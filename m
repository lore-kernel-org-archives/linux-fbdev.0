From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: cfb_imageblit() fix: handle widths not divisible by 8
Date: 14 Jan 2003 20:06:15 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042544142.1126.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YPyR-0004CS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Jan 2003 04:15:19 -0800
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James,

Heres a patch against 2.5.56 and your latest fbdev.diff:

a. fix for cfb_imageblit so it can handle monochrome bitmaps with widths
not a multiple of 8 (12x22, 4x6 fonts should now work)

b. further optimization of fast_imageblit() by removing unnecessary
steps from its main loop. 

c. fast_imageblit() should now work for bitmap widths which are least
divisible by 4 (12x22 and 4x6 fonts should now go to fast_imageblit()
instead of slow_imageblit().

c. Fix for fast_imageblit() so it always refer to mask tables in 32-bits
which should make it work for 64-bit machines.

d.  insert info->fbops->fb_sync() where it is needed: ie, 
cfb_{imageblit,fillrect,copyarea} and before the actual read/write in
fb_write and fb_read.

e.  trivial:  wrap text at 80 columns

Tony


diff -Naur linux-2.5.56-fbdev/drivers/video/cfbcopyarea.c linux/drivers/video/cfbcopyarea.c
--- linux-2.5.56-fbdev/drivers/video/cfbcopyarea.c	2003-01-14 11:34:35.000000000 +0000
+++ linux/drivers/video/cfbcopyarea.c	2003-01-14 01:21:49.000000000 +0000
@@ -65,13 +65,15 @@
 			// Single word
 			if (last)
 				first &= last;
-			FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+			FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), 
+				  dst);
 		} else {
 			// Multiple destination words
 			// Leading bits
 			if (first) {
 				
-				FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL((*src & first) | (FB_READL(dst) & 
+							    ~first), dst);
 				dst++;
 				src++;
 				n -= BITS_PER_LONG-dst_idx;
@@ -94,7 +96,8 @@
 				FB_WRITEL(*src++, dst++);
 			// Trailing bits
 			if (last)
-				FB_WRITEL((*src & last) | (FB_READL(dst) & ~last), dst);
+				FB_WRITEL((*src & last) | (FB_READL(dst) & 
+							   ~last), dst);
 		}
 	} else {
 		// Different alignment for source and dest
@@ -108,15 +111,18 @@
 				first &= last;
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL(((*src >> right) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((*src >> right) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 			} else if (src_idx+n <= BITS_PER_LONG) {
 				// Single source word
-				FB_WRITEL(((*src << left) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((*src << left) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 			} else {
 				// 2 source words
 				d0 = *src++;
 				d1 = *src;
-				FB_WRITEL(((d0 << left | d1 >> right) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((d0<<left | d1>>right) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 			}
 		} else {
 			// Multiple destination words
@@ -124,13 +130,15 @@
 			// Leading bits
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL(((d0 >> right) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((d0 >> right) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 				dst++;
 				n -= BITS_PER_LONG-dst_idx;
 			} else {
 				// 2 source words
 				d1 = *src++;
-				FB_WRITEL(((d0 << left | d1 >> right) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((d0<<left | d1>>right) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 				d0 = d1;
 				dst++;
 				n -= BITS_PER_LONG-dst_idx;
@@ -164,11 +172,15 @@
 			if (last) {
 				if (m <= right) {
 					// Single source word
-					FB_WRITEL(((d0 << left) & last) | (FB_READL(dst) & ~last), dst);
+					FB_WRITEL(((d0 << left) & last) | 
+						  (FB_READL(dst) & ~last), 
+						  dst);
 				} else {
 					// 2 source words
 					d1 = *src;
-					FB_WRITEL(((d0 << left | d1 >> right) & last) | (FB_READL(dst) & ~last), dst);
+					FB_WRITEL(((d0<<left | d1>>right) & 
+						   last) | (FB_READL(dst) & 
+							    ~last), dst);
 				}
 			}
 		}
@@ -208,12 +220,14 @@
 			// Single word
 			if (last)
 				first &= last;
-			FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+			FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), 
+				  dst);
 		} else {
 			// Multiple destination words
 			// Leading bits
 			if (first) {
-				FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL((*src & first) | (FB_READL(dst) & 
+							    ~first), dst);
 				dst--;
 				src--;
 				n -= dst_idx+1;
@@ -237,7 +251,8 @@
 			
 			// Trailing bits
 			if (last)
-				FB_WRITEL((*src & last) | (FB_READL(dst) & ~last), dst);
+				FB_WRITEL((*src & last) | (FB_READL(dst) & 
+							   ~last), dst);
 		}
 	} else {
 		// Different alignment for source and dest
@@ -251,15 +266,18 @@
 				first &= last;
 			if (shift < 0) {
 				// Single source word
-				FB_WRITEL((*src << left & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL((*src << left & first) | 
+					  (FB_READL(dst) & ~first), dst);
 			} else if (1+(unsigned long)src_idx >= n) {
 				// Single source word
-				FB_WRITEL(((*src >> right) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((*src >> right) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 			} else {
 				// 2 source words
 				d0 = *src--;
 				d1 = *src;
-				FB_WRITEL(((d0 >> right | d1 << left) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((d0>>right | d1<<left) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 			}
 		} else {
 			// Multiple destination words
@@ -267,13 +285,15 @@
 			// Leading bits
 			if (shift < 0) {
 				// Single source word
-				FB_WRITEL(((d0 << left) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((d0 << left) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 				dst--;
 				n -= dst_idx+1;
 			} else {
 				// 2 source words
 				d1 = *src--;
-				FB_WRITEL(((d0 >> right | d1 << left) & first) | (FB_READL(dst) & ~first), dst);
+				FB_WRITEL(((d0>>right | d1<<left) & first) | 
+					  (FB_READL(dst) & ~first), dst);
 				d0 = d1;
 				dst--;
 				n -= dst_idx+1;
@@ -307,12 +327,15 @@
 			if (last) {
 				if (m <= left) {
 					// Single source word
-					FB_WRITEL(((d0 >> right) & last) | (FB_READL(dst) & ~last), dst);
+					FB_WRITEL(((d0 >> right) & last) | 
+						  (FB_READL(dst) & ~last), 
+						  dst);
 				} else {
 					// 2 source words
 					d1 = *src;
-					FB_WRITEL(((d0 >> right | d1 << left) & last) |
-						  (FB_READL(dst) & ~last), dst);
+					FB_WRITEL(((d0>>right | d1<<left) & 
+						   last) | (FB_READL(dst) & 
+							    ~last), dst);
 				}
 			}
 		}
@@ -364,17 +387,21 @@
 	    (area->sy + area->height) > vyres)
 		return;
 	
-	if (area->dy > area->sy || (area->dy == area->sy && area->dx > area->sx)) {
+	if (area->dy > area->sy || (area->dy == area->sy && 
+				    area->dx > area->sx)) {
 		area->dy += area->height;
 		area->sy += area->height;
 		rev_copy = 1;
 	}
 
-	dst = src = (unsigned long *)((unsigned long)p->screen_base & ~(BYTES_PER_LONG-1));
+	dst = src = (unsigned long *)((unsigned long)p->screen_base & 
+				      ~(BYTES_PER_LONG-1));
 	dst_idx = src_idx = (unsigned long)p->screen_base & (BYTES_PER_LONG-1);
 	dst_idx += area->dy*next_line*8 + area->dx*p->var.bits_per_pixel;
 	src_idx += area->sy*next_line*8 + area->sx*p->var.bits_per_pixel;
 	
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
 	if (rev_copy) {
 		while (area->height--) {
 			dst_idx -= next_line*8;
@@ -383,8 +410,9 @@
 			dst_idx &= (BYTES_PER_LONG-1);
 			src += src_idx >> SHIFT_PER_LONG;
 			src_idx &= (BYTES_PER_LONG-1);
-			bitcpy_rev((unsigned long*)dst, dst_idx, (unsigned long *)src,
-					src_idx, area->width*p->var.bits_per_pixel);
+			bitcpy_rev((unsigned long*)dst, dst_idx, 
+				   (unsigned long *)src, src_idx, 
+				   area->width*p->var.bits_per_pixel);
 		}	
 	} else {
 		while (area->height--) {
@@ -392,8 +420,9 @@
 			dst_idx &= (BYTES_PER_LONG-1);
 			src += src_idx >> SHIFT_PER_LONG;
 			src_idx &= (BYTES_PER_LONG-1);
-			bitcpy((unsigned long*)dst, dst_idx, (unsigned long *)src,
-				   src_idx, area->width*p->var.bits_per_pixel);
+			bitcpy((unsigned long*)dst, dst_idx, 
+			       (unsigned long *)src, src_idx, 
+			       area->width*p->var.bits_per_pixel);
 			dst_idx += next_line*8;
 			src_idx += next_line*8;
 		}	
diff -Naur linux-2.5.56-fbdev/drivers/video/cfbfillrect.c linux/drivers/video/cfbfillrect.c
--- linux-2.5.56-fbdev/drivers/video/cfbfillrect.c	2003-01-14 11:34:32.000000000 +0000
+++ linux/drivers/video/cfbfillrect.c	2003-01-14 01:21:46.000000000 +0000
@@ -99,7 +99,8 @@
      *  the correct start position
      */
 
-static inline unsigned long pixel_to_pat(const struct fb_info *p, pixel_t pixel, int left)
+static inline unsigned long pixel_to_pat(const struct fb_info *p, 
+					 pixel_t pixel, int left)
 {
     unsigned long pat = pixel;
     u32 bpp = p->var.bits_per_pixel;
@@ -373,7 +374,8 @@
 	vxres = p->var.xres_virtual;
 	vyres = p->var.yres_virtual;
 
-	if (!rect->width || !rect->height || rect->dx > vxres || rect->dy > vyres)
+	if (!rect->width || !rect->height || 
+	    rect->dx > vxres || rect->dy > vyres)
 		return;
 
 	/* We could use hardware clipping but on many cards you get around
@@ -392,14 +394,18 @@
 	else
 		fg = rect->color;
 	
-	dst = (unsigned long *)((unsigned long)p->screen_base & ~(BYTES_PER_LONG-1));
+	dst = (unsigned long *)((unsigned long)p->screen_base & 
+				~(BYTES_PER_LONG-1));
 	dst_idx = ((unsigned long)p->screen_base & (BYTES_PER_LONG-1))*8;
 	dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
 	/* FIXME For now we support 1-32 bpp only */
 	left = BITS_PER_LONG % bpp;
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
 	if (!left) {
 		u32 pat = pixel_to_pat32(p, fg);
-		void (*fill_op32)(unsigned long *dst, int dst_idx, u32 pat, u32 n) = NULL;
+		void (*fill_op32)(unsigned long *dst, int dst_idx, u32 pat, 
+				  u32 n) = NULL;
 		
 		switch (rect->rop) {
 		case ROP_XOR:
@@ -420,8 +426,9 @@
 		unsigned long pat = pixel_to_pat(p, fg, (left-dst_idx) % bpp);
 		int right = bpp-left;
 		int r;
-		void (*fill_op)(unsigned long *dst, int dst_idx, unsigned long pat, 
-				int left, int right, u32 n) = NULL;
+		void (*fill_op)(unsigned long *dst, int dst_idx, 
+				unsigned long pat, int left, int right, 
+				u32 n) = NULL;
 		
 		switch (rect->rop) {
 		case ROP_XOR:
@@ -435,7 +442,8 @@
 		while (height--) {
 			dst += dst_idx >> SHIFT_PER_LONG;
 			dst_idx &= (BITS_PER_LONG-1);
-			fill_op(dst, dst_idx, pat, left, right, rect->width*bpp);
+			fill_op(dst, dst_idx, pat, left, right, 
+				rect->width*bpp);
 			r = (p->fix.line_length*8) % bpp;
 			pat = pat << (bpp-r) | pat >> r;
 			dst_idx += p->fix.line_length*8;
diff -Naur linux-2.5.56-fbdev/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.56-fbdev/drivers/video/cfbimgblt.c	2003-01-14 11:34:27.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-14 01:21:42.000000000 +0000
@@ -19,10 +19,6 @@
  *  up to the nearest byte. For example a bitmap 12 bits wide must be two 
  *  bytes width. 
  *
- *  FIXME
- *  The code for 24 bit is horrible. It copies byte by byte size instead of
- *  longs like the other sizes. Needs to be optimized.
- *  
  *  Tony: 
  *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
  *  up the code significantly.
@@ -32,7 +28,6 @@
  *
  *  Also need to add code to deal with cards endians that are different than
  *  the native cpu endians. I also need to deal with MSB position in the word.
- *
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -88,18 +83,21 @@
 
 #if defined (__BIG_ENDIAN)
 #define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
+#define LEFT_POS32(bpp)        (32 - bpp)
 #define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
 #define LEFT_POS(bpp)          (0)
+#define LEFT_POS32(bpp)        (0)
 #define NEXT_POS(pos, bpp)     ((pos) += (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
 #endif
 
-static inline void color_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				   unsigned long start_index, unsigned long pitch_index)
+static inline void color_imageblit(struct fb_image *image, struct fb_info *p, 
+				   u8 *dst1, unsigned long start_index, 
+				   unsigned long pitch_index)
 {
 	/* Draw the penguin */
 	unsigned long *dst, *dst2, color = 0, val, shift;
@@ -116,7 +114,8 @@
 		val = 0;
 		
 		if (start_index) {
-			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, 
+								start_index));
 
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
@@ -134,7 +133,8 @@
 				if (shift == null_bits)
 					val = 0;
 				else
-					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+					val = SHIFT_LOW(color, BITS_PER_LONG -
+							shift);
 			}
 			shift += bpp;
 			shift &= (BITS_PER_LONG - 1);
@@ -157,60 +157,64 @@
 	}
 }
 
-static inline void slow_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1,
-				  unsigned long fgcolor, unsigned long bgcolor, 
-				  unsigned long start_index, unsigned long pitch_index)
+static inline void slow_imageblit(struct fb_image *image, struct fb_info *p, 
+				  u8 *dst1, unsigned long fgcolor, 
+				  unsigned long bgcolor, 
+				  unsigned long start_index,
+				  unsigned long pitch_index)
 {
-	unsigned long i, j, l = 8;
+	unsigned long i, j, l;
 	unsigned long shift, color, bpp = p->var.bits_per_pixel;
 	unsigned long *dst, *dst2, val, pitch = p->fix.line_length;
 	unsigned long null_bits = BITS_PER_LONG - bpp;
+	unsigned long spitch = (image->width+7)/8;
 	u8 *src = image->data, *s;
 	
 	dst2 = (unsigned long *) dst1;
 
 	for (i = image->height; i--; ) {
-		shift = 0;
-		val = 0;
+		shift = val = 0;
+		l = 8;
 		j = image->width;
 		dst = (unsigned long *) dst1;
+		s = src;
 
 		/* write leading bits */
 		if (start_index) {
-			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, 
+								start_index));
 
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
 		}
+
 		while (j--) {
 			l--;
-			if (*src & (1 << l)) 
-				color = fgcolor;
-			else 
-				color = bgcolor;
+			color = (*s & (1 << l)) ? fgcolor : bgcolor;
 			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
-				if (shift == null_bits)
-					val = 0;
-				else
-					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+				val = (shift == null_bits) ? 
+					0 : SHIFT_LOW(color, BITS_PER_LONG - 
+						      shift);
 			}
 			shift += bpp;
 			shift &= (BITS_PER_LONG - 1);
-			if (!l) { l = 8; src++; };
+			if (!l) { l = 8; s++; };
 		}
+
 		/* write trailing bits */
  		if (shift) {
 			unsigned long end_mask = SHIFT_HIGH(~0UL, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
-		dst1 += pitch;	
 
+		dst1 += pitch;	
+		src += spitch;
 		if (pitch_index) {
 			dst2 += pitch;
 			dst1 = (char *) dst2;
@@ -223,26 +227,33 @@
 	}
 }
 
-static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				  unsigned long fgcolor, unsigned long bgcolor) 
+/*
+ * fast_imageblit - optimized monochrome color expansion
+ *
+ * Only if:  bits_per_pixel == 8, 16, or 32
+ *           image->width is divisible by pixel/dword (ppw);
+ *           fix->next_line is divisible by 4;
+ *           beginning and end of a scanline is dword aligned
+ */
+static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, 
+				  u8 *dst1, u32 fgcolor, u32 bgcolor) 
 {
-	int i, j, k, l = 8, n;
-	unsigned long bit_mask, end_mask, eorx; 
-	unsigned long fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
-	unsigned long tmp = (1 << bpp) - 1;
-	unsigned long ppw = BITS_PER_LONG/bpp, ppos;
-	unsigned long *dst;
+	int i, j, k; 
+	u32 bit_mask, end_mask, eorx, shift; 
+	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
+	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
+	u32 *dst;
 	u32 *tab = NULL;
-	char *src = image->data;
+	char *s = image->data, *src;
 		
-	switch (ppw) {
-	case 4:
+	switch (bpp) {
+	case 8:
 		tab = cfb_tab8;
 		break;
-	case 2:
+	case 16:
 		tab = cfb_tab16;
 		break;
-	case 1:
+	case 32:
 		tab = cfb_tab32;
 		break;
 	}
@@ -254,38 +265,20 @@
 		bgx |= bgcolor;
 	}
 	
-	n = ((image->width + 7) / 8);
-	pad = (n * 8) - image->width;
-	n = image->width % ppw;
-	
 	bit_mask = (1 << ppw) - 1;
 	eorx = fgx ^ bgx;
-
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (unsigned long *) dst1;
-		
+		dst = (u32 *) dst1; shift = 8; src = s;
 		for (j = k; j--; ) {
-			l -= ppw;
-			end_mask = tab[(*src >> l) & bit_mask]; 
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
-			if (!l) { l = 8; src++; }
+			shift -= ppw;
+			end_mask = tab[(*src >> shift) & bit_mask]; 
+			fb_writel((end_mask & eorx)^bgx, dst++);
+			if (!shift) { shift = 8; src++; }
 		}
-		if (n) {
-			end_mask = 0;	
-			ppos = LEFT_POS(bpp);
-			for (j = n; j > 0; j--) {
-				l--;
-				if (*src & (1 << l))
-					end_mask |= tmp << ppos;
-				NEXT_POS(ppos, bpp);
-				if (!l) { l = 8; src++; }
-			}
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
-		}
-		l -= pad;		
-		dst1 += p->fix.line_length;	
+		dst1 += p->fix.line_length;
+		s += spitch;
 	}
 }	
 	
@@ -299,8 +292,9 @@
 	vxres = p->var.xres_virtual;
 	vyres = p->var.yres_virtual;
 	/* 
-	 * We could use hardware clipping but on many cards you get around hardware
-	 * clipping by writing to framebuffer directly like we are doing here. 
+	 * We could use hardware clipping but on many cards you get around 
+	 * hardware clipping by writing to framebuffer directly like we are 
+	 * doing here. 
 	 */
 	if (image->dx > vxres ||
 	    image->dy > vyres)
@@ -323,21 +317,25 @@
 	bitstart &= ~(bpl - 1);
 	dst1 = p->screen_base + bitstart;
 
+	if (p->fbops->fb_sync)
+		p->fbops->fb_sync(p);
 	if (image->depth == 1) {
 		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
-			fgcolor = ((u32 *)(p->pseudo_palette))[image->fg_color];
-			bgcolor = ((u32 *)(p->pseudo_palette))[image->bg_color];
+			fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
+			bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
 		} else {
 			fgcolor = image->fg_color;
 			bgcolor = image->bg_color;
 		}	
 		
-		if (BITS_PER_LONG % bpp == 0 && !start_index && !pitch_index && 
-		    bpp >= 8 && bpp <= 32 && (image->width & 7) == 0) 
+		if (BITS_PER_LONG % bpp == 0 && !start_index && 
+		    !pitch_index && bpp >= 8 && bpp <= 32 && 
+		    (image->width & (32/bpp-1)) == 0) 
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
 		else 
-			slow_imageblit(image, p, dst1, fgcolor, bgcolor, start_index, pitch_index);
+			slow_imageblit(image, p, dst1, fgcolor, bgcolor, 
+				       start_index, pitch_index);
 	}
 	else if (image->depth == bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
diff -Naur linux-2.5.56-fbdev/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.56-fbdev/drivers/video/fbmem.c	2003-01-14 11:34:40.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-01-14 01:21:53.000000000 +0000
@@ -656,6 +656,8 @@
 	    count = info->fix.smem_len;
 	if (count + p > info->fix.smem_len)
 		count = info->fix.smem_len - p;
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
 	if (count) {
 	    char *base_addr;
 
@@ -692,6 +694,8 @@
 	    count = info->fix.smem_len - p;
 	    err = -ENOSPC;
 	}
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
 	if (count) {
 	    char *base_addr;
 



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
