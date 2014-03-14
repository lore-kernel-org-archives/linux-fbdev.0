From: Denis Carikli <denis@eukrea.com>
Date: Fri, 14 Mar 2014 09:12:46 +0000
Subject: [PATCH v7][ 2/5] video: mx3fb: Add device tree suport.
Message-Id: <1394788369-5096-2-git-send-email-denis@eukrea.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
In-Reply-To: <1394788369-5096-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch is based on:
  838bdf7 video: mxsfb: fix broken videomode selection

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
ChangeLog v6->v7:
- Removed the Cc from the patch, they went into 
  git send-email instead.

ChangeLog v5->v6:
- Shrinked the Cc list.
- de-active and pixelclk-active dt properties are
  now handled in this patch to get rid of the
  "fbdev: Add the lacking FB_SYNC_* for matching the DISPLAY_FLAGS_*" patch

ChangeLog v4->v5:
- Added some people in the Cc list.
- The full ipu register range is now passed to the driver,
  the code and the documentation were adapted to it.
- Updated the documentation not to mention the lcd controller, the ipu was
  mentioned instead.
- The ipu patch was removed from this patchset, as a consequence the mx3fb code
  has been adapted not to expect the dma ipu driver to be probed trough the device tree.

ChangeLog v3->v4:
- Updated bindings.
- Updated documentation accordinly.
- Updated code accordinly.
- Fixed the lack of "ret =" in
  of_property_read_string(display_np, "model", &name);
- Supressed some compilation warnings.

ChangeLog v2->v3:
- The device tree bindings were reworked in order to make it look more like the
  IPUv3 bindings.
- The interface_pix_fmt property now looks like the IPUv3 one.
---
 .../devicetree/bindings/video/fsl,mx3-fb.txt       |   44 +++++
 drivers/video/fbdev/Kconfig                        |    2 +
 drivers/video/fbdev/mx3fb.c                        |  185 +++++++++++++++++---
 3 files changed, 208 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,mx3-fb.txt

diff --git a/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
new file mode 100644
index 0000000..c0409a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/fsl,mx3-fb.txt
@@ -0,0 +1,44 @@
+Freescale MX3 IPU.
+=========
+
+Required properties:
+- compatible: Should be "fsl,<chip>-ipu". compatible chips include the imx31 and the
+  imx35.
+- reg: should be register base and length as documented in the datasheet.
+- clocks: Handle to the ipu_gate clock.
+- display: Phandle to a "fsl,mx3-parallel-display" compatible display node
+  which is described below.
+
+Example:
+
+ipu: ipu@53fc0000 {
+	compatible = "fsl,imx35-ipu";
+	reg = <0x53fc0000 0x4000>;
+	clocks = <&clks 55>;
+};
+
+Parallel display support
+============
+
+Required properties:
+- compatible: Should be "fsl,mx3-parallel-display".
+- model : The user-visible name of the display.
+
+Optional properties:
+- interface_pix_fmt: How this display is connected to the
+  crtc. Currently supported types: "rgb24", "rgb565", "rgb666".
+
+It can also have an optional timing subnode as described in
+  Documentation/devicetree/bindings/video/display-timing.txt.
+
+Example:
+
+display0: display@di0 {
+	compatible = "fsl,mx3-parallel-display";
+	interface-pix-fmt = "rgb666";
+	model = "CMO-QVGA";
+};
+
+&ipu {
+	display = <&display0>;
+}
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 67409e0..c996b96 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2330,6 +2330,8 @@ config FB_MX3
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS
+	select FB_MODE_HELPERS
 	default y
 	help
 	  This is a framebuffer device for the i.MX31 LCD Controller. So
diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index ee95de8..952d2b5 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -31,6 +31,10 @@
 #include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/video-mx3fb.h>
 
