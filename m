From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/20] svgalib: Move fb_get_caps to
	svgalib
Date: Sat, 05 May 2007 22:54:17 +0800
Message-ID: <463C9A99.6060706@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDc-000051-Vc for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:45 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDc-0008EN-Fe
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:44 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:30:44 -0700 (PDT)
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

Move fb_get_caps() method to svgalib.c as svga_get_caps() so it can be used by
s3fb, arkfb and vt8623fb.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/arkfb.c    |    1 +
 drivers/video/s3fb.c     |   19 +------------------
 drivers/video/svgalib.c  |   17 +++++++++++++++++
 drivers/video/vt8623fb.c |    1 +
 include/linux/svga.h     |    2 ++
 5 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index bb3f5e7..3a0ae2b 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -918,6 +918,7 @@ static struct fb_ops arkfb_ops = {
 	.fb_fillrect	= arkfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= arkfb_imageblit,
+	.fb_get_caps    = svga_get_caps,
 };
 
 
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index 756fafb..d117358 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -796,23 +796,6 @@ static int s3fb_pan_display(struct fb_va
 	return 0;
 }
 
-/* Get capabilities of accelerator based on the mode */
-
-static void s3fb_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
-			  struct fb_var_screeninfo *var)
-{
-	if (var->bits_per_pixel == 0) {
-		/* can only support 256 8x16 bitmap */
-		caps->x = 1 << (8 - 1);
-		caps->y = 1 << (16 - 1);
-		caps->len = 256;
-	} else {
-		caps->x = ~(u32)0;
-		caps->y = ~(u32)0;
-		caps->len = ~(u32)0;
-	}
-}
-
 /* ------------------------------------------------------------------------- */
 
 /* Frame buffer operations */
@@ -829,7 +812,7 @@ static struct fb_ops s3fb_ops = {
 	.fb_fillrect	= s3fb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= s3fb_imageblit,
-	.fb_get_caps    = s3fb_get_caps,
+	.fb_get_caps    = svga_get_caps,
 };
 
 /* ------------------------------------------------------------------------- */
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 079cdc9..25df928 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -347,6 +347,23 @@ int svga_get_tilemax(struct fb_info *inf
 	return 256;
 }
 
+/* Get capabilities of accelerator based on the mode */
+
+void svga_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
+		   struct fb_var_screeninfo *var)
+{
+	if (var->bits_per_pixel == 0) {
+		/* can only support 256 8x16 bitmap */
+		caps->x = 1 << (8 - 1);
+		caps->y = 1 << (16 - 1);
+		caps->len = 256;
+	} else {
+		caps->x = (var->bits_per_pixel == 4) ? 1 << (8 - 1) : ~(u32)0;
+		caps->y = ~(u32)0;
+		caps->len = ~(u32)0;
+	}
+}
+EXPORT_SYMBOL(svga_get_caps);
 
 /* ------------------------------------------------------------------------- */
 
diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index fc73f4b..4979af2 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -635,6 +635,7 @@ static struct fb_ops vt8623fb_ops = {
 	.fb_fillrect	= vt8623fb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= vt8623fb_imageblit,
+	.fb_get_caps    = svga_get_caps,
 };
 
 
diff --git a/include/linux/svga.h b/include/linux/svga.h
index e1cc552..13ad0b8 100644
--- a/include/linux/svga.h
+++ b/include/linux/svga.h
@@ -113,6 +113,8 @@ void svga_tilefill(struct fb_info *info,
 void svga_tileblit(struct fb_info *info, struct fb_tileblit *blit);
 void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor);
 int svga_get_tilemax(struct fb_info *info);
+void svga_get_caps(struct fb_info *info, struct fb_blit_caps *caps,
+		   struct fb_var_screeninfo *var);
 
 int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u16 *r, int node);
 int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, int node);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
