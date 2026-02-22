# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_stream

{.push importc, cdecl, header: "gmime/gmime.h".}
type
  GMimeStreamMem* {.byCopy.} = object
    parent_object*: GMimeStream
    buffer*: ptr GByteArray
    owner*: gboolean

  GMimeStreamMemClass* {.byCopy.} = object
    parent_class*: GMimeStreamClass

proc g_mime_stream_mem_get_type*(): GType

proc g_mime_stream_mem_new*(): ptr GMimeStream
proc g_mime_stream_mem_new_with_byte_array*(array: ptr GByteArray): ptr GMimeStream
proc g_mime_stream_mem_new_with_buffer*(buffer: cstring, len: csize_t): ptr GMimeStream

proc g_mime_stream_mem_get_byte_array*(mem: ptr GMimeStreamMem): ptr GByteArray
proc g_mime_stream_mem_set_byte_array*(mem: ptr GMimeStreamMem, array: ptr GByteArray)

proc g_mime_stream_mem_get_owner*(mem: ptr GMimeStreamMem): gboolean
proc g_mime_stream_mem_set_owner*(mem: ptr GMimeStreamMem, owner: gboolean)

{.pop.}