From: James Simmons <jsimmons@www.infradead.org>
Subject: Optimized cfbimgblt.c
Date: Thu, 20 Jan 2005 18:08:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501201808120.6978@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Crgjq-0005Ri-9u
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 10:08:58 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Crgjo-0001U9-7q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Jan 2005 10:08:58 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "adaplas@hotpop.com" <adaplas@hotpop.com>


Oops. Need to CC Tony.


Here is a patch for packed pixel software imageblit. Since the code to 
draw a color image and a mono image are almost the same I merged them. 
Second I made the code generic enough to work on big endian and little 
endian code at the same time. I set my radeon card in my x86 box to big 
endian mode and tested. It worked for me but I like people on big endian 
machines to test it. The last fix was to deal with the 16 color logo. The 
fb_set_logo was unpacking the 4bpp info. Now cfb_imageblit can handle the
logo data directly. Most hardware expects the data not to be unpacked. 
Another bug was image.depth was always set to 8 in fb_show_logo. This is 
in correct. Please test. Thank you.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/cfbimgblt.c fbdev-2.6/drivers/video/cfbimgblt.c
--- linus-2.6/drivers/video/cfbimgblt.c	2005-01-17 15:04:36.000000000 -0800
+++ fbdev-2.6/drivers/video/cfbimgblt.c	2005-01-16 18:24:22.000000000 -0800
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <asm/byteorder.h>
 #include <asm/types.h>
 
 #define DEBUG
