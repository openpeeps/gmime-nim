# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_object

{.push importc, cdecl, header: "gmime/gmime.h".}

type
  GMimePartIter* {.incompleteStruct.} = object

proc g_mime_part_iter_get_type*(): GType

proc g_mime_part_iter_new*(toplevel: ptr GMimeObject): ptr GMimePartIter
proc g_mime_part_iter_free*(iter: ptr GMimePartIter)
proc g_mime_part_iter_clone*(iter: ptr GMimePartIter): ptr GMimePartIter
proc g_mime_part_iter_reset*(iter: ptr GMimePartIter)
proc g_mime_part_iter_jump_to*(iter: ptr GMimePartIter, path: cstring): gboolean
proc g_mime_part_iter_is_valid*(iter: ptr GMimePartIter): gboolean
proc g_mime_part_iter_next*(iter: ptr GMimePartIter): gboolean
proc g_mime_part_iter_prev*(iter: ptr GMimePartIter): gboolean
proc g_mime_part_iter_get_toplevel*(iter: ptr GMimePartIter): ptr GMimeObject
proc g_mime_part_iter_get_current*(iter: ptr GMimePartIter): ptr GMimeObject
proc g_mime_part_iter_get_parent*(iter: ptr GMimePartIter): ptr GMimeObject
proc g_mime_part_iter_get_path*(iter: ptr GMimePartIter): cstring
proc g_mime_part_iter_replace*(iter: ptr GMimePartIter, replacement: ptr GMimeObject): gboolean
proc g_mime_part_iter_remove*(iter: ptr GMimePartIter): gboolean

{.pop.}