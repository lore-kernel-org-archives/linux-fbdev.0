From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Mon, 09 Jan 2012 19:59:12 +0000
Subject: [PATCH] video: s3c-fb: Add device tree support
Message-Id: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add device tree based discovery support for Samsung's display controller.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/fb/samsung-fb.txt          |  103 ++++++++++
 drivers/video/s3c-fb.c                             |  209 +++++++++++++++++++-
 2 files changed, 304 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/samsung-fb.txt

diff --git a/Documentation/devicetree/bindings/fb/samsung-fb.txt b/Documentation/devicetree/bindings/fb/samsung-fb.txt
new file mode 100644
index 0000000..8a27fcf
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/samsung-fb.txt
@@ -0,0 +1,103 @@
+* Samsung Display Controller (Framebuffer)
+
+The display controller is used to transfer image data from memory to a
+external LCD panel. It supports various color formats such as rgb, yuv
+and I80. It also supports multiple window overlays.
+
+Required properties:
+- compatible: should be one of the following
+    - samsung,exynos4210-fimd: for fimd compatible with Exynos4210 fimd
+    - samsung,s5pv210-fimd: for fimd compatible with s5pv210 fimd
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Three interrupts should be specified. The format of the
+  interrupt specifier depends on the interrupt controller. The interrupts
+  should be specified in the following order.
+    - VSYNC (Video Frame) interrupt
+    - Video FIFO level interrupt
+    - FIMD System Interrupt
+- gpios: The gpios used to interface with the external LCD panel.
+
+Overlays: Multiple overlays can be specified and child nodes. The order
+of the overlay should be the lowest numbered overlay first.
+- samsung,fimd-htiming: Specifies the horizontal timing for the overlay.
+  The horizontal timing includes four parameters in the following order.
+    - horizontal back porch (in number of lcd clocks)
+    - horizontal front porch (in number of lcd clocks)
+    - hsync pulse width (in number of lcd clocks)
+    - X resolution.
+- samsung,fimd-vtiming: Specifies the vertical timing for the overlay.
+  The vertical timing includes four parameters in the following order.
+    - vertical back porch (in number of lcd lines)
+    - vertical front porch (in number of lcd lines)
+    - vsync pulse width (in number of lcd clocks)
+    - Y resolution.
+- samsung,fimd-bpp: Specifies the bits per pixel. Two values should be
+  specified in the following order.
+    - max-bpp: maximum required bpp for the overlay.
+    - default-bpp: bpp supported by the overlay.
+- samsung,fimd-virtres: Specifies the resolution of the virtual frame
+  buffer. The resolution contains the X and Y resolution with value
+  of X being the first.
+
+Optional properties:
+- samsung,fimd-vidout-rgb: Video output format is RGB.
+- samsung,fimd-inv-hsync: invert hsync pulse polarity.
+- samsung,fimd-inv-vsync: invert vsync pulse polarity.
+- samsung,fimd-inv-vclk: invert video clock polarity.
+- samsung,fimd-inv-vden: invert video enable signal polarity.
+
+Example:
+
+	fimd@11C00000 {
+		compatible = "samsung,exynos4210-fimd";
+		interrupt-parent = <&combiner>;
+		reg = <0x11C00000 0x8000>;
+		interrupts = <11 1>, <11 0>, <11 2>;
+
+		samsung,fimd-vidout-rgb;
+		samsung,fimd-inv-hsync;
+		samsung,fimd-inv-vsync;
+		samsung,fimd-inv-vclk;
+
+		gpios = <&gpf0 0 2 0 0>,
+			<&gpf0 1 2 0 0>,
+			<&gpf0 2 2 0 0>,
+			<&gpf0 3 2 0 0>,
+			<&gpf0 4 2 0 0>,
+			<&gpf0 5 2 0 0>,
+			<&gpf0 6 2 0 0>,
+			<&gpf0 7 2 0 0>,
+			<&gpf1 0 2 0 0>,
+			<&gpf1 1 2 0 0>,
+			<&gpf1 2 2 0 0>,
+			<&gpf1 3 2 0 0>,
+			<&gpf1 4 2 0 0>,
+			<&gpf1 5 2 0 0>,
+			<&gpf1 6 2 0 0>,
+			<&gpf1 7 2 0 0>,
+			<&gpf2 0 2 0 0>,
+			<&gpf2 1 2 0 0>,
+			<&gpf2 2 2 0 0>,
+			<&gpf2 3 2 0 0>,
+			<&gpf2 4 2 0 0>,
+			<&gpf2 5 2 0 0>,
+			<&gpf2 6 2 0 0>,
+			<&gpf2 7 2 0 0>,
+			<&gpf3 0 2 0 0>,
+			<&gpf3 1 2 0 0>,
+			<&gpf3 2 2 0 0>,
+			<&gpf3 3 2 0 0>;
+
+		fimd-overlay0 {
+			samsung,fimd-htiming = <64 16 48 1024>;
+			samsung,fimd-vtiming = <64 16 3 600>;
+			samsung,fimd-bpp = <24 32>;
+		};
+
+		fimd-overlay1 {
+			samsung,fimd-htiming = <64 16 48 200>;
+			samsung,fimd-vtiming = <64 16 3 100>;
+			samsung,fimd-bpp = <16 32>;
+		};
+	};
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0753b1c..4517560 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -24,6 +24,8 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <mach/map.h>
 #include <plat/regs-fb-v4.h>
