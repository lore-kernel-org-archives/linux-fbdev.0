From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [patch] generic framebuffer support, cleanups
 and buglets with BPP < 32 (fwd)
Date: Wed, 16 Feb 2005 22:38:08 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502162237480.25965@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0502161022440.12747@numbat.sonytel.be>
 <200502162155.53719.adaplas@hotpop.com> <200502161506.45868.eckhardt@satorlaser.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1XoR-0006Vg-A1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:38:27 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1XoK-000500-TT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 14:38:27 -0800
In-Reply-To: <200502161506.45868.eckhardt@satorlaser.com>
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
To: Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Oop.s forgot the patch.

diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/cfbcopyarea.c fbdev-2.6/drivers/video/cfbcopyarea.c
--- linus-2.6/drivers/video/cfbcopyarea.c	2005-02-15 13:52:42.000000000 -0800
+++ fbdev-2.6/drivers/video/cfbcopyarea.c	2005-02-16 13:08:35.000000000 -0800
@@ -1,25 +1,29 @@
 /*
  *  Generic function for frame buffer with packed pixels of any depth.
  *
- *      Copyright (C)  June 1999 James Simmons
+ *      Copyright (C)  1999-2005 James Simmons <jsimmons@www.infradead.org>
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive for
  *  more details.
  *
  * NOTES:
- * 
- *  This is for cfb packed pixels. Iplan and such are incorporated in the 
+ *
+ *  This is for cfb packed pixels. Iplan and such are incorporated in the
  *  drivers that need them.
- * 
+ *
  *  FIXME
- *  The code for 24 bit is horrible. It copies byte by byte size instead of 
- *  longs like the other sizes. Needs to be optimized. 
  *
- *  Also need to add code to deal with cards endians that are different than 
+ *  Also need to add code to deal with cards endians that are different than
  *  the native cpu endians. I also need to deal with MSB position in the word.
- *  
+ *
+ *  The two functions or copying forward and backward could be split up like
+ *  the ones for filling, i.e. in aligned and unaligned versions. This would
+ *  help moving some redundant computations and branches out of the loop, too.
  */
+
+
+
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -29,58 +33,61 @@
 #include <asm/types.h>
 #include <asm/io.h>
 
-#define LONG_MASK  (BITS_PER_LONG - 1)
-
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-#define SHIFT_PER_LONG 5
-#define BYTES_PER_LONG 4
+#  define FB_WRITEL fb_writel
+#  define FB_READL  fb_readl
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
-#define SHIFT_PER_LONG 6
-#define BYTES_PER_LONG 8
+#  define FB_WRITEL fb_writeq
+#  define FB_READL  fb_readq
 #endif
 
