From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Portrait display mode
Date: 12 Sep 2002 03:50:23 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031773864.562.3.camel@daplas>
References: <Pine.GSO.4.21.0209110837090.27524-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-LdIWIMCTX3kuF0Jcc13C"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17pDU8-0000OZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Sep 2002 12:49:12 -0700
In-Reply-To: <Pine.GSO.4.21.0209110837090.27524-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: otto.wyss@bluewin.ch, fbdev <linux-fbdev-devel@lists.sourceforge.net>


--=-LdIWIMCTX3kuF0Jcc13C
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-09-11 at 14:38, Geert Uytterhoeven wrote: 

> > > turnable display I rather see this feature implemented. I even may help but can
> > > spend much time. How difficult would it be?
> > > 
> > It should not be too difficult to add per-driver support once the
> 
> Can't this be moved up to generic code, so we don't have to modify all drivers?
> 
I have thought about that, but since the patch was preliminary, I chose
not to disrupt the framework yet.  The tricky part in making the support
generic is display panning. 

Here is my train of thought.  Moving support into fbgen might involve a
few assumptions.  Firstly, info->var is assumed to be device specific
(ie, it does not care about the orientation). Secondly, the display->var
as well as those received from other sources (such as in an ioctl call)
are partly device independent.  When a structure var is passed to the
driver, it will undergo conversion so the structure is sane from the
driver's perspective.  The same is done vice-versa.  I've introduced two
(exportable) functions, convert_var_to_physical(), and
convert_var_to_logical() that should do that.  

All fbops functions should be passed with device-specific var except for
fb_set_var since I'm not too sure where to look for specific entry
points for fb_set_var.  I guess fb_check_var and fb_pan_display are the
most critical ones, since the other fbops functions do not look at the
framelengths, nor the offsets. 

With the changes, drivers that support fbcon_accel and gen_* functions
should have support for console rotation automatically.  

For those that support fbcon_accel, but not gen_* functions, the driver
should not look at display->var anymore, but look instead into
info->var. If possible, use the convert_to_var functions when
passing/getting information to/from structure display. 

For those, that don't support fbcon_accel, behaviour should remain as
usual. 

I'm not too sure if this is the correct way of doing this, but it's the
best I can think of at the moment without causing very intrusive
changes. 

Attached is a patch (fb_rotate2.diff).  Please apply the patches I have
sent previously before applying this patch. 

Tony 



--=-LdIWIMCTX3kuF0Jcc13C
Content-Disposition: attachment; filename=fb_rotate2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fb_rotate2.diff; charset=ISO-8859-1

diff -Naur linux-2.5.33/drivers/video/Config.in linux/drivers/video/Config.=
in
--- linux-2.5.33/drivers/video/Config.in	Wed Sep 11 18:28:40 2002
+++ linux/drivers/video/Config.in	Wed Sep 11 18:34:23 2002
@@ -227,7 +227,6 @@
       tristate '    24 bpp packed pixels support' CONFIG_FBCON_CFB24
       tristate '    32 bpp packed pixels support' CONFIG_FBCON_CFB32
       tristate '    Hardware acceleration support' CONFIG_FBCON_ACCEL
-      dep_tristate '    Console Display Rotation support' CONFIG_FBCON_ROT=
ATE $CONFIG_FBCON_ACCEL=09
       tristate '    Amiga bitplanes support' CONFIG_FBCON_AFB
       tristate '    Amiga interleaved bitplanes support' CONFIG_FBCON_ILBM
       tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG=
_FBCON_IPLAN2P2
@@ -368,13 +367,6 @@
 	      "$CONFIG_FB_CLPS711X" =3D "m" -o "$CONFIG_FB_3DFX" =3D "m" -o \
 	      "$CONFIG_FB_RIVA" =3D "m" -o "$CONFIG_FB_SGIVW" =3D "m" ]; then=20
 	    define_tristate CONFIG_FBCON_ACCEL m
-         fi      =20
-      fi
-      if [ "$CONFIG_FB_VESA" =3D "y" ]; then
-	 define_tristate CONFIG_FBCON_ROTATE y
-      else
-	 if [ "$CONFIG_FB_VESA" =3D "m" ]; then=20
-	    define_tristate CONFIG_FBCON_ROTATE m
          fi      =20
       fi
       if [ "$CONFIG_FB_AMIGA" =3D "y" ]; then
