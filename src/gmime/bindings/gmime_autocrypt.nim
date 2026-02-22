# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_internet_address

type
  GMimeAutocryptPreferEncrypt* = enum
    GMIME_AUTOCRYPT_PREFER_ENCRYPT_NONE = 0,
    GMIME_AUTOCRYPT_PREFER_ENCRYPT_MUTUAL = 1

  GMimeAutocryptHeader* = object
    parent_object: GObject
    address: ptr InternetAddressMailbox
    prefer_encrypt: GMimeAutocryptPreferEncrypt
    keydata: ptr GBytes
    effective_date: ptr GDateTime

  GMimeAutocryptHeaderClass* = object
    parent_class: GObjectClass

  GMimeAutocryptHeaderList* = object
    parent_object: GObject
    array: ptr GPtrArray

  GMimeAutocryptHeaderListClass* = object
    parent_class: GObjectClass

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_autocrypt_header_get_type*(): GType {.cdecl, importc.}

proc g_mime_autocrypt_header_new*(): ptr GMimeAutocryptHeader {.cdecl, importc.}
proc g_mime_autocrypt_header_new_from_string*(str: cstring): ptr GMimeAutocryptHeader {.cdecl, importc.}

proc g_mime_autocrypt_header_set_address*(ah: ptr GMimeAutocryptHeader, address: ptr InternetAddressMailbox) {.cdecl, importc.}
proc g_mime_autocrypt_header_get_address*(ah: ptr GMimeAutocryptHeader): ptr InternetAddressMailbox {.cdecl, importc.}
proc g_mime_autocrypt_header_set_address_from_string*(ah: ptr GMimeAutocryptHeader, address: cstring) {.cdecl, importc.}
proc g_mime_autocrypt_header_get_address_as_string*(ah: ptr GMimeAutocryptHeader): cstring {.cdecl, importc.}

proc g_mime_autocrypt_header_set_prefer_encrypt*(ah: ptr GMimeAutocryptHeader, pref: GMimeAutocryptPreferEncrypt) {.cdecl, importc.}
proc g_mime_autocrypt_header_get_prefer_encrypt*(ah: ptr GMimeAutocryptHeader): GMimeAutocryptPreferEncrypt {.cdecl, importc.}

proc g_mime_autocrypt_header_set_keydata*(ah: ptr GMimeAutocryptHeader, keydata: ptr GBytes) {.cdecl, importc.}
proc g_mime_autocrypt_header_get_keydata*(ah: ptr GMimeAutocryptHeader): ptr GBytes {.cdecl, importc.}

proc g_mime_autocrypt_header_set_effective_date*(ah: ptr GMimeAutocryptHeader, effective_date: ptr GDateTime) {.cdecl, importc.}
proc g_mime_autocrypt_header_get_effective_date*(ah: ptr GMimeAutocryptHeader): ptr GDateTime {.cdecl, importc.}

proc g_mime_autocrypt_header_to_string*(ah: ptr GMimeAutocryptHeader, gossip: gboolean): cstring {.cdecl, importc.}
proc g_mime_autocrypt_header_is_complete*(ah: ptr GMimeAutocryptHeader): gboolean {.cdecl, importc.}

proc g_mime_autocrypt_header_compare*(ah1: ptr GMimeAutocryptHeader, ah2: ptr GMimeAutocryptHeader): cint {.cdecl, importc.}
proc g_mime_autocrypt_header_clone*(dst: ptr GMimeAutocryptHeader, src: ptr GMimeAutocryptHeader) {.cdecl, importc.}

proc g_mime_autocrypt_header_list_get_type*(): GType {.cdecl, importc.}

proc g_mime_autocrypt_header_list_new*(): ptr GMimeAutocryptHeaderList {.cdecl, importc.}
proc g_mime_autocrypt_header_list_add_missing_addresses*(list: ptr GMimeAutocryptHeaderList, addresses: ptr InternetAddressList): guint {.cdecl, importc.}
proc g_mime_autocrypt_header_list_add*(list: ptr GMimeAutocryptHeaderList, header: ptr GMimeAutocryptHeader) {.cdecl, importc.}

proc g_mime_autocrypt_header_list_get_count*(list: ptr GMimeAutocryptHeaderList): guint {.cdecl, importc.}
proc g_mime_autocrypt_header_list_get_header_at*(list: ptr GMimeAutocryptHeaderList, index: guint): ptr GMimeAutocryptHeader {.cdecl, importc.}
proc g_mime_autocrypt_header_list_get_header_for_address*(list: ptr GMimeAutocryptHeaderList, mailbox: ptr InternetAddressMailbox): ptr GMimeAutocryptHeader {.cdecl, importc.}
proc g_mime_autocrypt_header_list_remove_incomplete*(list: ptr GMimeAutocryptHeaderList) {.cdecl, importc.}

{.pop.}