From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/10] fbdev: Generic drawing function cleanups 2
Date: Sun, 6 Mar 2005 08:16:52 +0800
Message-ID: <200503060816.52085.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jUC-00073Z-Tm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:19:08 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jUB-0000Ba-DZ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:19:08 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B50EE736CB
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:18:59 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@www.infradead.org>, ":"@smtp-3.hotpop.com

  From James Simmons <jsimmons@www.infradead.org>:

  Replaced LONG_MASK, SHIFT_PER_LONG, BYTES_PER_LONG with dynamic
  variables. This will allow drivers in the future to control how much
  data to read/write from the framebuffer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 cfbcopyarea.c |  185 ++++++++++++++++------------------------------------------
 cfbfillrect.c |   90 ++++++++++++----------------
 2 files changed, 94 insertions(+), 181 deletions(-)

diff -Nru a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
--- a/drivers/video/cfbcopyarea.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/cfbcopyarea.c	2005-03-05 07:46:05 +08:00
@@ -1,7 +1,7 @@
 /*
  *  Generic function for frame buffer with packed pixels of any depth.
  *
- *      Copyright (C)  June 1999 James Simmons
+ *      Copyright (C)  1999-2005 James Simmons <jsimmons@www.infradead.org>
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive for
@@ -33,18 +33,12 @@
 #include <asm/types.h>
 #include <asm/io.h>
 
-#define LONG_MASK  (BITS_PER_LONG - 1)
-
 #if BITS_PER_LONG == 32
 #  define FB_WRITEL fb_writel
 #  define FB_READL  fb_readl
-#  define SHIFT_PER_LONG 5
-#  define BYTES_PER_LONG 4
 #else
 #  define FB_WRITEL fb_writeq
 #  define FB_READL  fb_readq
-#  define SHIFT_PER_LONG 6
-#  define BYTES_PER_LONG 8
 #endif
 
     /*
@@ -63,21 +57,20 @@
      */
 
 static void
-bitcpy(unsigned long __iomem *dst, int dst_idx,
-       const unsigned long __iomem *src, int src_idx,
-       unsigned n)
+bitcpy(unsigned long __iomem *dst, int dst_idx, const unsigned long __iomem *src,
+	int src_idx, int bits, unsigned n)
 {
 	unsigned long first, last;
 	int const shift = dst_idx-src_idx;
 	int left, right;
 
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+	last = ~(~0UL >> ((dst_idx+n) % bits));
 
 	if (!shift) {
 		// Same alignment for source and dest
 
-		if (dst_idx+n <= BITS_PER_LONG) {
+		if (dst_idx+n <= bits) {
 			// Single word
 			if (last)
 				first &= last;
@@ -90,11 +83,11 @@
 				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), first), dst);
 				dst++;
 				src++;
-				n -= BITS_PER_LONG-dst_idx;
+				n -= bits - dst_idx;
 			}
 
 			// Main chunk
-			n /= BITS_PER_LONG;
+			n /= bits;
 			while (n >= 8) {
 				FB_WRITEL(FB_READL(src++), dst++);
 				FB_WRITEL(FB_READL(src++), dst++);
@@ -118,17 +111,17 @@
 		int m;
 		// Different alignment for source and dest
 
-		right = shift & (BITS_PER_LONG-1);
-		left = -shift & (BITS_PER_LONG-1);
+		right = shift & (bits - 1);
+		left = -shift & (bits - 1);
 
-		if (dst_idx+n <= BITS_PER_LONG) {
+		if (dst_idx+n <= bits) {
 			// Single destination word
 			if (last)
 				first &= last;
 			if (shift > 0) {
 				// Single source word
 				FB_WRITEL( comp( FB_READL(src) >> right, FB_READL(dst), first), dst);
-			} else if (src_idx+n <= BITS_PER_LONG) {
+			} else if (src_idx+n <= bits) {
 				// Single source word
 				FB_WRITEL( comp(FB_READL(src) << left, FB_READL(dst), first), dst);
 			} else {
@@ -150,19 +143,19 @@
 				// Single source word
 				FB_WRITEL( comp(d0 >> right, FB_READL(dst), first), dst);
 				dst++;
-				n -= BITS_PER_LONG-dst_idx;
+				n -= bits - dst_idx;
 			} else {
 				// 2 source words
 				d1 = FB_READL(src++);
 				FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), first), dst);
 				d0 = d1;
 				dst++;
-				n -= BITS_PER_LONG-dst_idx;
+				n -= bits - dst_idx;
 			}
 
 			// Main chunk
