From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/4] fbdev: Add iomem annotations to cfbimgblt.c
Date: Sat, 18 Sep 2004 11:48:00 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409181137.58690.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269111AbUIRDrp@vger.kernel.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

- Add iomem annotations to cfbimgblt.c

- remove pitch_index (if buffer pitch is not divisible by sizeof(u32)).
  This never gets used.
 
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 cfbimgblt.c |   68 ++++++++++++++++++++++--------------------------------------
 1 files changed, 26 insertions(+), 42 deletions(-)

diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/cfbimgblt.c linux-2.6.9-rc2-mm1/drivers/video/cfbimgblt.c
--- linux-2.6.9-rc2-mm1-orig/drivers/video/cfbimgblt.c	2004-09-16 19:32:57.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/cfbimgblt.c	2004-09-18 10:32:41.551674624 +0800
@@ -87,21 +87,20 @@ static u32 cfb_tab32[] = {
 #endif
 
 static inline void color_imageblit(const struct fb_image *image, 
-				   struct fb_info *p, u8 *dst1, 
-				   u32 start_index,
-				   u32 pitch_index)
+				   struct fb_info *p, u8 __iomem *dst1,
+				   u32 start_index)
 {
 	/* Draw the penguin */
-	u32 *dst, *dst2, color = 0, val, shift;
+	u32 __iomem *dst;
+	u32  color = 0, val, shift;
 	int i, n, bpp = p->var.bits_per_pixel;
 	u32 null_bits = 32 - bpp;
 	u32 *palette = (u32 *) p->pseudo_palette;
 	const u8 *src = image->data;
 
-	dst2 = (u32 *) dst1;
 	for (i = image->height; i--; ) {
 		n = image->width;
-		dst = (u32 *) dst1;
+		dst = (u32 __iomem *) dst1;
 		shift = 0;
 		val = 0;
 		
@@ -134,36 +133,27 @@ static inline void color_imageblit(const
 			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
 		}
 		dst1 += p->fix.line_length;
-		if (pitch_index) {
-			dst2 += p->fix.line_length;
-			dst1 = (u8 *)((long)dst2 & ~(sizeof(u32) - 1));
-
-			start_index += pitch_index;
-			start_index &= 32 - 1;
-		}
 	}
 }
 
-static inline void slow_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 *dst1, u32 fgcolor,
-				  u32 bgcolor, 
-				  u32 start_index,
-				  u32 pitch_index)
+static inline void slow_imageblit(const struct fb_image *image,
+				  struct fb_info *p,
+				  u8 __iomem *dst1, u32 fgcolor,
+				  u32 bgcolor, u32 start_index)
 {
 	u32 shift, color = 0, bpp = p->var.bits_per_pixel;
-	u32 *dst, *dst2, val, pitch = p->fix.line_length;
+	u32 __iomem *dst;
+	u32  val, pitch = p->fix.line_length;
 	u32 null_bits = 32 - bpp;
 	u32 spitch = (image->width+7)/8;
 	const u8 *src = image->data, *s;
 	u32 i, j, l;
 	
-	dst2 = (u32 *) dst1;
-
 	for (i = image->height; i--; ) {
 		shift = val = 0;
 		l = 8;
 		j = image->width;
-		dst = (u32 *) dst1;
+		dst = (u32 __iomem *) dst1;
 		s = src;
 
 		/* write leading bits */
@@ -199,13 +189,6 @@ static inline void slow_imageblit(const 
 		
 		dst1 += pitch;
 		src += spitch;	
-		if (pitch_index) {
-			dst2 += pitch;
-			dst1 = (u8 *)((long)dst2 & ~(sizeof(u32) - 1));
-			start_index += pitch_index;
-			start_index &= 32 - 1;
-		}
-		
 	}
 }
 
@@ -217,15 +200,16 @@ static inline void slow_imageblit(const 
  *           fix->line_legth is divisible by 4;
  *           beginning and end of a scanline is dword aligned
  */
-static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 *dst1, u32 fgcolor, 
+static inline void fast_imageblit(const struct fb_image *image,
+				  struct fb_info *p,
+				  u8 __iomem *dst1, u32 fgcolor,
 				  u32 bgcolor) 
 {
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
 	u32 bit_mask, end_mask, eorx, shift;
 	const char *s = image->data, *src;
-	u32 *dst;
+	u32 __iomem *dst;
 	u32 *tab = NULL;
 	int i, j, k;
 		
@@ -253,7 +237,9 @@ static inline void fast_imageblit(const 
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (u32 *) dst1, shift = 8; src = s;
+		dst = (u32 __iomem *) dst1, shift = 8;
+
+		src = s;
 		
 		for (j = k; j--; ) {
 			shift -= ppw;
@@ -268,12 +254,12 @@ static inline void fast_imageblit(const 
 	
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
-	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
+	u32 fgcolor, bgcolor, start_index, bitstart;
 	u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
 	u32 width = image->width, height = image->height; 
 	u32 dx = image->dx, dy = image->dy;
 	int x2, y2, vxres, vyres;
-	u8 *dst1;
+	u8 __iomem *dst1;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
@@ -299,11 +285,10 @@ void cfb_imageblit(struct fb_info *p, co
 
 	bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
 	start_index = bitstart & (32 - 1);
-	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
 
 	bitstart /= 8;
 	bitstart &= ~(bpl - 1);
-	dst1 = p->screen_base + bitstart;
+	dst1 = (u8 __iomem *) p->screen_base + bitstart;
 
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
@@ -318,15 +303,14 @@ void cfb_imageblit(struct fb_info *p, co
 			bgcolor = image->bg_color;
 		}	
 		
-		if (32 % bpp == 0 && !start_index && !pitch_index && 
-		    ((width & (32/bpp-1)) == 0) &&
-		    bpp >= 8 && bpp <= 32) 			
+		if (32 % bpp == 0 && !start_index &&
+		    ((width & (32/bpp-1)) == 0) && bpp >= 8 && bpp <= 32)
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
-					start_index, pitch_index);
+					start_index);
 	} else
-		color_imageblit(image, p, dst1, start_index, pitch_index);
+		color_imageblit(image, p, dst1, start_index);
 }
 
 EXPORT_SYMBOL(cfb_imageblit);
