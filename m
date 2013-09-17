From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 17 Sep 2013 05:08:58 +0000
Subject: [PATCH 13/19] video: imxfb: use dev_get_platdata()
Message-Id: <001301ceb364$040f82f0$0c2e88d0$%han@samsung.com>
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
 drivers/video/imxfb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 38733ac..44ee678 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -755,7 +755,7 @@ static int imxfb_resume(struct platform_device *dev)
 
 static int imxfb_init_fbinfo(struct platform_device *pdev)
 {
-	struct imx_fb_platform_data *pdata = pdev->dev.platform_data;
+	struct imx_fb_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct fb_info *info = dev_get_drvdata(&pdev->dev);
 	struct imxfb_info *fbi = info->par;
 	struct device_node *np;
@@ -877,7 +877,7 @@ static int imxfb_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 
 	info = framebuffer_alloc(sizeof(struct imxfb_info), &pdev->dev);
 	if (!info)
@@ -1066,7 +1066,7 @@ static int imxfb_remove(struct platform_device *pdev)
 #endif
 	unregister_framebuffer(info);
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
 
-- 
1.7.10.4


