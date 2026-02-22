# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_stream

# Type definitions
type
  GMimeStreamFs* = object
    parent_object: GMimeStream
    owner: gboolean
    eos: gboolean
    fd: int

  GMimeStreamFsClass* = object
    parent_class: GMimeStreamClass

const 
  GMimeReadOnly* = 0
  GMimeWriteOnly* = 1
  GMimeReadWrite* = 2

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_stream_fs_get_type*(): GType

proc g_mime_stream_fs_new*(fd: int): ptr GMimeStream
proc g_mime_stream_fs_new_with_bounds*(fd: int, start: gint64, `end`: gint64): ptr GMimeStream

proc g_mime_stream_fs_open*(path: cstring, flags: int, mode: int, err: ptr ptr GError): ptr GMimeStream

proc g_mime_stream_fs_get_owner*(stream: ptr GMimeStreamFs): gboolean
proc g_mime_stream_fs_set_owner*(stream: ptr GMimeStreamFs, owner: gboolean)
{.pop.}