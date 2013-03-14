From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:25 +0000
Subject: [PATCH 1/6] video: mxsfb: use devm_* managed functions
Message-Id: <1363240410-16865-2-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use devm_* managed functions to make code a little cleaner.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/video/mxsfb.c |   50 ++++++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 755556c..2c5ab15 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -801,23 +801,19 @@ static int mxsfb_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name))
-		return -EBUSY;
-
 	fb_info = framebuffer_alloc(sizeof(struct mxsfb_info), &pdev->dev);
 	if (!fb_info) {
 		dev_err(&pdev->dev, "Failed to allocate fbdev\n");
-		ret = -ENOMEM;
-		goto error_alloc_info;
+		return -ENOMEM;
 	}
 
 	host = to_imxfb_host(fb_info);
 
-	host->base = ioremap(res->start, resource_size(res));
-	if (!host->base) {
+	host->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(host->base)) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		ret = -ENOMEM;
-		goto error_ioremap;
+		ret = PTR_ERR(host->base);
+		goto fb_release;
 	}
 
 	host->pdev = pdev;
@@ -828,13 +824,13 @@ static int mxsfb_probe(struct platform_device *pdev)
 	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(pinctrl)) {
 		ret = PTR_ERR(pinctrl);
-		goto error_getpin;
+		goto fb_release;
 	}
 
-	host->clk = clk_get(&host->pdev->dev, NULL);
+	host->clk = devm_clk_get(&host->pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
-		goto error_getclock;
+		goto fb_release;
 	}
 
 	panel_enable = of_get_named_gpio_flags(pdev->dev.of_node,
@@ -849,21 +845,22 @@ static int mxsfb_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to request gpio %d: %d\n",
 				panel_enable, ret);
-			goto error_panel_enable;
+			goto fb_release;
 		}
 	}
 
-	fb_info->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
+	fb_info->pseudo_palette = devm_kzalloc(&pdev->dev, sizeof(u32) * 16,
+					       GFP_KERNEL);
 	if (!fb_info->pseudo_palette) {
 		ret = -ENOMEM;
-		goto error_pseudo_pallette;
+		goto fb_release;
 	}
 
 	INIT_LIST_HEAD(&fb_info->modelist);
 
 	ret = mxsfb_init_fbinfo(host);
 	if (ret != 0)
-		goto error_init_fb;
+		goto fb_release;
 
 	for (i = 0; i < pdata->mode_count; i++)
 		fb_add_videomode(&pdata->mode_list[i], &fb_info->modelist);
@@ -880,7 +877,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 	ret = register_framebuffer(fb_info);
 	if (ret != 0) {
 		dev_err(&pdev->dev,"Failed to register framebuffer\n");
-		goto error_register;
+		goto fb_destroy;
 	}
 
 	if (!host->enabled) {
@@ -893,22 +890,12 @@ static int mxsfb_probe(struct platform_device *pdev)
 
 	return 0;
 
-error_register:
+fb_destroy:
 	if (host->enabled)
 		clk_disable_unprepare(host->clk);
 	fb_destroy_modelist(&fb_info->modelist);
-error_init_fb:
-	kfree(fb_info->pseudo_palette);
-error_pseudo_pallette:
-error_panel_enable:
-	clk_put(host->clk);
-error_getclock:
-error_getpin:
-	iounmap(host->base);
-error_ioremap:
+fb_release:
 	framebuffer_release(fb_info);
-error_alloc_info:
-	release_mem_region(res->start, resource_size(res));
 
 	return ret;
 }
@@ -917,19 +904,14 @@ static int mxsfb_remove(struct platform_device *pdev)
 {
 	struct fb_info *fb_info = platform_get_drvdata(pdev);
 	struct mxsfb_info *host = to_imxfb_host(fb_info);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	if (host->enabled)
 		mxsfb_disable_controller(fb_info);
 
 	unregister_framebuffer(fb_info);
-	kfree(fb_info->pseudo_palette);
 	mxsfb_free_videomem(host);
-	iounmap(host->base);
-	clk_put(host->clk);
 
 	framebuffer_release(fb_info);
-	release_mem_region(res->start, resource_size(res));
 
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.9.5