@@ -44,29 +45,14 @@
 #endif
 
 static u32 cfb_tab8[] = {
-#if defined(__BIG_ENDIAN)
-    0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
-    0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
-    0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
-    0xffff0000,0xffff00ff,0xffffff00,0xffffffff
-#elif defined(__LITTLE_ENDIAN)
-    0x00000000,0xff000000,0x00ff0000,0xffff0000,
-    0x0000ff00,0xff00ff00,0x00ffff00,0xffffff00,
-    0x000000ff,0xff0000ff,0x00ff00ff,0xffff00ff,
-    0x0000ffff,0xff00ffff,0x00ffffff,0xffffffff
-#else
-#error FIXME: No endianness??
-#endif
+	0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
+	0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
+	0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
+	0xffff0000,0xffff00ff,0xffffff00,0xffffffff
 };
 
 static u32 cfb_tab16[] = {
-#if defined(__BIG_ENDIAN)
-    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
-#elif defined(__LITTLE_ENDIAN)
-    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
-#else
-#error FIXME: No endianness??
-#endif
+	0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
 };
 
 static u32 cfb_tab32[] = {
@@ -76,138 +62,83 @@
 #define FB_WRITEL fb_writel
 #define FB_READL  fb_readl
 
-#if defined (__BIG_ENDIAN)
-#define LEFT_POS(bpp)          (32 - bpp)
-#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
-#define SHIFT_LOW(val, bits)   ((val) << (bits))
-#else
-#define LEFT_POS(bpp)          (0)
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
-#endif
 
-static inline void color_imageblit(const struct fb_image *image, 
-				   struct fb_info *p, u8 __iomem *dst1, 
-				   u32 start_index,
-				   u32 pitch_index)
+static inline void slow_imageblit(const struct fb_image *image, 
+				struct fb_info *p, u8 __iomem *dst1, 
+				u32 start_index, u32 pitch_index)
 {
 	/* Draw the penguin */
-	u32 __iomem *dst, *dst2;
-	u32 color = 0, val, shift;
-	int i, n, bpp = p->var.bits_per_pixel;
-	u32 null_bits = 32 - bpp;
+	int spitch = (image->width * image->depth + 7) >> 3;
+	const u32 *src = (const u32 *) image->data;
+	int scan_align = p->pixmap.scan_align - 1;
 	u32 *palette = (u32 *) p->pseudo_palette;
-	const u8 *src = image->data;
-
-	dst2 = (u32 __iomem *) dst1;
-	for (i = image->height; i--; ) {
-		n = image->width;
-		dst = (u32 __iomem *) dst1;
-		shift = 0;
-		val = 0;
-		
-		if (start_index) {
-			u32 start_mask = ~(SHIFT_HIGH(~(u32)0, start_index));
-			val = FB_READL(dst) & start_mask;
-			shift = start_index;
-		}
-		while (n--) {
-			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
-			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-				color = palette[*src];
-			else
-				color = *src;
-			color <<= LEFT_POS(bpp);
-			val |= SHIFT_HIGH(color, shift);
-			if (shift >= null_bits) {
-				FB_WRITEL(val, dst++);
-	
-				val = (shift == null_bits) ? 0 : 
-					SHIFT_LOW(color, 32 - shift);
-			}
-			shift += bpp;
-			shift &= (32 - 1);
-			src++;
-		}
-		if (shift) {
-			u32 end_mask = SHIFT_HIGH(~(u32)0, shift);
-
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
-		}
-		dst1 += p->fix.line_length;
-		if (pitch_index) {
-			dst2 += p->fix.line_length;
-			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+	int bits = p->pixmap.access_align << 3;
+	int i, n, bpp = p->var.bits_per_pixel;
+	u32 null_bits = bits - bpp, l = bits;
+	int mask = (1 << image->depth) - 1;
+	u32 color = 0, val, shift;
+	u32 __iomem *dst, *dst2;
 
-			start_index += pitch_index;
-			start_index &= 32 - 1;
-		}
-	}
-}
+	spitch = (spitch + scan_align) & ~scan_align;
 
-static inline void slow_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 __iomem *dst1, u32 fgcolor,
-				  u32 bgcolor, 
-				  u32 start_index,
-				  u32 pitch_index)
-{
-	u32 shift, color = 0, bpp = p->var.bits_per_pixel;
-	u32 __iomem *dst, *dst2;
-	u32 val, pitch = p->fix.line_length;
-	u32 null_bits = 32 - bpp;
-	u32 spitch = (image->width+7)/8;
-	const u8 *src = image->data, *s;
-	u32 i, j, l;
-	
 	dst2 = (u32 __iomem *) dst1;
-
 	for (i = image->height; i--; ) {
-		shift = val = 0;
-		l = 8;
-		j = image->width;
 		dst = (u32 __iomem *) dst1;
-		s = src;
+		shift = 0, val = 0;
+		n = image->width;
 
 		/* write leading bits */
 		if (start_index) {
-			u32 start_mask = ~(SHIFT_HIGH(~(u32)0, start_index));
+			u32 start_mask = SHIFT_LOW(~(u32)0, bits - start_index);
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
 		}
 
-		while (j--) {
-			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
-			color <<= LEFT_POS(bpp);
+		while (n--) {
+			if (!l) { src++; l = bits; }
+			l -= image->depth;
+
+			color = (swab32p(src) & (mask << l));
+			if (image->depth == 1)
+				color = color ? image->fg_color : image->bg_color;
+			else
+				color >>= l;
+
+			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+			    p->fix.visual == FB_VISUAL_DIRECTCOLOR)
+				color = palette[color];
+
 			val |= SHIFT_HIGH(color, shift);
-			
-			/* Did the bitshift spill bits to the next long? */
+
+			/* Did the bitshift spill bits into the next long? */
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
-				val = (shift == null_bits) ? 0 :
-					 SHIFT_LOW(color,32 - shift);
+
+				val = (shift == null_bits) ? 0 : SHIFT_LOW(color, bits - shift);
 			}
 			shift += bpp;
-			shift &= (32 - 1);
-			if (!l) { l = 8; s++; };
+			shift &= (bits - 1);
 		}
 
+		l -= (spitch << 3) - image->width * image->depth;
+
 		/* write trailing bits */
- 		if (shift) {
+		if (shift) {
 			u32 end_mask = SHIFT_HIGH(~(u32)0, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
-		
-		dst1 += pitch;
-		src += spitch;	
+
+		dst1 += p->fix.line_length;
 		if (pitch_index) {
-			dst2 += pitch;
-			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+			dst2 += p->fix.line_length;
+			dst1 = (u8 __iomem *)((long)dst2 & ~(p->pixmap.access_align - 1));
+
 			start_index += pitch_index;
-			start_index &= 32 - 1;
+			start_index &= bits - 1;
 		}
-		
 	}
 }
 
@@ -220,17 +151,29 @@
  *           beginning and end of a scanline is dword aligned
  */
 static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 __iomem *dst1, u32 fgcolor, 
-				  u32 bgcolor) 
+				u8 __iomem *dst1)
 {
-	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
-	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
+	u32 fgx, fgcolor, bgx, bgcolor, bpp = p->var.bits_per_pixel;
+	int ppw = 32/bpp, spitch = (image->width + 7) >> 3;
+	int bit_access = p->pixmap.access_align << 3;
+	int scan_align = p->pixmap.scan_align - 1;
 	u32 bit_mask, end_mask, eorx, shift;
 	const char *s = image->data, *src;
 	u32 __iomem *dst;
 	u32 *tab = NULL;
 	int i, j, k;
-		
+
+	spitch = (spitch + scan_align) & ~scan_align;
+
+	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		fgx = fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
+		bgx = bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
+	} else {
+		fgx = fgcolor = image->fg_color;
+		bgx = bgcolor = image->bg_color;
+	}	
+
 	switch (bpp) {
 	case 8:
 		tab = cfb_tab8;
@@ -249,17 +192,17 @@
 		fgx |= fgcolor;
 		bgx |= bgcolor;
 	}
-	
+
+	k = (image->width * bpp)/bit_access;
 	bit_mask = (1 << ppw) - 1;
 	eorx = fgx ^ bgx;
-	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
 		dst = (u32 __iomem *) dst1, shift = 8; src = s;
-		
+
 		for (j = k; j--; ) {
 			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
+			end_mask = swab32(tab[(*src >> shift) & bit_mask]);
 			FB_WRITEL((end_mask & eorx)^bgx, dst++);
 			if (!shift) { shift = 8; src++; }		
 		}
