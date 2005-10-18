From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 5/17] fbdev: Remove software clipping from drawing functions
Date: Tue, 18 Oct 2005 17:16:12 +0800
Message-ID: <4354BD5C.40303@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIC-0000bN-2T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:40 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIB-0002Fg-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:40 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395674nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:39 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Remove software clipping from imageblit, fillrect and copyarea.  Clipping
is not needed because the console layer assures that reads/writes does not
happen beyond the extents of the framebuffer.  And software clipping tends
to hide bugs, if they do exist.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 cfbcopyarea.c |   36 ------------------------------------
 cfbfillrect.c |   24 ++----------------------
 cfbimgblt.c   |   22 +---------------------
 3 files changed, 3 insertions(+), 79 deletions(-)


diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
--- a/drivers/video/cfbcopyarea.c
+++ b/drivers/video/cfbcopyarea.c
@@ -349,46 +349,10 @@ void cfb_copyarea(struct fb_info *p, con
 	unsigned long __iomem *dst = NULL, *src = NULL;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	int dst_idx = 0, src_idx = 0, rev_copy = 0;
-	int x2, y2, vxres, vyres;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	/* We want rotation but lack hardware to do it for us. */
-	if (!p->fbops->fb_rotate && p->var.rotate) {
-	}
-
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-
-	if (area->dx > vxres || area->sx > vxres ||
-	    area->dy > vyres || area->sy > vyres)
-		return;
-
-	/* clip the destination
-	 * We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly.
-	 */
-	x2 = area->dx + area->width;
-	y2 = area->dy + area->height;
-	dx = area->dx > 0 ? area->dx : 0;
-	dy = area->dy > 0 ? area->dy : 0;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	width = x2 - dx;
-	height = y2 - dy;
-
-	if ((width==0) ||(height==0))
-		return;
-
-	/* update sx1,sy1 */
-	sx += (dx - area->dx);
-	sy += (dy - area->dy);
-
-	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 || (sx + width) > vxres || (sy + height) > vyres)
-		return;
-
 	/* if the beginning of the target area might overlap with the end of
 	the source area, be have to copy the area reverse. */
 	if ((dy == sy && dx > sx) || (dy > sy)) {
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -344,7 +344,8 @@ bitfill_unaligned_rev(unsigned long __io
 
 void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
-	unsigned long x2, y2, vxres, vyres, height, width, pat, fg;
+	unsigned long pat, fg;
+	unsigned long width = rect->width, height = rect->height;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	u32 bpp = p->var.bits_per_pixel;
 	unsigned long __iomem *dst;
@@ -353,27 +354,6 @@ void cfb_fillrect(struct fb_info *p, con
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	/* We want rotation but lack hardware to do it for us. */
-	if (!p->fbops->fb_rotate && p->var.rotate) {
-	}
-
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-
-	if (!rect->width || !rect->height ||
-	    rect->dx > vxres || rect->dy > vyres)
-		return;
-
-	/* We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly. */
-Remove software clipping from imageblit, fillrect and copyarea.  Clipping
is not needed because the console layer assures that reads/writes doest not
happen beyond the extents of the framebuffer.  And software clipping tends
to hide bugs, if they do exist.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 cfbcopyarea.c |   36 ------------------------------------
 cfbfillrect.c |   24 ++----------------------
 cfbimgblt.c   |   22 +---------------------
 3 files changed, 3 insertions(+), 79 deletions(-)


diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
--- a/drivers/video/cfbcopyarea.c
+++ b/drivers/video/cfbcopyarea.c
@@ -349,46 +349,10 @@ void cfb_copyarea(struct fb_info *p, con
 	unsigned long __iomem *dst = NULL, *src = NULL;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	int dst_idx = 0, src_idx = 0, rev_copy = 0;
-	int x2, y2, vxres, vyres;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	/* We want rotation but lack hardware to do it for us. */
-	if (!p->fbops->fb_rotate && p->var.rotate) {
-	}
-
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-
-	if (area->dx > vxres || area->sx > vxres ||
-	    area->dy > vyres || area->sy > vyres)
-		return;
-
-	/* clip the destination
-	 * We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly.
-	 */
-	x2 = area->dx + area->width;
-	y2 = area->dy + area->height;
-	dx = area->dx > 0 ? area->dx : 0;
-	dy = area->dy > 0 ? area->dy : 0;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	width = x2 - dx;
-	height = y2 - dy;
-
-	if ((width==0) ||(height==0))
-		return;
-
-	/* update sx1,sy1 */
-	sx += (dx - area->dx);
-	sy += (dy - area->dy);
-
-	/* the source must be completely inside the virtual screen */
-	if (sx < 0 || sy < 0 || (sx + width) > vxres || (sy + height) > vyres)
-		return;
-
 	/* if the beginning of the target area might overlap with the end of
 	the source area, be have to copy the area reverse. */
 	if ((dy == sy && dx > sx) || (dy > sy)) {
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -344,7 +344,8 @@ bitfill_unaligned_rev(unsigned long __io
 
 void cfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 {
-	unsigned long x2, y2, vxres, vyres, height, width, pat, fg;
+	unsigned long pat, fg;
+	unsigned long width = rect->width, height = rect->height;
 	int bits = BITS_PER_LONG, bytes = bits >> 3;
 	u32 bpp = p->var.bits_per_pixel;
 	unsigned long __iomem *dst;
@@ -353,27 +354,6 @@ void cfb_fillrect(struct fb_info *p, con
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	/* We want rotation but lack hardware to do it for us. */
-	if (!p->fbops->fb_rotate && p->var.rotate) {
-	}
-
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-
-	if (!rect->width || !rect->height ||
-	    rect->dx > vxres || rect->dy > vyres)
-		return;
-
-	/* We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly. */
-
-	x2 = rect->dx + rect->width;
-	y2 = rect->dy + rect->height;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	width = x2 - rect->dx;
-	height = y2 - rect->dy;
-
 	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
 		fg = ((u32 *) (p->pseudo_palette))[rect->color];
diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -272,33 +272,13 @@ void cfb_imageblit(struct fb_info *p, co
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
 	u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
-	u32 width = image->width, height = image->height; 
+	u32 width = image->width;
 	u32 dx = image->dx, dy = image->dy;
-	int x2, y2, vxres, vyres;
 	u8 __iomem *dst1;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-	/* 
-	 * We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly like we are
-	 * doing here. 
-	 */
-	if (image->dx > vxres || image->dy > vyres)
-		return;
-
-	x2 = image->dx + image->width;
-	y2 = image->dy + image->height;
-	dx = image->dx > 0 ? image->dx : 0;
-	dy = image->dy > 0 ? image->dy : 0;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	width  = x2 - dx;
-	height = y2 - dy;
-
 	bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
 	start_index = bitstart & (32 - 1);
 	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;

-	x2 = rect->dx + rect->width;
-	y2 = rect->dy + rect->height;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	width = x2 - rect->dx;
-	height = y2 - rect->dy;
-
 	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
 		fg = ((u32 *) (p->pseudo_palette))[rect->color];
diff --git a/drivers/video/cfbimgblt.c b/drivers/video/cfbimgblt.c
--- a/drivers/video/cfbimgblt.c
+++ b/drivers/video/cfbimgblt.c
@@ -272,33 +272,13 @@ void cfb_imageblit(struct fb_info *p, co
 {
 	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
 	u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
-	u32 width = image->width, height = image->height; 
+	u32 width = image->width;
 	u32 dx = image->dx, dy = image->dy;
-	int x2, y2, vxres, vyres;
 	u8 __iomem *dst1;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-	/* 
-	 * We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly like we are
-	 * doing here. 
-	 */
-	if (image->dx > vxres || image->dy > vyres)
-		return;
-
-	x2 = image->dx + image->width;
-	y2 = image->dy + image->height;
-	dx = image->dx > 0 ? image->dx : 0;
-	dy = image->dy > 0 ? image->dy : 0;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	width  = x2 - dx;
-	height = y2 - dy;
-
 	bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
 	start_index = bitstart & (32 - 1);
 	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
