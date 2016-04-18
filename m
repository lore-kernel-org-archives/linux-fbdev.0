From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Mon, 18 Apr 2016 19:56:58 +0000
Subject: [PATCH 2/2] console: Add ioctl for flushing the scrollback buffer
Message-Id: <1461009418-1795-3-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461009418-1795-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1461009418-1795-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, thomas@winischhofer.net, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jejb@parisc-linux.org, deller@gmx.de, manuel.schoelling@gmx.de, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org

Tools like clear_console rely on the fact that scrollback history is
flushed when switching back and forth between consoles.
Persistent scrollback buffers for each console breaks this, so this
patch adds a ioctl() callf for flushing the scrollback history.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
---
 drivers/tty/vt/vt_ioctl.c               | 20 ++++++++++++++++++++
 drivers/usb/misc/sisusbvga/sisusb_con.c |  1 +
 drivers/video/console/dummycon.c        |  1 +
 drivers/video/console/mdacon.c          |  6 ++++++
 drivers/video/console/newport_con.c     |  1 +
 drivers/video/console/sticon.c          |  7 +++++++
 drivers/video/console/vgacon.c          | 23 +++++++++++++++++++++++
 include/linux/console.h                 |  1 +
 include/uapi/linux/vt.h                 |  1 +
 9 files changed, 61 insertions(+)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 97d5a74..18adc23 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -903,6 +903,26 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 	}
