From: Antonino Daplas <adaplas@pol.net>
Subject: [Patch 2] Console Rotation
Date: 09 Sep 2002 22:22:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031580820.633.11.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPPr-0002qk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:21:27 -0700
Received: from AP-202-70-99-9.compass.com.ph (AP-202-70-99-9.compass.com.ph [202.70.99.9])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id WAA90348
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Sep 2002 22:21:19 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

The patch (fb_drawing.diff) is an optional replacement to cfbimgblt.c,
cfbfillrect.c and cfbcopyarea.c.  Rotating the display CW or CCW will
expose some of the limitations (alignment and access) of the current
drawing functions because fontheight is very variable.  This also fixes
software clipping.

cfbcopyarea.c is just a 'copy 'n paste' of Geert's version I leached
from fbutils (I hope this is okay with you, Geert :)  The only changes
are using FB_WRITEL and FB_READL where appropriate. 

Tony 

<<------------------------------------------------------------------->> 
diff -Naur linux-2.5.33/drivers/video/cfbcopyarea.c linux/drivers/video/cfbcopyarea.c
--- linux-2.5.33/drivers/video/cfbcopyarea.c	Sun Sep  8 19:34:36 2002
+++ linux/drivers/video/cfbcopyarea.c	Sun Sep  8 19:48:05 2002
@@ -28,22 +28,319 @@
 #include <asm/io.h>
 #include <video/fbcon.h>
 
+#include "fbcon-rotate.h"
+
+#define LONG_MASK  (BITS_PER_LONG - 1)
+
 #if BITS_PER_LONG == 32
-#define FB_READ		fb_readl
-#define FB_WRITE	fb_writel
+#define FB_WRITEL fb_writel
+#define FB_READL  fb_readl
+#define SHIFT_PER_LONG 5
+#define BYTES_PER_LONG 4
 #else
-#define FB_READ		fb_readq
-#define FB_WRITE	fb_writeq
+#define FB_WRITEL fb_writeq
+#define FB_READL  fb_readq(x)
+#define SHIFT_PER_LONG 6
+#define BYTES_PER_LONG 8
 #endif
 