diff -Naur linux-2.5.33/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.33/drivers/video/Makefile	Wed Sep 11 18:28:49 2002
+++ linux/drivers/video/Makefile	Wed Sep 11 18:36:23 2002
@@ -68,7 +68,7 @@
 obj-$(CONFIG_FB_S3TRIO)           +=3D S3triofb.o
 obj-$(CONFIG_FB_TGA)              +=3D tgafb.o
 obj-$(CONFIG_FB_VESA)             +=3D vesafb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o=20
-obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o fbcon-vga-planes.o
+obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o fbcon-vga-planes.o=20
 obj-$(CONFIG_FB_VIRGE)            +=3D virgefb.o
 obj-$(CONFIG_FB_G364)             +=3D g364fb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
 obj-$(CONFIG_FB_FM2)              +=3D fm2fb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
@@ -117,8 +117,7 @@
 obj-$(CONFIG_FBCON_MFB)           +=3D fbcon-mfb.o
 obj-$(CONFIG_FBCON_HGA)           +=3D fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           +=3D fbcon-sti.o
-obj-$(CONFIG_FBCON_ACCEL)	  +=3D fbcon-accel.o
-obj-$(CONFIG_FBCON_ROTATE)	  +=3D fbcon-rotate.o=20
+obj-$(CONFIG_FBCON_ACCEL)	  +=3D fbcon-accel.o fbcon-rotate.o
=20
 include $(TOPDIR)/Rules.make
=20
diff -Naur linux-2.5.33/drivers/video/cfbcopyarea.c linux/drivers/video/cfb=
copyarea.c
--- linux-2.5.33/drivers/video/cfbcopyarea.c	Wed Sep 11 18:29:01 2002
+++ linux/drivers/video/cfbcopyarea.c	Wed Sep 11 18:30:53 2002
@@ -28,7 +28,6 @@
 #include <asm/io.h>
 #include <video/fbcon.h>
=20
-#include "fbcon-rotate.h"
=20
 #define LONG_MASK  (BITS_PER_LONG - 1)
=20
@@ -329,12 +328,6 @@
=20
 	vxres =3D p->var.xres_virtual;
 	vyres =3D p->var.yres_virtual;
