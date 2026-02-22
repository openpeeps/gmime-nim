# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib

type
  GMimeDigestAlgo* = enum
    digestAlgoDefault       = 0,
    digestAlgoMD5           = 1,
    digestAlgoSHA1          = 2,
    digestAlgoRIPEMD160     = 3,
    digestAlgoMD2           = 5,
    digestAlgoTIGER192      = 6,
    digestAlgoHAVAL5160     = 7,
    digestAlgoSHA256        = 8,
    digestAlgoSHA384        = 9,
    digestAlgoSHA512        = 10,
    digestAlgoSHA224        = 11,
    digestAlgoMD4           = 301,
    digestAlgoCRC32         = 302,
    digestAlgoCRC32RFC1510  = 303,
    digestAlgoCRC32RFC2440  = 304

  GMimePubKeyAlgo* = enum
    pubkeyAlgoDefault  = 0,
    pubkeyAlgoRSA      = 1,
    pubkeyAlgoRSAE     = 2,
    pubkeyAlgoRSAS     = 3,
    pubkeyAlgoELGE     = 16,
    pubkeyAlgoDSA      = 17,
    pubkeyAlgoECC      = 18,
    pubkeyAlgoELG      = 20,
    pubkeyAlgoECDSA    = 301,
    pubkeyAlgoECDH     = 302,
    pubkeyAlgoEDDSA    = 303

  GMimeTrust* = enum
    trustUnknown   = 0,
    trustUndefined = 1,
    trustNever     = 2,
    trustMarginal  = 3,
    trustFull      = 4,
    trustUltimate  = 5

  GMimeValidity* = enum
    validityUnknown   = 0,
    validityUndefined = 1,
    validityNever     = 2,
    validityMarginal  = 3,
    validityFull      = 4,
    validityUltimate  = 5

  GMimeCertificate* = object
    parentObject*: pointer # GObject
    pubkeyAlgo*: GMimePubKeyAlgo
    digestAlgo*: GMimeDigestAlgo
    trust*: GMimeTrust
    issuerSerial*: cstring
    issuerName*: cstring
    fingerprint*: cstring
    created*: time_t
    expires*: time_t
    keyid*: cstring
    email*: cstring
    name*: cstring
    userId*: cstring
    idValidity*: GMimeValidity

  GMimeCertificateClass* = object
    parentClass*: pointer # GObjectClass

  GMimeCertificateList* = object
    parentObject*: pointer # GObject
    array*: pointer # GPtrArray

  GMimeCertificateListClass* = object
    parentClass*: pointer # GObjectClass

# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_certificate_get_type*(): GType
proc g_mime_certificate_new*(): ptr GMimeCertificate

proc g_mime_certificate_set_trust*(cert: ptr GMimeCertificate, trust: GMimeTrust)
proc g_mime_certificate_get_trust*(cert: ptr GMimeCertificate): GMimeTrust

proc g_mime_certificate_set_pubkey_algo*(cert: ptr GMimeCertificate, algo: GMimePubKeyAlgo)
proc g_mime_certificate_get_pubkey_algo*(cert: ptr GMimeCertificate): GMimePubKeyAlgo

proc g_mime_certificate_set_digest_algo*(cert: ptr GMimeCertificate, algo: GMimeDigestAlgo)
proc g_mime_certificate_get_digest_algo*(cert: ptr GMimeCertificate): GMimeDigestAlgo

proc g_mime_certificate_set_issuer_serial*(cert: ptr GMimeCertificate, issuerSerial: cstring)
proc g_mime_certificate_get_issuer_serial*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_issuer_name*(cert: ptr GMimeCertificate, issuerName: cstring)
proc g_mime_certificate_get_issuer_name*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_fingerprint*(cert: ptr GMimeCertificate, fingerprint: cstring)
proc g_mime_certificate_get_fingerprint*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_key_id*(cert: ptr GMimeCertificate, keyId: cstring)
proc g_mime_certificate_get_key_id*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_email*(cert: ptr GMimeCertificate, email: cstring)
proc g_mime_certificate_get_email*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_name*(cert: ptr GMimeCertificate, name: cstring)
proc g_mime_certificate_get_name*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_user_id*(cert: ptr GMimeCertificate, userId: cstring)
proc g_mime_certificate_get_user_id*(cert: ptr GMimeCertificate): cstring

proc g_mime_certificate_set_id_validity*(cert: ptr GMimeCertificate, validity: GMimeValidity)
proc g_mime_certificate_get_id_validity*(cert: ptr GMimeCertificate): GMimeValidity

proc g_mime_certificate_set_created*(cert: ptr GMimeCertificate, created: time_t)
proc g_mime_certificate_get_created*(cert: ptr GMimeCertificate): time_t
proc g_mime_certificate_get_created64*(cert: ptr GMimeCertificate): gint64

proc g_mime_certificate_set_expires*(cert: ptr GMimeCertificate, expires: time_t)
proc g_mime_certificate_get_expires*(cert: ptr GMimeCertificate): time_t
proc g_mime_certificate_get_expires64*(cert: ptr GMimeCertificate): gint64

proc g_mime_certificate_list_get_type*(): GType
proc g_mime_certificate_list_new*(): ptr GMimeCertificateList
proc g_mime_certificate_list_length*(list: ptr GMimeCertificateList): cint
proc g_mime_certificate_list_clear*(list: ptr GMimeCertificateList)
proc g_mime_certificate_list_add*(list: ptr GMimeCertificateList, cert: ptr GMimeCertificate): cint
proc g_mime_certificate_list_insert*(list: ptr GMimeCertificateList, index: cint, cert: ptr GMimeCertificate)
proc g_mime_certificate_list_remove*(list: ptr GMimeCertificateList, cert: ptr GMimeCertificate): gboolean
proc g_mime_certificate_list_remove_at*(list: ptr GMimeCertificateList, index: cint): gboolean
proc g_mime_certificate_list_contains*(list: ptr GMimeCertificateList, cert: ptr GMimeCertificate): gboolean
proc g_mime_certificate_list_index_of*(list: ptr GMimeCertificateList, cert: ptr GMimeCertificate): cint
proc g_mime_certificate_list_get_certificate*(list: ptr GMimeCertificateList, index: cint): ptr GMimeCertificate
proc g_mime_certificate_list_set_certificate*(list: ptr GMimeCertificateList, index: cint, cert: ptr GMimeCertificate)
{.pop.}