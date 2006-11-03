From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] fbcon: Re-fix little-endian bogosity in slow_imageblit()
Date: Fri, 03 Nov 2006 15:55:34 +0100
Message-ID: <454B5866.6000207@innova-card.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753255AbWKCOzD@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, adaplas@pol.net, gregkh@suse.de

From: Franck Bui-Huu <fbuihuu@gmail.com>

This bug has been introduced by commit:

	a536093a2f07007aa572e922752b7491b9ea8ff2

This commit fixed the big-endian case but broke the little-endian one.
This patch revert the previous change and swap the definition of
FB_BIT_NR() macro between big and little endian. It should work for
both endianess now.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 This is the most obvious fix for me although it's a bit weird
 that bit ordering depend on platform endianess. I don't know
 fb code so I prefer submitting this trivial fix rather than
 breaking every thing else ;)

 drivers/video/cfbimgblt.c |    4 ++--
 include/linux/fb.h        |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
index 51d3538..8f47bf4 100644
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -168,7 +168,7 @@ static inline void slow_imageblit(const
 
 		while (j--) {
 			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
+			color = (*s & (1 << FB_BIT_NR(l))) ? fgcolor : bgcolor;
 			val |= FB_SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */
@@ -258,7 +258,7 @@ static inline void fast_imageblit(const
 		s += spitch;
 	}
 }	
-	
+
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3e69241..6ca18b8 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -854,10 +854,12 @@ #define fb_memset memset
 #endif
 
 #if defined (__BIG_ENDIAN)
+#define FB_BIT_NR(b)              (b)
 #define FB_LEFT_POS(bpp)          (32 - bpp)
 #define FB_SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
+#define FB_BIT_NR(b)              (7 - (b))
 #define FB_LEFT_POS(bpp)          (0)
 #define FB_SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define FB_SHIFT_LOW(val, bits)   ((val) >> (bits))
-- 
1.4.3.2
