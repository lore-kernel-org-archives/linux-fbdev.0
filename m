From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Sat, 31 May 2014 10:57:36 +0000
Subject: [PATCH v2] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1401533856-4067-1-git-send-email-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdXP47kf1sSfx1NLpGb1eGsepVvMPQjVg9XzfFYWpwBaTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXP47kf1sSfx1NLpGb1eGsepVvMPQjVg9XzfFYWpwBaTQ@mail.gmail.com>
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
 drivers/video/console/Kconfig  |   19 ++++-
 drivers/video/console/vgacon.c |  159 +++++++++++++++++++++++++++---------=
----
 2 files changed, 124 insertions(+), 54 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index fe1cd01..05fdc2c 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -43,9 +43,22 @@ config VGACON_SOFT_SCROLLBACK_SIZE
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
+config VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE
+	bool "Persistent Scrollback History for each console"
+	depends on VGACON_SOFT_SCROLLBACK
+	default y
+	help
+	  Say Y here if for each VGA console a scrollback buffer should
+	  be allocated. The scrollback history will persist when switching
+	  between consoles. If you say N here, scrollback is only supported
+	  for the active VGA console and scrollback history will be flushed
+	  when switching between consoles.
+
+	  If you use a RAM-constrained system, say N here.
=20
 config MDA_CONSOLE
 	depends on !M68K && !PARISC && ISA
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 9d8feac..652131d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -181,70 +181,126 @@ static inline void vga_set_mem_top(struct vc_data *c)
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
+};
+static struct vgacon_scrollback_info *vgacon_scrollback_cur;
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE
+static struct vgacon_scrollback_info vgacon_scrollbacks[MAX_NR_CONSOLES];
+#else
+static struct vgacon_scrollback_info vgacon_scrollbacks[1];
+#endif
+
+static void vgacon_scrollback_reset(size_t reset_size)
 {
-	int rows =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
-
-	if (vgacon_scrollback) {
-		vgacon_scrollback_cnt  =3D 0;
-		vgacon_scrollback_tail =3D 0;
-		vgacon_scrollback_cur  =3D 0;
-		vgacon_scrollback_rows =3D rows - 1;
-		vgacon_scrollback_size =3D rows * pitch;
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
+
+		vgacon_scrollback_reset(0);
+	} else {
+		pr_warn("VGAcon: failed to allocate memory for scrollback. Trying to reu=
se previous buffer.\n");
+		/* leave vgacon_scrollback_cur untouched
+		   but reset its content */
+		vgacon_scrollback_reset(size);
 	}
 }
=20
+static void vgacon_switch_scrollback(int vc_num)
+{
+#ifdef CONFIG_VGACON_SOFT_SCROLLBACK_FOR_EACH_CONSOLE
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
+	}
+#endif
+}
+
 static void vgacon_scrollback_startup(void)
 {
-	vgacon_scrollback =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, G=
FP_NOWAIT);
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
-	if (!vgacon_scrollback_size || c->vc_num !=3D fg_console)
+	if (!vgacon_scrollback_cur->data || !vgacon_scrollback_cur->size)
 		return;
=20
 	p =3D (void *) (c->vc_origin + t * c->vc_size_row);
=20
 	while (count--) {
-		scr_memcpyw(vgacon_scrollback + vgacon_scrollback_tail,
+		scr_memcpyw(vgacon_scrollback_cur->data +
+			    vgacon_scrollback_cur->tail,
 			    p, c->vc_size_row);
-		vgacon_scrollback_cnt++;
+
+		vgacon_scrollback_cur->cnt++;
 		p +=3D c->vc_size_row;
-		vgacon_scrollback_tail +=3D c->vc_size_row;
+		vgacon_scrollback_cur->tail +=3D c->vc_size_row;
=20
-		if (vgacon_scrollback_tail >=3D vgacon_scrollback_size)
-			vgacon_scrollback_tail =3D 0;
+		if (vgacon_scrollback_cur->tail >=3D vgacon_scrollback_cur->size)
+			vgacon_scrollback_cur->tail =3D 0;
=20
-		if (vgacon_scrollback_cnt > vgacon_scrollback_rows)
-			vgacon_scrollback_cnt =3D vgacon_scrollback_rows;
+		if (vgacon_scrollback_cur->cnt > vgacon_scrollback_cur->rows)
+			vgacon_scrollback_cur->cnt =3D vgacon_scrollback_cur->rows;
=20
-		vgacon_scrollback_cur =3D vgacon_scrollback_cnt;
+		vgacon_scrollback_cur->cur =3D vgacon_scrollback_cur->cnt;
 	}
 }
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
-	vgacon_scrollback_save =3D 0;
+	vgacon_scrollback_cur->save =3D 0;
=20
-	if (!vga_is_gfx && !vgacon_scrollback_restore) {
+	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ?
 			    vga_vram_size : c->vc_screenbuf_size);
