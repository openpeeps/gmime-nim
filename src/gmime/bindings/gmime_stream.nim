# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

# Enum definitions
type
  GMimeSeekWhence* = enum
    GMIME_STREAM_SEEK_SET = 0 # SEEK_SET
    GMIME_STREAM_SEEK_CUR = 1 # SEEK_CUR
    GMIME_STREAM_SEEK_END = 2 # SEEK_END

# Type definitions
type
  GMimeStreamIOVector* = object
    data: pointer
    len: csize_t

  GMimeStream* = object
    parent_object: pointer # GObject, to be imported later
    super_stream: ptr GMimeStream
    position: gint64
    bound_start: gint64
    bound_end: gint64

  GMimeStreamClass* = object
    parent_class: pointer # GObjectClass, to be imported later
    read*: proc(stream: ptr GMimeStream, buf: cstring, len: csize_t): ssize_t
    write*: proc(stream: ptr GMimeStream, buf: cstring, len: csize_t): ssize_t
    flush*: proc(stream: ptr GMimeStream): int
    close*: proc(stream: ptr GMimeStream): int
    eos*: proc(stream: ptr GMimeStream): gboolean
    reset*: proc(stream: ptr GMimeStream): int
    seek*: proc(stream: ptr GMimeStream, offset: gint64, whence: GMimeSeekWhence): gint64
    tell*: proc(stream: ptr GMimeStream): gint64
    length*: proc(stream: ptr GMimeStream): gint64
    substream*: proc(stream: ptr GMimeStream, start: gint64, `end`: gint64): ptr GMimeStream

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_stream_get_type*(): GType

proc g_mime_stream_construct*(stream: ptr GMimeStream, start: gint64, `end`: gint64)

proc g_mime_stream_read*(stream: ptr GMimeStream, buf: cstring, len: csize_t): ssize_t
proc g_mime_stream_write*(stream: ptr GMimeStream, buf: cstring, len: csize_t): ssize_t
proc g_mime_stream_flush*(stream: ptr GMimeStream): int
proc g_mime_stream_close*(stream: ptr GMimeStream): int
proc g_mime_stream_eos*(stream: ptr GMimeStream): gboolean
proc g_mime_stream_reset*(stream: ptr GMimeStream): int
proc g_mime_stream_seek*(stream: ptr GMimeStream, offset: gint64, whence: GMimeSeekWhence): gint64
proc g_mime_stream_tell*(stream: ptr GMimeStream): gint64
proc g_mime_stream_length*(stream: ptr GMimeStream): gint64

proc g_mime_stream_substream*(stream: ptr GMimeStream, start: gint64, `end`: gint64): ptr GMimeStream

proc g_mime_stream_set_bounds*(stream: ptr GMimeStream, start: gint64, `end`: gint64)

proc g_mime_stream_write_string*(stream: ptr GMimeStream, str: cstring): ssize_t
proc g_mime_stream_printf*(stream: ptr GMimeStream, fmt: cstring): ssize_t

proc g_mime_stream_write_to_stream*(src: ptr GMimeStream, dest: ptr GMimeStream): gint64

proc g_mime_stream_writev*(stream: ptr GMimeStream, vector: ptr GMimeStreamIOVector, count: csize_t): gint64
{.pop.}