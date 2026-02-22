import unittest, os
import gmime

g_mime_init() # required before using GMime APIs

test "api - parse mime_simple.eml":
  let msgPath = getCurrentDir() / "tests/data/mime_simple.eml"

  let parser: ptr GMimeParser = parseEmail(msgPath)
  assert parser != nil, "Failed to create parser"

  let message: ptr GMimeMessage = parser.constructMail()
  assert message.getSubject == "Sample message"
  assert message.getFromList.len == 1
  assert message.getFromList.get(0).name == "Nathaniel Borenstein"

  parser.close()

g_mime_shutdown()
