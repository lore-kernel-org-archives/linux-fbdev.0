From: James Simmons <jsimmons@infradead.org>
Subject: [PATCH] cfbimgblt updates.
Date: Thu, 3 May 2007 16:48:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705031648050.25194@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjdY7-000455-Pd for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 08:48:56 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HjdY6-0007mg-JI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 08:48:55 -0700
Received: from localhost ([127.0.0.1])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HjdY4-0000JI-TE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 16:48:52 +0100
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



Here is the second run at the patch. Updated to the 2.6.21.

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 2610044..304cc57 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -1,7 +1,7 @@
 /*
  *  Generic BitBLT function for frame buffer with packed pixels of any depth.
  *
- *      Copyright (C)  June 1999 James Simmons
+ *      Copyright (C)  June 1999 - 2006 James Simmons
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive for
@@ -17,7 +17,7 @@
  *  their are cards with hardware that coverts images of various depths to the
  *  framebuffer depth. But not every card has this. All images must be rounded
  *  up to the nearest byte. For example a bitmap 12 bits wide must be two 
- *  bytes width. 
+ *  bytes width.
  *
  *  Tony: 
  *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <asm/byteorder.h>
 #include <asm/types.h>
 
 #define DEBUG
@@ -43,161 +44,100 @@
 #endif
 
 static const u32 cfb_tab8[] = {
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
 
 static const u32 cfb_tab16[] = {
-#if defined(__BIG_ENDIAN)
-    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
-#elif defined(__LITTLE_ENDIAN)
-    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
-#else
-#error FIXME: No endianness??
-#endif
+	0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
 };
 
 static const u32 cfb_tab32[] = {
 	0x00000000, 0xffffffff
 };
 
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
+#define FB_WRITEL		fb_writel
+#define FB_READL		fb_readl
 
-static inline void color_imageblit(const struct fb_image *image, 
-				   struct fb_info *p, u8 __iomem *dst1, 
-				   u32 start_index,
-				   u32 pitch_index)
+static inline void slow_imageblit(const struct fb_image *image, 
+				  struct fb_info *p, u8 __iomem *dst, 
+				  u32 start_index, u32 pitch_index)
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
+	int bpp = p->var.bits_per_pixel, i, n;
+	int access = p->pixmap.access_align;
+	int mask = (1 << image->depth) - 1;
+	int bpw = access >> 3, s = 32;
+	int null_bits = access - bpp;
+	u32 color = 0, val, shift;
+	u32 __iomem *dst2;
+	u8 __iomem *dst1;
 
-	dst2 = (u32 __iomem *) dst1;
+	spitch = (spitch + scan_align) & ~scan_align;
+	dst2 = (u32 __iomem *) dst;
 	for (i = image->height; i--; ) {
 		n = image->width;
-		dst = (u32 __iomem *) dst1;
-		shift = 0;
-		val = 0;
-		
+		shift = val = 0;
+		dst1 = dst;
+
+		/* write leading bits */
 		if (start_index) {
-			u32 start_mask = ~(FB_SHIFT_HIGH(~(u32)0, start_index));
-			val = FB_READL(dst) & start_mask;
+			u32 start_mask = (~(u32)0 << start_index);
+			val = FB_READL(dst1);
+			val &= start_mask;
 			shift = start_index;
 		}
