From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/7] fbdev: Generic drawing function cleanups
Date: Thu, 17 Feb 2005 20:45:40 +0800
Message-ID: <200502172045.40790.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1l64-0000l3-2i
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:49:32 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1l5y-00009N-GP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:49:31 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 847C1E3AE0D
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:49:20 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ulrich Eckhardt <eckhardt@satorlaser.com>

  From Ulrich Eckhardt:

   * removed trailing whitespace
   * use helper function for common bitwise operations
   * fixed several cases where either the wrong mask was used for bitops
     or the mask was computed falsely, messing up <32 BPP support
   * added self-tests for bitcpy_rev() algorithm in module-init function
   * no need to use explicitly sized integers in some cases
   * added a few comments where things weren't obvious to me

  I tested these changes on an Au1100 based board, using the patches to its
  framebuffer code that were posted here by Christian Pellegrin[1]. I had this
  code working both on a 16BPP color LCD and a 4BPP monochrome one.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 cfbcopyarea.c |  348 ++++++++++++++++++++++++++++++++++++----------------------
 cfbfillrect.c |  279 +++++++++++++++++++++++-----------------------
 2 files changed, 356 insertions(+), 271 deletions(-)

diff -Nru a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
--- a/drivers/video/cfbcopyarea.c	2004-10-19 20:21:21 +08:00
+++ b/drivers/video/cfbcopyarea.c	2005-02-17 00:11:49 +08:00
@@ -8,18 +8,22 @@
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
@@ -32,53 +36,63 @@
 #define LONG_MASK  (BITS_PER_LONG - 1)
 
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-#define SHIFT_PER_LONG 5
-#define BYTES_PER_LONG 4
+#  define FB_WRITEL fb_writel
+#  define FB_READL  fb_readl
+#  define SHIFT_PER_LONG 5
+#  define BYTES_PER_LONG 4
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
-#define SHIFT_PER_LONG 6
-#define BYTES_PER_LONG 8
+#  define FB_WRITEL fb_writeq
+#  define FB_READL  fb_readq
+#  define SHIFT_PER_LONG 6
+#  define BYTES_PER_LONG 8
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
+bitcpy(unsigned long __iomem *dst, int dst_idx,
+       const unsigned long __iomem *src, int src_idx,
+       unsigned n)
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
 	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