-#ifdef FBCON_HAS_ROTATE
-	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
-		vxres =3D p->var.yres_virtual;
-		vyres =3D p->var.xres_virtual;
-	}
-#endif
=20
 	if (area->dx > vxres ||=20
 	    area->sx > vxres ||
diff -Naur linux-2.5.33/drivers/video/cfbfillrect.c linux/drivers/video/cfb=
fillrect.c
--- linux-2.5.33/drivers/video/cfbfillrect.c	Wed Sep 11 18:29:05 2002
+++ linux/drivers/video/cfbfillrect.c	Wed Sep 11 18:30:58 2002
@@ -22,8 +22,6 @@
 #include <asm/types.h>
 #include <video/fbcon.h>
=20
-#include "fbcon-rotate.h"
-
 #if BITS_PER_LONG =3D=3D 32
 #define FB_WRITEL fb_writel
 #define FB_READL  fb_readl
@@ -53,12 +51,6 @@
=20
 	vxres =3D p->var.xres_virtual;
 	vyres =3D p->var.yres_virtual;
-#ifdef FBCON_HAS_ROTATE
-	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
-		vxres =3D p->var.yres_virtual;
-		vyres =3D p->var.xres_virtual;
-	}
-#endif
=20
 	if (!rect->width || !rect->height ||
 	    rect->dx > vxres ||
diff -Naur linux-2.5.33/drivers/video/cfbimgblt.c linux/drivers/video/cfbim=
gblt.c
--- linux-2.5.33/drivers/video/cfbimgblt.c	Wed Sep 11 18:28:56 2002
+++ linux/drivers/video/cfbimgblt.c	Wed Sep 11 18:30:48 2002
@@ -39,7 +39,6 @@
 #include <asm/types.h>
=20
 #include <video/fbcon.h>
-#include "fbcon-rotate.h"
=20
 #define DEBUG
=20
@@ -298,12 +297,6 @@
=20
 	vxres =3D p->var.xres_virtual;
 	vyres =3D p->var.yres_virtual;
-#ifdef FBCON_HAS_ROTATE
-	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
-		vxres =3D p->var.yres_virtual;
-		vyres =3D p->var.xres_virtual;
-	}
-#endif
=20
 	/*=20
 	 * We could use hardware clipping but on many cards you get around hardwa=
re
diff -Naur linux-2.5.33/drivers/video/fbcon-rotate.c linux/drivers/video/fb=
con-rotate.c
--- linux-2.5.33/drivers/video/fbcon-rotate.c	Wed Sep 11 18:33:04 2002
+++ linux/drivers/video/fbcon-rotate.c	Wed Sep 11 18:32:32 2002
@@ -114,9 +114,9 @@
 	struct fb_info *info =3D p->fb_info;
 	struct fb_copyarea area;
=20
-	area.sx =3D info->var.yres_virtual - ((sy + height) * fontheight(p));
+	area.sx =3D info->var.xres_virtual - ((sy + height) * fontheight(p));
 	area.sy =3D sx * fontwidth(p);
-	area.dx =3D info->var.yres_virtual - ((dy + height) * fontheight(p));
+	area.dx =3D info->var.xres_virtual - ((dy + height) * fontheight(p));
 	area.dy =3D dx * fontwidth(p);
 	area.width =3D height * fontheight(p);
 	area.height  =3D width * fontwidth(p);
@@ -131,7 +131,7 @@
 	struct fb_fillrect region;
=20
 	region.color =3D attr_bgcol_ec(p,vc);
-	region.dx =3D info->var.yres_virtual - ((sy + height) * fontheight(p));
+	region.dx =3D info->var.xres_virtual - ((sy + height) * fontheight(p));
 	region.dy =3D sx * fontwidth(p);
 	region.height =3D width * fontwidth(p);
 	region.width =3D height * fontheight(p);
@@ -150,7 +150,7 @@
=20
 	image.fg_color =3D attr_fgcol(p, c);
 	image.bg_color =3D attr_bgcol(p, c);
-	image.dx =3D info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(=
p));
+	image.dx =3D info->var.xres_virtual - ((yy * fontheight(p)) + fontheight(=
p));
 	image.dy =3D xx * fontwidth(p);
 	image.width =3D fontheight(p);
 	image.height =3D fontwidth(p);
@@ -170,7 +170,7 @@
=20
 	image.fg_color =3D attr_fgcol(p, *s);
 	image.bg_color =3D attr_bgcol(p, *s);
-	image.dx =3D info->var.yres_virtual - ((yy * fontheight(p)) + fontheight(=
p));
+	image.dx =3D info->var.xres_virtual - ((yy * fontheight(p)) + fontheight(=
p));
 	image.dy =3D xx * fontwidth(p);
 	image.width =3D fontheight(p);
 	image.height =3D fontwidth(p);
@@ -188,7 +188,7 @@
 	struct fb_fillrect region;
=20
 	region.color =3D attr_fgcol_ec(p, p->conp);
-	region.dx =3D info->var.yres_virtual - ((yy * fontheight(p)) + fontheight=
(p));
+	region.dx =3D info->var.xres_virtual - ((yy * fontheight(p)) + fontheight=
(p));
 	region.dy =3D xx * fontwidth(p);
 	region.width  =3D fontheight(p);
 	region.height =3D fontwidth(p);=20
@@ -203,10 +203,10 @@
 	struct fb_info *info =3D p->fb_info;
 	unsigned int cw =3D fontwidth(p);
 	unsigned int ch =3D fontheight(p);
-	unsigned int rw =3D info->var.xres % cw;
-	unsigned int bh =3D info->var.yres % ch;
-	unsigned int rs =3D info->var.xres - rw;
-	unsigned int bs =3D info->var.yres - bh;
+	unsigned int rw =3D info->var.yres % cw;
+	unsigned int bh =3D info->var.xres % ch;
+	unsigned int rs =3D info->var.yres - rw;
+	unsigned int bs =3D info->var.xres - bh;
 	struct fb_fillrect region;
=20
 	region.color =3D attr_bgcol_ec(p,vc);
@@ -214,15 +214,15 @@
=20
 	if (rw && !bottom_only) {
 		region.dx =3D 0;
-		region.dy =3D info->var.xoffset + rs;
+		region.dy =3D info->var.yoffset + rs;
 		region.height  =3D rw;
 		region.width =3D info->var.yres_virtual;
 		info->fbops->fb_fillrect(info, &region);=20
 	}
=20
 	if (bh) {
-		region.dx =3D info->var.yres_virtual - (info->var.yoffset + bs + bh);
-		region.dy =3D info->var.xoffset;
+		region.dx =3D info->var.xres_virtual - (info->var.xoffset + bs + bh);
+		region.dy =3D info->var.yoffset;
                 region.width  =3D bh;
                 region.height =3D rs;
 		info->fbops->fb_fillrect(info, &region);
@@ -276,9 +276,9 @@
 	struct fb_copyarea area;
=20
 	area.sx =3D sy * fontheight(p);
-	area.sy =3D info->var.xres_virtual - ((sx + width) * fontwidth(p));
+	area.sy =3D info->var.yres_virtual - ((sx + width) * fontwidth(p));
 	area.dx =3D dy * fontheight(p);
-	area.dy =3D info->var.xres_virtual - ((dx + width) * fontwidth(p));
+	area.dy =3D info->var.yres_virtual - ((dx + width) * fontwidth(p));
 	area.width =3D height * fontheight(p);
 	area.height  =3D width * fontwidth(p);
=20
@@ -293,7 +293,7 @@
=20
 	region.color =3D attr_bgcol_ec(p,vc);
 	region.dx =3D sy * fontheight(p);
-	region.dy =3D info->var.xres_virtual - ((sx + width)  *  fontwidth(p));
+	region.dy =3D info->var.yres_virtual - ((sx + width)  *  fontwidth(p));
 	region.height =3D width * fontwidth(p);
 	region.width =3D height * fontheight(p);
 	region.rop =3D ROP_COPY;
@@ -312,7 +312,7 @@
 	image.fg_color =3D attr_fgcol(p, c);
 	image.bg_color =3D attr_bgcol(p, c);
 	image.dx =3D yy * fontheight(p);
-	image.dy =3D info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p)=
);
+	image.dy =3D info->var.yres_virtual - ((xx * fontwidth(p)) + fontwidth(p)=
);
 	image.width =3D fontheight(p);
 	image.height =3D fontwidth(p);
 	image.data =3D fontcache + (c & charmask)*fontheight(p) * width;
@@ -332,7 +332,7 @@
 	image.fg_color =3D attr_fgcol(p, *s);
 	image.bg_color =3D attr_bgcol(p, *s);
 	image.dx =3D yy * fontheight(p);
-	image.dy =3D info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p)=
);
+	image.dy =3D info->var.yres_virtual - ((xx * fontwidth(p)) + fontwidth(p)=
);
 	image.width =3D fontheight(p);
 	image.height =3D fontwidth(p);
 	image.depth =3D 1;
@@ -350,7 +350,7 @@
=20
 	region.color =3D attr_fgcol_ec(p, p->conp);
 	region.dx =3D yy * fontheight(p);
-	region.dy =3D info->var.xres_virtual - ((xx * fontwidth(p)) + fontwidth(p=
));
+	region.dy =3D info->var.yres_virtual - ((xx * fontwidth(p)) + fontwidth(p=
));
 	region.width  =3D fontheight(p);
 	region.height =3D fontwidth(p);=20
 	region.rop =3D ROP_XOR;
@@ -364,10 +364,10 @@
 	struct fb_info *info =3D p->fb_info;
 	unsigned int cw =3D fontwidth(p);
 	unsigned int ch =3D fontheight(p);
-	unsigned int rw =3D info->var.xres % cw;
-	unsigned int bh =3D info->var.yres % ch;
-	unsigned int rs =3D info->var.xres - rw;
-	unsigned int bs =3D info->var.yres - bh;
+	unsigned int rw =3D info->var.yres % cw;
+	unsigned int bh =3D info->var.xres % ch;
+	unsigned int rs =3D info->var.yres - rw;
+	unsigned int bs =3D info->var.xres - bh;
 	struct fb_fillrect region;
=20
 	region.color =3D attr_bgcol_ec(p,vc);
@@ -375,15 +375,15 @@
=20
 	if (rw && !bottom_only) {
 		region.dx =3D 0;
-		region.dy =3D info->var.xres_virtual - (info->var.xoffset + rs + rw);
+		region.dy =3D info->var.yres_virtual - (info->var.yoffset + rs + rw);
 		region.height  =3D rw;
 		region.width =3D info->var.yres_virtual;
 		info->fbops->fb_fillrect(info, &region);=20
 	}
=20
 	if (bh) {
-		region.dx =3D info->var.yoffset + bs;
-		region.dy =3D info->var.xres_virtual - (info->var.xoffset + rs + rw);
+		region.dx =3D info->var.xoffset + bs;
+		region.dy =3D info->var.yres_virtual - (info->var.yoffset + rs + rw);
                 region.width  =3D bh;
                 region.height =3D rs;
 		info->fbops->fb_fillrect(info, &region);
diff -Naur linux-2.5.33/drivers/video/fbcon-rotate.h linux/drivers/video/fb=
con-rotate.h
--- linux-2.5.33/drivers/video/fbcon-rotate.h	Wed Sep 11 18:33:06 2002
+++ linux/drivers/video/fbcon-rotate.h	Wed Sep 11 18:32:35 2002
@@ -7,16 +7,6 @@
=20
 #include <linux/config.h>
=20
-#ifdef MODULE
-#if defined(CONFIG_FBCON_ROTATE) || defined(CONFIG_FBCON_ROTATE_MODULE)
-#define FBCON_HAS_ROTATE
-#endif
-#else
-#if defined(CONFIG_FBCON_ROTATE)
-#define FBCON_HAS_ROTATE
-#endif
-#endif
-
 extern struct display_switch fbcon_rr;
 extern void fbcon_rr_setup(struct display *p);
 extern void fbcon_rr_bmove(struct display *p, int sy, int sx, int dy,
diff -Naur linux-2.5.33/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux-2.5.33/drivers/video/fbgen.c	Wed Sep 11 18:28:35 2002
+++ linux/drivers/video/fbgen.c	Wed Sep 11 18:30:23 2002
@@ -31,37 +31,119 @@
 #include "fbcon-accel.h"
 #include "fbcon-rotate.h"
=20
+#define SWAP(x,y,z) do { (z) =3D (x); (x) =3D (y); (y) =3D (z); } while(0)
+
+void convert_var_to_phys(struct fb_var_screeninfo *var)
+{
+#ifdef FBCON_HAS_ACCEL
+	u32 tmp, xoffset, yoffset;
+=09
+	switch (var->vmode & FB_ROTATE_MASK) {
+	case FB_VMODE_ROTATE_CW:
+		xoffset =3D var->yres_virtual - (var->yres + var->yoffset);
+		yoffset =3D var->xoffset;
+		var->xoffset =3D xoffset;
+		var->yoffset =3D yoffset;
+		SWAP(var->xres, var->yres, tmp);
+		SWAP(var->xres_virtual, var->yres_virtual, tmp);
+		break;
+	case FB_VMODE_ROTATE_CCW:
+		xoffset =3D var->yoffset;
+		yoffset =3D var->xres_virtual - (var->xres + var->xoffset);
+		var->xoffset =3D xoffset;
+		var->yoffset =3D yoffset;
+		SWAP(var->xres, var->yres, tmp);
+		SWAP(var->xres_virtual, var->yres_virtual, tmp);
+		break;
+	case FB_VMODE_ROTATE_UD:
+		var->xoffset =3D var->xres_virtual - (var->xres + var->xoffset);
+		var->yoffset =3D var->yres_virtual - (var->yres + var->yoffset);
+		break;
+	}
+#endif
+}
+
+/*
+ * convert var from what hardware actually sees
+ */
+void convert_var_to_logical(struct fb_var_screeninfo *var)
+{
+#ifdef FBCON_HAS_ACCEL
+	u32 tmp, xoffset, yoffset;
+
+	switch (var->vmode & FB_ROTATE_MASK) {
+	case FB_VMODE_ROTATE_CW:
+		xoffset =3D var->yoffset;
+		yoffset =3D var->xres_virtual - (var->xres + var->xoffset);
+		var->xoffset =3D xoffset;
+		var->yoffset =3D yoffset;
+		SWAP(var->xres, var->yres, tmp);
+		SWAP(var->xres_virtual, var->yres_virtual, tmp);
+		break;
+	case FB_VMODE_ROTATE_CCW:
+		xoffset =3D var->yres_virtual - (var->yres + var->yoffset);
+		yoffset =3D var->xoffset;
+		var->xoffset =3D xoffset;
+		var->yoffset =3D yoffset;
+		SWAP(var->xres, var->yres, tmp);
+		SWAP(var->xres_virtual, var->yres_virtual, tmp);
+		break;
+	case FB_VMODE_ROTATE_UD:
+		var->xoffset =3D var->xres_virtual - (var->xres + var->xoffset);
+		var->yoffset =3D var->yres_virtual - (var->yres + var->yoffset);
+		break;
+	}
+#endif
+}	=09
+
 int gen_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *in=
