From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 13/15] fbdev: copyarea function taught
 to fully support swapped pixel order in byte
Date: Sat, 13 Oct 2007 08:32:05 +0800
Message-ID: <47101205.7040801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgVSd-00088Q-T3 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 18:06:35 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUyu-0002xt-O9
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:53 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:52 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Pisa <pisa@cmp.felk.cvut.cz>

From: Pavel Pisa <pisa@cmp.felk.cvut.cz>

This correct case, when source and destination X coordinates difference is n
multiple of pixels in byte. This is probably rare case, but this case should
supported for completeness.

Reorganization of FB_READL and FB_WRITEL calls results in code size decrease
for normal build without swapping support and size with support enabled
is reasonable too.

[adaplas]
Add missing fb_rev_pixels_in_long() prototype.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/cfbcopyarea.c |   84 ++++++++++++++++++++++++++++++-------------
 drivers/video/fb_draw.h     |   26 +++++++++++++
 2 files changed, 85 insertions(+), 25 deletions(-)

diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
index 1c67885..d05f9d3 100644
--- a/drivers/video/cfbcopyarea.c
+++ b/drivers/video/cfbcopyarea.c
@@ -94,29 +94,34 @@ bitcpy(unsigned long __iomem *dst, int d
 				FB_WRITEL( comp( FB_READL(src), FB_READL(dst), last), dst);
 		}
 	} else {
+		// Different alignment for source and dest
 		unsigned long d0, d1;
 		int m;
-		// Different alignment for source and dest
 
 		right = shift & (bits - 1);
 		left = -shift & (bits - 1);
+		bswapmask &= shift;
 
 		if (dst_idx+n <= bits) {
 			// Single destination word
 			if (last)
 				first &= last;
+			d0 = FB_READL(src);
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL( comp( FB_READL(src) >> right, FB_READL(dst), first), dst);
+				d0 >>= right;
 			} else if (src_idx+n <= bits) {
 				// Single source word
-				FB_WRITEL( comp(FB_READL(src) << left, FB_READL(dst), first), dst);
+				d0 <<= left;;
 			} else {
 				// 2 source words
-				d0 = FB_READL(src++);
-				d1 = FB_READL(src);
-				FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), first), dst);
+				d1 = FB_READL(src + 1);
+				d1 = fb_rev_pixels_in_long(d1, bswapmask);
+				d0 = d0<<left | d1>>right;
 			}
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL( comp(d0, FB_READL(dst), first), dst);
 		} else {
 			// Multiple destination words
 			/** We must always remember the last value read, because in case
@@ -125,25 +130,31 @@ bitcpy(unsigned long __iomem *dst, int d
 			overlap with the current long from SRC. We store this value in
 			'd0'. */
 			d0 = FB_READL(src++);
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
 			// Leading bits
 			if (shift > 0) {
 				// Single source word
-				FB_WRITEL( comp(d0 >> right, FB_READL(dst), first), dst);
+				d1 = d0;
+				d0 >>= right;
 				dst++;
 				n -= bits - dst_idx;
 			} else {
 				// 2 source words
 				d1 = FB_READL(src++);
-				FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), first), dst);
-				d0 = d1;
+				d1 = fb_rev_pixels_in_long(d1, bswapmask);
+
+				d0 = d0<<left | d1>>right;
 				dst++;
 				n -= bits - dst_idx;
 			}
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL( comp(d0, FB_READL(dst), first), dst);
+			d0 = d1;
 
 			// Main chunk
 			m = n % bits;
 			n /= bits;
