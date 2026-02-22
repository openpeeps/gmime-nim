# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

import ./gmime_format_options
import ./gmime_parser_options
import ./gmime_encodings

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_utils_header_decode_date*(str: cstring): ptr GDateTime
proc g_mime_utils_header_format_date*(date: ptr GDateTime): cstring
proc g_mime_utils_generate_message_id*(fqdn: cstring): cstring
proc g_mime_utils_decode_message_id*(message_id: cstring): cstring
proc g_mime_utils_structured_header_fold*(options: ptr GMimeParserOptions, format: ptr GMimeFormatOptions, header: cstring): cstring
proc g_mime_utils_unstructured_header_fold*(options: ptr GMimeParserOptions, format: ptr GMimeFormatOptions, header: cstring): cstring
proc g_mime_utils_header_printf*(options: ptr GMimeParserOptions, format: ptr GMimeFormatOptions, text: cstring): cstring
proc g_mime_utils_header_unfold*(value: cstring): cstring
proc g_mime_utils_quote_string*(str: cstring): cstring
proc g_mime_utils_unquote_string*(str: cstring)
proc g_mime_utils_text_is_8bit*(text: ptr cuchar, len: csize_t): gboolean
proc g_mime_utils_best_encoding*(text: ptr cuchar, len: csize_t): GMimeContentEncoding
proc g_mime_utils_decode_8bit*(options: ptr GMimeParserOptions, text: cstring, len: csize_t): cstring
proc g_mime_utils_header_decode_text*(options: ptr GMimeParserOptions, text: cstring): cstring
proc g_mime_utils_header_encode_text*(options: ptr GMimeFormatOptions, text: cstring, charset: cstring): cstring
proc g_mime_utils_header_decode_phrase*(options: ptr GMimeParserOptions, phrase: cstring): cstring
proc g_mime_utils_header_encode_phrase*(options: ptr GMimeFormatOptions, phrase: cstring, charset: cstring): cstring
{.pop.}