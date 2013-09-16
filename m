From: Pawel Moll <pawel.moll@arm.com>
Date: Mon, 16 Sep 2013 17:18:53 +0000
Subject: [PATCH v3 1/2] video: ARM CLCD: Add DT support
Message-Id: <1379351934-25415-1-git-send-email-pawel.moll@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds basic DT bindings for the PL11x CLCD controllers
and make their fbdev driver use them (initially only TFT panels
are supported).

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
Changes since v2:
- replaced video-ram phandle with arm,pl11x,framebuffer-base
- replaced panel-* properties with arm,pl11x,panel-data-pads
- replaced max-framebuffer-size with max-memory-bandwidth
- modified clcdfb_of_init_tft_panel() to use the pads
  data and take differences between PL110 and PL110 into
  account

Changes since v1:
- minor code cleanups as suggested by Sylwester Nawrocki
 .../devicetree/bindings/video/arm,pl11x.txt        | 145 +++++++++++
 drivers/video/Kconfig                              |   1 +
 drivers/video/amba-clcd.c                          | 268 +++++++++++++++++++++
 3 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/arm,pl11x.txt

diff --git a/Documentation/devicetree/bindings/video/arm,pl11x.txt b/Documentation/devicetree/bindings/video/arm,pl11x.txt
new file mode 100644
index 0000000..418ee06
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/arm,pl11x.txt
@@ -0,0 +1,145 @@
+* ARM PrimeCell Color LCD Controller PL110/PL111
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
+- arm,pl11x,panel-data-pads: array of 24 cells, each of them describing
+				a function of one of the CLD pads,
+				starting from 0 up to 23; each pad can
+				be described by one of the following values:
+	- 0: reserved (not connected)
+	- 0x100-0x107: color upper STN panel data 0 to 7
+	- 0x110-0x117: color lower STN panel data 0 to 7
+	- 0x200-0x207: mono upper STN panel data 0 to 7
+	- 0x210-0x217: mono lower STN panel data 0 to 7
+	- 0x300-0x307: red component bit 0 to 7 of TFT panel data
+	- 0x310-0x317: green component bit 0 to 7 of TFT panel data
+	- 0x320-0x327: blue component bit 0 to 7 of TFT panel data
+	- 0x330: intensity bit of TFT panel data
+				Example sets of values for standard
+				panel interfaces:
+	- PL110 single colour STN panel:
+			<0x107 0x106 0x105 0x104 0x103 0x102 0x101 0x100>,
+			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL110 dual colour STN panel:
+			<0x107 0x106 0x105 0x104 0x103 0x102 0x101 0x100>,
+			<0x117 0x116 0x115 0x114 0x113 0x112 0x111 0x110>,
+			<0 0 0 0 0 0 0 0>;
+	- PL110 single mono 4-bit STN panel:
+			<0x203 0x202 0x201 0x200>,
+			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL110 dual mono 4-bit STN panel:
+			<0x203 0x202 0x201 0x200>, <0 0 0 0>,
+			<0x213 0x212 0x211 0x210>,
+			<0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL110 single mono 8-bit STN panel:
+			<0x207 0x206 0x205 0x204 0x203 0x202 0x201 0x200>,
+			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL110 dual mono 8-bit STN panel:
+			<0x207 0x206 0x205 0x204 0x203 0x202 0x201 0x200>,
+			<0x217 0x216 0x215 0x214 0x213 0x212 0x211 0x210>,
+			<0 0 0 0 0 0 0 0>;
+	- PL110 TFT (1:)5:5:5 panel:
+			<0x330 0x300 0x301 0x302 0x303 0x304>,
+			<0x330 0x310 0x311 0x312 0x313 0x314>,
+			<0x330 0x320 0x321 0x322 0x323 0x324>,
+			<0 0 0 0 0 0>
+	- PL110 and PL111 TFT RGB 888 panel:
+			<0x300 0x301 0x302 0x303 0x304 0x305 0x306 0x307>,
+			<0x310 0x311 0x312 0x313 0x314 0x315 0x316 0x317>,
+			<0x320 0x321 0x322 0x323 0x324 0x325 0x326 0x327>;
+	- PL111 single colour STN panel:
+			<0x100 0x101 0x102 0x103 0x104 0x105 0x106 0x107>,
+			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL111 dual colour STN panel:
+			<0x100 0x101 0x102 0x103 0x104 0x105 0x106 0x107>,
+			<0x110 0x111 0x112 0x113 0x114 0x115 0x116 0x117>,
+			<0 0 0 0 0 0 0 0>;
+	- PL111 single mono 4-bit STN panel:
+			<0x200 0x201 0x202 0x203>,
+			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL111 dual mono 4-bit STN panel:
+			<0x200 0x201 0x202 0x203>, <0 0 0 0>,
+			<0x210 0x211 0x212 0x213>,
+			<0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL111 single mono 8-bit STN panel:
+			<0x200 0x201 0x202 0x203 0x204 0x205 0x206 0x207>,
+			<0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0>;
+	- PL111 dual mono 8-bit STN panel:
+			<0x200 0x201 0x202 0x203 0x204 0x205 0x206 0x207>,
+			<0x210 0x211 0x212 0x213 0x214 0x215 0x216 0x217>,
+			<0 0 0 0 0 0 0 0>;
+	- PL111 TFT 4:4:4 panel:
+			<0 0 0 0>, <0x300 0x301 0x302 0x303>,
+			<0 0 0 0>, <0x310 0x311 0x312 0x313>,
+			<0 0 0 0>, <0x320 0x321 0x322 0x323>;
+	- PL111 TFT 5:6:5 panel:
+			<0 0 0>, <0x300 0x301 0x302 0x303 0x304>,
+			<0 0>, <0x310 0x311 0x312 0x313 0x314 0x315>,
+			<0 0 0>, <0x320 0x321 0x322 0x323 0x324>;
+	- PL111 TFT (1):5:5:5 panel:
+			<0 0 0>, <0x300 0x301 0x302 0x303 0x304>,
+			<0 0>, <0x330 0x310 0x311 0x312 0x313 0x314>,
+			<0 0 0>, <0x320 0x321 0x322 0x323 0x324>;
+
+Optional properties:
+
+- arm,pl11x,framebuffer-base: a pair of two values, address and size,
+				defining the framebuffer to be used;
+				to be used only if it is *not*
+				part of normal memory, as described
+				in /memory node
+- max-memory-bandwidth: maximum bandwidth in bytes per second that the
+			cell's memory interface can handle
+- display-timings: standard display timings sub-node, defining possible
+			video modes of a connected panel; for details see
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
+				arm,pl11x,panel-data-pads = <0x300 0x301 0x302 0x303 0x304 0x305 0x306 0x307>,
+							    <0x310 0x311 0x312 0x313 0x314 0x315 0x316 0x317>,
+							    <0x320 0x321 0x322 0x323 0x324 0x325 0x326 0x327>;
+				arm,pl11x,framebuffer-base = <0x18000000 0x00800000>;
+				max-memory-bandwidth = <36864000>; /* bps, 640x480@60 16bpp */
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
index 0a2cce7..03420d1 100644
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
 
