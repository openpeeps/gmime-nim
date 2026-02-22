import unittest

import std/[os, times, options]
import ../src/gmime

g_mime_init() # required before using GMime APIs

test "api - parse mime_simple.eml":
  let msgPath = getCurrentDir() / "tests/data/mime_simple.eml"

  let parser: ptr GMimeParser = parseEmail(msgPath)
  assert parser != nil, "Failed to create parser"

  let message: ptr GMimeMessage = parser.constructMail()
  assert message.getSubject == "Sample message"
  assert message.getFromList.len == 1
  assert message.getFromList.get(0).name == "Nathaniel Borenstein"
  
  assert message.hasDateTime()
  let dt = parse("Fri, 21 May 1996 09:55:06 -0700", f = "ddd, dd MMM yyyy HH:mm:ss ZZZ")
  assert message.getDateTime().get() == dt

  parser.close()

g_mime_shutdown()