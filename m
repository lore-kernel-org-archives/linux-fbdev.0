From: Manuel Lauss <manuel.lauss@googlemail.com>
Date: Sat, 24 Mar 2012 10:38:02 +0000
Subject: [PATCH] fbdev: fix au1*fb builds
Message-Id: <1332585482-6607-1-git-send-email-manuel.lauss@googlemail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 1c16697bf9d5b206cb0d2b905a54de5e077296be
("drivers/video/au*fb.c: use devm_ functions) introduced 2 build failures
in the au1100fb and au1200fb drivers, fix them.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/video/au1100fb.c |    5 +++--
 drivers/video/au1200fb.c |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index befcbd8..ffbce45 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -499,7 +499,8 @@ static int __devinit au1100fb_drv_probe(struct platform_device *dev)
 	au1100fb_fix.mmio_start = regs_res->start;
 	au1100fb_fix.mmio_len = resource_size(regs_res);
 
-	if (!devm_request_mem_region(au1100fb_fix.mmio_start,
+	if (!devm_request_mem_region(&dev->dev,
+				     au1100fb_fix.mmio_start,
 				     au1100fb_fix.mmio_len,
 				     DRIVER_NAME)) {
 		print_err("fail to lock memory region at 0x%08lx",
@@ -516,7 +517,7 @@ static int __devinit au1100fb_drv_probe(struct platform_device *dev)
 	fbdev->fb_len = fbdev->panel->xres * fbdev->panel->yres *
 		  	(fbdev->panel->bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
 
-	fbdev->fb_mem = dmam_alloc_coherent(&dev->dev, &dev->dev,
+	fbdev->fb_mem = dmam_alloc_coherent(&dev->dev,
 					    PAGE_ALIGN(fbdev->fb_len),
 					    &fbdev->fb_phys, GFP_KERNEL);
 	if (!fbdev->fb_mem) {
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 3e9a773..7ca79f0 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -1724,7 +1724,7 @@ static int __devinit au1200fb_drv_probe(struct platform_device *dev)
 		/* Allocate the framebuffer to the maximum screen size */
 		fbdev->fb_len = (win->w[plane].xres * win->w[plane].yres * bpp) / 8;
 
-		fbdev->fb_mem = dmam_alloc_noncoherent(&dev->dev, &dev->dev,
+		fbdev->fb_mem = dmam_alloc_noncoherent(&dev->dev,
 				PAGE_ALIGN(fbdev->fb_len),
 				&fbdev->fb_phys, GFP_KERNEL);
 		if (!fbdev->fb_mem) {
-- 
1.7.8.5

