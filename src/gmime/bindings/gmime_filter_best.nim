# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_encodings
import ./gmime_filter

{.push importc, cdecl, header: "gmime/gmime.h".}
type
  GMimeFilterBestFlags* {.size: sizeof(cint).} = enum
    GMIME_FILTER_BEST_CHARSET  = (1 shl 0)
    GMIME_FILTER_BEST_ENCODING = (1 shl 1)

  GMimeFilterBest* {.byCopy.} = object
    parent_object*: GMimeFilter
    flags*: GMimeFilterBestFlags
    # The rest of the fields are internal and not needed for FFI use

  GMimeFilterBestClass* {.byCopy.} = object
    parent_class*: GMimeFilterClass

proc g_mime_filter_best_get_type*(): GType
proc g_mime_filter_best_new*(flags: GMimeFilterBestFlags): ptr GMimeFilter
proc g_mime_filter_best_charset*(best: ptr GMimeFilterBest): cstring
proc g_mime_filter_best_encoding*(best: ptr GMimeFilterBest, constraint: GMimeEncodingConstraint): GMimeContentEncoding

{.pop.}