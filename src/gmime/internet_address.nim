# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./bindings/gmime_internet_address

proc `$`*(address: ptr InternetAddress): string =
  ## Convert an InternetAddress to a string representation.
  if address != nil:
    return $(internet_address_to_string(address, nil, false.cint))