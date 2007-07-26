From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 15/33] pm3fb: imageblit improved
Date: Thu, 26 Jul 2007 20:21:02 +0800
Message-ID: <46A891AE.7080602@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2u9-00010w-A9 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:21 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2u9-00084u-1u
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:21 -0700
Received: by wa-out-1112.google.com with SMTP id k22so614502waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:57:20 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes the pm3_imageblit() restriction to blit only images with
width divisable by 32.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 0e63f03..280d108 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -46,6 +46,8 @@ #else
 #define DPRINTK(a,b...)
 #endif
 
+#define PM3_PIXMAP_SIZE	(2048 * 4)
+
 /*
  * Driver data
  */
@@ -513,7 +515,7 @@ static void pm3fb_imageblit(struct fb_in
 			bgx = par->palette[image->bg_color];
 			break;
 	}
-	if (image->depth != 1 || (image->width & 0x1f)) {
+	if (image->depth != 1) {
 		return cfb_imageblit(info, image);
 	}
 	if (info->var.bits_per_pixel == 8) {
@@ -525,18 +527,24 @@ static void pm3fb_imageblit(struct fb_in
 		bgx |= bgx << 16;
 	}
 
-	PM3_WAIT(par, 5);
+	PM3_WAIT(par, 7);
 
 	PM3_WRITE_REG(par, PM3ForegroundColor, fgx);
 	PM3_WRITE_REG(par, PM3BackgroundColor, bgx);
 
 	/* ROP Ox3 is GXcopy */
 	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UserScissorEnable |
 			PM3Config2D_UseConstantSource |
 			PM3Config2D_ForegroundROPEnable |
 			(PM3Config2D_ForegroundROP(0x3)) |
 			PM3Config2D_OpaqueSpan |
 			PM3Config2D_FBWriteEnable);
+	PM3_WRITE_REG(par, PM3ScissorMinXY,
+			((image->dy & 0x0fff) << 16) | (image->dx & 0x0fff));
+	PM3_WRITE_REG(par, PM3ScissorMaxXY,
+			(((image->dy + image->height) & 0x0fff) << 16) |
+			((image->dx + image->width) & 0x0fff));
 	PM3_WRITE_REG(par, PM3RectanglePosition,
 			(PM3RectanglePosition_XOffset(image->dx)) |
 			(PM3RectanglePosition_YOffset(image->dy)));
@@ -550,7 +558,8 @@ static void pm3fb_imageblit(struct fb_in
 
 
 	while (height--) {
-		u32 width = (image->width + 31) >> 5;
+		int width = ((image->width + 7) >> 3) + info->pixmap.scan_align;
+		width >>= 2;
 
 		while (width >= PM3_FIFO_SIZE) {
 			int i = PM3_FIFO_SIZE - 1;
@@ -1239,6 +1248,17 @@ #endif
 			FBINFO_HWACCEL_IMAGEBLIT |
 			FBINFO_HWACCEL_FILLRECT;
 
+	info->pixmap.addr = kmalloc(PM3_PIXMAP_SIZE, GFP_KERNEL);
+	if (!info->pixmap.addr) {
+		retval = -ENOMEM;
+		goto err_exit_pixmap;
+	}
+	info->pixmap.size = PM3_PIXMAP_SIZE;
+	info->pixmap.buf_align = 4;
+	info->pixmap.scan_align = 4;
+	info->pixmap.access_align = 32;
+	info->pixmap.flags = FB_PIXMAP_SYSTEM;
+
 	/*
 	 * This should give a reasonable default video mode. The following is
 	 * done when we can set a video mode.
@@ -1275,6 +1295,8 @@ #endif
  err_exit_all:
 	fb_dealloc_cmap(&info->cmap);
  err_exit_both:
+	kfree(info->pixmap.addr);
+ err_exit_pixmap:
 	iounmap(info->screen_base);
 	release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
  err_exit_mmio:
@@ -1305,6 +1327,7 @@ static void __devexit pm3fb_remove(struc
 		release_mem_region(fix->mmio_start, fix->mmio_len);
 
 		pci_set_drvdata(dev, NULL);
+		kfree(info->pixmap.addr);
 		framebuffer_release(info);
 	}
 }


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
