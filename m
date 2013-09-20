From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:23 +0000
Subject: [PATCH 14/15] video: tcx: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-15-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/tcx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index c000852..1f3a327 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -498,8 +498,6 @@ static int tcx_remove(struct platform_device *op)
 
 	framebuffer_release(info);
 
-	dev_set_drvdata(&op->dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

