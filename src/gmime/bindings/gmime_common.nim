# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_read_random_pool*(buffer: ptr uint8, bytes: csize_t) {.importc.}
proc g_mime_strcase_equal*(v: gconstpointer, v2: gconstpointer): cint {.importc.}
proc g_mime_strcase_hash*(key: gconstpointer): guint {.importc.}
proc g_mime_strdup_trim*(str: cstring): cstring {.importc.}
{.pop.}