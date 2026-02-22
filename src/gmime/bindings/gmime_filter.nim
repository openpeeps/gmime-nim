# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

# Type definitions
type
  GMimeFilter* = object
    parent_object: pointer # GObject, to be imported later
    priv: pointer # ptr GMimeFilterPrivate, private
    outreal: cstring
    outbuf: cstring
    outptr: cstring
    outsize: csize_t
    outpre: csize_t
    backbuf: cstring
    backsize: csize_t
    backlen: csize_t

  GMimeFilterClass* = object
    parent_class: pointer # GObjectClass, to be imported later
    copy*: proc(filter: ptr GMimeFilter): ptr GMimeFilter
    filter*: proc(filter: ptr GMimeFilter, inbuf: cstring, inlen: csize_t, prespace: csize_t, outbuf: ptr cstring, outlen: ptr csize_t, outprespace: ptr csize_t)
    complete*: proc(filter: ptr GMimeFilter, inbuf: cstring, inlen: csize_t, prespace: csize_t, outbuf: ptr cstring, outlen: ptr csize_t, outprespace: ptr csize_t)
    reset*: proc(filter: ptr GMimeFilter)

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_filter_get_type*(): GType

proc g_mime_filter_copy*(filter: ptr GMimeFilter): ptr GMimeFilter

proc g_mime_filter_filter*(filter: ptr GMimeFilter, inbuf: cstring, inlen: csize_t, prespace: csize_t, outbuf: ptr cstring, outlen: ptr csize_t, outprespace: ptr csize_t)
proc g_mime_filter_complete*(filter: ptr GMimeFilter, inbuf: cstring, inlen: csize_t, prespace: csize_t, outbuf: ptr cstring, outlen: ptr csize_t, outprespace: ptr csize_t)
proc g_mime_filter_reset*(filter: ptr GMimeFilter)

proc g_mime_filter_backup*(filter: ptr GMimeFilter, data: cstring, length: csize_t)
proc g_mime_filter_set_size*(filter: ptr GMimeFilter, size: csize_t, keep: gboolean)
{.pop.}