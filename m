From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/20] s3fb: updates
Date: Sat, 05 May 2007 22:46:02 +0800
Message-ID: <463C98AA.30002@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDJ-0008VK-Vl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:26 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDJ-0008EN-HZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:25 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:30:25 -0700 (PDT)
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

From: Ondrej Zajicek <santiago@crfreenet.org>

Move s3fb_get_tilemax to svgalib.c as svga_get_tilemax,
because it reports limitation of other code from svgalib
(svga_settile, svga_tilecopy, ...)

Limit font width to 8 pixels in 4 bpp mode.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3fb.c    |   15 ++++++---------
 drivers/video/svgalib.c |    6 ++++++
 include/linux/svga.h    |    1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 4d0e204..756fafb 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -183,18 +183,13 @@ static void s3fb_settile_fast(struct fb_
 	}
 }
 
-static int s3fb_get_tilemax(struct fb_info *info)
-{
-	return 256;
-}
-
 static struct fb_tile_ops s3fb_tile_ops = {
 	.fb_settile	= svga_settile,
 	.fb_tilecopy	= svga_tilecopy,
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
 	.fb_tilecursor  = svga_tilecursor,
-	.fb_get_tilemax = s3fb_get_tilemax,
+	.fb_get_tilemax = svga_get_tilemax,
 };
 
 static struct fb_tile_ops s3fb_fast_tile_ops = {
@@ -203,7 +198,7 @@ static struct fb_tile_ops s3fb_fast_tile
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
 	.fb_tilecursor  = svga_tilecursor,
-	.fb_get_tilemax = s3fb_get_tilemax,
+	.fb_get_tilemax = svga_get_tilemax,
 };
 
 
@@ -459,9 +454,10 @@ static int s3fb_set_par(struct fb_info *
 		info->flags &= ~FBINFO_MISC_TILEBLITTING;
 		info->tileops = NULL;
 
-		/* supports blit rectangles of any dimension */
-		info->pixmap.blit_x = ~(u32)0;
+		/* in 4bpp supports 8p wide tiles only, any tiles otherwise */
+		info->pixmap.blit_x = (bpp == 4) ? (1 << (8 - 1)) : (~(u32)0);
 		info->pixmap.blit_y = ~(u32)0;
+
 		offset_value = (info->var.xres_virtual * bpp) / 64;
 		screen_size = info->var.yres_virtual * info->fix.line_length;
 	} else {
@@ -470,6 +466,7 @@ static int s3fb_set_par(struct fb_info *
 
 		info->flags |= FBINFO_MISC_TILEBLITTING;
 		info->tileops = fasttext ? &s3fb_fast_tile_ops : &s3fb_tile_ops;
+
 		/* supports 8x16 tiles only */
 		info->pixmap.blit_x = 1 << (8 - 1);
 		info->pixmap.blit_y = 1 << (16 - 1);
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 7fddc4a..079cdc9 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -342,6 +342,11 @@ void svga_tilecursor(struct fb_info *inf
 	vga_wcrt(NULL, 0x0A, cs); /* set cursor start and enable it */
 }
 
+int svga_get_tilemax(struct fb_info *info)
+{
+	return 256;
+}
+
 
 /* ------------------------------------------------------------------------- */
 
@@ -623,6 +628,7 @@ EXPORT_SYMBOL(svga_tilecopy);
 EXPORT_SYMBOL(svga_tilefill);
 EXPORT_SYMBOL(svga_tileblit);
 EXPORT_SYMBOL(svga_tilecursor);
+EXPORT_SYMBOL(svga_get_tilemax);
 
 EXPORT_SYMBOL(svga_compute_pll);
 EXPORT_SYMBOL(svga_check_timings);
diff --git a/include/linux/svga.h b/include/linux/svga.h
index eadb981..e1cc552 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -112,6 +112,7 @@ void svga_tilecopy(struct fb_info *info,
 void svga_tilefill(struct fb_info *info, struct fb_tilerect *rect);
 void svga_tileblit(struct fb_info *info, struct fb_tileblit *blit);
 void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor);
+int svga_get_tilemax(struct fb_info *info);
 
 int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u16 *r, int node);
 int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, int node);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
