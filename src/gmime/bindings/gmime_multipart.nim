# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

import ./glib
import ./gmime_encodings
import ./gmime_object

# Type definitions
type
  GMimeMultipart* = object
    parent_object: GMimeObject
    children: pointer # GPtrArray, to be imported later
    boundary: cstring
    prologue: cstring
    epilogue: cstring
    write_end_boundary: gboolean

  GMimeMultipartClass* = object
    parent_class: GMimeObjectClass
    clear*: proc(multipart: ptr GMimeMultipart)
    add*: proc(multipart: ptr GMimeMultipart, part: ptr GMimeObject)
    insert*: proc(multipart: ptr GMimeMultipart, index: int, part: ptr GMimeObject)
    remove*: proc(multipart: ptr GMimeMultipart, part: ptr GMimeObject): gboolean
    remove_at*: proc(multipart: ptr GMimeMultipart, index: int): ptr GMimeObject
    get_part*: proc(multipart: ptr GMimeMultipart, index: int): ptr GMimeObject
    contains*: proc(multipart: ptr GMimeMultipart, part: ptr GMimeObject): gboolean
    index_of*: proc(multipart: ptr GMimeMultipart, part: ptr GMimeObject): int
    get_count*: proc(multipart: ptr GMimeMultipart): int
    set_boundary*: proc(multipart: ptr GMimeMultipart, boundary: cstring)
    get_boundary*: proc(multipart: ptr GMimeMultipart): cstring
  
  GMimeObjectForeachFunc* = proc(obj: ptr GMimeObject, user_data: pointer)


# Function declarations
{.push importc, cdecl, header: "gmime/gmime.h".}
proc g_mime_multipart_get_type*(): GType

proc g_mime_multipart_new*(): ptr GMimeMultipart
proc g_mime_multipart_new_with_subtype*(subtype: cstring): ptr GMimeMultipart

proc g_mime_multipart_set_prologue*(multipart: ptr GMimeMultipart, prologue: cstring)
proc g_mime_multipart_get_prologue*(multipart: ptr GMimeMultipart): cstring

proc g_mime_multipart_set_epilogue*(multipart: ptr GMimeMultipart, epilogue: cstring)
proc g_mime_multipart_get_epilogue*(multipart: ptr GMimeMultipart): cstring

proc g_mime_multipart_clear*(multipart: ptr GMimeMultipart)

proc g_mime_multipart_add*(multipart: ptr GMimeMultipart, part: ptr GMimeObject)
proc g_mime_multipart_insert*(multipart: ptr GMimeMultipart, index: int, part: ptr GMimeObject)
proc g_mime_multipart_remove*(multipart: ptr GMimeMultipart, part: ptr GMimeObject): gboolean
proc g_mime_multipart_remove_at*(multipart: ptr GMimeMultipart, index: int): ptr GMimeObject
proc g_mime_multipart_replace*(multipart: ptr GMimeMultipart, index: int, replacement: ptr GMimeObject): ptr GMimeObject
proc g_mime_multipart_get_part*(multipart: ptr GMimeMultipart, index: int): ptr GMimeObject

proc g_mime_multipart_contains*(multipart: ptr GMimeMultipart, part: ptr GMimeObject): gboolean
proc g_mime_multipart_index_of*(multipart: ptr GMimeMultipart, part: ptr GMimeObject): int

proc g_mime_multipart_get_count*(multipart: ptr GMimeMultipart): int

proc g_mime_multipart_set_boundary*(multipart: ptr GMimeMultipart, boundary: cstring)
proc g_mime_multipart_get_boundary*(multipart: ptr GMimeMultipart): cstring

proc g_mime_multipart_foreach*(multipart: ptr GMimeMultipart, callback: GMimeObjectForeachFunc, user_data: pointer)

proc g_mime_multipart_get_subpart_from_content_id*(multipart: ptr GMimeMultipart, content_id: cstring): ptr GMimeObject
{.pop.}