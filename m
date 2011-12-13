From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Dec 2011 14:02:07 +0000
Subject: [PATCH 12/57] arm: mach-shmobile: Add LCDC tx_dev field to platform data
Message-Id: <1323784972-24205-13-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make sure the transmitter devices get registered before the associated
LCDC devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |  272 ++++++++++++++++---------------
 arch/arm/mach-shmobile/board-mackerel.c |   66 ++++----
 2 files changed, 176 insertions(+), 162 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index dca4860..e0a6b3d 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -445,82 +445,6 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
-static const struct fb_videomode ap4evb_lcdc_modes[] = {
-	{
-#ifdef CONFIG_AP4EVB_QHD
-		.name		= "R63302(QHD)",
-		.xres		= 544,
-		.yres		= 961,
-		.left_margin	= 72,
-		.right_margin	= 600,
-		.hsync_len	= 16,
-		.upper_margin	= 8,
-		.lower_margin	= 8,
-		.vsync_len	= 2,
-		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
-#else
-		.name		= "WVGA Panel",
-		.xres		= 800,
-		.yres		= 480,
-		.left_margin	= 220,
-		.right_margin	= 110,
-		.hsync_len	= 70,
-		.upper_margin	= 20,
-		.lower_margin	= 5,
-		.vsync_len	= 5,
-		.sync		= 0,
-#endif
-	},
-};
-static struct sh_mobile_meram_cfg lcd_meram_cfg = {
-	.icb[0] = {
-		.marker_icb     = 28,
-		.cache_icb      = 24,
-		.meram_offset   = 0x0,
-		.meram_size     = 0x40,
-	},
-	.icb[1] = {
-		.marker_icb     = 29,
-		.cache_icb      = 25,
-		.meram_offset   = 0x40,
-		.meram_size     = 0x40,
-	},
-};
-
-static struct sh_mobile_lcdc_info lcdc_info = {
-	.meram_dev = &meram_info,
-	.ch[0] = {
-		.chan = LCDC_CHAN_MAINLCD,
-		.fourcc = V4L2_PIX_FMT_RGB565,
-		.lcd_cfg = ap4evb_lcdc_modes,
-		.num_cfg = ARRAY_SIZE(ap4evb_lcdc_modes),
-		.meram_cfg = &lcd_meram_cfg,
-	}
-};
-
-static struct resource lcdc_resources[] = {
-	[0] = {
-		.name	= "LCDC",
-		.start	= 0xfe940000, /* P4-only space */
-		.end	= 0xfe943fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= intcs_evt2irq(0x580),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device lcdc_device = {
-	.name		= "sh_mobile_lcdc_fb",
-	.num_resources	= ARRAY_SIZE(lcdc_resources),
-	.resource	= lcdc_resources,
-	.dev	= {
-		.platform_data	= &lcdc_info,
-		.coherent_dma_mask = ~0,
-	},
-};
-
 /*
  * QHD display
  */
@@ -601,6 +525,8 @@ static struct resource mipidsi0_resources[] = {
 	},
 };
 
+static struct sh_mobile_lcdc_info lcdc_info;
+
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc_info.ch[0],
@@ -627,6 +553,86 @@ static struct platform_device *qhd_devices[] __initdata = {
 };
 #endif /* CONFIG_AP4EVB_QHD */
 
+/* LCDC0 */
+static const struct fb_videomode ap4evb_lcdc_modes[] = {
+	{
+#ifdef CONFIG_AP4EVB_QHD
+		.name		= "R63302(QHD)",
+		.xres		= 544,
+		.yres		= 961,
+		.left_margin	= 72,
+		.right_margin	= 600,
+		.hsync_len	= 16,
+		.upper_margin	= 8,
+		.lower_margin	= 8,
+		.vsync_len	= 2,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+#else
+		.name		= "WVGA Panel",
+		.xres		= 800,
+		.yres		= 480,
+		.left_margin	= 220,
+		.right_margin	= 110,
+		.hsync_len	= 70,
+		.upper_margin	= 20,
+		.lower_margin	= 5,
+		.vsync_len	= 5,
+		.sync		= 0,
+#endif
+	},
+};
+static struct sh_mobile_meram_cfg lcd_meram_cfg = {
+	.icb[0] = {
+		.marker_icb     = 28,
+		.cache_icb      = 24,
+		.meram_offset   = 0x0,
+		.meram_size     = 0x40,
+	},
+	.icb[1] = {
+		.marker_icb     = 29,
+		.cache_icb      = 25,
+		.meram_offset   = 0x40,
+		.meram_size     = 0x40,
+	},
+};
+
+static struct sh_mobile_lcdc_info lcdc_info = {
+	.meram_dev = &meram_info,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.fourcc = V4L2_PIX_FMT_RGB565,
+		.lcd_cfg = ap4evb_lcdc_modes,
+		.num_cfg = ARRAY_SIZE(ap4evb_lcdc_modes),
+		.meram_cfg = &lcd_meram_cfg,
+#ifdef CONFIG_AP4EVB_QHD
+		.tx_dev = &mipidsi0_device,
+#endif
+	}
+};
+
+static struct resource lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000, /* P4-only space */
+		.end	= 0xfe943fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x580),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc_resources),
+	.resource	= lcdc_resources,
+	.dev	= {
+		.platform_data	= &lcdc_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
 /* FSI */
 #define IRQ_FSI		evt2irq(0x1840)
 static int __fsi_set_rate(struct clk *clk, long rate, int enable)
@@ -793,6 +799,62 @@ static struct platform_device fsi_device = {
 static struct platform_device fsi_ak4643_device = {
 	.name		= "sh_fsi2_a_ak4643",
 };
+
+/* LCDC1 */
+static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
+				unsigned long *parent_freq);
+
+static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info;
+
+static struct sh_mobile_hdmi_info hdmi_info = {
+	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
+	.flags = HDMI_SND_SRC_SPDIF,
+	.clk_optimize_parent = ap4evb_clk_optimize,
+};
+
+static struct resource hdmi_resources[] = {
+	[0] = {
+		.name	= "HDMI",
+		.start	= 0xe6be0000,
+		.end	= 0xe6be00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* There's also an HDMI interrupt on INTCS @ 0x18e0 */
+		.start	= evt2irq(0x17e0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device hdmi_device = {
+	.name		= "sh-mobile-hdmi",
+	.num_resources	= ARRAY_SIZE(hdmi_resources),
+	.resource	= hdmi_resources,
+	.id             = -1,
+	.dev	= {
+		.platform_data	= &hdmi_info,
+	},
+};
+
+static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
+				unsigned long *parent_freq)
+{
+	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
+	long error;
+
+	if (IS_ERR(hdmi_ick)) {
+		int ret = PTR_ERR(hdmi_ick);
+		pr_err("Cannot get HDMI ICK: %d\n", ret);
+		return ret;
+	}
+
+	error = clk_round_parent(hdmi_ick, target, best_freq, parent_freq, 1, 64);
+
+	clk_put(hdmi_ick);
+
+	return error;
+}
+
 static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 	.icb[0] = {
 		.marker_icb     = 30,
@@ -818,6 +880,7 @@ static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
 		.meram_cfg = &hdmi_meram_cfg,
+		.tx_dev = &hdmi_device,
 	}
 };
 
@@ -845,63 +908,10 @@ static struct platform_device lcdc1_device = {
 	},
 };
 
-static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
-				unsigned long *parent_freq);
-
-
-static struct sh_mobile_hdmi_info hdmi_info = {
-	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
-	.flags = HDMI_SND_SRC_SPDIF,
-	.clk_optimize_parent = ap4evb_clk_optimize,
-};
-
-static struct resource hdmi_resources[] = {
-	[0] = {
-		.name	= "HDMI",
-		.start	= 0xe6be0000,
-		.end	= 0xe6be00ff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		/* There's also an HDMI interrupt on INTCS @ 0x18e0 */
-		.start	= evt2irq(0x17e0),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device hdmi_device = {
-	.name		= "sh-mobile-hdmi",
-	.num_resources	= ARRAY_SIZE(hdmi_resources),
-	.resource	= hdmi_resources,
-	.id             = -1,
-	.dev	= {
-		.platform_data	= &hdmi_info,
-	},
-};
-
 static struct platform_device fsi_hdmi_device = {
 	.name		= "sh_fsi2_b_hdmi",
 };
 
-static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
-				unsigned long *parent_freq)
-{
-	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
-	long error;
-
-	if (IS_ERR(hdmi_ick)) {
-		int ret = PTR_ERR(hdmi_ick);
-		pr_err("Cannot get HDMI ICK: %d\n", ret);
-		return ret;
-	}
-
-	error = clk_round_parent(hdmi_ick, target, best_freq, parent_freq, 1, 64);
-
-	clk_put(hdmi_ick);
-
-	return error;
-}
-
 static struct gpio_led ap4evb_leds[] = {
 	{
 		.name			= "led4",
@@ -1036,9 +1046,9 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&fsi_ak4643_device,
 	&fsi_hdmi_device,
 	&sh_mmcif_device,
-	&lcdc1_device,
-	&lcdc_device,
 	&hdmi_device,
+	&lcdc_device,
+	&lcdc1_device,
 	&ceu_device,
 	&ap4evb_camera,
 	&meram_device,
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 4ed0138..ccdd9fc 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -431,6 +431,38 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+/* HDMI */
+static struct sh_mobile_lcdc_info hdmi_lcdc_info;
+
+static struct sh_mobile_hdmi_info hdmi_info = {
+	.lcd_chan	= &hdmi_lcdc_info.ch[0],
+	.flags		= HDMI_SND_SRC_SPDIF,
+};
+
+static struct resource hdmi_resources[] = {
+	[0] = {
+		.name	= "HDMI",
+		.start	= 0xe6be0000,
+		.end	= 0xe6be00ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* There's also an HDMI interrupt on INTCS @ 0x18e0 */
+		.start	= evt2irq(0x17e0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device hdmi_device = {
+	.name		= "sh-mobile-hdmi",
+	.num_resources	= ARRAY_SIZE(hdmi_resources),
+	.resource	= hdmi_resources,
+	.id             = -1,
+	.dev	= {
+		.platform_data	= &hdmi_info,
+	},
+};
+
 static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 	.icb[0] = {
 		.marker_icb     = 30,
@@ -445,7 +477,7 @@ static struct sh_mobile_meram_cfg hdmi_meram_cfg = {
 		.meram_size     = 0x100,
 	},
 };
-/* HDMI */
+
 static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
 	.meram_dev = &mackerel_meram_info,
 	.clock_source = LCDC_CLK_EXTERNAL,
@@ -456,6 +488,7 @@ static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
 		.clock_divider = 1,
 		.flags = LCDC_FLAGS_DWPOL,
 		.meram_cfg = &hdmi_meram_cfg,
+		.tx_dev = &hdmi_device,
 	}
 };
 
@@ -483,35 +516,6 @@ static struct platform_device hdmi_lcdc_device = {
 	},
 };
 
-static struct sh_mobile_hdmi_info hdmi_info = {
-	.lcd_chan	= &hdmi_lcdc_info.ch[0],
-	.flags		= HDMI_SND_SRC_SPDIF,
-};
-
-static struct resource hdmi_resources[] = {
-	[0] = {
-		.name	= "HDMI",
-		.start	= 0xe6be0000,
-		.end	= 0xe6be00ff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		/* There's also an HDMI interrupt on INTCS @ 0x18e0 */
-		.start	= evt2irq(0x17e0),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device hdmi_device = {
-	.name		= "sh-mobile-hdmi",
-	.num_resources	= ARRAY_SIZE(hdmi_resources),
-	.resource	= hdmi_resources,
-	.id             = -1,
-	.dev	= {
-		.platform_data	= &hdmi_info,
-	},
-};
-
 static struct platform_device fsi_hdmi_device = {
 	.name		= "sh_fsi2_b_hdmi",
 };
@@ -1313,8 +1317,8 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&sh_mmcif_device,
 	&ceu_device,
 	&mackerel_camera,
-	&hdmi_lcdc_device,
 	&hdmi_device,
+	&hdmi_lcdc_device,
 	&meram_device,
 };
 
-- 
1.7.3.4

