From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Date: Sat, 10 Nov 2012 11:46:44 +0000
Subject: [PATCH 1/2] exynos-mipi-dsi: using devm_ functions for automatic cleanup
Message-Id: <1352547285-12302-2-git-send-email-shaik.ameer@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Using devm_ functions will take care of cleaning the allocated
resources when the device is removed.

Change-Id: Ia904a65ebdfe15a69c7c16501b3d94dd41f69bf4
Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |   76 ++++++++-----------------------
 1 files changed, 20 insertions(+), 56 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 1f5de89..ae20bc3 100755
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -338,7 +338,8 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	struct mipi_dsim_ddi *dsim_ddi;
 	int ret = -EINVAL;
 
-	dsim = kzalloc(sizeof(struct mipi_dsim_device), GFP_KERNEL);
+	dsim = devm_kzalloc(&pdev->dev,
+			sizeof(struct mipi_dsim_device), GFP_KERNEL);
 	if (!dsim) {
 		dev_err(&pdev->dev, "failed to allocate dsim object.\n");
 		return -ENOMEM;
@@ -352,13 +353,13 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	dsim_pd = (struct mipi_dsim_platform_data *)dsim->pd;
 	if (dsim_pd = NULL) {
 		dev_err(&pdev->dev, "failed to get platform data for dsim.\n");
-		goto err_clock_get;
+		return -EFAULT;
 	}
 	/* get mipi_dsim_config. */
 	dsim_config = dsim_pd->dsim_config;
 	if (dsim_config = NULL) {
 		dev_err(&pdev->dev, "failed to get dsim config data.\n");
-		goto err_clock_get;
+		return -EFAULT;
 	}
 
 	dsim->dsim_config = dsim_config;
@@ -366,41 +367,28 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 
 	mutex_init(&dsim->lock);
 
-	ret = regulator_bulk_get(&pdev->dev, ARRAY_SIZE(supplies), supplies);
+	ret = devm_regulator_bulk_get(&pdev->dev,
+				ARRAY_SIZE(supplies), supplies);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get regulators: %d\n", ret);
-		goto err_clock_get;
+		return ret;
 	}
 
-	dsim->clock = clk_get(&pdev->dev, "dsim0");
+	dsim->clock = devm_clk_get(&pdev->dev, "dsim0");
 	if (IS_ERR(dsim->clock)) {
 		dev_err(&pdev->dev, "failed to get dsim clock source\n");
-		ret = -ENODEV;
-		goto err_clock_get;
+		return PTR_ERR(dsim->clock);
 	}
 
 	clk_enable(dsim->clock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get io memory region\n");
-		ret = -ENODEV;
-		goto err_platform_get;
-	}
-
-	dsim->res = request_mem_region(res->start, resource_size(res),
-					dev_name(&pdev->dev));
-	if (!dsim->res) {
-		dev_err(&pdev->dev, "failed to request io memory region\n");
-		ret = -ENOMEM;
-		goto err_mem_region;
-	}
 
-	dsim->reg_base = ioremap(res->start, resource_size(res));
+	dsim->reg_base = devm_request_and_ioremap(&pdev->dev, res);
 	if (!dsim->reg_base) {
-		dev_err(&pdev->dev, "failed to remap io region\n");
-		ret = -ENOMEM;
-		goto err_ioremap;
+		dev_err(&pdev->dev, "failed to map registers\n");
+		ret = -ENXIO;
+		goto cleanup_clk;
 	}
 
 	mutex_init(&dsim->lock);
@@ -409,27 +397,28 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	dsim_ddi = exynos_mipi_dsi_bind_lcd_ddi(dsim, dsim_pd->lcd_panel_name);
 	if (!dsim_ddi) {
 		dev_err(&pdev->dev, "mipi_dsim_ddi object not found.\n");
-		ret = -EINVAL;
-		goto err_bind;
+		ret = -ENXIO;
+		goto cleanup_clk;
 	}
 
 	dsim->irq = platform_get_irq(pdev, 0);
 	if (dsim->irq < 0) {
 		dev_err(&pdev->dev, "failed to request dsim irq resource\n");
 		ret = -EINVAL;
-		goto err_platform_get_irq;
+		goto cleanup_clk;
 	}
 
 	init_completion(&dsim_wr_comp);
 	init_completion(&dsim_rd_comp);
 	platform_set_drvdata(pdev, dsim);
 
-	ret = request_irq(dsim->irq, exynos_mipi_dsi_interrupt_handler,
+	ret = devm_request_irq(&pdev->dev, dsim->irq,
+			exynos_mipi_dsi_interrupt_handler,
 			IRQF_SHARED, dev_name(&pdev->dev), dsim);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "failed to request dsim irq\n");
 		ret = -EINVAL;
-		goto err_bind;
+		goto cleanup_clk;
 	}
 
 	/* enable interrupts */
@@ -464,29 +453,13 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
 	dsim->suspended = false;
 
 done:
-	platform_set_drvdata(pdev, dsim);
-
 	dev_dbg(&pdev->dev, "%s() completed sucessfuly (%s mode)\n", __func__,
 		dsim_config->e_interface = DSIM_COMMAND ? "CPU" : "RGB");
 
 	return 0;
 
-err_bind:
-	iounmap(dsim->reg_base);
-
-err_ioremap:
-	release_mem_region(dsim->res->start, resource_size(dsim->res));
-
-err_mem_region:
-	release_resource(dsim->res);
-
-err_platform_get:
+cleanup_clk:
 	clk_disable(dsim->clock);
-	clk_put(dsim->clock);
-err_clock_get:
-	kfree(dsim);
-
-err_platform_get_irq:
 	return ret;
 }
 
@@ -496,13 +469,7 @@ static int __devexit exynos_mipi_dsi_remove(struct platform_device *pdev)
 	struct mipi_dsim_ddi *dsim_ddi, *next;
 	struct mipi_dsim_lcd_driver *dsim_lcd_drv;
 
-	iounmap(dsim->reg_base);
-
 	clk_disable(dsim->clock);
-	clk_put(dsim->clock);
-
-	release_resource(dsim->res);
-	release_mem_region(dsim->res->start, resource_size(dsim->res));
 
 	list_for_each_entry_safe(dsim_ddi, next, &dsim_ddi_list, list) {
 		if (dsim_ddi) {
@@ -518,9 +485,6 @@ static int __devexit exynos_mipi_dsi_remove(struct platform_device *pdev)
 		}
 	}
 
-	regulator_bulk_free(ARRAY_SIZE(supplies), supplies);
-	kfree(dsim);
-
 	return 0;
 }
 
-- 
1.7.0.4

