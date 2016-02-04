From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:20 +0000
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This moves the versatile CLCD configuration to the device tree by:

- Deleting the board file set-up of CLCD displays and quirks,
  instead relying on the driver to handle this. The driver will
  attempt to auto-detect (like the board file did) and match to
  a corresponding panel in the device tree.

- Defining all auto-detectable panels in the device tree for the
  versatile-ab, defaulting the first one to VGA. The right
  panel will be selected at panel initialization, and should
  just work for the IB1 daughterboard panels, like EPSON.

- Creating a special superset DTS file for the IB2 daughterboard
  (phone form-factor) equipped Versatile, overriding the default VGA
  display with the Sanyo 2.5" portrait display definitions, so that
  the IB2-equipped Versatile can be used with this. This follows
  the pattern of how we define the Versatile PB as a superset of
  Versatile AB.

Tested on Versatile AB with just VGA with the default device tree,
and with the IB2 daughterboard with the custom IB2 device tree.
Tested to shunt in XVGA by modifying the device tree and this works
too. Also tested on QEMU for Versatile in both VGA and Sanyo 2.5"
mode. I don't have the IB1 daughterboard and its add-on displays,
but it should work as long as the detection mechanism and device
tree parameters are sound.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/versatile-ab-ib2.dts |  20 ++++
 arch/arm/boot/dts/versatile-ab.dts     | 203 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-versatile/versatile_dt.c | 162 --------------------------
 4 files changed, 220 insertions(+), 166 deletions(-)
 create mode 100644 arch/arm/boot/dts/versatile-ab-ib2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a4a6d70e8b26..76baaa51080c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -743,6 +743,7 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-proxstream2-vodka.dtb
 dtb-$(CONFIG_ARCH_VERSATILE) += \
 	versatile-ab.dtb \
+	versatile-ab-ib2.dtb \
 	versatile-pb.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += \
 	vexpress-v2p-ca5s.dtb \
