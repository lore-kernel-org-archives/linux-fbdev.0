From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: image.depth fix to accomodate monochrome cards
Date: 08 Jan 2003 00:16:26 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041956124.974.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W0g7-0000ak-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 12:50:27 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James,

I've waited a few days, seems nobody objected.

Attached is a patch for linux-2.5.54 + James Simmons' latest fbdev.diff.

1.  Changed meaning of image.depth.  If image.depth == 0, it flags for
color expansion, otherwise, it flags for image drawing (without color
expansion).  This change is to accomodate monochrome cards so they can
differentiate character drawing from logo drawing.

2.  diff submitted by Geert: cleaner logo data preparation for
monochrome cards and correct initialization of palette_cmap.transp.

3.  added a few commentaries in skeletonfb.c detailing image.depth and
image.data.

Tony

diff -Naur linux-2.5.54/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.54/drivers/video/cfbimgblt.c	2003-01-07 16:00:08.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-07 15:39:33.000000000 +0000
@@ -323,7 +323,7 @@
 	bitstart &= ~(bpl - 1);
 	dst1 = p->screen_base + bitstart;
 
-	if (image->depth == 1) {
+	if (image->depth == 0) {
 		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
 			fgcolor = ((u32 *)(p->pseudo_palette))[image->fg_color];
diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-07 16:01:11.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-07 15:43:52.000000000 +0000
@@ -395,7 +395,7 @@
 	image.dx = xx * vc->vc_font.width;
 	image.dy = yy * vc->vc_font.height;
 	image.height = vc->vc_font.height;
-	image.depth = 1;
+	image.depth = 0;
 
 	if (!(vc->vc_font.width & 7)) {
 		unsigned int pitch, cnt, i, j, k;
@@ -1170,7 +1170,7 @@
 	image.dy = real_y(p, ypos) * vc->vc_font.height;
 	image.width = vc->vc_font.width;
 	image.height = vc->vc_font.height;
-	image.depth = 1;
+	image.depth = 0;
 	image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
 
 	info->fbops->fb_imageblit(info, &image);
diff -Naur linux-2.5.54/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.54/drivers/video/fbmem.c	2003-01-07 16:00:15.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-01-07 15:43:11.000000000 +0000
@@ -386,6 +386,7 @@
 	palette_cmap.red = palette_red;
 	palette_cmap.green = palette_green;
 	palette_cmap.blue = palette_blue;
+	palette_cmap.transp = NULL;
 
 	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
 		n = LINUX_LOGO_COLORS - i;
@@ -461,13 +462,11 @@
 		break;
 	case 1:
 	case ~1:
-	default:
-		for (i = 0; i < (LOGO_W * LOGO_H)/8; i++)
-			for (j = 0; j < 8; j++)
-				logo[i*8 + j] = (linux_logo_bw[i] &  (7 - j)) ?
-						((needs_logo == 1) ? 1 : 0) :
-						((needs_logo == 1) ? 0 : 1);
-			break;
+		for (i = 0; i < (LOGO_W * LOGO_H)/8; i++) {
+		       u8 d = linux_logo_bw[i];
+                       for (j = 0; j < 8; j++, d <<= 1)
+                               logo[i*8+j] = ((d ^ needs_logo) >> 7) & 1;
+               }
 	}
 }
 
diff -Naur linux-2.5.54/drivers/video/i810/i810_accel.c linux/drivers/video/i810/i810_accel.c
--- linux-2.5.54/drivers/video/i810/i810_accel.c	2003-01-07 16:01:28.000000000 +0000
+++ linux/drivers/video/i810/i810_accel.c	2003-01-07 15:45:47.000000000 +0000
@@ -404,7 +404,7 @@
 		return;
 	}
 
