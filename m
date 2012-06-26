From: Shawn Guo <shawn.guo@linaro.org>
Date: Tue, 26 Jun 2012 09:02:59 +0000
Subject: [PATCH 2/2] video: mxsfb: add simple device tree probe
Message-Id: <1340701379-8619-3-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a simple device tree probe support for mxsfb driver.  Before
a common binding for struct fb_videomode is available, the driver will
keep using struct mxsfb_platform_data.  That said, platform code will
use auxdata to attach mxsfb_platform_data for device tree boot.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/fb/mxsfb.txt |   21 ++++++++
 drivers/video/mxsfb.c                          |   60 ++++++++++++++++++-----
 2 files changed, 68 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/mxsfb.txt

diff --git a/Documentation/devicetree/bindings/fb/mxsfb.txt b/Documentation/devicetree/bindings/fb/mxsfb.txt
new file mode 100644
index 0000000..d4f8bdb
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/mxsfb.txt
@@ -0,0 +1,21 @@
+* Freescale MXS LCD Interface (LCDIF)
+
+Required properties:
+- compatible: Should be "fsl,<chip>-lcdif".  Supported chips include
+  imx23 and imx28.
+- reg: Address and length of the register set for lcdif
+- interrupts: Should contain lcdif interrupts
+
+Optional properties:
+- panel-enable-gpios : Should specify the gpio for panel enable
+- enable-active-low : Polarity of panel enable gpio is active low.
+  If this property is missing, the default assumed is active high.
+
+Examples:
+
+lcdif@80030000 {
+	compatible = "fsl,imx28-lcdif";
+	reg = <0x80030000 2000>;
+	interrupts = <38 86>;
+	panel-enable-gpios = <&gpio3 30 0>;
+};
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 08dad8d..588f00d 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -41,6 +41,8 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
@@ -750,16 +752,42 @@ static void __devexit mxsfb_free_videomem(struct mxsfb_info *host)
 	}
 }
 
+static struct platform_device_id mxsfb_devtype[] = {
+	{
+		.name = "imx23-fb",
+		.driver_data = MXSFB_V3,
+	}, {
+		.name = "imx28-fb",
+		.driver_data = MXSFB_V4,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mxsfb_devtype);
+
+static const struct of_device_id mxsfb_dt_ids[] = {
+	{ .compatible = "fsl,imx23-lcdif", .data = &mxsfb_devtype[0], },
+	{ .compatible = "fsl,imx28-lcdif", .data = &mxsfb_devtype[1], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxsfb_dt_ids);
+
 static int __devinit mxsfb_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id +			of_match_device(mxsfb_dt_ids, &pdev->dev);
 	struct mxsfb_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *res;
 	struct mxsfb_info *host;
 	struct fb_info *fb_info;
 	struct fb_modelist *modelist;
 	struct pinctrl *pinctrl;
+	int panel_enable;
 	int i, ret;
 
+	if (of_id)
+		pdev->id_entry = of_id->data;
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "No platformdata. Giving up\n");
 		return -ENODEV;
@@ -807,6 +835,23 @@ static int __devinit mxsfb_probe(struct platform_device *pdev)
 		goto error_getclock;
 	}
 
+	panel_enable = of_get_named_gpio(pdev->dev.of_node,
+					 "panel-enable-gpios", 0);
+	if (gpio_is_valid(panel_enable)) {
+		int flags = GPIOF_OUT_INIT_HIGH;
+		if (of_get_property(pdev->dev.of_node,
+				    "enable-active-low", NULL))
+			flags = GPIOF_OUT_INIT_LOW;
+		ret = devm_gpio_request_one(&pdev->dev, panel_enable,
+					    flags, "panel-enable");
+		if (ret) {
+			dev_err(&pdev->dev,
+				"failed to request gpio %d: %d\n",
+				panel_enable, ret);
+			goto error_panel_enable;
+		}
+	}
+
 	fb_info->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
 	if (!fb_info->pseudo_palette) {
 		ret = -ENOMEM;
@@ -854,6 +899,7 @@ error_register:
 error_init_fb:
 	kfree(fb_info->pseudo_palette);
 error_pseudo_pallette:
+error_panel_enable:
 	clk_put(host->clk);
 error_getclock:
 error_getpin:
@@ -901,19 +947,6 @@ static void mxsfb_shutdown(struct platform_device *pdev)
 	writel(CTRL_RUN, host->base + LCDC_CTRL + REG_CLR);
 }
 
-static struct platform_device_id mxsfb_devtype[] = {
-	{
-		.name = "imx23-fb",
-		.driver_data = MXSFB_V3,
-	}, {
-		.name = "imx28-fb",
-		.driver_data = MXSFB_V4,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(platform, mxsfb_devtype);
-
 static struct platform_driver mxsfb_driver = {
 	.probe = mxsfb_probe,
 	.remove = __devexit_p(mxsfb_remove),
@@ -921,6 +954,7 @@ static struct platform_driver mxsfb_driver = {
 	.id_table = mxsfb_devtype,
 	.driver = {
 		   .name = DRIVER_NAME,
+		   .of_match_table = mxsfb_dt_ids,
 	},
 };
 
-- 
1.7.5.4