-			m = n % BITS_PER_LONG;
-			n /= BITS_PER_LONG;
+			m = n % bits;
+			n /= bits;
 			while (n >= 4) {
 				d1 = FB_READL(src++);
 				FB_WRITEL(d0 << left | d1 >> right, dst++);
@@ -204,28 +197,27 @@
      */
 
 static void
-bitcpy_rev(unsigned long __iomem *dst, int dst_idx,
-           const unsigned long __iomem *src, int src_idx,
-           unsigned n)
+bitcpy_rev(unsigned long __iomem *dst, int dst_idx, const unsigned long __iomem *src,
+		int src_idx, int bits, unsigned n)
 {
 	unsigned long first, last;
 	int shift;
 
-	dst += (n-1)/BITS_PER_LONG;
-	src += (n-1)/BITS_PER_LONG;
-	if ((n-1) % BITS_PER_LONG) {
-		dst_idx += (n-1) % BITS_PER_LONG;
-		dst += dst_idx >> SHIFT_PER_LONG;
-		dst_idx &= BITS_PER_LONG-1;
-		src_idx += (n-1) % BITS_PER_LONG;
-		src += src_idx >> SHIFT_PER_LONG;
-		src_idx &= BITS_PER_LONG-1;
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
 
 	shift = dst_idx-src_idx;
 
-	first = ~0UL << (BITS_PER_LONG-1-dst_idx);
-	last = ~(~0UL << (BITS_PER_LONG-1-((dst_idx-n) % BITS_PER_LONG)));
+	first = ~0UL << (bits - 1 - dst_idx);
+	last = ~(~0UL << (bits - 1 - ((dst_idx-n) % bits)));
 
 	if (!shift) {
 		// Same alignment for source and dest
@@ -247,7 +239,7 @@
 			}
 
 			// Main chunk
-			n /= BITS_PER_LONG;
+			n /= bits;
 			while (n >= 8) {
 				FB_WRITEL(FB_READL(src--), dst--);
 				FB_WRITEL(FB_READL(src--), dst--);
@@ -269,8 +261,8 @@
 	} else {
 		// Different alignment for source and dest
 
-		int const left = -shift & (BITS_PER_LONG-1);
-		int const right = shift & (BITS_PER_LONG-1);
+		int const left = -shift & (bits-1);
+		int const right = shift & (bits-1);
 
 		if ((unsigned long)dst_idx+1 >= n) {
 			// Single destination word
@@ -311,8 +303,8 @@
 			n -= dst_idx+1;
 
 			// Main chunk
-			m = n % BITS_PER_LONG;
-			n /= BITS_PER_LONG;
+			m = n % bits;
+			n /= bits;
 			while (n >= 4) {
 				d1 = FB_READL(src--);
 				FB_WRITEL(d0 >> right | d1 << left, dst--);
@@ -353,10 +345,11 @@
 {
 	u32 dx = area->dx, dy = area->dy, sx = area->sx, sy = area->sy;
 	u32 height = area->height, width = area->width;
-	int x2, y2, vxres, vyres;
 	unsigned long const bits_per_line = p->fix.line_length*8u;
-	int dst_idx = 0, src_idx = 0, rev_copy = 0;
 	unsigned long __iomem *dst = NULL, *src = NULL;
+	int bits = BITS_PER_LONG, bytes = bits >> 3;
+	int dst_idx = 0, src_idx = 0, rev_copy = 0;
+	int x2, y2, vxres, vyres;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
@@ -385,8 +378,7 @@
 	width = x2 - dx;
 	height = y2 - dy;
 
-	if ((width==0)
-	  ||(height==0))
+	if ((width==0) ||(height==0))
 		return;
 
 	/* update sx1,sy1 */
@@ -394,15 +386,12 @@
 	sy += (dy - area->dy);
 
 	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 ||
-	    (sx + width) > vxres ||
-	    (sy + height) > vyres)
+	if (sx < 0 || sy < 0 || (sx + width) > vxres || (sy + height) > vyres)
 		return;
 
 	/* if the beginning of the target area might overlap with the end of
 	the source area, be have to copy the area reverse. */
-	if ((dy == sy && dx > sx) ||
-	    (dy > sy)) {
+	if ((dy == sy && dx > sx) || (dy > sy)) {
 		dy += height;
 		sy += height;
 		rev_copy = 1;
@@ -410,9 +399,8 @@
 
 	// split the base of the framebuffer into a long-aligned address and the
 	// index of the first bit
-	dst = src = (unsigned long __iomem *)((unsigned long)p->screen_base &
-				      ~(BYTES_PER_LONG-1));
-	dst_idx = src_idx = 8*((unsigned long)p->screen_base & (BYTES_PER_LONG-1));
+	dst = src = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
+	dst_idx = src_idx = 8*((unsigned long)p->screen_base & (bytes-1));
 	// add offset of source and target area
 	dst_idx += dy*bits_per_line + dx*p->var.bits_per_pixel;
 	src_idx += sy*bits_per_line + sx*p->var.bits_per_pixel;
@@ -424,93 +412,26 @@
 		while (height--) {
 			dst_idx -= bits_per_line;
 			src_idx -= bits_per_line;
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= LONG_MASK;
-			src += src_idx >> SHIFT_PER_LONG;
-			src_idx &= LONG_MASK;
-			bitcpy_rev(dst, dst_idx, src, src_idx,
-				   width*p->var.bits_per_pixel);
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bytes - 1);
+			src += src_idx >> (ffs(bits) - 1);
+			src_idx &= (bytes - 1);
+			bitcpy_rev(dst, dst_idx, src, src_idx, bits,
+				width*p->var.bits_per_pixel);
 		}
 	} else {
 		while (height--) {
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= LONG_MASK;
-			src += src_idx >> SHIFT_PER_LONG;
-			src_idx &= LONG_MASK;
-			bitcpy(dst, dst_idx, src, src_idx,
-			       width*p->var.bits_per_pixel);
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bytes - 1);
+			src += src_idx >> (ffs(bits) - 1);
+			src_idx &= (bytes - 1);
+			bitcpy(dst, dst_idx, src, src_idx, bits,
+				width*p->var.bits_per_pixel);
 			dst_idx += bits_per_line;
 			src_idx += bits_per_line;
 		}
 	}
 }
-#undef CFB_DEBUG
-#ifdef CFB_DEBUG
-/** all this init-function does is to perform a few unittests.
-The idea it always to invoke the function to test on a predefined bitmap and
-compare the results to the expected output.
-TODO:
- - this currently only tests bitcpy_rev, as that was the only one giving me trouble
- - this assumes 32 bit longs
- - not sure about endianess, I only tested this on a 32 bit MIPS little endian system
- - could reuse testcases to test forward copying, too, just reverse the operation
-*/
-int __init cfb_copyarea_init(void)
-{
-	char const* comment = 0;
-	printk( KERN_INFO "cfb_copyarea_init()\n");
-	{
-		comment = "copy a single u32, source and target u32-aligned";
-		u32 tmp[] =          { 0xaaaaaaaau, 0x55555555u, 0xffffffffu, 0x00000000u };
-		u32 const expect[] = { 0xaaaaaaaau, 0xaaaaaaaau, 0xffffffffu, 0x00000000u };
-
-		bitcpy_rev( tmp, 0, tmp+1, 0, 32);
-
-		if( 0!=memcmp( expect, tmp, sizeof tmp))
-			goto error;
-	}
-
-	{
-		comment = "copy a single u32, source u32-aligned";
-		u32 tmp[] =          { 0x11112222u, 0x33334444u, 0x55556666u, 0x77778888u };
-		u32 const expect[] = { 0x11112222u, 0x22224444u, 0x55551111u, 0x77778888u };
-
-		bitcpy_rev( tmp, 0, tmp+1, 16, 32);
-
-		if( 0!=memcmp( expect, tmp, sizeof tmp))
-			goto error;
-	}
-
-	{
-		comment = "copy a single u32, target u32-aligned";
-		u32 tmp[] =          { 0x11112222u, 0x33334444u, 0x55556666u, 0x77778888u };
-		u32 const expect[] = { 0x11112222u, 0x33334444u, 0x44441111u, 0x77778888u };
-
-		bitcpy_rev( tmp, 16, tmp+2, 0, 32);
-
-		if( 0!=memcmp( expect, tmp, sizeof tmp))
-			goto error;
-	}
-
-	{
-		comment = "copy two u32, source and target u32-aligned";
-		u32 tmp[] =          { 0xaaaaaaaau, 0x55555555u, 0xffffffffu, 0x00000000u };
-		u32 const expect[] = { 0xaaaaaaaau, 0xaaaaaaaau, 0x55555555u, 0x00000000u };
-
-		bitcpy_rev( tmp, 0, tmp+1, 0, 64);
-
-		if( 0!=memcmp( expect, tmp, sizeof tmp))
-			goto error;
-	}
-
-	return 0;
-
-error:
-	printk( KERN_ERR " framebuffer self-test(%s) failed\n", comment);
-	return -1;
-}
-module_init(cfb_copyarea_init);
-#endif
 
 EXPORT_SYMBOL(cfb_copyarea);
 
diff -Nru a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
--- a/drivers/video/cfbfillrect.c	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/cfbfillrect.c	2005-03-06 07:11:25 +08:00
@@ -26,13 +26,9 @@
 #if BITS_PER_LONG == 32
 #  define FB_WRITEL fb_writel
 #  define FB_READL  fb_readl
-#  define SHIFT_PER_LONG 5
-#  define BYTES_PER_LONG 4
 #else
 #  define FB_WRITEL fb_writeq
 #  define FB_READL  fb_readq
-#  define SHIFT_PER_LONG 6
-#  define BYTES_PER_LONG 8
 #endif
 
     /*
@@ -107,7 +103,7 @@
      */
 
 static void
-bitfill32(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n)
+bitfill_aligned(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n, int bits)
 {
 	unsigned long first, last;
 
@@ -115,10 +111,9 @@
 		return;
 
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+	last = ~(~0UL >> ((dst_idx+n) % bits));
 
-
-	if (dst_idx+n <= BITS_PER_LONG) {
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -130,11 +125,11 @@
 		if (first!= ~0UL) {
 			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 			dst++;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
 
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 8) {
 			FB_WRITEL(pat, dst++);
 			FB_WRITEL(pat, dst++);
@@ -164,8 +159,8 @@
      */
 
 static void
-bitfill(unsigned long __iomem *dst, int dst_idx, unsigned long pat, int left,
-        int right, unsigned n)
+bitfill_unaligned(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
+			int left, int right, unsigned n, int bits)
 {
 	unsigned long first, last;
 
@@ -173,9 +168,9 @@
 		return;
 
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+	last = ~(~0UL >> ((dst_idx+n) % bits));
 
-	if (dst_idx+n <= BITS_PER_LONG) {
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -187,11 +182,11 @@
 			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
 			dst++;
 			pat = pat << left | pat >> right;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
 
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 4) {
 			FB_WRITEL(pat, dst++);
 			pat = pat << left | pat >> right;
@@ -218,7 +213,7 @@
      *  Aligned pattern invert using 32/64-bit memory accesses
      */
 static void
-bitfill32_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n)
+bitfill_aligned_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat, unsigned n, int bits)
 {
 	unsigned long val = pat, dat;
 	unsigned long first, last;
@@ -227,9 +222,9 @@
 		return;
 
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+	last = ~(~0UL >> ((dst_idx+n) % bits));
 
-	if (dst_idx+n <= BITS_PER_LONG) {
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -242,11 +237,11 @@
 			dat = FB_READL(dst);
 			FB_WRITEL(comp(dat ^ val, dat, first), dst);
 			dst++;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
 
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 8) {
 			FB_WRITEL(FB_READL(dst) ^ val, dst);
 			dst++;
@@ -287,8 +282,8 @@
      */
 
 static void
-bitfill_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat, int left,
-            int right, unsigned n)
+bitfill_unaligned_rev(unsigned long __iomem *dst, int dst_idx, unsigned long pat,
+			int left, int right, unsigned n, int bits)
 {
 	unsigned long first, last, dat;
 
@@ -296,9 +291,9 @@
 		return;
 
 	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+	last = ~(~0UL >> ((dst_idx+n) % bits));
 
-	if (dst_idx+n <= BITS_PER_LONG) {
+	if (dst_idx+n <= bits) {
 		// Single word
 		if (last)
 			first &= last;
@@ -313,11 +308,11 @@
 			FB_WRITEL(comp(dat ^ pat, dat, first), dst);
 			dst++;
 			pat = pat << left | pat >> right;
-			n -= BITS_PER_LONG-dst_idx;
+			n -= bits - dst_idx;
 		}
 
 		// Main chunk
-		n /= BITS_PER_LONG;
+		n /= bits;
 		while (n >= 4) {
 			FB_WRITEL(FB_READL(dst) ^ pat, dst);
 			dst++;
@@ -349,11 +344,10 @@
 
 void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
+	unsigned long x2, y2, vxres, vyres, height, width, pat, fg;
+	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	u32 bpp = p->var.bits_per_pixel;
-	unsigned long x2, y2, vxres, vyres;
-	unsigned long height, width, fg;
 	unsigned long __iomem *dst;
-	unsigned long pat;
 	int dst_idx, left;
 
 	if (p->state != FBINFO_STATE_RUNNING)
@@ -388,34 +382,33 @@
 
 	pat = pixel_to_pat( bpp, fg);
 
-	dst = (unsigned long __iomem *)((unsigned long)p->screen_base &
-				~(BYTES_PER_LONG-1));
-	dst_idx = ((unsigned long)p->screen_base & (BYTES_PER_LONG-1))*8;
+	dst = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
+	dst_idx = ((unsigned long)p->screen_base & (bytes - 1))*8;
 	dst_idx += rect->dy*p->fix.line_length*8+rect->dx*bpp;
 	/* FIXME For now we support 1-32 bpp only */
-	left = BITS_PER_LONG % bpp;
+	left = bits % bpp;
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
 	if (!left) {
 		void (*fill_op32)(unsigned long __iomem *dst, int dst_idx,
-		                  unsigned long pat, unsigned n) = NULL;
+		                  unsigned long pat, unsigned n, int bits) = NULL;
 
 		switch (rect->rop) {
 		case ROP_XOR:
-			fill_op32 = bitfill32_rev;
+			fill_op32 = bitfill_aligned_rev;
 			break;
 		case ROP_COPY:
-			fill_op32 = bitfill32;
+			fill_op32 = bitfill_aligned;
 			break;
 		default:
 			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
-			fill_op32 = bitfill32;
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
@@ -424,8 +417,7 @@
 		int rot = (left-dst_idx) % bpp;
 		void (*fill_op)(unsigned long __iomem *dst, int dst_idx,
 		                unsigned long pat, int left, int right,
-		                unsigned n) = NULL;
-
+		                unsigned n, int bits) = NULL;
 
 		/* rotate pattern to correct start position */
 		pat = pat << rot | pat >> (bpp-rot);
@@ -433,21 +425,21 @@
 		right = bpp-left;
 		switch (rect->rop) {
 		case ROP_XOR:
-			fill_op = bitfill_rev;
+			fill_op = bitfill_unaligned_rev;
 			break;
 		case ROP_COPY:
-			fill_op = bitfill;
+			fill_op = bitfill_unaligned;
 			break;
 		default:
 			printk( KERN_ERR "cfb_fillrect(): unknown rop, defaulting to ROP_COPY\n");
-			fill_op = bitfill;
+			fill_op = bitfill_unaligned;
 			break;
 		}
 		while (height--) {
-			dst += dst_idx >> SHIFT_PER_LONG;
-			dst_idx &= (BITS_PER_LONG-1);
+			dst += dst_idx >> (ffs(bits) - 1);
+			dst_idx &= (bits - 1);
 			fill_op(dst, dst_idx, pat, left, right,
-				width*bpp);
+				width*bpp, bits);
 			r = (p->fix.line_length*8) % bpp;
 			pat = pat << (bpp-r) | pat >> r;
 			dst_idx += p->fix.line_length*8;




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
