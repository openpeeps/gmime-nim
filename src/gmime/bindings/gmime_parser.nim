# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_object
import ./gmime_message
import ./gmime_content_type
import ./gmime_parser_options
import ./gmime_stream

# Enum definitions
type
  GMimeFormat* = enum
    ## The format of the message is unknown. This is the default.
    GMIME_FORMAT_MESSAGE,
    GMIME_FORMAT_MBOX,
    GMIME_FORMAT_MMDF

# Type definitions
type
  GMimeParser* = object
    parent_object: pointer # GObject, to be imported later
    priv: pointer # ptr GMimeParserPrivate, private

  GMimeParserClass* = object
    parent_class: pointer # GObjectClass, to be imported later

  GMimeParserHeaderRegexFunc* = proc(parser: ptr GMimeParser, header: cstring, value: cstring, offset: gint64, user_data: pointer)

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_parser_get_type*(): GType

proc g_mime_parser_new*(): ptr GMimeParser
proc g_mime_parser_new_with_stream*(stream: ptr GMimeStream): ptr GMimeParser

proc g_mime_parser_init_with_stream*(parser: ptr GMimeParser, stream: ptr GMimeStream)

proc g_mime_parser_get_persist_stream*(parser: ptr GMimeParser): gboolean
proc g_mime_parser_set_persist_stream*(parser: ptr GMimeParser, persist: gboolean)

proc g_mime_parser_get_format*(parser: ptr GMimeParser): GMimeFormat
proc g_mime_parser_set_format*(parser: ptr GMimeParser, format: GMimeFormat)

proc g_mime_parser_get_respect_content_length*(parser: ptr GMimeParser): gboolean
proc g_mime_parser_set_respect_content_length*(parser: ptr GMimeParser, respect_content_length: gboolean)

proc g_mime_parser_set_header_regex*(parser: ptr GMimeParser, regex: cstring, header_cb: GMimeParserHeaderRegexFunc, user_data: pointer)

proc g_mime_parser_construct_part*(parser: ptr GMimeParser, options: ptr GMimeParserOptions): ptr GMimeObject
proc g_mime_parser_construct_message*(parser: ptr GMimeParser, options: ptr GMimeParserOptions): ptr GMimeMessage

proc g_mime_parser_tell*(parser: ptr GMimeParser): gint64

proc g_mime_parser_eos*(parser: ptr GMimeParser): gboolean

proc g_mime_parser_get_mbox_marker*(parser: ptr GMimeParser): cstring
proc g_mime_parser_get_mbox_marker_offset*(parser: ptr GMimeParser): gint64

proc g_mime_parser_get_headers_begin*(parser: ptr GMimeParser): gint64
proc g_mime_parser_get_headers_end*(parser: ptr GMimeParser): gint64
{.pop.}