+
 	if (!shift) {
 		// Same alignment for source and dest
-		
+
 		if (dst_idx+n <= BITS_PER_LONG) {
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
 				n -= BITS_PER_LONG-dst_idx;
 			}
-			
+
 			// Main chunk
 			n /= BITS_PER_LONG;
 			while (n >= 8) {
@@ -94,55 +108,58 @@
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
+
 		right = shift & (BITS_PER_LONG-1);
 		left = -shift & (BITS_PER_LONG-1);
-		
+
 		if (dst_idx+n <= BITS_PER_LONG) {
 			// Single destination word
 			if (last)
 				first &= last;
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL(((FB_READL(src) >> right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp( FB_READL(src) >> right, FB_READL(dst), first), dst);
 			} else if (src_idx+n <= BITS_PER_LONG) {
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
 				n -= BITS_PER_LONG-dst_idx;
 			} else {
 				// 2 source words
 				d1 = FB_READL(src++);
-				FB_WRITEL(((d0<<left | d1>>right) & first) | 
-					  (FB_READL(dst) & ~first), dst);
+				FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), first), dst);
 				d0 = d1;
 				dst++;
 				n -= BITS_PER_LONG-dst_idx;
 			}
-			
+
 			// Main chunk
 			m = n % BITS_PER_LONG;
 			n /= BITS_PER_LONG;
@@ -166,37 +183,34 @@
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
+bitcpy_rev(unsigned long __iomem *dst, int dst_idx,
+           const unsigned long __iomem *src, int src_idx,
+           unsigned n)
 {
 	unsigned long first, last;
-	int shift = dst_idx-src_idx, left, right;
-	unsigned long d0, d1;
-	int m;
-	
-	if (!n)
-		return;
-	
+	int shift;
+
 	dst += (n-1)/BITS_PER_LONG;
 	src += (n-1)/BITS_PER_LONG;
 	if ((n-1) % BITS_PER_LONG) {
@@ -207,29 +221,31 @@
 		src += src_idx >> SHIFT_PER_LONG;
 		src_idx &= BITS_PER_LONG-1;
 	}
-	
+
 	shift = dst_idx-src_idx;
+
 	first = ~0UL << (BITS_PER_LONG-1-dst_idx);
 	last = ~(~0UL << (BITS_PER_LONG-1-((dst_idx-n) % BITS_PER_LONG)));
-	
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
 			n /= BITS_PER_LONG;
 			while (n >= 8) {
@@ -245,56 +261,55 @@
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
+		int const left = -shift & (BITS_PER_LONG-1);
+		int const right = shift & (BITS_PER_LONG-1);
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
 			m = n % BITS_PER_LONG;
 			n /= BITS_PER_LONG;
@@ -318,20 +333,16 @@
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
@@ -342,8 +353,8 @@
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
-	int x2, y2, old_dx, old_dy, vxres, vyres;
-	unsigned long next_line = p->fix.line_length;
+	int x2, y2, vxres, vyres;
+	unsigned long const bits_per_line = p->fix.line_length*8u;
 	int dst_idx = 0, src_idx = 0, rev_copy = 0;
 	unsigned long __iomem *dst = NULL, *src = NULL;
 
@@ -352,20 +363,16 @@
 
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
@@ -378,9 +385,13 @@
 	width = x2 - dx;
 	height = y2 - dy;
 
+	if ((width==0)
+	  ||(height==0))
+		return;
+
 	/* update sx1,sy1 */
-	sx += (dx - old_dx);
-	sy += (dy - old_dy);
+	sx += (dx - area->dx);
+	sy += (dy - area->dy);
 
 	/* the source must be completely inside the virtual screen */
 	if (sx < 0 || sy < 0 ||
@@ -388,45 +399,118 @@
 	    (sy + height) > vyres)
 		return;
 
-	if ((dy == sy && dx > sx) ||	
-	    (dy > sy)) { 
+	/* if the beginning of the target area might overlap with the end of
+	the source area, be have to copy the area reverse. */
+	if ((dy == sy && dx > sx) ||
+	    (dy > sy)) {
 		dy += height;
 		sy += height;
 		rev_copy = 1;
 	}
 
-	dst = src = (unsigned long __iomem *)((unsigned long)p->screen_base & 
+	// split the base of the framebuffer into a long-aligned address and the
+	// index of the first bit
+	dst = src = (unsigned long __iomem *)((unsigned long)p->screen_base &
 				      ~(BYTES_PER_LONG-1));
-	dst_idx = src_idx = (unsigned long)p->screen_base & (BYTES_PER_LONG-1);
-	dst_idx += dy*next_line*8 + dx*p->var.bits_per_pixel;
-	src_idx += sy*next_line*8 + sx*p->var.bits_per_pixel;
-	
+	dst_idx = src_idx = 8*((unsigned long)p->screen_base & (BYTES_PER_LONG-1));
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
+			dst_idx -= bits_per_line;
+			src_idx -= bits_per_line;
 			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BYTES_PER_LONG-1);
+			dst_idx &= LONG_MASK;
 			src += src_idx >> SHIFT_PER_LONG;
-			src_idx &= (BYTES_PER_LONG-1);
-			bitcpy_rev(dst, dst_idx, src, src_idx, 
+			src_idx &= LONG_MASK;
+			bitcpy_rev(dst, dst_idx, src, src_idx,
 				   width*p->var.bits_per_pixel);
-		}	
+		}
 	} else {
 		while (height--) {
 			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BYTES_PER_LONG-1);
+			dst_idx &= LONG_MASK;
 			src += src_idx >> SHIFT_PER_LONG;
-			src_idx &= (BYTES_PER_LONG-1);
-			bitcpy(dst, dst_idx, src, src_idx, 
+			src_idx &= LONG_MASK;
+			bitcpy(dst, dst_idx, src, src_idx,
 			       width*p->var.bits_per_pixel);
-			dst_idx += next_line*8;
-			src_idx += next_line*8;
-		}	
+			dst_idx += bits_per_line;
+			src_idx += bits_per_line;
+		}
+	}
+}
+#undef CFB_DEBUG
+#ifdef CFB_DEBUG
+/** all this init-function does is to perform a few unittests.
+The idea it always to invoke the function to test on a predefined bitmap and
+compare the results to the expected output.
+TODO:
+ - this currently only tests bitcpy_rev, as that was the only one giving me trouble
+ - this assumes 32 bit longs
+ - not sure about endianess, I only tested this on a 32 bit MIPS little endian system
+ - could reuse testcases to test forward copying, too, just reverse the operation
+*/
+int __init cfb_copyarea_init(void)
+{
+	char const* comment = 0;
+	printk( KERN_INFO "cfb_copyarea_init()\n");
+	{
+		comment = "copy a single u32, source and target u32-aligned";
+		u32 tmp[] =          { 0xaaaaaaaau, 0x55555555u, 0xffffffffu, 0x00000000u };
+		u32 const expect[] = { 0xaaaaaaaau, 0xaaaaaaaau, 0xffffffffu, 0x00000000u };
+
+		bitcpy_rev( tmp, 0, tmp+1, 0, 32);
+
+		if( 0!=memcmp( expect, tmp, sizeof tmp))
+			goto error;
+	}
+
+	{
+		comment = "copy a single u32, source u32-aligned";
+		u32 tmp[] =          { 0x11112222u, 0x33334444u, 0x55556666u, 0x77778888u };
+		u32 const expect[] = { 0x11112222u, 0x22224444u, 0x55551111u, 0x77778888u };
+
+		bitcpy_rev( tmp, 0, tmp+1, 16, 32);
+
+		if( 0!=memcmp( expect, tmp, sizeof tmp))
+			goto error;
+	}
+
+	{
+		comment = "copy a single u32, target u32-aligned";
+		u32 tmp[] =          { 0x11112222u, 0x33334444u, 0x55556666u, 0x77778888u };
+		u32 const expect[] = { 0x11112222u, 0x33334444u, 0x44441111u, 0x77778888u };
+
+		bitcpy_rev( tmp, 16, tmp+2, 0, 32);
+
+		if( 0!=memcmp( expect, tmp, sizeof tmp))
+			goto error;
 	}
+
+	{
+		comment = "copy two u32, source and target u32-aligned";
+		u32 tmp[] =          { 0xaaaaaaaau, 0x55555555u, 0xffffffffu, 0x00000000u };
+		u32 const expect[] = { 0xaaaaaaaau, 0xaaaaaaaau, 0x55555555u, 0x00000000u };
+
+		bitcpy_rev( tmp, 0, tmp+1, 0, 64);
+
+		if( 0!=memcmp( expect, tmp, sizeof tmp))
+			goto error;
+	}
+
+	return 0;
+
+error:
+	printk( KERN_ERR " framebuffer self-test(%s) failed\n", comment);
+	return -1;
 }