+static void bitcpy(unsigned long *dst, int dst_idx, const unsigned long *src,
+		   int src_idx, unsigned long n)
+{
+	unsigned long first, last;
+	int shift = dst_idx-src_idx, left, right;
+	unsigned long d0, d1;
+	int m;
+	
+	if (!n)
+		return;
+	
+	shift = dst_idx-src_idx;
+	first = ~0UL >> dst_idx;
+	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+	
+	if (!shift) {
+		// Same alignment for source and dest
+		
+		if (dst_idx+n <= BITS_PER_LONG) {
+			// Single word
+			if (last)
+				first &= last;
+			FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+		} else {
+			// Multiple destination words
+			// Leading bits
+			if (first) {
+				
+				FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+				dst++;
+				src++;
+				n -= BITS_PER_LONG-dst_idx;
+			}
+			
+			// Main chunk
+			n /= BITS_PER_LONG;
+			while (n >= 8) {
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				FB_WRITEL(*src++, dst++);
+				n -= 8;
+			}
+			while (n--)
+				FB_WRITEL(*src++, dst++);
+			// Trailing bits
+			if (last)
+				FB_WRITEL((*src & last) | (FB_READL(dst) & ~last), dst);
+		}
+	} else {
+		// Different alignment for source and dest
+		
+		right = shift & (BITS_PER_LONG-1);
+		left = -shift & (BITS_PER_LONG-1);
+		
+		if (dst_idx+n <= BITS_PER_LONG) {
+			// Single destination word
+			if (last)
+				first &= last;
+			if (shift > 0) {
+				// Single source word
+				FB_WRITEL(((*src >> right) & first) | (FB_READL(dst) & ~first), dst);
+			} else if (src_idx+n <= BITS_PER_LONG) {
+				// Single source word
+				FB_WRITEL(((*src << left) & first) | (FB_READL(dst) & ~first), dst);
+			} else {
+				// 2 source words
+				d0 = *src++;
+				d1 = *src;
+				FB_WRITEL(((d0 << left | d1 >> right) & first) | (FB_READL(dst) & ~first), dst);
+			}
+		} else {
+			// Multiple destination words
+			d0 = *src++;
+			// Leading bits
+			if (shift > 0) {
+				// Single source word
+				FB_WRITEL(((d0 >> right) & first) | (FB_READL(dst) & ~first), dst);
+				dst++;
+				n -= BITS_PER_LONG-dst_idx;
+			} else {
+				// 2 source words
+				d1 = *src++;
+				FB_WRITEL(((d0 << left | d1 >> right) & first) | (FB_READL(dst) & ~first), dst);
+				d0 = d1;
+				dst++;
+				n -= BITS_PER_LONG-dst_idx;
+			}
+			
+			// Main chunk
+			m = n % BITS_PER_LONG;
+			n /= BITS_PER_LONG;
+			while (n >= 4) {
+				d1 = *src++;
+				FB_WRITEL(d0 << left | d1 >> right, dst++);
+				d0 = d1;
+				d1 = *src++;
+				FB_WRITEL(d0 << left | d1 >> right, dst++);
+				d0 = d1;
+				d1 = *src++;
+				FB_WRITEL(d0 << left | d1 >> right, dst++);
+				d0 = d1;
+				d1 = *src++;
+				FB_WRITEL(d0 << left | d1 >> right, dst++);
+				d0 = d1;
+				n -= 4;
+			}
+			while (n--) {
+				d1 = *src++;
+				FB_WRITEL(d0 << left | d1 >> right, dst++);
+				d0 = d1;
+			}
+			
+			// Trailing bits
+			if (last) {
+				if (m <= right) {
+					// Single source word
+					FB_WRITEL(((d0 << left) & last) | (FB_READL(dst) & ~last), dst);
+				} else {
+					// 2 source words
+					d1 = *src;
+					FB_WRITEL(((d0 << left | d1 >> right) & last) | (FB_READL(dst) & ~last), dst);
+				}
+			}
+		}
+	}
+}
+
+static void bitcpy_rev(unsigned long *dst, int dst_idx,
+		       const unsigned long *src, int src_idx, unsigned long n)
+{
+	unsigned long first, last;
+	int shift = dst_idx-src_idx, left, right;
+	unsigned long d0, d1;
+	int m;
+	
+	if (!n)
+		return;
+	
+	dst += (n-1)/BITS_PER_LONG;
+	src += (n-1)/BITS_PER_LONG;
+	if ((n-1) % BITS_PER_LONG) {
+		dst_idx += (n-1) % BITS_PER_LONG;
+		dst += dst_idx >> SHIFT_PER_LONG;
+		dst_idx &= BITS_PER_LONG-1;
+		src_idx += (n-1) % BITS_PER_LONG;
+		src += src_idx >> SHIFT_PER_LONG;
+		src_idx &= BITS_PER_LONG-1;
+	}
+	
+	shift = dst_idx-src_idx;
+	first = ~0UL << (BITS_PER_LONG-1-dst_idx);
+	last = ~(~0UL << (BITS_PER_LONG-1-((dst_idx-n) % BITS_PER_LONG)));
+	
+	if (!shift) {
+		// Same alignment for source and dest
+		
+		if ((unsigned long)dst_idx+1 >= n) {
+			// Single word
+			if (last)
+				first &= last;
+			FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+		} else {
+			// Multiple destination words
+			// Leading bits
+			if (first) {
+				FB_WRITEL((*src & first) | (FB_READL(dst) & ~first), dst);
+				dst--;
+				src--;
+				n -= dst_idx+1;
+			}
+			
+			// Main chunk
+			n /= BITS_PER_LONG;
+			while (n >= 8) {
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				FB_WRITEL(*src--, dst--);
+				n -= 8;
+			}
+			while (n--)
+				FB_WRITEL(*src--, dst--);
+			
+			// Trailing bits
+			if (last)
+				FB_WRITEL((*src & last) | (FB_READL(dst) & ~last), dst);
+		}
+	} else {
+		// Different alignment for source and dest
+		
+		right = shift & (BITS_PER_LONG-1);
+		left = -shift & (BITS_PER_LONG-1);
+		
+		if ((unsigned long)dst_idx+1 >= n) {
+			// Single destination word
+			if (last)
+				first &= last;
+			if (shift < 0) {
+				// Single source word
+				FB_WRITEL((*src << left & first) | (FB_READL(dst) & ~first), dst);
+			} else if (1+(unsigned long)src_idx >= n) {
+				// Single source word
+				FB_WRITEL(((*src >> right) & first) | (FB_READL(dst) & ~first), dst);
+			} else {
+				// 2 source words
+				d0 = *src--;
+				d1 = *src;
+				FB_WRITEL(((d0 >> right | d1 << left) & first) | (FB_READL(dst) & ~first), dst);
+			}
+		} else {
+			// Multiple destination words
+			d0 = *src--;
+			// Leading bits
+			if (shift < 0) {
+				// Single source word
+				FB_WRITEL(((d0 << left) & first) | (FB_READL(dst) & ~first), dst);
+				dst--;
+				n -= dst_idx+1;
+			} else {
+				// 2 source words
+				d1 = *src--;
+				FB_WRITEL(((d0 >> right | d1 << left) & first) | (FB_READL(dst) & ~first), dst);
+				d0 = d1;
+				dst--;
+				n -= dst_idx+1;
+			}
+			
+			// Main chunk
+			m = n % BITS_PER_LONG;
+			n /= BITS_PER_LONG;
+			while (n >= 4) {
+				d1 = *src--;
+				FB_WRITEL(d0 >> right | d1 << left, dst--);
+				d0 = d1;
+				d1 = *src--;
+				FB_WRITEL(d0 >> right | d1 << left, dst--);
+				d0 = d1;
+				d1 = *src--;
+				FB_WRITEL(d0 >> right | d1 << left, dst--);
+				d0 = d1;
+				d1 = *src--;
+				FB_WRITEL(d0 >> right | d1 << left, dst--);
+				d0 = d1;
+				n -= 4;
+			}
+			while (n--) {
+				d1 = *src--;
+				FB_WRITEL(d0 >> right | d1 << left, dst--);
+				d0 = d1;
+			}
+			
+			// Trailing bits
+			if (last) {
+				if (m <= left) {
+					// Single source word
+					FB_WRITEL(((d0 >> right) & last) | (FB_READL(dst) & ~last), dst);
+				} else {
+					// 2 source words
+					d1 = *src;
+					FB_WRITEL(((d0 >> right | d1 << left) & last) |
+						  (FB_READL(dst) & ~last), dst);
+				}
+			}
+		}
+	}
+}
+
 void cfb_copyarea(struct fb_info *p, struct fb_copyarea *area)
 {
-	int x2, y2, lineincr, shift, shift_right, shift_left, old_dx, old_dy;
-	int j, linesize = p->fix.line_length, bpl = sizeof(unsigned long);
-	unsigned long start_index, end_index, start_mask, end_mask, last;
+	int x2, y2, old_dx, old_dy, vxres, vyres;
+	unsigned long next_line = p->fix.line_length;
+	int dst_idx = 0, src_idx = 0, rev_copy = 0;
 	unsigned long *dst = NULL, *src = NULL;
-	char *src1, *dst1;
-	int tmp, height;
+
+	vxres = p->var.xres_virtual;
+	vyres = p->var.yres_virtual;
+#ifdef FBCON_HAS_ROTATE
+	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
+		vxres = p->var.yres_virtual;
+		vyres = p->var.xres_virtual;
+	}
+#endif
+
+	if (area->dx > vxres || 
+	    area->sx > vxres ||
+	    area->dy > vyres ||
+	    area->sy > vyres)
+		return;
 
 	/* clip the destination */
 	old_dx = area->dx;
