From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:28 +0000
Subject: [PATCH 4/6] video: mxsfb: get display timings from device tree
Message-Id: <1363240410-16865-5-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use videomode helpers to get display timings and configurations from
device tree when platform_data is absent.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/fb/mxsfb.txt |   34 +++++++
 drivers/video/Kconfig                          |    2 +
 drivers/video/mxsfb.c                          |  118 ++++++++++++++++++++++--
 3 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/fb/mxsfb.txt b/Documentation/devicetree/bindings/fb/mxsfb.txt
index b41e5e52..7ba3b76 100644
--- a/Documentation/devicetree/bindings/fb/mxsfb.txt
+++ b/Documentation/devicetree/bindings/fb/mxsfb.txt
@@ -5,10 +5,20 @@ Required properties:
   imx23 and imx28.
 - reg: Address and length of the register set for lcdif
 - interrupts: Should contain lcdif interrupts
+- display : phandle to display node (see below for details)
 
 Optional properties:
 - panel-enable-gpios : Should specify the gpio for panel enable
 
+* display node
+
+Required properties:
+- bits-per-pixel : <16> for RGB565, <32> for RGB888/666.
+- bus-width : number of data lines.  Could be <8>, <16>, <18> or <24>.
+
+Required sub-node:
+- display-timings : Refer to binding doc display-timing.txt for details.
+
 Examples:
 
 lcdif@80030000 {
@@ -16,4 +26,28 @@ lcdif@80030000 {
 	reg = <0x80030000 2000>;
 	interrupts = <38 86>;
 	panel-enable-gpios = <&gpio3 30 0>;
+
+	display: display {
+		bits-per-pixel = <32>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency = <33500000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <164>;
+				hback-porch = <89>;
+				hsync-len = <10>;
+				vback-porch = <23>;
+				vfront-porch = <10>;
+				vsync-len = <10>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
 };
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..e7718fd 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2437,6 +2437,8 @@ config FB_MXS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_MODE_HELPERS
+	select OF_VIDEOMODE
 	help
 	  Framebuffer support for the MXS SoC.
 
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 001983a..cf968c6 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -43,12 +43,14 @@
 #include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <video/of_display_timing.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/mxsfb.h>
+#include <video/videomode.h>
 
 #define REG_SET	4
 #define REG_CLR	8
@@ -677,6 +679,97 @@ static int mxsfb_restore_mode(struct mxsfb_info *host)
 	return 0;
 }
 
+static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host)
+{
+	struct fb_info *fb_info = &host->fb_info;
+	struct fb_var_screeninfo *var = &fb_info->var;
+	struct device *dev = &host->pdev->dev;
+	struct device_node *np = host->pdev->dev.of_node;
+	struct device_node *display_np;
+	struct device_node *timings_np;
+	struct display_timings *timings;
+	u32 width;
+	int i;
+	int ret = 0;
+
+	display_np = of_parse_phandle(np, "display", 0);
+	if (!display_np) {
+		dev_err(dev, "failed to find display phandle\n");
+		return -ENOENT;
+	}
+
+	ret = of_property_read_u32(display_np, "bus-width", &width);
+	if (ret < 0) {
+		dev_err(dev, "failed to get property bus-width\n");
+		goto put_display_node;
+	}
+
+	switch (width) {
+	case 8:
+		host->ld_intf_width = STMLCDIF_8BIT;
+		break;
+	case 16:
+		host->ld_intf_width = STMLCDIF_16BIT;
+		break;
+	case 18:
+		host->ld_intf_width = STMLCDIF_18BIT;
+		break;
+	case 24:
+		host->ld_intf_width = STMLCDIF_24BIT;
+		break;
+	default:
+		dev_err(dev, "invalid bus-width value\n");
+		ret = -EINVAL;
+		goto put_display_node;
+	}
+
+	ret = of_property_read_u32(display_np, "bits-per-pixel",
+				   &var->bits_per_pixel);
+	if (ret < 0) {
+		dev_err(dev, "failed to get property bits-per-pixel\n");
+		goto put_display_node;
+	}
+
+	timings = of_get_display_timings(display_np);
+	if (!timings) {
+		dev_err(dev, "failed to get display timings\n");
+		ret = -ENOENT;
+		goto put_display_node;
+	}
+
+	timings_np = of_find_node_by_name(display_np,
+					  "display-timings");
+	if (!timings_np) {
+		dev_err(dev, "failed to find display-timings node\n");
+		ret = -ENOENT;
+		goto put_display_node;
+	}
+
+	for (i = 0; i < of_get_child_count(timings_np); i++) {
+		struct videomode vm;
+		struct fb_videomode fb_vm;
+
+		ret = videomode_from_timing(timings, &vm, i);
+		if (ret < 0)
+			goto put_timings_node;
+		ret = fb_videomode_from_videomode(&vm, &fb_vm);
+		if (ret < 0)
+			goto put_timings_node;
+
+		if (vm.data_flags & DISPLAY_FLAGS_DE_HIGH)
+			fb_vm.sync |= FB_SYNC_DATA_ENABLE_HIGH_ACT;
+		if (vm.data_flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+			fb_vm.sync |= FB_SYNC_DOTCLK_FAILING_ACT;
+		fb_add_videomode(&fb_vm, &fb_info->modelist);
+	}
+
+put_timings_node:
+	of_node_put(timings_np);
+put_display_node:
+	of_node_put(display_np);
+	return ret;
+}
+
 static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 {
 	struct fb_info *fb_info = &host->fb_info;
@@ -685,6 +778,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	dma_addr_t fb_phys;
 	void *fb_virt;
 	unsigned fb_size;
+	int ret;
 
 	fb_info->fbops = &mxsfb_ops;
 	fb_info->flags = FBINFO_FLAG_DEFAULT | FBINFO_READS_FAST;
@@ -694,14 +788,21 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host)
 	fb_info->fix.visual = FB_VISUAL_TRUECOLOR,
 	fb_info->fix.accel = FB_ACCEL_NONE;
 
-	var->bits_per_pixel = pdata->default_bpp ? pdata->default_bpp : 16;
+	if (pdata) {
+		host->ld_intf_width = pdata->ld_intf_width;
+		var->bits_per_pixel +			pdata->default_bpp ? pdata->default_bpp : 16;
+	} else {
+		ret = mxsfb_init_fbinfo_dt(host);
+		if (ret)
+			return ret;
+	}
+
 	var->nonstd = 0;
 	var->activate = FB_ACTIVATE_NOW;
 	var->accel_flags = 0;
 	var->vmode = FB_VMODE_NONINTERLACED;
 
-	host->ld_intf_width = pdata->ld_intf_width;
-
 	/* Memory allocation for framebuffer */
 	fb_size = SZ_2M;
 	fb_virt = alloc_pages_exact(fb_size, GFP_DMA);
@@ -764,11 +865,6 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (of_id)
 		pdev->id_entry = of_id->data;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platformdata. Giving up\n");
-		return -ENODEV;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "Cannot get memory IO resource\n");
@@ -836,8 +932,10 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto fb_release;
 
-	for (i = 0; i < pdata->mode_count; i++)
-		fb_add_videomode(&pdata->mode_list[i], &fb_info->modelist);
+	if (pdata)
+		for (i = 0; i < pdata->mode_count; i++)
+			fb_add_videomode(&pdata->mode_list[i],
+					 &fb_info->modelist);
 
 	modelist = list_first_entry(&fb_info->modelist,
 			struct fb_modelist, list);
-- 
1.7.9.5


