From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Wed, 16 Nov 2016 17:40:06 +0000
Subject: [PATCH v4 2/2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1479318006-22023-2-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479317933-21849-3-git-send-email-manuel.schoelling@gmx.de>
 <1479318006-22023-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1479318006-22023-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: manuel.schoelling@gmx.de, jslaby@suse.cz, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrey_utkin@fastmail.com

Add a scrollback buffers for each VGA console. The benefit is that
the scrollback history is not flushed when switching between consoles
but is persistent.
The buffers are allocated on demand when a new console is opened.

This breaks tools like clear_console that rely on flushing the
scrollback history by switching back and forth between consoles
which is why this feature is disabled by default.
Use the escape sequence \e[3J instead for flushing the buffer.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
---
 drivers/video/console/Kconfig  |  23 ++++++-
 drivers/video/console/vgacon.c | 134 +++++++++++++++++++++++++++++--------=
----
 2 files changed, 114 insertions(+), 43 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 38da6e2..8167540 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -43,9 +43,26 @@ config VGACON_SOFT_SCROLLBACK_SIZE
        range 1 1024
        default "64"
        help
-         Enter the amount of System RAM to allocate for the scrollback
-	 buffer.  Each 64KB will give you approximately 16 80x25
-	 screenfuls of scrollback buffer
+	  Enter the amount of System RAM to allocate for scrollback
+	  buffers of VGA consoles. Each 64KB will give you approximately
+	  16 80x25 screenfuls of scrollback buffer.
+
+config VGACON_SOFT_SCROLLBACK_PERSISTENT
+	bool "Persistent Scrollback History for each console"
+	depends on VGACON_SOFT_SCROLLBACK
+	default n
+	help
+	  Say Y here if the scrollback history should persist when switching
+	  between consoles. Otherwise, the scrollback history will be flushed
+	  each time the console is switched.
+
+	  This breaks legacy versions of tools like clear_console which
+	  might cause security issues.
+	  Use the escape sequence \e[3J instead if this feature is activated.
+
+	  Note that a buffer of VGACON_SOFT_SCROLLBACK_SIZE is taken for each
+	  created tty device.
+	  So if you use a RAM-constrained system, say N here.
=20
 config MDA_CONSOLE
 	depends on !M68K && !PARISC && ISA
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index d3f823a..90ec0c5 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -162,7 +162,7 @@ static inline void vga_set_mem_top(struct vc_data *c)
=20
 #ifdef CONFIG_VGACON_SOFT_SCROLLBACK
 /* software scrollback */
-static struct vgacon_scrollback_info {
+struct vgacon_scrollback_info {
 	void *data;
 	int tail;
 	int size;
@@ -171,63 +171,116 @@ static struct vgacon_scrollback_info {
 	int cur;
 	int save;
 	int restore;
-} vgacon_scrollback;
+};
+static struct vgacon_scrollback_info *vgacon_scrollback_cur;
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
+static struct vgacon_scrollback_info vgacon_scrollbacks[MAX_NR_CONSOLES];
+#else
+static struct vgacon_scrollback_info vgacon_scrollbacks[1];
+#endif
+
+static void vgacon_scrollback_reset(size_t reset_size)
+{
+	if (vgacon_scrollback_cur->data && reset_size > 0)
+		memset(vgacon_scrollback_cur->data, 0, reset_size);
+
+	vgacon_scrollback_cur->cnt  =3D 0;
+	vgacon_scrollback_cur->tail =3D 0;
+	vgacon_scrollback_cur->cur  =3D 0;
+}
+
+static void vgacon_scrollback_init(int vc_num)
+{
+	int pitch =3D vga_video_num_columns * 2;
+	size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+	int rows =3D size/pitch;
+	void *data;
+
+	data =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, GFP_NOWAIT);
+	if (data) {
+		vgacon_scrollbacks[vc_num].data =3D data;
+		vgacon_scrollback_cur =3D &vgacon_scrollbacks[vc_num];
+
+		vgacon_scrollback_cur->rows =3D rows - 1;
+		vgacon_scrollback_cur->size =3D rows * pitch;
=20
-static void vgacon_scrollback_init(int pitch)
+		vgacon_scrollback_reset(0);
+	} else {
+		pr_warn("VGAcon: failed to allocate memory for scrollback. Trying to reu=
se previous buffer.\n");
+		/* Leave vgacon_scrollback_cur untouched but reset its content */
+		vgacon_scrollback_reset(size);
+	}
+}
+
+static void vgacon_switch_scrollback(int vc_num)
 {
-	int rows =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
-
-	if (vgacon_scrollback.data) {
-		vgacon_scrollback.cnt  =3D 0;
-		vgacon_scrollback.tail =3D 0;
-		vgacon_scrollback.cur  =3D 0;
-		vgacon_scrollback.rows =3D rows - 1;
-		vgacon_scrollback.size =3D rows * pitch;
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
+	if (!vgacon_scrollbacks[vc_num].data)
+		vgacon_scrollback_init(vc_num);
+	else
+		vgacon_scrollback_cur =3D &vgacon_scrollbacks[vc_num];
+#else
+	vc_num =3D 0;
+
+	if (!vgacon_scrollbacks[vc_num].data)
+		vgacon_scrollback_init(vc_num);
+	else {
+		size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+
+		vgacon_scrollback_reset(size);
 	}
+#endif
 }
=20
 static void vgacon_scrollback_startup(void)
 {
-	vgacon_scrollback.data =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 10=
24, GFP_NOWAIT);
-	vgacon_scrollback_init(vga_video_num_columns * 2);
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(vgacon_scrollbacks); ++i)
+		vgacon_scrollbacks[i].data =3D NULL;
+
+	vgacon_scrollback_cur =3D &vgacon_scrollbacks[0];
+	vgacon_scrollback_init(0);
 }
=20
 static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 {
 	void *p;
=20
-	if (!vgacon_scrollback.size || c->vc_num !=3D fg_console)
+	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size)
 		return;
=20
 	p =3D (void *) (c->vc_origin + t * c->vc_size_row);
=20
 	while (count--) {
-		scr_memcpyw(vgacon_scrollback.data + vgacon_scrollback.tail,
+		scr_memcpyw(vgacon_scrollback_cur->data +
+			    vgacon_scrollback_cur->tail,
 			    p, c->vc_size_row);
-		vgacon_scrollback.cnt++;
+
+		vgacon_scrollback_cur->cnt++;
 		p +=3D c->vc_size_row;
-		vgacon_scrollback.tail +=3D c->vc_size_row;
+		vgacon_scrollback_cur->tail +=3D c->vc_size_row;
=20
-		if (vgacon_scrollback.tail >=3D vgacon_scrollback.size)
-			vgacon_scrollback.tail =3D 0;
+		if (vgacon_scrollback_cur->tail >=3D vgacon_scrollback_cur->size)
+			vgacon_scrollback_cur->tail =3D 0;
=20
-		if (vgacon_scrollback.cnt > vgacon_scrollback.rows)
-			vgacon_scrollback.cnt =3D vgacon_scrollback.rows;
+		if (vgacon_scrollback_cur->cnt > vgacon_scrollback_cur->rows)
+			vgacon_scrollback_cur->cnt =3D vgacon_scrollback_cur->rows;
=20
-		vgacon_scrollback.cur =3D vgacon_scrollback.cnt;
+		vgacon_scrollback_cur->cur =3D vgacon_scrollback_cur->cnt;
 	}
 }
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
-	vgacon_scrollback.save =3D 0;
+	vgacon_scrollback_cur->save =3D 0;
=20
-	if (!vga_is_gfx && !vgacon_scrollback.restore) {
+	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ?
 			    vga_vram_size : c->vc_screenbuf_size);
-		vgacon_scrollback.restore =3D 1;
-		vgacon_scrollback.cur =3D vgacon_scrollback.cnt;
+		vgacon_scrollback_cur->restore =3D 1;
+		vgacon_scrollback_cur->cur =3D vgacon_scrollback_cur->cnt;
 	}
 }
=20
@@ -241,17 +294,17 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
 lines)
 		return;
 	}
