# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim
import std/[times, strutils, options]

import ./bindings/[glib, gmime_parser, gmime_parser_options,
            gmime_stream_mem, gmime_stream_fs, gmime_object,
            gmime_content_type, gmime_format_options, gmime_part_iter,
            gmime_part, gmime_data_wrapper, gmime_multipart]

import ./internet_address

type
  MailParsingError* = object of CatchableError

proc parseEmail*(filePath: string): ptr GMimeParser =
  ## Parses the email message at the given file path and returns a
  ## GMimeParser instance.
  let stream = g_mime_stream_fs_open(filePath, GMimeReadOnly, 0644, nil)
  if stream == nil:
    raise newException(MailParsingError,
        "Failed to open stream for file: " & filePath)
  # ensure we alloc a GMimeParser instance
  result = g_mime_parser_new_with_stream(stream)
  if result == nil:
    g_object_unref(stream) # clean up the stream if parser creation failed
    raise newException(MailParsingError,
        "Failed to create GMimeParser for file: " & filePath)
  g_object_unref(stream) # parser takes ownership of the stream, so we can unref it now

proc parseMail*(filePath: string): ptr GMimeParser {.inline.} = 
  ## This is an alias for `parseEmail`, provided for convenience and readability.
  parseEmail(filePath)

#
# Parser Options
#
proc getDefaultParserOptions*(): ptr GMimeParserOptions =
  ## Retrieves the default parser options for GMime.
  g_mime_parser_options_get_default()

proc newParserOptions*: ptr GMimeParserOptions =
  ## Creates a new instance of GMimeParserOptions with default values.
  g_mime_parser_options_new()

proc allowAddressesWithoutDomain*(options: ptr GMimeParserOptions, allow: bool) =
  ## Sets whether the parser should allow email addresses without a domain part.
  g_mime_parser_options_set_allow_addresses_without_domain(options, allow.cint)

proc close*(parser: ptr GMimeParser) =
  ## Closes the parser and releases any associated resources.
  g_object_unref(parser)


#
# Message 
#
import ./bindings/gmime_message

proc constructMessage*(parser: ptr GMimeParser): ptr GMimeMessage =
  ## Constructs a GMimeMessage from the given parser.
  let message = g_mime_parser_construct_message(parser, nil)
  if message == nil:
    raise newException(MailParsingError,
        "Failed to construct GMimeMessage from parser")
  result = message

proc constructMail*(parser: ptr GMimeParser): ptr GMimeMessage {.inline.} = 
  ## This is an alias for `constructMessage`, provided for convenience and readability.
  constructMessage(parser)

proc getSubject*(message: ptr GMimeMessage): string =
  ## Retrieves the subject of the email message.
  $(g_mime_message_get_subject(message))

proc hasSubject*(message: ptr GMimeMessage): bool =
  ## Checks if the email message has a subject.
  g_mime_message_get_subject(message).len > 0

# proc removeAttachments*(message: ptr GMimeMessage): int =
#   ## Removes attachment parts from multipart parents.
#   if message == nil:
#     return 0

#   let iter = g_mime_part_iter_new(cast[ptr GMimeObject](message))
#   if iter == nil:
#     return 0
#   defer:
#     g_mime_part_iter_free(iter)

#   let attachments = g_ptr_array_new()
#   let multiparts = g_ptr_array_new()
#   if attachments == nil or multiparts == nil:
#     if attachments != nil: discard g_ptr_array_free(attachments, 1)
#     if multiparts != nil: discard g_ptr_array_free(multiparts, 1)
#     return 0
#   defer:
#     discard g_ptr_array_free(attachments, 1)
#     discard g_ptr_array_free(multiparts, 1)

#   # collect our list of attachments and their parent multiparts
#   while g_mime_part_iter_next(iter) != 0:
#     let current = g_mime_part_iter_get_current(iter)
#     let parent = g_mime_part_iter_get_parent(iter)

#     if parent != nil and current != nil and
#        g_type_check_instance_is_a(cast[pointer](parent), g_mime_multipart_get_type()) != 0 and
#        g_type_check_instance_is_a(cast[pointer](current), g_mime_part_get_type()) != 0:

