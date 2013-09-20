From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:19 +0000
Subject: [PATCH 10/15] video: ffb: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-11-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/ffb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
index 6d27447..4c4ffa6 100644
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -1035,8 +1035,6 @@ static int ffb_remove(struct platform_device *op)
 
 	framebuffer_release(info);
 
-	dev_set_drvdata(&op->dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