-		while (n--) {
-			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
-			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-				color = palette[*src];
-			else
-				color = *src;
-			color <<= FB_LEFT_POS(bpp);
-			val |= FB_SHIFT_HIGH(color, shift);
-			if (shift >= null_bits) {
-				FB_WRITEL(val, dst++);
-	
-				val = (shift == null_bits) ? 0 : 
-					FB_SHIFT_LOW(color, 32 - shift);
-			}
-			shift += bpp;
-			shift &= (32 - 1);
-			src++;
-		}
-		if (shift) {
-			u32 end_mask = FB_SHIFT_HIGH(~(u32)0, shift);
-
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
-		}
-		dst1 += p->fix.line_length;
-		if (pitch_index) {
-			dst2 += p->fix.line_length;
-			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
 
-			start_index += pitch_index;
-			start_index &= 32 - 1;
-		}
-	}
-}
+		while (n--) {
+			if (!s) { src++; s = 32; }
+			s -= image->depth;
 
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
-	dst2 = (u32 __iomem *) dst1;
-	fgcolor <<= FB_LEFT_POS(bpp);
-	bgcolor <<= FB_LEFT_POS(bpp);
+			color = (swab32p(src) & (mask << s));
+			if (image->depth == 1)
+				color = color ? image->fg_color : image->bg_color;
+			else
+				color >>= s;
 
-	for (i = image->height; i--; ) {
-		shift = val = 0;
-		l = 8;
-		j = image->width;
-		dst = (u32 __iomem *) dst1;
-		s = src;
+			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+			    p->fix.visual == FB_VISUAL_DIRECTCOLOR)
+				color = palette[color];
 
-		/* write leading bits */
-		if (start_index) {
-			u32 start_mask = ~(FB_SHIFT_HIGH(~(u32)0,start_index));
-			val = FB_READL(dst) & start_mask;
-			shift = start_index;
-		}
+			val <<= shift;
+			val |= color;
 
-		while (j--) {
-			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
-			val |= FB_SHIFT_HIGH(color, shift);
-			
-			/* Did the bitshift spill bits to the next long? */
+			/* Did the bitshift spill bits into the next long? */
 			if (shift >= null_bits) {
-				FB_WRITEL(val, dst++);
-				val = (shift == null_bits) ? 0 :
-					FB_SHIFT_LOW(color,32 - shift);
+				FB_WRITEL(val, dst1);
+				dst1 += bpw;
+				val = (shift == null_bits) ? 0 : (color >> (access - shift));
 			}
 			shift += bpp;
-			shift &= (32 - 1);
-			if (!l) { l = 8; s++; };
+			shift &= (access - 1);
 		}
+		s -= (spitch << 3) - image->width * image->depth;
 
 		/* write trailing bits */
- 		if (shift) {
-			u32 end_mask = FB_SHIFT_HIGH(~(u32)0, shift);
+		if (shift) {
+			u32 end_mask = (~(u32)0 << shift);
 
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
+			val = FB_READL(dst1);
+			val &= end_mask;
+			FB_WRITEL(val, dst1);
 		}
-		
-		dst1 += pitch;
-		src += spitch;	
+
+		dst += p->fix.line_length;
 		if (pitch_index) {
-			dst2 += pitch;
-			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+			dst2 += p->fix.line_length;
+			dst = (u8 __iomem *)((long __force)dst2 & ~(bpw - 1));
 			start_index += pitch_index;
-			start_index &= 32 - 1;
+			start_index &= access - 1;
 		}
-		
 	}
 }
 
@@ -210,101 +150,105 @@ static inline void slow_imageblit(const struct fb_image *image, struct fb_info *
  *           beginning and end of a scanline is dword aligned
  */
 static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 __iomem *dst1, u32 fgcolor, 
-				  u32 bgcolor) 
+				  u8 __iomem *dst) 
 {
-	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
-	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, end_mask, eorx, shift;
+	u32 bit_mask, end_mask = 0, mask = -1, eorx, fgx, fgcolor, bgx, bgcolor, val;
+	int scan_align = p->pixmap.scan_align - 1, spitch = (image->width + 7) >> 3;
+	int access = 16, bpw = access >> 3, bits;
+	int bpp = p->var.bits_per_pixel, ppw, shift, i, j;
 	const char *s = image->data, *src;
-	u32 __iomem *dst;
 	const u32 *tab = NULL;
-	int i, j, k;
-		
+	u8 __iomem *dst1;
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
+		ppw = 4;
 		break;
 	case 16:
 		tab = cfb_tab16;
+		ppw = 2;
 		break;
 	case 32:
 	default:
 		tab = cfb_tab32;
+		ppw = 1;
 		break;
 	}
 
-	for (i = ppw-1; i--; ) {
+	for (i = 0; i < 32; i += bpp) {
 		fgx <<= bpp;
 		bgx <<= bpp;
 		fgx |= fgcolor;
 		bgx |= bgcolor;
 	}
-	
+
 	bit_mask = (1 << ppw) - 1;
+	mask >>= (32 - access);
 	eorx = fgx ^ bgx;
-	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (u32 __iomem *) dst1, shift = 8; src = s;
-		
-		for (j = k; j--; ) {
-			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
-			if (!shift) { shift = 8; src++; }		
+		dst1 = dst, shift = 8, bits = 0; src = s;
+
+		for (j = image->width*bpp; j > 0; j -= access) {
+			if (bits <= 0) {
+				shift -= ppw, bits = 32;
+				end_mask = (swab32(tab[(*src >> shift) & bit_mask]) & eorx)^bgx;
+				if (!shift) { shift = 8; src++; }
+			}
+			bits -= access;
+			val = (end_mask >> bits) & mask;
+			FB_WRITEL(val, dst1);
+			dst1 += bpw;
 		}
-		dst1 += p->fix.line_length;
+		dst += p->fix.line_length;
 		s += spitch;
 	}
-}	
-	
+}
+
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
-	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
-	u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
-	u32 width = image->width;
-	u32 dx = image->dx, dy = image->dy;
+	int bits = p->pixmap.access_align, bpp = p->var.bits_per_pixel;
+	u32 start_index, bitstart, pitch_index = 0;
+	int dx = image->dx, dy = image->dy;
 	u8 __iomem *dst1;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
