# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_filter

# Enum definitions
type
  GMimeNewLineFormat* = enum
    GMIME_NEWLINE_FORMAT_UNIX,
    GMIME_NEWLINE_FORMAT_DOS

  GMimeParamEncodingMethod* = enum
    GMIME_PARAM_ENCODING_METHOD_DEFAULT = 0,
    GMIME_PARAM_ENCODING_METHOD_RFC2231 = 1,
    GMIME_PARAM_ENCODING_METHOD_RFC2047 = 2

# Type definitions
type
  GMimeFormatOptions* = object

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_format_options_get_type*(): GType

proc g_mime_format_options_get_default*(): ptr GMimeFormatOptions

proc g_mime_format_options_new*(): ptr GMimeFormatOptions
proc g_mime_format_options_free*(options: ptr GMimeFormatOptions)

proc g_mime_format_options_clone*(options: ptr GMimeFormatOptions): ptr GMimeFormatOptions

proc g_mime_format_options_get_param_encoding_method*(options: ptr GMimeFormatOptions): GMimeParamEncodingMethod
proc g_mime_format_options_set_param_encoding_method*(options: ptr GMimeFormatOptions, encodingMethod: GMimeParamEncodingMethod)

proc g_mime_format_options_get_newline_format*(options: ptr GMimeFormatOptions): GMimeNewLineFormat
proc g_mime_format_options_set_newline_format*(options: ptr GMimeFormatOptions, newline: GMimeNewLineFormat)

proc g_mime_format_options_get_newline*(options: ptr GMimeFormatOptions): cstring
proc g_mime_format_options_create_newline_filter*(options: ptr GMimeFormatOptions, ensure_newline: gboolean): ptr GMimeFilter

proc g_mime_format_options_is_hidden_header*(options: ptr GMimeFormatOptions, header: cstring): gboolean
proc g_mime_format_options_add_hidden_header*(options: ptr GMimeFormatOptions, header: cstring)
proc g_mime_format_options_remove_hidden_header*(options: ptr GMimeFormatOptions, header: cstring)
proc g_mime_format_options_clear_hidden_headers*(options: ptr GMimeFormatOptions)
{.pop.}