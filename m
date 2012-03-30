From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Fri, 30 Mar 2012 05:49:42 +0000
Subject: [PATCH v2] video: s3c-fb: Add device tree support
Message-Id: <1333086797-1625-1-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add device tree based discovery support for Samsung's display controller
framebuffer driver.

Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/fb/samsung-fb.txt          |  148 +++++++++++++
 drivers/video/s3c-fb.c                             |  230 +++++++++++++++++++-
 2 files changed, 370 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fb/samsung-fb.txt

diff --git a/Documentation/devicetree/bindings/fb/samsung-fb.txt b/Documentation/devicetree/bindings/fb/samsung-fb.txt
new file mode 100644
index 0000000..612bd9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/fb/samsung-fb.txt
@@ -0,0 +1,148 @@
+* Samsung Display Controller Framebuffer Controller
+
+The display controller is used to transfer image data from memory to a
+external display device such as an RGB interface LCD panel. It supports
+various color formats such as rgb and yuv. It also supports multiple window
+overlays.
+
+Required properties:
+
+    - compatible: should be one of the following
+      - samsung,exynos4210-fimd: for fimd compatible with Exynos4210 fimd
+      - samsung,s5pv210-fimd: for fimd compatible with s5pv210 fimd
+
+    - reg: physical base address of the controller and length of memory
+      mapped region.
+
+    - interrupts: Three interrupts should be specified. The format of the
+      interrupt specifier depends on the interrupt controller. The interrupts
+      should be specified in the following order.
+      - VSYNC (Video Frame) interrupt
+      - Video FIFO level interrupt
+      - FIMD System Interrupt
+
+    - gpios: The gpios used to interface with the external LCD panel. For a
+      panel with rgb interface, the gpio interface consists of video data
+      lines, HSYNC, VSYNC, Pixel Clock and Data Enable. The gpio's used for
+      these interface lines can be listed under this property in any order.
+
+    - samsung,fimd-display: The fimd controller is interfaced with the a
+      display device such as a lcd panel. This property should specify the
+      phandle of the display device node. For a display device node that
+      represents a RGB type display interface, it is expected to specify the
+      video interface timing using the following properties.
+
+      - lcd-htiming: Specifies the horizontal timing for the overlay. The
+        horizontal timing includes four parameters in the following order.
+
+        - horizontal back porch (in number of lcd clocks)
+        - horizontal front porch (in number of lcd clocks)
+        - hsync pulse width (in number of lcd clocks)
+        - Display panels X resolution.
+
+      - lcd-vtiming: Specifies the vertical timing for the overlay. The
+        vertical timing includes four parameters in the following order.
+
+        - vertical back porch (in number of lcd lines)
+        - vertical front porch (in number of lcd lines)
+        - vsync pulse width (in number of lcd clocks)
+        - Y resolution.
+
+    - Overlay/Windows: Multiple overlays/windows can be specified as child
+      nodes. Each window should have the following properties (optional
+      window properties are marked as 'optional').
+
+      - samsung,fimd-win-id: Specifies the window number of the fimd controller.
+
+      - samsung,fimd-win-bpp: Specifies the bits per pixel. Two values should
+	be specified in the following order.
+        - default-bpp: bpp supported by the overlay.
+        - max-bpp: maximum required bpp for the overlay.
+
+      - samsung,fimd-win-res: (OPTIONAL) Specifies the window resolution in
+        pixels. The resolution contains the X and Y pixel values with X being
+        specified first. If this property is not specified, the window
+        resolution is set to be equal to the display panel resolution.
+
+      - samsung,fimd-win-virtres: (OPTIONAL) Specifies the resolution of the
+        virtual frame buffer for the window. The resolution contains the X
+        and Y resolution in pixels with value of X being the specified first.
+
+Optional properties:
+
+    - samsung,fimd-vidout-rgb: Video output format is RGB.
+    - samsung,fimd-inv-hsync: invert hsync pulse polarity.
+    - samsung,fimd-inv-vsync: invert vsync pulse polarity.
+    - samsung,fimd-inv-vclk: invert video clock polarity.
+    - samsung,fimd-inv-vden: invert video enable signal polarity.
+    - samsung,fimd-frame-rate: Number of video frames per second.
+
+Example:
+
+    The following is an example for the fimd framebuffer controller is split
+    into two portions. The SoC specific portion can be specified in the SoC
+    specific dts file. The board specific portion can be specified in the
+    board specific dts file.
+
+    - SoC Specific portion
+
+	fimd@11C00000 {
+		compatible = "samsung,exynos4210-fimd";
+		interrupt-parent = <&combiner>;
+		reg = <0x11C00000 0x8000>;
+		interrupts = <11 1>, <11 0>, <11 2>;
+	};
+
+    - Board Specific portion
+
+	fimd@11C00000 {
+		samsung,fimd-display = <&lcd_fimd0>;
+		samsung,fimd-vidout-rgb;
+		samsung,fimd-inv-hsync;
+		samsung,fimd-inv-vsync;
+		samsung,fimd-inv-vclk;
+		samsung,fimd-frame-rate = <60>;
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
+		window0 {
+			samsung,fimd-win-id = <0>;
+			samsung,fimd-win-bpp = <32 24>;
+			samsung,fimd-win-res = <512 300>;
+			samsung,fimd-win-vres = <1024 600>;
+		};
+
+		window1 {
+			samsung,fimd-win-id = <1>;
+			samsung,fimd-win-bpp = <32 24>;
+			samsung,fimd-win-res = <1024 200>;
+			samsung,fimd-win-vres = <1024 600>;
+		};
+	};
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 18c84b8..b8be668 100644
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
@@ -220,6 +222,7 @@ struct s3c_fb {
 	int			 irq_no;
 	unsigned long		 irq_flags;
 	struct s3c_fb_vsync	 vsync_info;
+	int			 *gpios;
 };
 
 /**
@@ -1352,27 +1355,215 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
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
+static struct s3c_fb_platdata *s3c_fb_dt_parse_pdata(struct device *dev)
+{
+	struct device_node *np = dev->of_node, *win_np;
+	struct device_node *disp_np;
+	struct s3c_fb_platdata *pd;
+	struct s3c_fb_pd_win *win;
+	u32 wnum = 0, data[4];
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "memory allocation for pdata failed\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	pd->vtiming = devm_kzalloc(dev, sizeof(*pd->vtiming), GFP_KERNEL);
+	if (!pd->vtiming) {
+		dev_err(dev, "memory allocation for vtiming failed\n");
+		return ERR_PTR(-ENOMEM);
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
+	disp_np = of_parse_phandle(np, "samsung,fimd-display", 0);
+	if (!disp_np) {
+		dev_err(dev, "unable to find display panel info\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (of_property_read_u32_array(disp_np, "lcd-htiming", data, 4)) {
+		dev_err(dev, "invalid horizontal timing\n");
+		return ERR_PTR(-EINVAL);
+	}
+	pd->vtiming->left_margin = data[0];
+	pd->vtiming->right_margin = data[1];
+	pd->vtiming->hsync_len = data[2];
+	pd->vtiming->xres = data[3];
+
+	if (of_property_read_u32_array(disp_np, "lcd-vtiming", data, 4)) {
+		dev_err(dev, "invalid vertical timing\n");
+		return ERR_PTR(-EINVAL);
+	}
+	pd->vtiming->upper_margin = data[0];
+	pd->vtiming->lower_margin = data[1];
+	pd->vtiming->vsync_len = data[2];
+	pd->vtiming->yres = data[3];
+
+	of_property_read_u32_array(np, "samsung,fimd-frame-rate",
+				&pd->vtiming->refresh, 1);
+
+	for_each_child_of_node(np, win_np) {
+		if (of_property_read_u32_array(win_np, "samsung,fimd-win-id",
+						&wnum, 1)) {
+			dev_err(dev, "window id not specified\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		win = devm_kzalloc(dev, sizeof(*win), GFP_KERNEL);
+		if (!win) {
+			dev_err(dev, "no memory for window[%d] data\n", wnum);
+			return ERR_PTR(-ENOMEM);
+		}
+		pd->win[wnum] = win;
+
+		if (of_property_read_u32_array(win_np, "samsung,fimd-win-bpp",
+						data, 2)) {
+			dev_err(dev, "invalid window bpp\n");
+			return ERR_PTR(-EINVAL);
+		}
+		win->default_bpp = data[0];
+		win->max_bpp = data[1];
+
+		if (of_property_read_u32_array(win_np, "samsung,fimd-win-res",
+						data, 2)) {
+			dev_info(dev, "window [%d] resolution not specified. "
+				"Using lcd resolution X[%d] and Y[%d]", wnum,
+				pd->vtiming->xres, pd->vtiming->yres);
+			win->xres = pd->vtiming->xres;
+			win->yres = pd->vtiming->yres;
+		} else {
+			win->xres = data[0];
+			win->yres = data[1];
+		}
+
+		if (!of_property_read_u32_array(win_np,
+				"samsung,fimd-win-virtres", data, 2)) {
+			win->virtual_x = data[0];
+			win->virtual_y = data[1];
+		}
+	}
+
+	return pd;
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
-	struct s3c_fb_platdata *pd;
+	struct s3c_fb_platdata *pd = pdev->dev.platform_data;
 	struct s3c_fb *sfb;
 	struct resource *res;
 	int win;
 	int ret = 0;
 	u32 reg;
 
-	platid = platform_get_device_id(pdev);
-	fbdrv = (struct s3c_fb_driverdata *)platid->driver_data;
+	fbdrv = s3c_fb_get_driver_data(pdev);
 
 	if (fbdrv->variant.nr_windows > S3C_FB_MAX_WIN) {
 		dev_err(dev, "too many windows, cannot attach\n");
 		return -EINVAL;
 	}
 
-	pd = pdev->dev.platform_data;
+	if (pdev->dev.of_node) {
+		pd = s3c_fb_dt_parse_pdata(&pdev->dev);
+		if (IS_ERR(pd))
+			return PTR_ERR(pd);
+	}
+
 	if (!pd) {
 		dev_err(dev, "no platform data specified\n");
 		return -EINVAL;
@@ -1449,7 +1640,12 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	/* setup gpio and output polarity controls */
 
