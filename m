From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: [PATCH]: image.depth fix to accomodate
	monochrome cards
Date: 08 Jan 2003 10:41:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1041991742.927.12.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301072201350.21057-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18W6MV-0006lR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Jan 2003 18:54:35 -0800
In-Reply-To: <Pine.GSO.4.21.0301072201350.21057-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2003-01-08 at 05:06, Geert Uytterhoeven wrote: 
> On 8 Jan 2003, Antonino Daplas wrote:
> > 2.  diff submitted by Geert: cleaner logo data preparation for
> > monochrome cards and correct initialization of palette_cmap.transp.
> 
> I'll have to do some more fixes there, since the monochrome logo is used not
> only on monochrome displays, but on all other displays with bits_per_pixel < 4
> Since the pixel data in fb_image are colormap indices, they have to reflect the
> correct `black' and `white' colors on such displays.
> 
> E.g. on amifb (which supports all bits_per_pixel from 1 through 8) the logo
> showed up in black-and-blue with bits_per_pixel == 3, cfr. the first two
> entries of {red,green,blue}8[] in fbcmap.c.
> 

Hmm, I see.  I think only linux_logo_bw will be the only one affected,
since linux_logo_16 happens to match the console palette and in
linux_logo, we either reset the palette and/or the cmap.

Would expanding each bit to the full bit depth work?  Ie for bpp=8 using
monochrome data, white is 0 and black is 0xff.

I think we still have several corner cases, such as TRUECOLOR with bpp
<= 8, I'm not sure if that works.

Anyway, here's an updated patch for linux-2.5.54 + James Simmons' latest
fbdev.diff.  Not sure if it works though :-)

Tony

diff -Naur linux-2.5.54/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.54/drivers/video/cfbimgblt.c	2003-01-08 01:53:45.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-08 01:51:21.000000000 +0000
@@ -323,7 +323,7 @@
 	bitstart &= ~(bpl - 1);
 	dst1 = p->screen_base + bitstart;
 
-	if (image->depth == 1) {
+	if (image->depth == 0) {
 		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
 			fgcolor = ((u32 *)(p->pseudo_palette))[image->fg_color];
diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/fbmem.c	2003-01-08 01:53:45.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-01-08 01:53:22.000000000 +0000
@@ -386,6 +386,7 @@
 	palette_cmap.red = palette_red;
 	palette_cmap.green = palette_green;
 	palette_cmap.blue = palette_blue;
+	palette_cmap.transp = NULL;
 
 	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
 		n = LINUX_LOGO_COLORS - i;
@@ -448,26 +449,33 @@
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }
 
-static void __init fb_set_logo(struct fb_info *info, u8 *logo, int needs_logo)
+#if defined (__BIG_ENDIAN)
+#define BIT_SHIFT(x, shift) ((x) >> (shift))
+#else
+#define BIT_SHIFT(x, shift) ((x) << (shift))
+#endif
+
+static void fb_set_logo(struct fb_info *info, u8 *logo, int needs_logo)
 {
 	int i, j;
+	u8 mask = (u8) ~(BIT_SHIFT(0xffff, info->var.bits_per_pixel));
 
 	switch (needs_logo) {
 	case 4:
-		for (i = 0; i < (LOGO_W * LOGO_H)/2; i++) {
+		for (i = 0; i < (LOGO_W * LOGO_H)/2; i++) { 
 			logo[i*2] = linux_logo16[i] >> 4;
 			logo[(i*2)+1] = linux_logo16[i] & 0xf;
 		}
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
+                               logo[i*8+j] = (((d ^ needs_logo) >> 7) & 1) ?
+				       mask : 0;
+		}
+		break;
 	}
 }
 
diff -Naur linux-2.5.54/drivers/video/i810/i810_accel.c linux/drivers/video/i810/i810_accel.c
--- linux-2.5.54/drivers/video/i810/i810_accel.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/riva/fbdev.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/skeletonfb.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/softcursor.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/tdfxfb.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/tgafb.c	2003-01-08 01:53:45.000000000 +0000
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
--- linux-2.5.54/drivers/video/vga16fb.c	2003-01-08 01:53:45.000000000 +0000
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
