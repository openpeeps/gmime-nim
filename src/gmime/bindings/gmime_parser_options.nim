# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim


import ./glib

{.push importc, cdecl, header: "gmime/gmime.h".}
# Enum definitions
type
  GMimeRfcComplianceMode* = enum
    GMIME_RFC_COMPLIANCE_LOOSE,
    GMIME_RFC_COMPLIANCE_STRICT

  GMimeParserWarning* = enum
    GMIME_WARN_DUPLICATED_HEADER = 1,
    GMIME_WARN_DUPLICATED_PARAMETER = 2,
    GMIME_WARN_UNENCODED_8BIT_HEADER = 3,
    GMIME_WARN_INVALID_CONTENT_TYPE = 4,
    GMIME_WARN_INVALID_RFC2047_HEADER_VALUE = 5,
    GMIME_WARN_MALFORMED_MULTIPART = 6,
    GMIME_WARN_TRUNCATED_MESSAGE = 7,
    GMIME_WARN_MALFORMED_MESSAGE = 8,
    GMIME_CRIT_INVALID_HEADER_NAME = 100,
    GMIME_CRIT_CONFLICTING_HEADER = 101,
    GMIME_CRIT_CONFLICTING_PARAMETER = 102,
    GMIME_CRIT_MULTIPART_WITHOUT_BOUNDARY = 103,
    GMIME_WARN_INVALID_PARAMETER = 201,
    GMIME_WARN_INVALID_ADDRESS_LIST = 202,
    GMIME_CRIT_NESTING_OVERFLOW = 300,
    GMIME_WARN_PART_WITHOUT_CONTENT = 301,
    GMIME_CRIT_PART_WITHOUT_HEADERS_OR_CONTENT = 302,

# Type definitions
type
  GMimeParserOptions* {.byCopy.} = object

  GMimeParserWarningFunc* = proc(offset: gint64, errcode: GMimeParserWarning, item: cstring, user_data: pointer)

# Function declarations
proc g_mime_parser_options_get_type*(): GType
proc g_mime_parser_options_get_default*(): ptr GMimeParserOptions
proc g_mime_parser_options_new*(): ptr GMimeParserOptions
proc g_mime_parser_options_free*(options: ptr GMimeParserOptions)
proc g_mime_parser_options_clone*(options: ptr GMimeParserOptions): ptr GMimeParserOptions
proc g_mime_parser_options_get_address_compliance_mode*(options: ptr GMimeParserOptions): GMimeRfcComplianceMode
proc g_mime_parser_options_set_address_compliance_mode*(options: ptr GMimeParserOptions, mode: GMimeRfcComplianceMode)
proc g_mime_parser_options_get_allow_addresses_without_domain*(options: ptr GMimeParserOptions): gboolean
proc g_mime_parser_options_set_allow_addresses_without_domain*(options: ptr GMimeParserOptions, allow: gboolean)
proc g_mime_parser_options_get_parameter_compliance_mode*(options: ptr GMimeParserOptions): GMimeRfcComplianceMode
proc g_mime_parser_options_set_parameter_compliance_mode*(options: ptr GMimeParserOptions, mode: GMimeRfcComplianceMode)
proc g_mime_parser_options_get_rfc2047_compliance_mode*(options: ptr GMimeParserOptions): GMimeRfcComplianceMode
proc g_mime_parser_options_set_rfc2047_compliance_mode*(options: ptr GMimeParserOptions, mode: GMimeRfcComplianceMode)
proc g_mime_parser_options_get_fallback_charsets*(options: ptr GMimeParserOptions): ptr cstring
proc g_mime_parser_options_set_fallback_charsets*(options: ptr GMimeParserOptions, charsets: ptr cstring)
proc g_mime_parser_options_get_warning_callback*(options: ptr GMimeParserOptions): GMimeParserWarningFunc
proc g_mime_parser_options_set_warning_callback*(options: ptr GMimeParserOptions, warning_cb: GMimeParserWarningFunc, user_data: pointer)
proc g_mime_parser_options_set_warning_callback_full*(options: ptr GMimeParserOptions, warning_cb: GMimeParserWarningFunc, user_data: pointer, notify: GDestroyNotify)
{.pop.}