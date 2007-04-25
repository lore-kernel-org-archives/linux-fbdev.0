From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/41] fbdev: Add sparse annotations in
	svgalib.c
Date: Wed, 25 Apr 2007 14:29:27 +0800
Message-ID: <462EF547.8040200@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc5t-0000vf-7a for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:19 -0700
Received: from nz-out-0506.google.com ([64.233.162.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc5s-0005ke-Ds
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:16 -0700
Received: by nz-out-0506.google.com with SMTP id s18so211331nze
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:39:15 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add sparse annotations and use fb_read/fb_write family to access the
framebuffer.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/svgalib.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 68b30d9..7fddc4a 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -194,7 +194,7 @@ #endif  /*  0  */
 void svga_settile(struct fb_info *info, struct fb_tilemap *map)
 {
 	const u8 *font = map->data;
-	u8* fb = (u8 *) info->screen_base;
+	u8 __iomem *fb = (u8 __iomem *)info->screen_base;
 	int i, c;
 
 	if ((map->width != 8) || (map->height != 16) ||
@@ -207,7 +207,8 @@ void svga_settile(struct fb_info *info, 
 	fb += 2;
 	for (c = 0; c < map->length; c++) {
 		for (i = 0; i < map->height; i++) {
-			fb[i * 4] = font[i];
+			fb_writeb(font[i], fb + i * 4);
+//			fb[i * 4] = font[i];
 		}
 		fb += 128;
 		font += map->height;
@@ -221,8 +222,8 @@ void svga_tilecopy(struct fb_info *info,
 	/*  colstride is halved in this function because u16 are used */
 	int colstride = 1 << (info->fix.type_aux & FB_AUX_TEXT_SVGA_MASK);
 	int rowstride = colstride * (info->var.xres_virtual / 8);
-	u16 *fb = (u16 *) info->screen_base;
-	u16 *src, *dst;
+	u16 __iomem *fb = (u16 __iomem *) info->screen_base;
+	u16 __iomem *src, *dst;
 
 	if ((area->sy > area->dy) ||
 	    ((area->sy == area->dy) && (area->sx > area->dx))) {
@@ -239,10 +240,11 @@ void svga_tilecopy(struct fb_info *info,
 	    }
 
 	for (dy = 0; dy < area->height; dy++) {
-		u16* src2 = src;
-		u16* dst2 = dst;
+		u16 __iomem *src2 = src;
+		u16 __iomem *dst2 = dst;
 		for (dx = 0; dx < area->width; dx++) {
-			*dst2 = *src2;
+			fb_writew(fb_readw(src2), dst2);
+//			*dst2 = *src2;
 			src2 += colstride;
 			dst2 += colstride;
 		}
@@ -258,14 +260,14 @@ void svga_tilefill(struct fb_info *info,
 	int colstride = 2 << (info->fix.type_aux & FB_AUX_TEXT_SVGA_MASK);
 	int rowstride = colstride * (info->var.xres_virtual / 8);
 	int attr = (0x0F & rect->bg) << 4 | (0x0F & rect->fg);
-	u8  *fb = (u8 *) info->screen_base;
+	u8 __iomem *fb = (u8 __iomem *)info->screen_base;
 	fb += rect->sx * colstride + rect->sy * rowstride;
 
 	for (dy = 0; dy < rect->height; dy++) {
-		u8* fb2 = fb;
+		u8 __iomem *fb2 = fb;
 		for (dx = 0; dx < rect->width; dx++) {
-			fb2[0] = rect->index;
-			fb2[1] = attr;
+			fb_writeb(rect->index, fb2);
+			fb_writeb(attr, fb2 + 1);
 			fb2 += colstride;
 		}
 		fb += rowstride;
@@ -279,15 +281,15 @@ void svga_tileblit(struct fb_info *info,
 	int colstride = 2 << (info->fix.type_aux & FB_AUX_TEXT_SVGA_MASK);
 	int rowstride = colstride * (info->var.xres_virtual / 8);
 	int attr = (0x0F & blit->bg) << 4 | (0x0F & blit->fg);
-	u8* fb = (u8 *) info->screen_base;
+	u8 __iomem *fb = (u8 __iomem *)info->screen_base;
 	fb += blit->sx * colstride + blit->sy * rowstride;
 
 	i=0;
 	for (dy=0; dy < blit->height; dy ++) {
-		u8* fb2 = fb;
+		u8 __iomem *fb2 = fb;
 		for (dx = 0; dx < blit->width; dx ++) {
-			fb2[0] = blit->indices[i];
-			fb2[1] = attr;
+			fb_writeb(blit->indices[i], fb2);
+			fb_writeb(attr, fb2 + 1);
 			fb2 += colstride;
 			i ++;
 			if (i == blit->length) return;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