@@ -215,6 +217,7 @@ struct s3c_fb {
 	int			 irq_no;
 	unsigned long		 irq_flags;
 	struct s3c_fb_vsync	 vsync_info;
+	int			 *gpios;
 };
 
 /**
@@ -1315,9 +1318,168 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 	writel(reg & ~SHADOWCON_WINx_PROTECT(win), regs + SHADOWCON);
 }
 
+#ifdef CONFIG_OF
+static int s3c_fb_dt_parse_gpios(struct device *dev, struct s3c_fb *sfb,
+						bool request)
+{
+	int nr_gpios, idx, gpio, ret;
+
+	nr_gpios = sfb->pdata->win[0]->max_bpp + 4;
+	sfb->gpios = devm_kzalloc(dev, sizeof(int) * nr_gpios, GFP_KERNEL);
+	if (!sfb->gpios) {
+		dev_err(dev, "unable to allocate private data for gpio\n");
+		return -ENOMEM;
+	}
+
+	for (idx = 0; idx < nr_gpios; idx++) {
+		gpio = of_get_gpio(dev->of_node, idx);
+		if (!gpio_is_valid(gpio)) {
+			dev_err(dev, "invalid gpio[%d]: %d\n", idx, gpio);
+			return -EINVAL;
+		}
+
+		if (!request)
+			continue;
+
+		ret = gpio_request(gpio, "fimd");
+		if (ret) {
+			dev_err(dev, "gpio [%d] request failed\n", gpio);
+			goto gpio_free;
+		}
+		sfb->gpios[idx] = gpio;
+	}
+	return 0;
+
+gpio_free:
+	while (--idx >= 0)
+		gpio_free(sfb->gpios[idx]);
+	return ret;
+}
+
+static void s3c_fb_dt_free_gpios(struct s3c_fb *sfb)
+{
+	unsigned int idx, nr_gpio;
+
+	nr_gpio = sfb->pdata->win[0]->max_bpp + 4;
+	for (idx = 0; idx < nr_gpio; idx++)
+		gpio_free(sfb->gpios[idx]);
+}
+
+static int s3c_fb_dt_parse_pdata(struct device *dev,
+					struct s3c_fb_platdata **pdata)
+{
+	struct device_node *np = dev->of_node, *win_np;
+	struct s3c_fb_platdata *pd;
+	struct s3c_fb_pd_win *win;
+	int wnum = 0;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "no memory for pdata\n");
+		*pdata = NULL;
+		return -ENOMEM;
+	}
+
+	if (of_get_property(np, "samsung,fimd-vidout-rgb", NULL))
+		pd->vidcon0 |= VIDCON0_VIDOUT_RGB;
+	if (of_get_property(np, "samsung,fimd-vidout-tv", NULL))
+		pd->vidcon0 |= VIDCON0_VIDOUT_TV;
+	if (of_get_property(np, "samsung,fimd-inv-hsync", NULL))
+		pd->vidcon1 |= VIDCON1_INV_HSYNC;
+	if (of_get_property(np, "samsung,fimd-inv-vsync", NULL))
+		pd->vidcon1 |= VIDCON1_INV_VSYNC;
+	if (of_get_property(np, "samsung,fimd-inv-vclk", NULL))
+		pd->vidcon1 |= VIDCON1_INV_VCLK;
+	if (of_get_property(np, "samsung,fimd-inv-vden", NULL))
+		pd->vidcon1 |= VIDCON1_INV_VDEN;
+
+	for_each_child_of_node(np, win_np) {
+		struct fb_videomode *vm;
+		u32 data[4];
+
+		win = devm_kzalloc(dev, sizeof(*win), GFP_KERNEL);
+		if (!win) {
+			dev_err(dev, "no memory for window[%d] data\n", wnum);
+			return -ENOMEM;
+		}
+		pd->win[wnum++] = win;
+
+		vm = &win->win_mode;
+		if (of_property_read_u32_array(win_np, "samsung,fimd-htiming",
+						data, 4)) {
+			dev_err(dev, "invalid horizontal timing\n");
+			return -EINVAL;
+		}
+		vm->left_margin = data[0];
+		vm->right_margin = data[1];
+		vm->hsync_len = data[2];
+		vm->xres = data[3];
+
+		if (of_property_read_u32_array(win_np, "samsung,fimd-vtiming",
+						data, 4)) {
+			dev_err(dev, "invalid vertical timing\n");
+			return -EINVAL;
+		}
+		vm->upper_margin = data[0];
+		vm->lower_margin = data[1];
+		vm->vsync_len = data[2];
+		vm->yres = data[3];
+
+		if (of_property_read_u32_array(win_np, "samsung,fimd-bpp",
+						data, 2)) {
+			dev_err(dev, "invalid bpp\n");
+			return -EINVAL;
+		}
+		win->max_bpp = data[0];
+		win->default_bpp = data[1];
+
+		if (!of_property_read_u32_array(win_np, "samsung,fimd-virtres",
+						data, 2)) {
+			win->virtual_x = data[0];
+			win->virtual_y = data[1];
+		}
+	}
+
+	*pdata = pd;
+	return 0;
+}
+#else
+static int s3c_fb_dt_parse_gpios(struct device *dev, struct s3c_fb *sfb,
+						bool request)
+{
+	return 0;
+}
+
+static void s3c_fb_dt_free_gpios(struct s3c_fb *sfb)
+{
+	return 0;
+}
+
+static int s3c_fb_dt_parse_pdata(struct device *dev,
+					struct s3c_fb_platdata **pdata)
+{
+	return 0;
+}
+#endif /* CONFIG_OF */
+
+static const struct of_device_id s3c_fb_dt_match[];
+
+static inline struct s3c_fb_driverdata *s3c_fb_get_driver_data(
+			struct platform_device *pdev)
+{
+#ifdef CONFIG_OF
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(s3c_fb_dt_match, pdev->dev.of_node);
+		return (struct s3c_fb_driverdata *)match->data;
+	}
+#endif
+	return (struct s3c_fb_driverdata *)
+			platform_get_device_id(pdev)->driver_data;
+}
+
 static int __devinit s3c_fb_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *platid;
 	struct s3c_fb_driverdata *fbdrv;
 	struct device *dev = &pdev->dev;
 	struct s3c_fb_platdata *pd;