#       let part = cast[ptr GMimePart](current)
#       if g_mime_part_is_attachment(part) != 0:
#         g_ptr_array_add(multiparts, cast[pointer](parent))
#         g_ptr_array_add(attachments, cast[pointer](part))

#   # now remove each attachment from its parent multipart
#   for i in 0 ..< int(attachments.len):
#     let multipart = cast[ptr GMimeMultipart](attachments[].pdata[i]) # fixed below
#     discard multipart

#   # correct removal loop
#   for i in 0 ..< int(attachments.len):
#     let multipart = cast[ptr GMimeMultipart](multiparts[].pdata[i])
#     let attachment = cast[ptr GMimeObject](attachments[].pdata[i])
#     if g_mime_multipart_remove(multipart, attachment) != 0:
#       inc result

proc partContentToString(part: ptr GMimePart): string =
  let content = g_mime_part_get_content(part)
  if content == nil: return # empty string
  
  let stream = g_mime_stream_mem_new()
  if stream == nil: return # empty string

  defer:
    g_object_unref(stream)

  let wrote = g_mime_data_wrapper_write_to_stream(content, stream)
  if wrote <= 0: return # empty string

  let ba = g_mime_stream_mem_get_byte_array(cast[ptr GMimeStreamMem](stream))
  if ba == nil or ba.data == nil or ba.len == 0: return # empty string
  let n = int(ba.len)
  if n <= 0 or n > 10_000_000: return # empty string, sanity check to prevent OOM
  result = newString(n)
  copyMem(addr result[0], ba.data, n)

proc getTextParts(message: ptr GMimeMessage,
              parts: var seq[string], plainTextOnly: bool) =
  # Collect all non-attachment text/plain + text/html parts.
  if message == nil: return
  let root = g_mime_message_get_mime_part(message)
  if root == nil: return

  # we use a part iterator to traverse the MIME tree, which is more
  # efficient than recursion and avoids stack overflow on deeply nested messages
  let iter = g_mime_part_iter_new(root)
  if iter == nil: return 
  defer:
    g_mime_part_iter_free(iter)
  var steps = 0
  while true:
    inc steps
    if steps > 10000: break # sanity check to prevent infinite loops on malformed messages
    let current = g_mime_part_iter_get_current(iter)
    if current != nil and
       g_type_check_instance_is_a(cast[pointer](current), g_mime_part_get_type()) != 0:
      let part = cast[ptr GMimePart](current)
      if g_mime_part_is_attachment(part) == 0:
        let ctype = g_mime_object_get_content_type(current)
        # we only want text parts that are not attachments,
        # and if `plainTextOnly` is true, we only want `text/plain` parts,
        # otherwise we also allow `text/html`
        if ctype != nil and (g_mime_content_type_is_type(ctype, "text", "plain") != 0 or
          (plainTextOnly == false and g_mime_content_type_is_type(ctype, "text", "html") != 0)):
          let s = partContentToString(part)
          if s.len > 0: parts.add(s)
    if g_mime_part_iter_next(iter) == 0: break # no more parts to iterate

proc getBody*(message: ptr GMimeMessage, plainTextOnly = false): string =
  ## Returns all collected text parts joined with a blank line.
  var parts: seq[string]
  message.getTextParts(parts, plainTextOnly)
  result = parts.join("\n\n")


proc getFromList*(message: ptr GMimeMessage): ptr InternetAddressList =
  ## Retrieves the list of sender addresses from the email message.
  g_mime_message_get_from(message)

proc getCCList*(message: ptr GMimeMessage): ptr InternetAddressList =
  ## Retrieves the list of CC (carbon copy) addresses from the email message.
  g_mime_message_get_cc(message)

proc getBCCList*(message: ptr GMimeMessage): ptr InternetAddressList =
  ## Retrieves the list of BCC (blind carbon copy) addresses from the email message.
  g_mime_message_get_bcc(message)

proc hasDateTime*(message: ptr GMimeMessage): bool =
  ## Checks if the email message has a valid date and time.
  g_mime_message_get_date(message) != nil

proc getDateTime*(message: ptr GMimeMessage): Option[DateTime] =
  ## Retrieves the date and time when the email message was sent.
  ## Returns `none` if the date is not available.
  let gd = g_mime_message_get_date(message)
  if gd != nil:
    return some(fromUnix(g_date_time_to_unix(gd)).utc)
  none(DateTime)