From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH] Tile Blitting
Date: 23 Feb 2003 12:42:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045975269.1676.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6VAWOSB0G0FUYbDLGN9+"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18mnxk-0002JF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 22 Feb 2003 20:42:04 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-6VAWOSB0G0FUYbDLGN9+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi James,

If fbcon will support different methods of rasterizing to the
framebuffer, it's best if display->dispsw is revived.  Currently, fbcon
supports classic blitting, but if you decide to add text mode support
(for matroxfb and sbusfb), then tile blitting needs to be supported
too.  Also, rotation will require another method, and so will texture
mapping if you ever decide to add this (Isn't this a bit overkill?!). 
The struct display is not visible to the drivers, so fbcon need to know
which dispsw to use, possibly based on a new field in struct fb_info or
the presence of the function pointer. I prefer an info->caps field so
drivers need not mangle function pointers.

Here's an updated Tile Blitting patch.  The feature is selectable via
kernel configuration (under Advanced Low Level Driver Features). 
Currently, it detects the presence of info->tileops but bit setting
info->caps should be better.

The second patch adds generic tile blitting operation, to be used only
for testing purposes since it's very slow.  It just wraps fb_imageblit
and fb_copyarea.  If anyone wants to test this, just link the driver
cfb_tileops.o, add "info->tileops = &cfb_tileops" during driver
initialization, and enable Tile Blitting support in the kernel.  

Tony

PS: reverse the "accel_putcs() optimazation patch" if applied



--=-6VAWOSB0G0FUYbDLGN9+
Content-Disposition: attachment; filename=tileblit1.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=tileblit1.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/video/console/Kconfig linux-2.5.61/dr=
ivers/video/console/Kconfig
--- linux-2.5.61-fbdev/drivers/video/console/Kconfig	2003-02-16 00:49:23.00=
0000000 +0000
+++ linux-2.5.61/drivers/video/console/Kconfig	2003-02-23 03:19:44.00000000=
0 +0000
@@ -136,6 +136,16 @@
=20
 	  If unsure, say N.
=20
+config FBCON_ADVANCED_TILEBLIT
+	bool "Support for Tile Blitting Operations"
+	depends on FBCON_ADVANCED
+	---help---
+          If you say Y, Tile Blitting support will be added.  Tile blittin=
g is
+          a drawing operation, but its basic operating unit is a bitmap (i=
n
+          contrast to Classic Blitting which operate on pixels).  This is=20
+          necessary for drivers with Text Mode support.
+
+          If unsure, say N.
 # Guess what we need
=20
 config FONT_SUN8x16
diff -Naur linux-2.5.61-fbdev/drivers/video/console/Makefile linux-2.5.61/d=
rivers/video/console/Makefile
--- linux-2.5.61-fbdev/drivers/video/console/Makefile	2003-02-16 00:49:23.0=
00000000 +0000
+++ linux-2.5.61/drivers/video/console/Makefile	2003-02-23 03:19:48.0000000=
00 +0000
@@ -16,6 +16,12 @@
=20
 font-objs +=3D $(font-objs-y)
=20
+fbcon_adv-obj :=3D fbadv.o
+
+fbcon_adv-obj-$(CONFIG_FBCON_ADVANCED_TILEBLIT) +=3D fbcon_tileops.o
+
+fbcon_adv-objs +=3D $(fbcon_adv-obj-y)
+
 # Each configuration option enables a list of files.
=20
 obj-$(CONFIG_DUMMY_CONSOLE)       +=3D dummycon.o
@@ -24,7 +30,7 @@
 obj-$(CONFIG_STI_CONSOLE)         +=3D sticon.o sticore.o
 obj-$(CONFIG_VGA_CONSOLE)         +=3D vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         +=3D mdacon.o
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE) +=3D fbcon.o font.o
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE) +=3D fbcon.o font.o fbcon_adv.o
=20
 obj-$(CONFIG_FB_STI)              +=3D sticore.o
=20
diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61/dr=
ivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-22 02:34:26.00=
0000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon.c	2003-02-23 03:56:01.00000000=
0 +0000
@@ -331,17 +331,120 @@
 	info->fbops->fb_fillrect(info, &region);
 }=09
