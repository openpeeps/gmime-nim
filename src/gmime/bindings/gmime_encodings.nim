# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

# Enum definitions
type
  GMimeContentEncoding* = enum
    GMIME_CONTENT_ENCODING_DEFAULT,
    GMIME_CONTENT_ENCODING_7BIT,
    GMIME_CONTENT_ENCODING_8BIT,
    GMIME_CONTENT_ENCODING_BINARY,
    GMIME_CONTENT_ENCODING_BASE64,
    GMIME_CONTENT_ENCODING_QUOTEDPRINTABLE,
    GMIME_CONTENT_ENCODING_UUENCODE

  GMimeEncodingConstraint* = enum
    GMIME_ENCODING_CONSTRAINT_7BIT,
    GMIME_ENCODING_CONSTRAINT_8BIT,
    GMIME_ENCODING_CONSTRAINT_BINARY

# Constants
const
  GMIME_BASE64_ENCODE_LEN* = proc(x: int): int = (((((x) + 2) div 57) * 77) + 77)
  GMIME_QP_ENCODE_LEN*     = proc(x: int): int = ((((x) div 24) * 74) + 74)
  GMIME_UUENCODE_LEN*      = proc(x: int): int = (((((x) + 2) div 45) * 62) + 64)

  GMIME_UUDECODE_STATE_INIT*  = 0
  GMIME_UUDECODE_STATE_BEGIN* = 1 shl 16
  GMIME_UUDECODE_STATE_END*   = 1 shl 17
  GMIME_UUDECODE_STATE_MASK*  = GMIME_UUDECODE_STATE_BEGIN or GMIME_UUDECODE_STATE_END

# Type definitions
type
  GMimeEncoding* = object
    encoding: GMimeContentEncoding
    uubuf: array[0..59, uint8]
    encode: gboolean
    save: guint32
    state: int

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_content_encoding_from_string*(str: cstring): GMimeContentEncoding
proc g_mime_content_encoding_to_string*(encoding: GMimeContentEncoding): cstring

proc g_mime_encoding_init_encode*(state: ptr GMimeEncoding, encoding: GMimeContentEncoding)
proc g_mime_encoding_init_decode*(state: ptr GMimeEncoding, encoding: GMimeContentEncoding)
proc g_mime_encoding_reset*(state: ptr GMimeEncoding)

proc g_mime_encoding_outlen*(state: ptr GMimeEncoding, inlen: csize_t): csize_t

proc g_mime_encoding_step*(state: ptr GMimeEncoding, inbuf: cstring, inlen: csize_t, outbuf: cstring): csize_t
proc g_mime_encoding_flush*(state: ptr GMimeEncoding, inbuf: cstring, inlen: csize_t, outbuf: cstring): csize_t

proc g_mime_encoding_base64_decode_step*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
proc g_mime_encoding_base64_encode_step*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
proc g_mime_encoding_base64_encode_close*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t

proc g_mime_encoding_uudecode_step*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
proc g_mime_encoding_uuencode_step*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, uubuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
proc g_mime_encoding_uuencode_close*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, uubuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t

proc g_mime_encoding_quoted_decode_step*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
proc g_mime_encoding_quoted_encode_step*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
proc g_mime_encoding_quoted_encode_close*(inbuf: ptr uint8, inlen: csize_t, outbuf: ptr uint8, state: ptr int, save: ptr guint32): csize_t
{.pop.}