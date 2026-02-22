# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./bindings/[glib, gmime_parser, gmime_stream, gmime_stream_fs]
import ./internet_address

type
  MailParsingError* = object of CatchableError

proc parseEmail*(filePath: string): ptr GMimeParser =
  ## Parses the email message at the given file path and returns a
  ## GMimeParser instance.
  let stream = g_mime_stream_fsOpen(filePath, GMimeReadOnly, 0644, nil)
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

proc getFromList*(message: ptr GMimeMessage): ptr InternetAddressList =
  ## Retrieves the list of sender addresses from the email message.
  g_mime_message_get_from(message)