-	start_index = bitstart & (32 - 1);
-	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
+	bitstart = ((dy * p->fix.line_length) << 3) + (dx * bpp);
+	pitch_index = p->fix.line_length & 3;
+	start_index = bitstart & 31;
 
-	bitstart /= 8;
-	bitstart &= ~(bpl - 1);
-	dst1 = p->screen_base + bitstart;
+	bitstart &= ~(bits-1);
+	dst1 = p->screen_base + (bitstart >> 3);
 
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
+	if (image->depth != 1 || start_index || pitch_index || bpp < 8 || bpp > 32 ||
+	   (32 % bpp) || (image->width * bpp % 32)) {
+		pitch_index = (p->fix.line_length << 3) & bits;
+		start_index = bitstart & (bits - 1);
+		slow_imageblit(image, p, dst1, start_index, pitch_index);
 	} else
-		color_imageblit(image, p, dst1, start_index, pitch_index);
+		fast_imageblit(image, p, dst1);
 }
 
 EXPORT_SYMBOL(cfb_imageblit);
 
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
+MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
 MODULE_DESCRIPTION("Generic software accelerated imaging drawing");
 MODULE_LICENSE("GPL");
 
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 2822526..ed22487 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -242,48 +242,6 @@ static void fb_set_logo_directpalette(struct fb_info *info,
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }
 
-static void fb_set_logo(struct fb_info *info,
-			       const struct linux_logo *logo, u8 *dst,
-			       int depth)
-{
-	int i, j, k;
-	const u8 *src = logo->data;
-	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
-	u8 fg = 1, d;
-
-	if (fb_get_color_depth(&info->var, &info->fix) == 3)
-		fg = 7;
-
-	if (info->fix.visual == FB_VISUAL_MONO01 ||
-	    info->fix.visual == FB_VISUAL_MONO10)
-		fg = ~((u8) (0xfff << info->var.green.length));
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
@@ -452,10 +410,9 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
 
-	if (!fb_logo.logo) {
+	if (!fb_logo.logo)
 		return 0;
-	}
-	
+
 	if (rotate == FB_ROTATE_UR || rotate == FB_ROTATE_UD)
 		yres = info->var.yres;
 	else
@@ -479,14 +436,13 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 int fb_show_logo(struct fb_info *info, int rotate)
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
-	unsigned char *logo_new = NULL, *logo_rotate = NULL;
 	struct fb_image image;
 
 	/* Return if the frame buffer is not mapped or suspended */
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	image.depth = 8;
+	image.depth = fb_logo.depth;
 	image.data = fb_logo.logo->data;
 
 	if (fb_logo.needs_cmapreset)
@@ -507,17 +463,13 @@ int fb_show_logo(struct fb_info *info, int rotate)
 		info->pseudo_palette = palette;
 	}
 
-	if (fb_logo.depth <= 4) {
-		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
-				   GFP_KERNEL);
-		if (logo_new == NULL) {
-			kfree(palette);
-			if (saved_pseudo_palette)
-				info->pseudo_palette = saved_pseudo_palette;
-			return 0;
+	if (fb_logo.depth == 1) {
+		if (info->fix.visual == FB_VISUAL_MONO01) {
+			u32 fg = image.fg_color;
+
+			image.fg_color = image.bg_color;
+			image.bg_color = fg;
 		}
-		image.data = logo_new;
-		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.depth);
 	}
 
 	image.dx = 0;
@@ -526,10 +478,11 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	image.height = fb_logo.logo->height;
 
 	if (rotate) {
-		logo_rotate = kmalloc(fb_logo.logo->width *
+		unsigned char *logo_rotate = kzalloc(fb_logo.logo->width *
 				      fb_logo.logo->height, GFP_KERNEL);
 		if (logo_rotate)
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
+		kfree(logo_rotate);
 	}
 
 	fb_do_show_logo(info, &image, rotate);
@@ -537,8 +490,6 @@ int fb_show_logo(struct fb_info *info, int rotate)
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
-	kfree(logo_new);
-	kfree(logo_rotate);
 	return fb_logo.logo->height;
 }
 #else

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
