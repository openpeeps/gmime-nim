import unittest, os
import gmime

g_mime_init() # required before using GMime APIs

test "bindings - parse mime_simple.eml":
  let msgPath = getCurrentDir() / "tests/data/mime_simple.eml"

  let stream = g_mime_stream_fsOpen(msgPath, GMimeReadOnly, 0644, nil)
  assert stream != nil, "Failed to open stream"

  let parser = g_mime_parser_new_with_stream(stream)
  assert parser != nil, "Failed to create parser"

  g_object_unref(stream) # parser takes ownership of the stream, so we can unref it now

  let message = g_mime_parser_construct_message(parser, nil)
  assert message != nil, "Failed to construct message"

  g_object_unref(parser) # message takes ownership of the parser, so we can unref it now

  # Print the subject of the message
  let subject = g_mime_message_get_subject(message)
  assert $subject == "Sample message"

  # Print the sender of the message
  let fromList = g_mime_message_get_from(message)
  assert fromList != nil

  # Get the first address from the from list and check its name
  let fromAddress = internet_address_list_get_address(fromList, 0)
  assert $(fromAddress.name) == "Nathaniel Borenstein"

  g_object_unref(message)

g_mime_shutdown()