From: Darren Etheridge <detheridge@ti.com>
Date: Thu, 08 Aug 2013 20:15:36 +0000
Subject: [RFC 1/1] video: da8xx-fb: adding dt support
Message-Id: <1375992936-16755-2-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375992936-16755-1-git-send-email-detheridge@ti.com>
In-Reply-To: <1375992936-16755-1-git-send-email-detheridge@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, detheridge@ti.com
Cc: afzal@ti.com

Enhancing driver to enable probe triggered by a corresponding dt entry.

Add da8xx-fb.txt documentation to devicetree section.

Obtain fb_videomode details for the connected lcd panel using the
display timing details present in DT.

Ensure that platform data is present before checking whether platform
callback is present (the one used to control backlight). So far this
was not an issue as driver was purely non-DT triggered, but now DT
support has been added this check must be performed.

v2: squashing multiple commits from Afzal Mohammed (afzal@ti.com)
v3: remove superfluous cast
v4: expose both ti,am3352-lcdc and ti,da830-lcdc for .compatible
	as driver can use enhanced features of all version of the
	silicon block.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 .../devicetree/bindings/video/fb-da8xx.txt         |   37 +++++++++++
 drivers/video/da8xx-fb.c                           |   67 +++++++++++++++++++-
 2 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fb-da8xx.txt

diff --git a/Documentation/devicetree/bindings/video/fb-da8xx.txt b/Documentation/devicetree/bindings/video/fb-da8xx.txt
new file mode 100644
index 0000000..a6cfe3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fb-da8xx.txt
@@ -0,0 +1,37 @@
+TI LCD Controller on DA830/DA850/AM335x SoC's
+
+Required properties:
+- compatible:
+	DA830 - "ti,da830-lcdc"
+	AM335x SoC's - "ti,am3352-lcdc"
+- reg: Address range of lcdc register set
+- interrupts: lcdc interrupt
+- display-timings: typical videomode of lcd panel, represented as child.
+  Refer Documentation/devicetree/bindings/video/display-timing.txt for
+  display timing binding details. If multiple videomodes are mentioned
+  in display timings node, typical videomode has to be mentioned as the
+  native mode or it has to be first child (driver cares only for native
+  videomode).
+
+Example:
+
+lcdc@4830e000 {
+	compatible = "ti,am3352-lcdc";
+	reg =  <0x4830e000 0x1000>;
+	interrupts = <36>;
+	display-timings {
+		800x480p62 {
+			clock-frequency = <30000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <39>;
+			hback-porch = <39>;
+			hsync-len = <47>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <2>;
+			hsync-active = <1>;
+			vsync-active = <1>;
+		};
+	};
+};
diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index ea9771f..64fd8af 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/lcm.h>
+#include <video/of_display_timing.h>
 #include <video/da8xx-fb.h>
 #include <asm/div64.h>
 
@@ -1297,12 +1298,57 @@ static struct fb_ops da8xx_fb_ops = {
 	.fb_blank = cfb_blank,
 };
 
+static struct lcd_ctrl_config *da8xx_fb_create_cfg(struct platform_device *dev)
+{
+	struct lcd_ctrl_config *cfg;
+
+	cfg = devm_kzalloc(&dev->dev, sizeof(struct fb_videomode), GFP_KERNEL);
+	if (!cfg) {
+		dev_err(&dev->dev, "memory allocation failed\n");
+		return NULL;
+	}
+
+	/* default values */
+
+	if (lcd_revision = LCD_VERSION_1)
+		cfg->bpp = 16;
+	else
+		cfg->bpp = 32;
+
+	/*
+	 * For panels so far used with this LCDC, below statement is sufficient.
+	 * For new panels, if required, struct lcd_ctrl_cfg fields to be updated
+	 * with additional/modified values. Those values would have to be then
+	 * obtained from dt(requiring new dt bindings).
+	 */
+
+	cfg->panel_shade = COLOR_ACTIVE;
+
+	return cfg;
+}
+
 static struct fb_videomode *da8xx_fb_get_videomode(struct platform_device *dev)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata = dev->dev.platform_data;
 	struct fb_videomode *lcdc_info;
+	struct device_node *np = dev->dev.of_node;
 	int i;
 
+	if (np) {
+		lcdc_info = devm_kzalloc(&dev->dev,
+					 sizeof(struct fb_videomode),
+					 GFP_KERNEL);
+		if (!lcdc_info) {
+			dev_err(&dev->dev, "memory allocation failed\n");
+			return NULL;
+		}
+		if (of_get_fb_videomode(np, lcdc_info, OF_USE_NATIVE_MODE)) {
+			dev_err(&dev->dev, "timings not available in DT\n");
+			return NULL;
+		}
+		return lcdc_info;
+	}
+
 	for (i = 0, lcdc_info = known_lcd_panels;
 		i < ARRAY_SIZE(known_lcd_panels); i++, lcdc_info++) {
 		if (strcmp(fb_pdata->type, lcdc_info->name) = 0)
@@ -1331,7 +1377,7 @@ static int fb_probe(struct platform_device *device)
 	int ret;
 	unsigned long ulcm;
 
-	if (fb_pdata = NULL) {
+	if (fb_pdata = NULL && !device->dev.of_node) {
 		dev_err(&device->dev, "Can not get platform data\n");
 		return -ENOENT;
 	}
@@ -1371,7 +1417,10 @@ static int fb_probe(struct platform_device *device)
 		break;
 	}
 
-	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
+	if (device->dev.of_node)
+		lcd_cfg = da8xx_fb_create_cfg(device);
+	else
+		lcd_cfg = fb_pdata->controller_data;
 
 	if (!lcd_cfg) {
 		ret = -EINVAL;
@@ -1390,7 +1439,7 @@ static int fb_probe(struct platform_device *device)
 	par->dev = &device->dev;
 	par->lcdc_clk = tmp_lcdc_clk;
 	par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
-	if (fb_pdata->panel_power_ctrl) {
+	if (fb_pdata && fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
 		par->panel_power_ctrl(1);
 	}
@@ -1638,6 +1687,17 @@ static int fb_resume(struct platform_device *dev)
 #define fb_resume NULL
 #endif
 
+static const struct of_device_id da8xx_fb_of_match[] = {
+	/*
+	 * this driver supports version 1 and version 2 of the
+	 * Texas Instruments lcd controller (lcdc) hardware block
+	 */
+	{.compatible = "ti,da830-lcdc", },
+	{.compatible = "ti,am3352-lcdc", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, da8xx_fb_of_match);
+
 static struct platform_driver da8xx_fb_driver = {
 	.probe = fb_probe,
 	.remove = fb_remove,
@@ -1646,6 +1706,7 @@ static struct platform_driver da8xx_fb_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(da8xx_fb_of_match),
 		   },
 };
 
-- 
1.7.0.4

