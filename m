From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 21 Jul 2010 10:13:25 +0000
Subject: [PATCH 6/6 v3] ARM: mach-shmobile: add HDMI support to the ap4evb
Message-Id: <Pine.LNX.4.64.1007211209490.16933@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Support HDMI in 720p mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3:
1. Merged accidental patch from 5/6 into this one

v2:
1. Moved platform-specific clock configuration here
2. Not managing function clocks here, since they are managed by the 
   runtime PM now.

 arch/arm/mach-shmobile/board-ap4evb.c |  156 ++++++++++++++++++++++++++++++++-
 1 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5d24d4e..b0583be 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -44,6 +44,7 @@
 
 #include <sound/sh_fsi.h>
 
+#include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 
@@ -529,6 +530,90 @@ static struct platform_device fsi_device = {
 	},
 };
 
+static struct sh_mobile_lcdc_info sh_mobile_lcdc1_info = {
+	.clock_source = LCDC_CLK_EXTERNAL,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = RGB24,
+		.clock_divider = 1,
+		.flags = LCDC_FLAGS_DWPOL,
+		.lcd_cfg = {
+			.name = "HDMI",
+			/* So far only 720p is supported */
+			.xres = 1280,
+			.yres = 720,
+			/*
+			 * If left and right margins are not multiples of 8,
+			 * LDHAJR will be adjusted accordingly by the LCDC
+			 * driver. Until we start using EDID, these values
+			 * might have to be adjusted for different monitors.
+			 */
+			.left_margin = 200,
+			.right_margin = 88,
+			.hsync_len = 48,
+			.upper_margin = 20,
+			.lower_margin = 5,
+			.vsync_len = 5,
+			.pixclock = 13468,
+			.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+		},
+	}
+};
+
+static struct resource lcdc1_resources[] = {
+	[0] = {
+		.name	= "LCDC1",
+		.start	= 0xfe944000,
+		.end	= 0xfe947fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x17a0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device lcdc1_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(lcdc1_resources),
+	.resource	= lcdc1_resources,
+	.id             = 1,
+	.dev	= {
+		.platform_data	= &sh_mobile_lcdc1_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+static struct sh_mobile_hdmi_info hdmi_info = {
+	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
+	.lcd_dev = &lcdc1_device.dev,
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
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -536,10 +621,12 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&sdhi0_device,
 	&sdhi1_device,
 	&usb1_host_device,
-	&lcdc_device,
 	&mipidsi0_device,
 	&fsi_device,
-	&sh_mmcif_device
+	&sh_mmcif_device,
+	&lcdc1_device,
+	&lcdc_device,
+	&hdmi_device,
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
@@ -628,6 +715,55 @@ eclkdsitxget:
 
 device_initcall(ap4evb_init_display_clk);
 
+static int __init hdmi_init_pm_clock(void)
+{
+	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
+	int ret;
+	long rate;
+
+	if (IS_ERR(hdmi_ick)) {
+		ret = PTR_ERR(hdmi_ick);
+		pr_err("Cannot get HDMI ICK: %d\n", ret);
+		goto out;
+	}
+
+	ret = clk_set_parent(&pllc2_clk, &dv_clki_div2_clk);
+	if (ret < 0) {
+		pr_err("Cannot set PLLC2 parent: %d, %d users\n", ret, pllc2_clk.usecount);
+		goto out;
+	}
+
+	pr_debug("PLLC2 initial frequency %lu\n", clk_get_rate(&pllc2_clk));
+
+	rate = clk_round_rate(&pllc2_clk, 594000000);
+	if (rate < 0) {
+		pr_err("Cannot get suitable rate: %ld\n", rate);
+		ret = rate;
+		goto out;
+	}
+
+	ret = clk_set_rate(&pllc2_clk, rate);
+	if (ret < 0) {
+		pr_err("Cannot set rate %ld: %d\n", rate, ret);
+		goto out;
+	}
+
+	pr_debug("PLLC2 set frequency %lu\n", rate);
+
+	ret = clk_set_parent(hdmi_ick, &pllc2_clk);
+	if (ret < 0) {
+		pr_err("Cannot set HDMI parent: %d\n", ret);
+		goto out;
+	}
+
+out:
+	if (!IS_ERR(hdmi_ick))
+		clk_put(hdmi_ick);
+	return ret;
+}
+
+device_initcall(hdmi_init_pm_clock);
+
 /*
  * FIXME !!
  *
@@ -644,9 +780,9 @@ static void __init gpio_no_direction(u32 addr)
 
 #define GPIO_PORT9CR	0xE6051009
 #define GPIO_PORT10CR	0xE605100A
-
 static void __init ap4evb_init(void)
 {
+	u32 srcr4;
 	struct clk *clk;
 
 	sh7372_pinmux_init();
@@ -787,6 +923,17 @@ static void __init ap4evb_init(void)
 
 	sh7372_add_standard_devices();
 
+	/* HDMI */
+	gpio_request(GPIO_FN_HDMI_HPD, NULL);
+	gpio_request(GPIO_FN_HDMI_CEC, NULL);
+
+	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
+#define SRCR4 0xe61580bc
+	srcr4 = __raw_readl(SRCR4);
+	__raw_writel(srcr4 | (1 << 13), SRCR4);
+	udelay(50);
+	__raw_writel(srcr4 & ~(1 << 13), SRCR4);
+
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 }
 
@@ -794,6 +941,9 @@ static void __init ap4evb_timer_init(void)
 {
 	sh7372_clock_init();
 	shmobile_timer.init();
+
+	/* External clock source */
+	clk_set_rate(&dv_clki_clk, 27000000);
 }
 
 static struct sys_timer ap4evb_timer = {
-- 
1.6.2.4

