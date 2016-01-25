From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Jan 2016 15:04:03 +0000
Subject: [PATCH] fbdev: s6e8ax0: avoid unused function warnings
Message-Id: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The s6e8ax0 suspend/resume functions are hidden inside of an #ifdef
when CONFIG_PM is set to avoid unused function warnings, but they
call some other functions that nothing else calls, and we get warnings
about those:

drivers/video/fbdev/exynos/s6e8ax0.c:449:13: error: 's6e8ax0_sleep_in' defined but not used [-Werror=unused-function]
drivers/video/fbdev/exynos/s6e8ax0.c:485:13: error: 's6e8ax0_display_off' defined but not used [-Werror=unused-function]

This marks the PM functions as __maybe_unused so the compiler can
silently drop them when they are not referenced.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/exynos/s6e8ax0.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/exynos/s6e8ax0.c b/drivers/video/fbdev/exynos/s6e8ax0.c
index 95873f26e39c..de2f3e793786 100644
--- a/drivers/video/fbdev/exynos/s6e8ax0.c
+++ b/drivers/video/fbdev/exynos/s6e8ax0.c
@@ -829,8 +829,7 @@ static int s6e8ax0_probe(struct mipi_dsim_lcd_device *dsim_dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int s6e8ax0_suspend(struct mipi_dsim_lcd_device *dsim_dev)
+static int __maybe_unused s6e8ax0_suspend(struct mipi_dsim_lcd_device *dsim_dev)
 {
 	struct s6e8ax0 *lcd = dev_get_drvdata(&dsim_dev->dev);
 
@@ -843,7 +842,7 @@ static int s6e8ax0_suspend(struct mipi_dsim_lcd_device *dsim_dev)
 	return 0;
 }
 
-static int s6e8ax0_resume(struct mipi_dsim_lcd_device *dsim_dev)
+static int __maybe_unused s6e8ax0_resume(struct mipi_dsim_lcd_device *dsim_dev)
 {
 	struct s6e8ax0 *lcd = dev_get_drvdata(&dsim_dev->dev);
 
@@ -855,10 +854,6 @@ static int s6e8ax0_resume(struct mipi_dsim_lcd_device *dsim_dev)
 
 	return 0;
 }
-#else
-#define s6e8ax0_suspend		NULL
-#define s6e8ax0_resume		NULL
-#endif
 
 static struct mipi_dsim_lcd_driver s6e8ax0_dsim_ddi_driver = {
 	.name = "s6e8ax0",
@@ -867,8 +862,8 @@ static struct mipi_dsim_lcd_driver s6e8ax0_dsim_ddi_driver = {
 	.power_on = s6e8ax0_power_on,
 	.set_sequence = s6e8ax0_set_sequence,
 	.probe = s6e8ax0_probe,
-	.suspend = s6e8ax0_suspend,
-	.resume = s6e8ax0_resume,
+	.suspend = IS_ENABLED(CONFIG_PM) ? s6e8ax0_suspend : NULL,
+	.resume = IS_ENABLED(CONFIG_PM) ? s6e8ax0_resume : NULL,
 };
 
 static int s6e8ax0_init(void)
-- 
2.7.0

