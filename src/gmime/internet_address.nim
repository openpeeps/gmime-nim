# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./bindings/glib
import ./bindings/gmime_internet_address

proc getName*(ia: ptr InternetAddress): string =
  ## Get the name from an InternetAddress as a Nim string.
  if ia != nil:
    return $(internet_address_get_name(ia))

proc getCharset*(ia: ptr InternetAddress): string =
  ## Get the charset from an InternetAddress as a Nim string.
  if ia != nil:
    return $(internet_address_get_charset(ia))

#
# InternetAddressList
#
proc add*(ial: ptr InternetAddressList, ia: ptr InternetAddress): int {.discardable.} =
  ## Add an InternetAddress to an InternetAddressList.
  ## Returns the new number of addresses in the list.
  internet_address_list_add(ial, ia)

proc prepend*(ial, ial2: ptr InternetAddressList) =
  ## Prepend all addresses from one InternetAddressList to another.
  internet_address_list_prepend(ial, ial2)
  
proc append*(ial, ial2: ptr InternetAddressList) =
  ## Append an InternetAddress to an InternetAddressList.
  internet_address_list_append(ial, ial2)

proc insert*(ial: ptr InternetAddressList, ia: ptr InternetAddress, index: int) =
  ## Insert an InternetAddress at a specific index in an InternetAddressList
  internet_address_list_insert(ial, index, ia)

proc remove*(ial: ptr InternetAddressList, ia: ptr InternetAddress): bool =
  ## Remove an InternetAddress from an InternetAddressList
  internet_address_list_remove(ial, ia) != 0 

proc removeAt*(ial: ptr InternetAddressList, index: int): bool =
  ## Remove an InternetAddress at a specific index from an InternetAddressList
  internet_address_list_remove_at(ial, index) != 0

proc contains*(ial: ptr InternetAddressList, ia: ptr InternetAddress): bool =
  ## Check if an InternetAddressList contains a specific InternetAddress
  internet_address_list_contains(ial, ia) != 0

proc indexOf*(ial: ptr InternetAddressList, ia: ptr InternetAddress): int =
  ## Get the index of an InternetAddress in an InternetAddressList
  internet_address_list_index_of(ial, ia)

proc get*(ial: ptr InternetAddressList, index: int): ptr InternetAddress =
  ## Get an InternetAddress at a specific index from an InternetAddressList
  internet_address_list_get_address(ial, index)

proc put*(ial: ptr InternetAddressList, index: int, ia: ptr InternetAddress) =
  ## Set an InternetAddress at a specific index in an InternetAddressList
  ## 
  ## Note that this will replace and unref the existing InternetAddress at
  ## that index, so use with caution.
  let existing = ial.get(index)
  if existing != nil:
    g_object_unref(existing) # unref the existing address before replacing it
  internet_address_list_set_address(ial, index, ia)

proc `$`*(address: ptr InternetAddress): string =
  ## Convert an InternetAddress to a string representation.
  if address != nil:
    return $(internet_address_to_string(address, nil, false.cint))