+module_init(cfb_copyarea_init);
+#endif
 
 EXPORT_SYMBOL(cfb_copyarea);
 
diff -Nru a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
--- a/drivers/video/cfbfillrect.c	2004-11-21 22:18:53 +08:00
+++ b/drivers/video/cfbfillrect.c	2005-02-17 00:11:49 +08:00
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
@@ -24,149 +24,135 @@
 #include <asm/types.h>
 
 #if BITS_PER_LONG == 32
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
-#define BYTES_PER_LONG 4
-#define SHIFT_PER_LONG 5
+#  define FB_WRITEL fb_writel
+#  define FB_READL  fb_readl
+#  define SHIFT_PER_LONG 5
+#  define BYTES_PER_LONG 4
 #else
-#define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq
-#define BYTES_PER_LONG 8
-#define SHIFT_PER_LONG 6
+#  define FB_WRITEL fb_writeq
+#  define FB_READL  fb_readq
+#  define SHIFT_PER_LONG 6
+#  define BYTES_PER_LONG 8
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
 
-static void bitfill32(unsigned long __iomem *dst, int dst_idx, u32 pat, u32 n)
+static void
+bitfill32(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n)
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
 	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
+
+
 	if (dst_idx+n <= BITS_PER_LONG) {
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
 			n -= BITS_PER_LONG-dst_idx;
 		}
-		
+
 		// Main chunk
 		n /= BITS_PER_LONG;
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
 
@@ -178,17 +164,18 @@
      *  used for the next 32/64-bit word
      */
 
