# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_format_options
import ./gmime_parser_options
import ./gmime_content_type
import ./gmime_disposition
import ./gmime_encodings
import ./gmime_stream
import ./gmime_header
import ./gmime_autocrypt
import ./gmime_internet_address

# Type definitions
type
  GMimeObject* = object
    parent_object: pointer # GObject, to be imported later
    disposition: GMimeContentDisposition
    content_type: GMimeContentType
    headers: GMimeHeaderList
    content_id: cstring
    ensure_newline: gboolean

  GMimeObjectClass* = object
    parent_class: pointer # GObjectClass, to be imported later
    header_added*: proc(obj: ptr GMimeObject, header: ptr GMimeHeader)
    header_changed*: proc(obj: ptr GMimeObject, header: ptr GMimeHeader)
    header_removed*: proc(obj: ptr GMimeObject, header: ptr GMimeHeader)
    headers_cleared*: proc(obj: ptr GMimeObject)
    set_content_type*: proc(obj: ptr GMimeObject, content_type: GMimeContentType)
    get_headers*: proc(obj: ptr GMimeObject, options: GMimeFormatOptions): cstring
    write_to_stream*: proc(obj: ptr GMimeObject, options: GMimeFormatOptions, content_only: gboolean, stream: GMimeStream): ssize_t
    encode*: proc(obj: ptr GMimeObject, constraint: int) # GMimeEncodingConstraint

# Callback type
type
  GMimeObjectForeachFunc* = proc(parent: ptr GMimeObject, part: ptr GMimeObject, user_data: pointer)

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_object_get_type*(): GType
proc g_mime_object_register_type*(typeStr: cstring, subtype: cstring, object_type: GType)

proc g_mime_object_new*(options: GMimeParserOptions, content_type: GMimeContentType): ptr GMimeObject
proc g_mime_object_new_type*(options: GMimeParserOptions, typeStr: cstring, subtype: cstring): ptr GMimeObject

proc g_mime_object_set_content_type*(obj: ptr GMimeObject, content_type: GMimeContentType)
proc g_mime_object_get_content_type*(obj: ptr GMimeObject): GMimeContentType
proc g_mime_object_set_content_type_parameter*(obj: ptr GMimeObject, name: cstring, value: cstring)
proc g_mime_object_get_content_type_parameter*(obj: ptr GMimeObject, name: cstring): cstring

proc g_mime_object_set_content_disposition*(obj: ptr GMimeObject, disposition: GMimeContentDisposition)
proc g_mime_object_get_content_disposition*(obj: ptr GMimeObject): GMimeContentDisposition

proc g_mime_object_set_disposition*(obj: ptr GMimeObject, disposition: cstring)
proc g_mime_object_get_disposition*(obj: ptr GMimeObject): cstring

proc g_mime_object_set_content_disposition_parameter*(obj: ptr GMimeObject, name: cstring, value: cstring)
proc g_mime_object_get_content_disposition_parameter*(obj: ptr GMimeObject, name: cstring): cstring

proc g_mime_object_set_content_id*(obj: ptr GMimeObject, content_id: cstring)
proc g_mime_object_get_content_id*(obj: ptr GMimeObject): cstring

proc g_mime_object_prepend_header*(obj: ptr GMimeObject, header: cstring, value: cstring, charset: cstring)
proc g_mime_object_append_header*(obj: ptr GMimeObject, header: cstring, value: cstring, charset: cstring)
proc g_mime_object_set_header*(obj: ptr GMimeObject, header: cstring, value: cstring, charset: cstring)
proc g_mime_object_get_header*(obj: ptr GMimeObject, header: cstring): cstring
proc g_mime_object_remove_header*(obj: ptr GMimeObject, header: cstring): gboolean

proc g_mime_object_get_header_list*(obj: ptr GMimeObject): GMimeHeaderList

proc g_mime_object_get_headers*(obj: ptr GMimeObject, options: GMimeFormatOptions): cstring

proc g_mime_object_write_to_stream*(obj: ptr GMimeObject, options: GMimeFormatOptions, stream: GMimeStream): ssize_t
proc g_mime_object_write_content_to_stream*(obj: ptr GMimeObject, options: GMimeFormatOptions, stream: GMimeStream): ssize_t
proc g_mime_object_to_string*(obj: ptr GMimeObject, options: GMimeFormatOptions): cstring

proc g_mime_object_encode*(obj: ptr GMimeObject, constraint: int) # GMimeEncodingConstraint

# Internal API
proc g_mime_object_type_registry_init*()
proc g_mime_object_type_registry_shutdown*()
proc g_mime_object_get_autocrypt_headers*(mime_part: ptr GMimeObject, effective_date: pointer, matchheader: cstring, addresses: InternetAddressList, keep_incomplete: gboolean): GMimeAutocryptHeaderList
{.pop.}