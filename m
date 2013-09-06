From: Pawel Moll <pawel.moll@arm.com>
Date: Fri, 06 Sep 2013 17:23:20 +0000
Subject: [PATCH 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378488201-21146-1-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds basic DT bindings for the PL11x CLCD cells
and make their fbdev driver use them.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 .../devicetree/bindings/video/arm,pl11x.txt        |  87 +++++++++
 drivers/video/Kconfig                              |   1 +
 drivers/video/amba-clcd.c                          | 214 +++++++++++++++++++++
 3 files changed, 302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/arm,pl11x.txt

diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
new file mode 100644
index 0000000..178aebb
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
@@ -0,0 +1,87 @@
+* ARM PrimeCell Color LCD Controller (CLCD) PL110/PL111
+
+See also Documentation/devicetree/bindings/arm/primecell.txt
+
+Required properties:
+
+- compatible: must be one of:
+			"arm,pl110", "arm,primecell"
+			"arm,pl111", "arm,primecell"
+- reg: base address and size of the control registers block
+- interrupts: either a single interrupt specifier representing the
+		combined interrupt output (CLCDINTR) or an array of
+		four interrupt specifiers for CLCDMBEINTR,
+		CLCDVCOMPINTR, CLCDLNBUINTR, CLCDFUFINTR; in the
+		latter case interrupt names must be specified
+		(see below)
+- interrupt-names: when four interrupts are specified, their names:
+			"mbe", "vcomp", "lnbu", "fuf"
+			must be specified in order respective to the
+			interrupt specifiers
+- clocks: contains phandle and clock specifier pairs for the entries
+		in the clock-names property. See
+		Documentation/devicetree/binding/clock/clock-bindings.txt
+- clocks names: should contain "clcdclk" and "apb_pclk"
+
+Optional properties:
+
+- video-ram: phandle to a node describing specialized video memory
+		(that is *not* described in the top level "memory" node)
+                that must be used as a framebuffer, eg. due to restrictions
+		of the system interconnect; the node must contain a
+		standard reg property describing the address and the size
+		of the memory area
+- max-framebuffer-size: maximum size in bytes of the framebuffer the
+			system can handle, eg. in terms of available
+			memory bandwidth
+
+In the simplest case of a display panel being connected directly to the
+CLCD, it can be described in the node:
+
+- panel-dimensions: (optional) array of two numbers (width and height)
+			describing physical dimension in mm of the panel
+- panel-type: (required) must be "tft" or "stn", defines panel type
+- panel-tft-interface: (for "tft" panel type) array of 3 numbers defining
+			widths in bits of the R, G and B components
+- panel-tft-rb-swapped: (for "tft" panel type) if present means that
+			the R & B components are swapped on the board
+- panel-stn-color: (for "stn" panel type) if present means that
+			the panel is a colour STN display, if missing
+			is a monochrome display
+- panel-stn-dual: (for "stn" panel type) if present means that there
+			are two STN displays connected
+- panel-stn-4bit: (for monochrome "stn" panel) if present means
+			that the monochrome display is connected
+			via 4 bit-wide interface
+- display-timings: standard display timings sub-node, see
+			Documentation/devicetree/bindings/video/display-timing.txt
+
+Example:
+
+			clcd@1f0000 {
+				compatible = "arm,pl111", "arm,primecell";
+				reg = <0x1f0000 0x1000>;
+				interrupts = <14>;
+				clocks = <&v2m_oscclk1>, <&smbclk>;
+				clock-names = "clcdclk", "apb_pclk";
+
+				video-ram = <&v2m_vram>;
+				max-framebuffer-size = <614400>; /* 640x480 16bpp */
+
+				panel-type = "tft";
+				panel-tft-interface = <8 8 8>;
+				display-timings {
+					native-mode = <&v2m_clcd_timing0>;
+					v2m_clcd_timing0: vga {
+						clock-frequency = <25175000>;
+						hactive = <640>;
+						hback-porch = <40>;
+						hfront-porch = <24>;
+						hsync-len = <96>;
+						vactive = <480>;
+						vback-porch = <32>;
+						vfront-porch = <11>;
+						vsync-len = <2>;
+					};
+				};
+			};
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4cf1e1d..375bf63 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -316,6 +316,7 @@ config FB_ARMCLCD
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VIDEOMODE_HELPERS if OF
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 0a2cce7..145ca5a 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -25,6 +25,11 @@
 #include <linux/amba/clcd.h>
 #include <linux/clk.h>
 #include <linux/hardirq.h>
+#include <linux/dma-mapping.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <video/of_display_timing.h>
+#include <video/of_videomode.h>
 
 #include <asm/sizes.h>
 
@@ -542,6 +547,212 @@ static int clcdfb_register(struct clcd_fb *fb)
 	return ret;
 }
 
+#ifdef CONFIG_OF
+static int clcdfb_of_get_tft_panel(struct device_node *node,
+		struct clcd_panel *panel)
+{
+	int err;
+	u32 rgb[3];
+	int r, g, b;
+
+	err = of_property_read_u32_array(node, "panel-tft-interface", rgb, 3);
+	if (err)
+		return err;
+
+	r = rgb[0];
+	g = rgb[1];
+	b = rgb[2];
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
+	if (of_get_property(node, "panel-tft-rb-swapped", NULL))
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
+	u32 max_size;
+	u32 dimensions[2];
+	char *mode_name;
+	int len, err;
+	const char *panel_type;
+
+	fb->panel = devm_kzalloc(&fb->dev->dev, sizeof(*fb->panel), GFP_KERNEL);
+	if (!fb->panel)
+		return -ENOMEM;
+
+	err = of_get_fb_videomode(fb->dev->dev.of_node, &fb->panel->mode,
+			OF_USE_NATIVE_MODE);
+	if (err)
+		return err;
+
+	len = snprintf(NULL, 0, "%ux%u@%u", fb->panel->mode.xres,
+			fb->panel->mode.yres, fb->panel->mode.refresh);
+	mode_name = devm_kzalloc(&fb->dev->dev, len + 1, GFP_KERNEL);
+	snprintf(mode_name, len + 1, "%ux%u@%u", fb->panel->mode.xres,
+			fb->panel->mode.yres, fb->panel->mode.refresh);
+	fb->panel->mode.name = mode_name;
+
+	err = of_property_read_u32(node, "max-framebuffer-size", &max_size);
+	if (!err)
+		fb->panel->bpp = max_size / (fb->panel->mode.xres *
+				fb->panel->mode.yres) * 8;
+	else
+		fb->panel->bpp = 32;
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	fb->panel->cntl |= CNTL_BEBO;
+#endif
+
+	if (of_property_read_u32_array(node, "panel-dimensions",
+			dimensions, 2) == 0) {
+		fb->panel->width = dimensions[0];
+		fb->panel->height = dimensions[1];
+	} else {
+		fb->panel->width = -1;
+		fb->panel->height = -1;
+	}
+
+	panel_type = of_get_property(node, "panel-type", &len);
+	if (strncmp(panel_type, "tft", len) == 0)
+		return clcdfb_of_get_tft_panel(node, fb->panel);
+	else
+		return -EINVAL;
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
+	board->name = of_node_full_name(node);
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
@@ -549,6 +760,9 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	int ret;
 
 	if (!board)
+		board = clcdfb_of_get_board(dev);
+
+	if (!board)
 		return -EINVAL;
 
 	ret = amba_request_regions(dev, NULL);
-- 
1.8.1.2


