From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 20 Sep 2013 06:44:24 +0000
Subject: [PATCH 15/15] video: xilinxfb: Remove redundant dev_set_drvdata
Message-Id: <1379658744-17113-16-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/xilinxfb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index 84c664e..0e1dd33 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -369,7 +369,6 @@ err_fbmem:
 
 err_region:
 	kfree(drvdata);
-	dev_set_drvdata(dev, NULL);
 
 	return rc;
 }
@@ -404,7 +403,6 @@ static int xilinxfb_release(struct device *dev)
 #endif
 
 	kfree(drvdata);
-	dev_set_drvdata(dev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

