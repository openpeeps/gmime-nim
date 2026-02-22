# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

# Extern variables
var gmime_error_quark*: GQuark
var gmime_gpgme_error_quark*: GQuark

template GMIME_ERROR*: untyped = gmime_error_quark
template GMIME_GPGME_ERROR*: untyped = gmime_gpgme_error_quark

# Error codes
const
  GMIME_ERROR_GENERAL*           = -1
  GMIME_ERROR_NOT_SUPPORTED*     = -2
  GMIME_ERROR_INVALID_OPERATION* = -3
  GMIME_ERROR_PARSE_ERROR*       = -4
  GMIME_ERROR_PROTOCOL_ERROR*    = -5

# Macro function
proc GMIME_ERROR_IS_SYSTEM*(error: int): bool = error > 0