From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 15 Feb 2014 05:56:26 +0000
Subject: [PATCH 5/5] video: imxfb: Convert to SIMPLE_DEV_PM_OPS
Message-Id: <1392443786-30527-5-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of assigning the pm_ops fields individually we can simply
use SIMPLE_DEV_PM_OPS.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/imxfb.c | 59 ++++++++++++++++++---------------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 398a8ca..086e024 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -622,37 +622,6 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 	return 0;
 }
 
-#ifdef CONFIG_PM
-/*
- * Power management hooks.  Note that we won't be called from IRQ context,
- * unlike the blank functions above, so we may sleep.
- */
-static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct fb_info *info = platform_get_drvdata(dev);
-	struct imxfb_info *fbi = info->par;
-
-	pr_debug("%s\n", __func__);
-
-	imxfb_disable_controller(fbi);
-	return 0;
-}
-
-static int imxfb_resume(struct platform_device *dev)
-{
-	struct fb_info *info = platform_get_drvdata(dev);
-	struct imxfb_info *fbi = info->par;
-
-	pr_debug("%s\n", __func__);
-
-	imxfb_enable_controller(fbi);
-	return 0;
-}
-#else
-#define imxfb_suspend	NULL
-#define imxfb_resume	NULL
-#endif
-
 static int imxfb_init_fbinfo(struct platform_device *pdev)
 {
 	struct imx_fb_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -1063,23 +1032,37 @@ static int imxfb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void imxfb_shutdown(struct platform_device *dev)
+static int __maybe_unused imxfb_suspend(struct device *dev)
 {
-	struct fb_info *info = platform_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct imxfb_info *fbi = info->par;
+
 	imxfb_disable_controller(fbi);
+
+	return 0;
 }
 
+static int __maybe_unused imxfb_resume(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct imxfb_info *fbi = info->par;
+
+	imxfb_enable_controller(fbi);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imxfb_pm_ops, imxfb_suspend, imxfb_resume);
+
 static struct platform_driver imxfb_driver = {
-	.suspend	= imxfb_suspend,
-	.resume		= imxfb_resume,
-	.probe		= imxfb_probe,
-	.remove		= imxfb_remove,
-	.shutdown	= imxfb_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = imxfb_of_dev_id,
+		.owner	= THIS_MODULE,
+		.pm	= &imxfb_pm_ops,
 	},
+	.probe		= imxfb_probe,
+	.remove		= imxfb_remove,
 	.id_table	= imxfb_devtype,
 };
 module_platform_driver(imxfb_driver);
-- 
1.8.3.2

