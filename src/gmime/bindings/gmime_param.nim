# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_format_options
import ./gmime_parser_options

# Type definitions
type
  GMimeParam* = object
    parent_object: pointer # GObject, to be imported later
    `method`: GMimeParamEncodingMethod
    charset: cstring
    lang: cstring
    name: cstring
    value: cstring
    changed: pointer

  GMimeParamClass* = object
    parent_class: pointer # GObjectClass, to be imported later

  GMimeParamList* = object
    parent_object: pointer # GObject, to be imported later
    `array`: ptr GPtrArray
    changed: pointer

  GMimeParamListClass* = object
    parent_class: pointer # GObjectClass, to be imported later

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_param_get_type*(): GType

proc g_mime_param_get_name*(param: ptr GMimeParam): cstring

proc g_mime_param_get_value*(param: ptr GMimeParam): cstring
proc g_mime_param_set_value*(param: ptr GMimeParam, value: cstring)

proc g_mime_param_get_charset*(param: ptr GMimeParam): cstring
proc g_mime_param_set_charset*(param: ptr GMimeParam, charset: cstring)

proc g_mime_param_get_lang*(param: ptr GMimeParam): cstring
proc g_mime_param_set_lang*(param: ptr GMimeParam, lang: cstring)

proc g_mime_param_get_encoding_method*(param: ptr GMimeParam): GMimeParamEncodingMethod
proc g_mime_param_set_encoding_method*(param: ptr GMimeParam, `method`: GMimeParamEncodingMethod)

proc g_mime_param_list_get_type*(): GType

proc g_mime_param_list_new*(): ptr GMimeParamList
proc g_mime_param_list_parse*(options: ptr GMimeParserOptions, str: cstring): ptr GMimeParamList

proc g_mime_param_list_length*(list: ptr GMimeParamList): int

proc g_mime_param_list_clear*(list: ptr GMimeParamList)

proc g_mime_param_list_set_parameter*(list: ptr GMimeParamList, name: cstring, value: cstring)
proc g_mime_param_list_get_parameter*(list: ptr GMimeParamList, name: cstring): ptr GMimeParam
proc g_mime_param_list_get_parameter_at*(list: ptr GMimeParamList, index: int): ptr GMimeParam

proc g_mime_param_list_remove*(list: ptr GMimeParamList, name: cstring): gboolean
proc g_mime_param_list_remove_at*(list: ptr GMimeParamList, index: int): gboolean

proc g_mime_param_list_encode*(list: ptr GMimeParamList, options: ptr GMimeFormatOptions, fold: gboolean, str: pointer) # GString
{.pop.}