-static void bitcpy(unsigned long __iomem *dst, int dst_idx,
-		   const unsigned long __iomem *src, int src_idx,
-		   unsigned long n)
+    /*
+     *  Compose two values, using a bitmask as decision value
+     *  This is equivalent to (a & mask) | (b & ~mask)
+     */
+
+static inline unsigned long
+comp(unsigned long a, unsigned long b, unsigned long mask)
+{
+    return ((a ^ b) & mask) ^ b;
+}
+
+    /*
+     *  Generic bitwise copy algorithm
+     */
+
+static void
+bitcpy(unsigned long __iomem *dst, int dst_idx, const unsigned long __iomem *src,
+	int src_idx, int bits, unsigned n)
 {
 	unsigned long first, last;
-	int shift = dst_idx-src_idx, left, right;
-	unsigned long d0, d1;
-	int m;
-	
-	if (!n)
-		return;
-	
-	shift = dst_idx-src_idx;
+	int const shift = dst_idx-src_idx;
+	int left, right;
+
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
+	last = ~(~0UL >> ((dst_idx+n) % bits));
+
 	if (!shift) {
 		// Same alignment for source and dest
-		
-		if (dst_idx+n <= BITS_PER_LONG) {
+
+		if (dst_idx+n <= bits) {
 			// Single word
 			if (last)
 				first &= last;
-			FB_WRITEL((FB_READL(src) & first) | (FB_READL(dst) & ~first), dst);
+			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 		} else {
 			// Multiple destination words
+
 			// Leading bits
-			if (first) {
-				
-				FB_WRITEL((FB_READL(src) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+			if (first != ~0UL) {
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 				dst++;
 				src++;
-				n -= BITS_PER_LONG-dst_idx;
+				n -= bits - dst_idx;
 			}
-			
+
 			// Main chunk
-			n /= BITS_PER_LONG;
+			n /= bits;
 			while (n >= 8) {
 				FB_WRITEL(FB_READL(src++), dst++);
 				FB_WRITEL(FB_READL(src++), dst++);
@@ -94,58 +101,61 @@
 			}
 			while (n--)
 				FB_WRITEL(FB_READL(src++), dst++);
+
 			// Trailing bits
 			if (last)
-				FB_WRITEL((FB_READL(src) & last) | (FB_READL(dst) & ~last), dst);
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
 		}
 	} else {
+		unsigned long d0, d1;
+		int m;
 		// Different alignment for source and dest
-		
-		right = shift & (BITS_PER_LONG-1);
-		left = -shift & (BITS_PER_LONG-1);
-		
-		if (dst_idx+n <= BITS_PER_LONG) {
+
+		right = shift & (bits - 1);
+		left = -shift & (bits - 1);
+
+		if (dst_idx+n <= bits) {
 			// Single destination word
 			if (last)
 				first &= last;
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL(((FB_READL(src) >> right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
-			} else if (src_idx+n <= BITS_PER_LONG) {
+				FB_WRITEL( comp( FB_READL(src) >> right, FB_READL(dst), first), dst);
+			} else if (src_idx+n <= bits) {
 				// Single source word
-				FB_WRITEL(((FB_READL(src) << left) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp(FB_READL(src) << left, FB_READL(dst), first), dst);
 			} else {
 				// 2 source words
 				d0 = FB_READL(src++);
 				d1 = FB_READL(src);
-				FB_WRITEL(((d0<<left | d1>>right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), first), dst);
 			}
 		} else {
 			// Multiple destination words
+			/** We must always remember the last value read, because in case
+			SRC and DST overlap bitwise (e.g. when moving just one pixel in
+			1bpp), we always collect one full long for DST and that might
+			overlap with the current long from SRC. We store this value in
+			'd0'. */
 			d0 = FB_READL(src++);
 			// Leading bits
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL(((d0 >> right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp(d0 >> right, FB_READL(dst), first), dst);
 				dst++;
-				n -= BITS_PER_LONG-dst_idx;
+				n -= bits - dst_idx;
 			} else {
 				// 2 source words
 				d1 = FB_READL(src++);
-				FB_WRITEL(((d0<<left | d1>>right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), first), dst);
 				d0 = d1;
 				dst++;
-				n -= BITS_PER_LONG-dst_idx;
+				n -= bits - dst_idx;
 			}
-			
+
 			// Main chunk
-			m = n % BITS_PER_LONG;
-			n /= BITS_PER_LONG;
+			m = n % bits;
+			n /= bits;
 			while (n >= 4) {
 				d1 = FB_READL(src++);
 				FB_WRITEL(d0 << left | d1 >> right, dst++);
@@ -166,72 +176,70 @@
 				FB_WRITEL(d0 << left | d1 >> right, dst++);
 				d0 = d1;
 			}
-			
+
 			// Trailing bits
 			if (last) {
 				if (m <= right) {
 					// Single source word
-					FB_WRITEL(((d0 << left) & last) | 
-						  (FB_READL(dst) & ~last), 
-						  dst);
+					FB_WRITEL( comp(d0 << left, FB_READL(dst), last), dst);
 				} else {
 					// 2 source words
 					d1 = FB_READL(src);
-					FB_WRITEL(((d0<<left | d1>>right) & 
-						   last) | (FB_READL(dst) & 
-							    ~last), dst);
+					FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), last), dst);
 				}
 			}
 		}
 	}
 }
 
-static void bitcpy_rev(unsigned long __iomem *dst, int dst_idx,
-		       const unsigned long __iomem *src, int src_idx, unsigned long n)
+    /*
+     *  Generic bitwise copy algorithm, operating backward
+     */
+
+static void
+bitcpy_rev(unsigned long __iomem *dst, int dst_idx, const unsigned long __iomem *src,
+		int src_idx, int bits, unsigned n)
 {
 	unsigned long first, last;
-	int shift = dst_idx-src_idx, left, right;
-	unsigned long d0, d1;
-	int m;
-	
-	if (!n)
-		return;
-	
-	dst += (n-1)/BITS_PER_LONG;
-	src += (n-1)/BITS_PER_LONG;
-	if ((n-1) % BITS_PER_LONG) {
-		dst_idx += (n-1) % BITS_PER_LONG;
-		dst += dst_idx >> SHIFT_PER_LONG;
-		dst_idx &= BITS_PER_LONG-1;
-		src_idx += (n-1) % BITS_PER_LONG;
-		src += src_idx >> SHIFT_PER_LONG;
-		src_idx &= BITS_PER_LONG-1;
+	int shift;
+
+	dst += (n-1)/bits;
+	src += (n-1)/bits;
+	if ((n-1) % bits) {
+		dst_idx += (n-1) % bits;
+		dst += dst_idx >> (ffs(bits) - 1);
+		dst_idx &= bits - 1;
+		src_idx += (n-1) % bits;
+		src += src_idx >> (ffs(bits) - 1);
+		src_idx &= bits - 1;
 	}
-	
+
 	shift = dst_idx-src_idx;
-	first = ~0UL << (BITS_PER_LONG-1-dst_idx);
-	last = ~(~0UL << (BITS_PER_LONG-1-((dst_idx-n) % BITS_PER_LONG)));
-	
+
+	first = ~0UL << (bits - 1 - dst_idx);
+	last = ~(~0UL << (bits - 1 - ((dst_idx-n) % bits)));
+
 	if (!shift) {
 		// Same alignment for source and dest
-		
+
 		if ((unsigned long)dst_idx+1 >= n) {
 			// Single word
 			if (last)
 				first &= last;
-			FB_WRITEL((FB_READL(src) & first) | (FB_READL(dst) & ~first), dst); 
+			FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 		} else {
 			// Multiple destination words
+
 			// Leading bits
-			if (first) {
-				FB_WRITEL((FB_READL(src) & first) | (FB_READL(dst) & ~first), dst); 
+			if (first != ~0UL) {
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 				dst--;
 				src--;
 				n -= dst_idx+1;
 			}
-			
+
 			// Main chunk
-			n /= BITS_PER_LONG;
+			n /= bits;
 			while (n >= 8) {
 				FB_WRITEL(FB_READL(src--), dst--);
 				FB_WRITEL(FB_READL(src--), dst--);
@@ -245,59 +253,58 @@
 			}
 			while (n--)
 				FB_WRITEL(FB_READL(src--), dst--);
-			
+
 			// Trailing bits
 			if (last)
-				FB_WRITEL((FB_READL(src) & last) | (FB_READL(dst) & ~last), dst);
+				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
 		}
 	} else {
 		// Different alignment for source and dest
-		
-		right = shift & (BITS_PER_LONG-1);
-		left = -shift & (BITS_PER_LONG-1);
-		
+
+		int const left = -shift & (bits-1);
+		int const right = shift & (bits-1);
+
 		if ((unsigned long)dst_idx+1 >= n) {
 			// Single destination word
 			if (last)
 				first &= last;
 			if (shift < 0) {
 				// Single source word
-				FB_WRITEL((FB_READL(src) << left & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp( FB_READL(src)<<left, FB_READL(dst), first), dst);
 			} else if (1+(unsigned long)src_idx >= n) {
 				// Single source word
-				FB_WRITEL(((FB_READL(src) >> right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp( FB_READL(src)>>right, FB_READL(dst), first), dst);
 			} else {
 				// 2 source words
-				d0 = FB_READL(src--);
-				d1 = FB_READL(src);
-				FB_WRITEL(((d0>>right | d1<<left) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp( (FB_READL(src)>>right | FB_READL(src-1)<<left), FB_READL(dst), first), dst);
 			}
 		} else {
 			// Multiple destination words
+			/** We must always remember the last value read, because in case
+			SRC and DST overlap bitwise (e.g. when moving just one pixel in
+			1bpp), we always collect one full long for DST and that might
+			overlap with the current long from SRC. We store this value in
+			'd0'. */
+			unsigned long d0, d1;
+			int m;
+
 			d0 = FB_READL(src--);
 			// Leading bits
 			if (shift < 0) {
 				// Single source word
-				FB_WRITEL(((d0 << left) & first) | 
-					  (FB_READL(dst) & ~first), dst);
-				dst--;
-				n -= dst_idx+1;
+				FB_WRITEL( comp( (d0 << left), FB_READL(dst), first), dst);
 			} else {
 				// 2 source words
 				d1 = FB_READL(src--);
-				FB_WRITEL(((d0>>right | d1<<left) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp( (d0>>right | d1<<left), FB_READL(dst), first), dst);
 				d0 = d1;
-				dst--;
-				n -= dst_idx+1;
 			}
-			
+			dst--;
+			n -= dst_idx+1;
+
 			// Main chunk
-			m = n % BITS_PER_LONG;
-			n /= BITS_PER_LONG;
+			m = n % bits;
+			n /= bits;
 			while (n >= 4) {
 				d1 = FB_READL(src--);
 				FB_WRITEL(d0 >> right | d1 << left, dst--);
@@ -318,20 +325,16 @@
 				FB_WRITEL(d0 >> right | d1 << left, dst--);
 				d0 = d1;
 			}
-			
+
 			// Trailing bits
 			if (last) {
 				if (m <= left) {
 					// Single source word
-					FB_WRITEL(((d0 >> right) & last) | 
-						  (FB_READL(dst) & ~last), 
-						  dst);
+					FB_WRITEL( comp(d0 >> right, FB_READL(dst), last), dst);
 				} else {
 					// 2 source words
 					d1 = FB_READL(src);
-					FB_WRITEL(((d0>>right | d1<<left) & 
-						   last) | (FB_READL(dst) & 
-							    ~last), dst);
+					FB_WRITEL( comp(d0>>right | d1<<left, FB_READL(dst), last), dst);
 				}
 			}
 		}
@@ -342,30 +345,27 @@
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
-	int x2, y2, old_dx, old_dy, vxres, vyres;
-	unsigned long next_line = p->fix.line_length;
-	int dst_idx = 0, src_idx = 0, rev_copy = 0;
+	unsigned long const bits_per_line = p->fix.line_length*8u;
 	unsigned long __iomem *dst = NULL, *src = NULL;
+	int bits = BITS_PER_LONG, bytes = bits >> 3;
+	int dst_idx = 0, src_idx = 0, rev_copy = 0;
+	int x2, y2, vxres, vyres;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
 	/* We want rotation but lack hardware to do it for us. */
 	if (!p->fbops->fb_rotate && p->var.rotate) {
-	}	
-	
+	}
+
 	vxres = p->var.xres_virtual;
 	vyres = p->var.yres_virtual;
 
-	if (area->dx > vxres || area->sx > vxres || 
+	if (area->dx > vxres || area->sx > vxres ||
 	    area->dy > vyres || area->sy > vyres)
 		return;
 
-	/* clip the destination */
-	old_dx = area->dx;
-	old_dy = area->dy;
-
-	/*
+	/* clip the destination
 	 * We could use hardware clipping but on many cards you get around
 	 * hardware clipping by writing to framebuffer directly.
 	 */
@@ -378,53 +378,58 @@
 	width = x2 - dx;
 	height = y2 - dy;
 
+	if ((width==0) ||(height==0))
+		return;
+
 	/* update sx1,sy1 */
-	sx += (dx - old_dx);
-	sy += (dy - old_dy);
+	sx += (dx - area->dx);
+	sy += (dy - area->dy);
 
 	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 ||
-	    (sx + width) > vxres ||
-	    (sy + height) > vyres)
+	if (sx < 0 || sy < 0 || (sx + width) > vxres || (sy + height) > vyres)
 		return;
 
-	if ((dy == sy && dx > sx) ||	
-	    (dy > sy)) { 
+	/* if the beginning of the target area might overlap with the end of
+	the source area, be have to copy the area reverse. */
+	if ((dy == sy && dx > sx) || (dy > sy)) {
 		dy += height;
 		sy += height;
 		rev_copy = 1;
 	}
 
-	dst = src = (unsigned long __iomem *)((unsigned long)p->screen_base & 
-				      ~(BYTES_PER_LONG-1));
-	dst_idx = src_idx = (unsigned long)p->screen_base & (BYTES_PER_LONG-1);
-	dst_idx += dy*next_line*8 + dx*p->var.bits_per_pixel;
-	src_idx += sy*next_line*8 + sx*p->var.bits_per_pixel;
-	
+	// split the base of the framebuffer into a long-aligned address and the
+	// index of the first bit
+	dst = src = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
+	dst_idx = src_idx = 8*((unsigned long)p->screen_base & (bytes-1));
+	// add offset of source and target area
+	dst_idx += dy*bits_per_line + dx*p->var.bits_per_pixel;
+	src_idx += sy*bits_per_line + sx*p->var.bits_per_pixel;
+
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
+
 	if (rev_copy) {
 		while (height--) {
-			dst_idx -= next_line*8;
-			src_idx -= next_line*8;
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BYTES_PER_LONG-1);
-			src += src_idx >> SHIFT_PER_LONG;
-			src_idx &= (BYTES_PER_LONG-1);
-			bitcpy_rev(dst, dst_idx, src, src_idx, 
-				   width*p->var.bits_per_pixel);
-		}	
+			dst_idx -= bits_per_line;
+			src_idx -= bits_per_line;
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bytes - 1);
+			src += src_idx >> (ffs(bits) - 1);
+			src_idx &= (bytes - 1);
+			bitcpy_rev(dst, dst_idx, src, src_idx, bits,
+				width*p->var.bits_per_pixel);
+		}
 	} else {
 		while (height--) {
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BYTES_PER_LONG-1);
-			src += src_idx >> SHIFT_PER_LONG;
-			src_idx &= (BYTES_PER_LONG-1);
-			bitcpy(dst, dst_idx, src, src_idx, 
-			       width*p->var.bits_per_pixel);
-			dst_idx += next_line*8;
-			src_idx += next_line*8;
-		}	
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bytes - 1);
+			src += src_idx >> (ffs(bits) - 1);
+			src_idx &= (bytes - 1);
+			bitcpy(dst, dst_idx, src, src_idx, bits, 
+				width*p->var.bits_per_pixel);
+			dst_idx += bits_per_line;
+			src_idx += bits_per_line;
+		}
 	}
 }
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/cfbfillrect.c fbdev-2.6/drivers/video/cfbfillrect.c
--- linus-2.6/drivers/video/cfbfillrect.c	2005-02-15 13:52:42.000000000 -0800
+++ fbdev-2.6/drivers/video/cfbfillrect.c	2005-02-16 14:10:44.000000000 -0800
@@ -1,7 +1,7 @@
 /*
- *  Generic fillrect for frame buffers with packed pixels of any depth. 
+ *  Generic fillrect for frame buffers with packed pixels of any depth.
  *
- *      Copyright (C)  2000 James Simmons (jsimmons@linux-fbdev.org) 
+ *      Copyright (C)  2000 James Simmons (jsimmons@linux-fbdev.org)
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive for
@@ -9,8 +9,8 @@
  *
  * NOTES:
  *
- *  The code for depths like 24 that don't have integer number of pixels per 
- *  long is broken and needs to be fixed. For now I turned these types of 
+ *  The code for depths like 24 that don't have integer number of pixels per
+ *  long is broken and needs to be fixed. For now I turned these types of
  *  mode off.
  *
  *  Also need to add code to deal with cards endians that are different than
@@ -24,149 +24,129 @@
 #include <asm/types.h>
 
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-#define BYTES_PER_LONG 4
-#define SHIFT_PER_LONG 5
+#  define FB_WRITEL fb_writel
+#  define FB_READL  fb_readl
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
-#define BYTES_PER_LONG 8
-#define SHIFT_PER_LONG 6
+#  define FB_WRITEL fb_writeq
+#  define FB_READL  fb_readq
 #endif
 
-#define EXP1(x)		0xffffffffU*x
-#define EXP2(x)		0x55555555U*x
-#define EXP4(x)		0x11111111U*0x ## x
-
-typedef u32 pixel_t;
-
-static const u32 bpp1tab[2] = {
-    EXP1(0), EXP1(1)
-};
-
-static const u32 bpp2tab[4] = {
-    EXP2(0), EXP2(1), EXP2(2), EXP2(3)
-};
-
-static const u32 bpp4tab[16] = {
-    EXP4(0), EXP4(1), EXP4(2), EXP4(3), EXP4(4), EXP4(5), EXP4(6), EXP4(7),
-    EXP4(8), EXP4(9), EXP4(a), EXP4(b), EXP4(c), EXP4(d), EXP4(e), EXP4(f)
-};
-
     /*
      *  Compose two values, using a bitmask as decision value
      *  This is equivalent to (a & mask) | (b & ~mask)
      */
 
-static inline unsigned long comp(unsigned long a, unsigned long b,
-				 unsigned long mask)
+static inline unsigned long
+comp(unsigned long a, unsigned long b, unsigned long mask)
 {
     return ((a ^ b) & mask) ^ b;
 }
 
-static inline u32 pixel_to_pat32(const struct fb_info *p, pixel_t pixel)
-{
-    u32 pat = pixel;
+    /*
+     *  Create a pattern with the given pixel's color
+     */
 
-    switch (p->var.bits_per_pixel) {
+#if BITS_PER_LONG == 64
+static inline unsigned long
+pixel_to_pat( u32 bpp, u32 pixel)
+{
+	switch (bpp) {
 	case 1:
-	    pat = bpp1tab[pat];
-	    break;
-
+		return 0xfffffffffffffffful*pixel;
 	case 2:
-	    pat = bpp2tab[pat];
-	    break;
-
+		return 0x5555555555555555ul*pixel;
 	case 4:
-	    pat = bpp4tab[pat];
-	    break;
-
+		return 0x1111111111111111ul*pixel;
 	case 8:
-	    pat |= pat << 8;
-	    // Fall through
+		return 0x0101010101010101ul*pixel;
+	case 12:
+		return 0x0001001001001001ul*pixel;
 	case 16:
-	    pat |= pat << 16;
-	    // Fall through
+		return 0x0001000100010001ul*pixel;
+	case 24:
+		return 0x0000000001000001ul*pixel;
 	case 32:
-	    break;
+		return 0x0000000100000001ul*pixel;
+	default:
+		panic("pixel_to_pat(): unsupported pixelformat\n");
     }
-    return pat;
 }
-
-    /*
-     *  Expand a pixel value to a generic 32/64-bit pattern and rotate it to
-     *  the correct start position
-     */
-
-static inline unsigned long pixel_to_pat(const struct fb_info *p, 
-					 pixel_t pixel, int left)
+#else
+static inline unsigned long
+pixel_to_pat( u32 bpp, u32 pixel)
 {
-    unsigned long pat = pixel;
-    u32 bpp = p->var.bits_per_pixel;
-    int i;
-
-    /* expand pixel value */
-    for (i = bpp; i < BITS_PER_LONG; i *= 2)
-	pat |= pat << i;
-
-    /* rotate pattern to correct start position */
-    pat = pat << left | pat >> (bpp-left);
-    return pat;
+	switch (bpp) {
+	case 1:
+		return 0xfffffffful*pixel;
+	case 2:
+		return 0x55555555ul*pixel;
+	case 4:
+		return 0x11111111ul*pixel;
+	case 8:
+		return 0x01010101ul*pixel;
+	case 12:
+		return 0x00001001ul*pixel;
+	case 16:
+		return 0x00010001ul*pixel;
+	case 24:
+		return 0x00000001ul*pixel;
+	case 32:
+		return 0x00000001ul*pixel;
+	default:
+		panic("pixel_to_pat(): unsupported pixelformat\n");
+    }
 }
+#endif
 
     /*
-     *  Unaligned 32-bit pattern fill using 32/64-bit memory accesses
+     *  Aligned pattern fill using 32/64-bit memory accesses
      */
 
-void bitfill32(unsigned long __iomem *dst, int dst_idx, u32 pat, u32 n)
+static void
+bitfill_aligned(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n, int bits)
 {
-	unsigned long val = pat;
 	unsigned long first, last;
-	
+
 	if (!n)
 		return;
-	
-#if BITS_PER_LONG == 64
-	val |= val << 32;
-#endif
-	
+
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
-	if (dst_idx+n <= BITS_PER_LONG) {
+	last = ~(~0UL >> ((dst_idx+n) % bits));
+
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
-		FB_WRITEL(comp(val, FB_READL(dst), first), dst);
+		FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 	} else {
 		// Multiple destination words
+
 		// Leading bits
-		if (first) {
-			FB_WRITEL(comp(val, FB_READL(dst), first), dst);
+		if (first!= ~0UL) {
+			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 			dst++;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
-		
+
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 8) {
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
-			FB_WRITEL(val, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
+			FB_WRITEL(pat, dst++);
 			n -= 8;
 		}
 		while (n--)
-			FB_WRITEL(val, dst++);
-		
+			FB_WRITEL(pat, dst++);
+
 		// Trailing bits
 		if (last)
-			FB_WRITEL(comp(val, FB_READL(dst), first), dst);
+			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
 	}
 }
 
@@ -178,18 +158,19 @@
      *  used for the next 32/64-bit word
      */
 
-void bitfill(unsigned long __iomem *dst, int dst_idx, unsigned long pat, int left,
-	     int right, u32 n)
+static void
+bitfill_unaligned(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
+			int left, int right, unsigned n, int bits)
 {
 	unsigned long first, last;
 
 	if (!n)
 		return;
-	
+
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
-	if (dst_idx+n <= BITS_PER_LONG) {
+	last = ~(~0UL >> ((dst_idx+n) % bits));
+
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -201,11 +182,11 @@
 			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 			dst++;
 			pat = pat << left | pat >> right;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
-		
+
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 4) {
 			FB_WRITEL(pat, dst++);
 			pat = pat << left | pat >> right;
@@ -221,29 +202,29 @@
 			FB_WRITEL(pat, dst++);
 			pat = pat << left | pat >> right;
 		}
-		
+
 		// Trailing bits
 		if (last)
 			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 	}
 }
 
-void bitfill32_rev(unsigned long __iomem *dst, int dst_idx, u32 pat, u32 n)
+    /*
+     *  Aligned pattern invert using 32/64-bit memory accesses
+     */
+static void
+bitfill_aligned_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n, int bits)
 {
 	unsigned long val = pat, dat;
 	unsigned long first, last;
-	
+
 	if (!n)
 		return;
-	
-#if BITS_PER_LONG == 64
-	val |= val << 32;
-#endif
-	
+
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
-	if (dst_idx+n <= BITS_PER_LONG) {
+	last = ~(~0UL >> ((dst_idx+n) % bits));
+
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -252,15 +233,15 @@
 	} else {
 		// Multiple destination words
 		// Leading bits
-		if (first) {
+		if (first!=0UL) {
 			dat = FB_READL(dst);
 			FB_WRITEL(comp(dat ^ val, dat, first), dst);
 			dst++;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
-		
+
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 8) {
 			FB_WRITEL(FB_READL(dst) ^ val, dst);
 			dst++;
@@ -283,35 +264,36 @@
 		while (n--) {
 			FB_WRITEL(FB_READL(dst) ^ val, dst);
 			dst++;
-		}		
+		}
 		// Trailing bits
 		if (last) {
 			dat = FB_READL(dst);
-			FB_WRITEL(comp(dat ^ val, dat, first), dst);
+			FB_WRITEL(comp(dat ^ val, dat, last), dst);
 		}
 	}
 }
 
 
     /*
-     *  Unaligned generic pattern fill using 32/64-bit memory accesses
+     *  Unaligned generic pattern invert using 32/64-bit memory accesses
      *  The pattern must have been expanded to a full 32/64-bit value
      *  Left/right are the appropriate shifts to convert to the pattern to be
      *  used for the next 32/64-bit word
      */
 
-void bitfill_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat, int left,
-	     int right, u32 n)
+static void
+bitfill_unaligned_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
+			int left, int right, unsigned n, int bits)
 {
 	unsigned long first, last, dat;
 
 	if (!n)
 		return;
-	
+
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
-	if (dst_idx+n <= BITS_PER_LONG) {
+	last = ~(~0UL >> ((dst_idx+n) % bits));
+
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -319,17 +301,18 @@
 		FB_WRITEL(comp(dat ^ pat, dat, first), dst);
 	} else {
 		// Multiple destination words
+
 		// Leading bits
-		if (first) {
+		if (first != 0UL) {
 			dat = FB_READL(dst);
 			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
 			dst++;
 			pat = pat << left | pat >> right;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
-		
+
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 4) {
 			FB_WRITEL(FB_READL(dst) ^ pat, dst);
 			dst++;
@@ -350,20 +333,20 @@
 			dst++;
 			pat = pat << left | pat >> right;
 		}
-		
+
 		// Trailing bits
 		if (last) {
 			dat = FB_READL(dst);
-			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
+			FB_WRITEL(comp(dat ^ pat, dat, last), dst);
 		}
 	}
 }
 
 void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
+	unsigned long x2, y2, vxres, vyres, height, width, pat, fg;
+	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	u32 bpp = p->var.bits_per_pixel;
-	unsigned long x2, y2, vxres, vyres;
-	unsigned long height, width, fg;
 	unsigned long __iomem *dst;
 	int dst_idx, left;
 
@@ -372,81 +355,91 @@
 
 	/* We want rotation but lack hardware to do it for us. */
 	if (!p->fbops->fb_rotate && p->var.rotate) {
-	}	
-	
+	}
+
 	vxres = p->var.xres_virtual;
 	vyres = p->var.yres_virtual;
 
-	if (!rect->width || !rect->height || 
+	if (!rect->width || !rect->height ||
 	    rect->dx > vxres || rect->dy > vyres)
 		return;
 
 	/* We could use hardware clipping but on many cards you get around
 	 * hardware clipping by writing to framebuffer directly. */
-	
+
 	x2 = rect->dx + rect->width;
 	y2 = rect->dy + rect->height;
 	x2 = x2 < vxres ? x2 : vxres;
 	y2 = y2 < vyres ? y2 : vyres;
 	width = x2 - rect->dx;
 	height = y2 - rect->dy;
-	
+
 	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
 		fg = ((u32 *) (p->pseudo_palette))[rect->color];
 	else
 		fg = rect->color;
-	
-	dst = (unsigned long __iomem *)((unsigned long)p->screen_base & 
-				~(BYTES_PER_LONG-1));
-	dst_idx = ((unsigned long)p->screen_base & (BYTES_PER_LONG-1))*8;
+
+	pat = pixel_to_pat( bpp, fg);
+
+	dst = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
+	dst_idx = ((unsigned long)p->screen_base & (bytes - 1))*8;
 	dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
 	/* FIXME For now we support 1-32 bpp only */
-	left = BITS_PER_LONG % bpp;
+	left = bits % bpp;
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
 	if (!left) {
-		u32 pat = pixel_to_pat32(p, fg);
-		void (*fill_op32)(unsigned long __iomem *dst, int dst_idx, u32 pat, 
-				  u32 n) = NULL;
-		
+		void (*fill_op32)(unsigned long __iomem *dst, int dst_idx,
+		                  unsigned long pat, unsigned n, int bits) = NULL;
+
 		switch (rect->rop) {
 		case ROP_XOR:
-			fill_op32 = bitfill32_rev;
+			fill_op32 = bitfill_aligned_rev;
 			break;
 		case ROP_COPY:
+			fill_op32 = bitfill_aligned;
+			break;
 		default:
-			fill_op32 = bitfill32;
+			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
+			fill_op32 = bitfill_aligned;
 			break;
 		}
 		while (height--) {
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BITS_PER_LONG-1);
-			fill_op32(dst, dst_idx, pat, width*bpp);
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bits - 1);
+			fill_op32(dst, dst_idx, pat, width*bpp, bits);
 			dst_idx += p->fix.line_length*8;
 		}
 	} else {
-		unsigned long pat = pixel_to_pat(p, fg, (left-dst_idx) % bpp);
+		int rot = (left-dst_idx) % bpp;
+
+		/* rotate pattern to correct start position */
+		pat = pat << rot | pat >> (bpp-rot);
+
 		int right = bpp-left;
 		int r;
-		void (*fill_op)(unsigned long __iomem *dst, int dst_idx, 
-				unsigned long pat, int left, int right, 
-				u32 n) = NULL;
-		
+		void (*fill_op)(unsigned long __iomem *dst, int dst_idx,
+		                unsigned long pat, int left, int right,
+		                unsigned n, int bits) = NULL;
+
 		switch (rect->rop) {
 		case ROP_XOR:
-			fill_op = bitfill_rev;
+			fill_op = bitfill_unaligned_rev;
 			break;
 		case ROP_COPY:
+			fill_op = bitfill_unaligned;
+			break;
 		default:
-			fill_op = bitfill;
+			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
+			fill_op = bitfill_unaligned;
 			break;
 		}
 		while (height--) {
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BITS_PER_LONG-1);
-			fill_op(dst, dst_idx, pat, left, right, 
-				width*bpp);
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bits - 1);
+			fill_op(dst, dst_idx, pat, left, right,
+				width*bpp, bits);
 			r = (p->fix.line_length*8) % bpp;
 			pat = pat << (bpp-r) | pat >> r;
 			dst_idx += p->fix.line_length*8;



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