=20
-#define FB_PIXMAPSIZE 8192
-void accel_putcs(struct vc_data *vc, struct display *p,
-			const unsigned short *s, int count, int yy, int xx)
+static void accel_putc(struct vc_data *vc, struct display *p,
+		       int c, int ypos, int xpos)
 {
 	struct fb_info *info =3D p->fb_info;
 	unsigned short charmask =3D p->charmask;
-	unsigned int width =3D ((vc->vc_font.width + 7)/8);
+	unsigned int width =3D ((vc->vc_font.width + 7) >> 3);
+	struct fb_image image;
+
+	image.dx =3D xpos * vc->vc_font.width;
+	image.dy =3D real_y(p, ypos) * vc->vc_font.height;
+	image.width =3D vc->vc_font.width;
+	image.height =3D vc->vc_font.height;
+	image.fg_color =3D attr_fgcol(p, c);
+	image.bg_color =3D attr_bgcol(p, c);
+	image.depth =3D 0;
+	image.data =3D p->fontdata + (c & charmask) * vc->vc_font.height * width;
+
+	info->fbops->fb_imageblit(info, &image);
+}
+
+#define FB_PIXMAPSIZE 8192
+static void putcs_unaligned(struct vc_data *vc, struct display *p,
+			    struct fb_info *info, struct fb_image *image,=20
+			    int count, const unsigned short *s)
+{
+	unsigned int width =3D (vc->vc_font.width + 7)/8;
 	unsigned int cellsize =3D vc->vc_font.height * width;
+	unsigned int maxcnt =3D FB_PIXMAPSIZE/cellsize;
+	unsigned int pitch, cnt, i, j, k;
+	unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
+	unsigned int shift_high =3D 8;
+	unsigned int idx =3D vc->vc_font.width/8;
+	unsigned short charmask =3D p->charmask;
+	u8 mask, *src, *dst, *dst0;
+=09
+	while (count) {
+		if (count > maxcnt)=20
+			cnt =3D k =3D maxcnt;
+		else
+			cnt =3D k =3D count;
+	=09
+		dst0 =3D (u8 *) image->data;
+		image->width =3D vc->vc_font.width * cnt;
+		pitch =3D (image->width + 7)/8;
+		while (k--) {
+			src =3D p->fontdata + (scr_readw(s++) & charmask) * cellsize;
+			dst =3D dst0;
+			mask =3D (u8) (0xfff << shift_high);
+			for (i =3D image->height; i--; ) {
+				for (j =3D 0; j < idx; j++) {
+					dst[j] &=3D mask;
+					dst[j] |=3D *src >> shift_low;
+					dst[j+1] =3D *src << shift_high;
+					src++;
+				}
+				dst[idx] &=3D mask;
+				dst[idx] |=3D *src++ >> shift_low;
+				dst +=3D pitch;
+			}
+			shift_low +=3D mod;
+			shift_low &=3D 7;
+			shift_high =3D 8 - shift_low;
+			dst0 +=3D (shift_low) ? width - 1 : width;
+		}
+	=09
+		info->fbops->fb_imageblit(info, image);
+		image->dx +=3D cnt * vc->vc_font.width;
+		count -=3D cnt;
+	}
+}
+
+static void putcs_aligned(struct vc_data *vc, struct display *p,
+			  struct fb_info *info, struct fb_image *image,=20
+			  int count, const unsigned short *s)
+{
+	unsigned int width =3D (vc->vc_font.width + 7)/8;
+	unsigned int cellsize =3D vc->vc_font.height * width;
+	unsigned int maxcnt =3D FB_PIXMAPSIZE/cellsize;
+	unsigned int pitch, cnt, i, j, k;
+	unsigned short charmask =3D p->charmask;
+	u8 *src, *dst, *dst0;
+
+	while (count) {
+		if (count > maxcnt)
+			cnt =3D k =3D maxcnt;
+		else
+			cnt =3D k =3D count;
+		dst0 =3D (u8 *) image->data;
+		pitch =3D width *cnt;
+		image->width =3D vc->vc_font.width * cnt;
+		while (k--) {
+			src =3D p->fontdata + (scr_readw(s++) & charmask) * cellsize;
+			dst =3D dst0;
+			for (i =3D image->height; i--; ) {
+				for (j =3D 0; j < width; j++)=20
+					dst[j] =3D *src++;
+				dst +=3D pitch;
+			}
+			dst0 +=3D width;
+		}
+	=09
+		info->fbops->fb_imageblit(info, image);
+		image->dx +=3D cnt * vc->vc_font.width;
+		count -=3D cnt;
+	}
+}
+
+static void accel_putcs(struct vc_data *vc, struct display *p,
+			const unsigned short *s, int count, int yy, int xx)
+{
+	static u8 pixmap[FB_PIXMAPSIZE];
+	struct fb_info *info =3D p->fb_info;
 	struct fb_image image;
 	u16 c =3D scr_readw(s);
-	static u8 pixmap[FB_PIXMAPSIZE];
 =09
 	image.fg_color =3D attr_fgcol(p, c);
 	image.bg_color =3D attr_bgcol(p, c);
@@ -349,47 +452,12 @@
 	image.dy =3D yy * vc->vc_font.height;
 	image.height =3D vc->vc_font.height;
 	image.depth =3D 0;
+	image.data =3D pixmap;
=20
-	if (!(vc->vc_font.width & 7)) {
-		unsigned int pitch, cnt, i, j, k;
-		unsigned int maxcnt =3D FB_PIXMAPSIZE/cellsize;
-		char *src, *dst, *dst0;
-
-		image.data =3D pixmap;
-		while (count) {
-			if (count > maxcnt)=20
-				cnt =3D k =3D maxcnt;
-			else
-				cnt =3D k =3D count;
-		=09
-			dst0 =3D pixmap;
-			pitch =3D width * cnt;
-			image.width =3D vc->vc_font.width * cnt;
-			while (k--) {
-				src =3D p->fontdata + (scr_readw(s++)&charmask)*
-					cellsize;
-				dst =3D dst0;
-				for (i =3D image.height; i--; ) {
-					for (j =3D 0; j < width; j++)=20
-						dst[j] =3D *src++;
-					dst +=3D pitch;
-				}
-				dst0 +=3D width;
-			}
-
-			info->fbops->fb_imageblit(info, &image);
-			image.dx +=3D cnt * vc->vc_font.width;
-			count -=3D cnt;
-		}
-	} else {
-		image.width =3D vc->vc_font.width;
-		while (count--) {
-			image.data =3D p->fontdata +=20
-				(scr_readw(s++) & charmask) * cellsize;
-			info->fbops->fb_imageblit(info, &image);
-			image.dx +=3D vc->vc_font.width;
-		}=09
-	}
+	if (!(vc->vc_font.width & 7))=20
+		putcs_aligned(vc, p, info, &image, count, s);
+	else=20
+		putcs_unaligned(vc, p, info, &image, count, s);
 }
