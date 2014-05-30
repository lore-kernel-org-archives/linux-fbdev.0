From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Fri, 30 May 2014 13:27:05 +0000
Subject: [PATCH] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, geert@linux-m68k.org, broonie@linaro.org, rdunlap@infradead.org, dh.herrmann@gmail.com, airlied@redhat.com, mtosatti@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>

Add a scrollback buffers for each VGA console. The benefit is that
the scrollback history is not flushed when switching between consoles
but is persistent.
The buffers are allocated on demand when a new console is opened.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
---
 drivers/video/console/Kconfig  |    6 +-
 drivers/video/console/vgacon.c |  124 ++++++++++++++++++++++++------------=
----
 2 files changed, 79 insertions(+), 51 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index fe1cd01..d7ec96c 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -38,14 +38,14 @@ config VGACON_SOFT_SCROLLBACK
 	 RAM to allocate for this buffer.  If unsure, say 'N'.
=20
 config VGACON_SOFT_SCROLLBACK_SIZE
-       int "Scrollback Buffer Size (in KB)"
+       int "Scrollback Buffer Size per console (in KB)"
        depends on VGACON_SOFT_SCROLLBACK
        range 1 1024
        default "64"
        help
          Enter the amount of System RAM to allocate for the scrollback
-	 buffer.  Each 64KB will give you approximately 16 80x25
-	 screenfuls of scrollback buffer
+	 buffer for each VGA console. Each 64KB will give you approximately
+	 16 80x25 screenfuls of scrollback buffer.
=20
 config MDA_CONSOLE
 	depends on !M68K && !PARISC && ISA
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 9d8feac..215eafb 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -181,75 +181,101 @@ static inline void vga_set_mem_top(struct vc_data *c)
=20
 #ifdef CONFIG_VGACON_SOFT_SCROLLBACK
 /* software scrollback */
-static void *vgacon_scrollback;
-static int vgacon_scrollback_tail;
-static int vgacon_scrollback_size;
-static int vgacon_scrollback_rows;
-static int vgacon_scrollback_cnt;
-static int vgacon_scrollback_cur;
-static int vgacon_scrollback_save;
-static int vgacon_scrollback_restore;
-
-static void vgacon_scrollback_init(int pitch)
+struct vgacon_scrollback_info {
+	void *data;
+	int tail;
+	int size;
+	int rows;
+	int cnt;
+	int cur;
+	int save;
+	int restore;
+} vgacon_scrollbacks[MAX_NR_CONSOLES];
+
+static void vgacon_scrollback_init(int vc_num)
 {
+	int pitch =3D vga_video_num_columns * 2;
 	int rows =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
+	void *data;
=20
-	if (vgacon_scrollback) {
-		vgacon_scrollback_cnt  =3D 0;
-		vgacon_scrollback_tail =3D 0;
-		vgacon_scrollback_cur  =3D 0;
-		vgacon_scrollback_rows =3D rows - 1;
-		vgacon_scrollback_size =3D rows * pitch;
+	data =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, GFP_NOWAIT);
+	if (!data) {
+		pr_warn("VGAcon: failed to allocate memory for scrollback.\n");
+		vgacon_scrollbacks[vc_num].data =3D NULL;
+		return;
 	}
+
+	vgacon_scrollbacks[vc_num].data =3D data;
+	vgacon_scrollbacks[vc_num].cnt  =3D 0;
+	vgacon_scrollbacks[vc_num].tail =3D 0;
+	vgacon_scrollbacks[vc_num].cur  =3D 0;
+	vgacon_scrollbacks[vc_num].rows =3D rows - 1;
+	vgacon_scrollbacks[vc_num].size =3D rows * pitch;
+}
+
+static void vgacon_switch_scrollback(int vc_num)
+{
+	if (!vgacon_scrollbacks[vc_num].data)
+		vgacon_scrollback_init(vc_num);
 }
=20
 static void vgacon_scrollback_startup(void)
 {
-	vgacon_scrollback =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, G=
FP_NOWAIT);
-	vgacon_scrollback_init(vga_video_num_columns * 2);
+	int i;
+
+	for (i =3D 0; i < MAX_NR_CONSOLES; ++i)
+		vgacon_scrollbacks[i].data =3D NULL;
+
+	vgacon_scrollback_init(0);
 }
