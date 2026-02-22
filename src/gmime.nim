# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

{.
  passC:"-I /opt/local/include -I /opt/local/include/gmime-3.0 -I/opt/local/include/glib-2.0/ -I/opt/local/lib/glib-2.0/include"
  passL:"-L/opt/local/lib -lgmime-3.0 -lgobject-2.0 -lglib-2.0 -lgmodule-2.0",
.}

import ./gmime/bindings/gmime_bindings
export gmime_bindings

{.push cdecl, importc, header: "gmime/gmime.h".}
var
  gmime_major_version* {.importc.}: guint
  gmime_minor_version* {.importc.}: guint
  gmime_micro_version* {.importc.}: guint
  gmime_interface_age* {.importc.}: guint
  gmime_binary_age* {.importc.}: guint

proc g_mime_check_version*(major: guint, minor: guint, micro: guint): gboolean
proc g_mime_init*()
proc g_mime_shutdown*()
{.pop.}

#
# High-level API 
#
import ./gmime/internet_address
export internet_address

