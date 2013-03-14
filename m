From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 14 Mar 2013 05:53:29 +0000
Subject: [PATCH 5/6] ARM: mxs: move display timing configurations into device tree
Message-Id: <1363240410-16865-6-git-send-email-shawn.guo@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1363240410-16865-1-git-send-email-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move display timing configurations into device tree, so that the
auxdata for mxsfb driver can be killed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts        |   25 ++++++
 arch/arm/boot/dts/imx28-apf28dev.dts   |   25 ++++++
 arch/arm/boot/dts/imx28-apx4devkit.dts |   25 ++++++
 arch/arm/boot/dts/imx28-cfa10049.dts   |   25 ++++++
 arch/arm/boot/dts/imx28-evk.dts        |   25 ++++++
 arch/arm/boot/dts/imx28-m28evk.dts     |   25 ++++++
 arch/arm/mach-mxs/mach-mxs.c           |  153 --------------------------------
 7 files changed, 150 insertions(+), 153 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 035c13f..7880e17 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -60,7 +60,32 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a>;
 				panel-enable-gpios = <&gpio1 18 0>;
+				display = <&display>;
 				status = "okay";
+
+				display: display {
+					bits-per-pixel = <32>;
+					bus-width = <24>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <9200000>;
+							hactive = <480>;
+							vactive = <272>;
+							hback-porch = <15>;
+							hfront-porch = <8>;
+							vback-porch = <12>;
+							vfront-porch = <4>;
+							hsync-len = <1>;
+							vsync-len = <1>;
+							hsync-active = <0>;
+							vsync-active = <0>;
+							de-active = <1>;
+							pixelclk-active = <0>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 6d8865b..3d905d1 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -72,7 +72,32 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_16bit_pins_a
 						&lcdif_pins_apf28dev>;
+				display = <&display>;
 				status = "okay";
+
+				display: display {
+					bits-per-pixel = <16>;
+					bus-width = <16>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <33000033>;
+							hactive = <800>;
+							vactive = <480>;
+							hback-porch = <96>;
+							hfront-porch = <96>;
+							vback-porch = <20>;
+							vfront-porch = <21>;
+							hsync-len = <64>;
+							vsync-len = <4>;
+							hsync-active = <1>;
+							vsync-active = <1>;
+							de-active = <1>;
+							pixelclk-active = <0>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index 5171667..43bf3c7 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -94,7 +94,32 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_apx4>;
+				display = <&display>;
 				status = "okay";
+
+				display: display {
+					bits-per-pixel = <32>;
+					bus-width = <24>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <30000000>;
+							hactive = <800>;
+							vactive = <480>;
+							hback-porch = <88>;
+							hfront-porch = <40>;
+							vback-porch = <32>;
+							vfront-porch = <13>;
+							hsync-len = <48>;
+							vsync-len = <3>;
+							hsync-active = <1>;
+							vsync-active = <1>;
+							de-active = <1>;
+							pixelclk-active = <0>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a0d3e9f..7d6e1f8 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -126,7 +126,32 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_18bit_pins_cfa10049
 					     &lcdif_pins_cfa10049>;
+				display = <&display>;
 				status = "okay";
+
+				display: display {
+					bits-per-pixel = <32>;
+					bus-width = <18>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <9216000>;
+							hactive = <320>;
+							vactive = <480>;
+							hback-porch = <2>;
+							hfront-porch = <2>;
+							vback-porch = <2>;
+							vfront-porch = <2>;
+							hsync-len = <15>;
+							vsync-len = <15>;
+							hsync-active = <0>;
+							vsync-active = <0>;
+							de-active = <1>;
+							pixelclk-active = <1>;
+						};
+					};
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2da316e0..2d4ea3b 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -124,7 +124,32 @@
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_evk>;
 				panel-enable-gpios = <&gpio3 30 0>;
+				display = <&display>;
 				status = "okay";
+
+				display: display {
+					bits-per-pixel = <32>;
+					bus-width = <24>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <33500000>;
+							hactive = <800>;
+							vactive = <480>;
+							hback-porch = <89>;
+							hfront-porch = <164>;
+							vback-porch = <23>;
+							vfront-porch = <10>;
+							hsync-len = <10>;
+							vsync-len = <10>;
+							hsync-active = <0>;
+							vsync-active = <0>;
+							de-active = <1>;
+							pixelclk-active = <0>;
+						};
+					};
+				};
 			};
 
 			can0: can@80032000 {
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 6ce3d17..83e16c0 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -119,7 +119,32 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_m28>;
+				display = <&display>;
 				status = "okay";
+
+				display: display {
+					bits-per-pixel = <16>;
+					bus-width = <18>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <33260000>;
+							hactive = <800>;
+							vactive = <480>;
+							hback-porch = <0>;
+							hfront-porch = <256>;
+							vback-porch = <0>;
+							vfront-porch = <45>;
+							hsync-len = <1>;
+							vsync-len = <1>;
+							hsync-active = <0>;
+							vsync-active = <0>;
+							de-active = <1>;
+							pixelclk-active = <1>;
+						};
+					};
+				};
 			};
 
 			can0: can@80032000 {
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 3218f1f..b0ef36e 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -18,7 +18,6 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/micrel_phy.h>
-#include <linux/mxsfb.h>
 #include <linux/of_platform.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/consumer.h>
@@ -28,116 +27,6 @@
 #include <mach/digctl.h>
 #include <mach/mxs.h>
 
-static struct fb_videomode mx23evk_video_modes[] = {
-	{
-		.name		= "Samsung-LMS430HF02",
-		.refresh	= 60,
-		.xres		= 480,
-		.yres		= 272,
-		.pixclock	= 108096, /* picosecond (9.2 MHz) */
-		.left_margin	= 15,
-		.right_margin	= 8,
-		.upper_margin	= 12,
-		.lower_margin	= 4,
-		.hsync_len	= 1,
-		.vsync_len	= 1,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
-	},
-};
-
-static struct fb_videomode mx28evk_video_modes[] = {
-	{
-		.name		= "Seiko-43WVF1G",
-		.refresh	= 60,
-		.xres		= 800,
-		.yres		= 480,
-		.pixclock	= 29851, /* picosecond (33.5 MHz) */
-		.left_margin	= 89,
-		.right_margin	= 164,
-		.upper_margin	= 23,
-		.lower_margin	= 10,
-		.hsync_len	= 10,
-		.vsync_len	= 10,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
-	},
-};
-
-static struct fb_videomode m28evk_video_modes[] = {
-	{
-		.name		= "Ampire AM-800480R2TMQW-T01H",
-		.refresh	= 60,
-		.xres		= 800,
-		.yres		= 480,
-		.pixclock	= 30066, /* picosecond (33.26 MHz) */
-		.left_margin	= 0,
-		.right_margin	= 256,
-		.upper_margin	= 0,
-		.lower_margin	= 45,
-		.hsync_len	= 1,
-		.vsync_len	= 1,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT,
-	},
-};
-
-static struct fb_videomode apx4devkit_video_modes[] = {
-	{
-		.name		= "HannStar PJ70112A",
-		.refresh	= 60,
-		.xres		= 800,
-		.yres		= 480,
-		.pixclock	= 33333, /* picosecond (30.00 MHz) */
-		.left_margin	= 88,
-		.right_margin	= 40,
-		.upper_margin	= 32,
-		.lower_margin	= 13,
-		.hsync_len	= 48,
-		.vsync_len	= 3,
-		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
-				  FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
-	},
-};
-
-static struct fb_videomode apf28dev_video_modes[] = {
-	{
-		.name = "LW700",
-		.refresh = 60,
-		.xres = 800,
-		.yres = 480,
-		.pixclock = 30303, /* picosecond */
-		.left_margin = 96,
-		.right_margin = 96, /* at least 3 & 1 */
-		.upper_margin = 0x14,
-		.lower_margin = 0x15,
-		.hsync_len = 64,
-		.vsync_len = 4,
-		.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT |
-				FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				FB_SYNC_DOTCLK_FAILING_ACT,
-	},
-};
-
-static struct fb_videomode cfa10049_video_modes[] = {
-	{
-		.name		= "Himax HX8357-B",
-		.refresh	= 60,
-		.xres		= 320,
-		.yres		= 480,
-		.pixclock	= 108506, /* picosecond (9.216 MHz) */
-		.left_margin	= 2,
-		.right_margin	= 2,
-		.upper_margin	= 2,
-		.lower_margin	= 2,
-		.hsync_len	= 15,
-		.vsync_len	= 15,
-		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT
-	},
-};
-
-static struct mxsfb_platform_data mxsfb_pdata __initdata;
-
 /*
  * MX28EVK_FLEXCAN_SWITCH is shared between both flexcan controllers
  */
@@ -168,8 +57,6 @@ static void mx28evk_flexcan1_switch(int enable)
 static struct flexcan_platform_data flexcan_pdata[2];
 
 static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("fsl,imx23-lcdif", 0x80030000, NULL, &mxsfb_pdata),
-	OF_DEV_AUXDATA("fsl,imx28-lcdif", 0x80030000, NULL, &mxsfb_pdata),
 	OF_DEV_AUXDATA("fsl,imx28-flexcan", 0x80032000, NULL, &flexcan_pdata[0]),
 	OF_DEV_AUXDATA("fsl,imx28-flexcan", 0x80034000, NULL, &flexcan_pdata[1]),
 	{ /* sentinel */ }
@@ -253,14 +140,6 @@ static void __init update_fec_mac_prop(enum mac_oui oui)
 	}
 }
 