-static void bitfill(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
-		    int left, int right, u32 n)
+static void
+bitfill(unsigned long __iomem *dst, int dst_idx, unsigned long pat, int left,
+        int right, unsigned n)
 {
 	unsigned long first, last;
 
 	if (!n)
 		return;
-	
+
 	first = ~0UL >> dst_idx;
 	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
+
 	if (dst_idx+n <= BITS_PER_LONG) {
 		// Single word
 		if (last)
@@ -203,7 +190,7 @@
 			pat = pat << left | pat >> right;
 			n -= BITS_PER_LONG-dst_idx;
 		}
-		
+
 		// Main chunk
 		n /= BITS_PER_LONG;
 		while (n >= 4) {
@@ -221,28 +208,28 @@
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
 
-static void bitfill32_rev(unsigned long __iomem *dst, int dst_idx, u32 pat, u32 n)
+    /*
+     *  Aligned pattern invert using 32/64-bit memory accesses
+     */
+static void
+bitfill32_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n)
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
 	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
+
 	if (dst_idx+n <= BITS_PER_LONG) {
 		// Single word
 		if (last)
@@ -252,13 +239,13 @@
 	} else {
 		// Multiple destination words
 		// Leading bits
-		if (first) {
+		if (first!=0UL) {
 			dat = FB_READL(dst);
 			FB_WRITEL(comp(dat ^ val, dat, first), dst);
 			dst++;
 			n -= BITS_PER_LONG-dst_idx;
 		}
-		
+
 		// Main chunk
 		n /= BITS_PER_LONG;
 		while (n >= 8) {
@@ -283,34 +270,35 @@
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
 
-static void bitfill_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
-			int left, int right, u32 n)
+static void
+bitfill_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
+	    int left, int right, unsigned n)
 {
 	unsigned long first, last, dat;
 
 	if (!n)
 		return;
-	
+
 	first = ~0UL >> dst_idx;
 	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
-	
+
 	if (dst_idx+n <= BITS_PER_LONG) {
 		// Single word
 		if (last)
@@ -319,15 +307,16 @@
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
 			n -= BITS_PER_LONG-dst_idx;
 		}
-		
+
 		// Main chunk
 		n /= BITS_PER_LONG;
 		while (n >= 4) {
@@ -350,11 +339,11 @@
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
@@ -365,6 +354,7 @@
 	unsigned long x2, y2, vxres, vyres;
 	unsigned long height, width, fg;
 	unsigned long __iomem *dst;
+	unsigned long pat;
 	int dst_idx, left;
 
 	if (p->state != FBINFO_STATE_RUNNING)
@@ -372,32 +362,34 @@
 
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
+
+	pat = pixel_to_pat( bpp, fg);
+
+	dst = (unsigned long __iomem *)((unsigned long)p->screen_base &
 				~(BYTES_PER_LONG-1));
 	dst_idx = ((unsigned long)p->screen_base & (BYTES_PER_LONG-1))*8;
 	dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
@@ -406,16 +398,18 @@
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
 	if (!left) {
-		u32 pat = pixel_to_pat32(p, fg);
-		void (*fill_op32)(unsigned long __iomem *dst, int dst_idx, u32 pat, 
-				  u32 n) = NULL;
-		
+		void (*fill_op32)(unsigned long __iomem *dst, int dst_idx,
+		                  unsigned long pat, unsigned n) = NULL;
+
 		switch (rect->rop) {
 		case ROP_XOR:
 			fill_op32 = bitfill32_rev;
 			break;
 		case ROP_COPY:
+			fill_op32 = bitfill32;
+			break;
 		default:
+			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
 			fill_op32 = bitfill32;
 			break;
 		}
@@ -426,26 +420,33 @@
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
+		                unsigned n) = NULL;
+
 		switch (rect->rop) {
 		case ROP_XOR:
 			fill_op = bitfill_rev;
 			break;
 		case ROP_COPY:
+			fill_op = bitfill;
+			break;
 		default:
+			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
 			fill_op = bitfill;
 			break;
 		}
 		while (height--) {
 			dst += dst_idx >> SHIFT_PER_LONG;
 			dst_idx &= (BITS_PER_LONG-1);
-			fill_op(dst, dst_idx, pat, left, right, 
+			fill_op(dst, dst_idx, pat, left, right,
 				width*bpp);
 			r = (p->fix.line_length*8) % bpp;
 			pat = pat << (bpp-r) | pat >> r;




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
