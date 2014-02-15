From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 15 Feb 2014 05:56:24 +0000
Subject: [PATCH 3/5] video: imxfb: Use module_platform_driver()
Message-Id: <1392443786-30527-3-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We have no reason to call fb_get_options() when registering module,
so move this call in the probe() and convert the driver to use
module_platform_driver() macro.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/imxfb.c | 65 +++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 5b07053..3137a69 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -874,6 +874,26 @@ static struct lcd_ops imxfb_lcd_ops = {
 	.set_power	= imxfb_lcd_set_power,
 };
 
+static int imxfb_setup(void)
+{
+	char *opt, *options = NULL;
+
+	if (fb_get_options("imxfb", &options))
+		return -ENODEV;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((opt = strsep(&options, ",")) != NULL) {
+		if (!*opt)
+			continue;
+		else
+			fb_mode = opt;
+	}
+
+	return 0;
+}
+
 static int imxfb_probe(struct platform_device *pdev)
 {
 	struct imxfb_info *fbi;
@@ -888,6 +908,10 @@ static int imxfb_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "i.MX Framebuffer driver\n");
 
+	ret = imxfb_setup();
+	if (ret < 0)
+		return ret;
+
 	of_id = of_match_device(imxfb_of_dev_id, &pdev->dev);
 	if (of_id)
 		pdev->id_entry = of_id->data;
@@ -1113,6 +1137,7 @@ static void imxfb_shutdown(struct platform_device *dev)
 static struct platform_driver imxfb_driver = {
 	.suspend	= imxfb_suspend,
 	.resume		= imxfb_resume,
+	.probe		= imxfb_probe,
 	.remove		= imxfb_remove,
 	.shutdown	= imxfb_shutdown,
 	.driver		= {
@@ -1121,45 +1146,7 @@ static struct platform_driver imxfb_driver = {
 	},
 	.id_table	= imxfb_devtype,
 };
-
-static int imxfb_setup(void)
-{
-#ifndef MODULE
-	char *opt, *options = NULL;
-
-	if (fb_get_options("imxfb", &options))
-		return -ENODEV;
-
-	if (!options || !*options)
-		return 0;
-
-	while ((opt = strsep(&options, ",")) != NULL) {
-		if (!*opt)
-			continue;
-		else
-			fb_mode = opt;
-	}
-#endif
-	return 0;
-}
-
-static int __init imxfb_init(void)
-{
-	int ret = imxfb_setup();
-
-	if (ret < 0)
-		return ret;
-
-	return platform_driver_probe(&imxfb_driver, imxfb_probe);
-}
-
-static void __exit imxfb_cleanup(void)
-{
-	platform_driver_unregister(&imxfb_driver);
-}
-
-module_init(imxfb_init);
-module_exit(imxfb_cleanup);
+module_platform_driver(imxfb_driver);
 
 MODULE_DESCRIPTION("Freescale i.MX framebuffer driver");
 MODULE_AUTHOR("Sascha Hauer, Pengutronix");
-- 
1.8.3.2

