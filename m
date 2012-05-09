From: Donghwa Lee <dh09.lee@samsung.com>
Date: Wed, 09 May 2012 05:33:28 +0000
Subject: [PATCH 3/5] video: exynos mipi dsi: Avoid races in probe()
Message-Id: <4FAA01A8.4010704@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

Make sure all resources are initialized before interrupt handler is
registered. Pass full platform device name to request_irq() so it
can be distinguished which device has requested an interrupt in cases
there are multiple instances in the system.

Also enable voltage regulators regardless of they have been enabled
by bootloader or not, to make sure other drivers using same regulators
don't disable them unexpectedly.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index e004f1d..3fcdbf9 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -415,27 +415,30 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 		goto err_platform_get_irq;
 	}
 
+	init_completion(&dsim_wr_comp);
+	init_completion(&dsim_rd_comp);
+	platform_set_drvdata(pdev, dsim);
+
 	ret = request_irq(dsim->irq, exynos_mipi_dsi_interrupt_handler,
-			IRQF_SHARED, pdev->name, dsim);
+			IRQF_SHARED, dev_name(&pdev->dev), dsim);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to request dsim irq\n");
 		ret = -EINVAL;
 		goto err_bind;
 	}
 
-	init_completion(&dsim_wr_comp);
-	init_completion(&dsim_rd_comp);
-
-	/* enable interrupt */
+	/* enable interrupts */
 	exynos_mipi_dsi_init_interrupt(dsim);
 
 	/* initialize mipi-dsi client(lcd panel). */
 	if (dsim_ddi->dsim_lcd_drv && dsim_ddi->dsim_lcd_drv->probe)
 		dsim_ddi->dsim_lcd_drv->probe(dsim_ddi->dsim_lcd_dev);
 
-	/* in case that mipi got enabled at bootloader. */
-	if (dsim_pd->enabled)
-		goto out;
+	/* in case mipi-dsi has been enabled by bootloader */
+	if (dsim_pd->enabled) {
+		exynos_mipi_regulator_enable(dsim);
+		goto done;
+	}
 
 	/* lcd panel power on. */
 	if (dsim_ddi->dsim_lcd_drv && dsim_ddi->dsim_lcd_drv->power_on)
@@ -455,12 +458,11 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 
 	dsim->suspended = false;
 
-out:
+done:
 	platform_set_drvdata(pdev, dsim);
 
-	dev_dbg(&pdev->dev, "mipi-dsi driver(%s mode) has been probed.\n",
-		(dsim_config->e_interface = DSIM_COMMAND) ?
-			"CPU" : "RGB");
+	dev_dbg(&pdev->dev, "%s() completed sucessfuly (%s mode)\n", __func__,
+		dsim_config->e_interface = DSIM_COMMAND ? "CPU" : "RGB");
 
 	return 0;
 
-- 
1.7.4.1
