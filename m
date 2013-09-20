From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:14 +0000
Subject: [PATCH 05/15] video: amifb: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-6-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/amifb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index a6780ee..8ab304d 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -3748,7 +3748,6 @@ default_chipset:
 	return 0;
 
 unset_drvdata:
-	dev_set_drvdata(&pdev->dev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 free_irq:
 	free_irq(IRQ_AMIGA_COPPER, info->par);
@@ -3768,7 +3767,6 @@ static int __exit amifb_remove(struct platform_device *pdev)
 	struct fb_info *info = dev_get_drvdata(&pdev->dev);
 
 	unregister_framebuffer(info);
-	dev_set_drvdata(&pdev->dev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 	free_irq(IRQ_AMIGA_COPPER, info->par);
 	custom.dmacon = DMAF_ALL | DMAF_MASTER;
-- 
1.7.9.5