=20
 static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 {
+	struct vgacon_scrollback_info *scrollback;
 	void *p;
=20
-	if (!vgacon_scrollback_size || c->vc_num !=3D fg_console)
+	scrollback =3D &vgacon_scrollbacks[c->vc_num];
+	if (!scrollback->data || !scrollback->size)
 		return;
=20
 	p =3D (void *) (c->vc_origin + t * c->vc_size_row);
=20
 	while (count--) {
-		scr_memcpyw(vgacon_scrollback + vgacon_scrollback_tail,
+		scr_memcpyw(scrollback->data + scrollback->tail,
 			    p, c->vc_size_row);
-		vgacon_scrollback_cnt++;
+		scrollback->cnt++;
 		p +=3D c->vc_size_row;
-		vgacon_scrollback_tail +=3D c->vc_size_row;
+		scrollback->tail +=3D c->vc_size_row;
=20
-		if (vgacon_scrollback_tail >=3D vgacon_scrollback_size)
-			vgacon_scrollback_tail =3D 0;
+		if (scrollback->tail >=3D scrollback->size)
+			scrollback->tail =3D 0;
=20
-		if (vgacon_scrollback_cnt > vgacon_scrollback_rows)
-			vgacon_scrollback_cnt =3D vgacon_scrollback_rows;
+		if (scrollback->cnt > scrollback->rows)
+			scrollback->cnt =3D scrollback->rows;
=20
-		vgacon_scrollback_cur =3D vgacon_scrollback_cnt;
+		scrollback->cur =3D scrollback->cnt;
 	}
 }
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
-	vgacon_scrollback_save =3D 0;
+	struct vgacon_scrollback_info *scrollback;
+
+	scrollback =3D &vgacon_scrollbacks[c->vc_num];
+	scrollback->save =3D 0;
=20
-	if (!vga_is_gfx && !vgacon_scrollback_restore) {
+	if (!vga_is_gfx && !scrollback->restore) {
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ?
 			    vga_vram_size : c->vc_screenbuf_size);
-		vgacon_scrollback_restore =3D 1;
-		vgacon_scrollback_cur =3D vgacon_scrollback_cnt;
+		scrollback->restore =3D 1;
+		scrollback->cur =3D scrollback->cnt;
 	}
 }
=20
 static int vgacon_scrolldelta(struct vc_data *c, int lines)
 {
+	struct vgacon_scrollback_info *scrollback;
 	int start, end, count, soff;
=20
 	if (!lines) {
@@ -258,41 +284,42 @@ static int vgacon_scrolldelta(struct vc_data *c, int =
lines)
 		return 1;
 	}
=20
-	if (!vgacon_scrollback)
+	scrollback =3D &vgacon_scrollbacks[c->vc_num];
+	if (!scrollback->data)
 		return 1;
=20
-	if (!vgacon_scrollback_save) {
+	if (!scrollback->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
-		vgacon_scrollback_save =3D 1;
+		scrollback->save =3D 1;
 	}
=20
-	vgacon_scrollback_restore =3D 0;
-	start =3D vgacon_scrollback_cur + lines;
+	scrollback->restore =3D 0;
+	start =3D scrollback->cur + lines;
 	end =3D start + abs(lines);
=20
 	if (start < 0)
 		start =3D 0;
=20
-	if (start > vgacon_scrollback_cnt)
-		start =3D vgacon_scrollback_cnt;
+	if (start > scrollback->cnt)
+		start =3D scrollback->cnt;
=20
 	if (end < 0)
 		end =3D 0;
=20
-	if (end > vgacon_scrollback_cnt)
-		end =3D vgacon_scrollback_cnt;
+	if (end > scrollback->cnt)
+		end =3D scrollback->cnt;
=20
-	vgacon_scrollback_cur =3D start;
+	scrollback->cur =3D start;
 	count =3D end - start;
-	soff =3D vgacon_scrollback_tail - ((vgacon_scrollback_cnt - end) *
+	soff =3D scrollback->tail - ((scrollback->cnt - end) *
 					 c->vc_size_row);
 	soff -=3D count * c->vc_size_row;
=20
 	if (soff < 0)
-		soff +=3D vgacon_scrollback_size;
+		soff +=3D scrollback->size;
=20
-	count =3D vgacon_scrollback_cnt - start;
+	count =3D scrollback->cnt - start;
=20
 	if (count > c->vc_rows)
 		count =3D c->vc_rows;
@@ -306,13 +333,13 @@ static int vgacon_scrolldelta(struct vc_data *c, int =
lines)
=20
 		count *=3D c->vc_size_row;
 		/* how much memory to end of buffer left? */
-		copysize =3D min(count, vgacon_scrollback_size - soff);
-		scr_memcpyw(d, vgacon_scrollback + soff, copysize);
+		copysize =3D min(count, scrollback->size - soff);
+		scr_memcpyw(d, scrollback->data + soff, copysize);
 		d +=3D copysize;
 		count -=3D copysize;
=20
 		if (count) {
-			scr_memcpyw(d, vgacon_scrollback, count);
+			scr_memcpyw(d, scrollback->data, count);
 			d +=3D count;
 		}
=20
@@ -327,6 +354,7 @@ static int vgacon_scrolldelta(struct vc_data *c, int li=
nes)
 #define vgacon_scrollback_startup(...) do { } while (0)
 #define vgacon_scrollback_init(...)    do { } while (0)
 #define vgacon_scrollback_update(...)  do { } while (0)
+#define vgacon_switch_scrollback(...)  do { } while (0)
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
@@ -842,7 +870,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
=20
-	vgacon_scrollback_init(c->vc_size_row);
+	vgacon_switch_scrollback(c->vc_num);
 	return 0;		/* Redrawing not needed */
 }
=20
--=20
1.7.10.4

