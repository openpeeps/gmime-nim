# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

type
  GMimeCharset* = object
    mask*: uint
    level*: uint

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_charset_map_init*() {.importc.}
proc g_mime_charset_map_shutdown*() {.importc.}

proc g_mime_locale_charset*(): cstring {.importc.}
proc g_mime_locale_language*(): cstring {.importc.}

proc g_mime_charset_language*(charset: cstring): cstring {.importc.}
proc g_mime_charset_canon_name*(charset: cstring): cstring {.importc.}
proc g_mime_charset_iconv_name*(charset: cstring): cstring {.importc.}

# Deprecated functions (optional, can be commented out if not needed)
proc g_mime_charset_name*(charset: cstring): cstring {.importc.}
proc g_mime_charset_locale_name*(): cstring {.importc.}

proc g_mime_charset_iso_to_windows*(isocharset: cstring): cstring {.importc.}

proc g_mime_charset_init*(charset: ptr GMimeCharset) {.importc.}
proc g_mime_charset_step*(charset: ptr GMimeCharset, inbuf: cstring, inlen: csize_t) {.importc.}
proc g_mime_charset_best_name*(charset: ptr GMimeCharset): cstring {.importc.}

proc g_mime_charset_best*(inbuf: cstring, inlen: csize_t): cstring {.importc.}

proc g_mime_charset_can_encode*(mask: ptr GMimeCharset, charset: cstring, text: cstring, len: csize_t): gboolean {.importc.}
{.pop.}