# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_param
import ./gmime_parser_options
import ./gmime_format_options

type
  GMimeContentType* = object
    parentObject*: pointer # GObject
    `type`*: cstring
    subtype*: cstring
    params*: ptr GMimeParamList
    changed*: pointer # gpointer

  GMimeContentTypeClass* = object
    parentClass*: pointer # GObjectClass

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_content_type_get_type*(): GType

proc g_mime_content_type_new*(typeStr: cstring, subtypeStr: cstring): ptr GMimeContentType
proc g_mime_content_type_parse*(options: ptr GMimeParserOptions, str: cstring): ptr GMimeContentType

proc g_mime_content_type_get_mime_type*(contentType: ptr GMimeContentType): cstring

proc g_mime_content_type_encode*(contentType: ptr GMimeContentType, options: ptr GMimeFormatOptions): cstring

proc g_mime_content_type_is_type*(contentType: ptr GMimeContentType, typeStr: cstring, subtypeStr: cstring): gboolean

proc g_mime_content_type_set_media_type*(contentType: ptr GMimeContentType, typeStr: cstring)
proc g_mime_content_type_get_media_type*(contentType: ptr GMimeContentType): cstring

proc g_mime_content_type_set_media_subtype*(contentType: ptr GMimeContentType, subtypeStr: cstring)
proc g_mime_content_type_get_media_subtype*(contentType: ptr GMimeContentType): cstring

proc g_mime_content_type_get_parameters*(contentType: ptr GMimeContentType): ptr GMimeParamList

proc g_mime_content_type_set_parameter*(contentType: ptr GMimeContentType, name: cstring, value: cstring)
proc g_mime_content_type_get_parameter*(contentType: ptr GMimeContentType, name: cstring): cstring
{.pop.}