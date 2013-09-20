From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:11 +0000
Subject: [PATCH 02/15] video: grvga: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kristoffer Glembo <kristoffer@gaisler.com>
---
 drivers/video/grvga.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/grvga.c b/drivers/video/grvga.c
index b95eee7..c078701 100644
--- a/drivers/video/grvga.c
+++ b/drivers/video/grvga.c
@@ -496,7 +496,6 @@ static int grvga_probe(struct platform_device *dev)
 	return 0;
 
 free_mem:
-	dev_set_drvdata(&dev->dev, NULL);
 	if (grvga_fix_addr)
 		iounmap((void *)virtual_start);
 	else
@@ -530,7 +529,6 @@ static int grvga_remove(struct platform_device *device)
 			kfree((void *)info->screen_base);
 
 		framebuffer_release(info);
-		dev_set_drvdata(&device->dev, NULL);
 	}
 
 	return 0;
-- 
1.7.9.5