fo)
 {
-	int err;
+	int err, xoffset, yoffset, vmode, activate;=20
=20
+	/*
+	 * FIXME: VESAFB crashes when switching orientation and
+	 * xoffset/yoffset is not zero. This is what changevar
+	 * does anyway.
+	 */
+	var->xoffset =3D 0;
+	var->yoffset =3D 0;
+	convert_var_to_phys(var);
+	xoffset =3D var->xoffset;
+	yoffset =3D var->yoffset;
 	if (con < 0 || (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))=
)) {
 		if (!info->fbops->fb_check_var) {
-			*var =3D info->var;
-			return 0;
+			activate =3D var->activate;
+			vmode =3D var->vmode;
+			*var =3D info->var;=20
+			var->vmode &=3D ~FB_ROTATE_MASK;
+			var->vmode |=3D vmode & FB_ROTATE_MASK;
+			var->activate &=3D ~FB_ACTIVATE_MASK;
+			var->activate |=3D activate & FB_ACTIVATE_MASK;
 		}
-	=09
-		if ((err =3D info->fbops->fb_check_var(var, info)))
+		else if ((err =3D info->fbops->fb_check_var(var, info)))=20
 			return err;
-
+		=09
 		if ((var->activate & FB_ACTIVATE_MASK) =3D=3D FB_ACTIVATE_NOW) {
+			var->xoffset =3D xoffset;
+			var->yoffset =3D yoffset;
 			info->var =3D *var;
 		=09
 			if (con =3D=3D info->currcon) {
 				if (info->fbops->fb_set_par)
 					info->fbops->fb_set_par(info);
=20
-				if (info->fbops->fb_pan_display)
+				if (info->fbops->fb_pan_display) {
 					info->fbops->fb_pan_display(&info->var, con, info);
-
+				}
 				gen_set_disp(con, info);
 				fb_set_cmap(&info->cmap, 1, info);
 			}
-	=09
+
 			if (info->changevar)
 				info->changevar(con);
 		}
 	}
