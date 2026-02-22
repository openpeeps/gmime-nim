# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_signature
import ./gmime_stream
import ./gmime_certificate

type
  GMimePasswordRequestFunc* = proc(ctx: ptr GMimeCryptoContext, userId: cstring, prompt: cstring,
                                   reprompt: gboolean, response: ptr GMimeStream, err: ptr pointer): gboolean {.cdecl.}

  GMimeCryptoContextNewFunc* = proc(): ptr GMimeCryptoContext {.cdecl.}

  GMimeDecryptFlags* = enum
    decryptNone                             = 0,
    decryptExportSessionKey                 = 1 shl 0,
    decryptNoVerify                         = 1 shl 1,
    decryptEnableKeyserverLookups           = 1 shl 14,
    decryptEnableOnlineCertificateChecks    = 1 shl 15

  GMimeEncryptFlags* = enum
    encryptNone         = 0,
    encryptAlwaysTrust  = 1 shl 0,
    encryptNoCompress   = 1 shl 4,
    encryptSymmetric    = 1 shl 5,
    encryptThrowKeyids  = 1 shl 6

  GMimeVerifyFlags* = enum
    verifyNone                             = 0,
    verifyEnableKeyserverLookups           = 1 shl 14,
    verifyEnableOnlineCertificateChecks    = 1 shl 15

  GMimeCryptoContext* = object
    parentObject*: pointer # GObject
    requestPasswd*: GMimePasswordRequestFunc

  GMimeCryptoContextClass* = object
    parentClass*: pointer # GObjectClass
    digestId*: proc(ctx: ptr GMimeCryptoContext, name: cstring): GMimeDigestAlgo {.cdecl.}
    digestName*: proc(ctx: ptr GMimeCryptoContext, digest: GMimeDigestAlgo): cstring {.cdecl.}
    getSignatureProtocol*: proc(ctx: ptr GMimeCryptoContext): cstring {.cdecl.}
    getEncryptionProtocol*: proc(ctx: ptr GMimeCryptoContext): cstring {.cdecl.}
    getKeyExchangeProtocol*: proc(ctx: ptr GMimeCryptoContext): cstring {.cdecl.}
    sign*: proc(ctx: ptr GMimeCryptoContext, detach: gboolean, userid: cstring,
                istream: ptr GMimeStream, ostream: ptr GMimeStream, err: ptr pointer): cint {.cdecl.}
    verify*: proc(ctx: ptr GMimeCryptoContext, flags: GMimeVerifyFlags,
                  istream: ptr GMimeStream, sigstream: ptr GMimeStream,
                  ostream: ptr GMimeStream, err: ptr pointer): ptr GMimeSignatureList {.cdecl.}
    encrypt*: proc(ctx: ptr GMimeCryptoContext, sign: gboolean, userid: cstring,
                   flags: GMimeEncryptFlags, recipients: pointer,
                   istream: ptr GMimeStream, ostream: ptr GMimeStream, err: ptr pointer): cint {.cdecl.}
    decrypt*: proc(ctx: ptr GMimeCryptoContext, flags: GMimeDecryptFlags, sessionKey: cstring,
                   istream: ptr GMimeStream, ostream: ptr GMimeStream, err: ptr pointer): ptr GMimeDecryptResult {.cdecl.}
    importKeys*: proc(ctx: ptr GMimeCryptoContext, istream: ptr GMimeStream, err: ptr pointer): cint {.cdecl.}
    exportKeys*: proc(ctx: ptr GMimeCryptoContext, keys: ptr cstring,
                     ostream: ptr GMimeStream, err: ptr pointer): cint {.cdecl.}

  GMimeCipherAlgo* = enum
    cipherAlgoDefault     = 0,
    cipherAlgoIDEA        = 1,
    cipherAlgo3DES        = 2,
    cipherAlgoCAST5       = 3,
    cipherAlgoBlowfish    = 4,
    cipherAlgoAES         = 7,
    cipherAlgoAES192      = 8,
    cipherAlgoAES256      = 9,
    cipherAlgoTwofish     = 10,
    cipherAlgoCamellia128 = 11,
    cipherAlgoCamellia192 = 12,
    cipherAlgoCamellia256 = 13

  GMimeDecryptResult* = object
    parentObject*: pointer # GObject
    recipients*: ptr GMimeCertificateList
    signatures*: ptr GMimeSignatureList
    cipher*: GMimeCipherAlgo
    mdc*: GMimeDigestAlgo
    sessionKey*: cstring

  GMimeDecryptResultClass* = object
    parentClass*: pointer # GObjectClass

