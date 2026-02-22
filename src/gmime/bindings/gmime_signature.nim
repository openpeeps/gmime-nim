# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./gmime_certificate
import ./glib

{.push importc, cdecl, header: "gmime/gmime.h".}
# Enum definitions
type
  GMimeSignatureStatus* = enum
    GMIME_SIGNATURE_STATUS_VALID         = 0x0001,
    GMIME_SIGNATURE_STATUS_GREEN         = 0x0002,
    GMIME_SIGNATURE_STATUS_RED           = 0x0004,
    GMIME_SIGNATURE_STATUS_KEY_REVOKED   = 0x0010,
    GMIME_SIGNATURE_STATUS_KEY_EXPIRED   = 0x0020,
    GMIME_SIGNATURE_STATUS_SIG_EXPIRED   = 0x0040,
    GMIME_SIGNATURE_STATUS_KEY_MISSING   = 0x0080,
    GMIME_SIGNATURE_STATUS_CRL_MISSING   = 0x0100,
    GMIME_SIGNATURE_STATUS_CRL_TOO_OLD   = 0x0200,
    GMIME_SIGNATURE_STATUS_BAD_POLICY    = 0x0400,
    GMIME_SIGNATURE_STATUS_SYS_ERROR     = 0x0800,
    GMIME_SIGNATURE_STATUS_TOFU_CONFLICT = 0x1000

const
  GMIME_SIGNATURE_STATUS_ERROR_MASK* =
    not (GMimeSignatureStatus.GMIME_SIGNATURE_STATUS_VALID.int or
         GMimeSignatureStatus.GMIME_SIGNATURE_STATUS_GREEN.int or
         GMimeSignatureStatus.GMIME_SIGNATURE_STATUS_RED.int)

# Type definitions
type
  GMimeSignature* {.byCopy.} = object
    parent_object: pointer # GObject, to be imported later
    status: GMimeSignatureStatus
    cert: ptr GMimeCertificate
    created: time_t
    expires: time_t

  GMimeSignatureClass* {.byCopy.} = object
    parent_class: pointer # GObjectClass, to be imported later

  GMimeSignatureList* {.byCopy.} = object
    parent_object: pointer # GObject, to be imported later
    array: ptr GPtrArray

  GMimeSignatureListClass* {.byCopy.} = object
    parent_class: pointer # GObjectClass, to be imported later

# Function declarations
proc g_mime_signature_get_type*(): GType

proc g_mime_signature_new*(): ptr GMimeSignature

proc g_mime_signature_set_certificate*(sig: ptr GMimeSignature, cert: ptr GMimeCertificate)
proc g_mime_signature_get_certificate*(sig: ptr GMimeSignature): ptr GMimeCertificate

proc g_mime_signature_set_status*(sig: ptr GMimeSignature, status: GMimeSignatureStatus)
proc g_mime_signature_get_status*(sig: ptr GMimeSignature): GMimeSignatureStatus

proc g_mime_signature_set_created*(sig: ptr GMimeSignature, created: time_t)
proc g_mime_signature_get_created*(sig: ptr GMimeSignature): time_t
proc g_mime_signature_get_created64*(sig: ptr GMimeSignature): gint64

proc g_mime_signature_set_expires*(sig: ptr GMimeSignature, expires: time_t)
proc g_mime_signature_get_expires*(sig: ptr GMimeSignature): time_t
proc g_mime_signature_get_expires64*(sig: ptr GMimeSignature): gint64

proc g_mime_signature_list_get_type*(): GType

proc g_mime_signature_list_new*(): ptr GMimeSignatureList

proc g_mime_signature_list_length*(list: ptr GMimeSignatureList): int

proc g_mime_signature_list_clear*(list: ptr GMimeSignatureList)

proc g_mime_signature_list_add*(list: ptr GMimeSignatureList, sig: ptr GMimeSignature): int
proc g_mime_signature_list_insert*(list: ptr GMimeSignatureList, index: int, sig: ptr GMimeSignature)
proc g_mime_signature_list_remove*(list: ptr GMimeSignatureList, sig: ptr GMimeSignature): gboolean
proc g_mime_signature_list_remove_at*(list: ptr GMimeSignatureList, index: int): gboolean

proc g_mime_signature_list_contains*(list: ptr GMimeSignatureList, sig: ptr GMimeSignature): gboolean
proc g_mime_signature_list_index_of*(list: ptr GMimeSignatureList, sig: ptr GMimeSignature): int

proc g_mime_signature_list_get_signature*(list: ptr GMimeSignatureList, index: int): ptr GMimeSignature
proc g_mime_signature_list_set_signature*(list: ptr GMimeSignatureList, index: int, sig: ptr GMimeSignature)
{.pop.}