From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Feb 2016 10:01:43 +0000
Subject: [PATCH 6/7 v2] video: ARM CLCD: add special board and panel hooks for Nomadik
Message-Id: <1456221704-5792-7-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

In the .board_init() callback will set up a mux register in
the Nomadik system controller. It so happens that the platform
has two display output engines, and we have to poke a bit in
a special register to make sure the right engine is muxed in
as they are mutually exclusive.

The Nomadik CLCD variant is instantiated on a platform where
it is combined with a 800x480 TPO WVGA display. In the
.panel_init() hook we will detect this display from the
compatible string and set it up. We also add .enable() and
.disable() callbacks for it as the sleep state is software
controlled.

The display is connected with a special 3-wire serial bus
(this is sadly neither I2C or SPI) using three GPIO lines that
we bitbang to detect the display and enable/disable sleep
state.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- No changes. Just reposting.
---
 drivers/video/fbdev/Makefile            |   1 +
 drivers/video/fbdev/amba-clcd-nomadik.c | 257 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/amba-clcd-nomadik.h |  24 +++
 drivers/video/fbdev/amba-clcd.c         |   6 +-
 4 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 create mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h

diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 65fb15075c8f..f0aec3aa213c 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_FB_ATMEL)		  += atmel_lcdfb.o
 obj-$(CONFIG_FB_PVR2)             += pvr2fb.o
 obj-$(CONFIG_FB_VOODOO1)          += sstfb.o
 obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o
+obj-$(CONFIG_ARCH_NOMADIK)	  += amba-clcd-nomadik.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += amba-clcd-versatile.o
 obj-$(CONFIG_FB_GOLDFISH)         += goldfishfb.o
 obj-$(CONFIG_FB_68328)            += 68328fb.o