-	pd->setup_gpio();
+	if (dev->of_node) {
+		if (s3c_fb_dt_parse_gpios(dev, sfb, true))
+			goto err_lcd_clk;
+	} else {
+		pd->setup_gpio();
+	}
 
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
@@ -1499,6 +1695,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_runtime:
+	s3c_fb_dt_free_gpios(sfb);
 	pm_runtime_put_sync(sfb->dev);
 
 err_lcd_clk:
@@ -1545,6 +1742,7 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(sfb->dev);
 	pm_runtime_disable(sfb->dev);
+	s3c_fb_dt_free_gpios(sfb);
 
 	return 0;
 }
@@ -1588,7 +1786,10 @@ static int s3c_fb_resume(struct device *dev)
 		clk_enable(sfb->lcd_clk);
 
 	/* setup gpio and output polarity controls */
-	pd->setup_gpio();
+	if (dev->of_node)
+		s3c_fb_dt_parse_gpios(dev, sfb, false);
+	else
+		pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
 	/* set video clock running at under-run */
@@ -1658,7 +1859,10 @@ static int s3c_fb_runtime_resume(struct device *dev)
 		clk_enable(sfb->lcd_clk);
 
 	/* setup gpio and output polarity controls */
-	pd->setup_gpio();
+	if (dev->of_node)
+		s3c_fb_dt_parse_gpios(dev, sfb, false);
+	else
+		pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
 	return 0;
@@ -2028,6 +2232,15 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
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
 	SET_SYSTEM_SLEEP_PM_OPS(s3c_fb_suspend, s3c_fb_resume)
 	SET_RUNTIME_PM_OPS(s3c_fb_runtime_suspend, s3c_fb_runtime_resume,
@@ -2042,6 +2255,7 @@ static struct platform_driver s3c_fb_driver = {
 		.name	= "s3c-fb",
 		.owner	= THIS_MODULE,
 		.pm	= &s3cfb_pm_ops,
+		.of_match_table	= of_match_ptr(s3c_fb_dt_match),
 	},
 };
 
-- 
1.6.6.rc2