@@ -1326,15 +1488,21 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	int win;
 	int ret = 0;
 
-	platid = platform_get_device_id(pdev);
-	fbdrv = (struct s3c_fb_driverdata *)platid->driver_data;
+	fbdrv = s3c_fb_get_driver_data(pdev);
 
 	if (fbdrv->variant.nr_windows > S3C_FB_MAX_WIN) {
 		dev_err(dev, "too many windows, cannot attach\n");
 		return -EINVAL;
 	}
 
-	pd = pdev->dev.platform_data;
+	if (pdev->dev.of_node) {
+		ret = s3c_fb_dt_parse_pdata(&pdev->dev, &pd);
+		if (ret)
+			return ret;
+	} else {
+		pd = pdev->dev.platform_data;
+	}
+
 	if (!pd) {
 		dev_err(dev, "no platform data specified\n");
 		return -EINVAL;
@@ -1419,7 +1587,12 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	/* setup gpio and output polarity controls */
 
-	pd->setup_gpio();
+	if (dev->of_node) {
+		if (s3c_fb_dt_parse_gpios(dev, sfb, true))
+			goto err_irq;
+	} else {
+		pd->setup_gpio();
+	}
 
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
@@ -1452,7 +1625,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to create window %d\n", win);
 			for (; win >= 0; win--)
 				s3c_fb_release_win(sfb, sfb->windows[win]);
-			goto err_irq;
+			goto err_gpio;
 		}
 	}
 
@@ -1461,6 +1634,9 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_gpio:
+	s3c_fb_dt_free_gpios(sfb);
+
 err_irq:
 	free_irq(sfb->irq_no, sfb);
 
@@ -1520,6 +1696,7 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(sfb->dev);
 	pm_runtime_disable(sfb->dev);
 
+	s3c_fb_dt_free_gpios(sfb);
 	kfree(sfb);
 	return 0;
 }
@@ -1562,7 +1739,10 @@ static int s3c_fb_resume(struct device *dev)
 		clk_enable(sfb->lcd_clk);
 
 	/* setup gpio and output polarity controls */
-	pd->setup_gpio();
+	if (dev->of_node)
+		s3c_fb_dt_parse_gpios(dev, sfb, false);
+	else
+		pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
 	/* zero all windows before we do anything */
@@ -1627,7 +1807,10 @@ static int s3c_fb_runtime_resume(struct device *dev)
 		clk_enable(sfb->lcd_clk);
 
 	/* setup gpio and output polarity controls */
-	pd->setup_gpio();
+	if (dev->of_node)
+		s3c_fb_dt_parse_gpios(dev, sfb, false);
+	else
+		pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
 	/* zero all windows before we do anything */
@@ -1984,6 +2167,15 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, s3c_fb_driver_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c_fb_dt_match[] = {
+	{ .compatible = "samsung,exynos4210-fimd",
+		.data = (void *)&s3c_fb_data_exynos4 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, s3c_fb_dt_match);
+#endif
+
 static const struct dev_pm_ops s3cfb_pm_ops = {
 	.suspend	= s3c_fb_suspend,
 	.resume		= s3c_fb_resume,
@@ -1999,6 +2191,7 @@ static struct platform_driver s3c_fb_driver = {
 		.name	= "s3c-fb",
 		.owner	= THIS_MODULE,
 		.pm	= &s3cfb_pm_ops,
+		.of_match_table	= of_match_ptr(s3c_fb_dt_match),
 	},
 };
 
-- 
1.6.6.rc2