-		vgacon_scrollback_restore =3D 1;
-		vgacon_scrollback_cur =3D vgacon_scrollback_cnt;
+		vgacon_scrollback_cur->restore =3D 1;
+		vgacon_scrollback_cur->cur =3D vgacon_scrollback_cur->cnt;
 	}
 }
=20
@@ -258,41 +314,41 @@ static int vgacon_scrolldelta(struct vc_data *c, int =
lines)
 		return 1;
 	}
=20
-	if (!vgacon_scrollback)
+	if (!vgacon_scrollback_cur->data)
 		return 1;
=20
-	if (!vgacon_scrollback_save) {
+	if (!vgacon_scrollback_cur->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
-		vgacon_scrollback_save =3D 1;
+		vgacon_scrollback_cur->save =3D 1;
 	}
=20
-	vgacon_scrollback_restore =3D 0;
-	start =3D vgacon_scrollback_cur + lines;
+	vgacon_scrollback_cur->restore =3D 0;
+	start =3D vgacon_scrollback_cur->cur + lines;
 	end =3D start + abs(lines);
=20
 	if (start < 0)
 		start =3D 0;
=20
-	if (start > vgacon_scrollback_cnt)
-		start =3D vgacon_scrollback_cnt;
+	if (start > vgacon_scrollback_cur->cnt)
+		start =3D vgacon_scrollback_cur->cnt;
=20
 	if (end < 0)
 		end =3D 0;
=20
-	if (end > vgacon_scrollback_cnt)
-		end =3D vgacon_scrollback_cnt;
+	if (end > vgacon_scrollback_cur->cnt)
+		end =3D vgacon_scrollback_cur->cnt;
=20
-	vgacon_scrollback_cur =3D start;
+	vgacon_scrollback_cur->cur =3D start;
 	count =3D end - start;
-	soff =3D vgacon_scrollback_tail - ((vgacon_scrollback_cnt - end) *
-					 c->vc_size_row);
+	soff =3D vgacon_scrollback_cur->tail -
+		((vgacon_scrollback_cur->cnt - end) * c->vc_size_row);
 	soff -=3D count * c->vc_size_row;
=20
 	if (soff < 0)
-		soff +=3D vgacon_scrollback_size;
+		soff +=3D vgacon_scrollback_cur->size;
=20
-	count =3D vgacon_scrollback_cnt - start;
+	count =3D vgacon_scrollback_cur->cnt - start;
=20
 	if (count > c->vc_rows)
 		count =3D c->vc_rows;
@@ -306,13 +362,13 @@ static int vgacon_scrolldelta(struct vc_data *c, int =
lines)
=20
 		count *=3D c->vc_size_row;
 		/* how much memory to end of buffer left? */
-		copysize =3D min(count, vgacon_scrollback_size - soff);
-		scr_memcpyw(d, vgacon_scrollback + soff, copysize);
+		copysize =3D min(count, vgacon_scrollback_cur->size - soff);
+		scr_memcpyw(d, vgacon_scrollback_cur->data + soff, copysize);
 		d +=3D copysize;
 		count -=3D copysize;
=20
 		if (count) {
-			scr_memcpyw(d, vgacon_scrollback, count);
+			scr_memcpyw(d, vgacon_scrollback_cur->data, count);
 			d +=3D count;
 		}
=20
@@ -327,6 +383,7 @@ static int vgacon_scrolldelta(struct vc_data *c, int li=
nes)
 #define vgacon_scrollback_startup(...) do { } while (0)
 #define vgacon_scrollback_init(...)    do { } while (0)
 #define vgacon_scrollback_update(...)  do { } while (0)
+#define vgacon_switch_scrollback(...)  do { } while (0)
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
@@ -842,7 +899,7 @@ static int vgacon_switch(struct vc_data *c)
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

