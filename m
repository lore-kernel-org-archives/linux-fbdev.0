From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 03 Oct 2015 16:11:54 +0000
Subject: [PATCH 2/2] video: fbdev: pxafb: initial devicetree conversion
Message-Id: <1443888714-12362-3-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443888714-12362-1-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1443888714-12362-1-git-send-email-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

This patch brings a first support of pxa framebuffer devices to a
devicetree pxa platform, as was before platform data.

There are restrictions with this port, the biggest one being the lack of
support of smart panels. Moreover the conversion doesn't provide a way
to declare multiple framebuffer configurations with different bits per
pixel, only the LCD hardware bus width is used.

The patch was tested on both pxa25x, pxa27x and pxa3xx platform (namely
lubbock, mainstone and zylonite).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/video/fbdev/Kconfig |   2 +
 drivers/video/fbdev/pxafb.c | 162 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 8b1d371b5404..1a24ca5a0624 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1878,6 +1878,8 @@ config FB_PXA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS if OF
+	select FB_MODE_HELPERS if OF
 	---help---
 	  Frame buffer driver for the built-in LCD controller in the Intel
 	  PXA2x0 processor.
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index ed4b1a5dc306..602622c56186 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -55,6 +55,8 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/console.h>
+#include <video/of_display_timing.h>
+#include <video/videomode.h>
 
 #include <mach/hardware.h>
 #include <asm/io.h>
@@ -2092,6 +2094,152 @@ static void pxafb_check_options(struct device *dev, struct pxafb_mach_info *inf)
 #define pxafb_check_options(...)	do {} while (0)
 #endif
 
