From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Mon, 02 Jan 2017 14:27:39 +0000
Subject: [PATCH RESEND v7 2/3] console: Add callback to flush scrollback buffer to consw struct
Message-Id: <1483367260-3836-3-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1480848836-11330-1-git-send-email-manuel.schoelling@gmx.de>
 <1483367260-3836-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1483367260-3836-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: manuel.schoelling@gmx.de, jslaby@suse.cz, gregkh@linuxfoundation.org, andrey_utkin@fastmail.com, kilobyte@angband.pl, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This new callback is in preparation for persistent scrollback buffer
support for VGA consoles.
With a single scrollback buffer for all consoles, we could flush the
buffer just by invocating consw->con_switch(). But when each VGA console
has its own scrollback buffer, we need a new callback to tell the
video console driver which buffer to flush.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Adam Borowski <kilobyte@angband.pl>

---
 drivers/tty/vt/vt.c            |  9 +++++++++
 drivers/video/console/vgacon.c | 24 +++++++++++++++++++++++-
 include/linux/console.h        |  4 ++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4c10a9d..9d3ce50 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -625,6 +625,14 @@ static void save_screen(struct vc_data *vc)
 		vc->vc_sw->con_save_screen(vc);
 }
=20
+static void flush_scrollback(struct vc_data *vc)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	if (vc->vc_sw->con_flush_scrollback)
+		vc->vc_sw->con_flush_scrollback(vc);
+}
+
 /*
  *	Redrawing of screen
  */
@@ -1171,6 +1179,7 @@ static void csi_J(struct vc_data *vc, int vpar)
 		case 3: /* erase scroll-back buffer (and whole display) */
 			scr_memsetw(vc->vc_screenbuf, vc->vc_video_erase_char,
 				    vc->vc_screenbuf_size);
+			flush_scrollback(vc);
 			set_origin(vc);
 			if (con_is_visible(vc))
 				update_screen(vc);
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 48b9764..9a7c2bb 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -173,6 +173,16 @@ static struct vgacon_scrollback_info {
 	int restore;
 } vgacon_scrollback;
=20
+static void vgacon_scrollback_reset(size_t reset_size)
+{
+	if (vgacon_scrollback.data && reset_size > 0)
+		memset(vgacon_scrollback.data, 0, reset_size);
+
+	vgacon_scrollback.cnt  =3D 0;
+	vgacon_scrollback.tail =3D 0;
+	vgacon_scrollback.cur  =3D 0;
+}
+
 static void vgacon_scrollback_init(int pitch)
 {
 	int rows =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
@@ -305,6 +315,14 @@ static void vgacon_scrolldelta(struct vc_data *c, int =
lines)
 	} else
 		vgacon_cursor(c, CM_MOVE);
 }
+
+static void vgacon_flush_scrollback(struct vc_data *c)
+{
+	size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+
+	if (c->vc_num =3D fg_console)
+		vgacon_scrollback_reset(size);
+}
 #else
 #define vgacon_scrollback_startup(...) do { } while (0)
 #define vgacon_scrollback_init(...)    do { } while (0)
@@ -322,6 +340,10 @@ static void vgacon_scrolldelta(struct vc_data *c, int =
lines)
 			vga_vram_size);
 	vga_set_mem_top(c);
 }
+
+static void vgacon_flush_scrollback(struct vc_data *c)
+{
+}
 #endif /* CONFIG_VGACON_SOFT_SCROLLBACK */
=20
 static const char *vgacon_startup(void)
@@ -1329,7 +1351,6 @@ static bool vgacon_scroll(struct vc_data *c, unsigned=
 int t, unsigned int b,
 	return true;
 }
=20
-
 /*
  *  The console `switch' structure for the VGA based console
  */
@@ -1362,6 +1383,7 @@ const struct consw vga_con =3D {
 	.con_save_screen =3D vgacon_save_screen,
 	.con_build_attr =3D vgacon_build_attr,
 	.con_invert_region =3D vgacon_invert_region,
+	.con_flush_scrollback =3D vgacon_flush_scrollback,
 };
 EXPORT_SYMBOL(vga_con);
=20
diff --git a/include/linux/console.h b/include/linux/console.h
index 9c26c66..5949d18 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -73,6 +73,10 @@ struct consw {
 	u16    *(*con_screen_pos)(struct vc_data *, int);
 	unsigned long (*con_getxy)(struct vc_data *, unsigned long, int *, int *);
 	/*
+	 * Flush the video console driver's scrollback buffer
+	 */
+	void	(*con_flush_scrollback)(struct vc_data *);
+	/*
 	 * Prepare the console for the debugger.  This includes, but is not
 	 * limited to, unblanking the console, loading an appropriate
 	 * palette, and allowing debugger generated output.
--=20
2.1.4