# Function declarations
proc g_mime_crypto_context_get_type*(): GType {.importc.}
proc g_mime_crypto_context_register*(protocol: cstring, callback: GMimeCryptoContextNewFunc) {.importc.}
proc g_mime_crypto_context_new*(protocol: cstring): ptr GMimeCryptoContext {.importc.}
proc g_mime_crypto_context_set_request_password*(ctx: ptr GMimeCryptoContext, requestPasswd: GMimePasswordRequestFunc) {.importc.}

proc g_mime_crypto_context_digest_id*(ctx: ptr GMimeCryptoContext, name: cstring): GMimeDigestAlgo {.importc.}
proc g_mime_crypto_context_digest_name*(ctx: ptr GMimeCryptoContext, digest: GMimeDigestAlgo): cstring {.importc.}

proc g_mime_crypto_context_get_signature_protocol*(ctx: ptr GMimeCryptoContext): cstring {.importc.}
proc g_mime_crypto_context_get_encryption_protocol*(ctx: ptr GMimeCryptoContext): cstring {.importc.}
proc g_mime_crypto_context_get_key_exchange_protocol*(ctx: ptr GMimeCryptoContext): cstring {.importc.}

proc g_mime_crypto_context_sign*(ctx: ptr GMimeCryptoContext, detach: gboolean, userid: cstring,
                                istream: ptr GMimeStream, ostream: ptr GMimeStream, err: ptr pointer): cint {.importc.}

proc g_mime_crypto_context_verify*(ctx: ptr GMimeCryptoContext, flags: GMimeVerifyFlags,
                                  istream: ptr GMimeStream, sigstream: ptr GMimeStream,
                                  ostream: ptr GMimeStream, err: ptr pointer): ptr GMimeSignatureList {.importc.}

proc g_mime_crypto_context_encrypt*(ctx: ptr GMimeCryptoContext, sign: gboolean, userid: cstring,
                                   flags: GMimeEncryptFlags, recipients: pointer,
                                   istream: ptr GMimeStream, ostream: ptr GMimeStream,
                                   err: ptr pointer): cint {.importc.}

proc g_mime_crypto_context_decrypt*(ctx: ptr GMimeCryptoContext, flags: GMimeDecryptFlags,
                                   sessionKey: cstring, istream: ptr GMimeStream,
                                   ostream: ptr GMimeStream, err: ptr pointer): ptr GMimeDecryptResult {.importc.}

proc g_mime_crypto_context_import_keys*(ctx: ptr GMimeCryptoContext, istream: ptr GMimeStream, err: ptr pointer): cint {.importc.}
proc g_mime_crypto_context_export_keys*(ctx: ptr GMimeCryptoContext, keys: ptr cstring,
                                       ostream: ptr GMimeStream, err: ptr pointer): cint {.importc.}

proc g_mime_decrypt_result_get_type*(): GType {.importc.}
proc g_mime_decrypt_result_new*(): ptr GMimeDecryptResult {.importc.}

proc g_mime_decrypt_result_set_recipients*(result: ptr GMimeDecryptResult, recipients: ptr GMimeCertificateList) {.importc.}
proc g_mime_decrypt_result_get_recipients*(result: ptr GMimeDecryptResult): ptr GMimeCertificateList {.importc.}

proc g_mime_decrypt_result_set_signatures*(result: ptr GMimeDecryptResult, signatures: ptr GMimeSignatureList) {.importc.}
proc g_mime_decrypt_result_get_signatures*(result: ptr GMimeDecryptResult): ptr GMimeSignatureList {.importc.}

proc g_mime_decrypt_result_set_cipher*(result: ptr GMimeDecryptResult, cipher: GMimeCipherAlgo) {.importc.}
proc g_mime_decrypt_result_get_cipher*(result: ptr GMimeDecryptResult): GMimeCipherAlgo {.importc.}

proc g_mime_decrypt_result_set_mdc*(result: ptr GMimeDecryptResult, mdc: GMimeDigestAlgo) {.importc.}
proc g_mime_decrypt_result_get_mdc*(result: ptr GMimeDecryptResult): GMimeDigestAlgo {.importc.}

proc g_mime_decrypt_result_set_session_key*(result: ptr GMimeDecryptResult, sessionKey: cstring) {.importc.}
proc g_mime_decrypt_result_get_session_key*(result: ptr GMimeDecryptResult): cstring {.importc.}