+	convert_var_to_logical(var);
 	return 0;
 }
=20
@@ -139,13 +221,16 @@
 		display->dispsw_data =3D info->pseudo_palette;
 	}
 	display->var =3D info->var;
+	convert_var_to_logical(&display->var);
=20
 	/*
 	 * If we are setting all the virtual consoles, also set
 	 * the defaults used to create new consoles.
 	 */
-	if (con < 0 || info->var.activate & FB_ACTIVATE_ALL)
-		info->disp->var =3D info->var;=09
+	if (con < 0 || info->var.activate & FB_ACTIVATE_ALL) {
+		info->disp->var =3D info->var;
+		convert_var_to_logical(&info->disp->var);
+	}
=20
 	if (info->var.bits_per_pixel =3D=3D 24) {
 #ifdef FBCON_HAS_CFB24
@@ -157,7 +242,6 @@
=20
 #ifdef FBCON_HAS_ACCEL
 	display->scrollmode =3D SCROLL_YNOMOVE;
-#ifdef FBCON_HAS_ROTATE
 	if (info->var.vmode & FB_VMODE_ROTATE_CW)
 		display->dispsw =3D &fbcon_rr;
 	else if (info->var.vmode & FB_VMODE_ROTATE_CCW)
@@ -165,7 +249,6 @@
 	else if (info->var.vmode & FB_VMODE_ROTATE_UD)
 		display->dispsw =3D &fbcon_ud;
 	else=20
-#endif /* FBCON_HAS_ROTATE */
 		display->dispsw =3D &fbcon_accel;
 #else
 	display->dispsw =3D &fbcon_dummy;
@@ -201,11 +284,14 @@
 	int err;
    =20
 	if (con =3D=3D info->currcon) {
+		convert_var_to_phys(&disp->var);
 		info->var.xoffset =3D disp->var.xoffset;
 		info->var.yoffset =3D disp->var.yoffset;
 		info->var.vmode	=3D disp->var.vmode;=09
 		if (info->fbops->fb_pan_display) {
-			if ((err =3D info->fbops->fb_pan_display(&info->var, con, info)))
+			err =3D info->fbops->fb_pan_display(&info->var, con, info);
+			convert_var_to_logical(&disp->var);
+			if (err)=20
 				return err;
 		}
 	}=09
@@ -224,6 +310,7 @@
 		 * Save the old colormap and graphics mode.
 		 */
 		disp->var =3D info->var;
+		convert_var_to_logical(&disp->var);
 		if (disp->cmap.len)
 			fb_copy_cmap(&info->cmap, &disp->cmap, 0);
 	}
