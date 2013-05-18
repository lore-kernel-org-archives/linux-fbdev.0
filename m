From: Tony Prisk <linux@prisktech.co.nz>
Date: Sat, 18 May 2013 09:15:14 +0000
Subject: [PATCH 4/4] fb: vt8500: Add VGA output support to wm8505fb driver.
Message-Id: <1368868514-18975-5-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368868514-18975-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1368868514-18975-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The APC8750 does not support an LCD panel, but provides a VGA connector.
This patch adds support for the VGA interface, and defines an optional
devicetree property to specify the output interface. The default if not
specified is LCD for backward compatibility.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/video/wm,wm8505-fb.txt     |    5 ++++
 drivers/video/wm8505fb.c                           |   31 ++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt b/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
index 601416c..9f1d648 100644
--- a/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
+++ b/Documentation/devicetree/bindings/video/wm,wm8505-fb.txt
@@ -7,6 +7,10 @@ Required properties:
 - bits-per-pixel : bit depth of framebuffer (16 or 32)
 - clocks : phandle to DVO clock
 
+Optional properties:
+- output-interface : the interface the fb should output on. Valid values are
+	"lcd" or "vga". If not specified, the default is "lcd".
+
 Required subnodes:
 - display-timings: see display-timing.txt for information
 
@@ -17,6 +21,7 @@ Example:
 		reg = <0xd8051700 0x200>;
 		bits-per-pixel = <16>;
 		clocks = <&clkdvo>;
+		output-interface = "vga";
 
 		display-timings {
 			native-mode = <&timing0>;
diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
index f8bffc2..d1f7f33 100644
--- a/drivers/video/wm8505fb.c
+++ b/drivers/video/wm8505fb.c
@@ -130,12 +130,17 @@
 
 #define to_wm8505fb_info(__info) container_of(__info, \
 						struct wm8505fb_info, fb)
+
+#define INTERFACE_LCD	1
+#define INTERFACE_VGA	2
+
 struct wm8505fb_info {
 	struct fb_info fb;
 	void __iomem *regbase;
 	unsigned int contrast;
 	struct device *dev;
 	struct clk *clk_dvo;
+	int interface;
 };
 
 
@@ -158,7 +163,11 @@ static int wm8505fb_init_hw(struct fb_info *info)
 	 * 0x31C sets the correct color mode (RGB565) for WM8650
 	 * Bit 8+9 (0x300) are ignored on WM8505 as reserved
 	 */
-	writel(0x31c,		       fbi->regbase + REG_GOVRH_YUVRGB);
+	if (fbi->interface = INTERFACE_VGA)
+		writel(0x338, fbi->regbase + REG_GOVRH_YUVRGB);
+	else
+		writel(0x31c, fbi->regbase + REG_GOVRH_YUVRGB);
+
 	writel(1,		       fbi->regbase + REG_GOVRH_DVO_PIX);
 
 	/* Virtual buffer size */
@@ -167,7 +176,12 @@ static int wm8505fb_init_hw(struct fb_info *info)
 
 	/* black magic ;) */
 	writel(0xf,		       fbi->regbase + REG_GOVRH_FHI);
-	writel(4,		       fbi->regbase + REG_GOVRH_DVO_SET);
+
+	if (fbi->interface = INTERFACE_VGA)
+		writel(0xe, fbi->regbase + REG_GOVRH_DVO_SET);
+	else
+		writel(4, fbi->regbase + REG_GOVRH_DVO_SET);
+
 	writel(1,		       fbi->regbase + REG_GOVRH_MIF);
 	writel(1,		       fbi->regbase + REG_GOVRH_REG_STS);
 
@@ -194,11 +208,15 @@ static int wm8505fb_set_timing(struct fb_info *info)
 	writel(h_end,   fbi->regbase + REG_GOVRH_ACTPX_END);
 	writel(h_all,   fbi->regbase + REG_GOVRH_H_ALLPXL);
 	writel(h_sync,  fbi->regbase + REG_GOVRH_HDMI_HSYNW);
+	if (fbi->interface = INTERFACE_VGA)
+		writel(h_sync,  fbi->regbase + REG_GOVRH_VGA_HSYNW);
 
 	writel(v_start, fbi->regbase + REG_GOVRH_ACTLN_BG);
 	writel(v_end,   fbi->regbase + REG_GOVRH_ACTLN_END);
 	writel(v_all,   fbi->regbase + REG_GOVRH_V_ALLLN);
 	writel(v_sync,  fbi->regbase + REG_GOVRH_HDMI_VBISW);
+	if (fbi->interface = INTERFACE_VGA)
+		writel(info->var.pixclock,  fbi->regbase + REG_GOVRH_VGA_VSYNW);
 
 	writel(1, fbi->regbase + REG_GOVRH_TG_ENABLE);
 
@@ -371,6 +389,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	dma_addr_t fb_mem_phys;
 	unsigned long fb_mem_len;
 	void *fb_mem_virt;
+	const char *intf;
 
 	fbi = devm_kzalloc(&pdev->dev, sizeof(struct wm8505fb_info) +
 			sizeof(u32) * 16, GFP_KERNEL);
@@ -428,6 +447,14 @@ static int wm8505fb_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(fbi->clk_dvo);
 
+	fbi->interface = INTERFACE_LCD;
+	ret = of_property_read_string(pdev->dev.of_node, "output-interface",
+					&intf);
+	if (!ret) {
+		if (!strcmp(intf, "vga"))
+			fbi->interface = INTERFACE_VGA;
+	}
+
 	fb_videomode_to_var(&fbi->fb.var, &mode);
 
 	fbi->fb.var.nonstd		= 0;
-- 
1.7.9.5

