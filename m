From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: More optimization for accel_putcs()
Date: 22 Feb 2003 11:32:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045884656.1188.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Kqo9DJLpLMbtJZ+mcDQ0"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18mQNp-0007nF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Feb 2003 19:31:26 -0800
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


--=-Kqo9DJLpLMbtJZ+mcDQ0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Geert, James,

Here's a patch for linux-2.5.61 + James' fbdev.diff so accel_putcs()
will do only 1 fb_imageblit() at the end when fontwidth is not divisible
by 8.  Tested on 4x6 and 12x22 fonts.  There should be a significant
performance increase even with the generic functions, however, the
greatest gain can be seen on drivers with accelerated fb_imageblit(). 
Here are some numbers:

no accel
scrollmode: yredraw
font: 12x22
visual: packed pixels

time cat /usr/src/linux/MAINTAINERS

linux-2.5.62 (old -- 1 fb_imageblit/character)

bpp8
----
real    0m5.247s
user    0m0.001s
sys     0m5.245s

bpp16
-----
real    0m9.640s
user    0m0.001s
sys     0m9.591s

bpp24
-----
real    0m15.943s
user    0m0.001s
sys     0m15.944s

bpp32
-----
real    0m19.653s
user    0m0.002s
sys     0m19.651s

linux-2.5.62 (new - 1 fb_imageblit at the end)

bpp8
----
real    0m3.867s
user    0m0.000s
sys     0m3.866s

bpp16
-----
real    0m5.894s
user    0m0.001s
sys     0m5.892s

bpp24
-----
real    0m13.669s
user    0m0.000s
sys     0m13.670s

bpp32
-----
real    0m11.053s
user    0m0.001s
sys     0m11.054s


Tony



--=-Kqo9DJLpLMbtJZ+mcDQ0
Content-Disposition: attachment; filename=accel_putcs.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=accel_putcs.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61/dr=
ivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-22 02:34:26.00=
0000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon.c	2003-02-22 03:16:45.00000000=
0 +0000
@@ -332,16 +332,22 @@
 }=09
=20
 #define FB_PIXMAPSIZE 8192
+/*
+ * FIXME: Break up this function, it's becoming too long...
+ */       =20
 void accel_putcs(struct vc_data *vc, struct display *p,
 			const unsigned short *s, int count, int yy, int xx)
 {
+	static u8 pixmap[FB_PIXMAPSIZE];
+	struct fb_image image;
 	struct fb_info *info =3D p->fb_info;
 	unsigned short charmask =3D p->charmask;
 	unsigned int width =3D ((vc->vc_font.width + 7)/8);
 	unsigned int cellsize =3D vc->vc_font.height * width;
-	struct fb_image image;
+	unsigned int pitch, cnt, i, j, k;
+	unsigned int maxcnt =3D FB_PIXMAPSIZE/cellsize;
+	u8 *src, *dst, *dst0;
 	u16 c =3D scr_readw(s);
-	static u8 pixmap[FB_PIXMAPSIZE];
 =09
 	image.fg_color =3D attr_fgcol(p, c);
 	image.bg_color =3D attr_bgcol(p, c);
@@ -349,13 +355,9 @@
 	image.dy =3D yy * vc->vc_font.height;
 	image.height =3D vc->vc_font.height;
 	image.depth =3D 0;
+	image.data =3D pixmap;
=20
 	if (!(vc->vc_font.width & 7)) {
-		unsigned int pitch, cnt, i, j, k;
-		unsigned int maxcnt =3D FB_PIXMAPSIZE/cellsize;
-		char *src, *dst, *dst0;
-
-		image.data =3D pixmap;
 		while (count) {
 			if (count > maxcnt)=20
 				cnt =3D k =3D maxcnt;
@@ -381,14 +383,48 @@
 			image.dx +=3D cnt * vc->vc_font.width;
 			count -=3D cnt;
 		}
+	=09
 	} else {
-		image.width =3D vc->vc_font.width;
-		while (count--) {
-			image.data =3D p->fontdata +=20
-				(scr_readw(s++) & charmask) * cellsize;
+		unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
+		unsigned int shift_high =3D 8;
+		unsigned idx =3D vc->vc_font.width/8;
+		u8 mask;
+
+		while (count) {
+			if (count > maxcnt)=20
+				cnt =3D k =3D maxcnt;
+			else
+				cnt =3D k =3D count;
+		=09
+			dst0 =3D pixmap;
+			image.width =3D vc->vc_font.width * cnt;
+			pitch =3D (image.width + 7)/8;
+			while (k--) {
+				src =3D p->fontdata + (scr_readw(s++)&charmask)*
+					cellsize;
+				dst =3D dst0;
+				mask =3D (u8) (0xfff << shift_high);
+				for (i =3D image.height; i--; ) {
+					for (j =3D 0; j < idx; j++) {
+						dst[j] &=3D mask;
+						dst[j] |=3D *src >> shift_low;
+						dst[j+1] =3D *src << shift_high;
+						src++;
+					}
+					dst[idx] &=3D mask;
+					dst[idx] |=3D *src++ >> shift_low;
+					dst +=3D pitch;
+				}
+				shift_low +=3D mod;
+				shift_low &=3D 7;
+				shift_high =3D 8 - shift_low;
+				dst0 +=3D (shift_low) ? width - 1 : width;
+			}
+
 			info->fbops->fb_imageblit(info, &image);
-			image.dx +=3D vc->vc_font.width;
-		}=09
+			image.dx +=3D cnt * vc->vc_font.width;
+			count -=3D cnt;
+		}
 	}
 }
=20
diff -Naur linux-2.5.61-fbdev/drivers/video/fbmem.c linux-2.5.61/drivers/vi=
deo/fbmem.c
--- linux-2.5.61-fbdev/drivers/video/fbmem.c	2003-02-22 02:34:26.000000000 =
+0000
+++ linux-2.5.61/drivers/video/fbmem.c	2003-02-22 02:42:06.000000000 +0000
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

--=-Kqo9DJLpLMbtJZ+mcDQ0--




-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