@@ -270,11 +213,11 @@
 	
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
-	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
-	u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
-	u32 width = image->width, height = image->height; 
+	u32 bpl = p->pixmap.access_align, bpp = p->var.bits_per_pixel;
+	u32 width = image->width, height = image->height;
+	u32 start_index, bitstart, pitch_index = 0;
+	int x2, y2, vxres, vyres, bits = bpl << 3;
 	u32 dx = image->dx, dy = image->dy;
-	int x2, y2, vxres, vyres;
 	u8 __iomem *dst1;
 
 	if (p->state != FBINFO_STATE_RUNNING)
@@ -299,36 +242,21 @@
 	width  = x2 - dx;
 	height = y2 - dy;
 
-	bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
-	start_index = bitstart & (32 - 1);
-	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
+	bitstart = ((dy * p->fix.line_length) << 3) + (dx * bpp);
+	start_index = bitstart & (bits - 1);
+	pitch_index = (p->fix.line_length & (bpl - 1)) << 3;
 
-	bitstart /= 8;
+	bitstart >>= 3;
 	bitstart &= ~(bpl - 1);
 	dst1 = p->screen_base + bitstart;
 
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
 
-	if (image->depth == 1) {
-		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
-		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
-			fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
-			bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
-		} else {
-			fgcolor = image->fg_color;
-			bgcolor = image->bg_color;
-		}	
-		
-		if (32 % bpp == 0 && !start_index && !pitch_index && 
-		    ((width & (32/bpp-1)) == 0) &&
-		    bpp >= 8 && bpp <= 32) 			
-			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
-		else 
-			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
-					start_index, pitch_index);
-	} else
-		color_imageblit(image, p, dst1, start_index, pitch_index);
+	if (bits % bpp == 0 && image->depth == 1 && !start_index && !pitch_index && bpp >= 8 && bpp <= 32 && ((width & (bits/bpp-1)) == 0))
+		fast_imageblit(image, p, dst1);
+	else
+		slow_imageblit(image, p, dst1, start_index, pitch_index);
 }
 
 EXPORT_SYMBOL(cfb_imageblit);
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2005-01-07 11:07:25.000000000 -0800
+++ fbdev-2.6/drivers/video/fbmem.c	2005-01-15 17:08:20.000000000 -0800
@@ -291,43 +291,6 @@
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }
 
-static void fb_set_logo(struct fb_info *info,
-			       const struct linux_logo *logo, u8 *dst,
-			       int depth)
-{
-	int i, j, k, fg = 1;
-	const u8 *src = logo->data;
-	u8 d, xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
-
-	if (fb_get_color_depth(info) == 3)
-		fg = 7;
-
-	switch (depth) {
-	case 4:
-		for (i = 0; i < logo->height; i++)
-			for (j = 0; j < logo->width; src++) {
-				*dst++ = *src >> 4;
-				j++;
-				if (j < logo->width) {
-					*dst++ = *src & 0x0f;
-					j++;
-				}
-			}
-		break;
-	case 1:
-		for (i = 0; i < logo->height; i++) {
-			for (j = 0; j < logo->width; src++) {
-				d = *src ^ xor;
-				for (k = 7; k >= 0; k--) {
-					*dst++ = ((d >> k) & 1) ? fg : 0;
-					j++;
-				}
-			}
-		}
-		break;
-	}
-}
-
 /*
  * Three (3) kinds of logo maps exist.  linux_logo_clut224 (>16 colors),
  * linux_logo_vga16 (16 colors) and linux_logo_mono (2 colors).  Depending on
@@ -396,7 +359,7 @@
 
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
-	
+
 	if (!fb_logo.logo || fb_logo.logo->height > info->var.yres) {
 		fb_logo.logo = NULL;
 		return 0;
@@ -414,7 +377,6 @@
 int fb_show_logo(struct fb_info *info)
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
-	unsigned char *logo_new = NULL;
 	struct fb_image image;
 	int x;
 
@@ -422,7 +384,7 @@
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	image.depth = 8;
+	image.depth = fb_logo.depth;
 	image.data = fb_logo.logo->data;
 
 	if (fb_logo.needs_cmapreset)
@@ -443,20 +405,16 @@
 		info->pseudo_palette = palette;
 	}
 
-	if (fb_logo.depth <= 4) {
-		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
-				   GFP_KERNEL);
-		if (logo_new == NULL) {
-			if (palette)
-				kfree(palette);
-			if (saved_pseudo_palette)
-				info->pseudo_palette = saved_pseudo_palette;
-			return 0;
+	if (fb_logo.depth == 1) {
+		if (info->fix.visual == FB_VISUAL_MONO01) {
+			image.fg_color = 0;
+			image.bg_color = 1;
+		} else {
+			image.fg_color = 1;
+			image.bg_color = 0;
 		}
-		image.data = logo_new;
-		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.depth);
 	}
-
+	
 	image.width = fb_logo.logo->width;
 	image.height = fb_logo.logo->height;
 	image.dy = 0;
@@ -471,8 +429,6 @@
 		kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
-	if (logo_new != NULL)
-		kfree(logo_new);
 	return fb_logo.logo->height;
 }
 #else


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
