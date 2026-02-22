# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_param
import ./gmime_format_options
import ./gmime_parser_options

# Type definitions
type
  GMimeContentType* = object
    parent_object: pointer # GObject, to be imported later
    typ: cstring
    subtype: cstring
    params: ptr GMimeParamList
    changed: pointer

  GMimeContentTypeClass* = object
    parent_class: pointer # GObjectClass, to be imported later

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_content_type_get_type*(): GType
proc g_mime_content_type_new*(typ: cstring, subtype: cstring): ptr GMimeContentType
proc g_mime_content_type_parse*(options: ptr GMimeParserOptions, str: cstring): ptr GMimeContentType
proc g_mime_content_type_get_mime_type*(content_type: ptr GMimeContentType): cstring
proc g_mime_content_type_encode*(content_type: ptr GMimeContentType, options: ptr GMimeFormatOptions): cstring
proc g_mime_content_type_is_type*(content_type: ptr GMimeContentType, typ: cstring, subtype: cstring): gboolean
proc g_mime_content_type_set_media_type*(content_type: ptr GMimeContentType, typ: cstring)
proc g_mime_content_type_get_media_type*(content_type: ptr GMimeContentType): cstring
proc g_mime_content_type_set_media_subtype*(content_type: ptr GMimeContentType, subtype: cstring)
proc g_mime_content_type_get_media_subtype*(content_type: ptr GMimeContentType): cstring
proc g_mime_content_type_get_parameters*(content_type: ptr GMimeContentType): ptr GMimeParamList
proc g_mime_content_type_set_parameter*(content_type: ptr GMimeContentType, name: cstring, value: cstring)
proc g_mime_content_type_get_parameter*(content_type: ptr GMimeContentType, name: cstring): cstring
{.pop.}