diff --git a/arch/arm/boot/dts/versatile-ab-ib2.dts b/arch/arm/boot/dts/versatile-ab-ib2.dts
new file mode 100644
index 000000000000..4b98b5382922
--- /dev/null
+++ b/arch/arm/boot/dts/versatile-ab-ib2.dts
@@ -0,0 +1,20 @@
+#include <versatile-ab.dts>
+
+/ {
+	model = "ARM Versatile AB + IB2 board";
+
+	/* Special IB2 control register */
+	ib2_syscon@27000000 {
+		compatible = "arm,versatile-ib2-syscon", "syscon", "simple-mfd";
+		reg = <0x27000000 0x4>;
+
+		led@00.4 {
+			compatible = "register-bit-led";
+			offset = <0x00>;
+			mask = <0x10>;
+			label = "versatile-ib2:0";
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 6fd7efbead34..836511cf8046 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -29,6 +29,147 @@
 		clock-frequency = <24000000>;
 	};
 
+	vga_panel {
+		compatible = "VGA", "panel-dpi";
+		port {
+			clcd_vga_panel: endpoint {
+				remote-endpoint = <&clcd_vga_pads>;
+			};
+		};
+
+		/* Standard 640x480 VGA timings */
+		panel-timing {
+			clock-frequency = <25175000>;
+			pixelclk-active = <0>;
+			hactive = <640>;
+			hback-porch = <48>;
+			hfront-porch = <16>;
+			hsync-len = <96>;
+			vactive = <480>;
+			vback-porch = <33>;
+			vfront-porch = <10>;
+			vsync-len = <2>;
+		};
+	};
+
+	xvga_panel {
+		compatible = "XVGA", "panel-dpi";
+		port {
+			clcd_xvga_panel: endpoint {
+				remote-endpoint = <&clcd_xvga_pads>;
+			};
+		};
+
+		/* Standard 1024x768 XVGA timings */
+		panel-timing {
+			clock-frequency = <63500127>;
+			pixelclk-active = <0>;
+			hactive = <1024>;
+			hback-porch = <152>;
+			hfront-porch = <48>;
+			hsync-len = <104>;
+			vactive = <768>;
+			vback-porch = <23>;
+			vfront-porch = <3>;
+			vsync-len = <4>;
+		};
+	};
+
+	sanyo38_panel {
+		compatible = "sanyo,tm38qv67a02a", "panel-dpi";
+		port {
+			clcd_sanyo38_panel: endpoint {
+				remote-endpoint = <&clcd_sanyo38_pads>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <10000000>;
+			pixelclk-active = <1>;
+			hactive = <320>;
+			hback-porch = <6>;
+			hfront-porch = <6>;
+			hsync-len = <6>;
+			vactive = <240>;
+			vback-porch = <6>;
+			vfront-porch = <6>;
+			vsync-len = <0>;
+		};
+	};
+
+	sharp84_panel {
+		compatible = "sharp,lq084v1dg21", "panel-dpi";
+		port {
+			clcd_sharp84_panel: endpoint {
+				remote-endpoint = <&clcd_sharp84_pads>;
+			};
+		};
+
+		/* Standard 640x480 VGA timings */
+		panel-timing {
+			clock-frequency = <25175000>;
+			pixelclk-active = <0>;
+			hactive = <640>;
+			hback-porch = <48>;
+			hfront-porch = <16>;
+			hsync-len = <96>;
+			vactive = <480>;
+			vback-porch = <33>;
+			vfront-porch = <10>;
+			vsync-len = <2>;
+		};
+	};
+
+	/*
+	 * The IB2 has a Sanyo ALR252RGT QVGA panel mounted.
+	 */
+	sanyo25_panel {
+		compatible = "sanyo,alr252rgt", "panel-dpi";
+		port {
+			clcd_sanyo25_panel: endpoint {
+				remote-endpoint = <&clcd_sanyo25_pads>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <5440000>;
+			pixelclk-active = <0>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			hactive = <240>;
+			hback-porch = <20>;
+			hfront-porch = <10>;
+			hsync-len = <10>;
+			vactive = <320>;
+			vback-porch = <2>;
+			vfront-porch = <2>;
+			vsync-len = <2>;
+		};
+	};
+
+	epson_panel {
+		compatible = "epson,l2f50113t00", "panel-dpi";
+		port {
+			clcd_epson_panel: endpoint {
+				remote-endpoint = <&clcd_epson_pads>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <16000000>;
+			pixelclk-active = <0>;
+			hactive = <176>;
+			hback-porch = <3>;
+			hfront-porch = <2>;
+			hsync-len = <3>;
+			vactive = <220>;
+			vback-porch = <1>;
+			vfront-porch = <0>;
+			vsync-len = <2>;
+		};
+	};
+
 	core-module@10000000 {
 		compatible = "arm,core-module-versatile", "syscon", "simple-mfd";
 		reg = <0x10000000 0x200>;
@@ -93,10 +234,20 @@
 			default-state = "off";
 		};
 
-		/* OSC1 on AB, OSC4 on PB */
-		osc1: cm_aux_osc@24M {
+		oscclk0: osc0@0c {
+			compatible = "arm,syscon-icst307";
 			#clock-cells = <0>;
-			compatible = "arm,versatile-cm-auxosc";
+			lock-offset = <0x20>;
+			vco-offset = <0x0C>;
+			clocks = <&xtal24mhz>;
+		};
+
+		/* This is called OSC1 on AB, OSC4 on PB, call it OSC4 here */
+		oscclk4: osc4@1c {
+			compatible = "arm,syscon-icst307";
+			#clock-cells = <0>;
+			lock-offset = <0x20>;
+			vco-offset = <0x1C>;
 			clocks = <&xtal24mhz>;
 		};
 
@@ -227,8 +378,52 @@
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0x10120000 0x1000>;
 			interrupts = <16>;
-			clocks = <&osc1>, <&pclk>;
+			clocks = <&oscclk4>, <&pclk>;
 			clock-names = "clcd", "apb_pclk";
+			/* 16bpp @ 25.175MHz = 50350000 bytes per second */
+			max-memory-bandwidth = <50350000>;
+
+			port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				/*
+				 * The CLCD connects to either of these panels.
+				 * at run-time, board-specific code will
+				 * detect and select the right one. If no
+				 * panel is detected, the first one (VGA)
+				 * will be used by default.
+				 */
+				clcd_vga_pads: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&clcd_vga_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <1 7 13>;
+				};
+				clcd_xvga_pads: endpoint@1 {
+					reg = <1>;
+					remote-endpoint = <&clcd_xvga_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <1 7 13>;
+				};
+				clcd_sanyo38_pads: endpoint@2 {
+					reg = <2>;
+					remote-endpoint = <&clcd_sanyo38_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+				};
+				clcd_sharp84_pads: endpoint@3 {
+					reg = <3>;
+					remote-endpoint = <&clcd_sharp84_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+				};
+				clcd_sanyo25_pads: endpoint@4 {
+					reg = <4>;
+					remote-endpoint = <&clcd_sanyo25_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+				};
+				clcd_epson_pads: endpoint@5 {
+					reg = <5>;
+					remote-endpoint = <&clcd_epson_panel>;
+					arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
+				};
+			};
 		};
 
 		sctl@101e0000 {
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index c44871851255..ebe27945fea5 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -29,8 +29,6 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/amba/bus.h>
-#include <linux/amba/clcd.h>
-#include <linux/platform_data/video-clcd-versatile.h>
 #include <linux/amba/mmci.h>
 #include <linux/mtd/physmap.h>
 #include <asm/mach-types.h>
@@ -57,7 +55,6 @@
 #define VERSATILE_SYS_PCICTL_OFFSET           0x44
 #define VERSATILE_SYS_MCI_OFFSET              0x48
 #define VERSATILE_SYS_FLASH_OFFSET            0x4C
-#define VERSATILE_SYS_CLCD_OFFSET             0x50
 
 /*
  * VERSATILE_SYS_FLASH
@@ -69,10 +66,7 @@
  */
 #define VERSATILE_MMCI0_BASE           0x10005000	/* MMC interface */
 #define VERSATILE_MMCI1_BASE           0x1000B000	/* MMC Interface */
-#define VERSATILE_CLCD_BASE            0x10120000	/* CLCD */
 #define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
-#define VERSATILE_IB2_BASE             0x24000000	/* IB2 module */
-#define VERSATILE_IB2_CTL_BASE		(VERSATILE_IB2_BASE + 0x03000000)
 
 /*
  * System controller bit assignment
@@ -86,7 +80,6 @@
 #define VERSATILE_TIMER4_EnSel	21
 
 static void __iomem *versatile_sys_base;
-static void __iomem *versatile_ib2_ctrl;
 
 static void versatile_flash_set_vpp(struct platform_device *pdev, int on)
 {
@@ -149,158 +142,6 @@ static struct mmci_platform_data mmc1_plat_data = {
 };
 
 /*
- * CLCD support.
- */
-#define SYS_CLCD_MODE_MASK	(3 << 0)
-#define SYS_CLCD_MODE_888	(0 << 0)
-#define SYS_CLCD_MODE_5551	(1 << 0)
-#define SYS_CLCD_MODE_565_RLSB	(2 << 0)
-#define SYS_CLCD_MODE_565_BLSB	(3 << 0)
-#define SYS_CLCD_NLCDIOON	(1 << 2)
-#define SYS_CLCD_VDDPOSSWITCH	(1 << 3)
-#define SYS_CLCD_PWR3V5SWITCH	(1 << 4)
-#define SYS_CLCD_ID_MASK	(0x1f << 8)
-#define SYS_CLCD_ID_SANYO_3_8	(0x00 << 8)
-#define SYS_CLCD_ID_UNKNOWN_8_4	(0x01 << 8)
-#define SYS_CLCD_ID_EPSON_2_2	(0x02 << 8)
-#define SYS_CLCD_ID_SANYO_2_5	(0x07 << 8)
-#define SYS_CLCD_ID_VGA		(0x1f << 8)
-
-static bool is_sanyo_2_5_lcd;
-
-/*
- * Disable all display connectors on the interface module.
- */
-static void versatile_clcd_disable(struct clcd_fb *fb)
-{
-	void __iomem *sys_clcd = versatile_sys_base + VERSATILE_SYS_CLCD_OFFSET;
-	u32 val;
-
-	val = readl(sys_clcd);
-	val &= ~SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
-	writel(val, sys_clcd);
-
-	/*
-	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light off
-	 */
-	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
-		unsigned long ctrl;
-
-		ctrl = readl(versatile_ib2_ctrl);
-		ctrl &= ~0x01;
-		writel(ctrl, versatile_ib2_ctrl);
-	}
-}
-
-/*
- * Enable the relevant connector on the interface module.
- */
-static void versatile_clcd_enable(struct clcd_fb *fb)
-{
-	struct fb_var_screeninfo *var = &fb->fb.var;
-	void __iomem *sys_clcd = versatile_sys_base + VERSATILE_SYS_CLCD_OFFSET;
-	u32 val;
-
-	val = readl(sys_clcd);
-	val &= ~SYS_CLCD_MODE_MASK;
-
-	switch (var->green.length) {
-	case 5:
-		val |= SYS_CLCD_MODE_5551;
-		break;
-	case 6:
-		if (var->red.offset = 0)
-			val |= SYS_CLCD_MODE_565_RLSB;
-		else
-			val |= SYS_CLCD_MODE_565_BLSB;
-		break;
-	case 8:
-		val |= SYS_CLCD_MODE_888;
-		break;
-	}
-
-	/*
-	 * Set the MUX
-	 */
-	writel(val, sys_clcd);
-
-	/*
-	 * And now enable the PSUs
-	 */
-	val |= SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH;
-	writel(val, sys_clcd);
-
-	/*
-	 * If the LCD is Sanyo 2x5 in on the IB2 board, turn the back-light on
-	 */
-	if (of_machine_is_compatible("arm,versatile-ab") && is_sanyo_2_5_lcd) {
-		unsigned long ctrl;
-
-		ctrl = readl(versatile_ib2_ctrl);
-		ctrl |= 0x01;
-		writel(ctrl, versatile_ib2_ctrl);
-	}
-}
-
-/*
- * Detect which LCD panel is connected, and return the appropriate
- * clcd_panel structure.  Note: we do not have any information on
- * the required timings for the 8.4in panel, so we presently assume
- * VGA timings.
- */
-static int versatile_clcd_setup(struct clcd_fb *fb)
-{
-	void __iomem *sys_clcd = versatile_sys_base + VERSATILE_SYS_CLCD_OFFSET;
-	const char *panel_name;
-	u32 val;
-
-	is_sanyo_2_5_lcd = false;
-
-	val = readl(sys_clcd) & SYS_CLCD_ID_MASK;
-	if (val = SYS_CLCD_ID_SANYO_3_8)
-		panel_name = "Sanyo TM38QV67A02A";
-	else if (val = SYS_CLCD_ID_SANYO_2_5) {
-		panel_name = "Sanyo QVGA Portrait";
-		is_sanyo_2_5_lcd = true;
-	} else if (val = SYS_CLCD_ID_EPSON_2_2)
-		panel_name = "Epson L2F50113T00";
-	else if (val = SYS_CLCD_ID_VGA)
-		panel_name = "VGA";
-	else {
-		printk(KERN_ERR "CLCD: unknown LCD panel ID 0x%08x, using VGA\n",
-			val);
-		panel_name = "VGA";
-	}
-
-	fb->panel = versatile_clcd_get_panel(panel_name);
-	if (!fb->panel)
-		return -EINVAL;
-
-	return versatile_clcd_setup_dma(fb, SZ_1M);
-}
-
-static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
-{
-	clcdfb_decode(fb, regs);
-
-	/* Always clear BGR for RGB565: we do the routing externally */
-	if (fb->fb.var.green.length = 6)
-		regs->cntl &= ~CNTL_BGR;
-}
-
-static struct clcd_board clcd_plat_data = {
-	.name		= "Versatile",
-	.caps		= CLCD_CAP_5551 | CLCD_CAP_565 | CLCD_CAP_888,
-	.check		= clcdfb_check,
-	.decode		= versatile_clcd_decode,
-	.disable	= versatile_clcd_disable,
-	.enable		= versatile_clcd_enable,
-	.setup		= versatile_clcd_setup,
-	.mmap		= versatile_clcd_mmap_dma,
-	.remove		= versatile_clcd_remove_dma,
-};
-
-/*
  * Lookup table for attaching a specific name and platform_data pointer to
  * devices as they get created by of_platform_populate().  Ideally this table
  * would not exist, but the current clock implementation depends on some devices
@@ -309,7 +150,6 @@ static struct clcd_board clcd_plat_data = {
 struct of_dev_auxdata versatile_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI0_BASE, "fpga:05", &mmc0_plat_data),
 	OF_DEV_AUXDATA("arm,primecell", VERSATILE_MMCI1_BASE, "fpga:0b", &mmc1_plat_data),
-	OF_DEV_AUXDATA("arm,primecell", VERSATILE_CLCD_BASE, "dev:20", &clcd_plat_data),
 	{}
 };
 
@@ -400,8 +240,6 @@ static void __init versatile_dt_init(void)
 		versatile_sys_base = of_iomap(np, 0);
 	WARN_ON(!versatile_sys_base);
 
-	versatile_ib2_ctrl = ioremap(VERSATILE_IB2_CTL_BASE, SZ_4K);
-
 	versatile_dt_pci_init();
 
 	platform_device_register(&versatile_flash_device);
-- 
2.4.3