-			while (n >= 4) {
+			while ((n >= 4) && !bswapmask) {
 				d1 = FB_READL(src++);
 				FB_WRITEL(d0 << left | d1 >> right, dst++);
 				d0 = d1;
@@ -160,7 +171,10 @@ bitcpy(unsigned long __iomem *dst, int d
 			}
 			while (n--) {
 				d1 = FB_READL(src++);
-				FB_WRITEL(d0 << left | d1 >> right, dst++);
+				d1 = fb_rev_pixels_in_long(d1, bswapmask);
+				d0 = d0 << left | d1 >> right;
+				d0 = fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL(d0, dst++);
 				d0 = d1;
 			}
 
@@ -168,12 +182,15 @@ bitcpy(unsigned long __iomem *dst, int d
 			if (last) {
 				if (m <= right) {
 					// Single source word
-					FB_WRITEL( comp(d0 << left, FB_READL(dst), last), dst);
+					d0 <<= left;
 				} else {
 					// 2 source words
 					d1 = FB_READL(src);
-					FB_WRITEL( comp(d0<<left | d1>>right, FB_READL(dst), last), dst);
+					d1 = fb_rev_pixels_in_long(d1, bswapmask);
+					d0 = d0<<left | d1>>right;
 				}
+				d0 = fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL( comp(d0, FB_READL(dst), last), dst);
 			}
 		}
 	}
@@ -247,24 +264,32 @@ bitcpy_rev(unsigned long __iomem *dst, i
 		}
 	} else {
 		// Different alignment for source and dest
+		unsigned long d0, d1;
+		int m;
 
 		int const left = -shift & (bits-1);
 		int const right = shift & (bits-1);
+		bswapmask &= shift;
 
 		if ((unsigned long)dst_idx+1 >= n) {
 			// Single destination word
 			if (last)
 				first &= last;
+			d0 = FB_READL(src);
 			if (shift < 0) {
 				// Single source word
-				FB_WRITEL( comp( FB_READL(src)<<left, FB_READL(dst), first), dst);
+				d0 <<= left;
 			} else if (1+(unsigned long)src_idx >= n) {
 				// Single source word
-				FB_WRITEL( comp( FB_READL(src)>>right, FB_READL(dst), first), dst);
+				d0 >>= right;
 			} else {
 				// 2 source words
-				FB_WRITEL( comp( (FB_READL(src)>>right | FB_READL(src-1)<<left), FB_READL(dst), first), dst);
+				d1 = FB_READL(src - 1);
+				d1 = fb_rev_pixels_in_long(d1, bswapmask);
+				d0 = d0>>right | d1<<left;
 			}
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL( comp(d0, FB_READL(dst), first), dst);
 		} else {
 			// Multiple destination words
 			/** We must always remember the last value read, because in case
@@ -272,27 +297,30 @@ bitcpy_rev(unsigned long __iomem *dst, i
 			1bpp), we always collect one full long for DST and that might
 			overlap with the current long from SRC. We store this value in
 			'd0'. */
-			unsigned long d0, d1;
-			int m;
 
 			d0 = FB_READL(src--);
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
 			// Leading bits
 			if (shift < 0) {
 				// Single source word
-				FB_WRITEL( comp( (d0 << left), FB_READL(dst), first), dst);
+				d1 = d0;
+				d0 <<= left;
 			} else {
 				// 2 source words
 				d1 = FB_READL(src--);
-				FB_WRITEL( comp( (d0>>right | d1<<left), FB_READL(dst), first), dst);
-				d0 = d1;
+				d1 = fb_rev_pixels_in_long(d1, bswapmask);
+				d0 = d0>>right | d1<<left;
 			}
+			d0 = fb_rev_pixels_in_long(d0, bswapmask);
+			FB_WRITEL( comp(d0, FB_READL(dst), first), dst);
+			d0 = d1;
 			dst--;
 			n -= dst_idx+1;
 
 			// Main chunk
 			m = n % bits;
 			n /= bits;
-			while (n >= 4) {
+			while ((n >= 4) && !bswapmask) {
 				d1 = FB_READL(src--);
 				FB_WRITEL(d0 >> right | d1 << left, dst--);
 				d0 = d1;
@@ -309,7 +337,10 @@ bitcpy_rev(unsigned long __iomem *dst, i
 			}
 			while (n--) {
 				d1 = FB_READL(src--);
-				FB_WRITEL(d0 >> right | d1 << left, dst--);
+				d1 = fb_rev_pixels_in_long(d1, bswapmask);
+				d0 = d0 >> right | d1 << left;
+				d0 = fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL(d0, dst--);
 				d0 = d1;
 			}
 
@@ -317,12 +348,15 @@ bitcpy_rev(unsigned long __iomem *dst, i
 			if (last) {
 				if (m <= left) {
 					// Single source word
-					FB_WRITEL( comp(d0 >> right, FB_READL(dst), last), dst);
+					d0 >>= right;
 				} else {
 					// 2 source words
 					d1 = FB_READL(src);
-					FB_WRITEL( comp(d0>>right | d1<<left, FB_READL(dst), last), dst);
+					d1 = fb_rev_pixels_in_long(d1, bswapmask);
+					d0 = d0>>right | d1<<left;
 				}
+				d0 = fb_rev_pixels_in_long(d0, bswapmask);
+				FB_WRITEL( comp(d0, FB_READL(dst), last), dst);
 			}
 		}
 	}
diff --git a/drivers/video/fb_draw.h b/drivers/video/fb_draw.h
index 816843f..5dae96e 100644
--- a/drivers/video/fb_draw.h
+++ b/drivers/video/fb_draw.h
@@ -72,6 +72,26 @@ pixel_to_pat( u32 bpp, u32 pixel)
 #endif
 
 #ifdef CONFIG_FB_CFB_REV_PIXELS_IN_BYTE
+#if BITS_PER_LONG == 64
+#define REV_PIXELS_MASK1 0x5555555555555555ul
+#define REV_PIXELS_MASK2 0x3333333333333333ul
+#define REV_PIXELS_MASK4 0x0f0f0f0f0f0f0f0ful
+#else
+#define REV_PIXELS_MASK1 0x55555555ul
+#define REV_PIXELS_MASK2 0x33333333ul
+#define REV_PIXELS_MASK4 0x0f0f0f0ful
+#endif
+
+static inline unsigned long fb_rev_pixels_in_long(unsigned long val,
+						  u32 bswapmask)
+{
+	if(bswapmask & 1)
+		val = comp(val >> 1, val << 1, REV_PIXELS_MASK1);
+	if(bswapmask & 2)
+		val = comp(val >> 2, val << 2, REV_PIXELS_MASK2);
+	if(bswapmask & 3)
+		val = comp(val >> 4, val << 4, REV_PIXELS_MASK4);
+}
 
 static inline u32 fb_shifted_pixels_mask_u32(u32 index, u32 bswapmask)
 {
@@ -131,6 +151,12 @@ static inline u32 fb_compute_bswapmask(s
 
 #else /* CONFIG_FB_CFB_REV_PIXELS_IN_BYTE */
 
+static inline unsigned long fb_rev_pixels_in_long(unsigned long val,
+						  u32 bswapmask)
+{
+	return val;
+}
+
 #define fb_shifted_pixels_mask_u32(i, b) FB_SHIFT_HIGH(~(u32)0, (i))
 #define fb_shifted_pixels_mask_long(i, b) FB_SHIFT_HIGH(~0UL, (i))
 #define fb_compute_bswapmask(...) 0


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
