# GMime Bindings for Nim.
#
# (c) 2026 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/gmime-nim

type
  GObject* = object
    # Opaque type, actual fields are not exposed

  GObjectClass* = object of RootObj

  GSList* = object
    data*: pointer
    next*: ptr GSList

  GType* = culong      # GLib's GType is usually an unsigned long

  GMutex* = object     # Opaque struct, size depends on platform
    dummy: array[8, byte] # 8 bytes is typical for pthread mutex on most platforms

  GValue* = object
    dummy: array[24, byte] # GLib's GValue is typically 24 bytes on 64-bit platforms
  
  GParamSpec* = object
    dummy: array[16, byte] # Size can vary; 16 bytes is a common minimum

  GOptionGroup* = object
    dummy: array[16, byte] # Size can vary; 16 bytes is a common minimum

  GDestroyNotify* = proc(data: pointer)
  GBytes* = object
    dummy: array[16, byte] # Size can vary; 16 bytes is a common minimum

  GHashTable* = object
    dummy: array[16, byte] # Size can vary; 16 bytes is a common minimum

  GQuark* = guint
  GError* = object

  gboolean* = cint
  guint* = uint
  guint64* = uint64
  guint32* = uint32
  gint64* = int64
  gint32* = int32
  gint* = int
  gpointer* = pointer
  time_t* = clong
  gconstpointer* = pointer
  ssize_t* = clong
  gbpointer* = pointer
  guint8* = uint8

{.push cdecl, importc, header: "glib-object.h".}
type

  GPtrArray* {.incompleteStruct.} = object
    pdata*: ptr pointer
    len*: guint
    alloc: guint

  GByteArray* {.incompleteStruct.} = object
    data*: ptr guint8
    len*: guint

proc g_object_unref*(obj: pointer)
proc g_type_check_instance_is_a*(instance: pointer, iface_type: GType): gboolean
proc g_ptr_array_new*(): ptr GPtrArray
proc g_ptr_array_add*(array: ptr GPtrArray, data: pointer)
proc g_ptr_array_free*(array: ptr GPtrArray, free_seg: gboolean): pointer
{.pop.}

{.push cdecl, importc, header: "glib.h".}
type
  GDateTime* {.incompleteStruct.} = object
    # Opaque struct, actual fields are not exposed

proc g_date_time_to_unix*(datetime: ptr GDateTime): time_t
{.pop.}