=20
+	/*
+	 * flush the specified VT's scollback buffer
+	 */
+	case VT_FLUSH_SCROLLBACK: {
+		if (!perm)
+			return -EPERM;
+		if (arg =3D 0 || arg > MAX_NR_CONSOLES)
+			ret =3D -ENXIO;
+		else {
+			struct vc_data *data =3D vc_cons[arg-1].d;
+
+			if (!data)
+				ret =3D -ENXIO;
+			else
+				ret =3D data->vc_sw->con_flush_scrollback(data);
+		}
+
+		break;
+	}
+
 	case PIO_FONT: {
 		if (!perm)
 			return -EPERM;
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sis=
usbvga/sisusb_con.c
index ace3430..cc5fc10 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1442,6 +1442,7 @@ static const struct consw sisusb_dummy_con =3D {
 	.con_font_copy =3D	SISUSBCONDUMMY,
 	.con_set_palette =3D	SISUSBCONDUMMY,
 	.con_scrolldelta =3D	SISUSBCONDUMMY,
+	.con_flush_scrollback =3D SISUSBCONDUMMY,
 };
=20
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummy=
con.c
index 0efc52f..d2888e5 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -73,5 +73,6 @@ const struct consw dummy_con =3D {
     .con_font_copy =3D	DUMMY,
     .con_set_palette =3D	DUMMY,
     .con_scrolldelta =3D	DUMMY,
+    .con_flush_scrollback =3D DUMMY,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index 296e945..10ebcbe 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -510,6 +510,11 @@ static int mdacon_scrolldelta(struct vc_data *c, int l=
ines)
 	return 0;
 }
=20
+static int mdacon_flush_scrollback(struct vc_data *c)
+{
+	return 0;
+}
+
 static void mdacon_cursor(struct vc_data *c, int mode)
 {
 	if (mode =3D CM_ERASE) {
@@ -579,6 +584,7 @@ static const struct consw mda_con =3D {
 	.con_blank =3D		mdacon_blank,
 	.con_set_palette =3D	mdacon_set_palette,
 	.con_scrolldelta =3D	mdacon_scrolldelta,
+	.con_flush_scrollback =3D	mdacon_flush_scrollback,
 	.con_build_attr =3D	mdacon_build_attr,
 	.con_invert_region =3D	mdacon_invert_region,
 };
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/ne=
wport_con.c
index bb4e962..d04183c 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -738,6 +738,7 @@ const struct consw newport_con =3D {
 	.con_scrolldelta  =3D newport_scrolldelta,
 	.con_set_origin	  =3D DUMMY,
 	.con_save_screen  =3D DUMMY
+	.con_flush_scrollback =3D DUMMY,
 };
=20
 static int newport_probe(struct gio_device *dev,
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 026fd12..46046d6 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -345,6 +345,12 @@ static void sticon_save_screen(struct vc_data *conp)
 {
 }
=20
+static int sticon_flush_scrollback(struct vc_data *c)
+{
+	return 0;
+}
+
+
 static const struct consw sti_con =3D {
 	.owner			=3D THIS_MODULE,
 	.con_startup		=3D sticon_startup,
@@ -360,6 +366,7 @@ static const struct consw sti_con =3D {
 	.con_blank		=3D sticon_blank,
 	.con_set_palette	=3D sticon_set_palette,
 	.con_scrolldelta	=3D sticon_scrolldelta,
+	.con_flush_scrollback	=3D sticon_flush_scrollback,
 	.con_set_origin		=3D sticon_set_origin,
 	.con_save_screen	=3D sticon_save_screen,=20
 	.con_build_attr		=3D sticon_build_attr,
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 6c0b9ba..b5ea94f 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -379,12 +379,34 @@ static int vgacon_scrolldelta(struct vc_data *c, int =
lines)
=20
 	return 1;
 }
+
+/* flush the scrollback buffer of a console */
+static int vgacon_flush_scrollback(struct vc_data *c)
+{
+	size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+	struct vgacon_scrollback_info *vgacon_scrollback_prev;
+
+	vgacon_scrollback_prev =3D vgacon_scrollback_cur;
+	vgacon_scrollback_cur =3D &vgacon_scrollbacks[c->vc_num];
+
+	if (vgacon_scrollback_cur !=3D NULL)
+		vgacon_scrollback_reset(size);
+
+	vgacon_scrollback_cur =3D vgacon_scrollback_prev;
+
+	return 0;
+}
 #else
 #define vgacon_scrollback_startup(...) do { } while (0)
 #define vgacon_scrollback_init(...)    do { } while (0)
 #define vgacon_scrollback_update(...)  do { } while (0)
 #define vgacon_switch_scrollback(...)  do { } while (0)
=20
+static int vgacon_flush_scrollback(struct vc_data *c)
+{
+	return 0;
+}
+
 static void vgacon_restore_screen(struct vc_data *c)
 {
 	if (c->vc_origin !=3D c->vc_visible_origin)
@@ -1492,6 +1514,7 @@ const struct consw vga_con =3D {
 	.con_resize =3D vgacon_resize,
 	.con_set_palette =3D vgacon_set_palette,
 	.con_scrolldelta =3D vgacon_scrolldelta,
+	.con_flush_scrollback =3D vgacon_flush_scrollback,
 	.con_set_origin =3D vgacon_set_origin,
 	.con_save_screen =3D vgacon_save_screen,
 	.con_build_attr =3D vgacon_build_attr,
diff --git a/include/linux/console.h b/include/linux/console.h
index e49cc1e..946ff20 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -49,6 +49,7 @@ struct consw {
 			       unsigned int);
 	int	(*con_set_palette)(struct vc_data *, unsigned char *);
 	int	(*con_scrolldelta)(struct vc_data *, int);
+	int	(*con_flush_scrollback)(struct vc_data *);
 	int	(*con_set_origin)(struct vc_data *);
 	void	(*con_save_screen)(struct vc_data *);
 	u8	(*con_build_attr)(struct vc_data *, u8, u8, u8, u8, u8, u8);
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index 978578b..b799541 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -83,5 +83,6 @@ struct vt_setactivate {
 };
=20
 #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
+#define VT_FLUSH_SCROLLBACK	0x5610	/* Flush the scrollback buffer */
=20
 #endif /* _UAPI_LINUX_VT_H */
--=20
2.1.4

