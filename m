From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Nov 2015 21:47:41 +0000
Subject: [PATCH] fbdev: auo_k190x: avoid unused function warnings
Message-Id: <3917686.rD8ezhD468@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The auo_k190x framebuffer driver encloses the power-management
functions in #ifdef CONFIG_PM, but the auok190x_suspend/resume
functions are only really used when CONFIG_PM_SLEEP is also
set, as a frequent gcc warning shows:

drivers/video/fbdev/auo_k190x.c:859:12: warning: 'auok190x_suspend' defined but not used
drivers/video/fbdev/auo_k190x.c:899:12: warning: 'auok190x_resume' defined but not used

This changes the driver to remove the #ifdef and instead mark
the functions as __maybe_unused, which is a nicer anyway, as it
provides build testing for all the code in all configurations
and is harder to get wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/video/fbdev/auo_k190x.c b/drivers/video/fbdev/auo_k190x.c
index 8d2499d1cafb..9580374667ba 100644
--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -773,9 +773,7 @@ static void auok190x_recover(struct auok190xfb_par *par)
 /*
  * Power-management
  */
-
-#ifdef CONFIG_PM
-static int auok190x_runtime_suspend(struct device *dev)
+static int __maybe_unused auok190x_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -822,7 +820,7 @@ finish:
 	return 0;
 }
 
-static int auok190x_runtime_resume(struct device *dev)
+static int __maybe_unused auok190x_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -856,7 +854,7 @@ static int auok190x_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int auok190x_suspend(struct device *dev)
+static int __maybe_unused auok190x_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -896,7 +894,7 @@ static int auok190x_suspend(struct device *dev)
 	return 0;
 }
 
-static int auok190x_resume(struct device *dev)
+static int __maybe_unused auok190x_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct fb_info *info = platform_get_drvdata(pdev);
@@ -933,7 +931,6 @@ static int auok190x_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 const struct dev_pm_ops auok190x_pm = {
 	SET_RUNTIME_PM_OPS(auok190x_runtime_suspend, auok190x_runtime_resume,

