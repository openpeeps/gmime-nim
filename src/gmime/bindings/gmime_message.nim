# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./gmime_internet_address
import ./gmime_encodings
import ./gmime_object
import ./gmime_header
import ./gmime_stream
import ./gmime_autocrypt
import ./gmime_crypto_context
import ./glib

{.push importc, cdecl, header: "gmime/gmime.h".}
# Enum definitions
type
  GMimeAddressType* = enum
    GMIME_ADDRESS_TYPE_SENDER,
    GMIME_ADDRESS_TYPE_FROM,
    GMIME_ADDRESS_TYPE_REPLY_TO,
    GMIME_ADDRESS_TYPE_TO,
    GMIME_ADDRESS_TYPE_CC,
    GMIME_ADDRESS_TYPE_BCC

# Type definitions
type
  GMimeMessage* {.byCopy.} = object
    parent_object: GMimeObject
    addrlists: ptr ptr InternetAddressList
    mime_part: ptr GMimeObject
    message_id: cstring
    date: ptr GDateTime
    subject: cstring
    marker: cstring

  GMimeMessageClass* {.byCopy.} = object
    parent_class: GMimeObjectClass

  GMimeObjectForeachFunc* = proc(obj: ptr GMimeObject, user_data: pointer)

# Function declarations
proc g_mime_message_get_type*(): GType
proc g_mime_message_new*(pretty_headers: gboolean): ptr GMimeMessage
proc g_mime_message_get_from*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_get_sender*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_get_reply_to*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_get_to*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_get_cc*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_get_bcc*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_add_mailbox*(message: ptr GMimeMessage, typ: GMimeAddressType, name: cstring, `addr`: cstring)
proc g_mime_message_get_addresses*(message: ptr GMimeMessage, typ: GMimeAddressType): ptr InternetAddressList
proc g_mime_message_get_all_recipients*(message: ptr GMimeMessage): ptr InternetAddressList
proc g_mime_message_set_subject*(message: ptr GMimeMessage, subject: cstring, charset: cstring)
proc g_mime_message_get_subject*(message: ptr GMimeMessage): cstring
proc g_mime_message_set_date*(message: ptr GMimeMessage, date: ptr GDateTime)
proc g_mime_message_get_date*(message: ptr GMimeMessage): ptr GDateTime
proc g_mime_message_set_message_id*(message: ptr GMimeMessage, message_id: cstring)
proc g_mime_message_get_message_id*(message: ptr GMimeMessage): cstring
proc g_mime_message_get_mime_part*(message: ptr GMimeMessage): ptr GMimeObject
proc g_mime_message_set_mime_part*(message: ptr GMimeMessage, mime_part: ptr GMimeObject)
proc g_mime_message_get_autocrypt_header*(message: ptr GMimeMessage, now: ptr GDateTime): ptr GMimeAutocryptHeader
proc g_mime_message_get_autocrypt_gossip_headers*(message: ptr GMimeMessage, now: ptr GDateTime, flags: GMimeDecryptFlags, session_key: cstring, err: ptr ptr GError): ptr GMimeAutocryptHeaderList
proc g_mime_message_get_autocrypt_gossip_headers_from_inner_part*(message: ptr GMimeMessage, now: ptr GDateTime, inner_part: ptr GMimeObject): ptr GMimeAutocryptHeaderList

proc g_mime_message_foreach*(message: ptr GMimeMessage, callback: GMimeObjectForeachFunc, user_data: pointer)
proc g_mime_message_get_body*(message: ptr GMimeMessage): ptr GMimeObject
{.pop.}