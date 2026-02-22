# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_object
import ./gmime_encodings
import ./gmime_data_wrapper
import ./gmime_filter_best
import ./gmime_filter_openpgp
import ./gmime_crypto_context

{.push importc, cdecl, header: "gmime/gmime.h".}
type
  GMimePart* {.byCopy.} = object
    parent_object*: GMimeObject
    encoding*: GMimeContentEncoding
    openpgp*: GMimeOpenPGPData
    content_description*: cstring
    content_location*: cstring
    content_md5*: cstring
    content*: ptr GMimeDataWrapper

  GMimePartClass* {.byCopy.} = object
    parent_class*: GMimeObjectClass
    set_content*: proc(mime_part: ptr GMimePart, content: ptr GMimeDataWrapper)

proc g_mime_part_get_type*(): GType

proc g_mime_part_new*(): ptr GMimePart
proc g_mime_part_new_with_type*(typ, subtype: cstring): ptr GMimePart

proc g_mime_part_set_content_description*(mime_part: ptr GMimePart, description: cstring)
proc g_mime_part_get_content_description*(mime_part: ptr GMimePart): cstring

proc g_mime_part_set_content_id*(mime_part: ptr GMimePart, content_id: cstring)
proc g_mime_part_get_content_id*(mime_part: ptr GMimePart): cstring

proc g_mime_part_set_content_md5*(mime_part: ptr GMimePart, content_md5: cstring)
proc g_mime_part_verify_content_md5*(mime_part: ptr GMimePart): gboolean
proc g_mime_part_get_content_md5*(mime_part: ptr GMimePart): cstring

proc g_mime_part_set_content_location*(mime_part: ptr GMimePart, content_location: cstring)
proc g_mime_part_get_content_location*(mime_part: ptr GMimePart): cstring

proc g_mime_part_set_content_encoding*(mime_part: ptr GMimePart, encoding: GMimeContentEncoding)
proc g_mime_part_get_content_encoding*(mime_part: ptr GMimePart): GMimeContentEncoding

proc g_mime_part_get_best_content_encoding*(mime_part: ptr GMimePart, constraint: GMimeEncodingConstraint): GMimeContentEncoding

proc g_mime_part_is_attachment*(mime_part: ptr GMimePart): gboolean

proc g_mime_part_set_filename*(mime_part: ptr GMimePart, filename: cstring)
proc g_mime_part_get_filename*(mime_part: ptr GMimePart): cstring

proc g_mime_part_set_content*(mime_part: ptr GMimePart, content: ptr GMimeDataWrapper)
proc g_mime_part_get_content*(mime_part: ptr GMimePart): ptr GMimeDataWrapper

proc g_mime_part_set_openpgp_data*(mime_part: ptr GMimePart, data: GMimeOpenPGPData)
proc g_mime_part_get_openpgp_data*(mime_part: ptr GMimePart): GMimeOpenPGPData

proc g_mime_part_openpgp_encrypt*(mime_part: ptr GMimePart, sign: gboolean, userid: cstring,
                                  flags: GMimeEncryptFlags, recipients: pointer, err: ptr GError): gboolean
proc g_mime_part_openpgp_decrypt*(mime_part: ptr GMimePart, flags: GMimeDecryptFlags,
                                  session_key: cstring, err: ptr GError): pointer
proc g_mime_part_openpgp_sign*(mime_part: ptr GMimePart, userid: cstring, err: ptr GError): gboolean
proc g_mime_part_openpgp_verify*(mime_part: ptr GMimePart, flags: GMimeVerifyFlags, err: ptr GError): pointer
{.pop.}