=20
 void accel_clear_margins(struct vc_data *vc, struct display *p,
@@ -424,7 +492,15 @@
 	}=09
 }=09
=20
-void accel_cursor(struct display *p, int flags, int xx, int yy)
+static struct display_switch accel_switch =3D {
+	.bmove =3D         accel_bmove,
+	.clear =3D         accel_clear,
+	.putc =3D          accel_putc,
+	.putcs =3D         accel_putcs,
+	.clear_margins =3D accel_clear_margins,
+};
+
+void fb_cursor(struct display *p, int flags, int xx, int yy)
 {
 	static char mask[64], image[64], *dest;
 	struct vc_data *vc =3D p->conp;
@@ -743,6 +819,13 @@
 	int i, charcnt =3D 256;
 	struct font_desc *font;
=20
+#ifdef CONFIG_FBCON_ADVANCED_TILEBLIT
+	if (info->tileops)
+		p->dispsw =3D &tile_switch;
+	else=20
+#endif
+		p->dispsw =3D &accel_switch;
+
 	if (con !=3D fg_console || (info->flags & FBINFO_FLAG_MODULE) ||
 	    info->fix.type =3D=3D FB_TYPE_TEXT)
 		logo =3D 0;
@@ -880,7 +963,7 @@
 			vc_resize(con, nr_cols, nr_rows);
 		else if (CON_IS_VISIBLE(vc) &&
 			 vt_cons[vc->vc_num]->vc_mode =3D=3D KD_TEXT) {
-			accel_clear_margins(vc, p, 0);
+			p->dispsw->clear_margins(vc, p, 0);
 			update_screen(con);
 		}
 		if (save) {
@@ -977,11 +1060,11 @@
 	y_break =3D p->vrows - p->yscroll;
 	if (sy < y_break && sy + height - 1 >=3D y_break) {
 		u_int b =3D y_break - sy;
-		accel_clear(vc, p, real_y(p, sy), sx, b, width);
-		accel_clear(vc, p, real_y(p, sy + b), sx, height - b,
+		p->dispsw->clear(vc, p, real_y(p, sy), sx, b, width);
+		p->dispsw->clear(vc, p, real_y(p, sy + b), sx, height - b,
 				 width);
 	} else
-		accel_clear(vc, p, real_y(p, sy), sx, height, width);
+		p->dispsw->clear(vc, p, real_y(p, sy), sx, height, width);
=20
 	if (redraw_cursor)
 		vbl_cursor_cnt =3D CURSOR_DRAW_DELAY;
@@ -991,10 +1074,6 @@
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
 	struct display *p =3D &fb_display[vc->vc_num];
-	struct fb_info *info =3D p->fb_info;
-	unsigned short charmask =3D p->charmask;
-	unsigned int width =3D ((vc->vc_font.width + 7) >> 3);
-	struct fb_image image;
 	int redraw_cursor =3D 0;
=20
 	if (!p->can_soft_blank && console_blanked)
@@ -1008,16 +1087,7 @@
 		redraw_cursor =3D 1;
 	}
=20
-	image.fg_color =3D attr_fgcol(p, c);
-	image.bg_color =3D attr_bgcol(p, c);
-	image.dx =3D xpos * vc->vc_font.width;
-	image.dy =3D real_y(p, ypos) * vc->vc_font.height;
-	image.width =3D vc->vc_font.width;
-	image.height =3D vc->vc_font.height;
-	image.depth =3D 1;
-	image.data =3D p->fontdata + (c & charmask) * vc->vc_font.height * width;
-
-	info->fbops->fb_imageblit(info, &image);
+	p->dispsw->putc(vc, p, c, real_y(p, ypos), xpos);
=20
 	if (redraw_cursor)
 		vbl_cursor_cnt =3D CURSOR_DRAW_DELAY;
@@ -1042,7 +1112,7 @@
 		cursor_undrawn();
 		redraw_cursor =3D 1;
 	}
-	accel_putcs(vc, p, s, count, real_y(p, ypos), xpos);
+	p->dispsw->putcs(vc, p, s, count, real_y(p, ypos), xpos);
 	if (redraw_cursor)
 		vbl_cursor_cnt =3D CURSOR_DRAW_DELAY;
 }
@@ -1070,7 +1140,7 @@
=20
 	cursor_on =3D 0;
 	if (cursor_drawn)
