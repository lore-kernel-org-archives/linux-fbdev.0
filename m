From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Tue, 10 Jan 2017 21:28:37 +0000
Subject: [PATCH v9 3/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170110212838.16175-4-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170110212838.16175-1-manuel.schoelling@gmx.de>
In-Reply-To: <20170110212838.16175-1-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>

Add a scrollback buffers for each VGA console. The benefit is that
the scrollback history is not flushed when switching between consoles
but is persistent.
The buffers are allocated on demand when a new console is opened.

This breaks tools like clear_console that rely on flushing the
scrollback history by switching back and forth between consoles
which is why this feature is disabled by default.
Use the escape sequence \e[3J instead for flushing the buffer.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/video/console/Kconfig  |  25 +++++++-
 drivers/video/console/vgacon.c | 142 ++++++++++++++++++++++++++-----------=
----
 2 files changed, 111 insertions(+), 56 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index c3f1fb9ee820..f500e58f7636 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -43,9 +43,28 @@ config VGACON_SOFT_SCROLLBACK_SIZE
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
+	  This feature might break your tool of choice to flush the scrollback
+	  buffer, e.g. clear(1) will work fine but Debian's clear_console(1)
+	  will be broken, which might cause security issues.
+	  You can use the escape sequence \e[3J instead if this feature is
+	  activated.
+
+	  Note that a buffer of VGACON_SOFT_SCROLLBACK_SIZE is taken for each
+	  created tty device.
+	  So if you use a RAM-constrained system, say N here.
=20
 config MDA_CONSOLE
 	depends on !M68K && !PARISC && ISA
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 9a7c2bbc5326..ca23d222e029 100644
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
@@ -171,74 +171,110 @@ static struct vgacon_scrollback_info {
 	int cur;
 	int save;
 	int restore;
-} vgacon_scrollback;
+};
+
+static struct vgacon_scrollback_info *vgacon_scrollback_cur;
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
+static struct vgacon_scrollback_info vgacon_scrollbacks[MAX_NR_CONSOLES];
+#else
+static struct vgacon_scrollback_info vgacon_scrollbacks[1];
+#endif
=20
-static void vgacon_scrollback_reset(size_t reset_size)
+static void vgacon_scrollback_reset(int vc_num, size_t reset_size)
 {
-	if (vgacon_scrollback.data && reset_size > 0)
-		memset(vgacon_scrollback.data, 0, reset_size);
+	struct vgacon_scrollback_info *scrollback =3D &vgacon_scrollbacks[vc_num];
+
+	if (scrollback->data && reset_size > 0)
+		memset(scrollback->data, 0, reset_size);
=20
-	vgacon_scrollback.cnt  =3D 0;
-	vgacon_scrollback.tail =3D 0;
-	vgacon_scrollback.cur  =3D 0;
+	scrollback->cnt  =3D 0;
+	scrollback->tail =3D 0;
+	scrollback->cur  =3D 0;
 }
=20
-static void vgacon_scrollback_init(int pitch)
+static void vgacon_scrollback_init(int vc_num)
 {
-	int rows =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
-
-	if (vgacon_scrollback.data) {
-		vgacon_scrollback.cnt  =3D 0;
-		vgacon_scrollback.tail =3D 0;
-		vgacon_scrollback.cur  =3D 0;
-		vgacon_scrollback.rows =3D rows - 1;
-		vgacon_scrollback.size =3D rows * pitch;
+	int pitch =3D vga_video_num_columns * 2;
+	size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+	int rows =3D size / pitch;
+	void *data;
+
+	data =3D kmalloc_array(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024,
+			     GFP_NOWAIT);
+
+	vgacon_scrollbacks[vc_num].data =3D data;
+	vgacon_scrollback_cur =3D &vgacon_scrollbacks[vc_num];
+
+	vgacon_scrollback_cur->rows =3D rows - 1;
+	vgacon_scrollback_cur->size =3D rows * pitch;
+
+	vgacon_scrollback_reset(vc_num, size);
+}
+
+static void vgacon_scrollback_switch(int vc_num)
+{
+#ifndef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
+	vc_num =3D 0;
+#endif
+
+	if (!vgacon_scrollbacks[vc_num].data) {
+		vgacon_scrollback_init(vc_num);
+	} else {
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT
+		vgacon_scrollback_cur =3D &vgacon_scrollbacks[vc_num];
+#else
+		size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
+
+		vgacon_scrollback_reset(vc_num, size);
+#endif
 	}
 }
=20
 static void vgacon_scrollback_startup(void)
 {
-	vgacon_scrollback.data =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE,
-		1024, GFP_NOWAIT);
-	vgacon_scrollback_init(vga_video_num_columns * 2);
+	vgacon_scrollback_cur =3D &vgacon_scrollbacks[0];
+	vgacon_scrollback_init(0);
 }
=20
 static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 {
 	void *p;
=20
-	if (!vgacon_scrollback.size || c->vc_num !=3D fg_console)
+	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size ||
+	    c->vc_num !=3D fg_console)
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
@@ -252,41 +288,41 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
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
 		start =3D 0;
=20
-	if (start > vgacon_scrollback.cnt)
-		start =3D vgacon_scrollback.cnt;
+	if (start > vgacon_scrollback_cur->cnt)
+		start =3D vgacon_scrollback_cur->cnt;
=20
 	if (end < 0)
 		end =3D 0;
=20
-	if (end > vgacon_scrollback.cnt)
-		end =3D vgacon_scrollback.cnt;
+	if (end > vgacon_scrollback_cur->cnt)
+		end =3D vgacon_scrollback_cur->cnt;
=20
-	vgacon_scrollback.cur =3D start;
+	vgacon_scrollback_cur->cur =3D start;
 	count =3D end - start;
-	soff =3D vgacon_scrollback.tail - ((vgacon_scrollback.cnt - end) *
-					 c->vc_size_row);
+	soff =3D vgacon_scrollback_cur->tail -
+		((vgacon_scrollback_cur->cnt - end) * c->vc_size_row);
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
@@ -300,13 +336,13 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
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
@@ -320,13 +356,13 @@ static void vgacon_flush_scrollback(struct vc_data *c)
 {
 	size_t size =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024;
=20
-	if (c->vc_num =3D fg_console)
-		vgacon_scrollback_reset(size);
+	vgacon_scrollback_reset(c->vc_num, size);
 }
 #else
 #define vgacon_scrollback_startup(...) do { } while (0)
 #define vgacon_scrollback_init(...)    do { } while (0)
 #define vgacon_scrollback_update(...)  do { } while (0)
+#define vgacon_scrollback_switch(...)  do { } while (0)
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
@@ -805,7 +841,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
=20
-	vgacon_scrollback_init(c->vc_size_row);
+	vgacon_scrollback_switch(c->vc_num);
 	return 0;		/* Redrawing not needed */
 }
=20
--=20
2.11.0