diff --git a/drivers/video/fbdev/amba-clcd-nomadik.c b/drivers/video/fbdev/amba-clcd-nomadik.c
new file mode 100644
index 000000000000..243167c8ee15
--- /dev/null
+++ b/drivers/video/fbdev/amba-clcd-nomadik.c
@@ -0,0 +1,257 @@
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+
+#include "amba-clcd-nomadik.h"
+
+static struct gpio_desc *grestb;
+static struct gpio_desc *scen;
+static struct gpio_desc *scl;
+static struct gpio_desc *sda;
+
+static u8 tpg110_readwrite_reg(bool write, u8 address, u8 outval)
+{
+	int i;
+	u8 inval = 0;
+
+	/* Assert SCEN */
+	gpiod_set_value_cansleep(scen, 1);
+	ndelay(150);
+	/* Hammer out the address */
+	for (i = 5; i >= 0; i--) {
+		if (address & BIT(i))
+			gpiod_set_value_cansleep(sda, 1);
+		else
+			gpiod_set_value_cansleep(sda, 0);
+		ndelay(150);
+		/* Send an SCL pulse */
+		gpiod_set_value_cansleep(scl, 1);
+		ndelay(160);
+		gpiod_set_value_cansleep(scl, 0);
+		ndelay(160);
+	}
+
+	if (write) {
+		/* WRITE */
+		gpiod_set_value_cansleep(sda, 0);
+	} else {
+		/* READ */
+		gpiod_set_value_cansleep(sda, 1);
+	}
+	ndelay(150);
+	/* Send an SCL pulse */
+	gpiod_set_value_cansleep(scl, 1);
+	ndelay(160);
+	gpiod_set_value_cansleep(scl, 0);
+	ndelay(160);
+
+	if (!write)
+		/* HiZ turn-around cycle */
+		gpiod_direction_input(sda);
+	ndelay(150);
+	/* Send an SCL pulse */
+	gpiod_set_value_cansleep(scl, 1);
+	ndelay(160);
+	gpiod_set_value_cansleep(scl, 0);
+	ndelay(160);
+
+	/* Hammer in/out the data */
+	for (i = 7; i >= 0; i--) {
+		int value;
+
+		if (write) {
+			value = !!(outval & BIT(i));
+			gpiod_set_value_cansleep(sda, value);
+		} else {
+			value = gpiod_get_value(sda);
+			if (value)
+				inval |= BIT(i);
+		}
+		ndelay(150);
+		/* Send an SCL pulse */
+		gpiod_set_value_cansleep(scl, 1);
+		ndelay(160);
+		gpiod_set_value_cansleep(scl, 0);
+		ndelay(160);
+	}
+
+	gpiod_direction_output(sda, 0);
+	/* Deassert SCEN */
+	gpiod_set_value_cansleep(scen, 0);
+	/* Satisfies SCEN pulse width */
+	udelay(1);
+
+	return inval;
+}
+
+static u8 tpg110_read_reg(u8 address)
+{
+	return tpg110_readwrite_reg(false, address, 0);
+}
+
+static void tpg110_write_reg(u8 address, u8 outval)
+{
+	tpg110_readwrite_reg(true, address, outval);
+}
+
+static void tpg110_startup(struct device *dev)
+{
+	u8 val;
+
+	dev_info(dev, "TPG110 display enable\n");
+	/* De-assert the reset signal */
+	gpiod_set_value_cansleep(grestb, 0);
+	mdelay(1);
+	dev_info(dev, "de-asserted GRESTB\n");
+
+	/* Test display communication */
+	tpg110_write_reg(0x00, 0x55);
+	val = tpg110_read_reg(0x00);
+	if (val = 0x55)
+		dev_info(dev, "passed communication test\n");
+	val = tpg110_read_reg(0x01);
+	dev_info(dev, "TPG110 chip ID: %d version: %d\n",
+		val>>4, val&0x0f);
+
+	/* Show display resolution */
+	val = tpg110_read_reg(0x02);
+	val &= 7;
+	switch (val) {
+	case 0x0:
+		dev_info(dev, "IN 400x240 RGB -> OUT 800x480 RGB (dual scan)");
+		break;
+	case 0x1:
+		dev_info(dev, "IN 480x272 RGB -> OUT 800x480 RGB (dual scan)");
+		break;
+	case 0x4:
+		dev_info(dev, "480x640 RGB");
+		break;
+	case 0x5:
+		dev_info(dev, "480x272 RGB");
+		break;
+	case 0x6:
+		dev_info(dev, "640x480 RGB");
+		break;
+	case 0x7:
+		dev_info(dev, "800x480 RGB");
+		break;
+	default:
+		dev_info(dev, "ILLEGAL RESOLUTION");
+		break;
+	}
+
+	val = tpg110_read_reg(0x03);
+	dev_info(dev, "resolution is controlled by %s\n",
+		(val & BIT(7)) ? "software" : "hardware");
+}
+
+static void tpg110_enable(struct clcd_fb *fb)
+{
+	struct device *dev = &fb->dev->dev;
+	static bool startup;
+	u8 val;
+
+	if (!startup) {
+		tpg110_startup(dev);
+		startup = true;
+	}
+
+	/* Take chip out of standby */
+	val = tpg110_read_reg(0x03);
+	val |= BIT(0);
+	tpg110_write_reg(0x03, val);
+}
+
+static void tpg110_disable(struct clcd_fb *fb)
+{
+	u8 val;
+
+	dev_info(&fb->dev->dev, "TPG110 display disable\n");
+	val = tpg110_read_reg(0x03);
+	/* Put into standby */
+	val &= ~BIT(0);
+	tpg110_write_reg(0x03, val);
+}
+
+static void tpg110_init(struct device *dev, struct device_node *np,
+			struct clcd_board *board)
+{
+	dev_info(dev, "TPG110 display init\n");
+
+	grestb = devm_get_gpiod_from_child(dev, "grestb", &np->fwnode);
+	if (IS_ERR(grestb)) {
+		dev_err(dev, "no GRESTB GPIO\n");
+		return;
+	}
+	/* This asserts the GRESTB signal, putting the display into reset */
+	gpiod_direction_output(grestb, 1);
+
+	scen = devm_get_gpiod_from_child(dev, "scen", &np->fwnode);
+	if (IS_ERR(scen)) {
+		dev_err(dev, "no SCEN GPIO\n");
+		return;
+	}
+	gpiod_direction_output(scen, 0);
+	scl = devm_get_gpiod_from_child(dev, "scl", &np->fwnode);
+	if (IS_ERR(scl)) {
+		dev_err(dev, "no SCL GPIO\n");
+		return;
+	}
+	gpiod_direction_output(scl, 0);
+	sda = devm_get_gpiod_from_child(dev, "sda", &np->fwnode);
+	if (IS_ERR(sda)) {
+		dev_err(dev, "no SDA GPIO\n");
+		return;
+	}
+	gpiod_direction_output(sda, 0);
+	board->enable = tpg110_enable;
+	board->disable = tpg110_disable;
+}
+
+int nomadik_clcd_init_panel(struct clcd_fb *fb,
+			    struct device_node *endpoint)
+{
+	struct device_node *panel;
+
+	panel = of_graph_get_remote_port_parent(endpoint);
+	if (!panel)
+		return -ENODEV;
+
+	if (of_device_is_compatible(panel, "tpo,tpg110"))
+		tpg110_init(&fb->dev->dev, panel, fb->board);
+	else
+		dev_info(&fb->dev->dev, "unknown panel\n");
+
+	/* Unknown panel, fall through */
+	return 0;
+}
+
+#define PMU_CTRL_OFFSET 0x0000
+#define PMU_CTRL_LCDNDIF BIT(26)
+
+int nomadik_clcd_init_board(struct amba_device *adev,
+			    struct clcd_board *board)
+{
+	struct regmap *pmu_regmap;
+
+	dev_info(&adev->dev, "Nomadik CLCD board init\n");
+	pmu_regmap +		syscon_regmap_lookup_by_compatible("stericsson,nomadik-pmu");
+	if (IS_ERR(pmu_regmap)) {
+		dev_err(&adev->dev, "could not find PMU syscon regmap\n");
+		return PTR_ERR(pmu_regmap);
+	}
+	regmap_update_bits(pmu_regmap,
+			   PMU_CTRL_OFFSET,
+			   PMU_CTRL_LCDNDIF,
+			   0);
+	dev_info(&adev->dev, "set PMU mux to CLCD mode\n");
+
+	return 0;
+}
diff --git a/drivers/video/fbdev/amba-clcd-nomadik.h b/drivers/video/fbdev/amba-clcd-nomadik.h
new file mode 100644
index 000000000000..50aa9bda69fd
--- /dev/null
+++ b/drivers/video/fbdev/amba-clcd-nomadik.h
@@ -0,0 +1,24 @@
+#ifndef _AMBA_CLCD_NOMADIK_H
+#define _AMBA_CLCD_NOMADIK_H
+
+#include <linux/amba/bus.h>
+
+#ifdef CONFIG_ARCH_NOMADIK
+int nomadik_clcd_init_board(struct amba_device *adev,
+			     struct clcd_board *board);
+int nomadik_clcd_init_panel(struct clcd_fb *fb,
+			    struct device_node *endpoint);
+#else
+static inline int nomadik_clcd_init_board(struct amba_device *adev,
+					  struct clcd_board *board)
+{
+	return 0;
+}
+static inline int nomadik_clcd_init_panel(struct clcd_fb *fb,
+					  struct device_node *endpoint)
+{
+	return 0;
+}
+#endif
+
+#endif /* inclusion guard */
diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 24f4b596d502..2541b237e46e 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -37,6 +37,8 @@
 
 #include <asm/sizes.h>
 
+#include "amba-clcd-nomadik.h"
+
 #define to_clcd(info)	container_of(info, struct clcd_fb, fb)
 
 /* This is limited to 16 characters when displayed by X startup */
@@ -1003,7 +1005,7 @@ static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
 	if (ret)
 		goto free_fb;
 
-	ret = clcdfb_register(fb); 
+	ret = clcdfb_register(fb);
 	if (ret = 0) {
 		amba_set_drvdata(dev, fb);
 		goto out;
@@ -1047,6 +1049,8 @@ static struct clcd_vendor_data vendor_nomadik = {
 	.clock_timregs = true,
 	.packed_24_bit_pixels = true,
 	.st_bitmux_control = true,
+	.init_board = nomadik_clcd_init_board,
+	.init_panel = nomadik_clcd_init_panel,
 };
 
 static struct amba_id clcdfb_id_table[] = {
-- 
2.4.3