+#if defined(CONFIG_OF)
+static const char * const lcd_types[] = {
+	"unknown", "mono-stn", "mono-dstn", "color-stn", "color-dstn",
+	"color-tft", "smart-panel", NULL
+};
+
+static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
+				struct pxafb_mach_info *info)
+{
+	struct display_timings *timings;
+	struct videomode vm;
+	int i, ret = -EINVAL;
+	u32 bpp;
+	const char *s;
+
+	ret = of_property_read_u32(disp, "bits-per-pixel", &bpp);
+	if (ret) {
+		dev_err(dev, "no bits per pixel specified: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_property_read_string(disp, "lcd-type", &s);
+	if (ret) {
+		dev_err(dev, "no lcd type: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; lcd_types[i]; i++)
+		if (!strcmp(s, lcd_types[i]))
+			break;
+	if (!i || !lcd_types[i]) {
+		dev_err(dev, "lcd-type %s is unknown\n", s);
+		return -EINVAL;
+	}
+	info->lcd_conn |= LCD_CONN_TYPE(i);
+	info->lcd_conn |= LCD_CONN_WIDTH(bpp);
+
+	timings = of_get_display_timings(disp);
+	if (!timings)
+		goto out;
+
+	ret = -ENOMEM;
+	info->modes = kmalloc_array(timings->num_timings,
+				    sizeof(info->modes[0]), GFP_KERNEL);
+	if (!info->modes)
+		goto out;
+	info->num_modes = timings->num_timings;
+
+	for (i = 0; i < timings->num_timings; i++) {
+		ret = videomode_from_timings(timings, &vm, i);
+		if (ret) {
+			dev_err(dev, "videomode_from_timings %d failed: %d\n",
+				i, ret);
+			goto out;
+		}
+		if (vm.flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
+			info->lcd_conn |= LCD_PCLK_EDGE_RISE;
+		if (vm.flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+			info->lcd_conn |= LCD_PCLK_EDGE_FALL;
+		if (vm.flags & DISPLAY_FLAGS_DE_HIGH)
+			info->lcd_conn |= LCD_BIAS_ACTIVE_HIGH;
+		if (vm.flags & DISPLAY_FLAGS_DE_LOW)
+			info->lcd_conn |= LCD_BIAS_ACTIVE_LOW;
+		if (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH)
+			info->modes[i].sync |= FB_SYNC_HOR_HIGH_ACT;
+		if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
+			info->modes[i].sync |= FB_SYNC_VERT_HIGH_ACT;
+
+		info->modes[i].pixclock = 1000000000UL / (vm.pixelclock / 1000);
+		info->modes[i].xres = vm.hactive;
+		info->modes[i].yres = vm.vactive;
+		info->modes[i].hsync_len = vm.hsync_len;
+		info->modes[i].left_margin = vm.hback_porch;
+		info->modes[i].right_margin = vm.hfront_porch;
+		info->modes[i].vsync_len = vm.vsync_len;
+		info->modes[i].upper_margin = vm.vback_porch;
+		info->modes[i].lower_margin = vm.vfront_porch;
+		info->modes[i].bpp = bpp;
+	}
+	ret = 0;
+
+out:
+	display_timings_release(timings);
+	return ret;
+}
+
+static int of_get_pxafb_mode_info(struct device *dev,
+				  struct pxafb_mach_info *info)
+{
+	struct device_node *display;
+	u32 depth = 0, transparency = 0;
+	int ret, i;
+
+	of_property_read_u32(dev->of_node, "depth", &depth);
+	of_property_read_u32(dev->of_node, "enable-transparency-bit",
+			     &transparency);
+
+	display = of_parse_phandle(dev->of_node, "display", 0);
+	if (!display) {
+		dev_err(dev, "no display defined\n");
+		return -EINVAL;
+	}
+
+	ret = of_get_pxafb_display(dev, display, info);
+	of_node_put(display);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < info->num_modes; i++) {
+		info->modes[i].depth = depth;
+		info->modes[i].transparency = transparency;
+	}
+
+	return 0;
+}
+
+static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
+{
+	int ret;
+	struct pxafb_mach_info *info;
+
+	if (!dev->of_node)
+		return NULL;
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+	ret = of_get_pxafb_mode_info(dev, info);
+	if (ret) {
+		kfree(info->modes);
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * On purpose, neither lccrX registers nor video memory size can be
+	 * specified through device-tree, they are considered more a debug hack
+	 * available through command line.
+	 */
+	return info;
+}
+#else
+static struct pxafb_mach_info *of_pxafb_of_mach_info(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int pxafb_probe(struct platform_device *dev)
 {
 	struct pxafb_info *fbi;
@@ -2104,8 +2252,7 @@ static int pxafb_probe(struct platform_device *dev)
 	ret = -ENOMEM;
 	pdata = dev_get_platdata(&dev->dev);
 	inf = devm_kmalloc(&dev->dev, sizeof(*inf), GFP_KERNEL);
-	if (!inf)
-		goto failed;
+
 	if (pdata) {
 		*inf = *pdata;
 		inf->modes @@ -2117,8 +2264,9 @@ static int pxafb_probe(struct platform_device *dev)
 			inf->modes[i] = pdata->modes[i];
 	}
 
-	fbi = NULL;
 	if (!pdata)
+		inf = of_pxafb_of_mach_info(&dev->dev);
+	if (IS_ERR_OR_NULL(inf))
 		goto failed;
 
 	ret = pxafb_parse_options(&dev->dev, g_options, inf);
@@ -2313,11 +2461,19 @@ static int pxafb_remove(struct platform_device *dev)
 	return 0;
 }
 
+static const struct of_device_id pxafb_of_dev_id[] = {
+	{
+		.compatible = "marvell,pxa2xx-fb",
+	},
+};
+MODULE_DEVICE_TABLE(of, pxafb_of_dev_id);
+
 static struct platform_driver pxafb_driver = {
 	.probe		= pxafb_probe,
 	.remove 	= pxafb_remove,
 	.driver		= {
 		.name	= "pxa2xx-fb",
+		.of_match_table = pxafb_of_dev_id,
 #ifdef CONFIG_PM
 		.pm	= &pxafb_pm_ops,
 #endif
-- 
2.1.4

