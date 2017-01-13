From: =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Date: Fri, 13 Jan 2017 20:07:55 +0000
Subject: [PATCH v10 1/4] console: Move scrollback data into its own struct
Message-Id: <20170113200758.9880-2-manuel.schoelling@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170113200758.9880-1-manuel.schoelling@gmx.de>
In-Reply-To: <20170113200758.9880-1-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, =?UTF-8?q?Manuel=20Sch=C3=B6lling?= <manuel.schoelling@gmx.de>

This refactoring is in preparation for persistent scrollback
support for VGA console.

Signed-off-by: Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>
Reviewed-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Andrey Utkin <andrey_utkin@fastmail.com>
Tested-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/video/console/vgacon.c | 91 ++++++++++++++++++++++----------------=
----
 1 file changed, 47 insertions(+), 44 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index c22a56232b7c..48b97648d4af 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -162,31 +162,34 @@ static inline void vga_set_mem_top(struct vc_data *c)
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
+static struct vgacon_scrollback_info {
+	void *data;
+	int tail;
+	int size;
+	int rows;
+	int cnt;
+	int cur;
+	int save;
+	int restore;
+} vgacon_scrollback;
=20
 static void vgacon_scrollback_init(int pitch)
 {
 	int rows =3D CONFIG_VGACON_SOFT_SCROLLBACK_SIZE * 1024/pitch;
=20
-	if (vgacon_scrollback) {
-		vgacon_scrollback_cnt  =3D 0;
-		vgacon_scrollback_tail =3D 0;
-		vgacon_scrollback_cur  =3D 0;
-		vgacon_scrollback_rows =3D rows - 1;
-		vgacon_scrollback_size =3D rows * pitch;
+	if (vgacon_scrollback.data) {
+		vgacon_scrollback.cnt  =3D 0;
+		vgacon_scrollback.tail =3D 0;
+		vgacon_scrollback.cur  =3D 0;
+		vgacon_scrollback.rows =3D rows - 1;
+		vgacon_scrollback.size =3D rows * pitch;
 	}
 }
=20
 static void vgacon_scrollback_startup(void)
 {
-	vgacon_scrollback =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE, 1024, G=
FP_NOWAIT);
+	vgacon_scrollback.data =3D kcalloc(CONFIG_VGACON_SOFT_SCROLLBACK_SIZE,
+		1024, GFP_NOWAIT);
 	vgacon_scrollback_init(vga_video_num_columns * 2);
 }
=20
@@ -194,38 +197,38 @@ static void vgacon_scrollback_update(struct vc_data *=
c, int t, int count)
 {
 	void *p;
=20
-	if (!vgacon_scrollback_size || c->vc_num !=3D fg_console)
+	if (!vgacon_scrollback.size || c->vc_num !=3D fg_console)
 		return;
=20
 	p =3D (void *) (c->vc_origin + t * c->vc_size_row);
=20
 	while (count--) {
-		scr_memcpyw(vgacon_scrollback + vgacon_scrollback_tail,
+		scr_memcpyw(vgacon_scrollback.data + vgacon_scrollback.tail,
 			    p, c->vc_size_row);
-		vgacon_scrollback_cnt++;
+		vgacon_scrollback.cnt++;
 		p +=3D c->vc_size_row;
-		vgacon_scrollback_tail +=3D c->vc_size_row;
+		vgacon_scrollback.tail +=3D c->vc_size_row;
=20
-		if (vgacon_scrollback_tail >=3D vgacon_scrollback_size)
-			vgacon_scrollback_tail =3D 0;
+		if (vgacon_scrollback.tail >=3D vgacon_scrollback.size)
+			vgacon_scrollback.tail =3D 0;
=20
-		if (vgacon_scrollback_cnt > vgacon_scrollback_rows)
-			vgacon_scrollback_cnt =3D vgacon_scrollback_rows;
+		if (vgacon_scrollback.cnt > vgacon_scrollback.rows)
+			vgacon_scrollback.cnt =3D vgacon_scrollback.rows;
=20
-		vgacon_scrollback_cur =3D vgacon_scrollback_cnt;
+		vgacon_scrollback.cur =3D vgacon_scrollback.cnt;
 	}
 }
=20
 static void vgacon_restore_screen(struct vc_data *c)
 {
-	vgacon_scrollback_save =3D 0;
+	vgacon_scrollback.save =3D 0;
=20
-	if (!vga_is_gfx && !vgacon_scrollback_restore) {
+	if (!vga_is_gfx && !vgacon_scrollback.restore) {
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ?
 			    vga_vram_size : c->vc_screenbuf_size);
-		vgacon_scrollback_restore =3D 1;
-		vgacon_scrollback_cur =3D vgacon_scrollback_cnt;
+		vgacon_scrollback.restore =3D 1;
+		vgacon_scrollback.cur =3D vgacon_scrollback.cnt;
 	}
 }
=20
@@ -239,41 +242,41 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
 lines)
 		return;
 	}
=20
-	if (!vgacon_scrollback)
+	if (!vgacon_scrollback.data)
 		return;
=20
-	if (!vgacon_scrollback_save) {
+	if (!vgacon_scrollback.save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
-		vgacon_scrollback_save =3D 1;
+		vgacon_scrollback.save =3D 1;
 	}
=20
-	vgacon_scrollback_restore =3D 0;
-	start =3D vgacon_scrollback_cur + lines;
+	vgacon_scrollback.restore =3D 0;
+	start =3D vgacon_scrollback.cur + lines;
 	end =3D start + abs(lines);
=20
 	if (start < 0)
 		start =3D 0;
=20
-	if (start > vgacon_scrollback_cnt)
-		start =3D vgacon_scrollback_cnt;
+	if (start > vgacon_scrollback.cnt)
+		start =3D vgacon_scrollback.cnt;
=20
 	if (end < 0)
 		end =3D 0;
=20
-	if (end > vgacon_scrollback_cnt)
-		end =3D vgacon_scrollback_cnt;
+	if (end > vgacon_scrollback.cnt)
+		end =3D vgacon_scrollback.cnt;
=20
-	vgacon_scrollback_cur =3D start;
+	vgacon_scrollback.cur =3D start;
 	count =3D end - start;
-	soff =3D vgacon_scrollback_tail - ((vgacon_scrollback_cnt - end) *
+	soff =3D vgacon_scrollback.tail - ((vgacon_scrollback.cnt - end) *
 					 c->vc_size_row);
 	soff -=3D count * c->vc_size_row;
=20
 	if (soff < 0)
-		soff +=3D vgacon_scrollback_size;
+		soff +=3D vgacon_scrollback.size;
=20
-	count =3D vgacon_scrollback_cnt - start;
+	count =3D vgacon_scrollback.cnt - start;
=20
 	if (count > c->vc_rows)
 		count =3D c->vc_rows;
@@ -287,13 +290,13 @@ static void vgacon_scrolldelta(struct vc_data *c, int=
 lines)
=20
 		count *=3D c->vc_size_row;
 		/* how much memory to end of buffer left? */
-		copysize =3D min(count, vgacon_scrollback_size - soff);
-		scr_memcpyw(d, vgacon_scrollback + soff, copysize);
+		copysize =3D min(count, vgacon_scrollback.size - soff);
+		scr_memcpyw(d, vgacon_scrollback.data + soff, copysize);
 		d +=3D copysize;
 		count -=3D copysize;
=20
 		if (count) {
-			scr_memcpyw(d, vgacon_scrollback, count);
+			scr_memcpyw(d, vgacon_scrollback.data, count);
 			d +=3D count;
 		}
=20
--=20
2.11.0

