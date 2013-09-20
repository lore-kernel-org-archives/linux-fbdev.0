From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:10 +0000
Subject: [PATCH 01/15] video: atmel_lcdfb: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/video/atmel_lcdfb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 34e934d..70052e7 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -1318,7 +1318,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	return 0;
 
 reset_drvdata:
-	dev_set_drvdata(dev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 unregister_irqs:
 	cancel_work_sync(&sinfo->task);
@@ -1379,7 +1378,6 @@ static int __exit atmel_lcdfb_remove(struct platform_device *pdev)
 		atmel_lcdfb_free_video_memory(sinfo);
 	}
 
-	dev_set_drvdata(dev, NULL);
 	framebuffer_release(info);
 
 	return 0;
-- 
1.7.9.5