=20
-	if (!vgacon_scrollback.data)
+	if (!vgacon_scrollback_cur->data)
 		return;
=20
-	if (!vgacon_scrollback.save) {
+	if (!vgacon_scrollback_cur->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
-		vgacon_scrollback.save =3D 1;
+		vgacon_scrollback_cur->save =3D 1;
 	}
=20
-	vgacon_scrollback.restore =3D 0;
-	start =3D vgacon_scrollback.cur + lines;
+	vgacon_scrollback_cur->restore =3D 0;
+	start =3D vgacon_scrollback_cur->cur + lines;
 	end =3D start + abs(lines);
=20
 	if (start < 0)
@@ -266,16 +319,16 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
 lines)
 	if (end > vgacon_scrollback_cnt)
 		end =3D vgacon_scrollback_cnt;
=20
-	vgacon_scrollback.cur =3D start;
+	vgacon_scrollback_cur->cur =3D start;
 	count =3D end - start;
-	soff =3D vgacon_scrollback.tail - ((vgacon_scrollback.cnt - end) *
-					 c->vc_size_row);
+	soff =3D vgacon_scrollback_cur->tail - (c->vc_size_row *
+					 (vgacon_scrollback_cur->cnt - end));
 	soff -=3D count * c->vc_size_row;
=20
 	if (soff < 0)
-		soff +=3D vgacon_scrollback.size;
+		soff +=3D vgacon_scrollback_cur->size;
=20
-	count =3D vgacon_scrollback.cnt - start;
+	count =3D vgacon_scrollback_cur->cnt - start;
=20
 	if (count > c->vc_rows)
 		count =3D c->vc_rows;
@@ -289,13 +342,13 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
 lines)
=20
 		count *=3D c->vc_size_row;
 		/* how much memory to end of buffer left? */
-		copysize =3D min(count, vgacon_scrollback.size - soff);
-		scr_memcpyw(d, vgacon_scrollback.data + soff, copysize);
+		copysize =3D min(count, vgacon_scrollback_cur->size - soff);
+		scr_memcpyw(d, vgacon_scrollback_cur->data + soff, copysize);
 		d +=3D copysize;
 		count -=3D copysize;
=20
 		if (count) {
-			scr_memcpyw(d, vgacon_scrollback.data, count);
+			scr_memcpyw(d, vgacon_scrollback_cur->data, count);
 			d +=3D count;
 		}
=20
@@ -308,6 +361,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int l=
ines)
 #define vgacon_scrollback_startup(...) do { } while (0)
 #define vgacon_scrollback_init(...)    do { } while (0)
 #define vgacon_scrollback_update(...)  do { } while (0)
+#define vgacon_switch_scrollback(...)  do { } while (0)
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
@@ -782,7 +836,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
=20
-	vgacon_scrollback_init(c->vc_size_row);
+	vgacon_switch_scrollback(c->vc_num);
 	return 0;		/* Redrawing not needed */
 }
=20
--=20
2.1.4

