From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Feb 2016 14:04:17 +0000
Subject: [PATCH 08/11] video: ARM CLCD: add special panel hook for Versatiles
Message-Id: <1454594660-7532-9-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds a special panel init hook for the ARM reference designs
Integrator (IM-PD1), Versatile and RealView, so we can configure
a DPI panel from device tree and have it working without
boardfiles for these machines.

Basically this is the same code as from the board files, just
moved over to look up the syscon DT node and manipulate the
special CLCD register from their regmap.

Tested on RealView PB11MPcore.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/Kconfig               |   2 +
 drivers/video/fbdev/amba-clcd-versatile.c | 406 ++++++++++++++++++++++++++++++
 drivers/video/fbdev/amba-clcd-versatile.h |  17 ++
 drivers/video/fbdev/amba-clcd.c           |   4 +-
 4 files changed, 428 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/amba-clcd-versatile.h

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 6dcd91237551..a3fdc4cd1837 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -307,6 +307,8 @@ config PLAT_VERSATILE_CLCD
 	def_bool ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_INTEGRATOR
 	depends on ARM
 	depends on FB_ARMCLCD && FB=y
+	select REGMAP
+	select MFD_SYSCON
 
 config FB_ACORN
 	bool "Acorn VIDC support"
diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
index 7a8afcd4573e..5d125f77215d 100644
--- a/drivers/video/fbdev/amba-clcd-versatile.c
+++ b/drivers/video/fbdev/amba-clcd-versatile.c
@@ -3,6 +3,12 @@
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
 #include <linux/platform_data/video-clcd-versatile.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/bitops.h>
+#include "amba-clcd-versatile.h"
 
 static struct clcd_panel vga = {
 	.mode		= {
@@ -180,3 +186,403 @@ void versatile_clcd_remove_dma(struct clcd_fb *fb)
 	dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
 			      fb->fb.screen_base, fb->fb.fix.smem_start);
 }
