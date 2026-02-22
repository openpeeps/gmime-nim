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
  GMimeContentDisposition* = object
    parent_object: GObject
    disposition: cstring
    params: ptr GMimeParamList
    changed: gbpointer

  GMimeContentDispositionClass* = object
    parent_class: GObjectClass

# Constants
const
  GMIME_DISPOSITION_ATTACHMENT* = "attachment"
  GMIME_DISPOSITION_INLINE* = "inline"

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_content_disposition_get_type*(): GType
proc g_mime_content_disposition_new*(): ptr GMimeContentDisposition
proc g_mime_content_disposition_parse*(options: ptr GMimeParserOptions, str: cstring): ptr GMimeContentDisposition
proc g_mime_content_disposition_set_disposition*(disposition: ptr GMimeContentDisposition, value: cstring)
proc g_mime_content_disposition_get_disposition*(disposition: ptr GMimeContentDisposition): cstring
proc g_mime_content_disposition_get_parameters*(disposition: ptr GMimeContentDisposition): ptr GMimeParamList
proc g_mime_content_disposition_set_parameter*(disposition: ptr GMimeContentDisposition, name: cstring, value: cstring)
proc g_mime_content_disposition_get_parameter*(disposition: ptr GMimeContentDisposition, name: cstring): cstring
proc g_mime_content_disposition_is_attachment*(disposition: ptr GMimeContentDisposition): gboolean
proc g_mime_content_disposition_encode*(disposition: ptr GMimeContentDisposition, options: ptr GMimeFormatOptions): cstring
{.pop.}
