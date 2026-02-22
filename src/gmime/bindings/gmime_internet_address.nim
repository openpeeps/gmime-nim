# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_format_options
import ./gmime_parser_options

# Type definitions
{.push importc, cdecl, header: "gmime/gmime.h".}
type
  InternetAddress* {.byCopy.} = object
    parent_object*: pointer # GObject, to be imported later
    charset*: cstring
    name*: cstring
    changed*: pointer

  InternetAddressClass* {.byCopy.} = object
    parent_class: pointer # GObjectClass, to be imported later
    to_string*: proc(ia: ptr InternetAddress, options: ptr GMimeFormatOptions, flags: guint32, linelen: ptr csize_t, str: pointer) # GString

  InternetAddressMailbox* {.byCopy.} = object
    parent_object*: InternetAddress
    idn_addr*: cstring
    `addr`*: cstring
    at*: int

  InternetAddressMailboxClass* {.byCopy.} = object
    parent_class: InternetAddressClass

  InternetAddressGroup* {.byCopy.} = object
    parent_object: InternetAddress
    members: ptr InternetAddressList

  InternetAddressGroupClass* {.byCopy.} = object
    parent_class: InternetAddressClass

  InternetAddressList* {.byCopy.} = object
    parent_object: pointer # GObject, to be imported later
    `array`: pointer # GPtrArray, to be imported later
    changed: pointer

  InternetAddressListClass* {.byCopy.} = object
    parent_class: pointer # GObjectClass, to be imported later

# Function declarations
proc internet_address_get_type*(): GType

proc internet_address_set_name*(ia: ptr InternetAddress, name: cstring)
proc internet_address_get_name*(ia: ptr InternetAddress): cstring

proc internet_address_set_charset*(ia: ptr InternetAddress, charset: cstring)
proc internet_address_get_charset*(ia: ptr InternetAddress): cstring

proc internet_address_to_string*(ia: ptr InternetAddress, options: ptr GMimeFormatOptions, encode: gboolean): cstring

proc internet_address_mailbox_get_type*(): GType
proc internet_address_mailbox_new*(name: cstring, `addr`: cstring): ptr InternetAddress

proc internet_address_mailbox_set_addr*(mailbox: ptr InternetAddressMailbox, `addr`: cstring)
proc internet_address_mailbox_get_addr*(mailbox: ptr InternetAddressMailbox): cstring
proc internet_address_mailbox_get_idn_addr*(mailbox: ptr InternetAddressMailbox): cstring

proc internet_address_group_get_type*(): GType
proc internet_address_group_new*(name: cstring): ptr InternetAddress

proc internet_address_group_set_members*(group: ptr InternetAddressGroup, members: ptr InternetAddressList)
proc internet_address_group_get_members*(group: ptr InternetAddressGroup): ptr InternetAddressList
proc internet_address_group_add_member*(group: ptr InternetAddressGroup, member: ptr InternetAddress): int

proc internet_address_list_get_type*(): GType
proc internet_address_list_new*(): ptr InternetAddressList

proc internet_address_list_length*(list: ptr InternetAddressList): int
proc internet_address_list_clear*(list: ptr InternetAddressList)

proc internet_address_list_add*(list: ptr InternetAddressList, ia: ptr InternetAddress): int
proc internet_address_list_prepend*(list: ptr InternetAddressList, prepend: ptr InternetAddressList)
proc internet_address_list_append*(list: ptr InternetAddressList, append: ptr InternetAddressList)
proc internet_address_list_insert*(list: ptr InternetAddressList, index: int, ia: ptr InternetAddress)
proc internet_address_list_remove*(list: ptr InternetAddressList, ia: ptr InternetAddress): gboolean
proc internet_address_list_remove_at*(list: ptr InternetAddressList, index: int): gboolean

proc internet_address_list_contains*(list: ptr InternetAddressList, ia: ptr InternetAddress): gboolean
proc internet_address_list_index_of*(list: ptr InternetAddressList, ia: ptr InternetAddress): int

proc internet_address_list_get_address*(list: ptr InternetAddressList, index: int): ptr InternetAddress
proc internet_address_list_set_address*(list: ptr InternetAddressList, index: int, ia: ptr InternetAddress)

proc internet_address_list_to_string*(list: ptr InternetAddressList, options: ptr GMimeFormatOptions, encode: gboolean): cstring
proc internet_address_list_encode*(list: ptr InternetAddressList, options: ptr GMimeFormatOptions, str: pointer) # GString

proc internet_address_list_parse*(options: ptr GMimeParserOptions, str: cstring): ptr InternetAddressList
proc internet_address_list_append_parse*(list: ptr InternetAddressList, options: ptr GMimeParserOptions, str: cstring)
{.pop.}