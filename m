From: Donghwa Lee <dh09.lee@samsung.com>
Date: Wed, 09 May 2012 05:33:26 +0000
Subject: [PATCH 2/5] video: exynos mipi dsi: Do not use deprecated suspend/resume callbacks
Message-Id: <4FAA01A6.1020707@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

Use proper PM ops from struct dev_pm_ops rather than the deprecated ones.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 49c7351..e004f1d 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -517,10 +517,10 @@ static int __devexit exynos_mipi_dsi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int exynos_mipi_dsi_suspend(struct platform_device *pdev,
-		pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int exynos_mipi_dsi_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct mipi_dsim_device *dsim = platform_get_drvdata(pdev);
 	struct mipi_dsim_lcd_driver *client_drv = dsim->dsim_lcd_drv;
 	struct mipi_dsim_lcd_device *client_dev = dsim->dsim_lcd_dev;
@@ -546,8 +546,9 @@ static int exynos_mipi_dsi_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int exynos_mipi_dsi_resume(struct platform_device *pdev)
+static int exynos_mipi_dsi_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct mipi_dsim_device *dsim = platform_get_drvdata(pdev);
 	struct mipi_dsim_lcd_driver *client_drv = dsim->dsim_lcd_drv;
 	struct mipi_dsim_lcd_device *client_dev = dsim->dsim_lcd_dev;
@@ -579,19 +580,19 @@ static int exynos_mipi_dsi_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define exynos_mipi_dsi_suspend NULL
-#define exynos_mipi_dsi_resume NULL
 #endif
 
+static const struct dev_pm_ops exynos_mipi_dsi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(exynos_mipi_dsi_suspend, exynos_mipi_dsi_resume)
+};
+
 static struct platform_driver exynos_mipi_dsi_driver = {
 	.probe = exynos_mipi_dsi_probe,
 	.remove = __devexit_p(exynos_mipi_dsi_remove),
-	.suspend = exynos_mipi_dsi_suspend,
-	.resume = exynos_mipi_dsi_resume,
 	.driver = {
 		   .name = "exynos-mipi-dsim",
 		   .owner = THIS_MODULE,
+		   .pm = &exynos_mipi_dsi_pm_ops,
 	},
 };
 
-- 
1.7.4.1
