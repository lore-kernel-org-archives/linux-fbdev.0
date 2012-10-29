From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Mon, 29 Oct 2012 07:33:05 +0000
Subject: [PATCH 1/2] da8xx-fb: add DT support
Message-Id: <1351495266-1202-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: FlorianSchandinat@gmx.de, grant.likely@secretlab.ca, rob.herring@calxeda.com, davinci-linux-open-source@linux.davincidsp.com, linux-doc@vger.kernel.org, rob@landley.net, s.trumtrar@pengutronix.de, "Manjunathappa, Prakash" <prakash.pm@ti.com>

adds device tree support for da8xx-fb driver.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Depends on "of: Add display helper" [1] submitted by Steffen.
Above mentioned patch under review in community and has got
review comments. Preparing this patch to keep things moving.
@Steffen: Could you please include this in your next version of
your patch.

Applies on top of LCDC cleanup patches under community review [2].

[1]:http://marc.info/?l=dri-devel&m4937362110396&w=2
[2]:http://marc.info/?l=linux-fbdev&m5036440702662&w=2
 drivers/video/da8xx-fb.c |  165 +++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 149 insertions(+), 16 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index f0f21c8..8a2b0f8 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/lcm.h>
+#include <linux/of_videomode.h>
 #include <video/da8xx-fb.h>
 #include <asm/div64.h>
 
@@ -1211,12 +1212,134 @@ static unsigned int da8xxfb_pixel_clk_period(struct da8xx_fb_par *par)
 	return pix_clk_period_picosec;
 }
 
