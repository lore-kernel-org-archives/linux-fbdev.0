From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 30/41] s3fb: Limit 8x16 rectangles when
	tileblitting is enabled
Date: Wed, 25 Apr 2007 15:09:24 +0800
Message-ID: <462EFEA4.6050809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcAw-0001TO-3h for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:44:30 -0700
Received: from wx-out-0506.google.com ([66.249.82.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcAv-0004Ih-Q7
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:44:30 -0700
Received: by wx-out-0506.google.com with SMTP id i30so296021wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:44:29 -0700 (PDT)
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
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

If tileblitting is enabled (text mode), the hardware can only accept 8x16
bitmaps. Advertise this to the upper layer. And to ensure that an appropriate
font is always available, select an 8x16 font in Kconfig.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |    1 +
 drivers/video/s3fb.c  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e440caf..4958493 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1191,6 +1191,7 @@ config FB_S3
 	select FB_TILEBLITTING
 	select FB_SVGALIB
 	select VGASTATE
+	select FONT_8x16 if FRAMEBUFFER_CONSOLE
 	---help---
 	  Driver for graphics boards with S3 Trio / S3 Virge chip.
 
diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index f3470bb..53f1eb9 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -449,6 +449,9 @@ static int s3fb_set_par(struct fb_info *
 		info->flags &= ~FBINFO_MISC_TILEBLITTING;
 		info->tileops = NULL;
 
+		/* supports blit rectangles of any dimension */
+		info->pixmap.blit_x = ~(u32)0;
+		info->pixmap.blit_y = ~(u32)0;
 		offset_value = (info->var.xres_virtual * bpp) / 64;
 		screen_size = info->var.yres_virtual * info->fix.line_length;
 	} else {
@@ -457,6 +460,9 @@ static int s3fb_set_par(struct fb_info *
 
 		info->flags |= FBINFO_MISC_TILEBLITTING;
 		info->tileops = fasttext ? &s3fb_fast_tile_ops : &s3fb_tile_ops;
+		/* supports 8x16 tiles only */
+		info->pixmap.blit_x = 1 << (8 - 1);
+		info->pixmap.blit_y = 1 << (16 - 1);
 
 		offset_value = info->var.xres_virtual / 16;
 		screen_size = (info->var.xres_virtual * info->var.yres_virtual) / 64;


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
