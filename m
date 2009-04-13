From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] fbdev: fix fillrect for 24bpp modes
Date: Mon, 13 Apr 2009 19:09:54 +0200
Message-ID: <20090413170954.GA8403@tria>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753478AbZDMRLQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org

The software fillrect routines do not work properly when the number of
pixels per machine word is not an integer.  To see that, run the following
command on a fbdev console with a 24bpp video mode, using a non-accelerated
driver such as (u)vesafb:

  reset ; echo -e '\e[41mtest\e[K'

The expected result is 'test' displayed on a line with red background.
Instead of that, 'test' has a red background, but the rest of the line
(rendered using fillrect()) contains a distored colorful pattern.

This patch fixes the problem by correctly computing rotation shifts.
It has been tested in a 24bpp mode on 32- and 64-bit little-endian
machines.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
index 64b3576..396e676 100644
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -9,10 +9,6 @@
  *
  * NOTES:
  *
- *  The code for depths like 24 that don't have integer number of pixels per
- *  long is broken and needs to be fixed. For now I turned these types of
- *  mode off.
- *
  *  Also need to add code to deal with cards endians that are different than
  *  the native cpu endians. I also need to deal with MSB position in the word.
  *
@@ -139,7 +135,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long __iomem *dst, int dst_idx,
 
 		// Trailing bits
 		if (last)
-			FB_WRITEL(comp(pat, FB_READL(dst), first), dst);
+			FB_WRITEL(comp(pat, FB_READL(dst), last), dst);
 	}
 }
 
@@ -297,7 +293,7 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 	else
 		fg = rect->color;
 
-	pat = pixel_to_pat( bpp, fg);
+	pat = pixel_to_pat(bpp, fg);
 
 	dst = (unsigned long __iomem *)((unsigned long)p->screen_base & ~(bytes-1));
 	dst_idx = ((unsigned long)p->screen_base & (bytes - 1))*8;
@@ -333,17 +329,20 @@ void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 			dst_idx += p->fix.line_length*8;
 		}
 	} else {
-		int right;
-		int r;
-		int rot = (left-dst_idx) % bpp;
+		int right, r;
 		void (*fill_op)(struct fb_info *p, unsigned long __iomem *dst,
 				int dst_idx, unsigned long pat, int left,
 				int right, unsigned n, int bits) = NULL;
-
+#ifdef __LITTLE_ENDIAN
+		right = left;
+		left = bpp - right;
+#else
+		right = bpp - left;
+#endif
 		/* rotate pattern to correct start position */
-		pat = pat << rot | pat >> (bpp-rot);
+		r = dst_idx >> (ffs(bits) - 1);
+		pat = pat << ((left*r) % bpp) | pat >> ((right*r) % bpp);
 
-		right = bpp-left;
 		switch (rect->rop) {
 		case ROP_XOR:
 			fill_op = bitfill_unaligned_rev;
diff --git a/drivers/video/fb_draw.h b/drivers/video/fb_draw.h
index 1db6221..fa9626e 100644
--- a/drivers/video/fb_draw.h
+++ b/drivers/video/fb_draw.h
@@ -33,11 +33,11 @@ pixel_to_pat( u32 bpp, u32 pixel)
 	case 8:
 		return 0x0101010101010101ul*pixel;
 	case 12:
-		return 0x0001001001001001ul*pixel;
+		return 0x1001001001001001ul*pixel;
 	case 16:
 		return 0x0001000100010001ul*pixel;
 	case 24:
-		return 0x0000000001000001ul*pixel;
+		return 0x0001000001000001ul*pixel;
 	case 32:
 		return 0x0000000100000001ul*pixel;
 	default:
@@ -58,11 +58,11 @@ pixel_to_pat( u32 bpp, u32 pixel)
 	case 8:
 		return 0x01010101ul*pixel;
 	case 12:
-		return 0x00001001ul*pixel;
+		return 0x01001001ul*pixel;
 	case 16:
 		return 0x00010001ul*pixel;
 	case 24:
-		return 0x00000001ul*pixel;
+		return 0x01000001ul*pixel;
 	case 32:
 		return 0x00000001ul*pixel;
 	default:
diff --git a/drivers/video/sysfillrect.c b/drivers/video/sysfillrect.c
index f94d6b6..024e6b9 100644
--- a/drivers/video/sysfillrect.c
+++ b/drivers/video/sysfillrect.c
@@ -124,7 +124,7 @@ bitfill_unaligned(struct fb_info *p, unsigned long *dst, int dst_idx,
 
 		/* Trailing bits */
 		if (last)
-			*dst = comp(pat, *dst, first);
+			*dst = comp(pat, *dst, last);
 	}
 }
 
@@ -292,17 +292,20 @@ void sys_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 			dst_idx += p->fix.line_length*8;
 		}
 	} else {
-		int right;
-		int r;
-		int rot = (left-dst_idx) % bpp;
+		int right, r;
 		void (*fill_op)(struct fb_info *p, unsigned long *dst,
 				int dst_idx, unsigned long pat, int left,
 				int right, unsigned n, int bits) = NULL;
-
+#ifdef __LITTLE_ENDIAN
+		right = left;
+		left = bpp - right;
+#else
+		right = bpp - left;
+#endif
 		/* rotate pattern to correct start position */
-		pat = pat << rot | pat >> (bpp-rot);
+		r = dst_idx >> (ffs(bits) - 1);
+		pat = pat << ((left*r) % bpp) | pat >> ((right*r) % bpp);
 
-		right = bpp-left;
 		switch (rect->rop) {
 		case ROP_XOR:
 			fill_op = bitfill_unaligned_rev;
