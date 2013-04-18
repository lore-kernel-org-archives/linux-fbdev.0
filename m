From: Pawel Moll <pawel.moll@arm.com>
Date: Thu, 18 Apr 2013 17:33:21 +0000
Subject: [RFC v2] video: ARM CLCD: Add DT & CDF support
Message-Id: <1366306402-21651-1-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130418102444.GL14496@n2100.arm.linux.org.uk>
In-Reply-To: <20130418102444.GL14496@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Pawel Moll <pawel.moll@arm.com>

This patch adds basic DT bindings for the PL11x CLCD cells
and make their fbdev driver use them, together with the
Common Display Framework.

The DT provides information about the hardware configuration
and limitations (eg. the largest supported resolution)
but the video modes come exclusively from the Common
Display Framework drivers, referenced to by the standard CDF
binding.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 .../devicetree/bindings/video/arm,pl11x.txt        |   35 +++
 drivers/video/Kconfig                              |    1 +
 drivers/video/amba-clcd.c                          |  247 ++++++++++++++++++++
 include/linux/amba/clcd.h                          |    2 +
 4 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/arm,pl11x.txt

diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
new file mode 100644
index 0000000..ee9534a
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
@@ -0,0 +1,35 @@
+* ARM PrimeCell Color LCD Controller (CLCD) PL110/PL111
+
+Required properties:
+
+- compatible : must be one of:
+			"arm,pl110", "arm,primecell"
+			"arm,pl111", "arm,primecell"
+- reg : base address and size of the control registers block
+- interrupts : the combined interrupt
+- clocks : phandles to the CLCD (pixel) clock and the APB clocks
+- clock-names : "clcdclk", "apb_pclk"
+- display : phandle to the display entity connected to the controller
+
+Optional properties:
+
+- label : string describing the controller location and/or usage
+- video-ram : phandle to DT node of the specialized video RAM to be used
+- max-hactive : maximum frame buffer width in pixels
+- max-vactive : maximum frame buffer height in pixels
+- max-bpp : maximum number of bits per pixel
+- big-endian-pixels : defining this property makes the pixel bytes being
+			accessed in Big Endian organization
+
+Example:
+
+			clcd@1f0000 {
+				compatible = "arm,pl111", "arm,primecell";
+				reg = <0x1f0000 0x1000>;
+				interrupts = <14>;
+				clocks = <&v2m_oscclk1>, <&smbclk>;
+				clock-names = "clcdclk", "apb_pclk";
+				label = "IOFPGA CLCD";
+				video-ram = <&v2m_vram>;
+				display = <&v2m_muxfpga>;
+			};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 281e548..bad8166 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -340,6 +340,7 @@ config FB_ARMCLCD
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_MODE_HELPERS if OF
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 0a2cce7..853f74c 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -25,6 +25,11 @@
 #include <linux/amba/clcd.h>
 #include <linux/clk.h>
 #include <linux/hardirq.h>
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <video/display.h>
+#include <video/videomode.h>
 
 #include <asm/sizes.h>
 
@@ -62,6 +67,10 @@ static void clcdfb_disable(struct clcd_fb *fb)
 {
 	u32 val;
 
+	if (fb->panel->display)
+		display_entity_set_state(fb->panel->display,
+				DISPLAY_ENTITY_STATE_OFF);
+
 	if (fb->board->disable)
 		fb->board->disable(fb);
 
@@ -115,6 +124,11 @@ static void clcdfb_enable(struct clcd_fb *fb, u32 cntl)
 	 */
 	if (fb->board->enable)
 		fb->board->enable(fb);
+
+	if (fb->panel->display)
+		display_entity_set_state(fb->panel->display,
+				DISPLAY_ENTITY_STATE_ON);
+
 }
 
 static int
@@ -304,6 +318,13 @@ static int clcdfb_set_par(struct fb_info *info)
 
 	clcdfb_enable(fb, regs.cntl);
 
+	if (fb->panel->display) {
+		struct videomode mode;
+
+		videomode_from_fb_var_screeninfo(&fb->fb.var, &mode);
+		display_entity_update(fb->panel->display, &mode);
+	}
+
 #ifdef DEBUG
 	printk(KERN_INFO
 	       "CLCD: Registers set to\n"
@@ -542,6 +563,229 @@ static int clcdfb_register(struct clcd_fb *fb)
 	return ret;
 }
 