+
+#ifdef CONFIG_OF
+
+static struct regmap *versatile_syscon_map;
+static struct regmap *versatile_ib2_map;
+
+/*
+ * We detect the different syscon types from the compatible strings.
+ */
+enum versatile_clcd {
+	INTEGRATOR_CLCD_CM,
+	VERSATILE_CLCD,
+	REALVIEW_CLCD_EB,
+	REALVIEW_CLCD_PB1176,
+	REALVIEW_CLCD_PB11MP,
+	REALVIEW_CLCD_PBA8,
+	REALVIEW_CLCD_PBX,
+};
+
+static const struct of_device_id versatile_clcd_of_match[] = {
+	{
+		.compatible = "arm,core-module-integrator",
+		.data = (void *)INTEGRATOR_CLCD_CM,
+	},
+	{
+		.compatible = "arm,versatile-sysreg",
+		.data = (void *)VERSATILE_CLCD,
+	},
+	{
+		.compatible = "arm,realview-eb-syscon",
+		.data = (void *)REALVIEW_CLCD_EB,
+	},
+	{
+		.compatible = "arm,realview-pb1176-syscon",
+		.data = (void *)REALVIEW_CLCD_PB1176,
+	},
+	{
+		.compatible = "arm,realview-pb11mp-syscon",
+		.data = (void *)REALVIEW_CLCD_PB11MP,
+	},
+	{
+		.compatible = "arm,realview-pba8-syscon",
+		.data = (void *)REALVIEW_CLCD_PBA8,
+	},
+	{
+		.compatible = "arm,realview-pbx-syscon",
+		.data = (void *)REALVIEW_CLCD_PBX,
+	},
+	{},
+};
+
+/*
+ * Core module CLCD control on the Integrator/CP, bits
+ * 8 thru 19 of the CM_CONTROL register controls a bunch
+ * of CLCD settings.
+ */
+#define INTEGRATOR_HDR_CTRL_OFFSET	0x0C
+#define INTEGRATOR_CLCD_LCDBIASEN	BIT(8)
+#define INTEGRATOR_CLCD_LCDBIASUP	BIT(9)
+#define INTEGRATOR_CLCD_LCDBIASDN	BIT(10)
+/* Bits 11,12,13 controls the LCD type */
+#define INTEGRATOR_CLCD_LCDMUX_MASK	(BIT(11)|BIT(12)|BIT(13))
+#define INTEGRATOR_CLCD_LCDMUX_LCD24	BIT(11)
+#define INTEGRATOR_CLCD_LCDMUX_VGA565	BIT(12)
+#define INTEGRATOR_CLCD_LCDMUX_SHARP	(BIT(11)|BIT(12))
+#define INTEGRATOR_CLCD_LCDMUX_VGA555	BIT(13)
+#define INTEGRATOR_CLCD_LCDMUX_VGA24	(BIT(11)|BIT(12)|BIT(13))
+#define INTEGRATOR_CLCD_LCD0_EN		BIT(14)
+#define INTEGRATOR_CLCD_LCD1_EN		BIT(15)
+/* R/L flip on Sharp */
+#define INTEGRATOR_CLCD_LCD_STATIC1	BIT(16)
+/* U/D flip on Sharp */
+#define INTEGRATOR_CLCD_LCD_STATIC2	BIT(17)
+/* No connection on Sharp */
+#define INTEGRATOR_CLCD_LCD_STATIC	BIT(18)
+/* 0 = 24bit VGA, 1 = 18bit VGA */
+#define INTEGRATOR_CLCD_LCD_N24BITEN	BIT(19)
+
+#define INTEGRATOR_CLCD_MASK		(INTEGRATOR_CLCD_LCDMUX_MASK | \
+					 INTEGRATOR_CLCD_LCD0_EN | \
+					 INTEGRATOR_CLCD_LCD1_EN | \
+					 INTEGRATOR_CLCD_LCD_STATIC1 | \
+					 INTEGRATOR_CLCD_LCD_STATIC2 | \
+					 INTEGRATOR_CLCD_LCD_STATIC | \
+					 INTEGRATOR_CLCD_LCD_N24BITEN)
+
+static void integrator_clcd_enable(struct clcd_fb *fb)
+{
+	struct fb_var_screeninfo *var = &fb->fb.var;
+	u32 val;
+
+	dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");
+
+	val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
+		INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
+	if (var->bits_per_pixel <= 8 ||
+	    (var->bits_per_pixel = 16 && var->green.length = 5))
+		/* Pseudocolor, RGB555, BGR555 */
+		val |= INTEGRATOR_CLCD_LCDMUX_VGA555;
+	else if (fb->fb.var.bits_per_pixel <= 16)
+		/* truecolor RGB565 */
+		val |= INTEGRATOR_CLCD_LCDMUX_VGA565;
+	else
+		val = 0; /* no idea for this, don't trust the docs */
+
+	regmap_update_bits(versatile_syscon_map,
+			   INTEGRATOR_HDR_CTRL_OFFSET,
+			   0,
+			   INTEGRATOR_CLCD_MASK);
+}
+
+/*
+ * This configuration register in the Versatile and RealView
+ * family is uniformly present but appears more and more
+ * unutilized starting with the RealView series.
+ */
+#define SYS_CLCD			0x50
+#define SYS_CLCD_MODE_MASK		(BIT(0)|BIT(1))
+#define SYS_CLCD_MODE_888		0
+#define SYS_CLCD_MODE_5551		BIT(0)
+#define SYS_CLCD_MODE_565_R_LSB		BIT(1)
+#define SYS_CLCD_MODE_565_B_LSB		(BIT(0)|BIT(1))
+#define SYS_CLCD_CONNECTOR_MASK		(BIT(2)|BIT(3)|BIT(4)|BIT(5))
+#define SYS_CLCD_NLCDIOON		BIT(2)
+#define SYS_CLCD_VDDPOSSWITCH		BIT(3)
+#define SYS_CLCD_PWR3V5SWITCH		BIT(4)
+#define SYS_CLCD_VDDNEGSWITCH		BIT(5)
+#define SYS_CLCD_TSNSS			BIT(6) /* touchscreen enable */
+#define SYS_CLCD_SSPEXP			BIT(7) /* SSP expansion enable */
+
+/* The Versatile can detect the connected panel type */
+#define SYS_CLCD_CLCDID_MASK		(BIT(8)|BIT(9)|BIT(10)|BIT(11)|BIT(12))
+#define SYS_CLCD_ID_SANYO_3_8		(0x00 << 8)
+#define SYS_CLCD_ID_SHARP_8_4		(0x01 << 8)
+#define SYS_CLCD_ID_EPSON_2_2		(0x02 << 8)
+#define SYS_CLCD_ID_SANYO_2_5		(0x07 << 8)
+#define SYS_CLCD_ID_VGA			(0x1f << 8)
+
+#define SYS_CLCD_TSNDAV			BIT(13) /* data ready from TS */
+
+/* IB2 control register for the Versatile daughterboard */
+#define IB2_CTRL			0x00
+#define IB2_CTRL_LCD_SD			BIT(1) /* 1 = shut down LCD */
+#define IB2_CTRL_LCD_BL_ON		BIT(0)
+#define IB2_CTRL_LCD_MASK		(BIT(0)|BIT(1))
+
+static void versatile_clcd_disable(struct clcd_fb *fb)
+{
+	dev_info(&fb->dev->dev, "disable Versatile CLCD connectors\n");
+	regmap_update_bits(versatile_syscon_map,
+			   SYS_CLCD,
+			   SYS_CLCD_CONNECTOR_MASK,
+			   0);
+
+	/* If we're on an IB2 daughterboard, turn off display */
+	if (versatile_ib2_map) {
+		dev_info(&fb->dev->dev, "disable IB2 display\n");
+		regmap_update_bits(versatile_ib2_map,
+				   IB2_CTRL,
+				   IB2_CTRL_LCD_MASK,
+				   IB2_CTRL_LCD_SD);
+	}
+}
+
+static void versatile_clcd_enable(struct clcd_fb *fb)
+{
+	struct fb_var_screeninfo *var = &fb->fb.var;
+	u32 val = 0;
+
+	dev_info(&fb->dev->dev, "enable Versatile CLCD connectors\n");
+	switch (var->green.length) {
+	case 5:
+		val |= SYS_CLCD_MODE_5551;
+		break;
+	case 6:
+		if (var->red.offset = 0)
+			val |= SYS_CLCD_MODE_565_R_LSB;
+		else
+			val |= SYS_CLCD_MODE_565_B_LSB;
+		break;
+	case 8:
+		val |= SYS_CLCD_MODE_888;
+		break;
+	}
+
+	/* Set up the MUX */
+	regmap_update_bits(versatile_syscon_map,
+			   SYS_CLCD,
+			   SYS_CLCD_MODE_MASK,
+			   val);
+
+	/* Then enable the display */
+	regmap_update_bits(versatile_syscon_map,
+			   SYS_CLCD,
+			   SYS_CLCD_CONNECTOR_MASK,
+			   SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH);
+
+	/* If we're on an IB2 daughterboard, turn on display */
+	if (versatile_ib2_map) {
+		dev_info(&fb->dev->dev, "enable IB2 display\n");
+		regmap_update_bits(versatile_ib2_map,
+				   IB2_CTRL,
+				   IB2_CTRL_LCD_MASK,
+				   IB2_CTRL_LCD_BL_ON);
+	}
+}
+
+static void versatile_clcd_decode(struct clcd_fb *fb, struct clcd_regs *regs)
+{
+	clcdfb_decode(fb, regs);
+
+	/* Always clear BGR for RGB565: we do the routing externally */
+	if (fb->fb.var.green.length = 6)
+		regs->cntl &= ~CNTL_BGR;
+}
+
+static void realview_clcd_disable(struct clcd_fb *fb)
+{
+	dev_info(&fb->dev->dev, "disable RealView CLCD connectors\n");
+	regmap_update_bits(versatile_syscon_map,
+			   SYS_CLCD,
+			   SYS_CLCD_CONNECTOR_MASK,
+			   0);
+}
+
+static void realview_clcd_enable(struct clcd_fb *fb)
+{
+	dev_info(&fb->dev->dev, "enable RealView CLCD connectors\n");
+	regmap_update_bits(versatile_syscon_map,
+			   SYS_CLCD,
+			   SYS_CLCD_CONNECTOR_MASK,
+			   SYS_CLCD_NLCDIOON | SYS_CLCD_PWR3V5SWITCH);
+}
+
+struct versatile_panel {
+	u32 id;
+	char *compatible;
+	bool ib2;
+};
+
+static const struct versatile_panel versatile_panels[] = {
+	{
+		.id = SYS_CLCD_ID_VGA,
+		.compatible = "VGA",
+	},
+	{
+		.id = SYS_CLCD_ID_SANYO_3_8,
+		.compatible = "sanyo,tm38qv67a02a",
+	},
+	{
+		.id = SYS_CLCD_ID_SHARP_8_4,
+		.compatible = "sharp,lq084v1dg21",
+	},
+	{
+		.id = SYS_CLCD_ID_EPSON_2_2,
+		.compatible = "epson,l2f50113t00",
+	},
+	{
+		.id = SYS_CLCD_ID_SANYO_2_5,
+		.compatible = "sanyo,alr252rgt",
+		.ib2 = true,
+	},
+};
+
+static void versatile_panel_probe(struct device *dev,
+				  struct device_node **endpoint)
+{
+	struct versatile_panel const *vpanel = NULL;
+	struct device_node *ep = NULL;
+	struct device_node *panel = NULL;
+	u32 val;
+	int ret;
+	int i;
+
+	/*
+	 * The Versatile CLCD has a panel auto-detection mechanism.
+	 * We use this and look for the compatible panel in the
+	 * device tree.
+	 */
+	ret = regmap_read(versatile_syscon_map, SYS_CLCD, &val);
+	if (ret) {
+		dev_err(dev, "cannot read CLCD syscon register\n");
+		return;
+	}
+	val &= SYS_CLCD_CLCDID_MASK;
+	dev_info(dev, "SYS_CLCD=%08x\n", val);
+
+	/* First find corresponding panel information */
+	for (i = 0; i < ARRAY_SIZE(versatile_panels); i++) {
+		vpanel = &versatile_panels[i];
+
+		if (val = vpanel->id) {
+			dev_err(dev, "autodetected panel \"%s\"\n",
+				vpanel->compatible);
+			break;
+		}
+	}
+	if (i = ARRAY_SIZE(versatile_panels)) {
+		dev_err(dev, "could not auto-detect panel\n");
+		return;
+	}
+
+	/* Then look for a compatible endpoint/panel */
+	for_each_endpoint_of_node(dev->of_node, ep) {
+		panel = of_graph_get_remote_port_parent(ep);
+		if (!panel) {
+			dev_err(dev, "could not locate remote port for panel\n");
+			return;
+		}
+
+		if (of_device_is_compatible(panel, vpanel->compatible))
+			break;
+	}
+	if (ep = NULL) {
+		dev_err(dev, "could not find a panel compatible with \"%s\"\n",
+			vpanel->compatible);
+		return;
+	}
+
+
+	/*
+	 * If we have a Sanyo 2.5" port
+	 * that we're running on an IB2 and proceed to look for the
+	 * IB2 syscon regmap.
+	 */
+	if (!vpanel->ib2) {
+		/* Tell the driver to use this panel */
+		*endpoint = ep;
+		return;
+	}
+
+	versatile_ib2_map = syscon_regmap_lookup_by_compatible(
+		"arm,versatile-ib2-syscon");
+	if (IS_ERR(versatile_ib2_map)) {
+		dev_err(dev, "could not locate IB2 control register\n");
+		versatile_ib2_map = NULL;
+		return;
+	}
+	*endpoint = ep;
+}
+
+int versatile_clcd_init_panel(struct clcd_fb *fb,
+			      struct device_node **endpoint)
+{
+	const struct of_device_id *clcd_id;
+	enum versatile_clcd versatile_clcd_type;
+	struct device_node *np;
+	struct regmap *map;
+	struct device *dev = &fb->dev->dev;
+
+	np = of_find_matching_node_and_match(NULL, versatile_clcd_of_match,
+					     &clcd_id);
+	if (!np) {
+		dev_err(dev, "no Versatile syscon node\n");
+		return -ENODEV;
+	}
+	versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
+
+	map = syscon_node_to_regmap(np);
+	if (!map) {
+		dev_err(dev, "no Versatile syscon regmap\n");
+		return -ENODEV;
+	}
+
+	switch (versatile_clcd_type) {
+	case INTEGRATOR_CLCD_CM:
+		versatile_syscon_map = map;
+		fb->board->enable = integrator_clcd_enable;
+		/* Override the caps, we have only these */
+		fb->board->caps = CLCD_CAP_5551 | CLCD_CAP_RGB565 |
+			CLCD_CAP_888;
+		dev_info(dev, "set up callbacks for Integrator PL110\n");
+		break;
+	case VERSATILE_CLCD:
+		versatile_syscon_map = map;
+		fb->board->enable = versatile_clcd_enable;
+		fb->board->disable = versatile_clcd_disable;
+		fb->board->decode = versatile_clcd_decode;
+		versatile_panel_probe(dev, endpoint);
+		dev_info(dev, "set up callbacks for Versatile\n");
+		break;
+	case REALVIEW_CLCD_EB:
+	case REALVIEW_CLCD_PB1176:
+	case REALVIEW_CLCD_PB11MP:
+	case REALVIEW_CLCD_PBA8:
+	case REALVIEW_CLCD_PBX:
+		versatile_syscon_map = map;
+		fb->board->enable = realview_clcd_enable;
+		fb->board->disable = realview_clcd_disable;
+		dev_info(dev, "set up callbacks for RealView PL111\n");
+		break;
+	default:
+		dev_info(dev, "unknown Versatile system controller\n");
+		break;
+	}
+
+	return 0;
+}
+
+#endif
diff --git a/drivers/video/fbdev/amba-clcd-versatile.h b/drivers/video/fbdev/amba-clcd-versatile.h
new file mode 100644
index 000000000000..dc44557a2466
--- /dev/null
+++ b/drivers/video/fbdev/amba-clcd-versatile.h
@@ -0,0 +1,17 @@
+/*
+ * Special local versatile callbacks
+ */
+#include <linux/of.h>
+#include <linux/amba/bus.h>
+#include <linux/platform_data/video-clcd-versatile.h>
+
+#if defined(CONFIG_PLAT_VERSATILE_CLCD) && defined(CONFIG_OF)
+int versatile_clcd_init_panel(struct clcd_fb *fb,
+			      struct device_node **endpoint);
+#else
+static inline int versatile_clcd_init_panel(struct clcd_fb *fb,
+				struct device_node **endpoint)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 53c5ec31168d..e1897cb657f5 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -38,6 +38,7 @@
 #include <asm/sizes.h>
 
 #include "amba-clcd-nomadik.h"
+#include "amba-clcd-versatile.h"
 
 #define to_clcd(info)	container_of(info, struct clcd_fb, fb)
 
@@ -1042,7 +1043,8 @@ static int clcdfb_remove(struct amba_device *dev)
 }
 
 static struct clcd_vendor_data vendor_arm = {
-	/* No special business */
+	/* Sets up the versatile board displays */
+	.init_panel = versatile_clcd_init_panel,
 };
 
 static struct clcd_vendor_data vendor_nomadik = {
-- 
2.4.3