@@ -57,8 +354,8 @@
 	y2 = area->dy + area->height;
 	area->dx = area->dx > 0 ? area->dx : 0;
 	area->dy = area->dy > 0 ? area->dy : 0;
-	x2 = x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
-	y2 = y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
+	x2 = x2 < vxres ? x2 : vxres;
+	y2 = y2 < vyres ? y2 : vyres;
 	area->width = x2 - area->dx;
 	area->height = y2 - area->dy;
 
@@ -66,165 +363,45 @@
 	area->sx += (area->dx - old_dx);
 	area->sy += (area->dy - old_dy);
 
-	height = area->height;
-
 	/* the source must be completely inside the virtual screen */
 	if (area->sx < 0 || area->sy < 0 ||
-	    (area->sx + area->width) > p->var.xres_virtual ||
-	    (area->sy + area->height) > p->var.yres_virtual)
+	    (area->sx + area->width) > vxres ||
+	    (area->sy + area->height) > vyres)
 		return;
 
-	if (area->dy < area->sy
-	    || (area->dy == area->sy && area->dx < area->sx)) {
-		/* start at the top */
-		src1 = p->screen_base + area->sy * linesize +
-		    ((area->sx * p->var.bits_per_pixel) >> 3);
-		dst1 = p->screen_base + area->dy * linesize +
-		    ((area->dx * p->var.bits_per_pixel) >> 3);
-		lineincr = linesize;
-	} else {
-		/* start at the bottom */
-		src1 = p->screen_base + (area->sy + area->height-1) * linesize
-			+ (((area->sx + area->width - 1) * p->var.bits_per_pixel) >> 3);
-		dst1 = p->screen_base + (area->dy + area->height-1) * linesize
-			+ (((area->dx + area->width - 1) * p->var.bits_per_pixel) >> 3);
-		lineincr = -linesize;
+	if (area->dy > area->sy || (area->dy == area->sy && area->dx > area->sx)) {
+		area->dy += area->height;
+		area->sy += area->height;
+		rev_copy = 1;
 	}
-
-	if ((BITS_PER_LONG % p->var.bits_per_pixel) == 0) {
-		int ppw = BITS_PER_LONG / p->var.bits_per_pixel;
-		int n = ((area->width * p->var.bits_per_pixel) >> 3);
-
-		start_index = ((unsigned long) src1 & (bpl - 1));
-		end_index = ((unsigned long) (src1 + n) & (bpl - 1));
-		shift = ((unsigned long) dst1 & (bpl - 1)) -
-		    	((unsigned long) src1 & (bpl - 1));
-		start_mask = end_mask = 0;
-
-		if (start_index) {
-			start_mask = -1 >> (start_index << 3);
-			n -= (bpl - start_index);
+	
+	dst = src = (unsigned long *)((unsigned long)p->screen_base & ~(BYTES_PER_LONG-1));
+	dst_idx = src_idx = (unsigned long)p->screen_base & (BYTES_PER_LONG-1);
+	dst_idx += area->dy*next_line*8+area->dx*p->var.bits_per_pixel;
+	src_idx += area->sy*next_line*8+area->sx*p->var.bits_per_pixel;
+
+	if (rev_copy) {
+		while (area->height--) {
+			dst_idx -= next_line*8;
+			src_idx -= next_line*8;
+			dst += dst_idx >> SHIFT_PER_LONG;
+			dst_idx &= (BYTES_PER_LONG-1);
+			src += src_idx >> SHIFT_PER_LONG;
+			src_idx &= (BYTES_PER_LONG-1);
+			bitcpy_rev((unsigned long *)dst, dst_idx, (unsigned long *)src,
+				   src_idx, area->width*p->var.bits_per_pixel);
 		}
-
-		if (end_index) {
-			end_mask = -1 << ((bpl - end_index) << 3);
-			n -= end_index;
-		}
-		n /= bpl;
-
-		if (n <= 0) {
-			if (start_mask) {
-				if (end_mask)
-					end_mask &= start_mask;
-				else
-					end_mask = start_mask;
-				start_mask = 0;
-			}
-			n = 0;
-		}
-
-		if (shift) {
-			if (shift > 0) {
-				/* dest is over to right more */
-				shift_right =
-				    shift * p->var.bits_per_pixel;
-				shift_left =
-				    (ppw - shift) * p->var.bits_per_pixel;
-			} else {
-				/* source is to the right more */
-				shift_right =
-				    (ppw + shift) * p->var.bits_per_pixel;
-				shift_left =
-				    -shift * p->var.bits_per_pixel;
-			}
-			/* general case, positive increment */
-			if (lineincr > 0) {
-				if (shift < 0)
-					n++;
-				do {
-					dst = (unsigned long *) dst1;
-					src = (unsigned long *) src1;
-
-					last = (FB_READ(src) & start_mask);
-
-					if (shift > 0)
-						FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
-					for (j = 0; j < n; j++) {
-						dst++;
-						tmp = FB_READ(src);
-						src++;
-						FB_WRITE((last << shift_left) | (tmp >> shift_right), dst);
-						last = tmp;
-						src++;
-					}
-					FB_WRITE(FB_READ(dst) | (last << shift_left), dst);
-					src1 += lineincr;
-					dst1 += lineincr;
-				} while (--height);
-			} else {
-				/* general case, negative increment */
-				if (shift > 0)
-					n++;
-				do {
-					dst = (unsigned long *) dst1;
-					src = (unsigned long *) src1;
-
-					last = (FB_READ(src) & end_mask);
-
-					if (shift < 0)
-						FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
-					for (j = 0; j < n; j++) {
-						dst--;
-						tmp = FB_READ(src);
-						src--;
-						FB_WRITE((tmp << shift_left) | (last >> shift_right), dst);
-						last = tmp;
-						src--;
-					}
-					FB_WRITE(FB_READ(dst) | (last >> shift_right), dst);
-					src1 += lineincr;
-					dst1 += lineincr;
-				} while (--height);
-			}
-		} else {
-			/* no shift needed */
-			if (lineincr > 0) {
-				/* positive increment */
-				do {
-					dst = (unsigned long *) (dst1 - start_index);
-					src = (unsigned long *) (src1 - start_index);
-
-					if (start_mask)
-						FB_WRITE(FB_READ(src) | start_mask, dst);
-
-					for (j = 0; j < n; j++) {
-						FB_WRITE(FB_READ(src), dst);
-						dst++;
-						src++;
-					}
-
-					if (end_mask)
-						FB_WRITE(FB_READ(src) | end_mask, dst);
-					src1 += lineincr;
-					dst1 += lineincr;
-				} while (--height);
-			} else {
-				/* negative increment */
-				do {
-					dst = (unsigned long *) dst1;
-					src = (unsigned long *) src1;
-
-					if (start_mask)
-						FB_WRITE(FB_READ(src) | start_mask, dst);
-					for (j = 0; j < n; j++) {
-						FB_WRITE(FB_READ(src), dst);
-						dst--;
-						src--;
-					}
-					src1 += lineincr;
-					dst1 += lineincr;
-				} while (--height);
-			}
+	}
+	else {
+		while (area->height--) {
+			dst += dst_idx >> SHIFT_PER_LONG;
+			dst_idx &= (BYTES_PER_LONG-1);
+			src += src_idx >> SHIFT_PER_LONG;
+			src_idx &= (BYTES_PER_LONG-1);
+			bitcpy((unsigned long *)dst, dst_idx, (unsigned long *)src,
+			       src_idx, area->width*p->var.bits_per_pixel);
+			dst_idx += next_line*8;
+			src_idx += next_line*8;
 		}
 	}
-}
+}	
diff -Naur linux-2.5.33/drivers/video/cfbfillrect.c linux/drivers/video/cfbfillrect.c
--- linux-2.5.33/drivers/video/cfbfillrect.c	Sun Sep  8 19:34:36 2002
+++ linux/drivers/video/cfbfillrect.c	Sun Sep  8 19:47:59 2002
@@ -22,168 +22,167 @@
 #include <asm/types.h>
 #include <video/fbcon.h>
 
+#include "fbcon-rotate.h"
+
 #if BITS_PER_LONG == 32
-#define FB_READ		fb_readl
-#define FB_WRITE	fb_writel
+#define FB_WRITEL fb_writel
+#define FB_READL  fb_readl
 #else
-#define FB_READ		fb_readq
-#define FB_WRITE	fb_writeq
+#define FB_WRITEL fb_writeq
+#define FB_READL  fb_readq
+#endif
+
+#if defined (__BIG_ENDIAN)
+#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
+#define SHIFT_LOW(val, bits)   ((val) << (bits))
+#else
+#define SHIFT_HIGH(val, bits)  ((val) << (bits))
+#define SHIFT_LOW(val, bits)   ((val) >> (bits))
 #endif
 
 void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect)
 {
-	unsigned long start_index, end_index, start_mask = 0, end_mask = 0;
-	unsigned long height, ppw, fg, fgcolor;
-	int i, n, x2, y2, linesize = p->fix.line_length;
-	int bpl = sizeof(unsigned long);
-	unsigned long *dst;
-	char *dst1;
+	unsigned long start_index, pitch_index;
+	unsigned long height, fg, bitstart, shift, color;
+	unsigned long bpp = p->var.bits_per_pixel;
+	unsigned long null_bits = BITS_PER_LONG - bpp;
+	unsigned long n, x2, y2, vxres, vyres, linesize = p->fix.line_length;
+	unsigned long bpl = sizeof(unsigned long);
+	unsigned long *dst = NULL;
+	char *dst1, *dst2;
+
+	vxres = p->var.xres_virtual;
+	vyres = p->var.yres_virtual;
+#ifdef FBCON_HAS_ROTATE
+	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
+		vxres = p->var.yres_virtual;
+		vyres = p->var.xres_virtual;
+	}
+#endif
 
-	if (!rect->width || !rect->height)
+	if (!rect->width || !rect->height ||
+	    rect->dx > vxres ||
+	    rect->dy > vyres)
 		return;
 
 	/* We could use hardware clipping but on many cards you get around
 	 * hardware clipping by writing to framebuffer directly. */
+
 	x2 = rect->dx + rect->width;
 	y2 = rect->dy + rect->height;
-	x2 = x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
-	y2 = y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
+	x2 = x2 < vxres ? x2 : vxres;
+	y2 = y2 < vyres ? y2 : vyres;
 	rect->width = x2 - rect->dx;
 	height = y2 - rect->dy;
 
-	/* Size of the scanline in bytes */
-	n = (rect->width * (p->var.bits_per_pixel >> 3));
-	ppw = BITS_PER_LONG / p->var.bits_per_pixel;
-
-	dst1 = p->screen_base + (rect->dy * linesize) +
-	    	(rect->dx * (p->var.bits_per_pixel >> 3));
-	start_index = ((unsigned long) dst1 & (bpl - 1));
-	end_index = ((unsigned long) (dst1 + n) & (bpl - 1));
 
-	if (p->fix.visual == FB_VISUAL_TRUECOLOR)
-		fg = fgcolor = ((u32 *) (p->pseudo_palette))[rect->color];
+	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
+		fg = ((u32 *) (p->pseudo_palette))[rect->color];
 	else
-		fg = fgcolor = rect->color;
-
-	for (i = 0; i < ppw - 1; i++) {
-		fg <<= p->var.bits_per_pixel;
-		fg |= fgcolor;
-	}
-
-	if (start_index) {
-		start_mask = fg << (start_index << 3);
-		n -= (bpl - start_index);
-	}
-
-	if (end_index) {
-		end_mask = fg >> ((bpl - end_index) << 3);
-		n -= end_index;
-	}
-
-	n = n / bpl;
-
-	if (n <= 0) {
-		if (start_mask) {
-			if (end_mask)
-				end_mask &= start_mask;
-			else
-				end_mask = start_mask;
-			start_mask = 0;
-		}
-		n = 0;
-	}
-
-	if ((BITS_PER_LONG % p->var.bits_per_pixel) == 0) {
-		switch (rect->rop) {
-		case ROP_COPY:
-			do {
-				/* Word align to increases performace :-) */
-				dst = (unsigned long *) (dst1 - start_index);
-
-				if (start_mask) {
-					FB_WRITE(FB_READ(dst) |
-						  start_mask, dst);
-					dst++;
-				}
-
-				for (i = 0; i < n; i++) {
-					FB_WRITE(fg, dst);
-					dst++;
-				}
-
-				if (end_mask)
-					FB_WRITE(FB_READ(dst) | end_mask,
-						  dst);
-				dst1 += linesize;
-			} while (--height);
-			break;
-		case ROP_XOR:
-			do {
-				dst = (unsigned long *) (dst1 - start_index);
-
-				if (start_mask) {
-					FB_WRITE(FB_READ(dst) ^
-						  start_mask, dst);
-					dst++;
-				}
-
-				for (i = 0; i < n; i++) {
-					FB_WRITE(FB_READ(dst) ^ fg, dst);
-					dst++;
-				}
+		fg = rect->color;
 
-				if (end_mask) {
-					FB_WRITE(FB_READ(dst) ^ end_mask,
-						  dst);
-				}
+	bitstart = (((rect->dy * linesize) * 8) + 
+		    rect->dx * bpp);
+	
+	start_index = bitstart & (BITS_PER_LONG - 1);
+
+	/* line_length not a multiple of an unsigned long? */
+	pitch_index = (linesize & (bpl - 1)) * 8;
+
+	bitstart /= 8;
+	bitstart &= ~(bpl - 1);
+	dst1 = dst2 = p->screen_base + bitstart;
+
+	switch (rect->rop) {
+	case ROP_COPY:
+		do {
+			dst = (unsigned long *) dst1;
+			shift = 0;
+			color = 0;
+			n = rect->width;
+
+			/* 
+			 * read leading bits
+			 */
+			if (start_index) {
+				unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+				
+				color = FB_READL(dst) & start_mask;
+				shift = start_index;
+			}
+
+			while (n--) {
+				color |= SHIFT_HIGH(fg, shift);
+				if (shift >= null_bits) {
+					FB_WRITEL(color, dst++);
+					if (shift == null_bits)
+						color = 0;
+					else
+						color = SHIFT_LOW(color, BITS_PER_LONG - shift);
+				}
+				shift += bpp;
+				shift &= (BITS_PER_LONG - 1);
+			}
+			
+			/* 
+			 * write trailing bits
+			 */
+			if (shift) {
+				unsigned long end_mask = SHIFT_HIGH(~0UL, shift);
+
+				FB_WRITEL((FB_READL(dst) & end_mask) | color, dst);
+			}
+			
+			if (!pitch_index) {
 				dst1 += linesize;
-			} while (--height);
-			break;
-		}
-	} else {
-		/* Odd modes like 24 or 80 bits per pixel */
-		start_mask = fg >> (start_index * p->var.bits_per_pixel);
-		end_mask = fg << (end_index * p->var.bits_per_pixel);
-		/* start_mask =& PFILL24(x1,fg);
-		   end_mask_or = end_mask & PFILL24(x1+width-1,fg); */
-
-		n = (rect->width - start_index - end_index) / ppw;
-
-		switch (rect->rop) {
-		case ROP_COPY:
-			do {
-				dst = (unsigned long *) dst1;
-				if (start_mask)
-					*dst |= start_mask;
-				if ((start_index + rect->width) > ppw)
-					dst++;
+			}
+			else {
+				dst2 += linesize;
+				dst1 = dst2;
+				(unsigned long) dst1 &= ~(bpl - 1);
+				start_index += pitch_index;
+				start_index &= BITS_PER_LONG - 1;
+			}
+
+		} while (--height);
+		break;
+	case ROP_XOR:
+		do {
+			dst = (unsigned long *) dst1;
+			shift = start_index;
+			color = 0;
+			n = rect->width;
+
+			while (n--) {
+				color |= SHIFT_HIGH(fg, shift);
+				if (shift >= null_bits) {
+					FB_WRITEL(FB_READL(dst) ^ color, dst);
+					dst++;
+					if (shift == null_bits)
+						color = 0;
+					else
+						color = SHIFT_LOW(color, BITS_PER_LONG - shift);
+				}
+				shift += bpp;
+				shift &= (BITS_PER_LONG - 1);
+			}
+			if (shift) 
+				FB_WRITEL(FB_READL(dst) ^ color, dst);
 
-				/* XXX: slow */
-				for (i = 0; i < n; i++) {
-					*dst++ = fg;
-				}
-				if (end_mask)
-					*dst |= end_mask;
-				dst1 += linesize;
-			} while (--height);
-			break;
-		case ROP_XOR:
-			do {
-				dst = (unsigned long *) dst1;
-				if (start_mask)
-					*dst ^= start_mask;
-				if ((start_mask + rect->width) > ppw)
-					dst++;
-
-				for (i = 0; i < n; i++) {
-					*dst++ ^= fg;	/* PFILL24(fg,x1+i); */
-				}
-				if (end_mask)
-					*dst ^= end_mask;
+			if (!pitch_index) {
 				dst1 += linesize;
-			} while (--height);
-			break;
-		}
+			}
+			else {
+				dst2 += linesize;
+				dst1 = dst2;
+				(unsigned long) dst1 &= ~(bpl - 1);
+				start_index += pitch_index;
+				start_index &= BITS_PER_LONG - 1;
+			}
+		} while (--height);
+		break;
 	}
+	
 	return;
 }
diff -Naur linux-2.5.33/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.33/drivers/video/cfbimgblt.c	Sun Sep  8 19:31:34 2002
+++ linux/drivers/video/cfbimgblt.c	Sun Sep  8 19:47:55 2002
@@ -22,6 +22,13 @@
  *  FIXME
  *  The code for 24 bit is horrible. It copies byte by byte size instead of
  *  longs like the other sizes. Needs to be optimized.
+ *  
+ *  Tony: 
+ *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
+ *  up the code significantly.
+ *  
+ *  Code for depths not multiples of BITS_PER_LONG is still kludgy, which is
+ *  still processed a bit at a time.   
  *
  *  Also need to add code to deal with cards endians that are different than
  *  the native cpu endians. I also need to deal with MSB position in the word.
@@ -32,6 +39,7 @@
 #include <asm/types.h>
 
 #include <video/fbcon.h>
+#include "fbcon-rotate.h"
 
 #define DEBUG
 
@@ -41,91 +49,303 @@
 #define DPRINTK(fmt, args...)
 #endif
 
+static u32 cfb_tab8[] = {
+#if defined(__BIG_ENDIAN)
+    0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
+    0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
+    0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
+    0xffff0000,0xffff00ff,0xffffff00,0xffffffff
+#elif defined(__LITTLE_ENDIAN)
+    0x00000000,0xff000000,0x00ff0000,0xffff0000,
+    0x0000ff00,0xff00ff00,0x00ffff00,0xffffff00,
+    0x000000ff,0xff0000ff,0x00ff00ff,0xffff00ff,
+    0x0000ffff,0xff00ffff,0x00ffffff,0xffffffff
+#else
+#error FIXME: No endianness??
+#endif
+};
+
+static u32 cfb_tab16[] = {
+#if defined(__BIG_ENDIAN)
+    0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
+#elif defined(__LITTLE_ENDIAN)
+    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
+#else
+#error FIXME: No endianness??
+#endif
+};
+
+static u32 cfb_tab32[] = {
+	0x00000000, 0xffffffff
+};
+
+#if BITS_PER_LONG == 32
+#define FB_WRITEL fb_writel
+#define FB_READL  fb_readl
+#else
+#define FB_WRITEL fb_writeq
+#define FB_READL  fb_readq
+#endif 
+
+#if defined (__BIG_ENDIAN)
+#define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
+#define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
+#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
+#define SHIFT_LOW(val, bits)   ((val) << (bits))
+#else
+#define LEFT_POS(bpp)          (0)
+#define NEXT_POS(pos, bpp)     ((pos) += (bpp))
+#define SHIFT_HIGH(val, bits)  ((val) << (bits))
+#define SHIFT_LOW(val, bits)   ((val) >> (bits))
+#endif
+
+static inline void color_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
+				   unsigned long start_index, unsigned long pitch_index)
+{
+	/* Draw the penguin */
+	int i, n;
+	unsigned long bitmask = SHIFT_LOW(~0UL, BITS_PER_LONG - p->var.bits_per_pixel);
+	unsigned long *palette = (unsigned long *) p->pseudo_palette;
+	unsigned long *dst, *dst2, color = 0, val, shift;
+	unsigned long null_bits = BITS_PER_LONG - p->var.bits_per_pixel; 
+	u8 *src = image->data;
+
+	dst2 = (unsigned long *) dst1;
+	for (i = image->height; i--; ) {
+		n = image->width;
+		dst = (unsigned long *) dst1;
+		shift = 0;
+		val = 0;
+		
+		if (start_index) {
+			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+
+			val = FB_READL(dst) & start_mask;
+			shift = start_index;
+		}
+		while (n--) {
+			if (p->fix.visual == FB_VISUAL_PSEUDOCOLOR)
+				color = *src & bitmask; 
+			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
+				color = palette[*src] & bitmask; 
+			val |= SHIFT_HIGH(color, shift);
+			if (shift >= null_bits) {
+				FB_WRITEL(val, dst++);
+				if (shift == null_bits)
+					val = 0;
+				else
+					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+			}
+			shift += p->var.bits_per_pixel;
+			shift &= (BITS_PER_LONG - 1);
+			src++;
+		}
+		if (shift) {
+			unsigned long  end_mask = SHIFT_HIGH(~0UL, shift);
+
+			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
+		}
+		dst1 += p->fix.line_length;
+		if (pitch_index) {
+			dst2 += p->fix.line_length;
+			dst1 = (char *) dst2;
+			(unsigned long) dst1 &= ~(sizeof(unsigned long) - 1);
+
+			start_index += pitch_index;
+			start_index &= BITS_PER_LONG - 1;
+		}
+	}
+}
+
+static inline void slow_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1,
+				  unsigned long fgcolor, unsigned long bgcolor, 
+				  unsigned long start_index, unsigned long pitch_index)
+{
+	unsigned long i, j, l = 8;
+	unsigned long shift, color, bpp = p->var.bits_per_pixel;
+	unsigned long *dst, *dst2, val, pitch = p->fix.line_length;
+	unsigned long null_bits = BITS_PER_LONG - bpp;
+	u8 *src = image->data;
+	
+	dst2 = (unsigned long *) dst1;
+
+	for (i = image->height; i--; ) {
+		shift = 0;
+		val = 0;
+		j = image->width;
+		dst = (unsigned long *) dst1;
+
+		/* write start bits, if any */
+		if (start_index) {
+			unsigned long start_mask = ~(SHIFT_HIGH(~0UL, start_index));
+
+			val = FB_READL(dst) & start_mask;
+			shift = start_index;
+		}
+		while (j--) {
+			l--;
+			if (*src & (1 << l)) 
+				color = fgcolor;
+			else 
+				color = bgcolor;
+			val |= SHIFT_HIGH(color, shift);
+			
+			/* Did the bitshift spill bits to the next long? */
+			if (shift >= null_bits) {
+				FB_WRITEL(val, dst++);
+				if (shift == null_bits)
+					val = 0;
+				else
+					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
+			}
+			shift += bpp;
+			shift &= (BITS_PER_LONG - 1);
+			if (!l) { l = 8; src++; };
+		}
+		/* write end bits, if any*/
+ 		if (shift) {
+			unsigned long end_mask = SHIFT_HIGH(~0UL, shift);
+
+			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
+		}
+		dst1 += pitch;	
+
+		if (pitch_index) {
+			dst2 += pitch;
+			dst1 = (char *) dst2;
+			(unsigned long) dst1 &= ~(sizeof(unsigned long) - 1);
+
+			start_index += pitch_index;
+			start_index &= BITS_PER_LONG - 1;
+		}
+		
+	}
+}
+
+static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
+				  unsigned long fgcolor, unsigned long bgcolor) 
+{
+	int i, j, k, l = 8, n;
+	unsigned long bit_mask, end_mask, eorx; 
+	unsigned long fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
+	unsigned long tmp = (1 << bpp) - 1;
+	unsigned long ppw = BITS_PER_LONG/bpp, ppos;
+	unsigned long *dst;
+	u32 *tab = NULL;
+	char *src = image->data;
+		
+	switch (ppw) {
+	case 4:
+		tab = cfb_tab8;
+		break;
+	case 2:
+		tab = cfb_tab16;
+		break;
+	case 1:
+		tab = cfb_tab32;
+		break;
+	}
+
+	for (i = ppw-1; i--; ) {
+		fgx <<= bpp;
+		bgx <<= bpp;
+		fgx |= fgcolor;
+		bgx |= bgcolor;
+	}
+	
+	n = ((image->width + 7) / 8);
+	pad = (n * 8) - image->width;
+	n = image->width % ppw;
+	
+	bit_mask = (1 << ppw) - 1;
+	eorx = fgx ^ bgx;
+
+	k = image->width/ppw;
+
+	for (i = image->height; i--; ) {
+		dst = (unsigned long *) dst1;
+		
+		for (j = k; j--; ) {
+			l -= ppw;
+			end_mask = tab[(*src >> l) & bit_mask]; 
+			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			if (!l) { l = 8; src++; }
+		}
+		if (n) {
+			end_mask = 0;	
+			ppos = LEFT_POS(bpp);
+			for (j = n; j > 0; j--) {
+				l--;
+				if (*src & (1 << l))
+					end_mask |= tmp << ppos;
+				NEXT_POS(ppos, bpp);
+				if (!l) { l = 8; src++; }
+			}
+			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+		}
+		l -= pad;		
+		dst1 += p->fix.line_length;	
+	}
+}	
+	
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
-	int pad, ppw;
-	int x2, y2, n, i, j, k, l = 7;
-	unsigned long tmp = ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
-	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;	
-	unsigned long end_mask;
-	unsigned long *dst = NULL;
+	int x2, y2, vxres, vyres;
+	unsigned long fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
+	unsigned long bpl = sizeof(unsigned long), bpp = p->var.bits_per_pixel;
 	u8 *dst1;
