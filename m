From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH 2/5]: vga16fb fixes
Date: 16 Feb 2003 14:08:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045375686.1823.73.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-xrswo+bo8tWrXA3+VX3q"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kI0M-0005Zf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 15 Feb 2003 22:10:23 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-xrswo+bo8tWrXA3+VX3q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch (linux-2.5.61 + James' fbdev.diff) to fix compile warnings.

Tony 




--=-xrswo+bo8tWrXA3+VX3q
Content-Disposition: attachment; filename=vga16fb.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vga16fb.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/video/vga16fb.c linux-2.5.61-ad/drive=
rs/video/vga16fb.c
--- linux-2.5.61-fbdev/drivers/video/vga16fb.c	2003-02-16 00:55:53.00000000=
0 +0000
+++ linux-2.5.61-ad/drivers/video/vga16fb.c	2003-02-16 02:34:06.000000000 +=
0000
@@ -305,7 +305,8 @@
=20
 	if (!cnt) {
 		memset(&par->state, 0, sizeof(struct vgastate));
-		par->state.flags =3D 8;
+		par->state.flags =3D VGA_SAVE_FONTS | VGA_SAVE_MODE |
+			VGA_SAVE_CMAP;
 		save_vga(&par->state);
 	}
 	atomic_inc(&par->ref_count);
@@ -1164,14 +1165,14 @@
 #endif
 #endif
=20
-void vga_8planes_imageblit(struct fb_info *info, const struct fb_image *im=
age)
+void vga_8planes_imageblit(struct fb_info *info, struct fb_image *image)
 {
         char oldindex =3D getindex();
         char oldmode =3D setmode(0x40);
         char oldop =3D setop(0);
         char oldsr =3D setsr(0);
         char oldmask =3D selectmask();
-        u8 *cdat =3D image->data;
+        const char *cdat =3D image->data;
 	u32 dx =3D image->dx;
         char *where;
         int y;
@@ -1195,12 +1196,12 @@
         setindex(oldindex);
 }
=20
-void vga_imageblit_expand(struct fb_info *info, const struct fb_image *ima=
ge)
+void vga_imageblit_expand(struct fb_info *info, struct fb_image *image)
 {
 	char *where =3D info->screen_base + (image->dx/8) +=20
 		image->dy * info->fix.line_length;
 	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
-	u8 *cdat =3D image->data, *dst;
+	char *cdat =3D (char *) image->data, *dst;
 	int x, y;
=20
 	switch (info->fix.type) {
@@ -1258,7 +1259,7 @@
 	}
 }
=20
-void vga_imageblit_color(struct fb_info *info, const struct fb_image *imag=
e)=20
+void vga_imageblit_color(struct fb_info *info, struct fb_image *image)=20
 {
 	/*
 	 * Draw logo=20
@@ -1266,7 +1267,7 @@
 	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
 	char *where =3D info->screen_base + image->dy * info->fix.line_length +=20
 		image->dx/8;
-	char *cdat =3D image->data, *dst;
+	const char *cdat =3D image->data, *dst;
 	int x, y;
=20
 	switch (info->fix.type) {
@@ -1301,12 +1302,14 @@
 	}
 }
 			=09
-void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image)
+void vga16fb_imageblit(struct fb_info *info, const struct fb_image *img)
 {
-	if (image->depth =3D=3D 1)
-		vga_imageblit_expand(info, image);
-	else if (image->depth =3D=3D info->var.bits_per_pixel)
-		vga_imageblit_color(info, image);
+	struct fb_image image =3D *img;
+
+	if (image.depth =3D=3D 0)
+		vga_imageblit_expand(info, &image);
+	else if (image.depth =3D=3D info->var.bits_per_pixel)
+		vga_imageblit_color(info, &image);
 }
=20
 static struct fb_ops vga16fb_ops =3D {

--=-xrswo+bo8tWrXA3+VX3q--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
