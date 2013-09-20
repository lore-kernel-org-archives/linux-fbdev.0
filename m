From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:13 +0000
Subject: [PATCH 04/15] video: mb862xx: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-5-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xxfbdrv.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index 98d2f8c..0cd4c33 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -781,7 +781,6 @@ rel_reg:
 irqdisp:
 	irq_dispose_mapping(par->irq);
 fbrel:
-	dev_set_drvdata(dev, NULL);
 	framebuffer_release(info);
 	return ret;
 }
@@ -814,7 +813,6 @@ static int of_platform_mb862xx_remove(struct platform_device *ofdev)
 	iounmap(par->mmio_base);
 	iounmap(par->fb_base);
 
-	dev_set_drvdata(&ofdev->dev, NULL);
 	release_mem_region(par->res->start, res_size);
 	framebuffer_release(fbi);
 	return 0;
-- 
1.7.9.5