-	u8 *src;
+
+	vxres = p->var.xres_virtual;
+	vyres = p->var.yres_virtual;
+#ifdef FBCON_HAS_ROTATE
+	if (p->var.vmode & (FB_VMODE_ROTATE_CW | FB_VMODE_ROTATE_CCW)) {
+		vxres = p->var.yres_virtual;
+		vyres = p->var.xres_virtual;
+	}
+#endif
 
 	/* 
 	 * We could use hardware clipping but on many cards you get around hardware
 	 * clipping by writing to framebuffer directly like we are doing here. 
 	 */
+	if (image->dx > vxres ||
+	    image->dy > vyres)
+		return;
+
 	x2 = image->dx + image->width;
 	y2 = image->dy + image->height;
 	image->dx = image->dx > 0 ? image->dx : 0;
 	image->dy = image->dy > 0 ? image->dy : 0;
-	x2 = x2 < p->var.xres_virtual ? x2 : p->var.xres_virtual;
-	y2 = y2 < p->var.yres_virtual ? y2 : p->var.yres_virtual;
+	x2 = x2 < vxres ? x2 : vxres;
+	y2 = y2 < vyres ? y2 : vyres;
 	image->width  = x2 - image->dx;
 	image->height = y2 - image->dy;
-  
-	dst1 = p->screen_base + image->dy * p->fix.line_length + 
-		((image->dx * p->var.bits_per_pixel) >> 3);
-  
-	ppw = BITS_PER_LONG/p->var.bits_per_pixel;
 
