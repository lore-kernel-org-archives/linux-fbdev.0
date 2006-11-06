From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: [PATCH] fbcon: ReRe-fix little-endian bogosity in slow_imageblit()
Date: Mon, 06 Nov 2006 10:28:16 +0100
Message-ID: <454F0030.80101@innova-card.com>
References: <454B5866.6000207@innova-card.com>	 <20061103105857.874f566c.akpm@osdl.org> <cda58cb80611040122w6cf42014vf17f48edda97e797@mail.gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423183AbWKFJ1n@vger.kernel.org>
In-Reply-To: <cda58cb80611040122w6cf42014vf17f48edda97e797@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, gregkh@suse.de

From: Franck Bui-Huu <fbuihuu@gmail.com>

It seems that this piece of code has already been fixed twice...

The first fix has been made by the following commit:

	81d3e147ec9ffc6ef04b5f05afa4bef22487b32b

by introducing FB_BIT_NR() macro to fix a 'potential' endianess
bug. It appears that change was broken for big endian platforms,
but I suspect it was for little-endian ones too.

Then a second fix has been made to fix the previous change for
big-endian platform, see commit:

	a536093a2f07007aa572e922752b7491b9ea8ff2

This commit actually reverted the first fix and thus makes the
big-endian case works but leaves the little-endian case broken.
Therefore it seems that the very first state was broken only
on little-endian platform...

This patch is the third and hopefully the last attempt to fix
this bug correctly. It restores the first fix _and_ swaps the
little-endian and bit-endian implementations of FB_BIT_NR().

Now, it should work for both endianness but has been tested on
little-endian machine only.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Same patch with change log updated.

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
@@ -854,10 +854,12 @@ struct fb_info {
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
1.4.3.4