@@ -292,5 +379,7 @@
 EXPORT_SYMBOL(gen_update_var);
 EXPORT_SYMBOL(gen_switch);
 EXPORT_SYMBOL(fbgen_blank);
+EXPORT_SYMBOL(convert_var_to_logical);
+EXPORT_SYMBOL(convert_var_to_phys);
=20
 MODULE_LICENSE("GPL");
diff -Naur linux-2.5.33/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.33/drivers/video/fbmem.c	Wed Sep 11 18:28:43 2002
+++ linux/drivers/video/fbmem.c	Wed Sep 11 18:37:54 2002
@@ -476,7 +476,9 @@
 		return -ENODEV;
 	switch (cmd) {
 	case FBIOGET_VSCREENINFO:
-		return copy_to_user((void *) arg, &info->var,
+		var =3D info->var;
+		convert_var_to_logical(&var);
+		return copy_to_user((void *) arg, &var,
 				    sizeof(var)) ? -EFAULT : 0;
 	case FBIOPUT_VSCREENINFO:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
@@ -504,8 +506,10 @@
 			return -EFAULT;
 		if (fb->fb_pan_display =3D=3D NULL)
 			return (var.xoffset || var.yoffset) ? -EINVAL : 0;
+		convert_var_to_phys(&var);
 		if ((i=3Dfb->fb_pan_display(&var, PROC_CONSOLE(info), info)))
 			return i;
+		convert_var_to_logical(&var);
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
 		return i;
diff -Naur linux-2.5.33/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.33/drivers/video/vesafb.c	Wed Sep 11 18:29:11 2002
+++ linux/drivers/video/vesafb.c	Wed Sep 11 18:31:02 2002
@@ -27,8 +27,6 @@
=20
 #include <video/fbcon.h>
=20
-#include "fbcon-rotate.h"
-
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
=20
@@ -64,18 +62,12 @@
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
=20
-#ifdef FBCON_HAS_ROTATE
-static u32             xres;
-static u32             yres;
-static u32             vxres;
-static u32             vyres;
-#endif
 /* --------------------------------------------------------------------- *=
/
=20
 static int vesafb_pan_display(struct fb_var_screeninfo *var, int con,
                               struct fb_info *info)
 {
-	int offset, depth =3D (var->bits_per_pixel + 7)/8;
+	int offset;
=20
 	if (!ypan)
 		return -EINVAL;
@@ -86,18 +78,6 @@
 	if ((ypan=3D=3D1) && var->yoffset+var->yres > var->yres_virtual)
 		return -EINVAL;
=20
-#ifdef FBCON_HAS_ROTATE
-	if (var->vmode & FB_VMODE_ROTATE_CW)=20
-		offset =3D ((var->xoffset * info->fix.line_length) +
-			  ((var->yres_virtual - (var->yoffset + var->yres))) * depth) / 4;
-	else if (var->vmode & FB_VMODE_ROTATE_CCW)
-		offset =3D (((var->xres_virtual - (var->xoffset + var->xres)) * info->fi=
x.line_length) +
-			  (var->yoffset * depth)) / 4;
-	else if (var->vmode & FB_VMODE_ROTATE_UD)=20
-		offset =3D (((var->yres_virtual - (var->yoffset + var->yres)) * info->fi=
x.line_length) +
-			  ((var->xres_virtual - (var->xoffset + var->xres))) * depth) / 4;
-	else
-#endif
 		offset =3D (var->yoffset * info->fix.line_length + var->xoffset) / 4;
=20
         __asm__ __volatile__(
@@ -193,43 +173,11 @@
     return 0;
 }
=20
-static int vesafb_check_var(struct fb_var_screeninfo *var, struct fb_info =
*info)
-{
-#ifdef FBCON_HAS_ROTATE
-	u32 vmode;
-
-	vmode =3D var->vmode;
-	*var =3D info->var;
-	if (vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
-		var->xres =3D yres;
-		var->yres =3D xres;
-		var->xres_virtual =3D vyres;
-		var->yres_virtual =3D vxres;
-	}
-	else {
-		var->xres =3D xres;
-		var->yres =3D yres;
-		var->xres_virtual =3D vxres;
-		var->yres_virtual =3D vyres;
-	}	=09
-	vmode &=3D FB_ROTATE_MASK;
-	vmode |=3D info->var.vmode & ~FB_ROTATE_MASK;
-	var->vmode =3D vmode;
-#else
-	*var =3D info->var;
-#endif
-
-	var->xoffset =3D 0;
-	var->yoffset =3D 0;
-	return 0;
-}
-
 static struct fb_ops vesafb_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.fb_set_var	=3D gen_set_var,
 	.fb_get_cmap	=3D gen_get_cmap,
 	.fb_set_cmap	=3D gen_set_cmap,
-	.fb_check_var   =3D vesafb_check_var,
 	.fb_setcolreg	=3D vesafb_setcolreg,
 	.fb_pan_display	=3D vesafb_pan_display,
 	.fb_fillrect	=3D cfb_fillrect,
@@ -352,19 +300,6 @@
 		ypan =3D 0;
 	}
 =09
-#ifdef FBCON_HAS_ROTATE
-	xres =3D vesafb_defined.xres;
-	yres =3D vesafb_defined.yres;
-	vxres =3D vesafb_defined.xres_virtual;
-	vyres =3D vesafb_defined.yres_virtual;
-	if (vesafb_defined.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
-		vesafb_defined.xres =3D yres;
-		vesafb_defined.yres =3D xres;
-		vesafb_defined.xres_virtual =3D vyres;
-		vesafb_defined.yres_virtual =3D vxres;
-	}
-#endif
-
 	/* some dummy values for timing to make fbset happy */
 	vesafb_defined.pixclock     =3D 10000000 / vesafb_defined.xres * 1000 / v=
esafb_defined.yres;
 	vesafb_defined.left_margin  =3D (vesafb_defined.xres / 8) & 0xf8;
diff -Naur linux-2.5.33/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.33/include/linux/fb.h	Wed Sep 11 18:29:57 2002
+++ linux/include/linux/fb.h	Wed Sep 11 18:32:01 2002
@@ -419,6 +419,8 @@
 extern int fb_blank(int blank, struct fb_info *info);
 extern int gen_switch(int con, struct fb_info *info);
 extern void gen_set_disp(int con, struct fb_info *info);
+extern void convert_var_to_logical(struct fb_var_screeninfo *var);
+extern void convert_var_to_phys(struct fb_var_screeninfo *var);
=20
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

--=-LdIWIMCTX3kuF0Jcc13C--



-------------------------------------------------------
In remembrance
www.osdn.com/911/
