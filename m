From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Fix incorrect unaligned access in little-endian machines
Date: Sun, 20 Nov 2005 20:49:18 +0800
Message-ID: <438070CE.8050800@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdxKk-00087L-E7
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:50 -0800
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdxKk-0004L6-02
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 14:06:50 -0800
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
Cc: linux-fbdev-devel@lists.sf.net

The drawing function cfbfillrect does not work correctly when access is
not unsigned-long aligned.  It manifests as extra lines of pixels that are
not complete drawn.  Reversing the shift operator solves the problem, so
I would presume that this bug would manifest only on little endian machines.
The function cfbcopyarea may also have this bug.

Aligned access should present no problems.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
This is possibly needed for 2.6.15.

 drivers/video/cfbcopyarea.c |    8 ++++----
 drivers/video/cfbfillrect.c |   16 ++++++++--------
 drivers/video/cfbimgblt.c   |   36 ++++++++++++------------------------
 include/linux/fb.h          |   12 ++++++++++++
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
index cdc7157..7441532 100644
--- a/drivers/video/cfbcopyarea.c
+++ b/drivers/video/cfbcopyarea.c
@@ -64,8 +64,8 @@ bitcpy(unsigned long __iomem *dst, int d
 	int const shift = dst_idx-src_idx;
 	int left, right;
 
-	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % bits));
+	first = FB_SHIFT_HIGH(~0UL, dst_idx);
+	last = ~(FB_SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
 
 	if (!shift) {
 		// Same alignment for source and dest
@@ -216,8 +216,8 @@ bitcpy_rev(unsigned long __iomem *dst, i
 
 	shift = dst_idx-src_idx;
 
-	first = ~0UL << (bits - 1 - dst_idx);
-	last = ~(~0UL << (bits - 1 - ((dst_idx-n) % bits)));
+	first = FB_SHIFT_LOW(~0UL, bits - 1 - dst_idx);
+	last = ~(FB_SHIFT_LOW(~0UL, bits - 1 - ((dst_idx-n) % bits)));
 
 	if (!shift) {
 		// Same alignment for source and dest
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
index 167d931..e5ff62e 100644
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -110,8 +110,8 @@ bitfill_aligned(unsigned long __iomem *d
 	if (!n)
 		return;
 
-	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % bits));
+	first = FB_SHIFT_HIGH(~0UL, dst_idx);
+	last = ~(FB_SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
 
 	if (dst_idx+n <= bits) {
 		// Single word
@@ -167,8 +167,8 @@ bitfill_unaligned(unsigned long __iomem 
 	if (!n)
 		return;
 
-	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % bits));
+	first = FB_SHIFT_HIGH(~0UL, dst_idx);
+	last = ~(FB_SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
 
 	if (dst_idx+n <= bits) {
 		// Single word
@@ -221,8 +221,8 @@ bitfill_aligned_rev(unsigned long __iome
 	if (!n)
 		return;
 
-	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % bits));
+	first = FB_SHIFT_HIGH(~0UL, dst_idx);
+	last = ~(FB_SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
 
 	if (dst_idx+n <= bits) {
 		// Single word
@@ -290,8 +290,8 @@ bitfill_unaligned_rev(unsigned long __io
 	if (!n)
 		return;
 
-	first = ~0UL >> dst_idx;
-	last = ~(~0UL >> ((dst_idx+n) % bits));
+	first = FB_SHIFT_HIGH(~0UL, dst_idx);
+	last = ~(FB_SHIFT_HIGH(~0UL, (dst_idx+n) % bits));
 
 	if (dst_idx+n <= bits) {
 		// Single word
diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 7a01742..910e233 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -76,18 +76,6 @@ static u32 cfb_tab32[] = {
 #define FB_WRITEL fb_writel
 #define FB_READL  fb_readl
 
-#if defined (__BIG_ENDIAN)
-#define LEFT_POS(bpp)          (32 - bpp)
-#define SHIFT_HIGH(val, bits)  ((val) >> (bits))
-#define SHIFT_LOW(val, bits)   ((val) << (bits))
-#define BIT_NR(b)              (7 - (b))
-#else
-#define LEFT_POS(bpp)          (0)
-#define SHIFT_HIGH(val, bits)  ((val) << (bits))
-#define SHIFT_LOW(val, bits)   ((val) >> (bits))
-#define BIT_NR(b)              (b)
-#endif
-
 static inline void color_imageblit(const struct fb_image *image, 
 				   struct fb_info *p, u8 __iomem *dst1, 
 				   u32 start_index,
@@ -109,7 +97,7 @@ static inline void color_imageblit(const
 		val = 0;
 		
 		if (start_index) {
-			u32 start_mask = ~(SHIFT_HIGH(~(u32)0, start_index));
+			u32 start_mask = ~(FB_SHIFT_HIGH(~(u32)0, start_index));
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
 		}
@@ -119,20 +107,20 @@ static inline void color_imageblit(const
 				color = palette[*src];
 			else
 				color = *src;
-			color <<= LEFT_POS(bpp);
-			val |= SHIFT_HIGH(color, shift);
+			color <<= FB_LEFT_POS(bpp);
+			val |= FB_SHIFT_HIGH(color, shift);
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
 	
 				val = (shift == null_bits) ? 0 : 
-					SHIFT_LOW(color, 32 - shift);
+					FB_SHIFT_LOW(color, 32 - shift);
 			}
 			shift += bpp;
 			shift &= (32 - 1);
 			src++;
 		}
 		if (shift) {
-			u32 end_mask = SHIFT_HIGH(~(u32)0, shift);
+			u32 end_mask = FB_SHIFT_HIGH(~(u32)0, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
@@ -162,8 +150,8 @@ static inline void slow_imageblit(const 
 	u32 i, j, l;
 	
 	dst2 = (u32 __iomem *) dst1;
-	fgcolor <<= LEFT_POS(bpp);
-	bgcolor <<= LEFT_POS(bpp);
+	fgcolor <<= FB_LEFT_POS(bpp);
+	bgcolor <<= FB_LEFT_POS(bpp);
 
 	for (i = image->height; i--; ) {
 		shift = val = 0;
@@ -174,21 +162,21 @@ static inline void slow_imageblit(const 
 
 		/* write leading bits */
 		if (start_index) {
-			u32 start_mask = ~(SHIFT_HIGH(~(u32)0, start_index));
+			u32 start_mask = ~(FB_SHIFT_HIGH(~(u32)0,start_index));
 			val = FB_READL(dst) & start_mask;
 			shift = start_index;
 		}
 
 		while (j--) {
 			l--;
-			color = (*s & 1 << (BIT_NR(l))) ? fgcolor : bgcolor;
-			val |= SHIFT_HIGH(color, shift);
+			color = (*s & 1 << (FB_BIT_NR(l))) ? fgcolor : bgcolor;
+			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
 				val = (shift == null_bits) ? 0 :
-					 SHIFT_LOW(color,32 - shift);
+					FB_SHIFT_LOW(color,32 - shift);
 			}
 			shift += bpp;
 			shift &= (32 - 1);
@@ -197,7 +185,7 @@ static inline void slow_imageblit(const 
 
 		/* write trailing bits */
  		if (shift) {
-			u32 end_mask = SHIFT_HIGH(~(u32)0, shift);
+			u32 end_mask = FB_SHIFT_HIGH(~(u32)0, shift);
 
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 04a58f3..58e6c21 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -817,6 +817,18 @@ struct fb_info {
 
 #endif
 
+#if defined (__BIG_ENDIAN)
+#define FB_LEFT_POS(bpp)          (32 - bpp)
+#define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
+#define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
+#define FB_BIT_NR(b)              (7 - (b))
+#else
+#define FB_LEFT_POS(bpp)          (0)
+#define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
+#define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
+#define FB_BIT_NR(b)              (b)
+#endif
+
     /*
      *  `Generic' versions of the frame buffer device operations
      */



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