+#ifdef CONFIG_OF
+static struct da8xx_lcdc_platform_data
+	*da8xx_lcdc_of_get_pdata(struct platform_device *pdev,
+			struct fb_videomode **lcdc_info)
+{
+	struct device_node *np;
+	struct da8xx_lcdc_platform_data *pdata = NULL;
+	struct lcd_ctrl_config *lcd_cfg;
+	struct fb_videomode *panel_data = NULL;
+	u32 data;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "Failed to allocate memory for struct da8xx_lcdc_platform_data\n");
+			goto nodata;
+		}
+	}
+
+	np = pdev->dev.of_node;
+	if (!np)
+		goto nodata;
+
+	*lcdc_info = devm_kzalloc(&pdev->dev, sizeof(struct fb_videomode),
+			GFP_KERNEL);
+	if (!*lcdc_info) {
+		dev_err(&pdev->dev, "Failed to allocate memory for struct fb_videomode\n");
+		pdata = NULL;
+		goto nodata;
+	}
+	panel_data = *lcdc_info;
+
+	lcd_cfg = devm_kzalloc(&pdev->dev, sizeof(struct lcd_ctrl_config),
+			GFP_KERNEL);
+	if (!lcd_cfg) {
+		dev_err(&pdev->dev, "Failed to allocate memory for struct lcd_ctrl_config\n");
+		pdata = NULL;
+		goto nodata;
+	}
+	pdata->controller_data = lcd_cfg;
+
+	ret = of_get_fb_videomode(np, panel_data, 0);
+	if (ret) {
+		dev_err(&pdev->dev, "fb videomode data not specified\n");
+		pdata = NULL;
+		goto nodata;
+	}
+	/* Pixel clock is expected in Hertz */
+	panel_data->pixclock = PICOS2KHZ(panel_data->pixclock) * 1000;
+
+	/* Required properties */
+	ret = of_property_read_u32(np, "panel-shade", &data);
+	if (ret) {
+		dev_err(&pdev->dev, "panel-shade not specified\n");
+		pdata = NULL;
+		goto nodata;
+	}
+	lcd_cfg->panel_shade = data;
+
+	ret = of_property_read_u32(np, "bpp", &data);
+	if (ret) {
+		dev_err(&pdev->dev, "BPP of panel not specified\n");
+		pdata = NULL;
+		goto nodata;
+	}
+	lcd_cfg->bpp = data;
+
+	/* Optional properties */
+	ret = of_property_read_u32(np, "ac-bias", &data);
+	if (!ret)
+		lcd_cfg->ac_bias = data;
+
+	ret = of_property_read_u32(np, "ac-bias-intrpt", &data);
+	if (!ret)
+		lcd_cfg->ac_bias_intrpt = data;
+
+	ret = of_property_read_u32(np, "dma-burst-sz", &data);
+	if (!ret)
+		lcd_cfg->dma_burst_sz = data;
+
+	ret = of_property_read_u32(np, "fdd", &data);
+	if (!ret)
+		lcd_cfg->fdd = data;
+
+	ret = of_property_read_u32(np, "tft-alt-mode", &data);
+	if (!ret)
+		lcd_cfg->tft_alt_mode = data;
+
+	ret = of_property_read_u32(np, "stn-565-mode", &data);
+	if (!ret)
+		lcd_cfg->stn_565_mode = data;
+
+	ret = of_property_read_u32(np, "mono-8bit-mode", &data);
+	if (!ret)
+		lcd_cfg->mono_8bit_mode = data;
+
+	ret = of_property_read_u32(np, "sync-edge", &data);
+	if (!ret)
+		lcd_cfg->sync_edge = data;
+
+	ret = of_property_read_u32(np, "raster-order", &data);
+	if (!ret)
+		lcd_cfg->raster_order = data;
+
+	ret = of_property_read_u32(np, "fifo-threshold", &data);
+	if (!ret)
+		lcd_cfg->fifo_th = data;
+
+	pdev->dev.platform_data = pdata;
+nodata:
+	return pdata;
+}
+#else
+static struct da8xx_lcdc_platform_data
+	*da8xx_lcdc_of_get_pdata(struct platform_device *pdev,
+			struct fb_videomode **lcdc_info)
+{
+	return pdev->dev.platform_data;
+}
+#endif
+
 static int __devinit fb_probe(struct platform_device *device)
 {
-	struct da8xx_lcdc_platform_data *fb_pdata -						device->dev.platform_data;
+	struct da8xx_lcdc_platform_data *fb_pdata = NULL;
 	struct lcd_ctrl_config *lcd_cfg;
-	struct fb_videomode *lcdc_info;
+	struct fb_videomode *lcdc_info = NULL;
 	struct fb_info *da8xx_fb_info;
 	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
@@ -1224,6 +1347,7 @@ static int __devinit fb_probe(struct platform_device *device)
 	int ret, i;
 	unsigned long ulcm;
 
+	fb_pdata = da8xx_lcdc_of_get_pdata(device, &lcdc_info);
 	if (fb_pdata = NULL) {
 		dev_err(&device->dev, "Can not get platform data\n");
 		return -ENOENT;
@@ -1274,20 +1398,22 @@ static int __devinit fb_probe(struct platform_device *device)
 		break;
 	}
 
-	for (i = 0, lcdc_info = known_lcd_panels;
-		i < ARRAY_SIZE(known_lcd_panels);
-		i++, lcdc_info++) {
-		if (strcmp(fb_pdata->type, lcdc_info->name) = 0)
-			break;
-	}
+	if (device->dev.of_node = NULL) {
+		for (i = 0, lcdc_info = known_lcd_panels;
+			i < ARRAY_SIZE(known_lcd_panels);
+			i++, lcdc_info++) {
+			if (strcmp(fb_pdata->type, lcdc_info->name) = 0)
+				break;
+		}
 
-	if (i = ARRAY_SIZE(known_lcd_panels)) {
-		dev_err(&device->dev, "GLCD: No valid panel found\n");
-		ret = -ENODEV;
-		goto err_pm_runtime_disable;
-	} else
-		dev_info(&device->dev, "GLCD: Found %s panel\n",
-					fb_pdata->type);
+		if (i = ARRAY_SIZE(known_lcd_panels)) {
+			dev_err(&device->dev, "GLCD: No valid panel found\n");
+			ret = -ENODEV;
+			goto err_pm_runtime_disable;
+		} else
+			dev_info(&device->dev, "GLCD: Found %s panel\n",
+						fb_pdata->type);
+	}
 
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
@@ -1577,6 +1703,12 @@ static int fb_resume(struct platform_device *dev)
 #define fb_resume NULL
 #endif
 
+static const struct of_device_id da830_lcdc_of_match[] = {
+	{.compatible = "ti,da830-lcd", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, da830_lcdc_of_match);
+
 static struct platform_driver da8xx_fb_driver = {
 	.probe = fb_probe,
 	.remove = __devexit_p(fb_remove),
@@ -1585,6 +1717,7 @@ static struct platform_driver da8xx_fb_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(da830_lcdc_of_match),
 		   },
 };
 
-- 
1.7.0.4