-	src = image->data;	
+	bitstart = (image->dy * p->fix.line_length * 8) + (image->dx * bpp);
+	start_index = bitstart & (BITS_PER_LONG - 1);
+	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
 
-	if (image->depth == 1) {
+	bitstart /= 8;
+	bitstart &= ~(bpl - 1);
+	dst1 = p->screen_base + bitstart;
 
-		if (p->fix.visual == FB_VISUAL_TRUECOLOR) {
-			fgx = fgcolor = ((u32 *)(p->pseudo_palette))[image->fg_color];
-			bgx = bgcolor = ((u32 *)(p->pseudo_palette))[image->bg_color];
+	if (image->depth == 1) {
+		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+			fgcolor = ((u32 *)(p->pseudo_palette))[image->fg_color];
+			bgcolor = ((u32 *)(p->pseudo_palette))[image->bg_color];
 		} else {
-			fgx = fgcolor = image->fg_color;
-			bgx = bgcolor = image->bg_color;
+			fgcolor = image->fg_color;
+			bgcolor = image->bg_color;
 		}	
- 
-		for (i = 0; i < ppw-1; i++) {
-			fgx <<= p->var.bits_per_pixel;
-			bgx <<= p->var.bits_per_pixel;
-			fgx |= fgcolor;
-			bgx |= bgcolor;
-		}
-		eorx = fgx ^ bgx;
-		n = ((image->width + 7) >> 3);
-		pad = (n << 3) - image->width;
-		n = image->width % ppw;
 
-		for (i = 0; i < image->height; i++) {
-			dst = (unsigned long *) dst1;
-		
-			for (j = image->width/ppw; j > 0; j--) {
-				end_mask = 0;
-		
-				for (k = ppw; k > 0; k--) {
-					if (test_bit(l, (unsigned long *) src))
-						end_mask |= (tmp >> (p->var.bits_per_pixel*(k-1)));
-					l--;
-					if (l < 0) { l = 7; src++; }
-				}
-				fb_writel((end_mask & eorx)^bgx, dst);
-				dst++;
-			}
-		
-			if (n) {
-				end_mask = 0;	
-				for (j = n; j > 0; j--) {
-					if (test_bit(l, (unsigned long *) src))
-						end_mask |= (tmp >> (p->var.bits_per_pixel*(j-1)));
-					l--;
-					if (l < 0) { l = 7; src++; }
-				}
-				fb_writel((end_mask & eorx)^bgx, dst);
-				dst++;
-			}
-			l -= pad;		
-			dst1 += p->fix.line_length;	
-		}	
-	} else {
-		/* Draw the penguin */
-		n = ((image->width * p->var.bits_per_pixel) >> 3);
-		end_mask = 0;
+		if (BITS_PER_LONG % bpp == 0 && !start_index && !pitch_index && 
+		    bpp >= 8 && bpp <= 32 && (image->width & 7) == 0) 
+			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
+		else 
+			slow_imageblit(image, p, dst1, fgcolor, bgcolor, start_index, pitch_index);
 	}
+	else if (image->depth == bpp) 
+		color_imageblit(image, p, dst1, start_index, pitch_index);
 }



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
