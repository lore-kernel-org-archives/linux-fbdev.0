From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:11:55 +0000
Subject: [PATCH 19/19] video: w100fb: use dev_get_platdata()
Message-Id: <001901ceb364$6da31970$48e94c50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/w100fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 7a299e95..2a0437a 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -680,7 +680,7 @@ int w100fb_probe(struct platform_device *pdev)
 	par = info->par;
 	platform_set_drvdata(pdev, info);
 
-	inf = pdev->dev.platform_data;
+	inf = dev_get_platdata(&pdev->dev);
 	par->chip_id = chip_id;
 	par->mach = inf;
 	par->fastpll_mode = 0;
-- 
1.7.10.4