+#include <video/of_display_timing.h>
+#include <video/of_videomode.h>
+#include <video/videomode.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -237,6 +241,8 @@ static const struct fb_videomode mx3fb_modedb[] = {
 
 struct mx3fb_data {
 	struct fb_info		*fbi;
+	struct videomode	*vm;
+	struct fb_videomode	*fb_vm;
 	int			backlight_level;
 	void __iomem		*reg_base;
 	spinlock_t		lock;
@@ -269,6 +275,7 @@ struct mx3fb_info {
 	struct scatterlist		sg[2];
 
 	struct fb_var_screeninfo	cur_var; /* current var info */
+	uint32_t			flags;
 };
 
 static void mx3fb_dma_done(void *);
@@ -753,16 +760,32 @@ static int __set_par(struct fb_info *fbi, bool lock)
 
 	if (mx3_fbi->ipu_ch = IDMAC_SDC_0) {
 		memset(&sig_cfg, 0, sizeof(sig_cfg));
+
 		if (fbi->var.sync & FB_SYNC_HOR_HIGH_ACT)
 			sig_cfg.Hsync_pol = true;
+
 		if (fbi->var.sync & FB_SYNC_VERT_HIGH_ACT)
 			sig_cfg.Vsync_pol = true;
-		if (fbi->var.sync & FB_SYNC_CLK_INVERT)
-			sig_cfg.clk_pol = true;
+
+		if (fbi->device->of_node) {
+			if (mx3_fbi->flags & FB_SYNC_CLK_INVERT)
+				sig_cfg.clk_pol = true;
+		} else {
+			if (fbi->var.sync & FB_SYNC_CLK_INVERT)
+				sig_cfg.clk_pol = true;
+		}
+
 		if (fbi->var.sync & FB_SYNC_DATA_INVERT)
 			sig_cfg.data_pol = true;
-		if (fbi->var.sync & FB_SYNC_OE_ACT_HIGH)
-			sig_cfg.enable_pol = true;
+
+		if (fbi->device->of_node) {
+			if (mx3_fbi->flags & FB_SYNC_OE_ACT_HIGH)
+				sig_cfg.enable_pol = true;
+		} else {
+			if (fbi->var.sync & FB_SYNC_OE_ACT_HIGH)
+				sig_cfg.enable_pol = true;
+		}
+
 		if (fbi->var.sync & FB_SYNC_CLK_IDLE_EN)
 			sig_cfg.clkidle_en = true;
 		if (fbi->var.sync & FB_SYNC_CLK_SEL_EN)
@@ -1266,7 +1289,8 @@ static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len,
 						  &addr, GFP_DMA | GFP_KERNEL);
 
 	if (!fbi->screen_base) {
-		dev_err(fbi->device, "Cannot allocate %u bytes framebuffer memory\n",
+		dev_err(fbi->device,
+			"Cannot allocate %u bytes framebuffer memory\n",
 			mem_len);
 		retval = -EBUSY;
 		goto err0;
@@ -1280,7 +1304,8 @@ static int mx3fb_map_video_memory(struct fb_info *fbi, unsigned int mem_len,
 		mutex_unlock(&fbi->mm_lock);
 
 	dev_dbg(fbi->device, "allocated fb @ p=0x%08x, v=0x%p, size=%d.\n",
-		(uint32_t) fbi->fix.smem_start, fbi->screen_base, fbi->fix.smem_len);
+		(uint32_t) fbi->fix.smem_start,
+		fbi->screen_base, fbi->fix.smem_len);
 
 	fbi->screen_size = fbi->fix.smem_len;
 
@@ -1351,21 +1376,68 @@ static struct fb_info *mx3fb_init_fbinfo(struct device *dev, struct fb_ops *ops)
 	return fbi;
 }
 
+static int match_dt_disp_data(const char *property)
+{
+	if (!strcmp("rgb666", property))
+		return IPU_DISP_DATA_MAPPING_RGB666;
+	else if (!strcmp("rgb565", property))
+		return IPU_DISP_DATA_MAPPING_RGB565;
+	else if (!strcmp("rgb24", property))
+		return IPU_DISP_DATA_MAPPING_RGB888;
+	else
+		return -EINVAL;
+}
+
 static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 {
 	struct device *dev = mx3fb->dev;
 	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
-	const char *name = mx3fb_pdata->name;
+	struct device_node *np = dev->of_node;
+	const char *name;
+	const char *ipu_disp_format;
 	unsigned int irq;
 	struct fb_info *fbi;
 	struct mx3fb_info *mx3fbi;
 	const struct fb_videomode *mode;
 	int ret, num_modes;
+	struct device_node *display_np = NULL;
+
+	if (np) {
+		display_np = of_parse_phandle(np, "display", 0);
+		if (!display_np) {
+			dev_err(dev, "Can't get the display device node.\n");
+			return -EINVAL;
+		}
+
+		of_property_read_string(display_np, "interface-pix-fmt",
+					&ipu_disp_format);
+		if (!ipu_disp_format) {
+			mx3fb->disp_data_fmt = IPU_DISP_DATA_MAPPING_RGB666;
+			dev_warn(dev,
+				"ipu display data mapping was not defined, using the default rgb666.\n");
+		} else {
+			mx3fb->disp_data_fmt +				match_dt_disp_data(ipu_disp_format);
+		}
 
-	if (mx3fb_pdata->disp_data_fmt >= ARRAY_SIZE(di_mappings)) {
-		dev_err(dev, "Illegal display data format %d\n",
+		if (mx3fb->disp_data_fmt = -EINVAL) {
+			dev_err(dev, "Illegal display data format \"%s\"\n",
+				ipu_disp_format);
+			return -EINVAL;
+		}
+
+		ret = of_property_read_string(display_np, "model", &name);
+		if (ret) {
+			dev_err(dev, "Missing display model name\n");
+			return -EINVAL;
+		}
+	} else {
+		name = mx3fb_pdata->name;
+		if (mx3fb_pdata->disp_data_fmt >= ARRAY_SIZE(di_mappings)) {
+			dev_err(dev, "Illegal display data format %d\n",
 				mx3fb_pdata->disp_data_fmt);
-		return -EINVAL;
+			return -EINVAL;
+		}
 	}
 
 	ichan->client = mx3fb;
@@ -1386,12 +1458,36 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 		goto emode;
 	}
 
-	if (mx3fb_pdata->mode && mx3fb_pdata->num_modes) {
-		mode = mx3fb_pdata->mode;
-		num_modes = mx3fb_pdata->num_modes;
+	mx3fbi = fbi->par;
+
+	if (np) {
+		ret = of_get_videomode(display_np, mx3fb->vm,
+				       OF_USE_NATIVE_MODE);
+		if (ret) {
+			dev_err(dev, "failed to get videomode from DT\n");
+			goto put_display_node;
+		}
+
+		ret = fb_videomode_from_videomode(mx3fb->vm, mx3fb->fb_vm);
+		if (ret < 0)
+			goto put_display_node;
+
+		if (mx3fb->vm->flags & DISPLAY_FLAGS_DE_HIGH)
+			mx3fbi->flags |= FB_SYNC_OE_ACT_HIGH;
+
+		if (mx3fb->vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
+			mx3fbi->flags |= FB_SYNC_CLK_INVERT;
+
+		mode = mx3fb->fb_vm;
+		num_modes = 1;
 	} else {
-		mode = mx3fb_modedb;
-		num_modes = ARRAY_SIZE(mx3fb_modedb);
+		if (mx3fb_pdata->mode && mx3fb_pdata->num_modes) {
+			mode = mx3fb_pdata->mode;
+			num_modes = mx3fb_pdata->num_modes;
+		} else {
+			mode = mx3fb_modedb;
+			num_modes = ARRAY_SIZE(mx3fb_modedb);
+		}
 	}
 
 	if (!fb_find_mode(&fbi->var, fbi, fb_mode, mode,
@@ -1415,13 +1511,13 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 	sdc_set_global_alpha(mx3fb, true, 0xFF);
 	sdc_set_color_key(mx3fb, IDMAC_SDC_0, false, 0);
 
-	mx3fbi			= fbi->par;
 	mx3fbi->idmac_channel	= ichan;
 	mx3fbi->ipu_ch		= ichan->dma_chan.chan_id;
 	mx3fbi->mx3fb		= mx3fb;
 	mx3fbi->blank		= FB_BLANK_NORMAL;
 
-	mx3fb->disp_data_fmt	= mx3fb_pdata->disp_data_fmt;
+	if (!np)
+		mx3fb->disp_data_fmt = mx3fb_pdata->disp_data_fmt;
 
 	init_completion(&mx3fbi->flip_cmpl);
 	disable_irq(ichan->eof_irq);
@@ -1440,6 +1536,8 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
 
 	return 0;
 
+put_display_node:
+	of_node_put(display_np);
 erfb:
 esetpar:
 emode:
@@ -1455,17 +1553,21 @@ static bool chan_filter(struct dma_chan *chan, void *arg)
 	struct device *dev;
 	struct mx3fb_platform_data *mx3fb_pdata;
 
-	if (!imx_dma_is_ipu(chan))
-		return false;
-
 	if (!rq)
 		return false;
 
 	dev = rq->mx3fb->dev;
 	mx3fb_pdata = dev_get_platdata(dev);
 
-	return rq->id = chan->chan_id &&
-		mx3fb_pdata->dma_dev = chan->device->dev;
+	if (!imx_dma_is_ipu(chan) && mx3fb_pdata)
+		return false;
+
+	/* When using the devicetree, mx3fb_pdata is NULL */
+	if (mx3fb_pdata)
+		return rq->id = chan->chan_id &&
+			mx3fb_pdata->dma_dev = chan->device->dev;
+	else
+		return rq->id = chan->chan_id;
 }
 
 static void release_fbi(struct fb_info *fbi)
@@ -1487,6 +1589,9 @@ static int mx3fb_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
 	struct dma_chan_request rq;
+	struct device_node *np = dev->of_node;
+	struct videomode *vm;
+	struct fb_videomode *fb_vm;
 
 	/*
 	 * Display Interface (DI) and Synchronous Display Controller (SDC)
@@ -1508,7 +1613,33 @@ static int mx3fb_probe(struct platform_device *pdev)
 		goto eremap;
 	}
 
-	pr_debug("Remapped %pR at %p\n", sdc_reg, mx3fb->reg_base);
+	/* The full IPU registers range is passed by the device tree,
+	 * whereas the platform data only passes the SDC registers range.
+	 */
+	if (np) {
+		vm = devm_kzalloc(&pdev->dev, sizeof(struct videomode),
+				  GFP_KERNEL);
+		if (!vm) {
+			ret = -ENOMEM;
+			goto eremap;
+		}
+
+		fb_vm = devm_kzalloc(&pdev->dev, sizeof(struct fb_videomode),
+				     GFP_KERNEL);
+		if (!fb_vm) {
+			ret = -ENOMEM;
+			goto eremap;
+		}
+
+		mx3fb->vm = vm;
+		mx3fb->fb_vm = fb_vm;
+
+		mx3fb->reg_base += MX3FB_REG_OFFSET;
+		pr_debug("Remapped %pR at %p\n", sdc_reg + MX3FB_REG_OFFSET,
+			 mx3fb->reg_base);
+	} else {
+		pr_debug("Remapped %pR at %p\n", sdc_reg, mx3fb->reg_base);
+	}
 
 	/* IDMAC interface */
 	dmaengine_get();
@@ -1563,9 +1694,17 @@ static int mx3fb_remove(struct platform_device *dev)
 	return 0;
 }
 
+static struct of_device_id mx3fb_of_dev_id[] = {
+	{ .compatible = "fsl,imx31-ipu", },
+	{ .compatible = "fsl,imx35-ipu", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mx3fb_of_dev_id);
+
 static struct platform_driver mx3fb_driver = {
 	.driver = {
 		.name = MX3FB_NAME,
+		.of_match_table = mx3fb_of_dev_id,
 		.owner = THIS_MODULE,
 	},
 	.probe = mx3fb_probe,
-- 
1.7.9.5

