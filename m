From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] fix endian problem in color_imageblit
Date: Thu, 12 Dec 2002 14:41:30 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <15864.1386.543811.337732@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This patch fixes the endian problems in color_imageblit().  With this
patch, I get the penguin drawn properly on boot.

The main change is that on big-endian systems, when we load a pixel
from the source, we now shift it to the left-hand (most significant)
end of the word.  With this change the rest of the logic is correct on
big-endian systems.  This may not be the most efficient way to do
things but it is a simple change that works and avoids disturbing the
rest of the code.

Paul.

diff -urN linux-2.5/drivers/video/cfbimgblt.c pmac-2.5/drivers/video/cfbimgblt.c
--- linux-2.5/drivers/video/cfbimgblt.c	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/cfbimgblt.c	2002-12-12 09:14:47.000000000 +1100
@@ -103,10 +103,10 @@
 {
 	/* Draw the penguin */
 	int i, n;
-	unsigned long bitmask = SHIFT_LOW(~0UL, BITS_PER_LONG - p->var.bits_per_pixel);
+	int bpp = p->var.bits_per_pixel;
 	unsigned long *palette = (unsigned long *) p->pseudo_palette;
 	unsigned long *dst, *dst2, color = 0, val, shift;
-	unsigned long null_bits = BITS_PER_LONG - p->var.bits_per_pixel; 
+	unsigned long null_bits = BITS_PER_LONG - bpp;
 	u8 *src = image->data;
 
 	dst2 = (unsigned long *) dst1;
@@ -125,9 +125,10 @@
 		while (n--) {
 			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-				color = palette[*src] & bitmask;
+				color = palette[*src];
 			else
-				color = *src & bitmask;	
+				color = *src;
+			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
@@ -136,7 +137,7 @@
 				else
 					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
 			}
-			shift += p->var.bits_per_pixel;
+			shift += bpp;
 			shift &= (BITS_PER_LONG - 1);
 			src++;
 		}
