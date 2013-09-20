From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:18 +0000
Subject: [PATCH 09/15] video: cg6: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-10-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/cg6.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
index 3545dec..f070ec3 100644
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -839,8 +839,6 @@ static int cg6_remove(struct platform_device *op)
 
 	framebuffer_release(info);
 
-	dev_set_drvdata(&op->dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