+#if defined(CONFIG_OF)
+static int clcdfb_of_get_tft_parallel_panel(struct clcd_panel *panel,
+		struct display_entity_interface_params *params)
+{
+	int r = params->p.tft_parallel.r_bits;
+	int g = params->p.tft_parallel.g_bits;
+	int b = params->p.tft_parallel.b_bits;
+
+	/* Bypass pixel clock divider, data output on the falling edge */
+	panel->tim2 = TIM2_BCD | TIM2_IPC;
+
+	/* TFT display, vert. comp. interrupt at the start of the back porch */
+	panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
+
+	if (r >= 4 && g >= 4 && b >= 4)
+		panel->caps |= CLCD_CAP_444;
+	if (r >= 5 && g >= 5 && b >= 5)
+		panel->caps |= CLCD_CAP_5551;
+	if (r >= 5 && g >= 6 && b >= 5)
+		panel->caps |= CLCD_CAP_565;
+	if (r >= 8 && g >= 8 && b >= 8)
+		panel->caps |= CLCD_CAP_888;
+
+	if (params->p.tft_parallel.r_b_swapped)
+		panel->caps &= ~CLCD_CAP_RGB;
+	else
+		panel->caps &= ~CLCD_CAP_BGR;
+
+	return 0;
+}
+
+static int clcdfb_of_init_display(struct clcd_fb *fb)
+{
+	struct device_node *node = fb->dev->dev.of_node;
+	struct display_entity_interface_params params;
+	const struct videomode *modes;
+	int modes_num;
+	int best_mode = -1;
+	u32 max_bpp = 32;
+	u32 max_hactive = (u32)~0UL;
+	u32 max_vactive = (u32)~0UL;
+	unsigned int width, height;
+	char *mode_name;
+	int i, err;
+
+	fb->panel = devm_kzalloc(&fb->dev->dev, sizeof(*fb->panel), GFP_KERNEL);
+	if (!fb->panel)
+		return -ENOMEM;
+
+	fb->panel->display = of_display_entity_get(node, 0);
+	if (!fb->panel->display)
+		return -EPROBE_DEFER;
+
+	modes_num = display_entity_get_modes(fb->panel->display, &modes);
+	if (modes_num < 0)
+		return modes_num;
+
+	/* Pick the "best" (the widest, then the highest) mode from the list */
+	of_property_read_u32(node, "max-hactive", &max_hactive);
+	of_property_read_u32(node, "max-vactive", &max_vactive);
+	for (i = 0; i < modes_num; i++) {
+		if (modes[i].hactive > max_hactive ||
+				modes[i].vactive > max_vactive)
+			continue;
+		if (best_mode < 0 ||
+				(modes[i].hactive >= modes[best_mode].hactive &&
+				modes[i].vactive > modes[best_mode].vactive))
+			best_mode = i;
+	}
+	if (best_mode < 0)
+		return -ENODEV;
+
+	err = fb_videomode_from_videomode(&modes[best_mode], &fb->panel->mode);
+	if (err)
+		return err;
+
+	i = snprintf(NULL, 0, "%ux%u@%u", fb->panel->mode.xres,
+			fb->panel->mode.yres, fb->panel->mode.refresh);
+	mode_name = devm_kzalloc(&fb->dev->dev, i + 1, GFP_KERNEL);
+	snprintf(mode_name, i + 1, "%ux%u@%u", fb->panel->mode.xres,
+			fb->panel->mode.yres, fb->panel->mode.refresh);
+	fb->panel->mode.name = mode_name;
+
+	of_property_read_u32(node, "max-bpp", &max_bpp);
+	fb->panel->bpp = max_bpp;
+
+	if (of_property_read_bool(node, "big-endian-pixels"))
+		fb->panel->cntl |= CNTL_BEBO;
+
+	if (display_entity_get_size(fb->panel->display, &width, &height) != 0)
+		width = height = -1;
+	fb->panel->width = width;
+	fb->panel->height = height;
+
+	err = display_entity_get_params(fb->panel->display, &params);
+	if (err)
+		return err;
+
+	switch (params.type) {
+	case DISPLAY_ENTITY_INTERFACE_TFT_PARALLEL:
+		return clcdfb_of_get_tft_parallel_panel(fb->panel, &params);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int clcdfb_of_vram_setup(struct clcd_fb *fb)
+{
+	const __be32 *prop = of_get_property(fb->dev->dev.of_node, "video-ram",
+			NULL);
+	struct device_node *node = of_find_node_by_phandle(be32_to_cpup(prop));
+	u64 size;
+	int err;
+
+	if (!node)
+		return -ENODEV;
+
+	err = clcdfb_of_init_display(fb);
+	if (err)
+		return err;
+
+	fb->fb.screen_base = of_iomap(node, 0);
+	if (!fb->fb.screen_base)
+		return -ENOMEM;
+
+	fb->fb.fix.smem_start = of_translate_address(node,
+			of_get_address(node, 0, &size, NULL));
+	fb->fb.fix.smem_len = size;
+
+	return 0;
+}
+
+static int clcdfb_of_vram_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
+{
+	unsigned long off, user_size, kernel_size;
+
+	off = vma->vm_pgoff << PAGE_SHIFT;
+	user_size = vma->vm_end - vma->vm_start;
+	kernel_size = fb->fb.fix.smem_len;
+
+	if (off >= kernel_size || user_size > (kernel_size - off))
+		return -ENXIO;
+
+	return remap_pfn_range(vma, vma->vm_start,
+			__phys_to_pfn(fb->fb.fix.smem_start) + vma->vm_pgoff,
+			user_size,
+			pgprot_writecombine(vma->vm_page_prot));
+}
+
+static void clcdfb_of_vram_remove(struct clcd_fb *fb)
+{
+	iounmap(fb->fb.screen_base);
+}
+
+static int clcdfb_of_dma_setup(struct clcd_fb *fb)
+{
+	unsigned long framesize;
+	dma_addr_t dma;
+	int err;
+
+	err = clcdfb_of_init_display(fb);
+	if (err)
+		return err;
+
+	framesize = fb->panel->mode.xres * fb->panel->mode.yres *
+			fb->panel->bpp / 8;
+	fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev, framesize,
+			&dma, GFP_KERNEL);
+	if (!fb->fb.screen_base)
+		return -ENOMEM;
+
+	fb->fb.fix.smem_start = dma;
+	fb->fb.fix.smem_len = framesize;
+
+	return 0;
+}
+
+static int clcdfb_of_dma_mmap(struct clcd_fb *fb, struct vm_area_struct *vma)
+{
+	return dma_mmap_writecombine(&fb->dev->dev, vma, fb->fb.screen_base,
+			fb->fb.fix.smem_start, fb->fb.fix.smem_len);
+}
+
+static void clcdfb_of_dma_remove(struct clcd_fb *fb)
+{
+	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
+			fb->fb.screen_base, fb->fb.fix.smem_start);
+}
+
+static struct clcd_board *clcdfb_of_get_board(struct amba_device *dev)
+{
+	struct clcd_board *board = devm_kzalloc(&dev->dev, sizeof(*board),
+			GFP_KERNEL);
+	struct device_node *node = dev->dev.of_node;
+
+	if (!board)
+		return NULL;
+
+	board->name = of_get_property(node, "label", NULL);
+	if (!board->name)
+		board->name = of_node_full_name(node);
+	board->caps = CLCD_CAP_ALL;
+	board->check = clcdfb_check;
+	board->decode = clcdfb_decode;
+	if (of_find_property(node, "video-ram", NULL)) {
+		board->setup = clcdfb_of_vram_setup;
+		board->mmap = clcdfb_of_vram_mmap;
+		board->remove = clcdfb_of_vram_remove;
+	} else {
+		board->setup = clcdfb_of_dma_setup;
+		board->mmap = clcdfb_of_dma_mmap;
+		board->remove = clcdfb_of_dma_remove;
+	}
+
+	return board;
+}
+#else
+static struct clcd_board *clcdfb_of_get_board(struct amba_dev *dev)
+{
+	return NULL;
+}
+#endif
+
 static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 {
 	struct clcd_board *board = dev->dev.platform_data;
@@ -549,6 +793,9 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	int ret;
 
 	if (!board)
+		board = clcdfb_of_get_board(dev);
+
+	if (!board)
 		return -EINVAL;
 
 	ret = amba_request_regions(dev, NULL);
diff --git a/include/linux/amba/clcd.h b/include/linux/amba/clcd.h
index e82e3ee..73b199b 100644
--- a/include/linux/amba/clcd.h
+++ b/include/linux/amba/clcd.h
@@ -10,6 +10,7 @@
  * for more details.
  */
 #include <linux/fb.h>
+#include <video/display.h>
 
 /*
  * CLCD Controller Internal Register addresses
@@ -105,6 +106,7 @@ struct clcd_panel {
 				fixedtimings:1,
 				grayscale:1;
 	unsigned int		connector;
+	struct display_entity	*display;
 };
 
 struct clcd_regs {
-- 
1.7.10.4


