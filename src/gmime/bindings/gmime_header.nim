# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_format_options
import ./gmime_parser_options
import ./gmime_stream

type
  GMimeHeaderRawValueFormatter* = proc(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                       value: cstring, charset: cstring): cstring {.cdecl.}

  GMimeHeader* = object
    parent_object: GObject           # GObject will be imported later
    name: cstring
    value: cstring
    formatter: GMimeHeaderRawValueFormatter
    options: ptr GMimeParserOptions
    reformat: gboolean
    changed: gpointer
    raw_value: cstring
    raw_name: cstring
    charset: cstring
    offset: gint64

  GMimeHeaderClass* = object
    parent_class: GObjectClass       # GObjectClass will be imported later

  GMimeHeaderList* = object
    parent_object: GObject
    options: ptr GMimeParserOptions
    changed: gpointer
    hash: ptr GHashTable
    array: ptr GPtrArray

  GMimeHeaderListClass* = object
    parent_class: GObjectClass

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_header_get_type*(): GType {.cdecl, importc.}
proc g_mime_header_list_get_type*(): GType {.cdecl, importc.}

proc g_mime_header_format_content_disposition*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                               value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_content_type*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                        value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_message_id*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                      value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_references*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                      value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_addrlist*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                    value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_received*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                    value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_newsgroups*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                      value: cstring, charset: cstring): cstring {.cdecl, importc.}
proc g_mime_header_format_default*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                   value: cstring, charset: cstring): cstring {.cdecl, importc.}

proc g_mime_header_get_name*(header: ptr GMimeHeader): cstring {.cdecl, importc.}
proc g_mime_header_get_raw_name*(header: ptr GMimeHeader): cstring {.cdecl, importc.}
proc g_mime_header_get_value*(header: ptr GMimeHeader): cstring {.cdecl, importc.}
proc g_mime_header_set_value*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                              value: cstring, charset: cstring) {.cdecl, importc.}
proc g_mime_header_get_raw_value*(header: ptr GMimeHeader): cstring {.cdecl, importc.}
proc g_mime_header_set_raw_value*(header: ptr GMimeHeader, raw_value: cstring) {.cdecl, importc.}
proc g_mime_header_get_offset*(header: ptr GMimeHeader): gint64 {.cdecl, importc.}
proc g_mime_header_write_to_stream*(header: ptr GMimeHeader, options: ptr GMimeFormatOptions,
                                    stream: ptr GMimeStream): ssize_t {.cdecl, importc.}

proc g_mime_header_list_new*(options: ptr GMimeParserOptions): ptr GMimeHeaderList {.cdecl, importc.}
proc g_mime_header_list_clear*(headers: ptr GMimeHeaderList) {.cdecl, importc.}
proc g_mime_header_list_get_count*(headers: ptr GMimeHeaderList): cint {.cdecl, importc.}
proc g_mime_header_list_contains*(headers: ptr GMimeHeaderList, name: cstring): gboolean {.cdecl, importc.}
proc g_mime_header_list_prepend*(headers: ptr GMimeHeaderList, name: cstring, value: cstring, charset: cstring) {.cdecl, importc.}
proc g_mime_header_list_append*(headers: ptr GMimeHeaderList, name: cstring, value: cstring, charset: cstring) {.cdecl, importc.}
proc g_mime_header_list_set*(headers: ptr GMimeHeaderList, name: cstring, value: cstring, charset: cstring) {.cdecl, importc.}
proc g_mime_header_list_get_header*(headers: ptr GMimeHeaderList, name: cstring): ptr GMimeHeader {.cdecl, importc.}
proc g_mime_header_list_get_header_at*(headers: ptr GMimeHeaderList, index: cint): ptr GMimeHeader {.cdecl, importc.}
proc g_mime_header_list_remove*(headers: ptr GMimeHeaderList, name: cstring): gboolean {.cdecl, importc.}
proc g_mime_header_list_remove_at*(headers: ptr GMimeHeaderList, index: cint) {.cdecl, importc.}
proc g_mime_header_list_write_to_stream*(headers: ptr GMimeHeaderList, options: ptr GMimeFormatOptions,
                                         stream: ptr GMimeStream): ssize_t {.cdecl, importc.}
proc g_mime_header_list_to_string*(headers: ptr GMimeHeaderList, options: ptr GMimeFormatOptions): cstring {.cdecl, importc.}
{.pop.}