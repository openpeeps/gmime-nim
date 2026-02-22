switch("path", "$projectDir/../src")

when defined(macosx):
  --passC:"-I /opt/local/include -I /opt/local/include/gmime-3.0 -I/opt/local/include/glib-2.0/ -I/opt/local/lib/glib-2.0/include"
  --passL:"-L/opt/local/lib -lgmime-3.0 -lgobject-2.0 -lglib-2.0 -lgmodule-2.0"
elif defined(linux):
  --passC:"-I /usr/include -I /usr/include/gmime-3.0 -I/usr/include/glib-2.0/ -I/usr/lib/glib-2.0/include"
  --passL:"-L/usr/lib -lgmime-3.0 -lgobject-2.0 -lglib-2.0 -lgmodule-2.0"
  --passL:"-L/usr/lib/x86_64-linux-gnu -lgmime-3.0 -lgobject-2.0 -lglib-2.0 -lgmodule-2.0"