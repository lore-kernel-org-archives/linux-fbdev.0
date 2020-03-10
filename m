From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 10 Mar 2020 14:30:50 +0000
Subject: [PATCH v3] video: fbdev: arcfb: add missed free_irq and fix the order of request_irq
Message-Id: <20200310143050.5154-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-fbdev@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The driver forgets to free irq in remove which is requested in
probe.
Add the missed call to fix it.
Also, the position of request_irq() in probe should be put before
register_framebuffer().

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Add missed variable par in remove.

 drivers/video/fbdev/arcfb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
index 314ab82e01c0..9a720c14056c 100644
--- a/drivers/video/fbdev/arcfb.c
+++ b/drivers/video/fbdev/arcfb.c
@@ -544,10 +544,6 @@ static int arcfb_probe(struct platform_device *dev)
 	par->cslut[1] = 0x06;
 	info->flags = FBINFO_FLAG_DEFAULT;
 	spin_lock_init(&par->lock);
-	retval = register_framebuffer(info);
-	if (retval < 0)
-		goto err1;
-	platform_set_drvdata(dev, info);
 	if (irq) {
 		par->irq = irq;
 		if (request_irq(par->irq, &arcfb_interrupt, IRQF_SHARED,
@@ -558,6 +554,10 @@ static int arcfb_probe(struct platform_device *dev)
 			goto err1;
 		}
 	}
+	retval = register_framebuffer(info);
+	if (retval < 0)
+		goto err1;
+	platform_set_drvdata(dev, info);
 	fb_info(info, "Arc frame buffer device, using %dK of video memory\n",
 		videomemorysize >> 10);
 
@@ -590,9 +590,12 @@ static int arcfb_probe(struct platform_device *dev)
 static int arcfb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = platform_get_drvdata(dev);
+	struct arcfb_par *par = info->par;
 
 	if (info) {
 		unregister_framebuffer(info);
+		if (irq)
+			free_irq(par->irq, info);
 		vfree((void __force *)info->screen_base);
 		framebuffer_release(info);
 	}
-- 
2.25.1