-		accel_cursor(p, 0, p->cursor_x,
+		fb_cursor(p, 0, p->cursor_x,
 				  real_y(p, p->cursor_y));
=20
 	p->cursor_x =3D vc->vc_x;
@@ -1084,7 +1154,7 @@
 	case CM_MOVE:
 	case CM_DRAW:
 		if (cursor_drawn)
-			accel_cursor(p, FB_CUR_SETCUR, p->cursor_x,
+			fb_cursor(p, FB_CUR_SETCUR, p->cursor_x,
 					  real_y(p, p->cursor_y));
 		vbl_cursor_cnt =3D CURSOR_DRAW_DELAY;
 		cursor_on =3D 1;
@@ -1106,7 +1176,7 @@
 		flag =3D 0;
 		if (!cursor_drawn)
 			flag =3D FB_CUR_SETCUR;
-		accel_cursor(p, flag, p->cursor_x,
+		fb_cursor(p, flag, p->cursor_x,
 				  real_y(p, p->cursor_y));
 		cursor_drawn ^=3D 1;
 		vbl_cursor_cnt =3D cursor_blink_rate;
@@ -1168,7 +1238,7 @@
=20
 	p->yscroll +=3D count;
 	if (p->yscroll > p->vrows - vc->vc_rows) {
-		accel_bmove(p, p->vrows - vc->vc_rows, 0, 0, 0,
+		p->dispsw->bmove(p, p->vrows - vc->vc_rows, 0, 0, 0,
 				 vc->vc_rows, vc->vc_cols);
 		p->yscroll -=3D p->vrows - vc->vc_rows;
 	}
@@ -1176,7 +1246,7 @@
 	info->var.yoffset =3D p->yscroll * vc->vc_font.height;
 	info->var.vmode &=3D ~FB_VMODE_YWRAP;
 	update_var(vc->vc_num, info);
-	accel_clear_margins(vc, p, 1);
+	p->dispsw->clear_margins(vc, p, 1);
 	scrollback_max +=3D count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max =3D scrollback_phys_max;
@@ -1191,7 +1261,7 @@
=20
 	p->yscroll -=3D count;
 	if (p->yscroll < 0) {
-		accel_bmove(p, 0, 0, p->vrows - vc->vc_rows, 0,
+		p->dispsw->bmove(p, 0, 0, p->vrows - vc->vc_rows, 0,
 				 vc->vc_rows, vc->vc_cols);
 		p->yscroll +=3D p->vrows - vc->vc_rows;
 	}
@@ -1199,7 +1269,7 @@
 	info->var.yoffset =3D p->yscroll * vc->vc_font.height;
 	info->var.vmode &=3D ~FB_VMODE_YWRAP;
 	update_var(vc->vc_num, info);
-	accel_clear_margins(vc, p, 1);
+	p->dispsw->clear_margins(vc, p, 1);
 	scrollback_max -=3D count;
 	if (scrollback_max < 0)
 		scrollback_max =3D 0;
@@ -1265,7 +1335,7 @@
 			if (attr !=3D (c & 0xff00)) {
 				attr =3D c & 0xff00;
 				if (s > start) {
-					accel_putcs(vc, p, start,
+					p->dispsw->putcs(vc, p, start,
 							 s - start,
 							 real_y(p, line),
 							 x);
@@ -1275,7 +1345,7 @@
 			}
 			if (c =3D=3D scr_readw(d)) {
 				if (s > start) {
-					accel_putcs(vc, p, start,
+					p->dispsw->putcs(vc, p, start,
 							 s - start,
 							 real_y(p, line),
 							 x);
@@ -1290,7 +1360,7 @@
 			d++;
 		} while (s < le);
 		if (s > start)
-			accel_putcs(vc, p, start, s - start,
+			p->dispsw->putcs(vc, p, start, s - start,
 					 real_y(p, line), x);
 		line++;
 		if (d =3D=3D (u16 *) softback_end)
@@ -1323,7 +1393,7 @@
 			if (attr !=3D (c & 0xff00)) {
 				attr =3D c & 0xff00;
 				if (s > start) {
-					accel_putcs(vc, p, start,
+					p->dispsw->putcs(vc, p, start,
 							 s - start,
 							 real_y(p, line),
 							 x);
@@ -1333,7 +1403,7 @@
 			}
 			if (c =3D=3D scr_readw(d)) {
 				if (s > start) {
-					accel_putcs(vc, p, start,
+					p->dispsw->putcs(vc, p, start,
 							 s - start,
 							 real_y(p, line),
 							 x);
@@ -1350,7 +1420,7 @@
 			d++;
 		} while (s < le);
 		if (s > start)
-			accel_putcs(vc, p, start, s - start,
+			p->dispsw->putcs(vc, p, start, s - start,
 					 real_y(p, line), x);
 		console_conditional_schedule();
 		if (offset > 0)
@@ -1420,9 +1490,9 @@
 			goto redraw_up;
 		switch (p->scrollmode & __SCROLL_YMASK) {
 		case __SCROLL_YMOVE:
-			accel_bmove(p, t + count, 0, t, 0,
+			p->dispsw->bmove(p, t + count, 0, t, 0,
 					 b - t - count, vc->vc_cols);
-			accel_clear(vc, p, b - count, 0, count,
+			p->dispsw->clear(vc, p, b - count, 0, count,
 					 vc->vc_cols);
 			break;
=20
@@ -1471,7 +1541,7 @@
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
-			accel_clear(vc, p, real_y(p, b - count), 0,
+			p->dispsw->clear(vc, p, real_y(p, b - count), 0,
 					 count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
@@ -1487,9 +1557,9 @@
 			count =3D vc->vc_rows;
 		switch (p->scrollmode & __SCROLL_YMASK) {
 		case __SCROLL_YMOVE:
-			accel_bmove(p, t, 0, t + count, 0,
+			p->dispsw->bmove(p, t, 0, t + count, 0,
 					 b - t - count, vc->vc_cols);
-			accel_clear(vc, p, t, 0, count, vc->vc_cols);
+			p->dispsw->clear(vc, p, t, 0, count, vc->vc_cols);
 			break;
=20
 		case __SCROLL_YWRAP:
@@ -1536,7 +1606,7 @@
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
 				     -count * vc->vc_cols);
-			accel_clear(vc, p, real_y(p, t), 0, count,
+			p->dispsw->clear(vc, p, real_y(p, t), 0, count,
 					 vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
@@ -1615,7 +1685,7 @@
 		}
 		return;
 	}
-	accel_bmove(p, real_y(p, sy), sx, real_y(p, dy), dx, height,
+	p->dispsw->bmove(p, real_y(p, sy), sx, real_y(p, dy), dx, height,
 			 width);
 }
=20
@@ -1643,8 +1713,8 @@
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		var.activate =3D FB_ACTIVATE_NOW;
 		fb_set_var(&var, info);
-		p->vrows =3D info->var.yres_virtual/fh;
 	}
+	p->vrows =3D info->var.yres_virtual/fh;
 	return 0;
 }
=20
@@ -1654,6 +1724,13 @@
 	struct display *p =3D &fb_display[unit];
 	struct fb_info *info =3D p->fb_info;
=20
+#ifdef CONFIG_FBCON_ADVANCED_TILEBLIT
+	if (info->tileops)
+		p->dispsw =3D &tile_switch;
+	else
+#endif
+		p->dispsw =3D &accel_switch;
+
 	if (softback_top) {
 		int l =3D fbcon_softback_size / vc->vc_size_row;
 		if (softback_lines)
@@ -1679,6 +1756,9 @@
 	}
 	if (info)
 		info->var.yoffset =3D p->yscroll =3D 0;
+
+        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 		scrollback_phys_max =3D p->vrows - vc->vc_rows;
@@ -1695,14 +1775,39 @@
 	scrollback_max =3D 0;
 	scrollback_current =3D 0;
=20
+#ifdef CONFIG_FBCON_ADVANCED_TILEBLIT
+	if (info->tileops) {
+		struct fb_tiledata tile;
+		int err, cnt, size;
+		u8 *tiledata;
+
+		cnt =3D FNTCHARCNT(p->fontdata);
+		if (!cnt)
+			cnt =3D 256;
+		size =3D vc->vc_font.height * ((vc->vc_font.width + 7)/8) * cnt;=20
+		tiledata =3D kmalloc(size, GFP_KERNEL);
+		if (tiledata =3D=3D NULL)
+			return 0;
+		memcpy(tiledata, p->fontdata, size);
+		tile.tile.width =3D vc->vc_font.width;
+		tile.tile.height =3D vc->vc_font.height;
+		tile.tile.depth =3D 1;
+		tile.len =3D cnt;
+		tile.data =3D tiledata;=20
+		err =3D info->tileops->fb_loadtiles(info, &tile);
+		kfree(tiledata);
+
+		if (err) return 0;
+	}
+#endif
+
 	info->currcon =3D unit;
 =09
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	update_var(unit, info);
 	fbcon_set_palette(vc, color_table); =09
=20
 	if (vt_cons[unit]->vc_mode =3D=3D KD_TEXT)
-		accel_clear_margins(vc, p, 0);
+		p->dispsw->clear_margins(vc, p, 0);
 	if (logo_shown =3D=3D -2) {
 		logo_shown =3D fg_console;
 		/* This is protected above by initmem_freed */
@@ -1737,18 +1842,18 @@
 			height =3D vc->vc_rows;
 			y_break =3D p->vrows - p->yscroll;
 			if (height > y_break) {
-				accel_clear(vc, p,
+				p->dispsw->clear(vc, p,
 						 real_y(p, 0), 0,
 						 y_break,
 						 vc->vc_cols);
-				accel_clear(vc, p,
+				p->dispsw->clear(vc, p,
 						 real_y(p,
 						y_break),
 						0,
 						 height - y_break,
 						 vc->vc_cols);
 			} else
-				accel_clear(vc, p,
+				p->dispsw->clear(vc, p,
 						 real_y(p, 0), 0,
 						 height,
 						 vc->vc_cols);
@@ -1913,6 +2018,29 @@
=20
 	}
=20
+#ifdef CONFIG_FBCON_ADVANCED_TILEBLIT
+	if (info->tileops) {
+		struct fb_tiledata tile;
+		int err, size;
+		u8 *tiledata;
+	=09
+		size =3D vc->vc_font.height * ((vc->vc_font.width + 7)/8) * cnt;=20
+		tiledata =3D kmalloc(size, GFP_KERNEL);
+		if (tiledata =3D=3D NULL)
+			return 1;
+		memcpy(tiledata, p->fontdata, size);
+		tile.tile.width =3D vc->vc_font.width;
+		tile.tile.height =3D vc->vc_font.height;
+		tile.tile.depth =3D 1;
+		tile.len =3D cnt;
+		tile.data =3D tiledata;
+	=09
+		err =3D info->tileops->fb_loadtiles(info, &tile);
+		kfree(tiledata);
+		if (err) return err;
+	}
+#endif
+
 	if (resize) {
 		/* reset wrap/pan */
 		info->var.xoffset =3D info->var.yoffset =3D p->yscroll =3D 0;
@@ -1935,7 +2063,7 @@
 		}
 	} else if (CON_IS_VISIBLE(vc)
 		   && vt_cons[vc->vc_num]->vc_mode =3D=3D KD_TEXT) {
-		accel_clear_margins(vc, p, 0);
+		p->dispsw->clear_margins(vc, p, 0);
 		update_screen(vc->vc_num);
 	}
=20
diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.h linux-2.5.61/dr=
ivers/video/console/fbcon.h
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.h	2003-02-22 02:34:26.00=
0000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon.h	2003-02-23 03:20:58.00000000=
0 +0000
@@ -46,6 +46,20 @@
     unsigned int fontwidthmask;      /* 1 at (1 << (width - 1)) if width i=
s supported */
 };
=20
+struct display_switch {
+	void (*bmove)(struct display *p, int sy, int sx,=20
+		      int dy, int dx, int height, int width);
+	void (*clear)(struct vc_data *vc, struct display *p, int sy,
+		      int sx, int height, int width);
+	void (*putcs)(struct vc_data *vc, struct display *p,
+		      const unsigned short *s, int count,=20
+		      int yy, int xx);
+	void (*putc)(struct vc_data *vc, struct display *p,=20
+		     int c, int ypos, int xpos);
+	void (*clear_margins)(struct vc_data *vc, struct display *p,
+			      int bottom_only);
+};
+
 /* drivers/video/console/fbcon.c */
 extern struct display fb_display[MAX_NR_CONSOLES];
 extern char con2fb_map[MAX_NR_CONSOLES];
@@ -120,5 +134,6 @@
 #define SCROLL_YNOPARTIAL	__SCROLL_YNOPARTIAL
=20
 extern int fb_console_init(void);
+extern struct display_switch tile_switch;
=20
 #endif /* _VIDEO_FBCON_H */
diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon_tileops.c linux-2=
.5.61/drivers/video/console/fbcon_tileops.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon_tileops.c	1970-01-01 00:=
00:00.000000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon_tileops.c	2003-02-23 03:21:47.=
000000000 +0000
@@ -0,0 +1,118 @@
+/*
+ *  linux/drivers/video/fbcon_tileops.c -- Console Ops using Tile Blitting
+ *                                         (ie. Text Mode support)
+ *
+ *	Copyright (C) 2003 James Simmons
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License.  See the file COPYING in the main directory of this archive f=
or
+ *  more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/fb.h>
+#include "fbcon.h"
+
+static void tile_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		       int height, int width)
+{
+	struct fb_info *info =3D p->fb_info;
+	struct fb_tilecopy tilerect;
+
+	tilerect.sx =3D sx;
+	tilerect.sy =3D sy;
+	tilerect.dx =3D dx;
+	tilerect.dy =3D dy;
+	tilerect.height =3D height;
+	tilerect.width =3D width;
+=09
+	info->tileops->fb_tilecopy(info, &tilerect);
+}
+
+static void tile_clear(struct vc_data *vc, struct display *p, int sy,
+		       int sx, int height, int width)
+{
+	struct fb_info *info =3D p->fb_info;
+	struct fb_tilefill tilerect;
+=09
+	tilerect.dx =3D sx;
+	tilerect.dy =3D sy;
+	tilerect.width =3D width;
+	tilerect.height =3D height;
+	tilerect.fg_color =3D attr_fgcol_ec(p, vc);
+	tilerect.bg_color =3D attr_bgcol_ec(p, vc);
+	tilerect.idx =3D vc->vc_video_erase_char & p->charmask;
+	tilerect.rop =3D ROP_COPY;
+
+	info->tileops->fb_tilefill(info, &tilerect);
+}
+
+static void tile_putc(struct vc_data *vc, struct display *p,
+		      int c, int ypos, int xpos)
+{
+	struct fb_info *info =3D p->fb_info;
+	struct fb_tileblit tilerect;
+	u32 font =3D c & p->charmask;
+=09
+	tilerect.dx =3D xpos;
+	tilerect.dy =3D ypos;
+	tilerect.width =3D 1;
+	tilerect.height =3D 1;
+	tilerect.fg_color =3D attr_fgcol(p, c);
+	tilerect.bg_color =3D attr_bgcol(p, c);
+	tilerect.data =3D &font;
+
+	info->tileops->fb_tileblit(info, &tilerect);
+}
+
+#define TILEMAP_SIZE 1024
+static void tile_putcs(struct vc_data *vc, struct display *p,
+			const unsigned short *s, int count,=20
+			int yy, int xx)
+{
+	static u32 tilemap[TILEMAP_SIZE];
+	struct fb_info *info =3D p->fb_info;
+	struct fb_tileblit tilerect;
+	int maxcnt =3D TILEMAP_SIZE, i, cnt;
+	u16 c =3D scr_readw(s);
+
+	tilerect.dx =3D xx;
+	tilerect.dy =3D yy;
+	tilerect.height =3D 1;
+	tilerect.fg_color =3D attr_fgcol(p, c);
+	tilerect.bg_color =3D attr_bgcol(p, c);
+	tilerect.data =3D tilemap;
+
+	while (count) {
+		cnt =3D (count > maxcnt) ? maxcnt : count;
+		tilerect.width =3D cnt;
+		for (i =3D 0; i < cnt; i++)=20
+			tilemap[i] =3D (u32) (scr_readw(s++) & p->charmask);
+	=09
+		info->tileops->fb_tileblit(info, &tilerect);
+		tilerect.dx +=3D cnt;
+		count -=3D cnt;
+	}
+}
+
+static void tile_clear_margins(struct vc_data *vc, struct display *p,
+			       int bottom_only)
+{
+	/* Not used */
+	return;
+}
+
+struct display_switch tile_switch =3D {
+	.bmove =3D         tile_bmove,
+	.clear =3D         tile_clear,
+	.putc  =3D         tile_putc,
+	.putcs =3D         tile_putcs,
+	.clear_margins =3D tile_clear_margins,
+};
+
+EXPORT_SYMBOL(tile_switch);
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>, "
+	      "Antonino Daplas <adaplas@pol.net>");
+MODULE_DESCRIPTION("Console Tile Blitting Ops");
+MODULE_LICENSE("GPL");
diff -Naur linux-2.5.61-fbdev/drivers/video/fbmem.c linux-2.5.61/drivers/vi=
deo/fbmem.c
--- linux-2.5.61-fbdev/drivers/video/fbmem.c	2003-02-22 02:34:26.000000000 =
+0000
+++ linux-2.5.61/drivers/video/fbmem.c	2003-02-23 04:13:57.000000000 +0000
@@ -363,14 +363,14 @@
 static int ofonly __initdata =3D 0;
 #endif
=20
+#ifdef CONFIG_LOGO
+#include <linux/linux_logo.h>
+
 static inline unsigned safe_shift(unsigned d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
 }
=20
-#ifdef CONFIG_FB_LOGO
-#include <linux/linux_logo.h>
-
 static void __init fb_set_logocmap(struct fb_info *info,
 				   const struct linux_logo *logo)
 {
diff -Naur linux-2.5.61-fbdev/include/linux/fb.h linux-2.5.61/include/linux=
/fb.h
--- linux-2.5.61-fbdev/include/linux/fb.h	2003-02-22 02:34:26.000000000 +00=
00
+++ linux-2.5.61/include/linux/fb.h	2003-02-23 03:19:50.000000000 +0000
@@ -380,6 +380,77 @@
     int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area=
_struct *vma);
 };
=20
+/*=20
+ * Tile Blitting Support
+ *=20
+ * In Tile Blitting, the basic unit is a Tile which is a bitmap with
+ * a predefined width and height, and optionally, other properties
+ * such as color depth, spacing, transparency,  etc.  For now, we'll=20
+ * just support width, height, and color depth.
+ *=20
+ * All operations are analogous to classic blitting operations which
+ * use pixels as the basic unit.  Instead of pixels, it will use tiles,
+ * instead of info->pseudo_palette, it will use tiledata, etc.
+ */
+
+struct fb_tile {
+	__u32 width;            /* tile width in pixels */
+	__u32 height;           /* tile height in scanlines */
+	__u32 depth;            /* pixel depth */
+};
+
+struct fb_tiledata {
+	struct fb_tile tile;    /* tile properties */
+	__u32 len;              /* number of tiles in the map */
+	__u8  *data;            /* packed tile data */
+};
+
+struct fb_tileblit {
+	__u32 dx;               /* destination x origin, in tiles */
+	__u32 dy;               /* destination y origin, in tiles */
+	__u32 width;            /* destination window width, in tiles */
+	__u32 height;           /* destination window height, in tiles */
+	__u32 fg_color;         /* fg_color if monochrome */
+	__u32 bg_color;         /* bg_color if monochrome */
+	__u32 *data;            /* tile map - array of indices to tiledata */
+};
+
+struct fb_tilecopy {
+	__u32 dx;               /* destination window origin... */
+	__u32 dy;               /* in tiles */
+	__u32 width;            /* destination width, in tiles */
+	__u32 height;           /* destination height, in tiles */
+	__u32 sx;               /* source window origin ... */
+	__u32 sy;               /* in tiles */
+};
+
+struct fb_tilefill {
+	__u32 dx;               /* destination window origin ... */
+	__u32 dy;               /* in tiles */
+	__u32 width;            /* destination width in tiles */
+	__u32 height;           /* destination height in tiles */
+	__u32 fg_color;         /* fg_color if monochrome */
+	__u32 bg_color;         /* bg_color if monochrome */
+	__u32 rop;              /* rop operation */
+	__u32 idx;              /* index to current tiledata */
+};
+
+struct fb_tileops {
+    /* upload tile data to driver and make it current... the driver
+     * must copy the contents of tiledata.data, not just the pointer to it=
 */
+    int (*fb_loadtiles)(struct fb_info *info,=20
+			const struct fb_tiledata *tileinfo);
+    /* blit tiles to destination from a tilemap */
+    void (*fb_tileblit)(struct fb_info *info,=20
+			const struct fb_tileblit *tilemap);
+    /* copy tiles from one region of fb memory to another */
+    void (*fb_tilecopy)(struct fb_info *info, const struct fb_tilecopy *ar=
ea);
+    /* fill a region of fb memory with a tile */
+    void (*fb_tilefill)(struct fb_info *info,=20
+			const struct fb_tilefill *region);
+    /* If driver is to support tile blitting, all hooks above are required=
 */
+};
+
 struct fb_info {
    kdev_t node;
    int flags;
@@ -391,6 +462,7 @@
    struct fb_cursor cursor;		/* Current cursor */=09
    struct fb_cmap cmap;                 /* Current cmap */
    struct fb_ops *fbops;
+   struct fb_tileops *tileops;          /* Tile blitting */
    char *screen_base;                   /* Virtual address */
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */=09

--=-6VAWOSB0G0FUYbDLGN9+
Content-Disposition: attachment; filename=cfb_tileops.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=cfb_tileops.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/cfb_tileops.c linux-2.5.61/cfb_tileops.c
--- linux-2.5.61-fbdev/cfb_tileops.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.5.61/cfb_tileops.c	2003-02-23 04:17:36.000000000 +0000
@@ -0,0 +1,130 @@
+/*
+ *  Generic TileBLT function for frame buffer with packed pixels of any de=
pth.
+ *
+ *      Copyright (C)  June 1999 James Simmons
+ *
+ *  This file is subject to the terms and conditions of the GNU General Pu=
blic
+ *  License.  See the file COPYING in the main directory of this archive f=
or
+ *  more details.
+ *
+ * NOTES:
+ *
+ *  This is a test program to implement Tile Blitting using classical blit=
ting
+ *  routines.  This is naturally slower, so don't use this for your defaul=
t
+ *  operations.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <asm/types.h>
+
+static struct fb_tiledata cfb_tileinfo;
+static u8 *cfb_tiledata =3D NULL;
+
+static int cfb_loadtiles(struct fb_info *info,=20
+			 const struct fb_tiledata *tileinfo)
+{
+	u32 size =3D (tileinfo->tile.width + 7)/8 * tileinfo->tile.height;
+
+	size *=3D tileinfo->len;
+	if (cfb_tiledata) {
+		if (info->fbops->fb_sync)
+			info->fbops->fb_sync(info);
+		kfree(cfb_tiledata);
+		cfb_tiledata =3D NULL;
+	}
+		=09
+	cfb_tiledata =3D kmalloc(size, GFP_KERNEL);
+	if (cfb_tiledata =3D=3D NULL)
+		return 1;
+	cfb_tileinfo =3D *tileinfo;
+	cfb_tileinfo.data =3D cfb_tiledata;
+	memcpy(cfb_tiledata, tileinfo->data, size);
+
+	return 0;
+}
+
+static void cfb_tileblit(struct fb_info *info,=20
+			 const struct fb_tileblit *tilemap)
+{
+	struct fb_image image;
+	u32 width =3D cfb_tileinfo.tile.width;
+	u32 height =3D cfb_tileinfo.tile.height;
+	u32 cellsize =3D (width + 7)/8 * height;
+	int i;
+
+	image.dx =3D tilemap->dx * width;
+	image.dy =3D tilemap->dy * height;
+	image.width =3D width;
+	image.height =3D tilemap->height * height;
+	image.fg_color =3D tilemap->fg_color;
+	image.bg_color =3D tilemap->bg_color;
+	image.depth =3D 0;
+
+	for (i =3D 0; i < tilemap->width; i++) {
+		image.data =3D cfb_tileinfo.data + (tilemap->data[i] * cellsize);
+		info->fbops->fb_imageblit(info, &image);
+		image.dx +=3D width;
+	}
+}
+
+static void cfb_tilefill(struct fb_info *info,=20
+			 const struct fb_tilefill *tilerect)
+{
+	struct fb_image image;
+	u32 width =3D cfb_tileinfo.tile.width;
+	u32 height =3D cfb_tileinfo.tile.height;
+	u32 dx, dy, i, j;
+
+	dx =3D tilerect->dx * width;
+	dy =3D tilerect->dy * height;
+	image.width =3D width;
+	image.height =3D height;
+	image.fg_color =3D tilerect->fg_color;
+	image.bg_color =3D tilerect->bg_color;
+	image.data =3D cfb_tileinfo.data +=20
+		tilerect->idx * ((width + 7)/8 * height);
+	image.depth =3D 0;
+
+	for (i =3D 0; i < tilerect->height; i++) {
+		image.dy =3D dy;
+		for (j =3D 0; j < tilerect->width; j++) {
+			image.dx =3D dx;
+			info->fbops->fb_imageblit(info, &image);
+			dx +=3D width;
+		}
+		dy +=3D height;
+	}
+}
+
+static void cfb_tilecopy(struct fb_info *info, const struct fb_tilecopy *t=
ileregion)
+{
+	struct fb_copyarea area;
+	u32 width =3D cfb_tileinfo.tile.width;
+	u32 height =3D cfb_tileinfo.tile.height;
+
+	area.dx =3D tileregion->dx * width;
+	area.dy =3D tileregion->dy * height;
+	area.sx =3D tileregion->sx * width;
+	area.sy =3D tileregion->sy * height;
+	area.width =3D tileregion->width * width;
+	area.height =3D tileregion->height * height;
+
+	info->fbops->fb_copyarea(info, &area);
+}
+
+struct fb_tileops cfb_tileops =3D {
+	.fb_loadtiles =3D cfb_loadtiles,
+	.fb_tileblit  =3D cfb_tileblit,
+	.fb_tilecopy  =3D cfb_tilecopy,
+	.fb_tilefill  =3D cfb_tilefill,
+};
+
+EXPORT_SYMBOL(cfb_tileops);
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>, "
+	      "Antonino Daplas <adaplas@pol.net>");
+MODULE_DESCRIPTION("Low Level Tile Blitting Ops");
+MODULE_LICENSE("GPL");
+
+ =09

--=-6VAWOSB0G0FUYbDLGN9+--




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
