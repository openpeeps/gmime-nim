# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_filter

{.push importc, cdecl, header: "gmime/gmime.h".}

type
  GMimeOpenPGPData* {.size: sizeof(cint).} = enum
    GMIME_OPENPGP_DATA_NONE,
    GMIME_OPENPGP_DATA_ENCRYPTED,
    GMIME_OPENPGP_DATA_SIGNED,
    GMIME_OPENPGP_DATA_PUBLIC_KEY,
    GMIME_OPENPGP_DATA_PRIVATE_KEY

  GMimeOpenPGPState* {.size: sizeof(cint).} = enum
    GMIME_OPENPGP_NONE                        = 0,
    GMIME_OPENPGP_BEGIN_PGP_MESSAGE           = (1 shl 0),
    GMIME_OPENPGP_END_PGP_MESSAGE             = (1 shl 1) or (1 shl 0),
    GMIME_OPENPGP_BEGIN_PGP_SIGNED_MESSAGE    = (1 shl 2),
    GMIME_OPENPGP_BEGIN_PGP_SIGNATURE         = (1 shl 3) or (1 shl 2),
    GMIME_OPENPGP_END_PGP_SIGNATURE           = (1 shl 4) or (1 shl 3) or (1 shl 2),
    GMIME_OPENPGP_BEGIN_PGP_PUBLIC_KEY_BLOCK  = (1 shl 5),
    GMIME_OPENPGP_END_PGP_PUBLIC_KEY_BLOCK    = (1 shl 6) or (1 shl 5),
    GMIME_OPENPGP_BEGIN_PGP_PRIVATE_KEY_BLOCK = (1 shl 7),
    GMIME_OPENPGP_END_PGP_PRIVATE_KEY_BLOCK   = (1 shl 8) or (1 shl 7)

  GMimeOpenPGPMarker* {.byCopy.} = object
    marker*: cstring
    len*: csize_t
    before*: GMimeOpenPGPState
    after*: GMimeOpenPGPState
    is_end_marker*: gboolean

  GMimeFilterOpenPGP* {.byCopy.} = object
    parent_object*: GMimeFilter
    state*: GMimeOpenPGPState
    seen_end_marker*: gboolean
    midline*: gboolean
    begin_offset*: gint64
    end_offset*: gint64
    position*: gint64
    next*: guint

  GMimeFilterOpenPGPClass* {.byCopy.} = object
    parent_class*: GMimeFilterClass

proc g_mime_filter_openpgp_get_type*(): GType
proc g_mime_filter_openpgp_new*(): ptr GMimeFilter

proc g_mime_filter_openpgp_get_data_type*(openpgp: ptr GMimeFilterOpenPGP): GMimeOpenPGPData
proc g_mime_filter_openpgp_get_begin_offset*(openpgp: ptr GMimeFilterOpenPGP): gint64
proc g_mime_filter_openpgp_get_end_offset*(openpgp: ptr GMimeFilterOpenPGP): gint64

{.pop.}