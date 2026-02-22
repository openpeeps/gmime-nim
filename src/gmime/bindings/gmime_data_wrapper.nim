# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_content_type
import ./gmime_encodings
import ./gmime_stream
import ./gmime_utils

# Type definitions
type
  GMimeDataWrapper* = object
    parent_object: pointer # GObject, to be imported later
    encoding: GMimeContentEncoding
    stream: ptr GMimeStream

  GMimeDataWrapperClass* = object
    parent_class: pointer # GObjectClass, to be imported later
    write_to_stream*: proc(wrapper: ptr GMimeDataWrapper, stream: ptr GMimeStream): ssize_t

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_data_wrapper_get_type*(): GType
proc g_mime_data_wrapper_new*(): ptr GMimeDataWrapper
proc g_mime_data_wrapper_new_with_stream*(stream: ptr GMimeStream, encoding: GMimeContentEncoding): ptr GMimeDataWrapper

proc g_mime_data_wrapper_set_stream*(wrapper: ptr GMimeDataWrapper, stream: ptr GMimeStream)
proc g_mime_data_wrapper_get_stream*(wrapper: ptr GMimeDataWrapper): ptr GMimeStream

proc g_mime_data_wrapper_set_encoding*(wrapper: ptr GMimeDataWrapper, encoding: GMimeContentEncoding)
proc g_mime_data_wrapper_get_encoding*(wrapper: ptr GMimeDataWrapper): GMimeContentEncoding

proc g_mime_data_wrapper_write_to_stream*(wrapper: ptr GMimeDataWrapper, stream: ptr GMimeStream): ssize_t
{.pop.}