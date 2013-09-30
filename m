From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Mon, 30 Sep 2013 08:50:35 +0000
Subject: [PATCH 1/1] video: wmt_ge_rops: Fix a trivial typo
Message-Id: <1380531020-13155-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add a missing closing brace for email address.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Alexey Charkov <alchark@gmail.com>
---
 drivers/video/wmt_ge_rops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/wmt_ge_rops.c b/drivers/video/wmt_ge_rops.c
index d4ef841..b0a9f34 100644
--- a/drivers/video/wmt_ge_rops.c
+++ b/drivers/video/wmt_ge_rops.c
@@ -175,7 +175,7 @@ static struct platform_driver wmt_ge_rops_driver = {
 
 module_platform_driver(wmt_ge_rops_driver);
 
-MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com");
+MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("Accelerators for raster operations using "
 		   "WonderMedia Graphics Engine");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

