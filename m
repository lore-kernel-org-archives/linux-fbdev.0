From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Apr 2020 13:12:51 +0000
Subject: [PATCH fbtest] Fix small pixel drawing on little endian systems
Message-Id: <20200420131251.8172-1-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

If the pixel size (bpp) is smaller than the word size (long) on a little
endian system, pixel data is written to the wrong part of the word.

Fix this by reversing the shifts on little endian systems.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Seen on 16-bpp displays when drawing horizontal line segments that start
or end an odd pixel boundary.
---
 drawops/bitstream.c | 28 ++++++++++++++++++----------
 drawops/cfb.c       | 25 +++++++++++++++++++------
 include/types.h     |  2 ++
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drawops/bitstream.c b/drawops/bitstream.c
index b3e09336cc477baa..06c74043b091846b 100644
--- a/drawops/bitstream.c
+++ b/drawops/bitstream.c
@@ -13,6 +13,14 @@
 #include "bitstream.h"
 #include "fb.h"
 
+#if __BYTE_ORDER = __LITTLE_ENDIAN
+#define FIRST_MASK(idx)		(~0UL << (idx))
+#define LAST_MASK(idx, n)	(~(~0UL << (((idx)+(n)) % BITS_PER_LONG)))
+#else
+#define FIRST_MASK(idx)		(~0UL >> (idx))
+#define LAST_MASK(idx, n)	(~(~0UL >> (((idx)+(n)) % BITS_PER_LONG)))
+#endif
+
 
     /*
      *  Compose two values, using a bitmask as decision value
@@ -42,8 +50,8 @@ void bitcpy(unsigned long *dst, int dst_idx, const unsigned long *src,
 	return;
 
     shift = dst_idx-src_idx;
-    first = ~0UL >> dst_idx;
-    last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+    first = FIRST_MASK(dst_idx);
+    last = LAST_MASK(dst_idx, n);
 
     if (!shift) {
 	// Same alignment for source and dest
@@ -190,8 +198,8 @@ void bitcpy_rev(unsigned long *dst, int dst_idx, const unsigned long *src,
     }
 
     shift = dst_idx-src_idx;
-    first = ~0UL << (BITS_PER_LONG-1-dst_idx);
-    last = ~(~0UL << (BITS_PER_LONG-1-((dst_idx-n) % BITS_PER_LONG)));
+    first = FIRST_MASK(BITS_PER_LONG-1-dst_idx);
+    last = LAST_MASK(BITS_PER_LONG-1-dst_idx, n);
 
     if (!shift) {
 	// Same alignment for source and dest
@@ -328,8 +336,8 @@ void bitcpy_not(unsigned long *dst, int dst_idx, const unsigned long *src,
 	return;
 
     shift = dst_idx-src_idx;
-    first = ~0UL >> dst_idx;
-    last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+    first = FIRST_MASK(dst_idx);
+    last = LAST_MASK(dst_idx, n);
 
     if (!shift) {
 	// Same alignment for source and dest
@@ -465,8 +473,8 @@ void bitfill32(unsigned long *dst, int dst_idx, u32 pat, u32 n)
     val |= val << 32;
 #endif
 
-    first = ~0UL >> dst_idx;
-    last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+    first = FIRST_MASK(dst_idx);
+    last = LAST_MASK(dst_idx, n);
 
     if (dst_idx+n <= BITS_PER_LONG) {
 	// Single word
@@ -520,8 +528,8 @@ void bitfill(unsigned long *dst, int dst_idx, unsigned long pat, int left,
     if (!n)
 	return;
 
-    first = ~0UL >> dst_idx;
-    last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+    first = FIRST_MASK(dst_idx);
+    last = LAST_MASK(dst_idx, n);
 
     if (dst_idx+n <= BITS_PER_LONG) {
 	// Single word
diff --git a/drawops/cfb.c b/drawops/cfb.c
index 1d8c88e7f23e983e..4a5a1ab654d75310 100644
--- a/drawops/cfb.c
+++ b/drawops/cfb.c
@@ -104,7 +104,7 @@ static inline unsigned long pixel_to_pat(pixel_t pixel, int left)
 void cfb_draw_hline(u32 x, u32 y, u32 length, pixel_t pixel)
 {
     unsigned long *dst;
-    int dst_idx, left;
+    int dst_idx, left, right;
     u32 bpp = fb_var.bits_per_pixel;
 
     dst = (unsigned long *)((unsigned long)fb & ~(BYTES_PER_LONG-1));
@@ -118,15 +118,22 @@ void cfb_draw_hline(u32 x, u32 y, u32 length, pixel_t pixel)
 	u32 pat = pixel_to_pat32(pixel);
 	bitfill32(dst, dst_idx, pat, length*bpp);
     } else {
-	unsigned long pat = pixel_to_pat(pixel, (left-dst_idx) % bpp);
-	bitfill(dst, dst_idx, pat, left, bpp-left, length*bpp);
+	unsigned long pat;
+#if __BYTE_ORDER = __LITTLE_ENDIAN
+	right = left;
+	left = bpp-left;
+#else
+	right = bpp-left;
+#endif
+	pat = pixel_to_pat(pixel, (left-dst_idx) % bpp);
+	bitfill(dst, dst_idx, pat, left, right, length*bpp);
     }
 }
 
 void cfb_fill_rect(u32 x, u32 y, u32 width, u32 height, pixel_t pixel)
 {
     unsigned long *dst;
-    int dst_idx, left;
+    int dst_idx, left, right;
     u32 bpp = fb_var.bits_per_pixel;
 
     dst = (unsigned long *)((unsigned long)fb & ~(BYTES_PER_LONG-1));
@@ -143,9 +150,15 @@ void cfb_fill_rect(u32 x, u32 y, u32 width, u32 height, pixel_t pixel)
 	    dst_idx += next_line*8;
 	}
     } else {
-	unsigned long pat = pixel_to_pat(pixel, (left-dst_idx) % bpp);
-	int right = bpp-left;
+	unsigned long pat;
 	int r;
+#if __BYTE_ORDER = __LITTLE_ENDIAN
+	right = left;
+	left = bpp-left;
+#else
+	right = bpp-left;
+#endif
+	pat = pixel_to_pat(pixel, (left-dst_idx) % bpp);
 	while (height--) {
 	    dst += dst_idx >> SHIFT_PER_LONG;
 	    dst_idx &= (BITS_PER_LONG-1);
diff --git a/include/types.h b/include/types.h
index 8b11ee1b1b63ede6..33066fd299be79eb 100644
--- a/include/types.h
+++ b/include/types.h
@@ -9,6 +9,8 @@
  *  more details.
  */
 
+#include <endian.h>
+
 
     /*
      *  Fixed size quantities
-- 
2.17.1
