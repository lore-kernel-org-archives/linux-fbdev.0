From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Fri, 26 Apr 2013 20:02:18 +0000
Subject: [PATCH 4/9] s3c2410fb: Register single platform driver
Message-Id: <1367006543-5458-5-git-send-email-sylvester.nawrocki@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
In-Reply-To: <1367006543-5458-1-git-send-email-sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use the id_table instead of registering two separate platform drivers.
This allows then to declare the driver with module_platform_driver().

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 drivers/video/s3c2410fb.c |   59 +++++++++++---------------------------------
 1 files changed, 15 insertions(+), 44 deletions(-)

diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 12ac94e..d6706f7 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -818,8 +818,7 @@ static inline void s3c2410fb_cpufreq_deregister(struct s3c2410fb_info *info)
 
 static const char driver_name[] = "s3c2410fb";
 
-static int s3c24xxfb_probe(struct platform_device *pdev,
-			   enum s3c_drv_type drv_type)
+static int s3c2410fb_probe(struct platform_device *pdev)
 {
 	struct s3c2410fb_info *info;
 	struct s3c2410fb_display *display;
@@ -861,7 +860,7 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 
 	info = fbinfo->par;
 	info->dev = &pdev->dev;
-	info->drv_type = drv_type;
+	info->drv_type = platform_get_device_id(pdev)->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res = NULL) {
@@ -885,7 +884,7 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 		goto release_mem;
 	}
 
-	if (drv_type = DRV_S3C2412)
+	if (info->drv_type = DRV_S3C2412)
 		info->irq_base = info->io + S3C2412_LCDINTBASE;
 	else
 		info->irq_base = info->io + S3C2410_LCDINTBASE;
@@ -1009,17 +1008,6 @@ dealloc_fb:
 	return ret;
 }
 
-static int s3c2410fb_probe(struct platform_device *pdev)
-{
-	return s3c24xxfb_probe(pdev, DRV_S3C2410);
-}
-
-static int s3c2412fb_probe(struct platform_device *pdev)
-{
-	return s3c24xxfb_probe(pdev, DRV_S3C2412);
-}
-
-
 /*
  *  Cleanup
  */
@@ -1098,46 +1086,29 @@ static int s3c2410fb_resume(struct platform_device *dev)
 #define s3c2410fb_resume  NULL
 #endif
 
-static struct platform_driver s3c2410fb_driver = {
-	.probe		= s3c2410fb_probe,
-	.remove		= s3c2410fb_remove,
-	.suspend	= s3c2410fb_suspend,
-	.resume		= s3c2410fb_resume,
-	.driver		= {
-		.name	= "s3c2410-lcd",
-		.owner	= THIS_MODULE,
+static struct platform_device_id s3c2410fb_driver_ids[] = {
+	{
+		.name = "s3c2410-lcd",
+		.driver_data = (unsigned long)DRV_S3C2410,
+	}, {
+		.name = "s3c2412-lcd",
+		.driver_data = (unsigned long)DRV_S3C2412,
 	},
 };
 
-static struct platform_driver s3c2412fb_driver = {
-	.probe		= s3c2412fb_probe,
+static struct platform_driver s3c2410fb_driver = {
+	.probe		= s3c2410fb_probe,
 	.remove		= s3c2410fb_remove,
 	.suspend	= s3c2410fb_suspend,
 	.resume		= s3c2410fb_resume,
+	.id_table	= s3c2410fb_driver_ids,
 	.driver		= {
-		.name	= "s3c2412-lcd",
+		.name	= "s3c2410-lcd",
 		.owner	= THIS_MODULE,
 	},
 };
 
-int __init s3c2410fb_init(void)
-{
-	int ret = platform_driver_register(&s3c2410fb_driver);
-
-	if (ret = 0)
-		ret = platform_driver_register(&s3c2412fb_driver);
-
-	return ret;
-}
-
-static void __exit s3c2410fb_cleanup(void)
-{
-	platform_driver_unregister(&s3c2410fb_driver);
-	platform_driver_unregister(&s3c2412fb_driver);
-}
-
-module_init(s3c2410fb_init);
-module_exit(s3c2410fb_cleanup);
+module_platform_driver(s3c2410fb_driver);
 
 MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
 MODULE_AUTHOR("Ben Dooks <ben-linux@fluff.org>");
-- 
1.7.4.1