-static void __init imx23_evk_init(void)
-{
-	mxsfb_pdata.mode_list = mx23evk_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(mx23evk_video_modes);
-	mxsfb_pdata.default_bpp = 32;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
-}
-
 static inline void enable_clk_enet_out(void)
 {
 	struct clk *clk = clk_get_sys("enet_out", NULL);
@@ -274,11 +153,6 @@ static void __init imx28_evk_init(void)
 	enable_clk_enet_out();
 	update_fec_mac_prop(OUI_FSL);
 
-	mxsfb_pdata.mode_list = mx28evk_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(mx28evk_video_modes);
-	mxsfb_pdata.default_bpp = 32;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
-
 	mxs_saif_clkmux_select(MXS_DIGCTL_SAIF_CLKMUX_EXTMSTR0);
 }
 
@@ -291,14 +165,6 @@ static void __init imx28_evk_post_init(void)
 	}
 }
 
-static void __init m28evk_init(void)
-{
-	mxsfb_pdata.mode_list = m28evk_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
-	mxsfb_pdata.default_bpp = 16;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
-}
-
 static void __init sc_sps1_init(void)
 {
 	enable_clk_enet_out();
@@ -317,11 +183,6 @@ static void __init apx4devkit_init(void)
 	if (IS_BUILTIN(CONFIG_PHYLIB))
 		phy_register_fixup_for_uid(PHY_ID_KSZ8051, MICREL_PHY_ID_MASK,
 					   apx4devkit_phy_fixup);
-
-	mxsfb_pdata.mode_list = apx4devkit_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(apx4devkit_video_modes);
-	mxsfb_pdata.default_bpp = 32;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
 }
 
 #define ENET0_MDC__GPIO_4_0	MXS_GPIO_NR(4, 0)
@@ -402,11 +263,6 @@ static void __init cfa10049_init(void)
 {
 	enable_clk_enet_out();
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
-
-	mxsfb_pdata.mode_list = cfa10049_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(cfa10049_video_modes);
-	mxsfb_pdata.default_bpp = 32;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
 }
 
 static void __init cfa10037_init(void)
@@ -418,21 +274,12 @@ static void __init cfa10037_init(void)
 static void __init apf28_init(void)
 {
 	enable_clk_enet_out();
-
-	mxsfb_pdata.mode_list = apf28dev_video_modes;
-	mxsfb_pdata.mode_count = ARRAY_SIZE(apf28dev_video_modes);
-	mxsfb_pdata.default_bpp = 16;
-	mxsfb_pdata.ld_intf_width = STMLCDIF_16BIT;
 }
 
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
 		imx28_evk_init();
-	else if (of_machine_is_compatible("fsl,imx23-evk"))
-		imx23_evk_init();
-	else if (of_machine_is_compatible("denx,m28evk"))
-		m28evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
 		apx4devkit_init();
 	else if (of_machine_is_compatible("crystalfontz,cfa10037"))
-- 
1.7.9.5