-	if (par->depth == 4 || image->depth != 1) {
+	if (par->depth == 4 || image->depth != 0) {
 		wait_for_engine_idle(par);
 		cfb_imageblit(p, image);
 		return;
diff -Naur linux-2.5.54/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.54/drivers/video/riva/fbdev.c	2003-01-07 16:01:40.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2003-01-07 15:47:28.000000000 +0000
@@ -1323,7 +1323,7 @@
 	volatile u32 *d;
 	int i, j, size;
 
-	if (image->depth != 1) {
+	if (image->depth != 0) {
 		wait_for_idle(par);
 		cfb_imageblit(info, image);
 		return;
diff -Naur linux-2.5.54/drivers/video/skeletonfb.c linux/drivers/video/skeletonfb.c
--- linux-2.5.54/drivers/video/skeletonfb.c	2003-01-07 16:00:23.000000000 +0000
+++ linux/drivers/video/skeletonfb.c	2003-01-07 15:59:33.000000000 +0000
@@ -445,9 +445,14 @@
  *      @fg_color: For mono bitmap images this is color data for     
  *      @bg_color: the foreground and background of the image to
  *		   write directly to the frmaebuffer.
- *	@depth:	How many bits represent a single pixel for this image.
+ *	@depth:	This will be zero (0) if color expanding (character drawing).  
+ *              If nonzero, this represent the pixel depth of the data. 
  *	@data: The actual data used to construct the image on the display.
- *	@cmap: The colormap used for color images.   
+ *             It is a monochrome bitmap if color expanding.  For image
+ *             drawing, each byte of data represents 1 pixel irrespective
+ *             of the framebuffer depth.  The byte is either an index to the
+ *             pseudo_palette for directcolor and truecolor, or the 
+ *             actual pixel written to the framebuffer.
  */
 }
 
diff -Naur linux-2.5.54/drivers/video/softcursor.c linux/drivers/video/softcursor.c
--- linux-2.5.54/drivers/video/softcursor.c	2003-01-07 16:00:27.000000000 +0000
+++ linux/drivers/video/softcursor.c	2003-01-07 15:39:15.000000000 +0000
@@ -47,7 +47,7 @@
 	image.dy = cursor->image.dy;
 	image.width = cursor->image.width;
 	image.height = cursor->image.height;
-	image.depth = cursor->image.depth;
+	image.depth = 0;
 	image.data = data;
 
 	if (info->fbops->fb_imageblit)
diff -Naur linux-2.5.54/drivers/video/tdfxfb.c linux/drivers/video/tdfxfb.c
--- linux-2.5.54/drivers/video/tdfxfb.c	2003-01-07 16:00:30.000000000 +0000
+++ linux/drivers/video/tdfxfb.c	2003-01-07 15:46:33.000000000 +0000
@@ -939,7 +939,7 @@
 	u8 *chardata = (u8 *) pixmap->data;
 	u32 srcfmt;
 
-	if (pixmap->depth == 1) {
+	if (pixmap->depth == 0) {
 		banshee_make_room(par, 8 + ((size + 3) >> 2));
 		tdfx_outl(par, COLORFORE, pixmap->fg_color);
 		tdfx_outl(par, COLORBACK, pixmap->bg_color);
diff -Naur linux-2.5.54/drivers/video/tgafb.c linux/drivers/video/tgafb.c
--- linux-2.5.54/drivers/video/tgafb.c	2003-01-07 16:00:34.000000000 +0000
+++ linux/drivers/video/tgafb.c	2003-01-07 15:44:35.000000000 +0000
@@ -572,7 +572,7 @@
 	   can do better than the generic code.  */
 	/* ??? There is a DMA write mode; I wonder if that could be
 	   made to pull the data from the image buffer...  */
-	if (image->depth > 1) {
+	if (image->depth > 0) {
 		cfb_imageblit(info, image);
 		return;
 	}
diff -Naur linux-2.5.54/drivers/video/vga16fb.c linux/drivers/video/vga16fb.c
--- linux-2.5.54/drivers/video/vga16fb.c	2003-01-07 16:00:41.000000000 +0000
+++ linux/drivers/video/vga16fb.c	2003-01-07 15:50:49.000000000 +0000
@@ -1301,7 +1301,7 @@
 				
 void vga16fb_imageblit(struct fb_info *info, struct fb_image *image)
 {
-	if (image->depth == 1)
+	if (image->depth == 0)
 		vga_imageblit_expand(info, image);
 	else if (image->depth == info->var.bits_per_pixel)
 		vga_imageblit_color(info, image);



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