@@ -542,6 +547,266 @@ static int clcdfb_register(struct clcd_fb *fb)
 	return ret;
 }
 
+#ifdef CONFIG_OF
+
+#define CLCD_PADS_NUM 24
+
+#define CLCD_PAD_BIT(pad) ((pad) & 0xf)
+#define CLCD_PAD_TYPE(pad) (((pad) >> 8) & 0xf)
+
+#define CLCD_PAD_IS_TFT(pad) (CLCD_PAD_TYPE(pad) == 0x3)
+
+#define CLCD_PAD_RGB(pad) (((pad) >> 4) & 0xf)
+#define CLCD_PAD_R 0x0
+#define CLCD_PAD_G 0x1
+#define CLCD_PAD_B 0x2
+
+static int clcdfb_of_init_tft_panel(struct clcd_fb *fb, u32 *pads)
+{
+	static struct {
+		unsigned int part;
+		int r0, g0, b0;
+		u32 caps;
+	} panels[] = {
+		{ 0x110, 1,  7, 13, CLCD_CAP_5551 },
+		{ 0x110, 0,  8, 16, CLCD_CAP_888 },
+		{ 0x111, 4, 14, 20, CLCD_CAP_444 },
+		{ 0x111, 3, 11, 19, CLCD_CAP_444 | CLCD_CAP_5551 },
+		{ 0x111, 3, 10, 19, CLCD_CAP_444 | CLCD_CAP_5551 |
+				    CLCD_CAP_565 },
+		{ 0x111, 0,  8, 16, CLCD_CAP_444 | CLCD_CAP_5551 |
+				    CLCD_CAP_565 | CLCD_CAP_888 },
+	};
+	int r = 0, g = 0, b = 0;
+	int r0 = -1, g0 = -1, b0 = -1;
+	int i;
+
+	/* Bypass pixel clock divider, data output on the falling edge */
+	fb->panel->tim2 = TIM2_BCD | TIM2_IPC;
+
+	/* TFT display, vert. comp. interrupt at the start of the back porch */
+	fb->panel->cntl |= CNTL_LCDTFT | CNTL_LCDVCOMP(1);
+
+	fb->panel->caps = 0;
+
+	/*
+	 * Find indices of the first component bits and make sure they
+	 * are in correct order
+	 */
+	for (i = 0; i < CLCD_PADS_NUM; i++) {
+		int bit;
+
+		if (!pads[i])
+			continue;
+		switch (CLCD_PAD_RGB(pads[i])) {
+		case CLCD_PAD_R:
+			r0 = r ? r0 : i;
+			bit = r++;
+			break;
+		case CLCD_PAD_G:
+			g0 = g ? g0 : i;
+			bit = g++;
+			break;
+		case CLCD_PAD_B:
+			b0 = b ? b0 : i;
+			bit = b++;
+			break;
+		default:
+			return -EINVAL;
+		}
+		if (bit != CLCD_PAD_BIT(pads[i]) || !CLCD_PAD_IS_TFT(pads[i]))
+			return -EINVAL;
+	}
+
+	/* Match the setup with known variants */
+	for (i = 0; i < ARRAY_SIZE(panels) && !fb->panel->caps; i++) {
+		if (amba_part(fb->dev) != panels[i].part)
+			continue;
+		if (g0 != panels[i].g0)
+			continue;
+		if (r0 == panels[i].r0 && b0 == panels[i].b0)
+			fb->panel->caps = panels[i].caps & CLCD_CAP_RGB;
+		if (r0 == panels[i].b0 && b0 == panels[i].r0)
+			fb->panel->caps = panels[i].caps & CLCD_CAP_BGR;
+	}
+
+	return fb->panel->caps ? 0 : -EINVAL;
+}
+
+static int clcdfb_snprintf_mode(char *buf, int size, struct fb_videomode *mode)
+{
+	return snprintf(buf, size, "%ux%u@%u", mode->xres, mode->yres,
+			mode->refresh);
+}
+
+static int clcdfb_of_init_display(struct clcd_fb *fb)
+{
+	struct device_node *node = fb->dev->dev.of_node;
+	int err, len;
+	char *mode_name;
+	u32 max_bandwidth;
+	u32 pads[CLCD_PADS_NUM];
+	int i;
+
+	fb->panel = devm_kzalloc(&fb->dev->dev, sizeof(*fb->panel), GFP_KERNEL);
+	if (!fb->panel)
+		return -ENOMEM;
+
+	err = of_get_fb_videomode(node, &fb->panel->mode, OF_USE_NATIVE_MODE);
+	if (err)
+		return err;
+
+	len = clcdfb_snprintf_mode(NULL, 0, &fb->panel->mode);
+	mode_name = devm_kzalloc(&fb->dev->dev, len + 1, GFP_KERNEL);
+	clcdfb_snprintf_mode(mode_name, len + 1, &fb->panel->mode);
+	fb->panel->mode.name = mode_name;
+
+	err = of_property_read_u32(node, "max-memory-bandwidth",
+			&max_bandwidth);
+	if (!err)
+		fb->panel->bpp = 8 * max_bandwidth / (fb->panel->mode.xres *
+				fb->panel->mode.yres * fb->panel->mode.refresh);
+	else
+		fb->panel->bpp = 32;
+
+#ifdef CONFIG_CPU_BIG_ENDIAN
+	fb->panel->cntl |= CNTL_BEBO;
+#endif
+	fb->panel->width = -1;
+	fb->panel->height = -1;
+
+	err = of_property_read_u32_array(node, "arm,pl11x,panel-data-pads",
+			pads, ARRAY_SIZE(pads));
+	if (err)
+		return err;
+
+	/* Find first connected pad - its type determines the panel */
+	for (i = 0; i < CLCD_PADS_NUM; i++)
+		if (pads[i] && CLCD_PAD_IS_TFT(pads[i]))
+			return clcdfb_of_init_tft_panel(fb, pads);
+
+	return -EINVAL;
+}
+
+static int clcdfb_of_vram_setup(struct clcd_fb *fb)
+{
+	int err;
+	u32 values[2];
+	phys_addr_t phys_base;
+	size_t size;
+
+	err = clcdfb_of_init_display(fb);
+	if (err)
+		return err;
+
+	err = of_property_read_u32_array(fb->dev->dev.of_node,
+			"arm,pl11x,framebuffer-base",
+			values, ARRAY_SIZE(values));
+	if (err)
+		return err;
+
+	phys_base = values[0];
+	size = values[1];
+
+	fb->fb.screen_base = ioremap(phys_base, size);
+	if (!fb->fb.screen_base)
+		return -ENOMEM;
+
+	fb->fb.fix.smem_start = phys_base;
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
+	if (of_find_property(node, "arm,pl11x,framebuffer-base", NULL)) {
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
@@ -549,6 +814,9 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	int ret;
 
 	if (!board)
+		board = clcdfb_of_get_board(dev);
+
+	if (!board)
 		return -EINVAL;
 
 	ret = amba_request_regions(dev, NULL);
-- 
1.8.1.2


