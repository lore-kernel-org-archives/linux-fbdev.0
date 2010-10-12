From: Jimmy Rubin <jimmy.rubin@stericsson.com>
Subject: RFC: [PATCH 1/2] Video: Add support for MCDE frame buffer driver
Date: Tue, 12 Oct 2010 09:42:26 +0200
Message-ID: <1286869347-8980-2-git-send-email-jimmy.rubin@stericsson.com>
References: <1286869347-8980-1-git-send-email-jimmy.rubin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1286869347-8980-1-git-send-email-jimmy.rubin@stericsson.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Cc: Dan Johansson <dan.johansson@stericsson.com>, Jimmy Rubin <jimmy.rubin@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

This patch adds support for the MCDE, Memory-to-display controller,
found in the ST-Ericsson Ux500 products.
This patch includes frame buffer device driver for MCDE.
It also contains a generic display driver that supports
DSI in command mode.

Signed-off-by: Jimmy Rubin <jimmy.rubin@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/video/Kconfig                         |    2 +
 drivers/video/Makefile                        |    1 +
 drivers/video/mcde/Kconfig                    |   39 +
 drivers/video/mcde/Makefile                   |   12 +
 drivers/video/mcde/display-generic_dsi.c      |  152 +
 drivers/video/mcde/dsilink_regs.h             | 2024 ++++++++++
 drivers/video/mcde/mcde_bus.c                 |  259 ++
 drivers/video/mcde/mcde_display.c             |  427 ++
 drivers/video/mcde/mcde_dss.c                 |  353 ++
 drivers/video/mcde/mcde_fb.c                  |  697 ++++
 drivers/video/mcde/mcde_hw.c                  | 2526 ++++++++++++
 drivers/video/mcde/mcde_mod.c                 |   67 +
 drivers/video/mcde/mcde_regs.h                | 5297 +++++++++++++++++++++++++
 include/video/mcde/mcde.h                     |  387 ++
 include/video/mcde/mcde_display-generic_dsi.h |   34 +
 include/video/mcde/mcde_display.h             |  139 +
 include/video/mcde/mcde_dss.h                 |   78 +
 include/video/mcde/mcde_fb.h                  |   54 +
 18 files changed, 12548 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/mcde/Kconfig
 create mode 100644 drivers/video/mcde/Makefile
 create mode 100644 drivers/video/mcde/display-generic_dsi.c
 create mode 100644 drivers/video/mcde/dsilink_regs.h
 create mode 100644 drivers/video/mcde/mcde_bus.c
 create mode 100644 drivers/video/mcde/mcde_display.c
 create mode 100644 drivers/video/mcde/mcde_dss.c
 create mode 100644 drivers/video/mcde/mcde_fb.c
 create mode 100644 drivers/video/mcde/mcde_hw.c
 create mode 100644 drivers/video/mcde/mcde_mod.c
 create mode 100644 drivers/video/mcde/mcde_regs.h
 create mode 100644 include/video/mcde/mcde.h
 create mode 100644 include/video/mcde/mcde_display-generic_dsi.h
 create mode 100644 include/video/mcde/mcde_display.h
 create mode 100644 include/video/mcde/mcde_dss.h
 create mode 100644 include/video/mcde/mcde_fb.h

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 43e90b8..a58be32 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2258,6 +2258,8 @@ config FB_JZ4740
 source "drivers/video/omap/Kconfig"
 source "drivers/video/omap2/Kconfig"
 
+source "drivers/video/mcde/Kconfig"
+
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 485e8ed..325cdcc 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  += sh_mobile_hdmi.o
 obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
 obj-$(CONFIG_FB_OMAP)             += omap/
 obj-y                             += omap2/
+obj-$(CONFIG_FB_MCDE)             += mcde/
 obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
 obj-$(CONFIG_FB_CARMINE)          += carminefb.o
 obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
diff --git a/drivers/video/mcde/Kconfig b/drivers/video/mcde/Kconfig
new file mode 100644
index 0000000..5dab37b
--- /dev/null
+++ b/drivers/video/mcde/Kconfig
@@ -0,0 +1,39 @@
+config FB_MCDE
+	tristate "MCDE support"
+	depends on FB
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	---help---
+	  This enables support for MCDE based frame buffer driver.
+
+	  Please read the file <file:Documentation/fb/mcde.txt>
+
+config MCDE_DISPLAY_GENERIC_DSI
+	tristate "Generic display driver"
+	depends on FB_MCDE
+
+config FB_MCDE_DEBUG
+	bool "MCDE debug messages"
+	depends on FB_MCDE
+	---help---
+	  Say Y here if you want the MCDE driver to output debug messages
+
+config FB_MCDE_VDEBUG
+	bool "MCDE verbose debug messages"
+	depends on FB_MCDE_DEBUG
+	---help---
+	  Say Y here if you want the MCDE driver to output more debug messages
+
+config MCDE_FB_AVOID_REALLOC
+	bool "MCDE early allocate framebuffer"
+	default n
+	depends on FB_MCDE
+	---help---
+	  If you say Y here maximum frame buffer size is allocated and
+	  used for all resolutions. If you say N here, the frame buffer is
+	  reallocated when resolution is changed. This reallocation might
+	  fail because of fragmented memory. Note that this memory will
+	  never be deallocated, while the MCDE framebuffer is used.
+
diff --git a/drivers/video/mcde/Makefile b/drivers/video/mcde/Makefile
new file mode 100644
index 0000000..f90979a
--- /dev/null
+++ b/drivers/video/mcde/Makefile
@@ -0,0 +1,12 @@
+
+mcde-objs			:= mcde_mod.o mcde_hw.o mcde_dss.o mcde_display.o mcde_bus.o mcde_fb.o
+obj-$(CONFIG_FB_MCDE)		+= mcde.o
+
+obj-$(CONFIG_MCDE_DISPLAY_GENERIC_DSI)	+= display-generic_dsi.o
+
+ifdef CONFIG_FB_MCDE_DEBUG
+EXTRA_CFLAGS += -DDEBUG
+endif
+ifdef CONFIG_FB_MCDE_VDEBUG
+EXTRA_CFLAGS += -DVERBOSE_DEBUG
+endif
diff --git a/drivers/video/mcde/display-generic_dsi.c b/drivers/video/mcde/display-generic_dsi.c
new file mode 100644
index 0000000..1c1d266
--- /dev/null
+++ b/drivers/video/mcde/display-generic_dsi.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE generic DCS display driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/err.h>
+
+#include <video/mcde/mcde_display.h>
+#include <video/mcde/mcde_display-generic_dsi.h>
+
+static int __devinit generic_probe(struct mcde_display_device *dev)
+{
+	int ret = 0;
+	struct mcde_display_generic_platform_data *pdata =
+		dev->dev.platform_data;
+
+	if (pdata == NULL) {
+		dev_err(&dev->dev, "%s:Platform data missing\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev->port->type != MCDE_PORTTYPE_DSI) {
+		dev_err(&dev->dev,
+			"%s:Invalid port type %d\n",
+			__func__, dev->port->type);
+		return -EINVAL;
+	}
+
+	if (!dev->platform_enable && !dev->platform_disable) {
+		pdata->generic_platform_enable = true;
+		if (pdata->reset_gpio) {
+			ret = gpio_request(pdata->reset_gpio, NULL);
+			if (ret) {
+				dev_warn(&dev->dev,
+					"%s:Failed to request gpio %d\n",
+					__func__, pdata->reset_gpio);
+				return ret;
+			}
+		}
+		if (pdata->regulator_id) {
+			pdata->regulator = regulator_get(NULL,
+				pdata->regulator_id);
+			if (IS_ERR(pdata->regulator)) {
+				ret = PTR_ERR(pdata->regulator);
+				dev_warn(&dev->dev,
+					"%s:Failed to get regulator '%s'\n",
+					__func__, pdata->regulator_id);
+				pdata->regulator = NULL;
+				goto regulator_get_failed;
+			}
+			regulator_set_voltage(pdata->regulator,
+					pdata->min_supply_voltage,
+					pdata->max_supply_voltage);
+		}
+	}
+
+	/* TODO: Remove when DSI send command uses interrupts */
+	dev->prepare_for_update = NULL;
+	dev_info(&dev->dev, "Generic display probed\n");
+
+	return 0;
+
+regulator_get_failed:
+	if (pdata->generic_platform_enable && pdata->reset_gpio)
+		gpio_free(pdata->reset_gpio);
+	return ret;
+}
+
+static int __devexit generic_remove(struct mcde_display_device *dev)
+{
+	struct mcde_display_generic_platform_data *pdata =
+		dev->dev.platform_data;
+
+	dev->set_power_mode(dev, MCDE_DISPLAY_PM_OFF);
+
+	if (!pdata->generic_platform_enable)
+		return 0;
+
+	if (pdata->regulator)
+		regulator_put(pdata->regulator);
+	if (pdata->reset_gpio) {
+		gpio_direction_input(pdata->reset_gpio);
+		gpio_free(pdata->reset_gpio);
+	}
+
+	return 0;
+}
+
+static int generic_resume(struct mcde_display_device *ddev)
+{
+	int ret;
+
+	/* set_power_mode will handle call platform_enable */
+	ret = ddev->set_power_mode(ddev, MCDE_DISPLAY_PM_STANDBY);
+	if (ret < 0)
+		dev_warn(&ddev->dev, "%s:Failed to resume display\n"
+			, __func__);
+	return ret;
+}
+
+static int generic_suspend(struct mcde_display_device *ddev, pm_message_t state)
+{
+	int ret;
+
+	/* set_power_mode will handle call platform_disable */
+	ret = ddev->set_power_mode(ddev, MCDE_DISPLAY_PM_OFF);
+	if (ret < 0)
+		dev_warn(&ddev->dev, "%s:Failed to suspend display\n"
+			, __func__);
+	return ret;
+}
+
+static struct mcde_display_driver generic_driver = {
+	.probe	= generic_probe,
+	.remove = generic_remove,
+	.suspend = generic_suspend,
+	.resume = generic_resume,
+	.driver = {
+		.name	= "mcde_disp_generic",
+	},
+};
+
+/* Module init */
+static int __init mcde_display_generic_init(void)
+{
+	pr_info("%s\n", __func__);
+
+	return mcde_display_driver_register(&generic_driver);
+}
+module_init(mcde_display_generic_init);
+
+static void __exit mcde_display_generic_exit(void)
+{
+	pr_info("%s\n", __func__);
+
+	mcde_display_driver_unregister(&generic_driver);
+}
+module_exit(mcde_display_generic_exit);
+
+MODULE_AUTHOR("Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ST-Ericsson MCDE generic DCS display driver");
diff --git a/drivers/video/mcde/dsilink_regs.h b/drivers/video/mcde/dsilink_regs.h
new file mode 100644
index 0000000..b5d5bd9
--- /dev/null
+++ b/drivers/video/mcde/dsilink_regs.h
@@ -0,0 +1,2024 @@
+
+#define DSI_VAL2REG(__reg, __fld, __val) \
+	(((__val) << __reg##_##__fld##_SHIFT) & __reg##_##__fld##_MASK)
+#define DSI_REG2VAL(__reg, __fld, __val) \
+	(((__val) & __reg##_##__fld##_MASK) >> __reg##_##__fld##_SHIFT)
+
+#define DSI_MCTL_INTEGRATION_MODE 0x00000000
+#define DSI_MCTL_INTEGRATION_MODE_INT_MODE_EN_SHIFT 0
+#define DSI_MCTL_INTEGRATION_MODE_INT_MODE_EN_MASK 0x00000001
+#define DSI_MCTL_INTEGRATION_MODE_INT_MODE_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_INTEGRATION_MODE, INT_MODE_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL 0x00000004
+#define DSI_MCTL_MAIN_DATA_CTL_LINK_EN_SHIFT 0
+#define DSI_MCTL_MAIN_DATA_CTL_LINK_EN_MASK 0x00000001
+#define DSI_MCTL_MAIN_DATA_CTL_LINK_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, LINK_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_MODE_SHIFT 1
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_MODE_MASK 0x00000002
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_MODE_CMD 0
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_MODE_VID 1
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_MODE_ENUM(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, IF1_MODE, \
+	DSI_MCTL_MAIN_DATA_CTL_IF1_MODE_##__x)
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_MODE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, IF1_MODE, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_VID_EN_SHIFT 2
+#define DSI_MCTL_MAIN_DATA_CTL_VID_EN_MASK 0x00000004
+#define DSI_MCTL_MAIN_DATA_CTL_VID_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, VID_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_TVG_SEL_SHIFT 3
+#define DSI_MCTL_MAIN_DATA_CTL_TVG_SEL_MASK 0x00000008
+#define DSI_MCTL_MAIN_DATA_CTL_TVG_SEL(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, TVG_SEL, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_TBG_SEL_SHIFT 4
+#define DSI_MCTL_MAIN_DATA_CTL_TBG_SEL_MASK 0x00000010
+#define DSI_MCTL_MAIN_DATA_CTL_TBG_SEL(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, TBG_SEL, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_TE_EN_SHIFT 5
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_TE_EN_MASK 0x00000020
+#define DSI_MCTL_MAIN_DATA_CTL_IF1_TE_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, IF1_TE_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_IF2_TE_EN_SHIFT 6
+#define DSI_MCTL_MAIN_DATA_CTL_IF2_TE_EN_MASK 0x00000040
+#define DSI_MCTL_MAIN_DATA_CTL_IF2_TE_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, IF2_TE_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_REG_TE_EN_SHIFT 7
+#define DSI_MCTL_MAIN_DATA_CTL_REG_TE_EN_MASK 0x00000080
+#define DSI_MCTL_MAIN_DATA_CTL_REG_TE_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, REG_TE_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_READ_EN_SHIFT 8
+#define DSI_MCTL_MAIN_DATA_CTL_READ_EN_MASK 0x00000100
+#define DSI_MCTL_MAIN_DATA_CTL_READ_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, READ_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_BTA_EN_SHIFT 9
+#define DSI_MCTL_MAIN_DATA_CTL_BTA_EN_MASK 0x00000200
+#define DSI_MCTL_MAIN_DATA_CTL_BTA_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, BTA_EN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_GEN_ECC_SHIFT 10
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_GEN_ECC_MASK 0x00000400
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_GEN_ECC(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, DISP_GEN_ECC, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_GEN_CHECKSUM_SHIFT 11
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_GEN_CHECKSUM_MASK 0x00000800
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_GEN_CHECKSUM(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, DISP_GEN_CHECKSUM, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_HOST_EOT_GEN_SHIFT 12
+#define DSI_MCTL_MAIN_DATA_CTL_HOST_EOT_GEN_MASK 0x00001000
+#define DSI_MCTL_MAIN_DATA_CTL_HOST_EOT_GEN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, HOST_EOT_GEN, __x)
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_EOT_GEN_SHIFT 13
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_EOT_GEN_MASK 0x00002000
+#define DSI_MCTL_MAIN_DATA_CTL_DISP_EOT_GEN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_DATA_CTL, DISP_EOT_GEN, __x)
+#define DSI_MCTL_MAIN_PHY_CTL 0x00000008
+#define DSI_MCTL_MAIN_PHY_CTL_LANE2_EN_SHIFT 0
+#define DSI_MCTL_MAIN_PHY_CTL_LANE2_EN_MASK 0x00000001
+#define DSI_MCTL_MAIN_PHY_CTL_LANE2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, LANE2_EN, __x)
+#define DSI_MCTL_MAIN_PHY_CTL_FORCE_STOP_MODE_SHIFT 1
+#define DSI_MCTL_MAIN_PHY_CTL_FORCE_STOP_MODE_MASK 0x00000002
+#define DSI_MCTL_MAIN_PHY_CTL_FORCE_STOP_MODE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, FORCE_STOP_MODE, __x)
+#define DSI_MCTL_MAIN_PHY_CTL_CLK_CONTINUOUS_SHIFT 2
+#define DSI_MCTL_MAIN_PHY_CTL_CLK_CONTINUOUS_MASK 0x00000004
+#define DSI_MCTL_MAIN_PHY_CTL_CLK_CONTINUOUS(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, CLK_CONTINUOUS, __x)
+#define DSI_MCTL_MAIN_PHY_CTL_CLK_ULPM_EN_SHIFT 3
+#define DSI_MCTL_MAIN_PHY_CTL_CLK_ULPM_EN_MASK 0x00000008
+#define DSI_MCTL_MAIN_PHY_CTL_CLK_ULPM_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, CLK_ULPM_EN, __x)
+#define DSI_MCTL_MAIN_PHY_CTL_DAT1_ULPM_EN_SHIFT 4
+#define DSI_MCTL_MAIN_PHY_CTL_DAT1_ULPM_EN_MASK 0x00000010
+#define DSI_MCTL_MAIN_PHY_CTL_DAT1_ULPM_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, DAT1_ULPM_EN, __x)
+#define DSI_MCTL_MAIN_PHY_CTL_DAT2_ULPM_EN_SHIFT 5
+#define DSI_MCTL_MAIN_PHY_CTL_DAT2_ULPM_EN_MASK 0x00000020
+#define DSI_MCTL_MAIN_PHY_CTL_DAT2_ULPM_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, DAT2_ULPM_EN, __x)
+#define DSI_MCTL_MAIN_PHY_CTL_WAIT_BURST_TIME_SHIFT 6
+#define DSI_MCTL_MAIN_PHY_CTL_WAIT_BURST_TIME_MASK 0x000003C0
+#define DSI_MCTL_MAIN_PHY_CTL_WAIT_BURST_TIME(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_PHY_CTL, WAIT_BURST_TIME, __x)
+#define DSI_MCTL_PLL_CTL 0x0000000C
+#define DSI_MCTL_PLL_CTL_PLL_MULT_SHIFT 0
+#define DSI_MCTL_PLL_CTL_PLL_MULT_MASK 0x000000FF
+#define DSI_MCTL_PLL_CTL_PLL_MULT(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_MULT, __x)
+#define DSI_MCTL_PLL_CTL_PLL_OUT_DIV_SHIFT 8
+#define DSI_MCTL_PLL_CTL_PLL_OUT_DIV_MASK 0x00003F00
+#define DSI_MCTL_PLL_CTL_PLL_OUT_DIV(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_OUT_DIV, __x)
+#define DSI_MCTL_PLL_CTL_PLL_IN_DIV_SHIFT 14
+#define DSI_MCTL_PLL_CTL_PLL_IN_DIV_MASK 0x0001C000
+#define DSI_MCTL_PLL_CTL_PLL_IN_DIV(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_IN_DIV, __x)
+#define DSI_MCTL_PLL_CTL_PLL_SEL_DIV2_SHIFT 17
+#define DSI_MCTL_PLL_CTL_PLL_SEL_DIV2_MASK 0x00020000
+#define DSI_MCTL_PLL_CTL_PLL_SEL_DIV2(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_SEL_DIV2, __x)
+#define DSI_MCTL_PLL_CTL_PLL_OUT_SEL_SHIFT 18
+#define DSI_MCTL_PLL_CTL_PLL_OUT_SEL_MASK 0x00040000
+#define DSI_MCTL_PLL_CTL_PLL_OUT_SEL_INT_PLL 0
+#define DSI_MCTL_PLL_CTL_PLL_OUT_SEL_SYS_PLL 1
+#define DSI_MCTL_PLL_CTL_PLL_OUT_SEL_ENUM(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_OUT_SEL, \
+	DSI_MCTL_PLL_CTL_PLL_OUT_SEL_##__x)
+#define DSI_MCTL_PLL_CTL_PLL_OUT_SEL(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_OUT_SEL, __x)
+#define DSI_MCTL_PLL_CTL_PLL_MASTER_SHIFT 31
+#define DSI_MCTL_PLL_CTL_PLL_MASTER_MASK 0x80000000
+#define DSI_MCTL_PLL_CTL_PLL_MASTER(__x) \
+	DSI_VAL2REG(DSI_MCTL_PLL_CTL, PLL_MASTER, __x)
+#define DSI_MCTL_LANE_STS 0x00000010
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_SHIFT 0
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_MASK 0x00000003
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_START 0
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_IDLE 1
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_HS 2
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_ULPM 3
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE_ENUM(__x) \
+	DSI_VAL2REG(DSI_MCTL_LANE_STS, CLKLANE_STATE, \
+	DSI_MCTL_LANE_STS_CLKLANE_STATE_##__x)
+#define DSI_MCTL_LANE_STS_CLKLANE_STATE(__x) \
+	DSI_VAL2REG(DSI_MCTL_LANE_STS, CLKLANE_STATE, __x)
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_SHIFT 2
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_MASK 0x0000001C
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_START 0
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_IDLE 1
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_WRITE 2
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_ULPM 3
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_READ 4
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE_ENUM(__x) \
+	DSI_VAL2REG(DSI_MCTL_LANE_STS, DATLANE1_STATE, \
+	DSI_MCTL_LANE_STS_DATLANE1_STATE_##__x)
+#define DSI_MCTL_LANE_STS_DATLANE1_STATE(__x) \
+	DSI_VAL2REG(DSI_MCTL_LANE_STS, DATLANE1_STATE, __x)
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_SHIFT 5
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_MASK 0x00000060
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_START 0
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_IDLE 1
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_WRITE 2
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_ULPM 3
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE_ENUM(__x) \
+	DSI_VAL2REG(DSI_MCTL_LANE_STS, DATLANE2_STATE, \
+	DSI_MCTL_LANE_STS_DATLANE2_STATE_##__x)
+#define DSI_MCTL_LANE_STS_DATLANE2_STATE(__x) \
+	DSI_VAL2REG(DSI_MCTL_LANE_STS, DATLANE2_STATE, __x)
+#define DSI_MCTL_DPHY_TIMEOUT 0x00000014
+#define DSI_MCTL_DPHY_TIMEOUT_CLK_DIV_SHIFT 0
+#define DSI_MCTL_DPHY_TIMEOUT_CLK_DIV_MASK 0x0000000F
+#define DSI_MCTL_DPHY_TIMEOUT_CLK_DIV(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_TIMEOUT, CLK_DIV, __x)
+#define DSI_MCTL_DPHY_TIMEOUT_HSTX_TO_VAL_SHIFT 4
+#define DSI_MCTL_DPHY_TIMEOUT_HSTX_TO_VAL_MASK 0x0003FFF0
+#define DSI_MCTL_DPHY_TIMEOUT_HSTX_TO_VAL(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_TIMEOUT, HSTX_TO_VAL, __x)
+#define DSI_MCTL_DPHY_TIMEOUT_LPRX_TO_VAL_SHIFT 18
+#define DSI_MCTL_DPHY_TIMEOUT_LPRX_TO_VAL_MASK 0xFFFC0000
+#define DSI_MCTL_DPHY_TIMEOUT_LPRX_TO_VAL(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_TIMEOUT, LPRX_TO_VAL, __x)
+#define DSI_MCTL_ULPOUT_TIME 0x00000018
+#define DSI_MCTL_ULPOUT_TIME_CKLANE_ULPOUT_TIME_SHIFT 0
+#define DSI_MCTL_ULPOUT_TIME_CKLANE_ULPOUT_TIME_MASK 0x000001FF
+#define DSI_MCTL_ULPOUT_TIME_CKLANE_ULPOUT_TIME(__x) \
+	DSI_VAL2REG(DSI_MCTL_ULPOUT_TIME, CKLANE_ULPOUT_TIME, __x)
+#define DSI_MCTL_ULPOUT_TIME_DATA_ULPOUT_TIME_SHIFT 9
+#define DSI_MCTL_ULPOUT_TIME_DATA_ULPOUT_TIME_MASK 0x0003FE00
+#define DSI_MCTL_ULPOUT_TIME_DATA_ULPOUT_TIME(__x) \
+	DSI_VAL2REG(DSI_MCTL_ULPOUT_TIME, DATA_ULPOUT_TIME, __x)
+#define DSI_MCTL_DPHY_STATIC 0x0000001C
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_CLK_SHIFT 0
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_CLK_MASK 0x00000001
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_CLK(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, SWAP_PINS_CLK, __x)
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_CLK_SHIFT 1
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_CLK_MASK 0x00000002
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_CLK(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, HS_INVERT_CLK, __x)
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_DAT1_SHIFT 2
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_DAT1_MASK 0x00000004
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_DAT1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, SWAP_PINS_DAT1, __x)
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_DAT1_SHIFT 3
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_DAT1_MASK 0x00000008
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_DAT1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, HS_INVERT_DAT1, __x)
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_DAT2_SHIFT 4
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_DAT2_MASK 0x00000010
+#define DSI_MCTL_DPHY_STATIC_SWAP_PINS_DAT2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, SWAP_PINS_DAT2, __x)
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_DAT2_SHIFT 5
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_DAT2_MASK 0x00000020
+#define DSI_MCTL_DPHY_STATIC_HS_INVERT_DAT2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, HS_INVERT_DAT2, __x)
+#define DSI_MCTL_DPHY_STATIC_UI_X4_SHIFT 6
+#define DSI_MCTL_DPHY_STATIC_UI_X4_MASK 0x00000FC0
+#define DSI_MCTL_DPHY_STATIC_UI_X4(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_STATIC, UI_X4, __x)
+#define DSI_MCTL_MAIN_EN 0x00000020
+#define DSI_MCTL_MAIN_EN_PLL_START_SHIFT 0
+#define DSI_MCTL_MAIN_EN_PLL_START_MASK 0x00000001
+#define DSI_MCTL_MAIN_EN_PLL_START(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, PLL_START, __x)
+#define DSI_MCTL_MAIN_EN_CKLANE_EN_SHIFT 3
+#define DSI_MCTL_MAIN_EN_CKLANE_EN_MASK 0x00000008
+#define DSI_MCTL_MAIN_EN_CKLANE_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, CKLANE_EN, __x)
+#define DSI_MCTL_MAIN_EN_DAT1_EN_SHIFT 4
+#define DSI_MCTL_MAIN_EN_DAT1_EN_MASK 0x00000010
+#define DSI_MCTL_MAIN_EN_DAT1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, DAT1_EN, __x)
+#define DSI_MCTL_MAIN_EN_DAT2_EN_SHIFT 5
+#define DSI_MCTL_MAIN_EN_DAT2_EN_MASK 0x00000020
+#define DSI_MCTL_MAIN_EN_DAT2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, DAT2_EN, __x)
+#define DSI_MCTL_MAIN_EN_CLKLANE_ULPM_REQ_SHIFT 6
+#define DSI_MCTL_MAIN_EN_CLKLANE_ULPM_REQ_MASK 0x00000040
+#define DSI_MCTL_MAIN_EN_CLKLANE_ULPM_REQ(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, CLKLANE_ULPM_REQ, __x)
+#define DSI_MCTL_MAIN_EN_DAT1_ULPM_REQ_SHIFT 7
+#define DSI_MCTL_MAIN_EN_DAT1_ULPM_REQ_MASK 0x00000080
+#define DSI_MCTL_MAIN_EN_DAT1_ULPM_REQ(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, DAT1_ULPM_REQ, __x)
+#define DSI_MCTL_MAIN_EN_DAT2_ULPM_REQ_SHIFT 8
+#define DSI_MCTL_MAIN_EN_DAT2_ULPM_REQ_MASK 0x00000100
+#define DSI_MCTL_MAIN_EN_DAT2_ULPM_REQ(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, DAT2_ULPM_REQ, __x)
+#define DSI_MCTL_MAIN_EN_IF1_EN_SHIFT 9
+#define DSI_MCTL_MAIN_EN_IF1_EN_MASK 0x00000200
+#define DSI_MCTL_MAIN_EN_IF1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, IF1_EN, __x)
+#define DSI_MCTL_MAIN_EN_IF2_EN_SHIFT 10
+#define DSI_MCTL_MAIN_EN_IF2_EN_MASK 0x00000400
+#define DSI_MCTL_MAIN_EN_IF2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_EN, IF2_EN, __x)
+#define DSI_MCTL_MAIN_STS 0x00000024
+#define DSI_MCTL_MAIN_STS_PLL_LOCK_SHIFT 0
+#define DSI_MCTL_MAIN_STS_PLL_LOCK_MASK 0x00000001
+#define DSI_MCTL_MAIN_STS_PLL_LOCK(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, PLL_LOCK, __x)
+#define DSI_MCTL_MAIN_STS_CLKLANE_READY_SHIFT 1
+#define DSI_MCTL_MAIN_STS_CLKLANE_READY_MASK 0x00000002
+#define DSI_MCTL_MAIN_STS_CLKLANE_READY(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, CLKLANE_READY, __x)
+#define DSI_MCTL_MAIN_STS_DAT1_READY_SHIFT 2
+#define DSI_MCTL_MAIN_STS_DAT1_READY_MASK 0x00000004
+#define DSI_MCTL_MAIN_STS_DAT1_READY(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, DAT1_READY, __x)
+#define DSI_MCTL_MAIN_STS_DAT2_READY_SHIFT 3
+#define DSI_MCTL_MAIN_STS_DAT2_READY_MASK 0x00000008
+#define DSI_MCTL_MAIN_STS_DAT2_READY(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, DAT2_READY, __x)
+#define DSI_MCTL_MAIN_STS_HSTX_TO_ERR_SHIFT 4
+#define DSI_MCTL_MAIN_STS_HSTX_TO_ERR_MASK 0x00000010
+#define DSI_MCTL_MAIN_STS_HSTX_TO_ERR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, HSTX_TO_ERR, __x)
+#define DSI_MCTL_MAIN_STS_LPRX_TO_ERR_SHIFT 5
+#define DSI_MCTL_MAIN_STS_LPRX_TO_ERR_MASK 0x00000020
+#define DSI_MCTL_MAIN_STS_LPRX_TO_ERR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, LPRX_TO_ERR, __x)
+#define DSI_MCTL_MAIN_STS_CRS_UNTERM_PCK_SHIFT 6
+#define DSI_MCTL_MAIN_STS_CRS_UNTERM_PCK_MASK 0x00000040
+#define DSI_MCTL_MAIN_STS_CRS_UNTERM_PCK(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, CRS_UNTERM_PCK, __x)
+#define DSI_MCTL_MAIN_STS_VRS_UNTERM_PCK_SHIFT 7
+#define DSI_MCTL_MAIN_STS_VRS_UNTERM_PCK_MASK 0x00000080
+#define DSI_MCTL_MAIN_STS_VRS_UNTERM_PCK(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS, VRS_UNTERM_PCK, __x)
+#define DSI_MCTL_DPHY_ERR 0x00000028
+#define DSI_MCTL_DPHY_ERR_ERR_ESC_1_SHIFT 6
+#define DSI_MCTL_DPHY_ERR_ERR_ESC_1_MASK 0x00000040
+#define DSI_MCTL_DPHY_ERR_ERR_ESC_1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_ESC_1, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_ESC_2_SHIFT 7
+#define DSI_MCTL_DPHY_ERR_ERR_ESC_2_MASK 0x00000080
+#define DSI_MCTL_DPHY_ERR_ERR_ESC_2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_ESC_2, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_SYNCESC_1_SHIFT 8
+#define DSI_MCTL_DPHY_ERR_ERR_SYNCESC_1_MASK 0x00000100
+#define DSI_MCTL_DPHY_ERR_ERR_SYNCESC_1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_SYNCESC_1, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_SYNCESC_2_SHIFT 9
+#define DSI_MCTL_DPHY_ERR_ERR_SYNCESC_2_MASK 0x00000200
+#define DSI_MCTL_DPHY_ERR_ERR_SYNCESC_2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_SYNCESC_2, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_CONTROL_1_SHIFT 10
+#define DSI_MCTL_DPHY_ERR_ERR_CONTROL_1_MASK 0x00000400
+#define DSI_MCTL_DPHY_ERR_ERR_CONTROL_1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_CONTROL_1, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_CONTROL_2_SHIFT 11
+#define DSI_MCTL_DPHY_ERR_ERR_CONTROL_2_MASK 0x00000800
+#define DSI_MCTL_DPHY_ERR_ERR_CONTROL_2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_CONTROL_2, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP0_1_SHIFT 12
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP0_1_MASK 0x00001000
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP0_1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_CONT_LP0_1, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP0_2_SHIFT 13
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP0_2_MASK 0x00002000
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP0_2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_CONT_LP0_2, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP1_1_SHIFT 14
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP1_1_MASK 0x00004000
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP1_1(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_CONT_LP1_1, __x)
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP1_2_SHIFT 15
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP1_2_MASK 0x00008000
+#define DSI_MCTL_DPHY_ERR_ERR_CONT_LP1_2(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR, ERR_CONT_LP1_2, __x)
+#define DSI_INT_VID_RDDATA 0x00000030
+#define DSI_INT_VID_RDDATA_IF_DATA_SHIFT 0
+#define DSI_INT_VID_RDDATA_IF_DATA_MASK 0x0000FFFF
+#define DSI_INT_VID_RDDATA_IF_DATA(__x) \
+	DSI_VAL2REG(DSI_INT_VID_RDDATA, IF_DATA, __x)
+#define DSI_INT_VID_RDDATA_IF_VALID_SHIFT 16
+#define DSI_INT_VID_RDDATA_IF_VALID_MASK 0x00010000
+#define DSI_INT_VID_RDDATA_IF_VALID(__x) \
+	DSI_VAL2REG(DSI_INT_VID_RDDATA, IF_VALID, __x)
+#define DSI_INT_VID_RDDATA_IF_START_SHIFT 17
+#define DSI_INT_VID_RDDATA_IF_START_MASK 0x00020000
+#define DSI_INT_VID_RDDATA_IF_START(__x) \
+	DSI_VAL2REG(DSI_INT_VID_RDDATA, IF_START, __x)
+#define DSI_INT_VID_RDDATA_IF_FRAME_SYNC_SHIFT 18
+#define DSI_INT_VID_RDDATA_IF_FRAME_SYNC_MASK 0x00040000
+#define DSI_INT_VID_RDDATA_IF_FRAME_SYNC(__x) \
+	DSI_VAL2REG(DSI_INT_VID_RDDATA, IF_FRAME_SYNC, __x)
+#define DSI_INT_VID_GNT 0x00000034
+#define DSI_INT_VID_GNT_IF_STALL_SHIFT 0
+#define DSI_INT_VID_GNT_IF_STALL_MASK 0x00000001
+#define DSI_INT_VID_GNT_IF_STALL(__x) \
+	DSI_VAL2REG(DSI_INT_VID_GNT, IF_STALL, __x)
+#define DSI_INT_CMD_RDDATA 0x00000038
+#define DSI_INT_CMD_RDDATA_IF_DATA_SHIFT 0
+#define DSI_INT_CMD_RDDATA_IF_DATA_MASK 0x0000FFFF
+#define DSI_INT_CMD_RDDATA_IF_DATA(__x) \
+	DSI_VAL2REG(DSI_INT_CMD_RDDATA, IF_DATA, __x)
+#define DSI_INT_CMD_RDDATA_IF_VALID_SHIFT 16
+#define DSI_INT_CMD_RDDATA_IF_VALID_MASK 0x00010000
+#define DSI_INT_CMD_RDDATA_IF_VALID(__x) \
+	DSI_VAL2REG(DSI_INT_CMD_RDDATA, IF_VALID, __x)
+#define DSI_INT_CMD_RDDATA_IF_START_SHIFT 17
+#define DSI_INT_CMD_RDDATA_IF_START_MASK 0x00020000
+#define DSI_INT_CMD_RDDATA_IF_START(__x) \
+	DSI_VAL2REG(DSI_INT_CMD_RDDATA, IF_START, __x)
+#define DSI_INT_CMD_RDDATA_IF_FRAME_SYNC_SHIFT 18
+#define DSI_INT_CMD_RDDATA_IF_FRAME_SYNC_MASK 0x00040000
+#define DSI_INT_CMD_RDDATA_IF_FRAME_SYNC(__x) \
+	DSI_VAL2REG(DSI_INT_CMD_RDDATA, IF_FRAME_SYNC, __x)
+#define DSI_INT_CMD_GNT 0x0000003C
+#define DSI_INT_CMD_GNT_IF_STALL_SHIFT 0
+#define DSI_INT_CMD_GNT_IF_STALL_MASK 0x00000001
+#define DSI_INT_CMD_GNT_IF_STALL(__x) \
+	DSI_VAL2REG(DSI_INT_CMD_GNT, IF_STALL, __x)
+#define DSI_INT_INTERRUPT_CTL 0x00000040
+#define DSI_INT_INTERRUPT_CTL_INT_VAL_SHIFT 0
+#define DSI_INT_INTERRUPT_CTL_INT_VAL_MASK 0x00000001
+#define DSI_INT_INTERRUPT_CTL_INT_VAL(__x) \
+	DSI_VAL2REG(DSI_INT_INTERRUPT_CTL, INT_VAL, __x)
+#define DSI_CMD_MODE_CTL 0x00000050
+#define DSI_CMD_MODE_CTL_IF1_ID_SHIFT 0
+#define DSI_CMD_MODE_CTL_IF1_ID_MASK 0x00000003
+#define DSI_CMD_MODE_CTL_IF1_ID(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, IF1_ID, __x)
+#define DSI_CMD_MODE_CTL_IF2_ID_SHIFT 2
+#define DSI_CMD_MODE_CTL_IF2_ID_MASK 0x0000000C
+#define DSI_CMD_MODE_CTL_IF2_ID(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, IF2_ID, __x)
+#define DSI_CMD_MODE_CTL_IF1_LP_EN_SHIFT 4
+#define DSI_CMD_MODE_CTL_IF1_LP_EN_MASK 0x00000010
+#define DSI_CMD_MODE_CTL_IF1_LP_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, IF1_LP_EN, __x)
+#define DSI_CMD_MODE_CTL_IF2_LP_EN_SHIFT 5
+#define DSI_CMD_MODE_CTL_IF2_LP_EN_MASK 0x00000020
+#define DSI_CMD_MODE_CTL_IF2_LP_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, IF2_LP_EN, __x)
+#define DSI_CMD_MODE_CTL_ARB_MODE_SHIFT 6
+#define DSI_CMD_MODE_CTL_ARB_MODE_MASK 0x00000040
+#define DSI_CMD_MODE_CTL_ARB_MODE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, ARB_MODE, __x)
+#define DSI_CMD_MODE_CTL_ARB_PRI_SHIFT 7
+#define DSI_CMD_MODE_CTL_ARB_PRI_MASK 0x00000080
+#define DSI_CMD_MODE_CTL_ARB_PRI(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, ARB_PRI, __x)
+#define DSI_CMD_MODE_CTL_FIL_VALUE_SHIFT 8
+#define DSI_CMD_MODE_CTL_FIL_VALUE_MASK 0x0000FF00
+#define DSI_CMD_MODE_CTL_FIL_VALUE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, FIL_VALUE, __x)
+#define DSI_CMD_MODE_CTL_TE_TIMEOUT_SHIFT 16
+#define DSI_CMD_MODE_CTL_TE_TIMEOUT_MASK 0x03FF0000
+#define DSI_CMD_MODE_CTL_TE_TIMEOUT(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_CTL, TE_TIMEOUT, __x)
+#define DSI_CMD_MODE_STS 0x00000054
+#define DSI_CMD_MODE_STS_ERR_NO_TE_SHIFT 0
+#define DSI_CMD_MODE_STS_ERR_NO_TE_MASK 0x00000001
+#define DSI_CMD_MODE_STS_ERR_NO_TE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS, ERR_NO_TE, __x)
+#define DSI_CMD_MODE_STS_ERR_TE_MISS_SHIFT 1
+#define DSI_CMD_MODE_STS_ERR_TE_MISS_MASK 0x00000002
+#define DSI_CMD_MODE_STS_ERR_TE_MISS(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS, ERR_TE_MISS, __x)
+#define DSI_CMD_MODE_STS_ERR_SDI1_UNDERRUN_SHIFT 2
+#define DSI_CMD_MODE_STS_ERR_SDI1_UNDERRUN_MASK 0x00000004
+#define DSI_CMD_MODE_STS_ERR_SDI1_UNDERRUN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS, ERR_SDI1_UNDERRUN, __x)
+#define DSI_CMD_MODE_STS_ERR_SDI2_UNDERRUN_SHIFT 3
+#define DSI_CMD_MODE_STS_ERR_SDI2_UNDERRUN_MASK 0x00000008
+#define DSI_CMD_MODE_STS_ERR_SDI2_UNDERRUN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS, ERR_SDI2_UNDERRUN, __x)
+#define DSI_CMD_MODE_STS_ERR_UNWANTED_RD_SHIFT 4
+#define DSI_CMD_MODE_STS_ERR_UNWANTED_RD_MASK 0x00000010
+#define DSI_CMD_MODE_STS_ERR_UNWANTED_RD(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS, ERR_UNWANTED_RD, __x)
+#define DSI_CMD_MODE_STS_CSM_RUNNING_SHIFT 5
+#define DSI_CMD_MODE_STS_CSM_RUNNING_MASK 0x00000020
+#define DSI_CMD_MODE_STS_CSM_RUNNING(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS, CSM_RUNNING, __x)
+#define DSI_DIRECT_CMD_SEND 0x00000060
+#define DSI_DIRECT_CMD_SEND_START_SHIFT 0
+#define DSI_DIRECT_CMD_SEND_START_MASK 0xFFFFFFFF
+#define DSI_DIRECT_CMD_SEND_START(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_SEND, START, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS 0x00000064
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_SHIFT 0
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_MASK 0x00000007
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_WRITE 0
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_READ 1
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_TE_REQ 4
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_TRIG_REQ 5
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_BTA_REQ 6
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_ENUM(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_NAT, \
+	DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_##__x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_NAT, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT_SHIFT 3
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT_MASK 0x00000008
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_LONGNOTSHORT, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_SHIFT 8
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_MASK 0x00003F00
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_DCS_SHORT_WRITE_0 5
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_DCS_SHORT_WRITE_1 21
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_DCS_LONG_WRITE 57
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_DCS_READ 6
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_ENUM(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_HEAD, \
+	DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_##__x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_HEAD, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID_SHIFT 14
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID_MASK 0x0000C000
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_ID, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE_SHIFT 16
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE_MASK 0x001F0000
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_SIZE, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN_SHIFT 21
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN_MASK 0x00200000
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, CMD_LP_EN, __x)
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_TRIGGER_VAL_SHIFT 24
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_TRIGGER_VAL_MASK 0x0F000000
+#define DSI_DIRECT_CMD_MAIN_SETTINGS_TRIGGER_VAL(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_MAIN_SETTINGS, TRIGGER_VAL, __x)
+#define DSI_DIRECT_CMD_STS 0x00000068
+#define DSI_DIRECT_CMD_STS_CMD_TRANSMISSION_SHIFT 0
+#define DSI_DIRECT_CMD_STS_CMD_TRANSMISSION_MASK 0x00000001
+#define DSI_DIRECT_CMD_STS_CMD_TRANSMISSION(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, CMD_TRANSMISSION, __x)
+#define DSI_DIRECT_CMD_STS_WRITE_COMPLETED_SHIFT 1
+#define DSI_DIRECT_CMD_STS_WRITE_COMPLETED_MASK 0x00000002
+#define DSI_DIRECT_CMD_STS_WRITE_COMPLETED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, WRITE_COMPLETED, __x)
+#define DSI_DIRECT_CMD_STS_TRIGGER_COMPLETED_SHIFT 2
+#define DSI_DIRECT_CMD_STS_TRIGGER_COMPLETED_MASK 0x00000004
+#define DSI_DIRECT_CMD_STS_TRIGGER_COMPLETED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, TRIGGER_COMPLETED, __x)
+#define DSI_DIRECT_CMD_STS_READ_COMPLETED_SHIFT 3
+#define DSI_DIRECT_CMD_STS_READ_COMPLETED_MASK 0x00000008
+#define DSI_DIRECT_CMD_STS_READ_COMPLETED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, READ_COMPLETED, __x)
+#define DSI_DIRECT_CMD_STS_ACKNOWLEDGE_RECEIVED_SHIFT 4
+#define DSI_DIRECT_CMD_STS_ACKNOWLEDGE_RECEIVED_MASK 0x00000010
+#define DSI_DIRECT_CMD_STS_ACKNOWLEDGE_RECEIVED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, ACKNOWLEDGE_RECEIVED, __x)
+#define DSI_DIRECT_CMD_STS_ACKNOWLEDGE_WITH_ERR_RECEIVED_SHIFT 5
+#define DSI_DIRECT_CMD_STS_ACKNOWLEDGE_WITH_ERR_RECEIVED_MASK 0x00000020
+#define DSI_DIRECT_CMD_STS_ACKNOWLEDGE_WITH_ERR_RECEIVED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, ACKNOWLEDGE_WITH_ERR_RECEIVED, __x)
+#define DSI_DIRECT_CMD_STS_TRIGGER_RECEIVED_SHIFT 6
+#define DSI_DIRECT_CMD_STS_TRIGGER_RECEIVED_MASK 0x00000040
+#define DSI_DIRECT_CMD_STS_TRIGGER_RECEIVED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, TRIGGER_RECEIVED, __x)
+#define DSI_DIRECT_CMD_STS_TE_RECEIVED_SHIFT 7
+#define DSI_DIRECT_CMD_STS_TE_RECEIVED_MASK 0x00000080
+#define DSI_DIRECT_CMD_STS_TE_RECEIVED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, TE_RECEIVED, __x)
+#define DSI_DIRECT_CMD_STS_BTA_COMPLETED_SHIFT 8
+#define DSI_DIRECT_CMD_STS_BTA_COMPLETED_MASK 0x00000100
+#define DSI_DIRECT_CMD_STS_BTA_COMPLETED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, BTA_COMPLETED, __x)
+#define DSI_DIRECT_CMD_STS_BTA_FINISHED_SHIFT 9
+#define DSI_DIRECT_CMD_STS_BTA_FINISHED_MASK 0x00000200
+#define DSI_DIRECT_CMD_STS_BTA_FINISHED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, BTA_FINISHED, __x)
+#define DSI_DIRECT_CMD_STS_READ_COMPLETED_WITH_ERR_SHIFT 10
+#define DSI_DIRECT_CMD_STS_READ_COMPLETED_WITH_ERR_MASK 0x00000400
+#define DSI_DIRECT_CMD_STS_READ_COMPLETED_WITH_ERR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, READ_COMPLETED_WITH_ERR, __x)
+#define DSI_DIRECT_CMD_STS_TRIGGER_VAL_SHIFT 11
+#define DSI_DIRECT_CMD_STS_TRIGGER_VAL_MASK 0x00007800
+#define DSI_DIRECT_CMD_STS_TRIGGER_VAL(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, TRIGGER_VAL, __x)
+#define DSI_DIRECT_CMD_STS_ACK_VAL_SHIFT 16
+#define DSI_DIRECT_CMD_STS_ACK_VAL_MASK 0xFFFF0000
+#define DSI_DIRECT_CMD_STS_ACK_VAL(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS, ACK_VAL, __x)
+#define DSI_DIRECT_CMD_RD_INIT 0x0000006C
+#define DSI_DIRECT_CMD_RD_INIT_RESET_SHIFT 0
+#define DSI_DIRECT_CMD_RD_INIT_RESET_MASK 0xFFFFFFFF
+#define DSI_DIRECT_CMD_RD_INIT_RESET(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_INIT, RESET, __x)
+#define DSI_DIRECT_CMD_WRDAT0 0x00000070
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT0_SHIFT 0
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT0_MASK 0x000000FF
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT0(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT0, WRDAT0, __x)
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT1_SHIFT 8
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT1_MASK 0x0000FF00
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT1(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT0, WRDAT1, __x)
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT2_SHIFT 16
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT2_MASK 0x00FF0000
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT2(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT0, WRDAT2, __x)
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT3_SHIFT 24
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT3_MASK 0xFF000000
+#define DSI_DIRECT_CMD_WRDAT0_WRDAT3(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT0, WRDAT3, __x)
+#define DSI_DIRECT_CMD_WRDAT1 0x00000074
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT4_SHIFT 0
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT4_MASK 0x000000FF
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT4(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT1, WRDAT4, __x)
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT5_SHIFT 8
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT5_MASK 0x0000FF00
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT5(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT1, WRDAT5, __x)
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT6_SHIFT 16
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT6_MASK 0x00FF0000
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT6(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT1, WRDAT6, __x)
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT7_SHIFT 24
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT7_MASK 0xFF000000
+#define DSI_DIRECT_CMD_WRDAT1_WRDAT7(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT1, WRDAT7, __x)
+#define DSI_DIRECT_CMD_WRDAT2 0x00000078
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT8_SHIFT 0
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT8_MASK 0x000000FF
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT8(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT2, WRDAT8, __x)
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT9_SHIFT 8
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT9_MASK 0x0000FF00
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT9(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT2, WRDAT9, __x)
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT10_SHIFT 16
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT10_MASK 0x00FF0000
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT10(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT2, WRDAT10, __x)
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT11_SHIFT 24
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT11_MASK 0xFF000000
+#define DSI_DIRECT_CMD_WRDAT2_WRDAT11(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT2, WRDAT11, __x)
+#define DSI_DIRECT_CMD_WRDAT3 0x0000007C
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT12_SHIFT 0
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT12_MASK 0x000000FF
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT12(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT3, WRDAT12, __x)
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT13_SHIFT 8
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT13_MASK 0x0000FF00
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT13(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT3, WRDAT13, __x)
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT14_SHIFT 16
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT14_MASK 0x00FF0000
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT14(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT3, WRDAT14, __x)
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT15_SHIFT 24
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT15_MASK 0xFF000000
+#define DSI_DIRECT_CMD_WRDAT3_WRDAT15(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_WRDAT3, WRDAT15, __x)
+#define DSI_DIRECT_CMD_RDDAT 0x00000080
+#define DSI_DIRECT_CMD_RDDAT_RDDAT0_SHIFT 0
+#define DSI_DIRECT_CMD_RDDAT_RDDAT0_MASK 0x000000FF
+#define DSI_DIRECT_CMD_RDDAT_RDDAT0(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RDDAT, RDDAT0, __x)
+#define DSI_DIRECT_CMD_RDDAT_RDDAT1_SHIFT 8
+#define DSI_DIRECT_CMD_RDDAT_RDDAT1_MASK 0x0000FF00
+#define DSI_DIRECT_CMD_RDDAT_RDDAT1(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RDDAT, RDDAT1, __x)
+#define DSI_DIRECT_CMD_RDDAT_RDDAT2_SHIFT 16
+#define DSI_DIRECT_CMD_RDDAT_RDDAT2_MASK 0x00FF0000
+#define DSI_DIRECT_CMD_RDDAT_RDDAT2(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RDDAT, RDDAT2, __x)
+#define DSI_DIRECT_CMD_RDDAT_RDDAT3_SHIFT 24
+#define DSI_DIRECT_CMD_RDDAT_RDDAT3_MASK 0xFF000000
+#define DSI_DIRECT_CMD_RDDAT_RDDAT3(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RDDAT, RDDAT3, __x)
+#define DSI_DIRECT_CMD_RD_PROPERTY 0x00000084
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_SIZE_SHIFT 0
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_SIZE_MASK 0x0000FFFF
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_SIZE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_PROPERTY, RD_SIZE, __x)
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_ID_SHIFT 16
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_ID_MASK 0x00030000
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_ID(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_PROPERTY, RD_ID, __x)
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_DCSNOTGENERIC_SHIFT 18
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_DCSNOTGENERIC_MASK 0x00040000
+#define DSI_DIRECT_CMD_RD_PROPERTY_RD_DCSNOTGENERIC(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_PROPERTY, RD_DCSNOTGENERIC, __x)
+#define DSI_DIRECT_CMD_RD_STS 0x00000088
+#define DSI_DIRECT_CMD_RD_STS_ERR_FIXED_SHIFT 0
+#define DSI_DIRECT_CMD_RD_STS_ERR_FIXED_MASK 0x00000001
+#define DSI_DIRECT_CMD_RD_STS_ERR_FIXED(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_FIXED, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_UNCORRECTABLE_SHIFT 1
+#define DSI_DIRECT_CMD_RD_STS_ERR_UNCORRECTABLE_MASK 0x00000002
+#define DSI_DIRECT_CMD_RD_STS_ERR_UNCORRECTABLE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_UNCORRECTABLE, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_CHECKSUM_SHIFT 2
+#define DSI_DIRECT_CMD_RD_STS_ERR_CHECKSUM_MASK 0x00000004
+#define DSI_DIRECT_CMD_RD_STS_ERR_CHECKSUM(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_CHECKSUM, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_UNDECODABLE_SHIFT 3
+#define DSI_DIRECT_CMD_RD_STS_ERR_UNDECODABLE_MASK 0x00000008
+#define DSI_DIRECT_CMD_RD_STS_ERR_UNDECODABLE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_UNDECODABLE, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_RECEIVE_SHIFT 4
+#define DSI_DIRECT_CMD_RD_STS_ERR_RECEIVE_MASK 0x00000010
+#define DSI_DIRECT_CMD_RD_STS_ERR_RECEIVE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_RECEIVE, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_OVERSIZE_SHIFT 5
+#define DSI_DIRECT_CMD_RD_STS_ERR_OVERSIZE_MASK 0x00000020
+#define DSI_DIRECT_CMD_RD_STS_ERR_OVERSIZE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_OVERSIZE, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_WRONG_LENGTH_SHIFT 6
+#define DSI_DIRECT_CMD_RD_STS_ERR_WRONG_LENGTH_MASK 0x00000040
+#define DSI_DIRECT_CMD_RD_STS_ERR_WRONG_LENGTH(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_WRONG_LENGTH, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_MISSING_EOT_SHIFT 7
+#define DSI_DIRECT_CMD_RD_STS_ERR_MISSING_EOT_MASK 0x00000080
+#define DSI_DIRECT_CMD_RD_STS_ERR_MISSING_EOT(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_MISSING_EOT, __x)
+#define DSI_DIRECT_CMD_RD_STS_ERR_EOT_WITH_ERR_SHIFT 8
+#define DSI_DIRECT_CMD_RD_STS_ERR_EOT_WITH_ERR_MASK 0x00000100
+#define DSI_DIRECT_CMD_RD_STS_ERR_EOT_WITH_ERR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS, ERR_EOT_WITH_ERR, __x)
+#define DSI_VID_MAIN_CTL 0x00000090
+#define DSI_VID_MAIN_CTL_START_MODE_SHIFT 0
+#define DSI_VID_MAIN_CTL_START_MODE_MASK 0x00000003
+#define DSI_VID_MAIN_CTL_START_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, START_MODE, __x)
+#define DSI_VID_MAIN_CTL_STOP_MODE_SHIFT 2
+#define DSI_VID_MAIN_CTL_STOP_MODE_MASK 0x0000000C
+#define DSI_VID_MAIN_CTL_STOP_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, STOP_MODE, __x)
+#define DSI_VID_MAIN_CTL_VID_ID_SHIFT 4
+#define DSI_VID_MAIN_CTL_VID_ID_MASK 0x00000030
+#define DSI_VID_MAIN_CTL_VID_ID(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, VID_ID, __x)
+#define DSI_VID_MAIN_CTL_HEADER_SHIFT 6
+#define DSI_VID_MAIN_CTL_HEADER_MASK 0x00000FC0
+#define DSI_VID_MAIN_CTL_HEADER(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, HEADER, __x)
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_SHIFT 12
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_MASK 0x00003000
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_16BITS 0
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_18BITS 1
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_18BITS_LOOSE 2
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_24BITS 3
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE_ENUM(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, VID_PIXEL_MODE, \
+	DSI_VID_MAIN_CTL_VID_PIXEL_MODE_##__x)
+#define DSI_VID_MAIN_CTL_VID_PIXEL_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, VID_PIXEL_MODE, __x)
+#define DSI_VID_MAIN_CTL_BURST_MODE_SHIFT 14
+#define DSI_VID_MAIN_CTL_BURST_MODE_MASK 0x00004000
+#define DSI_VID_MAIN_CTL_BURST_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, BURST_MODE, __x)
+#define DSI_VID_MAIN_CTL_SYNC_PULSE_ACTIVE_SHIFT 15
+#define DSI_VID_MAIN_CTL_SYNC_PULSE_ACTIVE_MASK 0x00008000
+#define DSI_VID_MAIN_CTL_SYNC_PULSE_ACTIVE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, SYNC_PULSE_ACTIVE, __x)
+#define DSI_VID_MAIN_CTL_SYNC_PULSE_HORIZONTAL_SHIFT 16
+#define DSI_VID_MAIN_CTL_SYNC_PULSE_HORIZONTAL_MASK 0x00010000
+#define DSI_VID_MAIN_CTL_SYNC_PULSE_HORIZONTAL(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, SYNC_PULSE_HORIZONTAL, __x)
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_SHIFT 17
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_MASK 0x00060000
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_NULL 0
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_BLANKING 1
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_LP_0 2
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_LP_1 3
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_ENUM(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, REG_BLKLINE_MODE, \
+	DSI_VID_MAIN_CTL_REG_BLKLINE_MODE_##__x)
+#define DSI_VID_MAIN_CTL_REG_BLKLINE_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, REG_BLKLINE_MODE, __x)
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_SHIFT 19
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_MASK 0x00180000
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_NULL 0
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_BLANKING 1
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_LP_0 2
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_LP_1 3
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_ENUM(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, REG_BLKEOL_MODE, \
+	DSI_VID_MAIN_CTL_REG_BLKEOL_MODE_##__x)
+#define DSI_VID_MAIN_CTL_REG_BLKEOL_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, REG_BLKEOL_MODE, __x)
+#define DSI_VID_MAIN_CTL_RECOVERY_MODE_SHIFT 21
+#define DSI_VID_MAIN_CTL_RECOVERY_MODE_MASK 0x00600000
+#define DSI_VID_MAIN_CTL_RECOVERY_MODE(__x) \
+	DSI_VAL2REG(DSI_VID_MAIN_CTL, RECOVERY_MODE, __x)
+#define DSI_VID_VSIZE 0x00000094
+#define DSI_VID_VSIZE_VSA_LENGTH_SHIFT 0
+#define DSI_VID_VSIZE_VSA_LENGTH_MASK 0x0000003F
+#define DSI_VID_VSIZE_VSA_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_VSIZE, VSA_LENGTH, __x)
+#define DSI_VID_VSIZE_VBP_LENGTH_SHIFT 6
+#define DSI_VID_VSIZE_VBP_LENGTH_MASK 0x00000FC0
+#define DSI_VID_VSIZE_VBP_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_VSIZE, VBP_LENGTH, __x)
+#define DSI_VID_VSIZE_VFP_LENGTH_SHIFT 12
+#define DSI_VID_VSIZE_VFP_LENGTH_MASK 0x000FF000
+#define DSI_VID_VSIZE_VFP_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_VSIZE, VFP_LENGTH, __x)
+#define DSI_VID_VSIZE_VACT_LENGTH_SHIFT 20
+#define DSI_VID_VSIZE_VACT_LENGTH_MASK 0x7FF00000
+#define DSI_VID_VSIZE_VACT_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_VSIZE, VACT_LENGTH, __x)
+#define DSI_VID_HSIZE1 0x00000098
+#define DSI_VID_HSIZE1_HSA_LENGTH_SHIFT 0
+#define DSI_VID_HSIZE1_HSA_LENGTH_MASK 0x000003FF
+#define DSI_VID_HSIZE1_HSA_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_HSIZE1, HSA_LENGTH, __x)
+#define DSI_VID_HSIZE1_HBP_LENGTH_SHIFT 10
+#define DSI_VID_HSIZE1_HBP_LENGTH_MASK 0x000FFC00
+#define DSI_VID_HSIZE1_HBP_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_HSIZE1, HBP_LENGTH, __x)
+#define DSI_VID_HSIZE1_HFP_LENGTH_SHIFT 20
+#define DSI_VID_HSIZE1_HFP_LENGTH_MASK 0x7FF00000
+#define DSI_VID_HSIZE1_HFP_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_HSIZE1, HFP_LENGTH, __x)
+#define DSI_VID_HSIZE2 0x0000009C
+#define DSI_VID_HSIZE2_RGB_SIZE_SHIFT 0
+#define DSI_VID_HSIZE2_RGB_SIZE_MASK 0x00001FFF
+#define DSI_VID_HSIZE2_RGB_SIZE(__x) \
+	DSI_VAL2REG(DSI_VID_HSIZE2, RGB_SIZE, __x)
+#define DSI_VID_BLKSIZE1 0x000000A0
+#define DSI_VID_BLKSIZE1_BLKLINE_EVENT_PCK_SHIFT 0
+#define DSI_VID_BLKSIZE1_BLKLINE_EVENT_PCK_MASK 0x00001FFF
+#define DSI_VID_BLKSIZE1_BLKLINE_EVENT_PCK(__x) \
+	DSI_VAL2REG(DSI_VID_BLKSIZE1, BLKLINE_EVENT_PCK, __x)
+#define DSI_VID_BLKSIZE1_BLKEOL_PCK_SHIFT 13
+#define DSI_VID_BLKSIZE1_BLKEOL_PCK_MASK 0x03FFE000
+#define DSI_VID_BLKSIZE1_BLKEOL_PCK(__x) \
+	DSI_VAL2REG(DSI_VID_BLKSIZE1, BLKEOL_PCK, __x)
+#define DSI_VID_BLKSIZE2 0x000000A4
+#define DSI_VID_BLKSIZE2_BLKLINE_PULSE_PCK_SHIFT 0
+#define DSI_VID_BLKSIZE2_BLKLINE_PULSE_PCK_MASK 0x00001FFF
+#define DSI_VID_BLKSIZE2_BLKLINE_PULSE_PCK(__x) \
+	DSI_VAL2REG(DSI_VID_BLKSIZE2, BLKLINE_PULSE_PCK, __x)
+#define DSI_VID_PCK_TIME 0x000000A8
+#define DSI_VID_PCK_TIME_BLKEOL_DURATION_SHIFT 0
+#define DSI_VID_PCK_TIME_BLKEOL_DURATION_MASK 0x00001FFF
+#define DSI_VID_PCK_TIME_BLKEOL_DURATION(__x) \
+	DSI_VAL2REG(DSI_VID_PCK_TIME, BLKEOL_DURATION, __x)
+#define DSI_VID_DPHY_TIME 0x000000AC
+#define DSI_VID_DPHY_TIME_REG_LINE_DURATION_SHIFT 0
+#define DSI_VID_DPHY_TIME_REG_LINE_DURATION_MASK 0x00001FFF
+#define DSI_VID_DPHY_TIME_REG_LINE_DURATION(__x) \
+	DSI_VAL2REG(DSI_VID_DPHY_TIME, REG_LINE_DURATION, __x)
+#define DSI_VID_DPHY_TIME_REG_WAKEUP_TIME_SHIFT 13
+#define DSI_VID_DPHY_TIME_REG_WAKEUP_TIME_MASK 0x00FFE000
+#define DSI_VID_DPHY_TIME_REG_WAKEUP_TIME(__x) \
+	DSI_VAL2REG(DSI_VID_DPHY_TIME, REG_WAKEUP_TIME, __x)
+#define DSI_VID_ERR_COLOR 0x000000B0
+#define DSI_VID_ERR_COLOR_COL_RED_SHIFT 0
+#define DSI_VID_ERR_COLOR_COL_RED_MASK 0x000000FF
+#define DSI_VID_ERR_COLOR_COL_RED(__x) \
+	DSI_VAL2REG(DSI_VID_ERR_COLOR, COL_RED, __x)
+#define DSI_VID_ERR_COLOR_COL_GREEN_SHIFT 8
+#define DSI_VID_ERR_COLOR_COL_GREEN_MASK 0x0000FF00
+#define DSI_VID_ERR_COLOR_COL_GREEN(__x) \
+	DSI_VAL2REG(DSI_VID_ERR_COLOR, COL_GREEN, __x)
+#define DSI_VID_ERR_COLOR_COL_BLUE_SHIFT 16
+#define DSI_VID_ERR_COLOR_COL_BLUE_MASK 0x00FF0000
+#define DSI_VID_ERR_COLOR_COL_BLUE(__x) \
+	DSI_VAL2REG(DSI_VID_ERR_COLOR, COL_BLUE, __x)
+#define DSI_VID_ERR_COLOR_PAD_VAL_SHIFT 24
+#define DSI_VID_ERR_COLOR_PAD_VAL_MASK 0xFF000000
+#define DSI_VID_ERR_COLOR_PAD_VAL(__x) \
+	DSI_VAL2REG(DSI_VID_ERR_COLOR, PAD_VAL, __x)
+#define DSI_VID_VPOS 0x000000B4
+#define DSI_VID_VPOS_LINE_POS_SHIFT 0
+#define DSI_VID_VPOS_LINE_POS_MASK 0x00000003
+#define DSI_VID_VPOS_LINE_POS(__x) \
+	DSI_VAL2REG(DSI_VID_VPOS, LINE_POS, __x)
+#define DSI_VID_VPOS_LINE_VAL_SHIFT 2
+#define DSI_VID_VPOS_LINE_VAL_MASK 0x00001FFC
+#define DSI_VID_VPOS_LINE_VAL(__x) \
+	DSI_VAL2REG(DSI_VID_VPOS, LINE_VAL, __x)
+#define DSI_VID_HPOS 0x000000B8
+#define DSI_VID_HPOS_HORIZONTAL_POS_SHIFT 0
+#define DSI_VID_HPOS_HORIZONTAL_POS_MASK 0x00000007
+#define DSI_VID_HPOS_HORIZONTAL_POS(__x) \
+	DSI_VAL2REG(DSI_VID_HPOS, HORIZONTAL_POS, __x)
+#define DSI_VID_HPOS_HORIZONTAL_VAL_SHIFT 3
+#define DSI_VID_HPOS_HORIZONTAL_VAL_MASK 0x0000FFF8
+#define DSI_VID_HPOS_HORIZONTAL_VAL(__x) \
+	DSI_VAL2REG(DSI_VID_HPOS, HORIZONTAL_VAL, __x)
+#define DSI_VID_MODE_STS 0x000000BC
+#define DSI_VID_MODE_STS_VSG_RUNNING_SHIFT 0
+#define DSI_VID_MODE_STS_VSG_RUNNING_MASK 0x00000001
+#define DSI_VID_MODE_STS_VSG_RUNNING(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, VSG_RUNNING, __x)
+#define DSI_VID_MODE_STS_ERR_MISSING_DATA_SHIFT 1
+#define DSI_VID_MODE_STS_ERR_MISSING_DATA_MASK 0x00000002
+#define DSI_VID_MODE_STS_ERR_MISSING_DATA(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_MISSING_DATA, __x)
+#define DSI_VID_MODE_STS_ERR_MISSING_HSYNC_SHIFT 2
+#define DSI_VID_MODE_STS_ERR_MISSING_HSYNC_MASK 0x00000004
+#define DSI_VID_MODE_STS_ERR_MISSING_HSYNC(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_MISSING_HSYNC, __x)
+#define DSI_VID_MODE_STS_ERR_MISSING_VSYNC_SHIFT 3
+#define DSI_VID_MODE_STS_ERR_MISSING_VSYNC_MASK 0x00000008
+#define DSI_VID_MODE_STS_ERR_MISSING_VSYNC(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_MISSING_VSYNC, __x)
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_LENGTH_SHIFT 4
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_LENGTH_MASK 0x00000010
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, REG_ERR_SMALL_LENGTH, __x)
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_HEIGHT_SHIFT 5
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_HEIGHT_MASK 0x00000020
+#define DSI_VID_MODE_STS_REG_ERR_SMALL_HEIGHT(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, REG_ERR_SMALL_HEIGHT, __x)
+#define DSI_VID_MODE_STS_ERR_BURSTWRITE_SHIFT 6
+#define DSI_VID_MODE_STS_ERR_BURSTWRITE_MASK 0x00000040
+#define DSI_VID_MODE_STS_ERR_BURSTWRITE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_BURSTWRITE, __x)
+#define DSI_VID_MODE_STS_ERR_LONGWRITE_SHIFT 7
+#define DSI_VID_MODE_STS_ERR_LONGWRITE_MASK 0x00000080
+#define DSI_VID_MODE_STS_ERR_LONGWRITE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_LONGWRITE, __x)
+#define DSI_VID_MODE_STS_ERR_LONGREAD_SHIFT 8
+#define DSI_VID_MODE_STS_ERR_LONGREAD_MASK 0x00000100
+#define DSI_VID_MODE_STS_ERR_LONGREAD(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_LONGREAD, __x)
+#define DSI_VID_MODE_STS_ERR_VRS_WRONG_LENGTH_SHIFT 9
+#define DSI_VID_MODE_STS_ERR_VRS_WRONG_LENGTH_MASK 0x00000200
+#define DSI_VID_MODE_STS_ERR_VRS_WRONG_LENGTH(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, ERR_VRS_WRONG_LENGTH, __x)
+#define DSI_VID_MODE_STS_VSG_RECOVERY_SHIFT 10
+#define DSI_VID_MODE_STS_VSG_RECOVERY_MASK 0x00000400
+#define DSI_VID_MODE_STS_VSG_RECOVERY(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS, VSG_RECOVERY, __x)
+#define DSI_VID_VCA_SETTING1 0x000000C0
+#define DSI_VID_VCA_SETTING1_MAX_BURST_LIMIT_SHIFT 0
+#define DSI_VID_VCA_SETTING1_MAX_BURST_LIMIT_MASK 0x0000FFFF
+#define DSI_VID_VCA_SETTING1_MAX_BURST_LIMIT(__x) \
+	DSI_VAL2REG(DSI_VID_VCA_SETTING1, MAX_BURST_LIMIT, __x)
+#define DSI_VID_VCA_SETTING1_BURST_LP_SHIFT 16
+#define DSI_VID_VCA_SETTING1_BURST_LP_MASK 0x00010000
+#define DSI_VID_VCA_SETTING1_BURST_LP(__x) \
+	DSI_VAL2REG(DSI_VID_VCA_SETTING1, BURST_LP, __x)
+#define DSI_VID_VCA_SETTING2 0x000000C4
+#define DSI_VID_VCA_SETTING2_EXACT_BURST_LIMIT_SHIFT 0
+#define DSI_VID_VCA_SETTING2_EXACT_BURST_LIMIT_MASK 0x0000FFFF
+#define DSI_VID_VCA_SETTING2_EXACT_BURST_LIMIT(__x) \
+	DSI_VAL2REG(DSI_VID_VCA_SETTING2, EXACT_BURST_LIMIT, __x)
+#define DSI_VID_VCA_SETTING2_MAX_LINE_LIMIT_SHIFT 16
+#define DSI_VID_VCA_SETTING2_MAX_LINE_LIMIT_MASK 0xFFFF0000
+#define DSI_VID_VCA_SETTING2_MAX_LINE_LIMIT(__x) \
+	DSI_VAL2REG(DSI_VID_VCA_SETTING2, MAX_LINE_LIMIT, __x)
+#define DSI_TVG_CTL 0x000000C8
+#define DSI_TVG_CTL_TVG_RUN_SHIFT 0
+#define DSI_TVG_CTL_TVG_RUN_MASK 0x00000001
+#define DSI_TVG_CTL_TVG_RUN(__x) \
+	DSI_VAL2REG(DSI_TVG_CTL, TVG_RUN, __x)
+#define DSI_TVG_CTL_TVG_STOPMODE_SHIFT 1
+#define DSI_TVG_CTL_TVG_STOPMODE_MASK 0x00000006
+#define DSI_TVG_CTL_TVG_STOPMODE(__x) \
+	DSI_VAL2REG(DSI_TVG_CTL, TVG_STOPMODE, __x)
+#define DSI_TVG_CTL_TVG_MODE_SHIFT 3
+#define DSI_TVG_CTL_TVG_MODE_MASK 0x00000018
+#define DSI_TVG_CTL_TVG_MODE(__x) \
+	DSI_VAL2REG(DSI_TVG_CTL, TVG_MODE, __x)
+#define DSI_TVG_CTL_TVG_STRIPE_SIZE_SHIFT 5
+#define DSI_TVG_CTL_TVG_STRIPE_SIZE_MASK 0x000000E0
+#define DSI_TVG_CTL_TVG_STRIPE_SIZE(__x) \
+	DSI_VAL2REG(DSI_TVG_CTL, TVG_STRIPE_SIZE, __x)
+#define DSI_TVG_IMG_SIZE 0x000000CC
+#define DSI_TVG_IMG_SIZE_TVG_LINE_SIZE_SHIFT 0
+#define DSI_TVG_IMG_SIZE_TVG_LINE_SIZE_MASK 0x00001FFF
+#define DSI_TVG_IMG_SIZE_TVG_LINE_SIZE(__x) \
+	DSI_VAL2REG(DSI_TVG_IMG_SIZE, TVG_LINE_SIZE, __x)
+#define DSI_TVG_IMG_SIZE_TVG_NBLINE_SHIFT 16
+#define DSI_TVG_IMG_SIZE_TVG_NBLINE_MASK 0x07FF0000
+#define DSI_TVG_IMG_SIZE_TVG_NBLINE(__x) \
+	DSI_VAL2REG(DSI_TVG_IMG_SIZE, TVG_NBLINE, __x)
+#define DSI_TVG_COLOR1 0x000000D0
+#define DSI_TVG_COLOR1_COL1_RED_SHIFT 0
+#define DSI_TVG_COLOR1_COL1_RED_MASK 0x000000FF
+#define DSI_TVG_COLOR1_COL1_RED(__x) \
+	DSI_VAL2REG(DSI_TVG_COLOR1, COL1_RED, __x)
+#define DSI_TVG_COLOR1_COL1_GREEN_SHIFT 8
+#define DSI_TVG_COLOR1_COL1_GREEN_MASK 0x0000FF00
+#define DSI_TVG_COLOR1_COL1_GREEN(__x) \
+	DSI_VAL2REG(DSI_TVG_COLOR1, COL1_GREEN, __x)
+#define DSI_TVG_COLOR1_COL1_BLUE_SHIFT 16
+#define DSI_TVG_COLOR1_COL1_BLUE_MASK 0x00FF0000
+#define DSI_TVG_COLOR1_COL1_BLUE(__x) \
+	DSI_VAL2REG(DSI_TVG_COLOR1, COL1_BLUE, __x)
+#define DSI_TVG_COLOR2 0x000000D4
+#define DSI_TVG_COLOR2_COL2_RED_SHIFT 0
+#define DSI_TVG_COLOR2_COL2_RED_MASK 0x000000FF
+#define DSI_TVG_COLOR2_COL2_RED(__x) \
+	DSI_VAL2REG(DSI_TVG_COLOR2, COL2_RED, __x)
+#define DSI_TVG_COLOR2_COL2_GREEN_SHIFT 8
+#define DSI_TVG_COLOR2_COL2_GREEN_MASK 0x0000FF00
+#define DSI_TVG_COLOR2_COL2_GREEN(__x) \
+	DSI_VAL2REG(DSI_TVG_COLOR2, COL2_GREEN, __x)
+#define DSI_TVG_COLOR2_COL2_BLUE_SHIFT 16
+#define DSI_TVG_COLOR2_COL2_BLUE_MASK 0x00FF0000
+#define DSI_TVG_COLOR2_COL2_BLUE(__x) \
+	DSI_VAL2REG(DSI_TVG_COLOR2, COL2_BLUE, __x)
+#define DSI_TVG_STS 0x000000D8
+#define DSI_TVG_STS_TVG_RUNNING_SHIFT 0
+#define DSI_TVG_STS_TVG_RUNNING_MASK 0x00000001
+#define DSI_TVG_STS_TVG_RUNNING(__x) \
+	DSI_VAL2REG(DSI_TVG_STS, TVG_RUNNING, __x)
+#define DSI_TBG_CTL 0x000000E0
+#define DSI_TBG_CTL_TBG_START_SHIFT 0
+#define DSI_TBG_CTL_TBG_START_MASK 0x00000001
+#define DSI_TBG_CTL_TBG_START(__x) \
+	DSI_VAL2REG(DSI_TBG_CTL, TBG_START, __x)
+#define DSI_TBG_CTL_TBG_HS_REQ_SHIFT 1
+#define DSI_TBG_CTL_TBG_HS_REQ_MASK 0x00000002
+#define DSI_TBG_CTL_TBG_HS_REQ(__x) \
+	DSI_VAL2REG(DSI_TBG_CTL, TBG_HS_REQ, __x)
+#define DSI_TBG_CTL_TBG_DATA_SEL_SHIFT 2
+#define DSI_TBG_CTL_TBG_DATA_SEL_MASK 0x00000004
+#define DSI_TBG_CTL_TBG_DATA_SEL(__x) \
+	DSI_VAL2REG(DSI_TBG_CTL, TBG_DATA_SEL, __x)
+#define DSI_TBG_CTL_TBG_MODE_SHIFT 3
+#define DSI_TBG_CTL_TBG_MODE_MASK 0x00000018
+#define DSI_TBG_CTL_TBG_MODE_1BYTE 0
+#define DSI_TBG_CTL_TBG_MODE_2BYTE 1
+#define DSI_TBG_CTL_TBG_MODE_BURST_COUNTER 2
+#define DSI_TBG_CTL_TBG_MODE_BURST 3
+#define DSI_TBG_CTL_TBG_MODE_ENUM(__x) \
+	DSI_VAL2REG(DSI_TBG_CTL, TBG_MODE, DSI_TBG_CTL_TBG_MODE_##__x)
+#define DSI_TBG_CTL_TBG_MODE(__x) \
+	DSI_VAL2REG(DSI_TBG_CTL, TBG_MODE, __x)
+#define DSI_TBG_SETTING 0x000000E4
+#define DSI_TBG_SETTING_TBG_DATA_SHIFT 0
+#define DSI_TBG_SETTING_TBG_DATA_MASK 0x0000FFFF
+#define DSI_TBG_SETTING_TBG_DATA(__x) \
+	DSI_VAL2REG(DSI_TBG_SETTING, TBG_DATA, __x)
+#define DSI_TBG_SETTING_TBG_CPT_SHIFT 16
+#define DSI_TBG_SETTING_TBG_CPT_MASK 0x0FFF0000
+#define DSI_TBG_SETTING_TBG_CPT(__x) \
+	DSI_VAL2REG(DSI_TBG_SETTING, TBG_CPT, __x)
+#define DSI_TBG_STS 0x000000E8
+#define DSI_TBG_STS_TBG_STATUS_SHIFT 0
+#define DSI_TBG_STS_TBG_STATUS_MASK 0x00000001
+#define DSI_TBG_STS_TBG_STATUS(__x) \
+	DSI_VAL2REG(DSI_TBG_STS, TBG_STATUS, __x)
+#define DSI_MCTL_MAIN_STS_CTL 0x000000F0
+#define DSI_MCTL_MAIN_STS_CTL_PLL_LOCK_EN_SHIFT 0
+#define DSI_MCTL_MAIN_STS_CTL_PLL_LOCK_EN_MASK 0x00000001
+#define DSI_MCTL_MAIN_STS_CTL_PLL_LOCK_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, PLL_LOCK_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_CLKLANE_READY_EN_SHIFT 1
+#define DSI_MCTL_MAIN_STS_CTL_CLKLANE_READY_EN_MASK 0x00000002
+#define DSI_MCTL_MAIN_STS_CTL_CLKLANE_READY_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, CLKLANE_READY_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_DAT1_READY_EN_SHIFT 2
+#define DSI_MCTL_MAIN_STS_CTL_DAT1_READY_EN_MASK 0x00000004
+#define DSI_MCTL_MAIN_STS_CTL_DAT1_READY_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, DAT1_READY_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_DAT2_READY_EN_SHIFT 3
+#define DSI_MCTL_MAIN_STS_CTL_DAT2_READY_EN_MASK 0x00000008
+#define DSI_MCTL_MAIN_STS_CTL_DAT2_READY_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, DAT2_READY_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_HSTX_TO_ERR_EN_SHIFT 4
+#define DSI_MCTL_MAIN_STS_CTL_HSTX_TO_ERR_EN_MASK 0x00000010
+#define DSI_MCTL_MAIN_STS_CTL_HSTX_TO_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, HSTX_TO_ERR_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_LPRX_TO_ERR_EN_SHIFT 5
+#define DSI_MCTL_MAIN_STS_CTL_LPRX_TO_ERR_EN_MASK 0x00000020
+#define DSI_MCTL_MAIN_STS_CTL_LPRX_TO_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, LPRX_TO_ERR_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_CRS_UNTERM_PCK_ERR_EN_SHIFT 6
+#define DSI_MCTL_MAIN_STS_CTL_CRS_UNTERM_PCK_ERR_EN_MASK 0x00000040
+#define DSI_MCTL_MAIN_STS_CTL_CRS_UNTERM_PCK_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, CRS_UNTERM_PCK_ERR_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_VRS_UNTERM_PCK_ERR_EN_SHIFT 7
+#define DSI_MCTL_MAIN_STS_CTL_VRS_UNTERM_PCK_ERR_EN_MASK 0x00000080
+#define DSI_MCTL_MAIN_STS_CTL_VRS_UNTERM_PCK_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, VRS_UNTERM_PCK_ERR_EN, __x)
+#define DSI_MCTL_MAIN_STS_CTL_PLL_LOCK_EDGE_SHIFT 16
+#define DSI_MCTL_MAIN_STS_CTL_PLL_LOCK_EDGE_MASK 0x00010000
+#define DSI_MCTL_MAIN_STS_CTL_PLL_LOCK_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, PLL_LOCK_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_CLKLANE_READY_EDGE_SHIFT 17
+#define DSI_MCTL_MAIN_STS_CTL_CLKLANE_READY_EDGE_MASK 0x00020000
+#define DSI_MCTL_MAIN_STS_CTL_CLKLANE_READY_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, CLKLANE_READY_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_DAT1_READY_EDGE_SHIFT 18
+#define DSI_MCTL_MAIN_STS_CTL_DAT1_READY_EDGE_MASK 0x00040000
+#define DSI_MCTL_MAIN_STS_CTL_DAT1_READY_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, DAT1_READY_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_DAT2_READY_EDGE_SHIFT 19
+#define DSI_MCTL_MAIN_STS_CTL_DAT2_READY_EDGE_MASK 0x00080000
+#define DSI_MCTL_MAIN_STS_CTL_DAT2_READY_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, DAT2_READY_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_HSTX_TO_ERR_EDGE_SHIFT 20
+#define DSI_MCTL_MAIN_STS_CTL_HSTX_TO_ERR_EDGE_MASK 0x00100000
+#define DSI_MCTL_MAIN_STS_CTL_HSTX_TO_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, HSTX_TO_ERR_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_LPRX_TO_ERR_EDGE_SHIFT 21
+#define DSI_MCTL_MAIN_STS_CTL_LPRX_TO_ERR_EDGE_MASK 0x00200000
+#define DSI_MCTL_MAIN_STS_CTL_LPRX_TO_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, LPRX_TO_ERR_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_CRS_UNTERM_PCK_ERR_EDGE_SHIFT 22
+#define DSI_MCTL_MAIN_STS_CTL_CRS_UNTERM_PCK_ERR_EDGE_MASK 0x00400000
+#define DSI_MCTL_MAIN_STS_CTL_CRS_UNTERM_PCK_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, CRS_UNTERM_PCK_ERR_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CTL_VRS_UNTERM_PCK_ERR_EDGE_SHIFT 23
+#define DSI_MCTL_MAIN_STS_CTL_VRS_UNTERM_PCK_ERR_EDGE_MASK 0x00800000
+#define DSI_MCTL_MAIN_STS_CTL_VRS_UNTERM_PCK_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CTL, VRS_UNTERM_PCK_ERR_EDGE, __x)
+#define DSI_CMD_MODE_STS_CTL 0x000000F4
+#define DSI_CMD_MODE_STS_CTL_ERR_NO_TE_EN_SHIFT 0
+#define DSI_CMD_MODE_STS_CTL_ERR_NO_TE_EN_MASK 0x00000001
+#define DSI_CMD_MODE_STS_CTL_ERR_NO_TE_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_NO_TE_EN, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_TE_MISS_EN_SHIFT 1
+#define DSI_CMD_MODE_STS_CTL_ERR_TE_MISS_EN_MASK 0x00000002
+#define DSI_CMD_MODE_STS_CTL_ERR_TE_MISS_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_TE_MISS_EN, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI1_UNDERRUN_EN_SHIFT 2
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI1_UNDERRUN_EN_MASK 0x00000004
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI1_UNDERRUN_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_SDI1_UNDERRUN_EN, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI2_UNDERRUN_EN_SHIFT 3
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI2_UNDERRUN_EN_MASK 0x00000008
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI2_UNDERRUN_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_SDI2_UNDERRUN_EN, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_UNWANTED_RD_EN_SHIFT 4
+#define DSI_CMD_MODE_STS_CTL_ERR_UNWANTED_RD_EN_MASK 0x00000010
+#define DSI_CMD_MODE_STS_CTL_ERR_UNWANTED_RD_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_UNWANTED_RD_EN, __x)
+#define DSI_CMD_MODE_STS_CTL_CSM_RUNNING_EN_SHIFT 5
+#define DSI_CMD_MODE_STS_CTL_CSM_RUNNING_EN_MASK 0x00000020
+#define DSI_CMD_MODE_STS_CTL_CSM_RUNNING_EN(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, CSM_RUNNING_EN, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_NO_TE_EDGE_SHIFT 16
+#define DSI_CMD_MODE_STS_CTL_ERR_NO_TE_EDGE_MASK 0x00010000
+#define DSI_CMD_MODE_STS_CTL_ERR_NO_TE_EDGE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_NO_TE_EDGE, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_TE_MISS_EDGE_SHIFT 17
+#define DSI_CMD_MODE_STS_CTL_ERR_TE_MISS_EDGE_MASK 0x00020000
+#define DSI_CMD_MODE_STS_CTL_ERR_TE_MISS_EDGE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_TE_MISS_EDGE, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI1_UNDERRUN_EDGE_SHIFT 18
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI1_UNDERRUN_EDGE_MASK 0x00040000
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI1_UNDERRUN_EDGE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_SDI1_UNDERRUN_EDGE, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI2_UNDERRUN_EDGE_SHIFT 19
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI2_UNDERRUN_EDGE_MASK 0x00080000
+#define DSI_CMD_MODE_STS_CTL_ERR_SDI2_UNDERRUN_EDGE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_SDI2_UNDERRUN_EDGE, __x)
+#define DSI_CMD_MODE_STS_CTL_ERR_UNWANTED_RD_EDGE_SHIFT 20
+#define DSI_CMD_MODE_STS_CTL_ERR_UNWANTED_RD_EDGE_MASK 0x00100000
+#define DSI_CMD_MODE_STS_CTL_ERR_UNWANTED_RD_EDGE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, ERR_UNWANTED_RD_EDGE, __x)
+#define DSI_CMD_MODE_STS_CTL_CSM_RUNNING_EDGE_SHIFT 21
+#define DSI_CMD_MODE_STS_CTL_CSM_RUNNING_EDGE_MASK 0x00200000
+#define DSI_CMD_MODE_STS_CTL_CSM_RUNNING_EDGE(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CTL, CSM_RUNNING_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL 0x000000F8
+#define DSI_DIRECT_CMD_STS_CTL_CMD_TRANSMISSION_EN_SHIFT 0
+#define DSI_DIRECT_CMD_STS_CTL_CMD_TRANSMISSION_EN_MASK 0x00000001
+#define DSI_DIRECT_CMD_STS_CTL_CMD_TRANSMISSION_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, CMD_TRANSMISSION_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_WRITE_COMPLETED_EN_SHIFT 1
+#define DSI_DIRECT_CMD_STS_CTL_WRITE_COMPLETED_EN_MASK 0x00000002
+#define DSI_DIRECT_CMD_STS_CTL_WRITE_COMPLETED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, WRITE_COMPLETED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_COMPLETED_EN_SHIFT 2
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_COMPLETED_EN_MASK 0x00000004
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_COMPLETED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, TRIGGER_COMPLETED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_EN_SHIFT 3
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_EN_MASK 0x00000008
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, READ_COMPLETED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_RECEIVED_EN_SHIFT 4
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_RECEIVED_EN_MASK 0x00000010
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_RECEIVED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, ACKNOWLEDGE_RECEIVED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_WITH_ERR_EN_SHIFT 5
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_WITH_ERR_EN_MASK 0x00000020
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_WITH_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, ACKNOWLEDGE_WITH_ERR_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_RECEIVED_EN_SHIFT 6
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_RECEIVED_EN_MASK 0x00000040
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_RECEIVED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, TRIGGER_RECEIVED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_TE_RECEIVED_EN_SHIFT 7
+#define DSI_DIRECT_CMD_STS_CTL_TE_RECEIVED_EN_MASK 0x00000080
+#define DSI_DIRECT_CMD_STS_CTL_TE_RECEIVED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, TE_RECEIVED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_BTA_COMPLETED_EN_SHIFT 8
+#define DSI_DIRECT_CMD_STS_CTL_BTA_COMPLETED_EN_MASK 0x00000100
+#define DSI_DIRECT_CMD_STS_CTL_BTA_COMPLETED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, BTA_COMPLETED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_BTA_FINISHED_EN_SHIFT 9
+#define DSI_DIRECT_CMD_STS_CTL_BTA_FINISHED_EN_MASK 0x00000200
+#define DSI_DIRECT_CMD_STS_CTL_BTA_FINISHED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, BTA_FINISHED_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_WITH_ERR_EN_SHIFT 10
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_WITH_ERR_EN_MASK 0x00000400
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_WITH_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, READ_COMPLETED_WITH_ERR_EN, __x)
+#define DSI_DIRECT_CMD_STS_CTL_CMD_TRANSMISSION_EDGE_SHIFT 16
+#define DSI_DIRECT_CMD_STS_CTL_CMD_TRANSMISSION_EDGE_MASK 0x00010000
+#define DSI_DIRECT_CMD_STS_CTL_CMD_TRANSMISSION_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, CMD_TRANSMISSION_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_WRITE_COMPLETED_EDGE_SHIFT 17
+#define DSI_DIRECT_CMD_STS_CTL_WRITE_COMPLETED_EDGE_MASK 0x00020000
+#define DSI_DIRECT_CMD_STS_CTL_WRITE_COMPLETED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, WRITE_COMPLETED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_COMPLETED_EDGE_SHIFT 18
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_COMPLETED_EDGE_MASK 0x00040000
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_COMPLETED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, TRIGGER_COMPLETED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_EDGE_SHIFT 19
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_EDGE_MASK 0x00080000
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, READ_COMPLETED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_RECEIVED_EDGE_SHIFT 20
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_RECEIVED_EDGE_MASK 0x00100000
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_RECEIVED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, ACKNOWLEDGE_RECEIVED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_WITH_ERR_EDGE_SHIFT 21
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_WITH_ERR_EDGE_MASK 0x00200000
+#define DSI_DIRECT_CMD_STS_CTL_ACKNOWLEDGE_WITH_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, ACKNOWLEDGE_WITH_ERR_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_RECEIVED_EDGE_SHIFT 22
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_RECEIVED_EDGE_MASK 0x00400000
+#define DSI_DIRECT_CMD_STS_CTL_TRIGGER_RECEIVED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, TRIGGER_RECEIVED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_TE_RECEIVED_EDGE_SHIFT 23
+#define DSI_DIRECT_CMD_STS_CTL_TE_RECEIVED_EDGE_MASK 0x00800000
+#define DSI_DIRECT_CMD_STS_CTL_TE_RECEIVED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, TE_RECEIVED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_BTA_COMPLETED_EDGE_SHIFT 24
+#define DSI_DIRECT_CMD_STS_CTL_BTA_COMPLETED_EDGE_MASK 0x01000000
+#define DSI_DIRECT_CMD_STS_CTL_BTA_COMPLETED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, BTA_COMPLETED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_BTA_FINISHED_EDGE_SHIFT 25
+#define DSI_DIRECT_CMD_STS_CTL_BTA_FINISHED_EDGE_MASK 0x02000000
+#define DSI_DIRECT_CMD_STS_CTL_BTA_FINISHED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, BTA_FINISHED_EDGE, __x)
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_WITH_ERR_EDGE_SHIFT 26
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_WITH_ERR_EDGE_MASK 0x04000000
+#define DSI_DIRECT_CMD_STS_CTL_READ_COMPLETED_WITH_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CTL, READ_COMPLETED_WITH_ERR_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL 0x000000FC
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_FIXED_EN_SHIFT 0
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_FIXED_EN_MASK 0x00000001
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_FIXED_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_FIXED_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNCORRECTABLE_EN_SHIFT 1
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNCORRECTABLE_EN_MASK 0x00000002
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNCORRECTABLE_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_UNCORRECTABLE_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_CHECKSUM_EN_SHIFT 2
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_CHECKSUM_EN_MASK 0x00000004
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_CHECKSUM_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_CHECKSUM_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNDECODABLE_EN_SHIFT 3
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNDECODABLE_EN_MASK 0x00000008
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNDECODABLE_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_UNDECODABLE_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_RECEIVE_EN_SHIFT 4
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_RECEIVE_EN_MASK 0x00000010
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_RECEIVE_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_RECEIVE_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_OVERSIZE_EN_SHIFT 5
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_OVERSIZE_EN_MASK 0x00000020
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_OVERSIZE_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_OVERSIZE_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_WRONG_LENGTH_EN_SHIFT 6
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_WRONG_LENGTH_EN_MASK 0x00000040
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_WRONG_LENGTH_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_WRONG_LENGTH_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_MISSING_EOT_EN_SHIFT 7
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_MISSING_EOT_EN_MASK 0x00000080
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_MISSING_EOT_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_MISSING_EOT_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_EOT_WITH_ERR_EN_SHIFT 8
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_EOT_WITH_ERR_EN_MASK 0x00000100
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_EOT_WITH_ERR_EN(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_EOT_WITH_ERR_EN, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_FIXED_EDGE_SHIFT 16
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_FIXED_EDGE_MASK 0x00010000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_FIXED_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_FIXED_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNCORRECTABLE_EDGE_SHIFT 17
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNCORRECTABLE_EDGE_MASK 0x00020000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNCORRECTABLE_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_UNCORRECTABLE_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_CHECKSUM_EDGE_SHIFT 18
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_CHECKSUM_EDGE_MASK 0x00040000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_CHECKSUM_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_CHECKSUM_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNDECODABLE_EDGE_SHIFT 19
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNDECODABLE_EDGE_MASK 0x00080000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_UNDECODABLE_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_UNDECODABLE_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_RECEIVE_EDGE_SHIFT 20
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_RECEIVE_EDGE_MASK 0x00100000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_RECEIVE_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_RECEIVE_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_OVERSIZE_EDGE_SHIFT 21
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_OVERSIZE_EDGE_MASK 0x00200000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_OVERSIZE_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_OVERSIZE_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_WRONG_LENGTH_EDGE_SHIFT 22
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_WRONG_LENGTH_EDGE_MASK 0x00400000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_WRONG_LENGTH_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_WRONG_LENGTH_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_MISSING_EOT_EDGE_SHIFT 23
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_MISSING_EOT_EDGE_MASK 0x00800000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_MISSING_EOT_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_MISSING_EOT_EDGE, __x)
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_EOT_WITH_ERR_EDGE_SHIFT 24
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_EOT_WITH_ERR_EDGE_MASK 0x01000000
+#define DSI_DIRECT_CMD_RD_STS_CTL_ERR_EOT_WITH_ERR_EDGE(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CTL, ERR_EOT_WITH_ERR_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL 0x00000100
+#define DSI_VID_MODE_STS_CTL_VSG_RUNNING_EN_SHIFT 0
+#define DSI_VID_MODE_STS_CTL_VSG_RUNNING_EN_MASK 0x00000001
+#define DSI_VID_MODE_STS_CTL_VSG_RUNNING_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, VSG_RUNNING_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA_EN_SHIFT 1
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA_EN_MASK 0x00000002
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_MISSING_DATA_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_HSYNC_EN_SHIFT 2
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_HSYNC_EN_MASK 0x00000004
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_HSYNC_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_MISSING_HSYNC_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC_EN_SHIFT 3
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC_EN_MASK 0x00000008
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_MISSING_VSYNC_EN, __x)
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_LENGTH_EN_SHIFT 4
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_LENGTH_EN_MASK 0x00000010
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_LENGTH_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, REG_ERR_SMALL_LENGTH_EN, __x)
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_HEIGHT_EN_SHIFT 5
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_HEIGHT_EN_MASK 0x00000020
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_HEIGHT_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, REG_ERR_SMALL_HEIGHT_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_BURSTWRITE_EN_SHIFT 6
+#define DSI_VID_MODE_STS_CTL_ERR_BURSTWRITE_EN_MASK 0x00000040
+#define DSI_VID_MODE_STS_CTL_ERR_BURSTWRITE_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_BURSTWRITE_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_LONGWRITE_EN_SHIFT 7
+#define DSI_VID_MODE_STS_CTL_ERR_LONGWRITE_EN_MASK 0x00000080
+#define DSI_VID_MODE_STS_CTL_ERR_LONGWRITE_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_LONGWRITE_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_LONGREAD_EN_SHIFT 8
+#define DSI_VID_MODE_STS_CTL_ERR_LONGREAD_EN_MASK 0x00000100
+#define DSI_VID_MODE_STS_CTL_ERR_LONGREAD_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_LONGREAD_EN, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_VRS_WRONG_LENGTH_EN_SHIFT 9
+#define DSI_VID_MODE_STS_CTL_ERR_VRS_WRONG_LENGTH_EN_MASK 0x00000200
+#define DSI_VID_MODE_STS_CTL_ERR_VRS_WRONG_LENGTH_EN(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_VRS_WRONG_LENGTH_EN, __x)
+#define DSI_VID_MODE_STS_CTL_VSG_RUNNING_EDGE_SHIFT 16
+#define DSI_VID_MODE_STS_CTL_VSG_RUNNING_EDGE_MASK 0x00010000
+#define DSI_VID_MODE_STS_CTL_VSG_RUNNING_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, VSG_RUNNING_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA_EDGE_SHIFT 17
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA_EDGE_MASK 0x00020000
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_DATA_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_MISSING_DATA_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_HSYNC_EDGE_SHIFT 18
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_HSYNC_EDGE_MASK 0x00040000
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_HSYNC_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_MISSING_HSYNC_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC_EDGE_SHIFT 19
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC_EDGE_MASK 0x00080000
+#define DSI_VID_MODE_STS_CTL_ERR_MISSING_VSYNC_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_MISSING_VSYNC_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_LENGTH_EDGE_SHIFT 20
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_LENGTH_EDGE_MASK 0x00100000
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_LENGTH_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, REG_ERR_SMALL_LENGTH_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_HEIGHT_EDGE_SHIFT 21
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_HEIGHT_EDGE_MASK 0x00200000
+#define DSI_VID_MODE_STS_CTL_REG_ERR_SMALL_HEIGHT_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, REG_ERR_SMALL_HEIGHT_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_BURSTWRITE_EDGE_SHIFT 22
+#define DSI_VID_MODE_STS_CTL_ERR_BURSTWRITE_EDGE_MASK 0x00400000
+#define DSI_VID_MODE_STS_CTL_ERR_BURSTWRITE_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_BURSTWRITE_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_LONGWRITE_EDGE_SHIFT 23
+#define DSI_VID_MODE_STS_CTL_ERR_LONGWRITE_EDGE_MASK 0x00800000
+#define DSI_VID_MODE_STS_CTL_ERR_LONGWRITE_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_LONGWRITE_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_LONGREAD_EDGE_SHIFT 24
+#define DSI_VID_MODE_STS_CTL_ERR_LONGREAD_EDGE_MASK 0x01000000
+#define DSI_VID_MODE_STS_CTL_ERR_LONGREAD_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_LONGREAD_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_ERR_VRS_WRONG_LENGTH_EDGE_SHIFT 25
+#define DSI_VID_MODE_STS_CTL_ERR_VRS_WRONG_LENGTH_EDGE_MASK 0x02000000
+#define DSI_VID_MODE_STS_CTL_ERR_VRS_WRONG_LENGTH_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, ERR_VRS_WRONG_LENGTH_EDGE, __x)
+#define DSI_VID_MODE_STS_CTL_VSG_RECOVERY_EDGE_SHIFT 26
+#define DSI_VID_MODE_STS_CTL_VSG_RECOVERY_EDGE_MASK 0x04000000
+#define DSI_VID_MODE_STS_CTL_VSG_RECOVERY_EDGE(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CTL, VSG_RECOVERY_EDGE, __x)
+#define DSI_TG_STS_CTL 0x00000104
+#define DSI_TG_STS_CTL_TVG_STS_EN_SHIFT 0
+#define DSI_TG_STS_CTL_TVG_STS_EN_MASK 0x00000001
+#define DSI_TG_STS_CTL_TVG_STS_EN(__x) \
+	DSI_VAL2REG(DSI_TG_STS_CTL, TVG_STS_EN, __x)
+#define DSI_TG_STS_CTL_TBG_STS_EN_SHIFT 1
+#define DSI_TG_STS_CTL_TBG_STS_EN_MASK 0x00000002
+#define DSI_TG_STS_CTL_TBG_STS_EN(__x) \
+	DSI_VAL2REG(DSI_TG_STS_CTL, TBG_STS_EN, __x)
+#define DSI_TG_STS_CTL_TVG_STS_EDGE_SHIFT 16
+#define DSI_TG_STS_CTL_TVG_STS_EDGE_MASK 0x00010000
+#define DSI_TG_STS_CTL_TVG_STS_EDGE(__x) \
+	DSI_VAL2REG(DSI_TG_STS_CTL, TVG_STS_EDGE, __x)
+#define DSI_TG_STS_CTL_TBG_STS_EDGE_SHIFT 17
+#define DSI_TG_STS_CTL_TBG_STS_EDGE_MASK 0x00020000
+#define DSI_TG_STS_CTL_TBG_STS_EDGE(__x) \
+	DSI_VAL2REG(DSI_TG_STS_CTL, TBG_STS_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL 0x00000108
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_1_EN_SHIFT 6
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_1_EN_MASK 0x00000040
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_ESC_1_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_2_EN_SHIFT 7
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_2_EN_MASK 0x00000080
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_ESC_2_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_1_EN_SHIFT 8
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_1_EN_MASK 0x00000100
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_SYNCESC_1_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_2_EN_SHIFT 9
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_2_EN_MASK 0x00000200
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_SYNCESC_2_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_1_EN_SHIFT 10
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_1_EN_MASK 0x00000400
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONTROL_1_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_2_EN_SHIFT 11
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_2_EN_MASK 0x00000800
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONTROL_2_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_1_EN_SHIFT 12
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_1_EN_MASK 0x00001000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP0_1_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_2_EN_SHIFT 13
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_2_EN_MASK 0x00002000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP0_2_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_1_EN_SHIFT 14
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_1_EN_MASK 0x00004000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_1_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP1_1_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_2_EN_SHIFT 15
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_2_EN_MASK 0x00008000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_2_EN(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP1_2_EN, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_1_EDGE_SHIFT 22
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_1_EDGE_MASK 0x00400000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_1_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_ESC_1_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_2_EDGE_SHIFT 23
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_2_EDGE_MASK 0x00800000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_ESC_2_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_ESC_2_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_1_EDGE_SHIFT 24
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_1_EDGE_MASK 0x01000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_1_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_SYNCESC_1_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_2_EDGE_SHIFT 25
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_2_EDGE_MASK 0x02000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_SYNCESC_2_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_SYNCESC_2_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_1_EDGE_SHIFT 26
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_1_EDGE_MASK 0x04000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_1_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONTROL_1_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_2_EDGE_SHIFT 27
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_2_EDGE_MASK 0x08000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONTROL_2_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONTROL_2_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_1_EDGE_SHIFT 28
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_1_EDGE_MASK 0x10000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_1_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP0_1_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_2_EDGE_SHIFT 29
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_2_EDGE_MASK 0x20000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP0_2_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP0_2_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_1_EDGE_SHIFT 30
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_1_EDGE_MASK 0x40000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_1_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP1_1_EDGE, __x)
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_2_EDGE_SHIFT 31
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_2_EDGE_MASK 0x80000000
+#define DSI_MCTL_DHPY_ERR_CTL_ERR_CONT_LP1_2_EDGE(__x) \
+	DSI_VAL2REG(DSI_MCTL_DHPY_ERR_CTL, ERR_CONT_LP1_2_EDGE, __x)
+#define DSI_MCTL_MAIN_STS_CLR 0x00000110
+#define DSI_MCTL_MAIN_STS_CLR_PLL_LOCK_CLR_SHIFT 0
+#define DSI_MCTL_MAIN_STS_CLR_PLL_LOCK_CLR_MASK 0x00000001
+#define DSI_MCTL_MAIN_STS_CLR_PLL_LOCK_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, PLL_LOCK_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_CLKLANE_READY_CLR_SHIFT 1
+#define DSI_MCTL_MAIN_STS_CLR_CLKLANE_READY_CLR_MASK 0x00000002
+#define DSI_MCTL_MAIN_STS_CLR_CLKLANE_READY_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, CLKLANE_READY_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_DAT1_READY_CLR_SHIFT 2
+#define DSI_MCTL_MAIN_STS_CLR_DAT1_READY_CLR_MASK 0x00000004
+#define DSI_MCTL_MAIN_STS_CLR_DAT1_READY_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, DAT1_READY_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_DAT2_READY_CLR_SHIFT 3
+#define DSI_MCTL_MAIN_STS_CLR_DAT2_READY_CLR_MASK 0x00000008
+#define DSI_MCTL_MAIN_STS_CLR_DAT2_READY_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, DAT2_READY_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_HSTX_TO_ERR_CLR_SHIFT 4
+#define DSI_MCTL_MAIN_STS_CLR_HSTX_TO_ERR_CLR_MASK 0x00000010
+#define DSI_MCTL_MAIN_STS_CLR_HSTX_TO_ERR_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, HSTX_TO_ERR_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_LPRX_TO_ERR_CLR_SHIFT 5
+#define DSI_MCTL_MAIN_STS_CLR_LPRX_TO_ERR_CLR_MASK 0x00000020
+#define DSI_MCTL_MAIN_STS_CLR_LPRX_TO_ERR_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, LPRX_TO_ERR_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_CRS_UNTERM_PCK_CLR_SHIFT 6
+#define DSI_MCTL_MAIN_STS_CLR_CRS_UNTERM_PCK_CLR_MASK 0x00000040
+#define DSI_MCTL_MAIN_STS_CLR_CRS_UNTERM_PCK_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, CRS_UNTERM_PCK_CLR, __x)
+#define DSI_MCTL_MAIN_STS_CLR_VRS_UNTERM_PCK_CLR_SHIFT 7
+#define DSI_MCTL_MAIN_STS_CLR_VRS_UNTERM_PCK_CLR_MASK 0x00000080
+#define DSI_MCTL_MAIN_STS_CLR_VRS_UNTERM_PCK_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_CLR, VRS_UNTERM_PCK_CLR, __x)
+#define DSI_CMD_MODE_STS_CLR 0x00000114
+#define DSI_CMD_MODE_STS_CLR_ERR_NO_TE_CLR_SHIFT 0
+#define DSI_CMD_MODE_STS_CLR_ERR_NO_TE_CLR_MASK 0x00000001
+#define DSI_CMD_MODE_STS_CLR_ERR_NO_TE_CLR(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CLR, ERR_NO_TE_CLR, __x)
+#define DSI_CMD_MODE_STS_CLR_ERR_TE_MISS_CLR_SHIFT 1
+#define DSI_CMD_MODE_STS_CLR_ERR_TE_MISS_CLR_MASK 0x00000002
+#define DSI_CMD_MODE_STS_CLR_ERR_TE_MISS_CLR(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CLR, ERR_TE_MISS_CLR, __x)
+#define DSI_CMD_MODE_STS_CLR_ERR_SDI1_UNDERRUN_CLR_SHIFT 2
+#define DSI_CMD_MODE_STS_CLR_ERR_SDI1_UNDERRUN_CLR_MASK 0x00000004
+#define DSI_CMD_MODE_STS_CLR_ERR_SDI1_UNDERRUN_CLR(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CLR, ERR_SDI1_UNDERRUN_CLR, __x)
+#define DSI_CMD_MODE_STS_CLR_ERR_SDI2_UNDERRUN_CLR_SHIFT 3
+#define DSI_CMD_MODE_STS_CLR_ERR_SDI2_UNDERRUN_CLR_MASK 0x00000008
+#define DSI_CMD_MODE_STS_CLR_ERR_SDI2_UNDERRUN_CLR(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CLR, ERR_SDI2_UNDERRUN_CLR, __x)
+#define DSI_CMD_MODE_STS_CLR_ERR_UNWANTED_RD_CLR_SHIFT 4
+#define DSI_CMD_MODE_STS_CLR_ERR_UNWANTED_RD_CLR_MASK 0x00000010
+#define DSI_CMD_MODE_STS_CLR_ERR_UNWANTED_RD_CLR(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CLR, ERR_UNWANTED_RD_CLR, __x)
+#define DSI_CMD_MODE_STS_CLR_CSM_RUNNING_CLR_SHIFT 5
+#define DSI_CMD_MODE_STS_CLR_CSM_RUNNING_CLR_MASK 0x00000020
+#define DSI_CMD_MODE_STS_CLR_CSM_RUNNING_CLR(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_CLR, CSM_RUNNING_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR 0x00000118
+#define DSI_DIRECT_CMD_STS_CLR_CMD_TRANSMISSION_CLR_SHIFT 0
+#define DSI_DIRECT_CMD_STS_CLR_CMD_TRANSMISSION_CLR_MASK 0x00000001
+#define DSI_DIRECT_CMD_STS_CLR_CMD_TRANSMISSION_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, CMD_TRANSMISSION_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_WRITE_COMPLETED_CLR_SHIFT 1
+#define DSI_DIRECT_CMD_STS_CLR_WRITE_COMPLETED_CLR_MASK 0x00000002
+#define DSI_DIRECT_CMD_STS_CLR_WRITE_COMPLETED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, WRITE_COMPLETED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_TRIGGER_COMPLETED_CLR_SHIFT 2
+#define DSI_DIRECT_CMD_STS_CLR_TRIGGER_COMPLETED_CLR_MASK 0x00000004
+#define DSI_DIRECT_CMD_STS_CLR_TRIGGER_COMPLETED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, TRIGGER_COMPLETED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_READ_COMPLETED_CLR_SHIFT 3
+#define DSI_DIRECT_CMD_STS_CLR_READ_COMPLETED_CLR_MASK 0x00000008
+#define DSI_DIRECT_CMD_STS_CLR_READ_COMPLETED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, READ_COMPLETED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_ACKNOWLEDGE_RECEIVED_CLR_SHIFT 4
+#define DSI_DIRECT_CMD_STS_CLR_ACKNOWLEDGE_RECEIVED_CLR_MASK 0x00000010
+#define DSI_DIRECT_CMD_STS_CLR_ACKNOWLEDGE_RECEIVED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, ACKNOWLEDGE_RECEIVED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_ACKNOWLEDGE_WITH_ERR_RECEIVED_CLR_SHIFT 5
+#define DSI_DIRECT_CMD_STS_CLR_ACKNOWLEDGE_WITH_ERR_RECEIVED_CLR_MASK 0x00000020
+#define DSI_DIRECT_CMD_STS_CLR_ACKNOWLEDGE_WITH_ERR_RECEIVED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, ACKNOWLEDGE_WITH_ERR_RECEIVED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_TRIGGER_RECEIVED_CLR_SHIFT 6
+#define DSI_DIRECT_CMD_STS_CLR_TRIGGER_RECEIVED_CLR_MASK 0x00000040
+#define DSI_DIRECT_CMD_STS_CLR_TRIGGER_RECEIVED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, TRIGGER_RECEIVED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_TE_RECEIVED_CLR_SHIFT 7
+#define DSI_DIRECT_CMD_STS_CLR_TE_RECEIVED_CLR_MASK 0x00000080
+#define DSI_DIRECT_CMD_STS_CLR_TE_RECEIVED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, TE_RECEIVED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_BTA_COMPLETED_CLR_SHIFT 8
+#define DSI_DIRECT_CMD_STS_CLR_BTA_COMPLETED_CLR_MASK 0x00000100
+#define DSI_DIRECT_CMD_STS_CLR_BTA_COMPLETED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, BTA_COMPLETED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_BTA_FINISHED_CLR_SHIFT 9
+#define DSI_DIRECT_CMD_STS_CLR_BTA_FINISHED_CLR_MASK 0x00000200
+#define DSI_DIRECT_CMD_STS_CLR_BTA_FINISHED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, BTA_FINISHED_CLR, __x)
+#define DSI_DIRECT_CMD_STS_CLR_READ_COMPLETED_WITH_ERR_CLR_SHIFT 10
+#define DSI_DIRECT_CMD_STS_CLR_READ_COMPLETED_WITH_ERR_CLR_MASK 0x00000400
+#define DSI_DIRECT_CMD_STS_CLR_READ_COMPLETED_WITH_ERR_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_CLR, READ_COMPLETED_WITH_ERR_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR 0x0000011C
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_FIXED_CLR_SHIFT 0
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_FIXED_CLR_MASK 0x00000001
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_FIXED_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_FIXED_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_UNCORRECTABLE_CLR_SHIFT 1
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_UNCORRECTABLE_CLR_MASK 0x00000002
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_UNCORRECTABLE_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_UNCORRECTABLE_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_CHECKSUM_CLR_SHIFT 2
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_CHECKSUM_CLR_MASK 0x00000004
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_CHECKSUM_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_CHECKSUM_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_UNDECODABLE_CLR_SHIFT 3
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_UNDECODABLE_CLR_MASK 0x00000008
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_UNDECODABLE_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_UNDECODABLE_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_RECEIVE_CLR_SHIFT 4
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_RECEIVE_CLR_MASK 0x00000010
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_RECEIVE_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_RECEIVE_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_OVERSIZE_CLR_SHIFT 5
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_OVERSIZE_CLR_MASK 0x00000020
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_OVERSIZE_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_OVERSIZE_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_WRONG_LENGTH_CLR_SHIFT 6
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_WRONG_LENGTH_CLR_MASK 0x00000040
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_WRONG_LENGTH_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_WRONG_LENGTH_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_MISSING_EOT_CLR_SHIFT 7
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_MISSING_EOT_CLR_MASK 0x00000080
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_MISSING_EOT_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_MISSING_EOT_CLR, __x)
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_EOT_WITH_ERR_CLR_SHIFT 8
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_EOT_WITH_ERR_CLR_MASK 0x00000100
+#define DSI_DIRECT_CMD_RD_STS_CLR_ERR_EOT_WITH_ERR_CLR(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_CLR, ERR_EOT_WITH_ERR_CLR, __x)
+#define DSI_VID_MODE_STS_CLR 0x00000120
+#define DSI_VID_MODE_STS_CLR_VSG_STS_CLR_SHIFT 0
+#define DSI_VID_MODE_STS_CLR_VSG_STS_CLR_MASK 0x00000001
+#define DSI_VID_MODE_STS_CLR_VSG_STS_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, VSG_STS_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_DATA_CLR_SHIFT 1
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_DATA_CLR_MASK 0x00000002
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_DATA_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_MISSING_DATA_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_HSYNC_CLR_SHIFT 2
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_HSYNC_CLR_MASK 0x00000004
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_HSYNC_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_MISSING_HSYNC_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_VSYNC_CLR_SHIFT 3
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_VSYNC_CLR_MASK 0x00000008
+#define DSI_VID_MODE_STS_CLR_ERR_MISSING_VSYNC_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_MISSING_VSYNC_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_REG_ERR_SMALL_LENGTH_CLR_SHIFT 4
+#define DSI_VID_MODE_STS_CLR_REG_ERR_SMALL_LENGTH_CLR_MASK 0x00000010
+#define DSI_VID_MODE_STS_CLR_REG_ERR_SMALL_LENGTH_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, REG_ERR_SMALL_LENGTH_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_REG_ERR_SMALL_HEIGHT_CLR_SHIFT 5
+#define DSI_VID_MODE_STS_CLR_REG_ERR_SMALL_HEIGHT_CLR_MASK 0x00000020
+#define DSI_VID_MODE_STS_CLR_REG_ERR_SMALL_HEIGHT_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, REG_ERR_SMALL_HEIGHT_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_BURSTWRITE_CLR_SHIFT 6
+#define DSI_VID_MODE_STS_CLR_ERR_BURSTWRITE_CLR_MASK 0x00000040
+#define DSI_VID_MODE_STS_CLR_ERR_BURSTWRITE_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_BURSTWRITE_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_LONGWRITE_CLR_SHIFT 7
+#define DSI_VID_MODE_STS_CLR_ERR_LONGWRITE_CLR_MASK 0x00000080
+#define DSI_VID_MODE_STS_CLR_ERR_LONGWRITE_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_LONGWRITE_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_LONGREAD_CLR_SHIFT 8
+#define DSI_VID_MODE_STS_CLR_ERR_LONGREAD_CLR_MASK 0x00000100
+#define DSI_VID_MODE_STS_CLR_ERR_LONGREAD_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_LONGREAD_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_ERR_VRS_WRONG_LENGTH_CLR_SHIFT 9
+#define DSI_VID_MODE_STS_CLR_ERR_VRS_WRONG_LENGTH_CLR_MASK 0x00000200
+#define DSI_VID_MODE_STS_CLR_ERR_VRS_WRONG_LENGTH_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, ERR_VRS_WRONG_LENGTH_CLR, __x)
+#define DSI_VID_MODE_STS_CLR_VSG_RECOVERY_CLR_SHIFT 10
+#define DSI_VID_MODE_STS_CLR_VSG_RECOVERY_CLR_MASK 0x00000400
+#define DSI_VID_MODE_STS_CLR_VSG_RECOVERY_CLR(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_CLR, VSG_RECOVERY_CLR, __x)
+#define DSI_TG_STS_CLR 0x00000124
+#define DSI_TG_STS_CLR_TVG_STS_CLR_SHIFT 0
+#define DSI_TG_STS_CLR_TVG_STS_CLR_MASK 0x00000001
+#define DSI_TG_STS_CLR_TVG_STS_CLR(__x) \
+	DSI_VAL2REG(DSI_TG_STS_CLR, TVG_STS_CLR, __x)
+#define DSI_TG_STS_CLR_TBG_STS_CLR_SHIFT 1
+#define DSI_TG_STS_CLR_TBG_STS_CLR_MASK 0x00000002
+#define DSI_TG_STS_CLR_TBG_STS_CLR(__x) \
+	DSI_VAL2REG(DSI_TG_STS_CLR, TBG_STS_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR 0x00000128
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_ESC_1_CLR_SHIFT 6
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_ESC_1_CLR_MASK 0x00000040
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_ESC_1_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_ESC_1_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_ESC_2_CLR_SHIFT 7
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_ESC_2_CLR_MASK 0x00000080
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_ESC_2_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_ESC_2_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_SYNCESC_1_CLR_SHIFT 8
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_SYNCESC_1_CLR_MASK 0x00000100
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_SYNCESC_1_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_SYNCESC_1_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_SYNCESC_2_CLR_SHIFT 9
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_SYNCESC_2_CLR_MASK 0x00000200
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_SYNCESC_2_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_SYNCESC_2_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONTROL_1_CLR_SHIFT 10
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONTROL_1_CLR_MASK 0x00000400
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONTROL_1_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_CONTROL_1_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONTROL_2_CLR_SHIFT 11
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONTROL_2_CLR_MASK 0x00000800
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONTROL_2_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_CONTROL_2_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP0_1_CLR_SHIFT 12
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP0_1_CLR_MASK 0x00001000
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP0_1_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_CONT_LP0_1_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP0_2_CLR_SHIFT 13
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP0_2_CLR_MASK 0x00002000
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP0_2_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_CONT_LP0_2_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP1_1_CLR_SHIFT 14
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP1_1_CLR_MASK 0x00004000
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP1_1_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_CONT_LP1_1_CLR, __x)
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP1_2_CLR_SHIFT 15
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP1_2_CLR_MASK 0x00008000
+#define DSI_MCTL_DPHY_ERR_CLR_ERR_CONT_LP1_2_CLR(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_CLR, ERR_CONT_LP1_2_CLR, __x)
+#define DSI_MCTL_MAIN_STS_FLAG 0x00000130
+#define DSI_MCTL_MAIN_STS_FLAG_PLL_LOCK_FLAG_SHIFT 0
+#define DSI_MCTL_MAIN_STS_FLAG_PLL_LOCK_FLAG_MASK 0x00000001
+#define DSI_MCTL_MAIN_STS_FLAG_PLL_LOCK_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, PLL_LOCK_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_CLKLANE_READY_FLAG_SHIFT 1
+#define DSI_MCTL_MAIN_STS_FLAG_CLKLANE_READY_FLAG_MASK 0x00000002
+#define DSI_MCTL_MAIN_STS_FLAG_CLKLANE_READY_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, CLKLANE_READY_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_DAT1_READY_FLAG_SHIFT 2
+#define DSI_MCTL_MAIN_STS_FLAG_DAT1_READY_FLAG_MASK 0x00000004
+#define DSI_MCTL_MAIN_STS_FLAG_DAT1_READY_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, DAT1_READY_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_DAT2_READY_FLAG_SHIFT 3
+#define DSI_MCTL_MAIN_STS_FLAG_DAT2_READY_FLAG_MASK 0x00000008
+#define DSI_MCTL_MAIN_STS_FLAG_DAT2_READY_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, DAT2_READY_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_HSTX_TO_ERR_FLAG_SHIFT 4
+#define DSI_MCTL_MAIN_STS_FLAG_HSTX_TO_ERR_FLAG_MASK 0x00000010
+#define DSI_MCTL_MAIN_STS_FLAG_HSTX_TO_ERR_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, HSTX_TO_ERR_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_LPRX_TO_ERR_FLAG_SHIFT 5
+#define DSI_MCTL_MAIN_STS_FLAG_LPRX_TO_ERR_FLAG_MASK 0x00000020
+#define DSI_MCTL_MAIN_STS_FLAG_LPRX_TO_ERR_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, LPRX_TO_ERR_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_CRS_UNTERM_PCK_FLAG_SHIFT 6
+#define DSI_MCTL_MAIN_STS_FLAG_CRS_UNTERM_PCK_FLAG_MASK 0x00000040
+#define DSI_MCTL_MAIN_STS_FLAG_CRS_UNTERM_PCK_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, CRS_UNTERM_PCK_FLAG, __x)
+#define DSI_MCTL_MAIN_STS_FLAG_VRS_UNTERM_PCK_FLAG_SHIFT 7
+#define DSI_MCTL_MAIN_STS_FLAG_VRS_UNTERM_PCK_FLAG_MASK 0x00000080
+#define DSI_MCTL_MAIN_STS_FLAG_VRS_UNTERM_PCK_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_MAIN_STS_FLAG, VRS_UNTERM_PCK_FLAG, __x)
+#define DSI_CMD_MODE_STS_FLAG 0x00000134
+#define DSI_CMD_MODE_STS_FLAG_ERR_NO_TE_FLAG_SHIFT 0
+#define DSI_CMD_MODE_STS_FLAG_ERR_NO_TE_FLAG_MASK 0x00000001
+#define DSI_CMD_MODE_STS_FLAG_ERR_NO_TE_FLAG(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_FLAG, ERR_NO_TE_FLAG, __x)
+#define DSI_CMD_MODE_STS_FLAG_ERR_TE_MISS_FLAG_SHIFT 1
+#define DSI_CMD_MODE_STS_FLAG_ERR_TE_MISS_FLAG_MASK 0x00000002
+#define DSI_CMD_MODE_STS_FLAG_ERR_TE_MISS_FLAG(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_FLAG, ERR_TE_MISS_FLAG, __x)
+#define DSI_CMD_MODE_STS_FLAG_ERR_SDI1_UNDERRUN_FLAG_SHIFT 2
+#define DSI_CMD_MODE_STS_FLAG_ERR_SDI1_UNDERRUN_FLAG_MASK 0x00000004
+#define DSI_CMD_MODE_STS_FLAG_ERR_SDI1_UNDERRUN_FLAG(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_FLAG, ERR_SDI1_UNDERRUN_FLAG, __x)
+#define DSI_CMD_MODE_STS_FLAG_ERR_SDI2_UNDERRUN_FLAG_SHIFT 3
+#define DSI_CMD_MODE_STS_FLAG_ERR_SDI2_UNDERRUN_FLAG_MASK 0x00000008
+#define DSI_CMD_MODE_STS_FLAG_ERR_SDI2_UNDERRUN_FLAG(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_FLAG, ERR_SDI2_UNDERRUN_FLAG, __x)
+#define DSI_CMD_MODE_STS_FLAG_ERR_UNWANTED_RD_FLAG_SHIFT 4
+#define DSI_CMD_MODE_STS_FLAG_ERR_UNWANTED_RD_FLAG_MASK 0x00000010
+#define DSI_CMD_MODE_STS_FLAG_ERR_UNWANTED_RD_FLAG(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_FLAG, ERR_UNWANTED_RD_FLAG, __x)
+#define DSI_CMD_MODE_STS_FLAG_CSM_RUNNING_FLAG_SHIFT 5
+#define DSI_CMD_MODE_STS_FLAG_CSM_RUNNING_FLAG_MASK 0x00000020
+#define DSI_CMD_MODE_STS_FLAG_CSM_RUNNING_FLAG(__x) \
+	DSI_VAL2REG(DSI_CMD_MODE_STS_FLAG, CSM_RUNNING_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG 0x00000138
+#define DSI_DIRECT_CMD_STS_FLAG_CMD_TRANSMISSION_FLAG_SHIFT 0
+#define DSI_DIRECT_CMD_STS_FLAG_CMD_TRANSMISSION_FLAG_MASK 0x00000001
+#define DSI_DIRECT_CMD_STS_FLAG_CMD_TRANSMISSION_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, CMD_TRANSMISSION_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_WRITE_COMPLETED_FLAG_SHIFT 1
+#define DSI_DIRECT_CMD_STS_FLAG_WRITE_COMPLETED_FLAG_MASK 0x00000002
+#define DSI_DIRECT_CMD_STS_FLAG_WRITE_COMPLETED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, WRITE_COMPLETED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_TRIGGER_COMPLETED_FLAG_SHIFT 2
+#define DSI_DIRECT_CMD_STS_FLAG_TRIGGER_COMPLETED_FLAG_MASK 0x00000004
+#define DSI_DIRECT_CMD_STS_FLAG_TRIGGER_COMPLETED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, TRIGGER_COMPLETED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_READ_COMPLETED_FLAG_SHIFT 3
+#define DSI_DIRECT_CMD_STS_FLAG_READ_COMPLETED_FLAG_MASK 0x00000008
+#define DSI_DIRECT_CMD_STS_FLAG_READ_COMPLETED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, READ_COMPLETED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_ACKNOWLEDGE_RECEIVED_FLAG_SHIFT 4
+#define DSI_DIRECT_CMD_STS_FLAG_ACKNOWLEDGE_RECEIVED_FLAG_MASK 0x00000010
+#define DSI_DIRECT_CMD_STS_FLAG_ACKNOWLEDGE_RECEIVED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, ACKNOWLEDGE_RECEIVED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_ACKNOWLEDGE_WITH_ERR_RECEIVED_FLAG_SHIFT 5
+#define DSI_DIRECT_CMD_STS_FLAG_ACKNOWLEDGE_WITH_ERR_RECEIVED_FLAG_MASK 0x00000020
+#define DSI_DIRECT_CMD_STS_FLAG_ACKNOWLEDGE_WITH_ERR_RECEIVED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, ACKNOWLEDGE_WITH_ERR_RECEIVED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_TRIGGER_RECEIVED_FLAG_SHIFT 6
+#define DSI_DIRECT_CMD_STS_FLAG_TRIGGER_RECEIVED_FLAG_MASK 0x00000040
+#define DSI_DIRECT_CMD_STS_FLAG_TRIGGER_RECEIVED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, TRIGGER_RECEIVED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_TE_RECEIVED_FLAG_SHIFT 7
+#define DSI_DIRECT_CMD_STS_FLAG_TE_RECEIVED_FLAG_MASK 0x00000080
+#define DSI_DIRECT_CMD_STS_FLAG_TE_RECEIVED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, TE_RECEIVED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_BTA_COMPLETED_FLAG_SHIFT 8
+#define DSI_DIRECT_CMD_STS_FLAG_BTA_COMPLETED_FLAG_MASK 0x00000100
+#define DSI_DIRECT_CMD_STS_FLAG_BTA_COMPLETED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, BTA_COMPLETED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_BTA_FINISHED_FLAG_SHIFT 9
+#define DSI_DIRECT_CMD_STS_FLAG_BTA_FINISHED_FLAG_MASK 0x00000200
+#define DSI_DIRECT_CMD_STS_FLAG_BTA_FINISHED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, BTA_FINISHED_FLAG, __x)
+#define DSI_DIRECT_CMD_STS_FLAG_READ_COMPLETED_WITH_ERR_FLAG_SHIFT 10
+#define DSI_DIRECT_CMD_STS_FLAG_READ_COMPLETED_WITH_ERR_FLAG_MASK 0x00000400
+#define DSI_DIRECT_CMD_STS_FLAG_READ_COMPLETED_WITH_ERR_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_STS_FLAG, READ_COMPLETED_WITH_ERR_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG 0x0000013C
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_FIXED_FLAG_SHIFT 0
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_FIXED_FLAG_MASK 0x00000001
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_FIXED_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_FIXED_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_UNCORRECTABLE_FLAG_SHIFT 1
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_UNCORRECTABLE_FLAG_MASK 0x00000002
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_UNCORRECTABLE_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_UNCORRECTABLE_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_CHECKSUM_FLAG_SHIFT 2
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_CHECKSUM_FLAG_MASK 0x00000004
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_CHECKSUM_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_CHECKSUM_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_UNDECODABLE_FLAG_SHIFT 3
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_UNDECODABLE_FLAG_MASK 0x00000008
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_UNDECODABLE_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_UNDECODABLE_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_RECEIVE_FLAG_SHIFT 4
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_RECEIVE_FLAG_MASK 0x00000010
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_RECEIVE_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_RECEIVE_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_OVERSIZE_FLAG_SHIFT 5
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_OVERSIZE_FLAG_MASK 0x00000020
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_OVERSIZE_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_OVERSIZE_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_WRONG_LENGTH_FLAG_SHIFT 6
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_WRONG_LENGTH_FLAG_MASK 0x00000040
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_WRONG_LENGTH_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_WRONG_LENGTH_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_MISSING_EOT_FLAG_SHIFT 7
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_MISSING_EOT_FLAG_MASK 0x00000080
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_MISSING_EOT_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_MISSING_EOT_FLAG, __x)
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_EOT_WITH_ERR_FLAG_SHIFT 8
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_EOT_WITH_ERR_FLAG_MASK 0x00000100
+#define DSI_DIRECT_CMD_RD_STS_FLAG_ERR_EOT_WITH_ERR_FLAG(__x) \
+	DSI_VAL2REG(DSI_DIRECT_CMD_RD_STS_FLAG, ERR_EOT_WITH_ERR_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG 0x00000140
+#define DSI_VID_MODE_STS_FLAG_VSG_STS_FLAG_SHIFT 0
+#define DSI_VID_MODE_STS_FLAG_VSG_STS_FLAG_MASK 0x00000001
+#define DSI_VID_MODE_STS_FLAG_VSG_STS_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, VSG_STS_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_DATA_FLAG_SHIFT 1
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_DATA_FLAG_MASK 0x00000002
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_DATA_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_MISSING_DATA_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_HSYNC_FLAG_SHIFT 2
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_HSYNC_FLAG_MASK 0x00000004
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_HSYNC_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_MISSING_HSYNC_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_VSYNC_FLAG_SHIFT 3
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_VSYNC_FLAG_MASK 0x00000008
+#define DSI_VID_MODE_STS_FLAG_ERR_MISSING_VSYNC_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_MISSING_VSYNC_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_REG_ERR_SMALL_LENGTH_FLAG_SHIFT 4
+#define DSI_VID_MODE_STS_FLAG_REG_ERR_SMALL_LENGTH_FLAG_MASK 0x00000010
+#define DSI_VID_MODE_STS_FLAG_REG_ERR_SMALL_LENGTH_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, REG_ERR_SMALL_LENGTH_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_REG_ERR_SMALL_HEIGHT_FLAG_SHIFT 5
+#define DSI_VID_MODE_STS_FLAG_REG_ERR_SMALL_HEIGHT_FLAG_MASK 0x00000020
+#define DSI_VID_MODE_STS_FLAG_REG_ERR_SMALL_HEIGHT_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, REG_ERR_SMALL_HEIGHT_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_BURSTWRITE_FLAG_SHIFT 6
+#define DSI_VID_MODE_STS_FLAG_ERR_BURSTWRITE_FLAG_MASK 0x00000040
+#define DSI_VID_MODE_STS_FLAG_ERR_BURSTWRITE_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_BURSTWRITE_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_LONGWRITE_FLAG_SHIFT 7
+#define DSI_VID_MODE_STS_FLAG_ERR_LONGWRITE_FLAG_MASK 0x00000080
+#define DSI_VID_MODE_STS_FLAG_ERR_LONGWRITE_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_LONGWRITE_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_LONGREAD_FLAG_SHIFT 8
+#define DSI_VID_MODE_STS_FLAG_ERR_LONGREAD_FLAG_MASK 0x00000100
+#define DSI_VID_MODE_STS_FLAG_ERR_LONGREAD_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_LONGREAD_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_ERR_VRS_WRONG_LENGTH_FLAG_SHIFT 9
+#define DSI_VID_MODE_STS_FLAG_ERR_VRS_WRONG_LENGTH_FLAG_MASK 0x00000200
+#define DSI_VID_MODE_STS_FLAG_ERR_VRS_WRONG_LENGTH_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, ERR_VRS_WRONG_LENGTH_FLAG, __x)
+#define DSI_VID_MODE_STS_FLAG_VSG_RECOVERY_FLAG_SHIFT 10
+#define DSI_VID_MODE_STS_FLAG_VSG_RECOVERY_FLAG_MASK 0x00000400
+#define DSI_VID_MODE_STS_FLAG_VSG_RECOVERY_FLAG(__x) \
+	DSI_VAL2REG(DSI_VID_MODE_STS_FLAG, VSG_RECOVERY_FLAG, __x)
+#define DSI_TG_STS_FLAG 0x00000144
+#define DSI_TG_STS_FLAG_TVG_STS_FLAG_SHIFT 0
+#define DSI_TG_STS_FLAG_TVG_STS_FLAG_MASK 0x00000001
+#define DSI_TG_STS_FLAG_TVG_STS_FLAG(__x) \
+	DSI_VAL2REG(DSI_TG_STS_FLAG, TVG_STS_FLAG, __x)
+#define DSI_TG_STS_FLAG_TBG_STS_FLAG_SHIFT 1
+#define DSI_TG_STS_FLAG_TBG_STS_FLAG_MASK 0x00000002
+#define DSI_TG_STS_FLAG_TBG_STS_FLAG(__x) \
+	DSI_VAL2REG(DSI_TG_STS_FLAG, TBG_STS_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG 0x00000148
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_ESC_1_FLAG_SHIFT 6
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_ESC_1_FLAG_MASK 0x00000040
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_ESC_1_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_ESC_1_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_ESC_2_FLAG_SHIFT 7
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_ESC_2_FLAG_MASK 0x00000080
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_ESC_2_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_ESC_2_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_SYNCESC_1_FLAG_SHIFT 8
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_SYNCESC_1_FLAG_MASK 0x00000100
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_SYNCESC_1_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_SYNCESC_1_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_SYNCESC_2_FLAG_SHIFT 9
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_SYNCESC_2_FLAG_MASK 0x00000200
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_SYNCESC_2_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_SYNCESC_2_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONTROL_1_FLAG_SHIFT 10
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONTROL_1_FLAG_MASK 0x00000400
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONTROL_1_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_CONTROL_1_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONTROL_2_FLAG_SHIFT 11
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONTROL_2_FLAG_MASK 0x00000800
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONTROL_2_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_CONTROL_2_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP0_1_FLAG_SHIFT 12
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP0_1_FLAG_MASK 0x00001000
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP0_1_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_CONT_LP0_1_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP0_2_FLAG_SHIFT 13
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP0_2_FLAG_MASK 0x00002000
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP0_2_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_CONT_LP0_2_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP1_1_FLAG_SHIFT 14
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP1_1_FLAG_MASK 0x00004000
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP1_1_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_CONT_LP1_1_FLAG, __x)
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP1_2_FLAG_SHIFT 15
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP1_2_FLAG_MASK 0x00008000
+#define DSI_MCTL_DPHY_ERR_FLAG_ERR_CONT_LP1_2_FLAG(__x) \
+	DSI_VAL2REG(DSI_MCTL_DPHY_ERR_FLAG, ERR_CONT_LP1_2_FLAG, __x)
+#define DSI_DPHY_LANES_TRIM 0x00000150
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_DAT1_SHIFT 0
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_DAT1_MASK 0x00000003
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_DAT1(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_SKEW_DAT1, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_CD_OFF_DAT1_SHIFT 2
+#define DSI_DPHY_LANES_TRIM_DPHY_CD_OFF_DAT1_MASK 0x00000004
+#define DSI_DPHY_LANES_TRIM_DPHY_CD_OFF_DAT1(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_CD_OFF_DAT1, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_DAT1_SHIFT 3
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_DAT1_MASK 0x00000008
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_DAT1(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_HSTX_SLEWRATE_UP_DAT1, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_DAT1_SHIFT 4
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_DAT1_MASK 0x00000010
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_DAT1(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_HSTX_SLEWRATE_DOWN_DAT1, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_DAT1_SHIFT 5
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_DAT1_MASK 0x00000020
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_DAT1(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_TEST_RESERVED_1_DAT1, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_CLK_SHIFT 6
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_CLK_MASK 0x000000C0
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_CLK(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_SKEW_CLK, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_LP_RX_VIL_CLK_SHIFT 8
+#define DSI_DPHY_LANES_TRIM_DPHY_LP_RX_VIL_CLK_MASK 0x00000300
+#define DSI_DPHY_LANES_TRIM_DPHY_LP_RX_VIL_CLK(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_LP_RX_VIL_CLK, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_LP_TX_SLEWRATE_CLK_SHIFT 10
+#define DSI_DPHY_LANES_TRIM_DPHY_LP_TX_SLEWRATE_CLK_MASK 0x00000C00
+#define DSI_DPHY_LANES_TRIM_DPHY_LP_TX_SLEWRATE_CLK(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_LP_TX_SLEWRATE_CLK, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_SHIFT 12
+#define DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_MASK 0x00001000
+#define DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_0_81 0
+#define DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_0_90 1
+#define DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_ENUM(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_SPECS_90_81B, \
+	DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_##__x)
+#define DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_SPECS_90_81B, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_CLK_SHIFT 13
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_CLK_MASK 0x00002000
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_CLK(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_HSTX_SLEWRATE_UP_CLK, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_CLK_SHIFT 14
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_CLK_MASK 0x00004000
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_CLK(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_HSTX_SLEWRATE_DOWN_CLK, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_CLK_SHIFT 15
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_CLK_MASK 0x00008000
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_CLK(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_TEST_RESERVED_1_CLK, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_DAT2_SHIFT 16
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_DAT2_MASK 0x00030000
+#define DSI_DPHY_LANES_TRIM_DPHY_SKEW_DAT2(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_SKEW_DAT2, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_DAT2_SHIFT 18
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_DAT2_MASK 0x00040000
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_UP_DAT2(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_HSTX_SLEWRATE_UP_DAT2, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_DAT2_SHIFT 19
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_DAT2_MASK 0x00080000
+#define DSI_DPHY_LANES_TRIM_DPHY_HSTX_SLEWRATE_DOWN_DAT2(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_HSTX_SLEWRATE_DOWN_DAT2, __x)
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_DAT2_SHIFT 20
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_DAT2_MASK 0x00100000
+#define DSI_DPHY_LANES_TRIM_DPHY_TEST_RESERVED_1_DAT2(__x) \
+	DSI_VAL2REG(DSI_DPHY_LANES_TRIM, DPHY_TEST_RESERVED_1_DAT2, __x)
+#define DSI_ID_REG 0x00000FF0
+#define DSI_ID_REG_Y_SHIFT 0
+#define DSI_ID_REG_Y_MASK 0x0000000F
+#define DSI_ID_REG_Y(__x) \
+	DSI_VAL2REG(DSI_ID_REG, Y, __x)
+#define DSI_ID_REG_X_SHIFT 4
+#define DSI_ID_REG_X_MASK 0x000000F0
+#define DSI_ID_REG_X(__x) \
+	DSI_VAL2REG(DSI_ID_REG, X, __x)
+#define DSI_ID_REG_H_SHIFT 8
+#define DSI_ID_REG_H_MASK 0x00000300
+#define DSI_ID_REG_H(__x) \
+	DSI_VAL2REG(DSI_ID_REG, H, __x)
+#define DSI_ID_REG_PRODUCT_ID_SHIFT 10
+#define DSI_ID_REG_PRODUCT_ID_MASK 0x0003FC00
+#define DSI_ID_REG_PRODUCT_ID(__x) \
+	DSI_VAL2REG(DSI_ID_REG, PRODUCT_ID, __x)
+#define DSI_ID_REG_VENDOR_ID_SHIFT 18
+#define DSI_ID_REG_VENDOR_ID_MASK 0xFFFC0000
+#define DSI_ID_REG_VENDOR_ID(__x) \
+	DSI_VAL2REG(DSI_ID_REG, VENDOR_ID, __x)
+#define DSI_IP_CONF 0x00000FF4
+#define DSI_IP_CONF_FIFO_SIZE_SHIFT 0
+#define DSI_IP_CONF_FIFO_SIZE_MASK 0x0000003F
+#define DSI_IP_CONF_FIFO_SIZE(__x) \
+	DSI_VAL2REG(DSI_IP_CONF, FIFO_SIZE, __x)
diff --git a/drivers/video/mcde/mcde_bus.c b/drivers/video/mcde/mcde_bus.c
new file mode 100644
index 0000000..bc1f048
--- /dev/null
+++ b/drivers/video/mcde/mcde_bus.c
@@ -0,0 +1,259 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE display bus driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/notifier.h>
+
+#include <video/mcde/mcde_display.h>
+#include <video/mcde/mcde_dss.h>
+
+#define to_mcde_display_driver(__drv) \
+	container_of((__drv), struct mcde_display_driver, driver)
+
+static BLOCKING_NOTIFIER_HEAD(bus_notifier_list);
+
+static int mcde_drv_suspend(struct device *_dev, pm_message_t state);
+static int mcde_drv_resume(struct device *_dev);
+struct bus_type mcde_bus_type;
+
+static int mcde_suspend_device(struct device *dev, void *data)
+{
+	pm_message_t* state = (pm_message_t *) data;
+	if (dev->driver->suspend)
+		return dev->driver->suspend(dev, *state);
+	return 0;
+}
+
+static int mcde_resume_device(struct device *dev, void *data)
+{
+	if (dev->driver->resume)
+		return dev->driver->resume(dev);
+	return 0;
+}
+
+/* Bus driver */
+
+static int mcde_bus_match(struct device *_dev, struct device_driver *driver)
+{
+	pr_debug("Matching device %s with driver %s\n",
+		dev_name(_dev), driver->name);
+
+	return strncmp(dev_name(_dev), driver->name, strlen(driver->name)) == 0;
+}
+
+static int mcde_bus_suspend(struct device *_dev, pm_message_t state)
+{
+	int ret;
+	ret = bus_for_each_dev(&mcde_bus_type, NULL, &state,
+				mcde_suspend_device);
+	if (ret) {
+		/* TODO Resume all suspended devices */
+		/* mcde_bus_resume(dev); */
+		return ret;
+	}
+	return 0;
+}
+
+static int mcde_bus_resume(struct device *_dev)
+{
+	return bus_for_each_dev(&mcde_bus_type, NULL, NULL, mcde_resume_device);
+}
+
+struct bus_type mcde_bus_type = {
+	.name = "mcde_bus",
+	.match = mcde_bus_match,
+	.suspend = mcde_bus_suspend,
+	.resume = mcde_bus_resume,
+};
+
+static int mcde_drv_probe(struct device *_dev)
+{
+	struct mcde_display_driver *drv = to_mcde_display_driver(_dev->driver);
+	struct mcde_display_device *dev = to_mcde_display_device(_dev);
+
+	return drv->probe(dev);
+}
+
+static int mcde_drv_remove(struct device *_dev)
+{
+	struct mcde_display_driver *drv = to_mcde_display_driver(_dev->driver);
+	struct mcde_display_device *dev = to_mcde_display_device(_dev);
+
+	return drv->remove(dev);
+}
+
+static void mcde_drv_shutdown(struct device *_dev)
+{
+	struct mcde_display_driver *drv = to_mcde_display_driver(_dev->driver);
+	struct mcde_display_device *dev = to_mcde_display_device(_dev);
+
+	drv->shutdown(dev);
+}
+
+static int mcde_drv_suspend(struct device *_dev, pm_message_t state)
+{
+	struct mcde_display_driver *drv = to_mcde_display_driver(_dev->driver);
+	struct mcde_display_device *dev = to_mcde_display_device(_dev);
+
+	return drv->suspend(dev, state);
+}
+
+static int mcde_drv_resume(struct device *_dev)
+{
+	struct mcde_display_driver *drv = to_mcde_display_driver(_dev->driver);
+	struct mcde_display_device *dev = to_mcde_display_device(_dev);
+
+	return drv->resume(dev);
+}
+
+/* Bus device */
+
+static void mcde_bus_release(struct device *dev)
+{
+}
+
+struct device mcde_bus = {
+	.init_name = "mcde_bus",
+	.release  = mcde_bus_release
+};
+
+/* Public bus API */
+
+int mcde_display_driver_register(struct mcde_display_driver *drv)
+{
+	drv->driver.bus = &mcde_bus_type;
+	if (drv->probe)
+		drv->driver.probe = mcde_drv_probe;
+	if (drv->remove)
+		drv->driver.remove = mcde_drv_remove;
+	if (drv->shutdown)
+		drv->driver.shutdown = mcde_drv_shutdown;
+	if (drv->suspend)
+		drv->driver.suspend = mcde_drv_suspend;
+	if (drv->resume)
+		drv->driver.resume = mcde_drv_resume;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL(mcde_display_driver_register);
+
+void mcde_display_driver_unregister(struct mcde_display_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL(mcde_display_driver_unregister);
+
+static void mcde_display_dev_release(struct device *dev)
+{
+	/* Do nothing */
+}
+
+int mcde_display_device_register(struct mcde_display_device *dev)
+{
+	/* Setup device */
+	if (!dev)
+		return -EINVAL;
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.bus = &mcde_bus_type;
+	if (dev->dev.parent != NULL)
+		dev->dev.parent = &mcde_bus;
+	dev->dev.release = mcde_display_dev_release;
+	if (dev->id != -1)
+		dev_set_name(&dev->dev, "%s.%d", dev->name,  dev->id);
+	else
+		dev_set_name(&dev->dev, dev->name);
+
+	mcde_display_init_device(dev);
+
+	return device_register(&dev->dev);
+}
+EXPORT_SYMBOL(mcde_display_device_register);
+
+void mcde_display_device_unregister(struct mcde_display_device *dev)
+{
+	device_unregister(&dev->dev);
+}
+EXPORT_SYMBOL(mcde_display_device_unregister);
+
+/* Notifications */
+int mcde_dss_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&bus_notifier_list, nb);
+}
+EXPORT_SYMBOL(mcde_dss_register_notifier);
+
+int mcde_dss_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&bus_notifier_list, nb);
+}
+EXPORT_SYMBOL(mcde_dss_unregister_notifier);
+
+static int bus_notify_callback(struct notifier_block *nb,
+	unsigned long event, void *dev)
+{
+	struct mcde_display_device *ddev = to_mcde_display_device(dev);
+
+	if (event == BUS_NOTIFY_BOUND_DRIVER) {
+		ddev->initialized = true;
+		blocking_notifier_call_chain(&bus_notifier_list,
+			MCDE_DSS_EVENT_DISPLAY_REGISTERED, ddev);
+	} else if (event == BUS_NOTIFY_UNBIND_DRIVER) {
+		ddev->initialized = false;
+		blocking_notifier_call_chain(&bus_notifier_list,
+			MCDE_DSS_EVENT_DISPLAY_UNREGISTERED, ddev);
+	}
+	return 0;
+}
+
+struct notifier_block bus_nb = {
+	.notifier_call = bus_notify_callback,
+};
+
+/* Driver init/exit */
+
+int __init mcde_display_init(void)
+{
+	int ret;
+
+	ret = bus_register(&mcde_bus_type);
+	if (ret) {
+		pr_warning("Unable to register bus type\n");
+		return ret;
+	}
+	ret = device_register(&mcde_bus);
+	if (ret) {
+		pr_warning("Unable to register bus device\n");
+		goto no_device_registration;
+	}
+	ret = bus_register_notifier(&mcde_bus_type, &bus_nb);
+	if (ret) {
+		pr_warning("Unable to register bus notifier\n");
+		goto no_bus_notifier;
+	}
+
+	return 0;
+
+no_bus_notifier:
+	device_unregister(&mcde_bus);
+no_device_registration:
+	bus_unregister(&mcde_bus_type);
+	return ret;
+}
+
+void mcde_display_exit(void)
+{
+	bus_unregister_notifier(&mcde_bus_type, &bus_nb);
+	device_unregister(&mcde_bus);
+	bus_unregister(&mcde_bus_type);
+}
diff --git a/drivers/video/mcde/mcde_display.c b/drivers/video/mcde/mcde_display.c
new file mode 100644
index 0000000..25f5ff3
--- /dev/null
+++ b/drivers/video/mcde/mcde_display.c
@@ -0,0 +1,427 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE display driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+#include <video/mcde/mcde_display.h>
+
+/*temp*/
+#include <linux/delay.h>
+
+static void mcde_display_get_native_resolution_default(
+	struct mcde_display_device *ddev, u16 *x_res, u16 *y_res)
+{
+	if (x_res)
+		*x_res = ddev->native_x_res;
+	if (y_res)
+		*y_res = ddev->native_y_res;
+}
+
+static enum mcde_ovly_pix_fmt mcde_display_get_default_pixel_format_default(
+	struct mcde_display_device *ddev)
+{
+	return ddev->default_pixel_format;
+}
+
+static void mcde_display_get_physical_size_default(
+	struct mcde_display_device *ddev, u16 *width, u16 *height)
+{
+	if (width)
+		*width = ddev->physical_width;
+	if (height)
+		*height = ddev->physical_height;
+}
+
+static int mcde_display_set_power_mode_default(struct mcde_display_device *ddev,
+	enum mcde_display_power_mode power_mode)
+{
+	int ret = 0;
+
+	/* OFF -> STANDBY */
+	if (ddev->power_mode == MCDE_DISPLAY_PM_OFF &&
+		power_mode != MCDE_DISPLAY_PM_OFF) {
+		if (ddev->platform_enable) {
+			ret = ddev->platform_enable(ddev);
+			if (ret)
+				return ret;
+		}
+		ddev->power_mode = MCDE_DISPLAY_PM_STANDBY;
+	}
+
+	if (ddev->port->type == MCDE_PORTTYPE_DSI) {
+		/* STANDBY -> ON */
+		if (ddev->power_mode == MCDE_DISPLAY_PM_STANDBY &&
+			power_mode == MCDE_DISPLAY_PM_ON) {
+			ret = mcde_dsi_dcs_write(ddev->chnl_state,
+				DCS_CMD_EXIT_SLEEP_MODE, NULL, 0);
+			if (ret)
+				return ret;
+
+			ret = mcde_dsi_dcs_write(ddev->chnl_state,
+				DCS_CMD_SET_DISPLAY_ON, NULL, 0);
+			if (ret)
+				return ret;
+
+			ddev->power_mode = MCDE_DISPLAY_PM_ON;
+			goto set_power_and_exit;
+		}
+		/* ON -> STANDBY */
+		else if (ddev->power_mode == MCDE_DISPLAY_PM_ON &&
+			power_mode <= MCDE_DISPLAY_PM_STANDBY) {
+			ret = mcde_dsi_dcs_write(ddev->chnl_state,
+				DCS_CMD_SET_DISPLAY_OFF, NULL, 0);
+			if (ret)
+				return ret;
+
+			ret = mcde_dsi_dcs_write(ddev->chnl_state,
+				DCS_CMD_ENTER_SLEEP_MODE, NULL, 0);
+			if (ret)
+				return ret;
+
+			ddev->power_mode = MCDE_DISPLAY_PM_STANDBY;
+			goto set_power_and_exit;
+		}
+	} else if (ddev->port->type == MCDE_PORTTYPE_DPI)
+		ddev->power_mode = power_mode;
+	else if (ddev->power_mode != power_mode)
+		return -EINVAL;
+
+	/* SLEEP -> OFF */
+	if (ddev->power_mode == MCDE_DISPLAY_PM_STANDBY &&
+		power_mode == MCDE_DISPLAY_PM_OFF) {
+		if (ddev->platform_disable) {
+			ret = ddev->platform_disable(ddev);
+			if (ret)
+				return ret;
+		}
+		ddev->power_mode = MCDE_DISPLAY_PM_OFF;
+	}
+
+set_power_and_exit:
+	mcde_chnl_set_power_mode(ddev->chnl_state, ddev->power_mode);
+
+	return ret;
+}
+
+static inline enum mcde_display_power_mode mcde_display_get_power_mode_default(
+	struct mcde_display_device *ddev)
+{
+	return ddev->power_mode;
+}
+
+static inline int mcde_display_try_video_mode_default(
+	struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode)
+{
+	/* TODO Check if inside native_xres and native_yres */
+	return 0;
+}
+
+static int mcde_display_set_video_mode_default(struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode)
+{
+	int ret;
+	struct mcde_video_mode channel_video_mode;
+
+	if (!video_mode)
+		return -EINVAL;
+
+	ddev->video_mode = *video_mode;
+	channel_video_mode = ddev->video_mode;
+	/* Dependant on if display should rotate or MCDE should rotate */
+	if (ddev->rotation == MCDE_DISPLAY_ROT_90_CCW ||
+				ddev->rotation == MCDE_DISPLAY_ROT_90_CW) {
+		channel_video_mode.xres = ddev->native_x_res;
+		channel_video_mode.yres = ddev->native_y_res;
+	}
+	ret = mcde_chnl_set_video_mode(ddev->chnl_state, &channel_video_mode);
+	if (ret < 0) {
+		dev_warn(&ddev->dev, "%s:Failed to set video mode\n", __func__);
+		return ret;
+	}
+
+	ddev->update_flags |= UPDATE_FLAG_VIDEO_MODE;
+
+	return 0;
+}
+
+static inline void mcde_display_get_video_mode_default(
+	struct mcde_display_device *ddev, struct mcde_video_mode *video_mode)
+{
+	if (video_mode)
+		*video_mode = ddev->video_mode;
+}
+
+static int mcde_display_set_pixel_format_default(
+	struct mcde_display_device *ddev, enum mcde_ovly_pix_fmt format)
+{
+	int ret;
+
+	ddev->pixel_format = format;
+	ret = mcde_chnl_set_pixel_format(ddev->chnl_state,
+						ddev->port->pixel_format);
+	if (ret < 0) {
+		dev_warn(&ddev->dev, "%s:Failed to set pixel format = %d\n",
+							__func__, format);
+		return ret;
+	}
+
+	ddev->update_flags |= UPDATE_FLAG_PIXEL_FORMAT;
+
+	return 0;
+}
+
+static inline enum mcde_ovly_pix_fmt mcde_display_get_pixel_format_default(
+	struct mcde_display_device *ddev)
+{
+	return ddev->pixel_format;
+}
+
+static inline enum mcde_port_pix_fmt mcde_display_get_port_pixel_format_default(
+	struct mcde_display_device *ddev)
+{
+	return ddev->port->pixel_format;
+}
+
+static int mcde_display_set_rotation_default(struct mcde_display_device *ddev,
+	enum mcde_display_rotation rotation)
+{
+	int ret;
+
+	ret = mcde_chnl_set_rotation(ddev->chnl_state, rotation,
+		ddev->rotbuf1, ddev->rotbuf2);
+	if (ret < 0) {
+		dev_warn(&ddev->dev, "%s:Failed to set rotation = %d\n",
+							__func__, rotation);
+		return ret;
+	}
+
+	ddev->rotation = rotation;
+	ddev->update_flags |= UPDATE_FLAG_ROTATION;
+
+	return 0;
+}
+
+static inline enum mcde_display_rotation mcde_display_get_rotation_default(
+	struct mcde_display_device *ddev)
+{
+	return ddev->rotation;
+}
+
+static int mcde_display_set_synchronized_update_default(
+	struct mcde_display_device *ddev, bool enable)
+{
+	if (ddev->port->type == MCDE_PORTTYPE_DSI && enable) {
+		int ret;
+		u8 m = 0;
+
+		if (ddev->port->sync_src == MCDE_SYNCSRC_OFF)
+			return -EINVAL;
+
+		ret = mcde_dsi_dcs_write(ddev->chnl_state,
+						DCS_CMD_SET_TEAR_ON, &m, 1);
+		if (ret < 0) {
+			dev_warn(&ddev->dev,
+				"%s:Failed to set synchornized update = %d\n",
+				__func__, enable);
+			return ret;
+		}
+	}
+	ddev->synchronized_update = enable;
+	return 0;
+}
+
+static inline bool mcde_display_get_synchronized_update_default(
+	struct mcde_display_device *ddev)
+{
+	return ddev->synchronized_update;
+}
+
+static int mcde_display_apply_config_default(struct mcde_display_device *ddev)
+{
+	int ret;
+
+	ret = mcde_chnl_enable_synchronized_update(ddev->chnl_state,
+		ddev->synchronized_update);
+
+	if (ret < 0) {
+		dev_warn(&ddev->dev,
+			"%s:Failed to enable synchronized update\n",
+			__func__);
+		return ret;
+	}
+
+	if (!ddev->update_flags)
+		return 0;
+
+	if ((ddev->update_flags & UPDATE_FLAG_VIDEO_MODE) ||
+		(ddev->update_flags & UPDATE_FLAG_PIXEL_FORMAT))
+		mcde_chnl_stop_flow(ddev->chnl_state);
+
+	ret = mcde_chnl_apply(ddev->chnl_state);
+	if (ret < 0) {
+		dev_warn(&ddev->dev, "%s:Failed to apply to channel\n",
+							__func__);
+		return ret;
+	}
+	ddev->update_flags = 0;
+	ddev->first_update = true;
+
+	return 0;
+}
+
+static int mcde_display_invalidate_area_default(
+					struct mcde_display_device *ddev,
+					struct mcde_rectangle *area)
+{
+	dev_vdbg(&ddev->dev, "%s\n", __func__);
+	if (area) {
+		/* take union of rects */
+		u16 t;
+		t = min(ddev->update_area.x, area->x);
+		/* note should be > 0 */
+		ddev->update_area.w = max(ddev->update_area.x +
+							ddev->update_area.w,
+							area->x + area->w) - t;
+		ddev->update_area.x = t;
+		t = min(ddev->update_area.y, area->y);
+		ddev->update_area.h = max(ddev->update_area.y +
+							ddev->update_area.h,
+							area->y + area->h) - t;
+		ddev->update_area.y = t;
+		/* TODO: Implement real clipping when partial refresh is
+		activated.*/
+		ddev->update_area.w = min((u16) ddev->video_mode.xres,
+					(u16) ddev->update_area.w);
+		ddev->update_area.h = min((u16) ddev->video_mode.yres,
+					(u16) ddev->update_area.h);
+	} else {
+		ddev->update_area.x = 0;
+		ddev->update_area.y = 0;
+		ddev->update_area.w = ddev->video_mode.xres;
+		ddev->update_area.h = ddev->video_mode.yres;
+		/* Invalidate_area(ddev, NULL) means reset area to empty
+		 * rectangle really. After that the rectangle should grow by
+		 * taking an union (above). This means that the code should
+		 * really look like below, however the code above is a temp fix
+		 * for rotation.
+		 * TODO: fix
+		 * ddev->update_area.x = ddev->video_mode.xres;
+		 * ddev->update_area.y = ddev->video_mode.yres;
+		 * ddev->update_area.w = 0;
+		 * ddev->update_area.h = 0;
+		 */
+	}
+
+	return 0;
+}
+
+static int mcde_display_update_default(struct mcde_display_device *ddev)
+{
+	int ret;
+
+	/* TODO: Dirty */
+	if (ddev->prepare_for_update) {
+		/* TODO: Send dirty rectangle */
+		ret = ddev->prepare_for_update(ddev, 0, 0,
+			ddev->native_x_res, ddev->native_y_res);
+		if (ret < 0) {
+			dev_warn(&ddev->dev,
+				"%s:Failed to prepare for update\n", __func__);
+			return ret;
+		}
+	}
+	/* TODO: Calculate & set update rect */
+	ret = mcde_chnl_update(ddev->chnl_state, &ddev->update_area);
+	if (ret < 0) {
+		dev_warn(&ddev->dev, "%s:Failed to update channel\n", __func__);
+		return ret;
+	}
+	if (ddev->first_update && ddev->on_first_update)
+		ddev->on_first_update(ddev);
+
+	if (ddev->power_mode != MCDE_DISPLAY_PM_ON && ddev->set_power_mode) {
+		ret = ddev->set_power_mode(ddev, MCDE_DISPLAY_PM_ON);
+		if (ret < 0) {
+			dev_warn(&ddev->dev,
+				"%s:Failed to set power mode to on\n",
+				__func__);
+			return ret;
+		}
+	}
+
+	dev_vdbg(&ddev->dev, "Overlay updated, chnl=%d\n", ddev->chnl_id);
+
+	return 0;
+}
+
+static int mcde_display_prepare_for_update_default(
+					struct mcde_display_device *ddev,
+					u16 x, u16 y, u16 w, u16 h)
+{
+	int ret;
+	u8 params[8] = { x >> 8, x & 0xff,
+			(x + w - 1) >> 8, (x + w - 1) & 0xff,
+			 y >> 8, y & 0xff,
+			(y + h - 1) >> 8, (y + h - 1) & 0xff };
+
+	if (ddev->port->type != MCDE_PORTTYPE_DSI)
+		return -EINVAL;
+
+	ret = mcde_dsi_dcs_write(ddev->chnl_state,
+		DCS_CMD_SET_COLUMN_ADDRESS, &params[0], 4);
+	if (ret)
+		return ret;
+
+	ret = mcde_dsi_dcs_write(ddev->chnl_state,
+		DCS_CMD_SET_PAGE_ADDRESS, &params[4], 4);
+
+	return ret;
+}
+
+static inline int mcde_display_on_first_update_default(
+					struct mcde_display_device *ddev)
+{
+	ddev->first_update = false;
+	return 0;
+}
+
+void mcde_display_init_device(struct mcde_display_device *ddev)
+{
+	/* Setup default callbacks */
+	ddev->get_native_resolution =
+				mcde_display_get_native_resolution_default;
+	ddev->get_default_pixel_format =
+				mcde_display_get_default_pixel_format_default;
+	ddev->get_physical_size = mcde_display_get_physical_size_default;
+	ddev->set_power_mode = mcde_display_set_power_mode_default;
+	ddev->get_power_mode = mcde_display_get_power_mode_default;
+	ddev->try_video_mode = mcde_display_try_video_mode_default;
+	ddev->set_video_mode = mcde_display_set_video_mode_default;
+	ddev->get_video_mode = mcde_display_get_video_mode_default;
+	ddev->set_pixel_format = mcde_display_set_pixel_format_default;
+	ddev->get_pixel_format = mcde_display_get_pixel_format_default;
+	ddev->get_port_pixel_format =
+				mcde_display_get_port_pixel_format_default;
+	ddev->set_rotation = mcde_display_set_rotation_default;
+	ddev->get_rotation = mcde_display_get_rotation_default;
+	ddev->set_synchronized_update =
+				mcde_display_set_synchronized_update_default;
+	ddev->get_synchronized_update =
+				mcde_display_get_synchronized_update_default;
+	ddev->apply_config = mcde_display_apply_config_default;
+	ddev->invalidate_area = mcde_display_invalidate_area_default;
+	ddev->update = mcde_display_update_default;
+	ddev->prepare_for_update = mcde_display_prepare_for_update_default;
+	ddev->on_first_update = mcde_display_on_first_update_default;
+}
+
diff --git a/drivers/video/mcde/mcde_dss.c b/drivers/video/mcde/mcde_dss.c
new file mode 100644
index 0000000..c5b3a96
--- /dev/null
+++ b/drivers/video/mcde/mcde_dss.c
@@ -0,0 +1,353 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE display sub system driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <video/mcde/mcde_dss.h>
+
+#define to_overlay(x) container_of(x, struct mcde_overlay, kobj)
+
+void overlay_release(struct kobject *kobj)
+{
+	struct mcde_overlay *ovly = to_overlay(kobj);
+
+	kfree(ovly);
+}
+
+struct kobj_type ovly_type = {
+	.release = overlay_release,
+};
+
+static int apply_overlay(struct mcde_overlay *ovly,
+				struct mcde_overlay_info *info, bool force)
+{
+	int ret = 0;
+	if (ovly->ddev->invalidate_area) {
+		/* TODO: transform ovly coord to screen coords (vmode):
+		 * add offset
+		 */
+		struct mcde_rectangle dirty = info->dirty;
+		ret = ovly->ddev->invalidate_area(ovly->ddev, &dirty);
+	}
+
+	if (ovly->info.paddr != info->paddr || force)
+		mcde_ovly_set_source_buf(ovly->state, info->paddr);
+
+	if (ovly->info.stride != info->stride || ovly->info.fmt != info->fmt ||
+									force)
+		mcde_ovly_set_source_info(ovly->state, info->stride, info->fmt);
+	if (ovly->info.src_x != info->src_x ||
+					ovly->info.src_y != info->src_y ||
+					ovly->info.w != info->w ||
+					ovly->info.h != info->h || force)
+		mcde_ovly_set_source_area(ovly->state,
+				info->src_x, info->src_y, info->w, info->h);
+	if (ovly->info.dst_x != info->dst_x || ovly->info.dst_y != info->dst_y
+					|| ovly->info.dst_z != info->dst_z ||
+					force)
+		mcde_ovly_set_dest_pos(ovly->state,
+					info->dst_x, info->dst_y, info->dst_z);
+
+	mcde_ovly_apply(ovly->state);
+	ovly->info = *info;
+
+	return ret;
+}
+
+/* MCDE DSS operations */
+
+int mcde_dss_enable_display(struct mcde_display_device *ddev)
+{
+	int ret;
+	struct mcde_chnl_state *chnl;
+
+	if (ddev->enabled)
+		return 0;
+
+	/* Acquire MCDE resources */
+	chnl = mcde_chnl_get(ddev->chnl_id, ddev->fifo, ddev->port);
+	if (IS_ERR(chnl)) {
+		ret = PTR_ERR(chnl);
+		dev_warn(&ddev->dev, "Failed to acquire MCDE channel\n");
+		return ret;
+	}
+	ddev->chnl_state = chnl;
+	/* Initiate display communication */
+	ret = ddev->set_power_mode(ddev, MCDE_DISPLAY_PM_STANDBY);
+	if (ret < 0) {
+		dev_warn(&ddev->dev, "Failed to initialize display\n");
+		goto display_failed;
+	}
+
+	ret = ddev->set_synchronized_update(ddev, ddev->synchronized_update);
+	if (ret < 0)
+		dev_warn(&ddev->dev, "Failed to set sync\n");
+
+	/* TODO: call driver for all defaults like sync_update above */
+
+	dev_dbg(&ddev->dev, "Display enabled, chnl=%d\n",
+					ddev->chnl_id);
+	ddev->enabled = true;
+	return 0;
+
+display_failed:
+	mcde_chnl_put(ddev->chnl_state);
+	ddev->chnl_state = NULL;
+	return ret;
+}
+EXPORT_SYMBOL(mcde_dss_enable_display);
+
+void mcde_dss_disable_display(struct mcde_display_device *ddev)
+{
+	if (!ddev->enabled)
+		return;
+
+	/* TODO: Disable overlays */
+
+	(void)ddev->set_power_mode(ddev, MCDE_DISPLAY_PM_OFF);
+	mcde_chnl_put(ddev->chnl_state);
+	ddev->chnl_state = NULL;
+
+	ddev->enabled = false;
+
+	dev_dbg(&ddev->dev, "Display disabled, chnl=%d\n", ddev->chnl_id);
+}
+EXPORT_SYMBOL(mcde_dss_disable_display);
+
+int mcde_dss_apply_channel(struct mcde_display_device *ddev)
+{
+	if (!ddev->apply_config)
+		return -EINVAL;
+
+	return ddev->apply_config(ddev);
+}
+EXPORT_SYMBOL(mcde_dss_apply_channel);
+
+struct mcde_overlay *mcde_dss_create_overlay(struct mcde_display_device *ddev,
+	struct mcde_overlay_info *info)
+{
+	struct mcde_overlay *ovly;
+
+	ovly = kzalloc(sizeof(struct mcde_overlay), GFP_KERNEL);
+	if (!ovly)
+		return NULL;
+
+	kobject_init(&ovly->kobj, &ovly_type); /* Local ref */
+	kobject_get(&ovly->kobj); /* Creator ref */
+	INIT_LIST_HEAD(&ovly->list);
+	list_add(&ddev->ovlys, &ovly->list);
+	ovly->info = *info;
+	ovly->ddev = ddev;
+
+	return ovly;
+}
+EXPORT_SYMBOL(mcde_dss_create_overlay);
+
+void mcde_dss_destroy_overlay(struct mcde_overlay *ovly)
+{
+	list_del(&ovly->list);
+	if (ovly->state)
+		mcde_dss_disable_overlay(ovly);
+	kobject_put(&ovly->kobj);
+}
+EXPORT_SYMBOL(mcde_dss_destroy_overlay);
+
+int mcde_dss_enable_overlay(struct mcde_overlay *ovly)
+{
+	int ret;
+
+	if (!ovly->ddev->chnl_state)
+		return -EINVAL;
+
+	if (!ovly->state) {
+		struct mcde_ovly_state *state;
+		state = mcde_ovly_get(ovly->ddev->chnl_state);
+		if (IS_ERR(state)) {
+			ret = PTR_ERR(state);
+			dev_warn(&ovly->ddev->dev,
+				"Failed to acquire overlay\n");
+			return ret;
+		}
+		ovly->state = state;
+	}
+
+	apply_overlay(ovly, &ovly->info, true);
+
+	dev_vdbg(&ovly->ddev->dev, "Overlay enabled, chnl=%d\n",
+							ovly->ddev->chnl_id);
+	return 0;
+}
+EXPORT_SYMBOL(mcde_dss_enable_overlay);
+
+int mcde_dss_apply_overlay(struct mcde_overlay *ovly,
+						struct mcde_overlay_info *info)
+{
+	if (info == NULL)
+		info = &ovly->info;
+	return apply_overlay(ovly, info, false);
+}
+EXPORT_SYMBOL(mcde_dss_apply_overlay);
+
+void mcde_dss_disable_overlay(struct mcde_overlay *ovly)
+{
+	if (!ovly->state)
+		return;
+
+	mcde_ovly_put(ovly->state);
+
+	dev_dbg(&ovly->ddev->dev, "Overlay disabled, chnl=%d\n",
+							ovly->ddev->chnl_id);
+
+	ovly->state = NULL;
+}
+EXPORT_SYMBOL(mcde_dss_disable_overlay);
+
+int mcde_dss_update_overlay(struct mcde_overlay *ovly)
+{
+	int ret;
+
+	dev_vdbg(&ovly->ddev->dev, "Overlay update, chnl=%d\n",
+							ovly->ddev->chnl_id);
+
+	if (!ovly->state || !ovly->ddev->update || !ovly->ddev->invalidate_area)
+		return -EINVAL;
+
+	ret = ovly->ddev->update(ovly->ddev);
+	if (ret)
+		return ret;
+
+	return ovly->ddev->invalidate_area(ovly->ddev, NULL);
+}
+EXPORT_SYMBOL(mcde_dss_update_overlay);
+
+void mcde_dss_get_native_resolution(struct mcde_display_device *ddev,
+	u16 *x_res, u16 *y_res)
+{
+	ddev->get_native_resolution(ddev, x_res, y_res);
+}
+EXPORT_SYMBOL(mcde_dss_get_native_resolution);
+
+enum mcde_ovly_pix_fmt mcde_dss_get_default_pixel_format(
+	struct mcde_display_device *ddev)
+{
+	return ddev->get_default_pixel_format(ddev);
+}
+EXPORT_SYMBOL(mcde_dss_get_default_pixel_format);
+
+void mcde_dss_get_physical_size(struct mcde_display_device *ddev,
+	u16 *physical_width, u16 *physical_height)
+{
+	ddev->get_physical_size(ddev, physical_width, physical_height);
+}
+EXPORT_SYMBOL(mcde_dss_get_physical_size);
+
+int mcde_dss_try_video_mode(struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode)
+{
+	return ddev->try_video_mode(ddev, video_mode);
+}
+EXPORT_SYMBOL(mcde_dss_try_video_mode);
+
+int mcde_dss_set_video_mode(struct mcde_display_device *ddev,
+	struct mcde_video_mode *vmode)
+{
+	int ret;
+	struct mcde_video_mode old_vmode;
+
+	ddev->get_video_mode(ddev, &old_vmode);
+	if (memcmp(vmode, &old_vmode, sizeof(old_vmode)) == 0)
+		return 0;
+
+	ret = ddev->set_video_mode(ddev, vmode);
+	if (ret)
+		return ret;
+
+	return ddev->invalidate_area(ddev, NULL);
+}
+EXPORT_SYMBOL(mcde_dss_set_video_mode);
+
+void mcde_dss_get_video_mode(struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode)
+{
+	ddev->get_video_mode(ddev, video_mode);
+}
+EXPORT_SYMBOL(mcde_dss_get_video_mode);
+
+int mcde_dss_set_pixel_format(struct mcde_display_device *ddev,
+	enum mcde_ovly_pix_fmt pix_fmt)
+{
+	enum mcde_ovly_pix_fmt old_pix_fmt;
+
+	old_pix_fmt = ddev->get_pixel_format(ddev);
+	if (old_pix_fmt == pix_fmt)
+		return 0;
+
+	return ddev->set_pixel_format(ddev, pix_fmt);
+}
+EXPORT_SYMBOL(mcde_dss_set_pixel_format);
+
+int mcde_dss_get_pixel_format(struct mcde_display_device *ddev)
+{
+	return ddev->get_pixel_format(ddev);
+}
+EXPORT_SYMBOL(mcde_dss_get_pixel_format);
+
+int mcde_dss_set_rotation(struct mcde_display_device *ddev,
+	enum mcde_display_rotation rotation)
+{
+	enum mcde_display_rotation old_rotation;
+
+	old_rotation = ddev->get_rotation(ddev);
+	if (old_rotation == rotation)
+		return 0;
+
+	return ddev->set_rotation(ddev, rotation);
+}
+EXPORT_SYMBOL(mcde_dss_set_rotation);
+
+enum mcde_display_rotation mcde_dss_get_rotation(
+	struct mcde_display_device *ddev)
+{
+	return ddev->get_rotation(ddev);
+}
+EXPORT_SYMBOL(mcde_dss_get_rotation);
+
+int mcde_dss_set_synchronized_update(struct mcde_display_device *ddev,
+	bool enable)
+{
+	int ret;
+	ret = ddev->set_synchronized_update(ddev, enable);
+	if (ret)
+		return ret;
+	if (ddev->chnl_state)
+		mcde_chnl_enable_synchronized_update(ddev->chnl_state, enable);
+	return 0;
+}
+EXPORT_SYMBOL(mcde_dss_set_synchronized_update);
+
+bool mcde_dss_get_synchronized_update(struct mcde_display_device *ddev)
+{
+	return ddev->get_synchronized_update(ddev);
+}
+EXPORT_SYMBOL(mcde_dss_get_synchronized_update);
+
+int __init mcde_dss_init(void)
+{
+	return 0;
+}
+
+void mcde_dss_exit(void)
+{
+}
+
diff --git a/drivers/video/mcde/mcde_fb.c b/drivers/video/mcde/mcde_fb.c
new file mode 100644
index 0000000..9486e33
--- /dev/null
+++ b/drivers/video/mcde/mcde_fb.c
@@ -0,0 +1,697 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE frame buffer driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/fb.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+
+#include <video/mcde/mcde_fb.h>
+
+#define MCDE_FB_BPP_MAX		16
+#define MCDE_FB_VXRES_MAX	1920
+#define MCDE_FB_VYRES_MAX	2160
+
+static struct fb_ops fb_ops;
+
+struct pix_fmt_info {
+	enum mcde_ovly_pix_fmt pix_fmt;
+
+	u32		   bpp;
+	struct fb_bitfield r;
+	struct fb_bitfield g;
+	struct fb_bitfield b;
+	struct fb_bitfield a;
+	u32                nonstd;
+};
+
+struct pix_fmt_info pix_fmt_map[] = {
+	{
+		.pix_fmt = MCDE_OVLYPIXFMT_RGB565,
+		.bpp = 16,
+		.r = { .offset = 11, .length = 5 },
+		.g = { .offset =  5, .length = 6 },
+		.b = { .offset =  0, .length = 5 },
+	}, {
+		.pix_fmt = MCDE_OVLYPIXFMT_RGBA5551,
+		.bpp = 16,
+		.r = { .offset = 11, .length = 5 },
+		.g = { .offset =  6, .length = 5 },
+		.b = { .offset =  1, .length = 5 },
+		.a = { .offset =  0, .length = 1 },
+	}, {
+		.pix_fmt = MCDE_OVLYPIXFMT_RGBA4444,
+		.bpp = 16,
+		.r = { .offset = 12, .length = 4 },
+		.g = { .offset =  8, .length = 4 },
+		.b = { .offset =  4, .length = 4 },
+		.a = { .offset =  0, .length = 4 },
+	}, {
+		.pix_fmt = MCDE_OVLYPIXFMT_YCbCr422,
+		.bpp = 16,
+		.nonstd = MCDE_OVLYPIXFMT_YCbCr422,
+	}, {
+		.pix_fmt = MCDE_OVLYPIXFMT_RGB888,
+		.bpp = 24,
+		.r = { .offset = 16, .length = 8 },
+		.g = { .offset =  8, .length = 8 },
+		.b = { .offset =  0, .length = 8 },
+	}, {
+		.pix_fmt = MCDE_OVLYPIXFMT_RGBA8888,
+		.bpp = 32,
+		.r = { .offset = 16, .length = 8 },
+		.g = { .offset =  8, .length = 8 },
+		.b = { .offset =  0, .length = 8 },
+		.a = { .offset = 24, .length = 8 },
+	}, {
+		.pix_fmt = MCDE_OVLYPIXFMT_RGBX8888,
+		.bpp = 32,
+		.r = { .offset = 16, .length = 8 },
+		.g = { .offset =  8, .length = 8 },
+		.b = { .offset =  0, .length = 8 },
+	}
+
+};
+
+static struct platform_device mcde_fb_device = {
+	.name = "mcde_fb",
+	.id = -1,
+};
+
+/* Helpers */
+
+static struct pix_fmt_info *find_pix_fmt_info(enum mcde_ovly_pix_fmt pix_fmt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pix_fmt_map); i++) {
+		if (pix_fmt_map[i].pix_fmt == pix_fmt)
+			return &pix_fmt_map[i];
+	}
+	return NULL;
+}
+
+static bool bitfield_cmp(struct fb_bitfield *bf1, struct fb_bitfield *bf2)
+{
+	return bf1->offset == bf2->offset &&
+		bf1->length == bf2->length &&
+		bf1->msb_right == bf2->msb_right;
+}
+
+static struct pix_fmt_info *var_to_pix_fmt_info(struct fb_var_screeninfo *var)
+{
+	int i;
+	struct pix_fmt_info *info;
+
+	if (var->nonstd)
+		return find_pix_fmt_info(var->nonstd);
+
+	for (i = 0; i < ARRAY_SIZE(pix_fmt_map); i++) {
+		info = &pix_fmt_map[i];
+		if (info->bpp == var->bits_per_pixel &&
+					bitfield_cmp(&info->r, &var->red) &&
+					bitfield_cmp(&info->g, &var->green) &&
+					bitfield_cmp(&info->b, &var->blue) &&
+					bitfield_cmp(&info->a, &var->transp))
+			return info;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pix_fmt_map); i++) {
+		info = &pix_fmt_map[i];
+		if (var->bits_per_pixel == info->bpp)
+			return info;
+	}
+
+	return NULL;
+}
+
+static void pix_fmt_info_to_var(struct pix_fmt_info *pix_fmt_info,
+	struct fb_var_screeninfo *var)
+{
+	var->bits_per_pixel = pix_fmt_info->bpp;
+	var->nonstd = pix_fmt_info->nonstd;
+	var->red = pix_fmt_info->r;
+	var->green = pix_fmt_info->g;
+	var->blue = pix_fmt_info->b;
+	var->transp = pix_fmt_info->a;
+}
+
+static int init_var_fmt(struct fb_var_screeninfo *var,
+	u16 w, u16 h, u16 vw, u16 vh, enum mcde_ovly_pix_fmt pix_fmt,
+	u32 rotate)
+{
+	struct pix_fmt_info *info;
+
+	info = find_pix_fmt_info(pix_fmt);
+	if (!info)
+		return -EINVAL;
+
+	var->bits_per_pixel = info->bpp;
+	var->nonstd         = info->nonstd;
+	var->red            = info->r;
+	var->green          = info->g;
+	var->blue           = info->b;
+	var->transp         = info->a;
+	var->grayscale      = false;
+
+	var->xres = w;
+	var->yres = h;
+	var->xres_virtual = vw;
+	var->yres_virtual = vh;
+	var->xoffset = 0;
+	var->yoffset = 0;
+	var->activate = FB_ACTIVATE_NOW;
+	var->rotate = rotate;
+	return 0;
+};
+
+static int reallocate_fb_mem(struct fb_info *fbi, u32 size)
+{
+	dma_addr_t paddr;
+	void __iomem *vaddr;
+#ifdef CONFIG_MCDE_FB_AVOID_REALLOC
+	u32 size_max;
+#endif
+
+	size = PAGE_ALIGN(size);
+
+	if (size == fbi->screen_size)
+		return 0;
+
+	/* TODO: hwmem */
+#ifdef CONFIG_MCDE_FB_AVOID_REALLOC
+	size_max = MCDE_FB_BPP_MAX / 8 * MCDE_FB_VXRES_MAX *
+				MCDE_FB_VYRES_MAX;
+	if (!fbi->screen_base) {
+		vaddr = dma_alloc_coherent(fbi->dev, size_max, &paddr,
+				GFP_KERNEL|GFP_DMA);
+		if (!vaddr)
+			return -ENOMEM;
+
+		fbi->screen_base = vaddr;
+		fbi->fix.smem_start = paddr;
+	} else if (size_max < size)
+		return -ENOMEM;
+#else
+	vaddr = dma_alloc_coherent(fbi->dev, size, &paddr, GFP_KERNEL|GFP_DMA);
+	if (!vaddr)
+		return -ENOMEM;
+#endif
+
+#ifndef CONFIG_MCDE_FB_AVOID_REALLOC
+	if (fbi->screen_base)
+		dma_free_coherent(fbi->dev, fbi->screen_size,
+			fbi->screen_base, fbi->fix.smem_start);
+#endif
+
+#ifndef CONFIG_MCDE_FB_AVOID_REALLOC
+	fbi->screen_base = vaddr;
+	fbi->fix.smem_start = paddr;
+#endif
+	fbi->screen_size = size;
+	fbi->fix.smem_len = size;
+
+	return 0;
+}
+
+static void free_fb_mem(struct fb_info *fbi)
+{
+	if (fbi->fix.smem_start) {
+		dma_free_coherent(fbi->dev, fbi->screen_size,
+			fbi->screen_base, fbi->fix.smem_start);
+		fbi->fix.smem_start = 0;
+		fbi->fix.smem_len = 0;
+		fbi->screen_base = 0;
+		fbi->screen_size = 0;
+	}
+}
+
+static void init_fb(struct fb_info *fbi)
+{
+	struct mcde_fb *mfb = to_mcde_fb(fbi);
+
+	strlcpy(fbi->fix.id, "mcde_fb", sizeof(fbi->fix.id));
+	fbi->fix.type = FB_TYPE_PACKED_PIXELS;
+	fbi->fix.visual = FB_VISUAL_TRUECOLOR;
+	fbi->fix.xpanstep = 1;
+	fbi->fix.ypanstep = 1;
+	fbi->flags = FBINFO_HWACCEL_DISABLED;
+	fbi->fbops = &fb_ops;
+	fbi->pseudo_palette = &mfb->pseudo_palette[0];
+}
+
+static void get_ovly_info(struct fb_info *fbi, struct mcde_overlay *ovly,
+	struct mcde_overlay_info *info)
+{
+	struct mcde_fb *mfb = to_mcde_fb(fbi);
+
+	memset(info, 0, sizeof(*info));
+	info->paddr = fbi->fix.smem_start +
+		fbi->fix.line_length * fbi->var.yoffset;
+	/* TODO: move mem check to check_var/pan_display */
+	if (info->paddr + fbi->fix.line_length * fbi->var.yres >
+		fbi->fix.smem_start + fbi->fix.smem_len)
+		info->paddr = fbi->fix.smem_start;
+	info->fmt = mfb->pix_fmt;
+	info->stride = fbi->fix.line_length;
+	if (ovly) {
+		info->src_x = ovly->info.src_x;
+		info->src_y = ovly->info.src_y;
+		info->dst_x = ovly->info.dst_x;
+		info->dst_y = ovly->info.dst_y;
+		info->dst_z = ovly->info.dst_z;
+	} else {
+		info->src_x = 0;
+		info->src_y = 0;
+		info->dst_x = 0;
+		info->dst_y = 0;
+		info->dst_z = 0;
+	}
+	info->w = fbi->var.xres;
+	info->h = fbi->var.yres;
+	info->dirty.x = 0;
+	info->dirty.y = 0;
+	info->dirty.w = fbi->var.xres;
+	info->dirty.h = fbi->var.yres;
+}
+
+void vmode_to_var(struct mcde_video_mode *video_mode,
+	struct fb_var_screeninfo *var)
+{
+	/* TODO: use only 1 vbp and 1 vfp */
+	var->xres           = video_mode->xres;
+	var->yres           = video_mode->yres;
+	var->pixclock       = video_mode->pixclock;
+	var->upper_margin   = video_mode->vbp1 + video_mode->vbp2;
+	var->lower_margin   = video_mode->vfp1 + video_mode->vfp2;
+	var->left_margin    = video_mode->hbp;
+	var->right_margin   = video_mode->hfp;
+	var->vmode         |= video_mode->interlaced ?
+				FB_VMODE_INTERLACED : FB_VMODE_NONINTERLACED;
+}
+
+void var_to_vmode(struct fb_var_screeninfo *var,
+	struct mcde_video_mode *video_mode)
+{
+	video_mode->xres       = var->xres;
+	video_mode->yres       = var->yres;
+	video_mode->pixclock   = var->pixclock;
+	video_mode->vbp1       = var->upper_margin / 2;
+	video_mode->vfp1       = var->lower_margin / 2;
+	video_mode->vbp2       = video_mode->vbp1 + var->upper_margin % 2;
+	video_mode->vfp2       = video_mode->vfp1 + var->lower_margin % 2;
+	video_mode->hbp        = var->left_margin;
+	video_mode->hfp        = var->right_margin;
+	video_mode->interlaced = (var->vmode & FB_VMODE_INTERLACED) ==
+							FB_VMODE_INTERLACED;
+}
+
+enum mcde_display_rotation var_to_rotation(struct fb_var_screeninfo *var)
+{
+	enum mcde_display_rotation rot;
+
+	switch (var->rotate) {
+	case FB_ROTATE_UR:
+		rot = MCDE_DISPLAY_ROT_0;
+		break;
+	case FB_ROTATE_CW:
+		rot = MCDE_DISPLAY_ROT_90_CW;
+		break;
+	case FB_ROTATE_UD:
+		rot = MCDE_DISPLAY_ROT_180_CW;
+		break;
+	case FB_ROTATE_CCW:
+		rot = MCDE_DISPLAY_ROT_90_CCW;
+		break;
+	default:
+		rot = MCDE_DISPLAY_ROT_0;
+		break;
+	}
+	dev_vdbg(&mcde_fb_device.dev, "var_rot: %d -> mcde_rot: %d\n",
+							var->rotate, rot);
+	return rot;
+}
+
+static struct mcde_display_device *fb_to_display(struct fb_info *fbi)
+{
+	int i;
+	struct mcde_fb *mfb = to_mcde_fb(fbi);
+
+	for (i = 0; i < mfb->num_ovlys; i++) {
+		if (mfb->ovlys[i])
+			return mfb->ovlys[i]->ddev;
+	}
+	return NULL;
+}
+
+static int check_var(struct fb_var_screeninfo *var, struct fb_info *fbi,
+	struct mcde_display_device *ddev)
+{
+	int ret;
+	u16 w = -1, h = -1;
+	struct mcde_video_mode vmode;
+	struct pix_fmt_info *fmtinfo;
+
+	/* TODO: check sizes/offsets/memory validity */
+
+	/* Device physical size */
+	mcde_dss_get_physical_size(ddev, &w, &h);
+	var->width  = w;
+	var->height = h;
+
+	/* Rotation */
+	if (var->rotate > 3) {
+		dev_info(&(ddev->dev), "check_var failed var->rotate\n");
+		return -EINVAL;
+	}
+
+	/* Video mode */
+	var_to_vmode(var, &vmode);
+	ret = mcde_dss_try_video_mode(ddev, &vmode);
+	if (ret < 0) {
+		dev_vdbg(&(ddev->dev), "check_var failed "
+			"mcde_dss_try_video_mode with size = %x\n", ret);
+		return ret;
+	}
+	vmode_to_var(&vmode, var);
+
+	/* Pixel format */
+	fmtinfo = var_to_pix_fmt_info(var);
+	if (!fmtinfo) {
+		dev_vdbg(&(ddev->dev), "check_var failed fmtinfo\n");
+		return -EINVAL;
+	}
+	pix_fmt_info_to_var(fmtinfo, var);
+
+	/* Not used */
+	var->grayscale = 0;
+	var->sync = 0;
+
+	return 0;
+}
+
+static int apply_var(struct fb_info *fbi, struct mcde_display_device *ddev)
+{
+	int ret, i;
+	struct mcde_fb *mfb = to_mcde_fb(fbi);
+	struct fb_var_screeninfo *var;
+	struct mcde_video_mode vmode;
+	struct pix_fmt_info *fmt;
+	u32 line_len, size;
+
+	dev_vdbg(&(ddev->dev), "%s\n", __func__);
+
+	var = &fbi->var;
+
+	/* Reallocate memory */
+	line_len = (fbi->var.bits_per_pixel * var->xres_virtual) / 8;
+	line_len = ALIGN(line_len, MCDE_BUF_LINE_ALIGMENT);
+	size = line_len * var->yres_virtual;
+	ret = reallocate_fb_mem(fbi, size);
+	if (ret) {
+		dev_vdbg(&(ddev->dev), "apply_var failed with"
+				"reallocate mem with size = %d\n", size);
+		return ret;
+	}
+	fbi->fix.line_length = line_len;
+
+	if (ddev) {
+		/* Apply pixel format */
+		fmt = var_to_pix_fmt_info(var);
+		mfb->pix_fmt = fmt->pix_fmt;
+		mcde_dss_set_pixel_format(ddev, mfb->pix_fmt);
+
+		/* Apply rotation */
+		mcde_dss_set_rotation(ddev, var_to_rotation(var));
+		/* Apply video mode */
+		memset(&vmode, 0, sizeof(struct mcde_video_mode));
+		var_to_vmode(var, &vmode);
+		mcde_dss_set_video_mode(ddev, &vmode);
+		mcde_dss_apply_channel(ddev);
+	}
+
+	/* Apply overlay info */
+	for (i = 0; i < mfb->num_ovlys; i++) {
+		struct mcde_overlay *ovly = mfb->ovlys[i];
+		struct mcde_overlay_info info;
+
+		get_ovly_info(fbi, ovly, &info);
+		(void) mcde_dss_apply_overlay(ovly, &info);
+		ret = mcde_dss_update_overlay(ovly);
+	}
+
+	return 0;
+}
+
+/* FB ops */
+
+static int mcde_fb_open(struct fb_info *fbi, int user)
+{
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+	return 0;
+}
+
+static int mcde_fb_release(struct fb_info *fbi, int user)
+{
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+	return 0;
+}
+
+static int mcde_fb_check_var(struct fb_var_screeninfo *var, struct fb_info *fbi)
+{
+	struct mcde_display_device *ddev = fb_to_display(fbi);
+
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+
+	if (!ddev) {
+		printk(KERN_ERR "mcde_fb_check_var failed !ddev\n");
+		return -ENODEV;
+	}
+
+	return check_var(var, fbi, ddev);
+}
+
+static int mcde_fb_set_par(struct fb_info *fbi)
+{
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+
+	return apply_var(fbi, fb_to_display(fbi));
+}
+
+static int mcde_fb_blank(int blank, struct fb_info *fbi)
+{
+	int ret = 0;
+	int i;
+	struct mcde_display_device *ddev = fb_to_display(fbi);
+	struct mcde_fb *mfb = to_mcde_fb(fbi);
+
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+
+	switch (blank) {
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
+		for (i = 0; i < mfb->num_ovlys; i++) {
+			struct mcde_overlay *ovly = mfb->ovlys[i];
+			mcde_dss_disable_overlay(ovly);
+		}
+		mcde_dss_disable_display(ddev);
+	break;
+	case FB_BLANK_UNBLANK:
+		ret = mcde_dss_enable_display(ddev);
+		for (i = 0; i < mfb->num_ovlys; i++) {
+			struct mcde_overlay *ovly = mfb->ovlys[i];
+			ret = mcde_dss_enable_overlay(ovly);
+			ret = mcde_dss_update_overlay(ovly);
+		}
+	break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static int mcde_fb_pan_display(struct fb_var_screeninfo *var,
+	struct fb_info *fbi)
+{
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+
+	if (var->xoffset == fbi->var.xoffset &&
+					var->yoffset == fbi->var.yoffset)
+		return 0;
+
+	fbi->var.xoffset = var->xoffset;
+	fbi->var.yoffset = var->yoffset;
+	return apply_var(fbi, fb_to_display(fbi));
+}
+
+static void mcde_fb_rotate(struct fb_info *fbi, int rotate)
+{
+	dev_vdbg(fbi->dev, "%s\n", __func__);
+}
+
+static struct fb_ops fb_ops = {
+	/* creg, cmap */
+	.owner          = THIS_MODULE,
+	.fb_open        = mcde_fb_open,
+	.fb_release     = mcde_fb_release,
+	.fb_read        = fb_sys_read,
+	.fb_write       = fb_sys_write,
+	.fb_fillrect    = sys_fillrect,
+	.fb_copyarea    = sys_copyarea,
+	.fb_imageblit   = sys_imageblit,
+	.fb_check_var   = mcde_fb_check_var,
+	.fb_set_par     = mcde_fb_set_par,
+	.fb_blank       = mcde_fb_blank,
+	.fb_pan_display = mcde_fb_pan_display,
+	.fb_rotate      = mcde_fb_rotate,
+};
+
+/* FB driver */
+
+struct fb_info *mcde_fb_create(struct mcde_display_device *ddev,
+	u16 w, u16 h, u16 vw, u16 vh, enum mcde_ovly_pix_fmt pix_fmt,
+	u32 rotate)
+{
+	int ret = 0;
+	struct fb_info *fbi;
+	struct mcde_fb *mfb;
+	struct mcde_overlay *ovly = NULL;
+	struct mcde_overlay_info ovly_info;
+
+	dev_vdbg(&ddev->dev, "%s\n", __func__);
+	if (!ddev->initialized) {
+		dev_warn(&ddev->dev, "%s: Device not initialized\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Init fb */
+	fbi = framebuffer_alloc(sizeof(struct mcde_fb), &mcde_fb_device.dev);
+	if (fbi == NULL) {
+		ret = -ENOMEM;
+		goto fb_alloc_failed;
+	}
+	init_fb(fbi);
+	mfb = to_mcde_fb(fbi);
+
+	ret = mcde_dss_enable_display(ddev);
+	if (ret)
+		goto display_enable_failed;
+
+	/* Prepare var and allocate frame buffer memory */
+	init_var_fmt(&fbi->var, w, h, vw, vh, pix_fmt, rotate);
+	check_var(&fbi->var, fbi, ddev);
+	ret = apply_var(fbi, ddev);
+	if (ret)
+		goto apply_var_failed;
+
+	/* Setup overlay */
+	get_ovly_info(fbi, NULL, &ovly_info);
+	ovly = mcde_dss_create_overlay(ddev, &ovly_info);
+	if (!ovly) {
+		ret = PTR_ERR(ovly);
+		goto ovly_alloc_failed;
+	}
+	mfb->ovlys[0] = ovly;
+	mfb->num_ovlys = 1;
+
+	ret = mcde_dss_enable_overlay(ovly);
+	if (ret)
+		goto ovly_enable_failed;
+
+	mfb->id = ddev->id;
+
+	mcde_dss_update_overlay(ovly);
+
+	/* Register framebuffer */
+	ret = register_framebuffer(fbi);
+	if (ret)
+		goto fb_register_failed;
+
+	goto out;
+fb_register_failed:
+	mcde_dss_disable_overlay(ovly);
+ovly_enable_failed:
+	mcde_dss_destroy_overlay(ovly);
+ovly_alloc_failed:
+	free_fb_mem(fbi);
+apply_var_failed:
+	mcde_dss_disable_display(ddev);
+display_enable_failed:
+	framebuffer_release(fbi);
+	fbi = NULL;
+fb_alloc_failed:
+out:
+	return ret ? ERR_PTR(ret) : fbi;
+}
+EXPORT_SYMBOL(mcde_fb_create);
+
+int mcde_fb_attach_overlay(struct fb_info *fb_info, struct mcde_overlay *ovl)
+{
+	/* TODO: Attach extra overlay targets */
+	return -EINVAL;
+}
+
+void mcde_fb_destroy(struct fb_info *fb_info)
+{
+	/* TODO: clean up */
+}
+
+/* Overlay fbs' platform device */
+static int mcde_fb_probe(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int mcde_fb_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver mcde_fb_driver = {
+	.probe  = mcde_fb_probe,
+	.remove = mcde_fb_remove,
+	.driver = {
+		.name  = "mcde_fb",
+		.owner = THIS_MODULE,
+	},
+};
+
+/* MCDE fb init */
+
+int __init mcde_fb_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&mcde_fb_driver);
+	if (ret)
+		goto fb_driver_failed;
+	ret = platform_device_register(&mcde_fb_device);
+	if (ret)
+		goto fb_device_failed;
+
+	goto out;
+fb_device_failed:
+	platform_driver_unregister(&mcde_fb_driver);
+fb_driver_failed:
+out:
+	return ret;
+}
+
+void mcde_fb_exit(void)
+{
+	platform_device_unregister(&mcde_fb_device);
+	platform_driver_unregister(&mcde_fb_driver);
+}
+
diff --git a/drivers/video/mcde/mcde_hw.c b/drivers/video/mcde/mcde_hw.c
new file mode 100644
index 0000000..5ab445f
--- /dev/null
+++ b/drivers/video/mcde/mcde_hw.c
@@ -0,0 +1,2526 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE base driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/err.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
+#include <linux/clk.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+
+#include <video/mcde/mcde.h>
+
+#include "dsilink_regs.h"
+#include "mcde_regs.h"
+
+static void disable_channel(struct mcde_chnl_state *chnl);
+static void enable_channel(struct mcde_chnl_state *chnl);
+static void watchdog_auto_sync_timer_function(unsigned long arg);
+
+#define OVLY_TIMEOUT 500
+#define CHNL_TIMEOUT 500
+
+u8 *mcdeio;
+u8 **dsiio;
+DEFINE_SPINLOCK(mcde_lock); /* REVIEW: Remove or use */
+struct platform_device *mcde_dev;
+u8 num_dsilinks;
+static u8 hardware_version;
+
+static struct regulator *regulator;
+static struct clk *clock_dsi;
+static struct clk *clock_mcde;
+static struct clk *clock_dsi_lp;
+static u8 mcde_is_enabled;
+
+static inline u32 dsi_rreg(int i, u32 reg)
+{
+	return readl(dsiio[i] + reg);
+}
+static inline void dsi_wreg(int i, u32 reg, u32 val)
+{
+	writel(val, dsiio[i] + reg);
+}
+#define dsi_rfld(__i, __reg, __fld) \
+	((dsi_rreg(__i, __reg) & __reg##_##__fld##_MASK) >> \
+		__reg##_##__fld##_SHIFT)
+#define dsi_wfld(__i, __reg, __fld, __val) \
+	dsi_wreg(__i, __reg, (dsi_rreg(__i, __reg) & \
+	~__reg##_##__fld##_MASK) | (((__val) << __reg##_##__fld##_SHIFT) & \
+		 __reg##_##__fld##_MASK))
+
+static inline u32 mcde_rreg(u32 reg)
+{
+	return readl(mcdeio + reg);
+}
+static inline void mcde_wreg(u32 reg, u32 val)
+{
+	writel(val, mcdeio + reg);
+}
+#define mcde_rfld(__reg, __fld) \
+	((mcde_rreg(__reg) & __reg##_##__fld##_MASK) >> \
+		__reg##_##__fld##_SHIFT)
+#define mcde_wfld(__reg, __fld, __val) \
+	mcde_wreg(__reg, (mcde_rreg(__reg) & \
+	~__reg##_##__fld##_MASK) | (((__val) << __reg##_##__fld##_SHIFT) & \
+		 __reg##_##__fld##_MASK))
+
+struct ovly_regs {
+	u8   ch_id;
+	bool enabled;
+	u32  baseaddress0;
+	u32  baseaddress1;
+	bool reset_buf_id;
+	u8   bits_per_pixel;
+	u8   bpp;
+	bool bgr;
+	bool bebo;
+	bool opq;
+	u8   col_conv;
+	u8   pixoff;
+	u16  ppl;
+	u16  lpf;
+	u16  cropx;
+	u16  cropy;
+	u16  xpos;
+	u16  ypos;
+	u8   z;
+};
+
+struct mcde_ovly_state {
+	bool inuse;
+	u8 idx; /* MCDE overlay index */
+	struct mcde_chnl_state *chnl; /* Owner channel */
+	u32 transactionid; /* Apply time stamp */
+	u32 transactionid_regs; /* Register update time stamp */
+	u32 transactionid_hw; /* HW completed time stamp */
+	wait_queue_head_t waitq_hw; /* Waitq for transactionid_hw */
+
+	/* Staged settings */
+	u32 paddr;
+	u16 stride;
+	enum mcde_ovly_pix_fmt pix_fmt;
+
+	u16 src_x;
+	u16 src_y;
+	u16 dst_x;
+	u16 dst_y;
+	u16 dst_z;
+	u16 w;
+	u16 h;
+
+	/* Applied settings */
+	struct ovly_regs regs;
+};
+static struct mcde_ovly_state overlays[] = {
+	{ .idx = 0 },
+	{ .idx = 1 },
+	{ .idx = 2 },
+	{ .idx = 3 },
+	{ .idx = 4 },
+	{ .idx = 5 },
+};
+
+struct chnl_regs {
+	bool floen;
+	u16  x;
+	u16  y;
+	u16  ppl;
+	u16  lpf;
+	u8   bpp;
+	bool synchronized_update;
+	bool roten;
+	u8   rotdir;
+	u32  rotbuf1; /* TODO: Replace with eSRAM alloc */
+	u32  rotbuf2; /* TODO: Replace with eSRAM alloc */
+
+	/* DSI */
+	u8 dsipacking;
+};
+
+struct col_regs {
+	u16 y_red;
+	u16 y_green;
+	u16 y_blue;
+	u16 cb_red;
+	u16 cb_green;
+	u16 cb_blue;
+	u16 cr_red;
+	u16 cr_green;
+	u16 cr_blue;
+	u16 off_red;
+	u16 off_green;
+	u16 off_blue;
+};
+
+struct tv_regs {
+	u16 hbw; /* horizontal blanking width */
+	/* field 1 */
+	u16 bel1; /* field total vertical blanking lines */
+	u16 fsl1; /* field vbp */
+	/* field 2 */
+	u16 bel2;
+	u16 fsl2;
+	bool interlaced_en;
+	u8 tv_mode;
+};
+
+struct mcde_chnl_state {
+	bool inuse;
+	enum mcde_chnl id;
+	enum mcde_fifo fifo;
+	struct mcde_port port;
+	struct mcde_ovly_state *ovly0;
+	struct mcde_ovly_state *ovly1;
+	const struct chnl_config *cfg;
+	u32 transactionid;
+	u32 transactionid_regs;
+	u32 transactionid_hw;
+	wait_queue_head_t waitq_hw; /* Waitq for transactionid_hw */
+	/* Used as watchdog timer for auto sync feature */
+	struct timer_list auto_sync_timer;
+
+	enum mcde_display_power_mode power_mode;
+
+	/* Staged settings */
+	bool synchronized_update;
+	enum mcde_port_pix_fmt pix_fmt;
+	struct mcde_video_mode vmode;
+	enum mcde_display_rotation rotation;
+	u32 rotbuf1;
+	u32 rotbuf2;
+
+	/* Applied settings */
+	struct chnl_regs regs;
+	struct col_regs  col_regs;
+	struct tv_regs   tv_regs;
+
+	bool continous_running;
+};
+
+static struct mcde_chnl_state channels[] = {
+	{
+		.id = MCDE_CHNL_A,
+		.ovly0 = &overlays[0],
+		.ovly1 = &overlays[1],
+	},
+	{
+		.id = MCDE_CHNL_B,
+		.ovly0 = &overlays[2],
+		.ovly1 = &overlays[3],
+	},
+	{
+		.id = MCDE_CHNL_C0,
+		.ovly0 = &overlays[4],
+		.ovly1 = NULL,
+	},
+	{
+		.id = MCDE_CHNL_C1,
+		.ovly0 = &overlays[5],
+		.ovly1 = NULL,
+	}
+};
+
+struct chnl_config {
+	/* Key */
+	enum mcde_chnl_path path;
+
+	/* Value */
+	bool swap_a_c0;
+	bool swap_a_c0_set;
+	bool swap_b_c1;
+	bool swap_b_c1_set;
+	bool fabmux;
+	bool fabmux_set;
+	bool f01mux;
+	bool f01mux_set;
+};
+
+static /* TODO: const, compiler bug? */ struct chnl_config chnl_configs[] = {
+	/* Channel A */
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOA_DPI_0,
+	  .swap_a_c0 = false, .swap_a_c0_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC0_0,
+	  .swap_a_c0 = false, .swap_a_c0_set = true,
+	  .fabmux = false, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC0_1,
+	  .swap_a_c0 = false, .swap_a_c0_set = true,
+	  .fabmux = true, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOC0_DSI_IFC0_2,
+	  .swap_a_c0 = true, .swap_a_c0_set = true,
+	  .f01mux = false, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOC0_DSI_IFC1_0,
+	  .swap_a_c0 = true, .swap_a_c0_set = true,
+	  .f01mux = false, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOC0_DSI_IFC1_1,
+	  .swap_a_c0 = true, .swap_a_c0_set = true,
+	  .f01mux = true, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC1_2,
+	  .swap_a_c0 = false, .swap_a_c0_set = true,
+	  .fabmux = false, .fabmux_set = true },
+	/* Channel B */
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOB_DPI_1,
+	  .swap_b_c1 = false, .swap_b_c1_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOB_DSI_IFC0_0,
+	  .swap_b_c1 = false, .swap_b_c1_set = true,
+	  .fabmux = true, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOB_DSI_IFC0_1,
+	  .swap_b_c1 = false, .swap_b_c1_set = true,
+	  .fabmux = false, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOC1_DSI_IFC0_2,
+	  .swap_b_c1 = true, .swap_b_c1_set = true,
+	  .f01mux = true, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOC1_DSI_IFC1_0,
+	  .swap_b_c1 = true, .swap_b_c1_set = true,
+	  .f01mux = true, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOC1_DSI_IFC1_1,
+	  .swap_b_c1 = true, .swap_b_c1_set = true,
+	  .f01mux = false, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLB_FIFOB_DSI_IFC1_2,
+	  .swap_b_c1 = false, .swap_b_c1_set = true,
+	  .fabmux = true, .fabmux_set = true },
+	/* Channel C0 */
+	{ .path = MCDE_CHNLPATH_CHNLC0_FIFOA_DSI_IFC0_0,
+	  .swap_a_c0 = true, .swap_a_c0_set = true,
+	  .fabmux = false, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC0_FIFOA_DSI_IFC0_1,
+	  .swap_a_c0 = true, .swap_a_c0_set = true,
+	  .fabmux = true, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC0_FIFOC0_DSI_IFC0_2,
+	  .swap_a_c0 = false, .swap_a_c0_set = true,
+	  .f01mux = false, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC0_FIFOC0_DSI_IFC1_0,
+	  .swap_a_c0 = false, .swap_a_c0_set = true,
+	  .f01mux = false, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC0_FIFOC0_DSI_IFC1_1,
+	  .swap_a_c0 = false, .swap_a_c0_set = true,
+	  .f01mux = true, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC0_FIFOA_DSI_IFC1_2,
+	  .swap_a_c0 = true, .swap_a_c0_set = true,
+	  .fabmux = false, .fabmux_set = true },
+	/* Channel C1 */
+	{ .path = MCDE_CHNLPATH_CHNLC1_FIFOB_DSI_IFC0_0,
+	  .swap_b_c1 = true, .swap_b_c1_set = true,
+	  .fabmux = true, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC1_FIFOB_DSI_IFC0_1,
+	  .swap_b_c1 = true, .swap_b_c1_set = true,
+	  .fabmux = false, .fabmux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC1_FIFOC1_DSI_IFC0_2,
+	  .swap_b_c1 = false, .swap_b_c1_set = true,
+	  .f01mux = true, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC1_FIFOC1_DSI_IFC1_0,
+	  .swap_b_c1 = false, .swap_b_c1_set = true,
+	  .f01mux = true, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC1_FIFOC1_DSI_IFC1_1,
+	  .swap_b_c1 = false, .swap_b_c1_set = true,
+	  .f01mux = false, .f01mux_set = true },
+	{ .path = MCDE_CHNLPATH_CHNLC1_FIFOB_DSI_IFC1_2,
+	  .swap_b_c1 = true, .swap_b_c1_set = true,
+	  .fabmux = true, .fabmux_set = true },
+};
+
+static int enable_clocks_and_power(struct platform_device *pdev)
+{
+	struct mcde_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	if (regulator) {
+		ret = regulator_enable(regulator);
+		if (ret < 0) {
+			dev_warn(&pdev->dev, "%s: regulator_enable failed\n",
+			__func__);
+			return ret;
+		}
+	} else {
+		dev_dbg(&pdev->dev, "%s: No regulator id supplied\n"
+						, __func__);
+	}
+
+	ret = pdata->platform_enable();
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "%s: "
+			"platform_enable failed ret = %d\n", __func__, ret);
+		goto prcmu_err;
+	}
+
+	ret = clk_enable(clock_dsi);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "%s: "
+			"clk_enable dsi failed ret = %d\n", __func__, ret);
+		goto clk_dsi_err;
+	}
+	ret = clk_enable(clock_dsi_lp);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "%s: "
+			"clk_enable dsi_lp failed ret = %d\n", __func__, ret);
+		goto clk_dsi_lp_err;
+	}
+	ret = clk_enable(clock_mcde);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "%s: "
+			"clk_enable mcde failed ret = %d\n", __func__, ret);
+		goto clk_mcde_err;
+	}
+
+	return ret;
+
+prcmu_err:
+	pdata->platform_disable();
+clk_mcde_err:
+	clk_disable(clock_dsi_lp);
+clk_dsi_lp_err:
+	clk_disable(clock_dsi);
+clk_dsi_err:
+	if (regulator)
+		regulator_disable(regulator);
+	return ret;
+}
+
+static int disable_clocks_and_power(struct platform_device *pdev)
+{
+	struct mcde_platform_data *pdata = pdev->dev.platform_data;
+	int ret = 0;
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	clk_disable(clock_dsi_lp);
+	clk_disable(clock_mcde);
+	clk_disable(clock_dsi);
+	if (regulator) {
+		ret = regulator_disable(regulator);
+		if (ret < 0) {
+			dev_warn(&pdev->dev, "%s: regulator_disable failed\n"
+					, __func__);
+			goto regulator_err;
+		}
+	} else {
+		dev_dbg(&pdev->dev, "%s: No regulator id supplied\n"
+					, __func__);
+	}
+
+	pdata->platform_disable();
+
+	return ret;
+regulator_err:
+	clk_enable(clock_dsi_lp);
+	clk_enable(clock_mcde);
+	clk_enable(clock_dsi);
+	return ret;
+}
+
+static void update_mcde_registers(void)
+{
+	struct mcde_platform_data *pdata = mcde_dev->dev.platform_data;
+
+	/* Setup output muxing */
+	mcde_wreg(MCDE_CONF0,
+		MCDE_CONF0_IFIFOCTRLWTRMRKLVL(7) |
+		MCDE_CONF0_OUTMUX0(pdata->outmux[0]) |
+		MCDE_CONF0_OUTMUX1(pdata->outmux[1]) |
+		MCDE_CONF0_OUTMUX2(pdata->outmux[2]) |
+		MCDE_CONF0_OUTMUX3(pdata->outmux[3]) |
+		MCDE_CONF0_OUTMUX4(pdata->outmux[4]) |
+		pdata->syncmux);
+
+	/* Enable channel VCMP interrupts */
+	mcde_wreg(MCDE_IMSCPP,
+		MCDE_IMSCPP_VCMPAIM(true) |
+		MCDE_IMSCPP_VCMPBIM(true) |
+		MCDE_IMSCPP_VCMPC0IM(true) |
+		MCDE_IMSCPP_VCMPC1IM(true));
+
+	/* Enable overlay fetch done interrupts */
+	mcde_wfld(MCDE_IMSCOVL, OVLFDIM, 0x3f);
+
+	/* Setup sync pulse length */
+	mcde_wreg(MCDE_VSCRC0,
+		MCDE_VSCRC0_VSPMIN(1) |
+		MCDE_VSCRC0_VSPMAX(0xff));
+	mcde_wreg(MCDE_VSCRC1,
+		MCDE_VSCRC1_VSPMIN(1) |
+		MCDE_VSCRC1_VSPMAX(0xff));
+}
+
+static int is_channel_enabled(struct mcde_chnl_state *chnl)
+{
+	switch (chnl->id) {
+	case MCDE_CHNL_A:
+		return mcde_rfld(MCDE_CRA0, FLOEN);
+	case MCDE_CHNL_B:
+		return mcde_rfld(MCDE_CRB0, FLOEN);
+	case MCDE_CHNL_C0:
+		return mcde_rfld(MCDE_CRC, FLOEN);
+	case MCDE_CHNL_C1:
+		return mcde_rfld(MCDE_CRC, FLOEN);
+	}
+	return 0;
+}
+
+static void channel_flow_disable(struct mcde_chnl_state *chnl)
+{
+	switch (chnl->id) {
+	case MCDE_CHNL_A:
+		mcde_wfld(MCDE_CRA0, FLOEN, false);
+		break;
+	case MCDE_CHNL_B:
+		mcde_wfld(MCDE_CRB0, FLOEN, false);
+		break;
+	case MCDE_CHNL_C0:
+		mcde_wfld(MCDE_CRC, FLOEN, false);
+		break;
+	case MCDE_CHNL_C1:
+		mcde_wfld(MCDE_CRC, FLOEN, false);
+		break;
+	}
+}
+
+static void channel_flow_enable(struct mcde_chnl_state *chnl)
+{
+	switch (chnl->id) {
+	case MCDE_CHNL_A:
+		mcde_wfld(MCDE_CRA0, FLOEN, true);
+		break;
+	case MCDE_CHNL_B:
+		mcde_wfld(MCDE_CRB0, FLOEN, true);
+		break;
+	case MCDE_CHNL_C0:
+		mcde_wfld(MCDE_CRC, C1EN, true);
+		mcde_wfld(MCDE_CRC, FLOEN, true);
+		break;
+	case MCDE_CHNL_C1:
+		mcde_wfld(MCDE_CRC, C2EN, true);
+		mcde_wfld(MCDE_CRC, FLOEN, true);
+		break;
+	}
+}
+
+#define MCDE_PIXELDISABLE_MAX_TRIAL 20
+static void channel_pixelprocessing_disable(struct mcde_chnl_state *chnl)
+{
+	int i;
+	switch (chnl->id) {
+	case MCDE_CHNL_A:
+	case MCDE_CHNL_B:
+		/* Pixelprocessing can not be enable/disabled for A and B */
+		return;
+	case MCDE_CHNL_C0:
+		mcde_wfld(MCDE_CRC, C1EN, false);
+		for (i = 0; i < MCDE_PIXELDISABLE_MAX_TRIAL; i++) {
+			msleep(3);
+			if (!mcde_rfld(MCDE_CRC, C1EN)) {
+				dev_vdbg(&mcde_dev->dev,
+					"C1 disable after >= %d ms\n"
+									, i);
+				return;
+			}
+		}
+		break;
+	case MCDE_CHNL_C1:
+		mcde_wfld(MCDE_CRC, C2EN, false);
+		for (i = 0; i < MCDE_PIXELDISABLE_MAX_TRIAL; i++) {
+			msleep(3);
+			if (!mcde_rfld(MCDE_CRC, C2EN)) {
+				dev_vdbg(&mcde_dev->dev,
+					"C2 disable after >= %d ms\n"
+									, i);
+				return;
+			}
+		}
+		break;
+	}
+	dev_warn(&mcde_dev->dev, "%s: Channel %d timeout\n"
+						, __func__, chnl->id);
+}
+#undef MCDE_PIXELDISABLE_MAX_TRIAL
+
+int mcde_chnl_set_video_mode(struct mcde_chnl_state *chnl,
+				struct mcde_video_mode *vmode)
+{
+	if (chnl == NULL || vmode == NULL)
+		return -EINVAL;
+
+	chnl->vmode = *vmode;
+
+	return 0;
+}
+
+static void tv_video_mode_apply(struct mcde_chnl_state *chnl)
+{
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+	/* -4 since MCDE doesn't include SAV/EAV, 2 bytes each, to blanking */
+	chnl->tv_regs.hbw  = chnl->vmode.hbp + chnl->vmode.hfp - 4;
+	chnl->tv_regs.bel1 = chnl->vmode.vbp1 + chnl->vmode.vfp1;
+	chnl->tv_regs.fsl1 = chnl->vmode.vbp1;
+	chnl->tv_regs.bel2 = chnl->vmode.vbp2 + chnl->vmode.vfp2;
+	chnl->tv_regs.fsl2 = chnl->vmode.vbp2;
+	chnl->tv_regs.interlaced_en = chnl->vmode.interlaced;
+
+	if (chnl->port.phy.dpi.bus_width == 4)
+		chnl->tv_regs.tv_mode = MCDE_TVCRA_TVMODE_SDTV_656P_BE;
+	else
+		chnl->tv_regs.tv_mode = MCDE_TVCRA_TVMODE_SDTV_656P;
+}
+
+static void update_tv_registers(enum mcde_chnl chnl_id, struct tv_regs *regs)
+{
+	u8 idx = chnl_id;
+
+	dev_dbg(&mcde_dev->dev, "%s\n", __func__);
+	mcde_wreg(MCDE_TVCRA + idx * MCDE_TVCRA_GROUPOFFSET,
+			MCDE_TVCRA_SEL_MOD(MCDE_TVCRA_SEL_MOD_TV)         |
+			MCDE_TVCRA_INTEREN(regs->interlaced_en)           |
+			MCDE_TVCRA_IFIELD(1)                              |
+			MCDE_TVCRA_TVMODE(regs->tv_mode)                  |
+			MCDE_TVCRA_SDTVMODE(MCDE_TVCRA_SDTVMODE_Y0CBY1CR) |
+			MCDE_TVCRA_AVRGEN(0));
+	mcde_wreg(MCDE_TVBLUA + idx * MCDE_TVBLUA_GROUPOFFSET,
+		MCDE_TVBLUA_TVBLU(MCDE_CONFIG_TVOUT_BACKGROUND_LUMINANCE) |
+		MCDE_TVBLUA_TVBCB(MCDE_CONFIG_TVOUT_BACKGROUND_CHROMINANCE_CB)|
+		MCDE_TVBLUA_TVBCR(MCDE_CONFIG_TVOUT_BACKGROUND_CHROMINANCE_CR));
+
+	/* Vertical timing registers */
+	mcde_wreg(MCDE_TVDVOA + idx * MCDE_TVDVOA_GROUPOFFSET,
+				MCDE_TVDVOA_DVO1(MCDE_CONFIG_TVOUT_VBORDER) |
+				MCDE_TVDVOA_DVO2(MCDE_CONFIG_TVOUT_VBORDER));
+	mcde_wreg(MCDE_TVBL1A + idx * MCDE_TVBL1A_GROUPOFFSET,
+				MCDE_TVBL1A_BEL1(regs->bel1) |
+				MCDE_TVBL1A_BSL1(MCDE_CONFIG_TVOUT_VBORDER));
+	mcde_wreg(MCDE_TVBL2A + idx * MCDE_TVBL1A_GROUPOFFSET,
+				MCDE_TVBL2A_BEL2(regs->bel2) |
+				MCDE_TVBL2A_BSL2(MCDE_CONFIG_TVOUT_VBORDER));
+	mcde_wreg(MCDE_TVISLA + idx * MCDE_TVISLA_GROUPOFFSET,
+				MCDE_TVISLA_FSL1(regs->fsl1) |
+				MCDE_TVISLA_FSL2(regs->fsl2));
+
+	/* Horizontal timing registers */
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_8) {
+		mcde_wreg(MCDE_TVLBALWA + idx * MCDE_TVLBALWA_GROUPOFFSET,
+				MCDE_TVLBALWA_LBW(regs->hbw) |
+				MCDE_TVLBALWA_ALW(MCDE_CONFIG_TVOUT_HBORDER));
+		mcde_wreg(MCDE_TVTIM1A + idx * MCDE_TVTIM1A_GROUPOFFSET,
+				MCDE_TVTIM1A_DHO(MCDE_CONFIG_TVOUT_HBORDER));
+	} else {
+		/* in earlier versions the LBW and DHO fields are swapped */
+		mcde_wreg(MCDE_TVLBALWA + idx * MCDE_TVLBALWA_GROUPOFFSET,
+				MCDE_TVLBALWA_LBW(MCDE_CONFIG_TVOUT_HBORDER) |
+				MCDE_TVLBALWA_ALW(MCDE_CONFIG_TVOUT_HBORDER));
+		mcde_wreg(MCDE_TVTIM1A + idx * MCDE_TVTIM1A_GROUPOFFSET,
+			MCDE_TVTIM1A_DHO(regs->hbw));
+	}
+}
+
+static void update_col_registers(enum mcde_chnl chnl_id, struct col_regs *regs)
+{
+	u8 idx = chnl_id;
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+	mcde_wreg(MCDE_RGBCONV1A + idx * MCDE_RGBCONV1A_GROUPOFFSET,
+				MCDE_RGBCONV1A_YR_RED(regs->y_red) |
+				MCDE_RGBCONV1A_YR_GREEN(regs->y_green));
+	mcde_wreg(MCDE_RGBCONV2A + idx * MCDE_RGBCONV2A_GROUPOFFSET,
+				MCDE_RGBCONV2A_YR_BLUE(regs->y_blue) |
+				MCDE_RGBCONV2A_CR_RED(regs->cr_red));
+	mcde_wreg(MCDE_RGBCONV3A + idx * MCDE_RGBCONV3A_GROUPOFFSET,
+				MCDE_RGBCONV3A_CR_GREEN(regs->cr_green) |
+				MCDE_RGBCONV3A_CR_BLUE(regs->cr_blue));
+	mcde_wreg(MCDE_RGBCONV4A + idx * MCDE_RGBCONV4A_GROUPOFFSET,
+				MCDE_RGBCONV4A_CB_RED(regs->cb_red) |
+				MCDE_RGBCONV4A_CB_GREEN(regs->cb_green));
+	mcde_wreg(MCDE_RGBCONV5A + idx * MCDE_RGBCONV5A_GROUPOFFSET,
+				MCDE_RGBCONV5A_CB_BLUE(regs->cb_blue) |
+				MCDE_RGBCONV5A_OFF_RED(regs->off_red));
+	mcde_wreg(MCDE_RGBCONV6A + idx * MCDE_RGBCONV6A_GROUPOFFSET,
+				MCDE_RGBCONV6A_OFF_GREEN(regs->off_green) |
+				MCDE_RGBCONV6A_OFF_BLUE(regs->off_blue));
+}
+
+/* MCDE internal helpers */
+static u8 portfmt2dsipacking(enum mcde_port_pix_fmt pix_fmt)
+{
+	switch (pix_fmt) {
+	case MCDE_PORTPIXFMT_DSI_16BPP:
+		return MCDE_DSIVID0CONF0_PACKING_RGB565;
+	case MCDE_PORTPIXFMT_DSI_18BPP_PACKED:
+		return MCDE_DSIVID0CONF0_PACKING_RGB666;
+	case MCDE_PORTPIXFMT_DSI_18BPP:
+	case MCDE_PORTPIXFMT_DSI_24BPP:
+	default:
+		return MCDE_DSIVID0CONF0_PACKING_RGB888;
+	case MCDE_PORTPIXFMT_DSI_YCBCR422:
+		return MCDE_DSIVID0CONF0_PACKING_HDTV;
+	}
+}
+
+static u8 portfmt2bpp(enum mcde_port_pix_fmt pix_fmt)
+{
+	/* TODO: Check DPI spec *//* REVIEW: Remove or check */
+	switch (pix_fmt) {
+	case MCDE_PORTPIXFMT_DPI_16BPP_C1:
+	case MCDE_PORTPIXFMT_DPI_16BPP_C2:
+	case MCDE_PORTPIXFMT_DPI_16BPP_C3:
+	case MCDE_PORTPIXFMT_DSI_16BPP:
+	case MCDE_PORTPIXFMT_DSI_YCBCR422:
+		return 16;
+	case MCDE_PORTPIXFMT_DPI_18BPP_C1:
+	case MCDE_PORTPIXFMT_DPI_18BPP_C2:
+	case MCDE_PORTPIXFMT_DSI_18BPP_PACKED:
+		return 18;
+	case MCDE_PORTPIXFMT_DSI_18BPP:
+	case MCDE_PORTPIXFMT_DPI_24BPP:
+	case MCDE_PORTPIXFMT_DSI_24BPP:
+		return 24;
+	default:
+		return 1;
+	}
+}
+
+static u8 bpp2outbpp(u8 bpp)
+{
+	/* TODO: Check DPI spec *//* REVIEW: Remove or check */
+	switch (bpp) {
+	case 16:
+		return MCDE_CRA1_OUTBPP_16BPP;
+	case 18:
+		return MCDE_CRA1_OUTBPP_18BPP;
+	case 24:
+		return MCDE_CRA1_OUTBPP_24BPP;
+	default:
+		return 0;
+	}
+}
+
+static u32 get_output_fifo_size(enum mcde_fifo fifo)
+{
+	u32 ret = 1; /* Avoid div by zero */
+
+	switch (fifo) {
+	case MCDE_FIFO_A:
+	case MCDE_FIFO_B:
+		ret = MCDE_FIFO_AB_SIZE;
+		break;
+	case MCDE_FIFO_C0:
+	case MCDE_FIFO_C1:
+		ret = MCDE_FIFO_C0C1_SIZE;
+		break;
+	default:
+		dev_vdbg(&mcde_dev->dev, "Unsupported fifo");
+		break;
+	}
+	return ret;
+}
+
+static u8 get_dsi_formid(const struct mcde_port *port)
+{
+	if (port->ifc == DSI_VIDEO_MODE && port->link == 0)
+		return MCDE_CTRLA_FORMID_DSI0VID;
+	else if (port->ifc == DSI_VIDEO_MODE && port->link == 1)
+		return MCDE_CTRLA_FORMID_DSI1VID;
+	else if (port->ifc == DSI_VIDEO_MODE && port->link == 2)
+		return MCDE_CTRLA_FORMID_DSI2VID;
+	else if (port->ifc == DSI_CMD_MODE && port->link == 0)
+		return MCDE_CTRLA_FORMID_DSI0CMD;
+	else if (port->ifc == DSI_CMD_MODE && port->link == 1)
+		return MCDE_CTRLA_FORMID_DSI1CMD;
+	else if (port->ifc == DSI_CMD_MODE && port->link == 2)
+		return MCDE_CTRLA_FORMID_DSI2CMD;
+	return 0;
+}
+
+static struct mcde_chnl_state *find_channel_by_dsilink(int link)
+{
+	struct mcde_chnl_state *chnl = &channels[0];
+	for (; chnl < &channels[ARRAY_SIZE(channels)]; chnl++)
+		if (chnl->inuse && chnl->port.link == link &&
+					chnl->port.type == MCDE_PORTTYPE_DSI)
+			return chnl;
+	return NULL;
+}
+
+static irqreturn_t mcde_irq_handler(int irq, void *dev)
+{
+	int i;
+	u32 irq_status;
+	bool trig = false;
+	struct mcde_chnl_state *chnl;
+
+	/* Handle overlay irqs */
+	irq_status = mcde_rfld(MCDE_RISOVL, OVLFDRIS);
+	for (i = 0; i < ARRAY_SIZE(overlays); i++) {
+		if (irq_status & (1 << i)) {
+			struct mcde_ovly_state *ovly = &overlays[i];
+			ovly->transactionid_hw = ovly->transactionid_regs;
+			wake_up(&ovly->waitq_hw);
+		}
+	}
+	mcde_wfld(MCDE_RISOVL, OVLFDRIS, irq_status);
+
+	/* Handle channel irqs */
+	irq_status = mcde_rreg(MCDE_RISPP);
+	if (irq_status & MCDE_RISPP_VCMPARIS_MASK) {
+		chnl = &channels[MCDE_CHNL_A];
+		chnl->transactionid_hw = chnl->transactionid_regs;
+		wake_up(&chnl->waitq_hw);
+		mcde_wfld(MCDE_RISPP, VCMPARIS, 1);
+		if (chnl->port.update_auto_trig &&
+				chnl->port.sync_src == MCDE_SYNCSRC_OFF &&
+				chnl->port.type == MCDE_PORTTYPE_DSI &&
+				chnl->continous_running) {
+			mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl->id * MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+			mod_timer(&chnl->auto_sync_timer,
+				jiffies +
+				msecs_to_jiffies(MCDE_AUTO_SYNC_WATCHDOG
+								* 1000));
+		}
+	}
+	if (irq_status & MCDE_RISPP_VCMPBRIS_MASK) {
+		chnl = &channels[MCDE_CHNL_B];
+		chnl->transactionid_hw = chnl->transactionid_regs;
+		wake_up(&chnl->waitq_hw);
+		mcde_wfld(MCDE_RISPP, VCMPBRIS, 1);
+		if (chnl->port.update_auto_trig &&
+				chnl->port.sync_src == MCDE_SYNCSRC_OFF &&
+				chnl->port.type == MCDE_PORTTYPE_DSI &&
+				chnl->continous_running) {
+			mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl->id * MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+			mod_timer(&chnl->auto_sync_timer,
+				jiffies +
+				msecs_to_jiffies(MCDE_AUTO_SYNC_WATCHDOG
+								* 1000));
+		}
+	}
+	if (irq_status & MCDE_RISPP_VCMPC0RIS_MASK) {
+		chnl = &channels[MCDE_CHNL_C0];
+		chnl->transactionid_hw = chnl->transactionid_regs;
+		wake_up(&chnl->waitq_hw);
+		mcde_wfld(MCDE_RISPP, VCMPC0RIS, 1);
+		if (chnl->port.update_auto_trig &&
+				chnl->port.sync_src == MCDE_SYNCSRC_OFF &&
+				chnl->port.type == MCDE_PORTTYPE_DSI &&
+				chnl->continous_running) {
+			mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl->id * MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+			mod_timer(&chnl->auto_sync_timer,
+				jiffies +
+				msecs_to_jiffies(MCDE_AUTO_SYNC_WATCHDOG
+								* 1000));
+		}
+	}
+	if (irq_status & MCDE_RISPP_VCMPC1RIS_MASK) {
+		chnl = &channels[MCDE_CHNL_C1];
+		chnl->transactionid_hw = chnl->transactionid_regs;
+		wake_up(&chnl->waitq_hw);
+		mcde_wfld(MCDE_RISPP, VCMPC1RIS, 1);
+		if (chnl->port.update_auto_trig &&
+				chnl->port.sync_src == MCDE_SYNCSRC_OFF &&
+				chnl->port.type == MCDE_PORTTYPE_DSI &&
+				chnl->continous_running) {
+			mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl->id * MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+			mod_timer(&chnl->auto_sync_timer,
+				jiffies +
+				msecs_to_jiffies(MCDE_AUTO_SYNC_WATCHDOG
+								* 1000));
+		}
+	}
+	for (i = 0; i < num_dsilinks; i++) {
+		struct mcde_chnl_state *chnl_from_dsi;
+
+		trig = false;
+		irq_status = dsi_rfld(i, DSI_DIRECT_CMD_STS_FLAG,
+			TE_RECEIVED_FLAG);
+		if (irq_status) {
+			trig = true;
+			dsi_wreg(i, DSI_DIRECT_CMD_STS_CLR,
+				DSI_DIRECT_CMD_STS_CLR_TE_RECEIVED_CLR(true));
+			dev_vdbg(&mcde_dev->dev, "BTA TE DSI%d\n", i);
+		}
+		irq_status = dsi_rfld(i, DSI_CMD_MODE_STS_FLAG, ERR_NO_TE_FLAG);
+		if (irq_status) {
+			dsi_wreg(i, DSI_CMD_MODE_STS_CLR,
+				DSI_CMD_MODE_STS_CLR_ERR_NO_TE_CLR(true));
+			dev_info(&mcde_dev->dev, "NO_TE DSI%d\n", i);
+		}
+		if (!trig)
+			continue;
+		chnl_from_dsi = find_channel_by_dsilink(i);
+		if (chnl_from_dsi) {
+			mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl_from_dsi->id *
+				MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+			dev_vdbg(&mcde_dev->dev, "SW TRIG DSI%d, chnl=%d\n", i,
+				chnl_from_dsi->id);
+			/*
+			* This comment is valid for hardware_version ==
+			* MCDE_CHIP_VERSION_3_0_8.
+			*
+			* If you disable after the last frame you triggered has
+			* finished. The output formatter
+			* (at least DSI is working like this) is waiting for a
+			* new frame that will never come, and then the FLOEN
+			* will stay at 1. To avoid this, you have to always
+			* disable just after your last trig, before receiving
+			* VCOMP interrupt (= before the last triggered frame
+			* is finished).
+			*/
+			if (hardware_version == MCDE_CHIP_VERSION_3_0_8)
+				channel_flow_disable(chnl_from_dsi);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+void wait_for_overlay(struct mcde_ovly_state *ovly)
+{
+	int ret;
+
+	ret = wait_event_timeout(ovly->waitq_hw,
+		ovly->transactionid_hw == ovly->transactionid_regs,
+		msecs_to_jiffies(OVLY_TIMEOUT));
+	if (!ret)
+		dev_warn(&mcde_dev->dev,
+			"Wait for overlay timeout (ovly=%d,%d<%d)!\n",
+			ovly->idx, ovly->transactionid_hw,
+			ovly->transactionid_regs);
+}
+
+void wait_for_channel(struct mcde_chnl_state *chnl)
+{
+	int ret;
+
+	ret = wait_event_timeout(chnl->waitq_hw,
+		chnl->transactionid_hw == chnl->transactionid_regs,
+		msecs_to_jiffies(CHNL_TIMEOUT));
+	if (!ret)
+		dev_warn(&mcde_dev->dev,
+			"Wait for channel timeout (chnl=%d,%d<%d)!\n",
+			chnl->id, chnl->transactionid_hw,
+			chnl->transactionid_regs);
+}
+
+static int update_channel_static_registers(struct mcde_chnl_state *chnl)
+{
+	const struct chnl_config *cfg = chnl->cfg;
+	const struct mcde_port *port = &chnl->port;
+
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_5) {
+		/* Fifo & muxing */
+		if (cfg->swap_a_c0_set)
+			mcde_wfld(MCDE_CONF0, SWAP_A_C0_V1, cfg->swap_a_c0);
+		if (cfg->swap_b_c1_set)
+			mcde_wfld(MCDE_CONF0, SWAP_B_C1_V1, cfg->swap_b_c1);
+		if (cfg->fabmux_set)
+			mcde_wfld(MCDE_CR, FABMUX_V1, cfg->fabmux);
+		if (cfg->f01mux_set)
+			mcde_wfld(MCDE_CR, F01MUX_V1, cfg->f01mux);
+
+		if (port->type == MCDE_PORTTYPE_DPI) {
+			if (port->link == 0)
+				mcde_wfld(MCDE_CR, DPIA_EN_V1, true);
+			else if (port->link == 1)
+				mcde_wfld(MCDE_CR, DPIB_EN_V1, true);
+		} else if (port->type == MCDE_PORTTYPE_DSI) {
+			if (port->ifc == DSI_VIDEO_MODE && port->link == 0)
+				mcde_wfld(MCDE_CR, DSIVID0_EN_V1, true);
+			else if (port->ifc == DSI_VIDEO_MODE && port->link == 1)
+				mcde_wfld(MCDE_CR, DSIVID1_EN_V1, true);
+			else if (port->ifc == DSI_VIDEO_MODE && port->link == 2)
+				mcde_wfld(MCDE_CR, DSIVID2_EN_V1, true);
+			else if (port->ifc == DSI_CMD_MODE && port->link == 0)
+				mcde_wfld(MCDE_CR, DSICMD0_EN_V1, true);
+			else if (port->ifc == DSI_CMD_MODE && port->link == 1)
+				mcde_wfld(MCDE_CR, DSICMD1_EN_V1, true);
+			else if (port->ifc == DSI_CMD_MODE && port->link == 2)
+				mcde_wfld(MCDE_CR, DSICMD2_EN_V1, true);
+		}
+
+		if (chnl->fifo == MCDE_FIFO_C0)
+			mcde_wreg(MCDE_CTRLC0, MCDE_CTRLC0_FIFOWTRMRK(
+					get_output_fifo_size(MCDE_FIFO_C0)));
+		else if (chnl->fifo == MCDE_FIFO_C1)
+			mcde_wreg(MCDE_CTRLC1, MCDE_CTRLC1_FIFOWTRMRK(
+					get_output_fifo_size(MCDE_FIFO_C1)));
+		else if (port->update_auto_trig &&
+					(port->sync_src == MCDE_SYNCSRC_TE0))
+			mcde_wreg(MCDE_CTRLC0, MCDE_CTRLC0_FIFOWTRMRK(
+					get_output_fifo_size(MCDE_FIFO_C0)));
+		else if (port->update_auto_trig &&
+					(port->sync_src == MCDE_SYNCSRC_TE1))
+			mcde_wreg(MCDE_CTRLC1, MCDE_CTRLC1_FIFOWTRMRK(
+					get_output_fifo_size(MCDE_FIFO_C1)));
+	} else {
+
+		switch (chnl->fifo) {
+		case MCDE_FIFO_A:
+			mcde_wreg(MCDE_CHNL0MUXING_V2 + chnl->id *
+				MCDE_CHNL0MUXING_V2_GROUPOFFSET,
+				MCDE_CHNL0MUXING_V2_FIFO_ID_ENUM(FIFO_A));
+			if (port->type == MCDE_PORTTYPE_DPI) {
+				mcde_wfld(MCDE_CTRLA, FORMTYPE,
+						MCDE_CTRLA_FORMTYPE_DPITV);
+				mcde_wfld(MCDE_CTRLA, FORMID, port->link);
+				mcde_wfld(MCDE_CTRLA, FIFOWTRMRK,
+					get_output_fifo_size(MCDE_FIFO_A));
+			} else if (port->type == MCDE_PORTTYPE_DSI) {
+				mcde_wfld(MCDE_CTRLA, FORMTYPE,
+						MCDE_CTRLA_FORMTYPE_DSI);
+				mcde_wfld(MCDE_CTRLA, FORMID,
+							get_dsi_formid(port));
+				mcde_wfld(MCDE_CTRLA, FIFOWTRMRK,
+					get_output_fifo_size(MCDE_FIFO_A));
+			}
+			break;
+		case MCDE_FIFO_B:
+			mcde_wreg(MCDE_CHNL0MUXING_V2 + chnl->id *
+				MCDE_CHNL0MUXING_V2_GROUPOFFSET,
+				MCDE_CHNL0MUXING_V2_FIFO_ID_ENUM(FIFO_B));
+			if (port->type == MCDE_PORTTYPE_DPI) {
+				mcde_wfld(MCDE_CTRLB, FORMTYPE,
+						MCDE_CTRLB_FORMTYPE_DPITV);
+				mcde_wfld(MCDE_CTRLB, FORMID, port->link);
+				mcde_wfld(MCDE_CTRLB, FIFOWTRMRK,
+					get_output_fifo_size(MCDE_FIFO_B));
+			} else if (port->type == MCDE_PORTTYPE_DSI) {
+				mcde_wfld(MCDE_CTRLB, FORMTYPE,
+						MCDE_CTRLB_FORMTYPE_DSI);
+				mcde_wfld(MCDE_CTRLB, FORMID,
+							get_dsi_formid(port));
+				mcde_wfld(MCDE_CTRLB, FIFOWTRMRK,
+					get_output_fifo_size(MCDE_FIFO_B));
+			}
+
+			break;
+		case MCDE_FIFO_C0:
+			mcde_wreg(MCDE_CHNL0MUXING_V2 + chnl->id *
+				MCDE_CHNL0MUXING_V2_GROUPOFFSET,
+				MCDE_CHNL0MUXING_V2_FIFO_ID_ENUM(FIFO_C0));
+			if (port->type == MCDE_PORTTYPE_DPI)
+				return -EINVAL;
+			mcde_wfld(MCDE_CTRLC0, FORMTYPE,
+						MCDE_CTRLC0_FORMTYPE_DSI);
+			mcde_wfld(MCDE_CTRLC0, FORMID, get_dsi_formid(port));
+			mcde_wfld(MCDE_CTRLC0, FIFOWTRMRK,
+					get_output_fifo_size(MCDE_FIFO_C0));
+			break;
+		case MCDE_FIFO_C1:
+			mcde_wreg(MCDE_CHNL0MUXING_V2 + chnl->id *
+				MCDE_CHNL0MUXING_V2_GROUPOFFSET,
+				MCDE_CHNL0MUXING_V2_FIFO_ID_ENUM(FIFO_C1));
+			if (port->type == MCDE_PORTTYPE_DPI)
+				return -EINVAL;
+			mcde_wfld(MCDE_CTRLC1, FORMTYPE,
+						MCDE_CTRLC1_FORMTYPE_DSI);
+			mcde_wfld(MCDE_CTRLC1, FORMID, get_dsi_formid(port));
+			mcde_wfld(MCDE_CTRLC1, FIFOWTRMRK,
+					get_output_fifo_size(MCDE_FIFO_C1));
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* Formatter */
+	if (port->type == MCDE_PORTTYPE_DSI) {
+		int i = 0;
+		u8 idx = 2 * port->link + port->ifc;
+		u8 lnk = port->link;
+
+		dsi_wfld(lnk, DSI_MCTL_MAIN_DATA_CTL, LINK_EN, true);
+		dsi_wfld(lnk, DSI_MCTL_MAIN_DATA_CTL, BTA_EN, true);
+		dsi_wfld(lnk, DSI_MCTL_MAIN_DATA_CTL, READ_EN, true);
+		dsi_wfld(lnk, DSI_MCTL_MAIN_DATA_CTL, REG_TE_EN, true);
+		dsi_wreg(lnk, DSI_MCTL_DPHY_STATIC,
+			DSI_MCTL_DPHY_STATIC_UI_X4(port->phy.dsi.ui));
+		dsi_wreg(lnk, DSI_DPHY_LANES_TRIM,
+			DSI_DPHY_LANES_TRIM_DPHY_SPECS_90_81B_ENUM(0_90));
+		dsi_wreg(lnk, DSI_MCTL_DPHY_TIMEOUT,
+			DSI_MCTL_DPHY_TIMEOUT_CLK_DIV(0xf) |
+			DSI_MCTL_DPHY_TIMEOUT_HSTX_TO_VAL(0x3fff) |
+			DSI_MCTL_DPHY_TIMEOUT_LPRX_TO_VAL(0x3fff));
+		dsi_wreg(lnk, DSI_MCTL_MAIN_PHY_CTL,
+			DSI_MCTL_MAIN_PHY_CTL_WAIT_BURST_TIME(0xf) |
+			DSI_MCTL_MAIN_PHY_CTL_LANE2_EN(true) |
+			DSI_MCTL_MAIN_PHY_CTL_CLK_CONTINUOUS(
+				port->phy.dsi.clk_cont));
+		dsi_wreg(lnk, DSI_MCTL_ULPOUT_TIME,
+			DSI_MCTL_ULPOUT_TIME_CKLANE_ULPOUT_TIME(1) |
+			DSI_MCTL_ULPOUT_TIME_DATA_ULPOUT_TIME(1));
+		/* TODO: make enum */
+		dsi_wfld(lnk, DSI_CMD_MODE_CTL, ARB_MODE, false);
+		/* TODO: make enum */
+		dsi_wfld(lnk, DSI_CMD_MODE_CTL, ARB_PRI, port->ifc == 1);
+		dsi_wreg(lnk, DSI_MCTL_MAIN_EN,
+			DSI_MCTL_MAIN_EN_PLL_START(true) |
+			DSI_MCTL_MAIN_EN_CKLANE_EN(true) |
+			DSI_MCTL_MAIN_EN_DAT1_EN(true) |
+			DSI_MCTL_MAIN_EN_DAT2_EN(port->phy.dsi.num_data_lanes
+				== 2) |
+			DSI_MCTL_MAIN_EN_IF1_EN(port->ifc == 0) |
+			DSI_MCTL_MAIN_EN_IF2_EN(port->ifc == 1));
+		while (dsi_rfld(lnk, DSI_MCTL_MAIN_STS, CLKLANE_READY) == 0 ||
+		       dsi_rfld(lnk, DSI_MCTL_MAIN_STS, DAT1_READY) == 0 ||
+		       dsi_rfld(lnk, DSI_MCTL_MAIN_STS, DAT2_READY) == 0) {
+			mdelay(1);
+			if (i++ == 10) {
+				dev_warn(&mcde_dev->dev,
+					"DSI lane not ready (link=%d)!\n", lnk);
+				return -EINVAL;
+			}
+		}
+
+		mcde_wreg(MCDE_DSIVID0CONF0 +
+			idx * MCDE_DSIVID0CONF0_GROUPOFFSET,
+			MCDE_DSIVID0CONF0_BLANKING(0) |
+			MCDE_DSIVID0CONF0_VID_MODE(
+				port->mode == MCDE_PORTMODE_VID) |
+			MCDE_DSIVID0CONF0_CMD8(true) |
+			MCDE_DSIVID0CONF0_BIT_SWAP(false) |
+			MCDE_DSIVID0CONF0_BYTE_SWAP(false) |
+			MCDE_DSIVID0CONF0_DCSVID_NOTGEN(true));
+
+		if (port->mode == MCDE_PORTMODE_CMD) {
+			if (port->ifc == DSI_VIDEO_MODE)
+				dsi_wfld(port->link, DSI_CMD_MODE_CTL, IF1_ID,
+					port->phy.dsi.virt_id);
+			else if (port->ifc == DSI_CMD_MODE)
+				dsi_wfld(port->link, DSI_CMD_MODE_CTL, IF2_ID,
+					port->phy.dsi.virt_id);
+		}
+	}
+
+	mcde_wfld(MCDE_CR, MCDEEN, true);
+
+	dev_vdbg(&mcde_dev->dev, "Static registers setup, chnl=%d\n", chnl->id);
+
+	return 0;
+}
+
+/* REVIEW: Make update_* an mcde_rectangle? */
+static void update_overlay_registers(u8 idx, struct ovly_regs *regs,
+			struct mcde_port *port, enum mcde_fifo fifo,
+			u16 update_x, u16 update_y, u16 update_w,
+			u16 update_h, u16 stride, bool interlaced)
+{
+	/* TODO: fix clipping for small overlay */
+	u32 lmrgn = (regs->cropx + update_x) * regs->bits_per_pixel;
+	u32 tmrgn = (regs->cropy + update_y) * stride;
+	u32 ppl = regs->ppl - update_x;
+	u32 lpf = regs->lpf - update_y;
+	u32 ljinc = stride;
+	u32 pixelfetchwtrmrklevel;
+	u8  nr_of_bufs = 1;
+	u32 fifo_size;
+
+	/* TODO: disable if everything clipped */
+	if (!regs->enabled) {
+		u32 temp;
+		temp = mcde_rreg(MCDE_OVL0CR + idx * MCDE_OVL0CR_GROUPOFFSET);
+		mcde_wreg(MCDE_OVL0CR + idx * MCDE_OVL0CR_GROUPOFFSET,
+			(temp & ~MCDE_OVL0CR_OVLEN_MASK) |
+			MCDE_OVL0CR_OVLEN(false));
+		return;
+	}
+
+	/*
+	* TODO: Preferably most of this is done in some apply function instead
+	* of every update. Problem is however that at overlay apply
+	* there is no port type info available (and the question is
+	* whether it is appropriate to add a port type there).
+	* Note that lpf has a dependency on update_y.
+	*/
+	if (port->type == MCDE_PORTTYPE_DPI)
+		/* REVIEW: Why not for DSI? enable in regs? */
+		regs->col_conv = MCDE_OVL0CR_COLCCTRL_ENABLED_NO_SAT;
+	else if (port->type == MCDE_PORTTYPE_DSI) {
+		if (port->pixel_format == MCDE_PORTPIXFMT_DSI_YCBCR422)
+			regs->col_conv = MCDE_OVL0CR_COLCCTRL_ENABLED_NO_SAT;
+		else
+			regs->col_conv = MCDE_OVL0CR_COLCCTRL_DISABLED;
+		if (interlaced) {
+			nr_of_bufs = 2;
+			lpf = lpf / 2;
+			ljinc *= 2;
+		}
+	}
+
+	fifo_size = get_output_fifo_size(fifo);
+#ifdef CONFIG_AV8100_SDTV
+	/* TODO: check if these watermark levels work for HDMI as well. */
+	pixelfetchwtrmrklevel = MCDE_PIXFETCH_SMALL_WTRMRKLVL;
+#else
+	if ((fifo == MCDE_FIFO_A || fifo == MCDE_FIFO_B) &&
+					regs->ppl >= fifo_size * 2)
+		pixelfetchwtrmrklevel = MCDE_PIXFETCH_LARGE_WTRMRKLVL;
+	else
+		pixelfetchwtrmrklevel = MCDE_PIXFETCH_MEDIUM_WTRMRKLVL;
+#endif /* CONFIG_AV8100_SDTV */
+
+	if (regs->reset_buf_id) {
+		u32 sel_mod = MCDE_EXTSRC0CR_SEL_MOD_SOFTWARE_SEL;
+		if (port->update_auto_trig && port->type == MCDE_PORTTYPE_DSI) {
+			switch (port->sync_src) {
+			case MCDE_SYNCSRC_OFF:
+				sel_mod = MCDE_EXTSRC0CR_SEL_MOD_SOFTWARE_SEL;
+				break;
+			case MCDE_SYNCSRC_TE0:
+			case MCDE_SYNCSRC_TE1:
+			default:
+				sel_mod = MCDE_EXTSRC0CR_SEL_MOD_AUTO_TOGGLE;
+			}
+		} else if (port->type == MCDE_PORTTYPE_DPI) {
+			sel_mod = port->update_auto_trig ?
+					MCDE_EXTSRC0CR_SEL_MOD_AUTO_TOGGLE :
+					MCDE_EXTSRC0CR_SEL_MOD_SOFTWARE_SEL;
+		}
+
+		regs->reset_buf_id = false;
+		mcde_wreg(MCDE_EXTSRC0CONF + idx * MCDE_EXTSRC0CONF_GROUPOFFSET,
+			MCDE_EXTSRC0CONF_BUF_ID(0) |
+			MCDE_EXTSRC0CONF_BUF_NB(nr_of_bufs) |
+			MCDE_EXTSRC0CONF_PRI_OVLID(idx) |
+			MCDE_EXTSRC0CONF_BPP(regs->bpp) |
+			MCDE_EXTSRC0CONF_BGR(regs->bgr) |
+			MCDE_EXTSRC0CONF_BEBO(regs->bebo) |
+			MCDE_EXTSRC0CONF_BEPO(false));
+		mcde_wreg(MCDE_EXTSRC0CR + idx * MCDE_EXTSRC0CR_GROUPOFFSET,
+			MCDE_EXTSRC0CR_SEL_MOD(sel_mod) |
+			MCDE_EXTSRC0CR_MULTIOVL_CTRL_ENUM(PRIMARY) |
+			MCDE_EXTSRC0CR_FS_DIV_DISABLE(false) |
+			MCDE_EXTSRC0CR_FORCE_FS_DIV(false));
+		mcde_wreg(MCDE_OVL0CR + idx * MCDE_OVL0CR_GROUPOFFSET,
+			MCDE_OVL0CR_OVLEN(true) |
+		MCDE_OVL0CR_COLCCTRL(regs->col_conv) |
+			MCDE_OVL0CR_CKEYGEN(false) |
+			MCDE_OVL0CR_ALPHAPMEN(true) |
+			MCDE_OVL0CR_OVLF(false) |
+			MCDE_OVL0CR_OVLR(false) |
+			MCDE_OVL0CR_OVLB(false) |
+			MCDE_OVL0CR_FETCH_ROPC(0) |
+			MCDE_OVL0CR_STBPRIO(0) |
+			MCDE_OVL0CR_BURSTSIZE_ENUM(HW_8W) |
+			/* TODO: enum, get from ovly */
+			MCDE_OVL0CR_MAXOUTSTANDING_ENUM(4_REQ) |
+			/* TODO: _HW_8W, calculate? */
+			MCDE_OVL0CR_ROTBURSTSIZE_ENUM(HW_8W));
+		mcde_wreg(MCDE_OVL0CONF + idx * MCDE_OVL0CONF_GROUPOFFSET,
+			MCDE_OVL0CONF_PPL(ppl) |
+			MCDE_OVL0CONF_EXTSRC_ID(idx) |
+			MCDE_OVL0CONF_LPF(lpf));
+		mcde_wreg(MCDE_OVL0CONF2 + idx * MCDE_OVL0CONF2_GROUPOFFSET,
+			MCDE_OVL0CONF2_BP_ENUM(PER_PIXEL_ALPHA) |
+			/* TODO: Allow setting? */
+			MCDE_OVL0CONF2_ALPHAVALUE(0xff) |
+			MCDE_OVL0CONF2_OPQ(regs->opq) |
+			MCDE_OVL0CONF2_PIXOFF(lmrgn & 63) |
+			MCDE_OVL0CONF2_PIXELFETCHERWATERMARKLEVEL(
+				pixelfetchwtrmrklevel));
+		mcde_wreg(MCDE_OVL0LJINC + idx * MCDE_OVL0LJINC_GROUPOFFSET,
+			ljinc);
+		mcde_wreg(MCDE_OVL0CROP + idx * MCDE_OVL0CROP_GROUPOFFSET,
+			MCDE_OVL0CROP_TMRGN(tmrgn) |
+			MCDE_OVL0CROP_LMRGN(lmrgn >> 6));
+		mcde_wreg(MCDE_OVL0COMP + idx * MCDE_OVL0COMP_GROUPOFFSET,
+			MCDE_OVL0COMP_XPOS(regs->xpos) |
+			MCDE_OVL0COMP_CH_ID(regs->ch_id) |
+			MCDE_OVL0COMP_YPOS(regs->ypos) |
+			MCDE_OVL0COMP_Z(regs->z));
+	}
+
+	dev_vdbg(&mcde_dev->dev, "Overlay registers setup, idx=%d\n", idx);
+}
+
+static void update_overlay_address_registers(u8 idx, struct ovly_regs *regs)
+{
+	mcde_wreg(MCDE_EXTSRC0A0 + idx * MCDE_EXTSRC0A0_GROUPOFFSET,
+		regs->baseaddress0);
+	mcde_wreg(MCDE_EXTSRC0A1 + idx * MCDE_EXTSRC0A1_GROUPOFFSET,
+		regs->baseaddress1);
+}
+
+#define MCDE_FLOWEN_MAX_TRIAL	6
+
+static void disable_channel(struct mcde_chnl_state *chnl)
+{
+	int i;
+	const struct mcde_port *port = &chnl->port;
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_8 &&
+				!is_channel_enabled(chnl)) {
+		chnl->continous_running = false;
+		return;
+	}
+
+	if (port->type == MCDE_PORTTYPE_DSI)
+		dsi_wfld(port->link, DSI_MCTL_MAIN_PHY_CTL, CLK_CONTINUOUS,
+			false);
+
+	channel_pixelprocessing_disable(chnl);
+
+	channel_flow_disable(chnl);
+
+	wait_for_channel(chnl);
+
+	for (i = 0; i < MCDE_FLOWEN_MAX_TRIAL; i++) {
+		if (hardware_version == MCDE_CHIP_VERSION_3_0_5)
+			msleep(1);
+		if (!is_channel_enabled(chnl)) {
+			dev_vdbg(&mcde_dev->dev,
+				"%s: Flow %d after >= %d ms\n"
+						, __func__, chnl->id, i);
+			chnl->continous_running = false;
+			return;
+		}
+		if (hardware_version == MCDE_CHIP_VERSION_3_0_8)
+			msleep(5);
+	}
+	/*
+	* For MCDE 3.0.5.8 and forward if this occurs the last frame
+	* is still in progress then reconsider the delay and the
+	* MAX_TRAIL value to match the refresh rate of the display
+	*/
+	dev_warn(&mcde_dev->dev, "%s: Flow %d timeout\n"
+						, __func__, chnl->id);
+}
+static void enable_channel(struct mcde_chnl_state *chnl)
+{
+	const struct mcde_port *port = &chnl->port;
+	int i;
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	if (port->type == MCDE_PORTTYPE_DSI)
+		dsi_wfld(port->link, DSI_MCTL_MAIN_PHY_CTL, CLK_CONTINUOUS,
+				port->phy.dsi.clk_cont);
+
+	channel_flow_enable(chnl);
+
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_8) {
+		for (i = 0; i < MCDE_FLOWEN_MAX_TRIAL; i++) {
+			if (is_channel_enabled(chnl)) {
+				dev_vdbg(&mcde_dev->dev,
+				"Flow %d enable after >= %d ms\n"
+							, chnl->id, i*5);
+				return;
+			}
+			msleep(5);
+		}
+		dev_warn(&mcde_dev->dev, "%s: channel %d timeout\n",
+							__func__, chnl->id);
+	}
+}
+#undef MCDE_FLOWEN_MAX_TRIAL
+
+static void watchdog_auto_sync_timer_function(unsigned long arg)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(channels); i++) {
+		struct mcde_chnl_state *chnl = &channels[i];
+		if (chnl->port.update_auto_trig &&
+				chnl->port.sync_src == MCDE_SYNCSRC_OFF &&
+				chnl->port.type == MCDE_PORTTYPE_DSI &&
+				chnl->continous_running) {
+			mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl->id
+				* MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+			mod_timer(&chnl->auto_sync_timer,
+				jiffies +
+				msecs_to_jiffies(MCDE_AUTO_SYNC_WATCHDOG
+								* 1000));
+		}
+	}
+}
+
+/* TODO get from register */
+#define MCDE_CLK_FREQ_MHZ 160
+
+void update_channel_registers(enum mcde_chnl chnl_id, struct chnl_regs *regs,
+				struct mcde_port *port, enum mcde_fifo fifo,
+				struct mcde_video_mode *video_mode)
+{
+	u8 idx = chnl_id;
+	u32 out_synch_src = MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_FORMATTER;
+	u32 src_synch = MCDE_CHNL0SYNCHMOD_SRC_SYNCH_SOFTWARE;
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+	/* Channel */
+	if (port->update_auto_trig && port->type == MCDE_PORTTYPE_DSI) {
+		switch (port->sync_src) {
+		case MCDE_SYNCSRC_TE0:
+			out_synch_src = MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_VSYNC0;
+			src_synch = MCDE_CHNL0SYNCHMOD_SRC_SYNCH_OUTPUT;
+			break;
+		case MCDE_SYNCSRC_OFF:
+			src_synch = MCDE_CHNL0SYNCHMOD_SRC_SYNCH_SOFTWARE;
+			break;
+		case MCDE_SYNCSRC_TE1:
+		default:
+			out_synch_src = MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_VSYNC1;
+			src_synch = MCDE_CHNL0SYNCHMOD_SRC_SYNCH_OUTPUT;
+		}
+	} else if (port->type == MCDE_PORTTYPE_DPI) {
+		src_synch = port->update_auto_trig ?
+					MCDE_CHNL0SYNCHMOD_SRC_SYNCH_OUTPUT :
+					MCDE_CHNL0SYNCHMOD_SRC_SYNCH_SOFTWARE;
+	}
+
+	mcde_wreg(MCDE_CHNL0CONF + idx * MCDE_CHNL0CONF_GROUPOFFSET,
+		MCDE_CHNL0CONF_PPL(regs->ppl-1) |
+		MCDE_CHNL0CONF_LPF(regs->lpf-1));
+	mcde_wreg(MCDE_CHNL0STAT + idx * MCDE_CHNL0STAT_GROUPOFFSET,
+		MCDE_CHNL0STAT_CHNLBLBCKGND_EN(false) |
+		MCDE_CHNL0STAT_CHNLRD(true));
+	mcde_wreg(MCDE_CHNL0SYNCHMOD +
+		idx * MCDE_CHNL0SYNCHMOD_GROUPOFFSET,
+		MCDE_CHNL0SYNCHMOD_SRC_SYNCH(src_synch) |
+		MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC(out_synch_src));
+	mcde_wreg(MCDE_CHNL0BCKGNDCOL + idx * MCDE_CHNL0BCKGNDCOL_GROUPOFFSET,
+		MCDE_CHNL0BCKGNDCOL_B(0) |
+		MCDE_CHNL0BCKGNDCOL_G(0) |
+		MCDE_CHNL0BCKGNDCOL_R(0));
+
+	switch (chnl_id) {
+	case MCDE_CHNL_A:
+		if (port->type == MCDE_PORTTYPE_DPI) {
+			mcde_wreg(MCDE_CRA1,
+				MCDE_CRA1_CLKSEL_ENUM(EXT_TV1) |
+				MCDE_CRA1_OUTBPP(bpp2outbpp(regs->bpp)) |
+				MCDE_CRA1_BCD(1)
+			);
+		} else {
+			mcde_wreg(MCDE_CRA1, MCDE_CRA1_CLKSEL_ENUM(166MHZ));
+		}
+		break;
+	case MCDE_CHNL_B:
+		if (port->type == MCDE_PORTTYPE_DPI) {
+			mcde_wreg(MCDE_CRB1,
+				MCDE_CRB1_CLKSEL_ENUM(EXT_TV2) |
+				MCDE_CRB1_OUTBPP(bpp2outbpp(regs->bpp)) |
+				MCDE_CRB1_BCD(1)
+			);
+		} else {
+			mcde_wreg(MCDE_CRB1, MCDE_CRB1_CLKSEL_ENUM(166MHZ));
+		}
+		break;
+	default:
+		break;
+	}
+
+	/* Formatter */
+	if (port->type == MCDE_PORTTYPE_DSI) {
+		u8 fidx = 2 * port->link + port->ifc;
+		u32 temp, packet;
+		/* pkt_div is used to avoid underflow in output fifo for
+		 * large packets */
+		u32 pkt_div = 1;
+		u32 dsi_delay0 = 0;
+		u32 screen_ppl, screen_lpf;
+
+		screen_ppl = video_mode->xres;
+		screen_lpf = video_mode->yres;
+
+		if  (screen_ppl == 1920) {
+			pkt_div = (screen_ppl - 1) /
+			get_output_fifo_size(fifo) + 1;
+		} else {
+			pkt_div = screen_ppl /
+			(get_output_fifo_size(fifo) * 2) + 1;
+		}
+
+		if (video_mode->interlaced)
+			screen_lpf /= 2;
+
+		/* pkt_delay_progressive = pixelclock * htot /
+		 * (1E12 / 160E6) / pkt_div */
+		dsi_delay0 = (video_mode->pixclock + 1) *
+			(video_mode->xres + video_mode->hbp +
+				video_mode->hfp) /
+			(1000000 / MCDE_CLK_FREQ_MHZ) / pkt_div;
+		temp = mcde_rreg(MCDE_DSIVID0CONF0 +
+			fidx * MCDE_DSIVID0CONF0_GROUPOFFSET);
+		mcde_wreg(MCDE_DSIVID0CONF0 +
+			fidx * MCDE_DSIVID0CONF0_GROUPOFFSET,
+			(temp & ~MCDE_DSIVID0CONF0_PACKING_MASK) |
+			MCDE_DSIVID0CONF0_PACKING(regs->dsipacking));
+		/* 1==CMD8 */
+		packet = ((screen_ppl / pkt_div * regs->bpp) >> 3) + 1;
+		mcde_wreg(MCDE_DSIVID0FRAME +
+			fidx * MCDE_DSIVID0FRAME_GROUPOFFSET,
+			MCDE_DSIVID0FRAME_FRAME(packet * pkt_div * screen_lpf));
+		mcde_wreg(MCDE_DSIVID0PKT + fidx * MCDE_DSIVID0PKT_GROUPOFFSET,
+			MCDE_DSIVID0PKT_PACKET(packet));
+		mcde_wreg(MCDE_DSIVID0SYNC +
+			fidx * MCDE_DSIVID0SYNC_GROUPOFFSET,
+			MCDE_DSIVID0SYNC_SW(0) |
+			MCDE_DSIVID0SYNC_DMA(0));
+		mcde_wreg(MCDE_DSIVID0CMDW +
+			fidx * MCDE_DSIVID0CMDW_GROUPOFFSET,
+			MCDE_DSIVID0CMDW_CMDW_START(DCS_CMD_WRITE_START) |
+			MCDE_DSIVID0CMDW_CMDW_CONTINUE(DCS_CMD_WRITE_CONTINUE));
+		mcde_wreg(MCDE_DSIVID0DELAY0 +
+			fidx * MCDE_DSIVID0DELAY0_GROUPOFFSET,
+			MCDE_DSIVID0DELAY0_INTPKTDEL(dsi_delay0));
+		mcde_wreg(MCDE_DSIVID0DELAY1 +
+			fidx * MCDE_DSIVID0DELAY1_GROUPOFFSET,
+			MCDE_DSIVID0DELAY1_TEREQDEL(0) |
+			MCDE_DSIVID0DELAY1_FRAMESTARTDEL(0));
+	}
+
+	if (regs->roten) {
+		/* TODO: Allocate memory in ESRAM instead of
+				static allocations. */
+		mcde_wreg(MCDE_ROTADD0A + chnl_id * MCDE_ROTADD0A_GROUPOFFSET,
+			regs->rotbuf1);
+		mcde_wreg(MCDE_ROTADD1A + chnl_id * MCDE_ROTADD1A_GROUPOFFSET,
+			regs->rotbuf2);
+
+		mcde_wreg(MCDE_ROTACONF + chnl_id * MCDE_ROTACONF_GROUPOFFSET,
+			MCDE_ROTACONF_ROTBURSTSIZE_ENUM(8W) |
+			MCDE_ROTACONF_ROTBURSTSIZE_HW(1) |
+			MCDE_ROTACONF_ROTDIR(regs->rotdir) |
+			MCDE_ROTACONF_STRIP_WIDTH_ENUM(16PIX) |
+			MCDE_ROTACONF_RD_MAXOUT_ENUM(4_REQ) |
+			MCDE_ROTACONF_WR_MAXOUT_ENUM(8_REQ));
+		if (chnl_id == MCDE_CHNL_A) {
+			mcde_wfld(MCDE_CRA0, ROTEN, true);
+			mcde_wfld(MCDE_CRA1, CLKSEL, MCDE_CRA1_CLKSEL_166MHZ);
+			mcde_wfld(MCDE_CRA1, OUTBPP, bpp2outbpp(regs->bpp));
+			mcde_wfld(MCDE_CRA1, BCD, true);
+		} else if (chnl_id == MCDE_CHNL_B) {
+			mcde_wfld(MCDE_CRB0, ROTEN, true);
+			mcde_wfld(MCDE_CRB1, CLKSEL, MCDE_CRB1_CLKSEL_166MHZ);
+			mcde_wfld(MCDE_CRB1, OUTBPP, bpp2outbpp(regs->bpp));
+			mcde_wfld(MCDE_CRB1, BCD, true);
+		}
+	} else {
+		if (chnl_id == MCDE_CHNL_A)
+			mcde_wfld(MCDE_CRA0, ROTEN, false);
+		else if (chnl_id == MCDE_CHNL_B)
+			mcde_wfld(MCDE_CRB0, ROTEN, false);
+	}
+
+	dev_vdbg(&mcde_dev->dev, "Channel registers setup, chnl=%d\n", chnl_id);
+}
+
+/* DSI */
+
+int mcde_dsi_dcs_write(struct mcde_chnl_state *chnl, u8 cmd, u8* data, int len)
+{
+	int i;
+	u32 wrdat[4] = { 0, 0, 0, 0 };
+	u32 settings;
+	u8 link = chnl->port.link;
+	u8 virt_id = chnl->port.phy.dsi.virt_id;
+
+	/* REVIEW: One command at a time */
+	/* REVIEW: Allow read/write on unreserved ports */
+	if (len > MCDE_MAX_DCS_WRITE || chnl->port.type != MCDE_PORTTYPE_DSI)
+		return -EINVAL;
+
+	wrdat[0] = cmd;
+	for (i = 1; i <= len; i++)
+		wrdat[i>>2] |= ((u32)data[i-1] << ((i & 3) * 8));
+
+	settings = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_ENUM(WRITE) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT(len > 1) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID(virt_id) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE(len+1) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN(true);
+	if (len == 0)
+		settings |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_ENUM(
+			DCS_SHORT_WRITE_0);
+	else if (len == 1)
+		settings |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_ENUM(
+			DCS_SHORT_WRITE_1);
+	else
+		settings |= DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_ENUM(
+			DCS_LONG_WRITE);
+
+	dsi_wreg(link, DSI_DIRECT_CMD_MAIN_SETTINGS, settings);
+	dsi_wreg(link, DSI_DIRECT_CMD_WRDAT0, wrdat[0]);
+	if (len >  3)
+		dsi_wreg(link, DSI_DIRECT_CMD_WRDAT1, wrdat[1]);
+	if (len >  7)
+		dsi_wreg(link, DSI_DIRECT_CMD_WRDAT2, wrdat[2]);
+	if (len > 11)
+		dsi_wreg(link, DSI_DIRECT_CMD_WRDAT3, wrdat[3]);
+	dsi_wreg(link, DSI_DIRECT_CMD_STS_CLR, ~0);
+	dsi_wreg(link, DSI_DIRECT_CMD_SEND, true);
+
+	/* TODO: irq wait and error check */
+	mdelay(10);
+	dsi_wreg(link, DSI_CMD_MODE_STS_CLR, ~0);
+	dsi_wreg(link, DSI_DIRECT_CMD_STS_CLR, ~0);
+
+	return 0;
+}
+
+int mcde_dsi_dcs_read(struct mcde_chnl_state *chnl, u8 cmd, u8* data, int *len)
+{
+	int ret = 0;
+	u8 link = chnl->port.link;
+	u8 virt_id = chnl->port.phy.dsi.virt_id;
+	u32 settings;
+	int wait = 100;
+	bool error, ok;
+
+	if (*len > MCDE_MAX_DCS_READ || chnl->port.type != MCDE_PORTTYPE_DSI)
+		return -EINVAL;
+
+	dsi_wfld(link, DSI_MCTL_MAIN_DATA_CTL, BTA_EN, true);
+	dsi_wfld(link, DSI_MCTL_MAIN_DATA_CTL, READ_EN, true);
+	settings = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_ENUM(READ) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT(false) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID(virt_id) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE(1) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN(true) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_ENUM(DCS_READ);
+	dsi_wreg(link, DSI_DIRECT_CMD_MAIN_SETTINGS, settings);
+	dsi_wreg(link, DSI_DIRECT_CMD_WRDAT0, cmd);
+	dsi_wreg(link, DSI_DIRECT_CMD_STS_CLR, ~0);
+	dsi_wreg(link, DSI_DIRECT_CMD_RD_STS_CLR, ~0);
+	dsi_wreg(link, DSI_DIRECT_CMD_SEND, true);
+
+	/* TODO */
+	while (wait-- && !(error = dsi_rfld(link, DSI_DIRECT_CMD_STS,
+		READ_COMPLETED_WITH_ERR)) && !(ok = dsi_rfld(link,
+		DSI_DIRECT_CMD_STS, READ_COMPLETED)))
+		mdelay(10);
+
+	if (ok) {
+		int rdsize;
+		u32 rddat;
+
+		rdsize = dsi_rfld(link, DSI_DIRECT_CMD_RD_PROPERTY, RD_SIZE);
+		rddat = dsi_rreg(link, DSI_DIRECT_CMD_RDDAT);
+		if (rdsize < *len)
+			pr_debug("DCS incomplete read %d<%d (%.8X)\n",
+				rdsize, *len, rddat);/* REVIEW: dev_dbg */
+		*len = min(*len, rdsize);
+		memcpy(data, &rddat, *len);
+	} else {
+		pr_err("DCS read failed, err=%d, sts=%X\n",
+			error, dsi_rreg(link, DSI_DIRECT_CMD_STS));
+		ret = -EIO;
+	}
+
+	dsi_wreg(link, DSI_CMD_MODE_STS_CLR, ~0);
+	dsi_wreg(link, DSI_DIRECT_CMD_STS_CLR, ~0);
+
+	return ret;
+}
+
+static void dsi_te_request(struct mcde_chnl_state *chnl)
+{
+	u8 link = chnl->port.link;
+	u8 virt_id = chnl->port.phy.dsi.virt_id;
+	u32 settings;
+
+	dev_vdbg(&mcde_dev->dev, "Request BTA TE, chnl=%d\n",
+		chnl->id);
+
+	dsi_wfld(link, DSI_MCTL_MAIN_DATA_CTL, BTA_EN, true);
+	dsi_wfld(link, DSI_MCTL_MAIN_DATA_CTL, REG_TE_EN, true);
+	dsi_wfld(link, DSI_CMD_MODE_CTL, TE_TIMEOUT, 0x3FF);
+	settings = DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_NAT_ENUM(TE_REQ) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LONGNOTSHORT(false) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_ID(virt_id) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_SIZE(2) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_LP_EN(true) |
+		DSI_DIRECT_CMD_MAIN_SETTINGS_CMD_HEAD_ENUM(DCS_SHORT_WRITE_1);
+	dsi_wreg(link, DSI_DIRECT_CMD_MAIN_SETTINGS, settings);
+	dsi_wreg(link, DSI_DIRECT_CMD_WRDAT0, DCS_CMD_SET_TEAR_ON);
+	dsi_wreg(link, DSI_DIRECT_CMD_STS_CLR,
+		DSI_DIRECT_CMD_STS_CLR_TE_RECEIVED_CLR(true));
+	dsi_wfld(link, DSI_DIRECT_CMD_STS_CTL, TE_RECEIVED_EN, true);
+	dsi_wreg(link, DSI_CMD_MODE_STS_CLR,
+		DSI_CMD_MODE_STS_CLR_ERR_NO_TE_CLR(true));
+	dsi_wfld(link, DSI_CMD_MODE_STS_CTL, ERR_NO_TE_EN, true);
+	dsi_wreg(link, DSI_DIRECT_CMD_SEND, true);
+}
+
+/* MCDE channels */
+struct mcde_chnl_state *mcde_chnl_get(enum mcde_chnl chnl_id,
+	enum mcde_fifo fifo, const struct mcde_port *port)
+{
+	int i;
+	struct mcde_chnl_state *chnl = NULL;
+	enum mcde_chnl_path path;
+	const struct chnl_config *cfg = NULL;
+
+	/* Allocate channel */
+	for (i = 0; i < ARRAY_SIZE(channels); i++) {
+		if (chnl_id == channels[i].id)
+			chnl = &channels[i];
+	}
+	if (!chnl) {
+		dev_dbg(&mcde_dev->dev, "Invalid channel, chnl=%d\n", chnl_id);
+		return ERR_PTR(-EINVAL);
+	}
+	if (chnl->inuse) {
+		dev_dbg(&mcde_dev->dev, "Channel in use, chnl=%d\n", chnl_id);
+		return ERR_PTR(-EBUSY);
+	}
+
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_5) {
+		path = MCDE_CHNLPATH(chnl->id, fifo, port->type, port->ifc,
+								port->link);
+		for (i = 0; i < ARRAY_SIZE(chnl_configs); i++)
+			if (chnl_configs[i].path == path) {
+				cfg = &chnl_configs[i];
+				break;
+			}
+		if (cfg == NULL) {
+			dev_dbg(&mcde_dev->dev, "Invalid config, chnl=%d,"
+					" path=0x%.8X\n", chnl_id, path);
+			return ERR_PTR(-EINVAL);
+		} else
+			dev_info(&mcde_dev->dev, "Config, chnl=%d,"
+					" path=0x%.8X\n", chnl_id, path);
+
+		/*
+		* TODO: verify that cfg is ok to activate
+		* (check other chnl cfgs)
+		*/
+	}
+
+	chnl->cfg = cfg;
+	chnl->port = *port;
+	chnl->fifo = fifo;
+
+	if (!mcde_is_enabled) {
+		int ret;
+		ret = enable_clocks_and_power(mcde_dev);
+		if (ret < 0) {
+			dev_dbg(&mcde_dev->dev,
+				"%s: Enable clocks and power failed\n"
+							, __func__);
+			return ERR_PTR(-EINVAL);
+		}
+		update_mcde_registers();
+		mcde_is_enabled = true;
+	}
+
+	if (update_channel_static_registers(chnl) < 0)
+		return ERR_PTR(-EINVAL);
+
+	chnl->synchronized_update = true;
+	chnl->pix_fmt = port->pixel_format;
+	mcde_chnl_apply(chnl);
+	chnl->inuse = true;
+
+	return chnl;
+}
+
+int mcde_chnl_set_pixel_format(struct mcde_chnl_state *chnl,
+	enum mcde_port_pix_fmt pix_fmt)
+{
+	if (!chnl->inuse)
+		return -EINVAL;
+	chnl->pix_fmt = pix_fmt;
+	return 0;
+}
+
+void mcde_chnl_set_col_convert(struct mcde_chnl_state *chnl,
+					struct mcde_col_convert *col_convert)
+{
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+	chnl->col_regs.y_red     = col_convert->matrix[0][0];
+	chnl->col_regs.y_green   = col_convert->matrix[0][1];
+	chnl->col_regs.y_blue    = col_convert->matrix[0][2];
+	chnl->col_regs.cb_red    = col_convert->matrix[1][0];
+	chnl->col_regs.cb_green  = col_convert->matrix[1][1];
+	chnl->col_regs.cb_blue   = col_convert->matrix[1][2];
+	chnl->col_regs.cr_red    = col_convert->matrix[2][0];
+	chnl->col_regs.cr_green  = col_convert->matrix[2][1];
+	chnl->col_regs.cr_blue   = col_convert->matrix[2][2];
+	chnl->col_regs.off_red   = col_convert->offset[0];
+	chnl->col_regs.off_green = col_convert->offset[1];
+	chnl->col_regs.off_blue  = col_convert->offset[2];
+}
+
+int mcde_chnl_set_rotation(struct mcde_chnl_state *chnl,
+	enum mcde_display_rotation rotation, u32 rotbuf1, u32 rotbuf2)
+{
+	if (!chnl->inuse)
+		return -EINVAL;
+
+	/* TODO: Fix 180 degrees rotation */
+	if (rotation == MCDE_DISPLAY_ROT_180_CCW ||
+		(chnl->id != MCDE_CHNL_A && chnl->id != MCDE_CHNL_B))
+		return -EINVAL;
+
+	chnl->rotation = rotation;
+	chnl->rotbuf1  = rotbuf1;
+	chnl->rotbuf2  = rotbuf2;
+
+	return 0;
+}
+
+int mcde_chnl_enable_synchronized_update(struct mcde_chnl_state *chnl,
+	bool enable)
+{
+	if (!chnl->inuse)
+		return -EINVAL;
+	chnl->synchronized_update = enable;
+	return 0;
+}
+
+int mcde_chnl_set_power_mode(struct mcde_chnl_state *chnl,
+	enum mcde_display_power_mode power_mode)
+{
+	if (!chnl->inuse)
+		return -EINVAL;
+
+	chnl->power_mode = power_mode;
+	return 0;
+}
+
+int mcde_chnl_apply(struct mcde_chnl_state *chnl)
+{
+	/* TODO: lock *//* REVIEW: MCDE locking! */
+	bool roten = false;
+	u8 rotdir = 0;
+
+	if (!chnl->inuse)
+		return -EINVAL;
+
+	if (chnl->rotation == MCDE_DISPLAY_ROT_90_CCW) {
+		roten = true;
+		rotdir = MCDE_ROTACONF_ROTDIR_CCW;
+	} else if (chnl->rotation == MCDE_DISPLAY_ROT_90_CW) {
+		roten = true;
+		rotdir = MCDE_ROTACONF_ROTDIR_CW;
+	}
+	/* REVIEW: 180 deg? */
+
+	chnl->regs.bpp = portfmt2bpp(chnl->pix_fmt);
+	chnl->regs.synchronized_update = chnl->synchronized_update;
+	chnl->regs.roten = roten;
+	chnl->regs.rotdir = rotdir;
+	chnl->regs.rotbuf1 = chnl->rotbuf1;
+	chnl->regs.rotbuf2 = chnl->rotbuf2;
+	if (chnl->port.type == MCDE_PORTTYPE_DSI)
+		chnl->regs.dsipacking = portfmt2dsipacking(chnl->pix_fmt);
+	else if (chnl->port.type == MCDE_PORTTYPE_DPI)
+		tv_video_mode_apply(chnl);
+	chnl->transactionid++;
+
+	dev_vdbg(&mcde_dev->dev, "Channel applied, chnl=%d\n", chnl->id);
+	return 0;
+}
+
+static void chnl_update_registers(struct mcde_chnl_state *chnl)
+{
+	/* REVIEW: Move content to update_channel_register */
+	/* and remove this one */
+	if (chnl->port.type == MCDE_PORTTYPE_DPI)
+		update_tv_registers(chnl->id, &chnl->tv_regs);
+	if (chnl->id == MCDE_CHNL_A || chnl->id == MCDE_CHNL_B)
+		update_col_registers(chnl->id, &chnl->col_regs);
+	update_channel_registers(chnl->id, &chnl->regs, &chnl->port,
+						chnl->fifo, &chnl->vmode);
+
+	chnl->transactionid_regs = chnl->transactionid;
+}
+
+static void chnl_update_continous(struct mcde_chnl_state *chnl)
+{
+	if (!chnl->continous_running) {
+		if (chnl->transactionid_regs < chnl->transactionid)
+			chnl_update_registers(chnl);
+
+		if (chnl->port.sync_src == MCDE_SYNCSRC_TE0)
+			mcde_wfld(MCDE_CRC, SYCEN0, true);
+		else if (chnl->port.sync_src == MCDE_SYNCSRC_TE1)
+			mcde_wfld(MCDE_CRC, SYCEN1, true);
+
+		chnl->continous_running = true;
+
+		enable_channel(chnl);
+
+		if (chnl->port.type == MCDE_PORTTYPE_DSI &&
+				chnl->port.sync_src == MCDE_SYNCSRC_OFF) {
+			/*
+			* For main and secondary display,
+			* FLOWEN has to be set before a SOFTWARE TRIG
+			* Otherwise not overlay interrupt is triggerd
+			*/
+			/*
+			* In MCDE_CHIP_VERSION_3_0_5 an VCOMP Irq was
+			* triggered after FLOEN = true but this does not
+			* happen in 3_0_8 and therefor SW_TRIG is added
+			*/
+			if (hardware_version == MCDE_CHIP_VERSION_3_0_8)
+				mcde_wreg(MCDE_CHNL0SYNCHSW +
+				chnl->id * MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+				MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+
+			mod_timer(&chnl->auto_sync_timer,
+					jiffies +
+			msecs_to_jiffies(MCDE_AUTO_SYNC_WATCHDOG * 1000));
+		}
+	}
+}
+
+static void chnl_update_non_continous(struct mcde_chnl_state *chnl)
+{
+	/* Commit settings to registers */
+	wait_for_channel(chnl);
+	if (chnl->transactionid_regs < chnl->transactionid)
+		chnl_update_registers(chnl);
+
+	/*
+	* For main and secondary display,
+	* FLOWEN has to be set before a SOFTWARE TRIG
+	* Otherwise not overlay interrupt is triggerd
+	* However FLOWEN must not be triggered before SOFTWARE TRIG
+	* if rotation is enabled
+	*/
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_8 ||
+			(chnl->power_mode == MCDE_DISPLAY_PM_STANDBY ||
+							!chnl->regs.roten))
+		enable_channel(chnl);
+
+	/* TODO: look at port sync source and synched_update */
+	if (chnl->regs.synchronized_update &&
+				chnl->power_mode == MCDE_DISPLAY_PM_ON) {
+		if (chnl->port.type == MCDE_PORTTYPE_DSI &&
+			chnl->port.sync_src == MCDE_SYNCSRC_BTA) {
+			while (dsi_rfld(chnl->port.link, DSI_CMD_MODE_STS,
+				CSM_RUNNING))
+				udelay(100);
+			dsi_te_request(chnl);
+		}
+	} else {
+		mcde_wreg(MCDE_CHNL0SYNCHSW +
+			chnl->id * MCDE_CHNL0SYNCHSW_GROUPOFFSET,
+			MCDE_CHNL0SYNCHSW_SW_TRIG(true));
+		dev_vdbg(&mcde_dev->dev, "Channel update (no sync), chnl=%d\n",
+			chnl->id);
+
+		/*
+		* This comment is valid for hardware_version ==
+		* MCDE_CHIP_VERSION_3_0_8.
+		*
+		* If you disable after the last frame you triggered has
+		* finished. The output formatter
+		* (at least DSI is working like this) is waiting for a new
+		* frame that will never come, and then the FLOEN will
+		* stay at 1. To avoid this, you have to always disable just
+		* after your last trig, before receiving VCOMP interrupt
+		* (= before the last triggered frame is finished).
+		*/
+		if (hardware_version == MCDE_CHIP_VERSION_3_0_8)
+			channel_flow_disable(chnl);
+	}
+
+	if (hardware_version == MCDE_CHIP_VERSION_3_0_5 &&
+		chnl->power_mode == MCDE_DISPLAY_PM_ON && chnl->regs.roten)
+		enable_channel(chnl);
+
+}
+
+static void chnl_update_overlay(struct mcde_chnl_state *chnl,
+						struct mcde_ovly_state *ovly)
+{
+	if (!ovly || (ovly->transactionid_regs >= ovly->transactionid &&
+			chnl->transactionid_regs >= chnl->transactionid))
+		return;
+
+	update_overlay_address_registers(ovly->idx, &ovly->regs);
+	if (ovly->regs.reset_buf_id) {
+		if (!chnl->continous_running)
+			wait_for_overlay(ovly);
+
+		update_overlay_registers(ovly->idx, &ovly->regs, &chnl->port,
+			chnl->fifo, chnl->regs.x, chnl->regs.y,
+			chnl->regs.ppl, chnl->regs.lpf, ovly->stride,
+			chnl->vmode.interlaced);
+		ovly->transactionid_regs = ovly->transactionid;
+	} else if (chnl->continous_running) {
+		ovly->transactionid_regs = ovly->transactionid;
+		wait_for_overlay(ovly);
+	}
+}
+
+int mcde_chnl_update(struct mcde_chnl_state *chnl,
+					struct mcde_rectangle *update_area)
+{
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	/* TODO: lock & make wait->trig async */
+	if (!chnl->inuse || !update_area
+			|| (update_area->w == 0 && update_area->h == 0)) {
+		return -EINVAL;
+	}
+
+	chnl->regs.x   = update_area->x;
+	chnl->regs.y   = update_area->y;
+	/* TODO Crop against video_mode.xres and video_mode.yres */
+	chnl->regs.ppl = update_area->w;
+	chnl->regs.lpf = update_area->h;
+	if (chnl->port.type == MCDE_PORTTYPE_DPI) {/* REVIEW: Comment */
+		chnl->regs.ppl -= 2 * MCDE_CONFIG_TVOUT_HBORDER;
+		/* subtract double borders, ie. per field */
+		chnl->regs.lpf -= 4 * MCDE_CONFIG_TVOUT_VBORDER;
+	} else if (chnl->port.type == MCDE_PORTTYPE_DSI &&
+			chnl->vmode.interlaced)
+		chnl->regs.lpf /= 2;
+
+	chnl_update_overlay(chnl, chnl->ovly0);
+	chnl_update_overlay(chnl, chnl->ovly1);
+
+	if (chnl->port.update_auto_trig)
+		chnl_update_continous(chnl);
+	else
+		chnl_update_non_continous(chnl);
+
+	dev_vdbg(&mcde_dev->dev, "Channel updated, chnl=%d\n", chnl->id);
+	return 0;
+}
+
+void mcde_chnl_put(struct mcde_chnl_state *chnl)
+{
+	struct mcde_chnl_state *chnl_tmp = &channels[0];
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	if (!chnl->inuse)
+		return;
+
+	disable_channel(chnl);
+	chnl->inuse = false;
+
+	for (; chnl_tmp < &channels[ARRAY_SIZE(channels)]; chnl_tmp++)
+		if (chnl_tmp->inuse)
+			return;
+
+	disable_clocks_and_power(mcde_dev);
+
+	mcde_is_enabled = false;
+}
+
+void mcde_chnl_stop_flow(struct mcde_chnl_state *chnl)
+{
+	disable_channel(chnl);
+}
+
+/* MCDE overlays */
+struct mcde_ovly_state *mcde_ovly_get(struct mcde_chnl_state *chnl)
+{
+	struct mcde_ovly_state *ovly;
+
+	if (!chnl->inuse)
+		return ERR_PTR(-EINVAL);
+
+	if (!chnl->ovly0->inuse)
+		ovly = chnl->ovly0;
+	else if (chnl->ovly1 && !chnl->ovly1->inuse)
+		ovly = chnl->ovly1;
+	else
+		ovly = ERR_PTR(-EBUSY);
+
+	if (!IS_ERR(ovly)) {
+		ovly->inuse = true;
+		ovly->paddr = 0;
+		ovly->stride = 0;
+		ovly->pix_fmt = MCDE_OVLYPIXFMT_RGB565;
+		ovly->src_x = 0;
+		ovly->src_y = 0;
+		ovly->dst_x = 0;
+		ovly->dst_y = 0;
+		ovly->dst_z = 0;
+		ovly->w = 0;
+		ovly->h = 0;
+		mcde_ovly_apply(ovly);
+	}
+
+	return ovly;
+}
+
+void mcde_ovly_put(struct mcde_ovly_state *ovly)
+{
+	if (!ovly->inuse)
+		return;
+	if (ovly->regs.enabled) {
+		ovly->paddr = 0;
+		mcde_ovly_apply(ovly);/* REVIEW: API call calling API call! */
+	}
+	ovly->inuse = false;
+}
+
+void mcde_ovly_set_source_buf(struct mcde_ovly_state *ovly, u32 paddr)
+{
+	if (!ovly->inuse)
+		return;
+
+	ovly->paddr = paddr;
+}
+
+void mcde_ovly_set_source_info(struct mcde_ovly_state *ovly,
+	u32 stride, enum mcde_ovly_pix_fmt pix_fmt)
+{
+	if (!ovly->inuse)
+		return;
+
+	ovly->stride = stride;
+	ovly->pix_fmt = pix_fmt;
+}
+
+void mcde_ovly_set_source_area(struct mcde_ovly_state *ovly,
+	u16 x, u16 y, u16 w, u16 h)
+{
+	if (!ovly->inuse)
+		return;
+
+	ovly->src_x = x;
+	ovly->src_y = y;
+	ovly->w = w;
+	ovly->h = h;
+}
+
+void mcde_ovly_set_dest_pos(struct mcde_ovly_state *ovly, u16 x, u16 y, u8 z)
+{
+	if (!ovly->inuse)
+		return;
+
+	ovly->dst_x = x;
+	ovly->dst_y = y;
+	ovly->dst_z = z;
+}
+
+void mcde_ovly_apply(struct mcde_ovly_state *ovly)
+{
+	if (!ovly->inuse)
+		return;
+
+	/* TODO: lock */
+
+	ovly->regs.ch_id = ovly->chnl->id;
+	ovly->regs.enabled = ovly->paddr != 0;
+	ovly->regs.baseaddress0 = ovly->paddr;
+	ovly->regs.baseaddress1 = ovly->paddr + ovly->stride;
+	/*TODO set to true if interlaced *//* REVIEW: Video mode interlaced? */
+	ovly->regs.reset_buf_id = !ovly->chnl->continous_running;
+	switch (ovly->pix_fmt) {/* REVIEW: Extract to table */
+	case MCDE_OVLYPIXFMT_RGB565:
+		ovly->regs.bits_per_pixel = 16;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_RGB565;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = false;
+		ovly->regs.opq = true;
+		break;
+	case MCDE_OVLYPIXFMT_RGBA5551:
+		ovly->regs.bits_per_pixel = 16;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_IRGB1555;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = false;
+		ovly->regs.opq = false;
+		break;
+	case MCDE_OVLYPIXFMT_RGBA4444:
+		ovly->regs.bits_per_pixel = 16;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_ARGB4444;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = false;
+		ovly->regs.opq = false;
+		break;
+	case MCDE_OVLYPIXFMT_RGB888:
+		ovly->regs.bits_per_pixel = 24;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_RGB888;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = false;
+		ovly->regs.opq = true;
+		break;
+	case MCDE_OVLYPIXFMT_RGBX8888:
+		ovly->regs.bits_per_pixel = 32;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_XRGB8888;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = true;
+		ovly->regs.opq = true;
+		break;
+	case MCDE_OVLYPIXFMT_RGBA8888:
+		ovly->regs.bits_per_pixel = 32;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_ARGB8888;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = true;
+		ovly->regs.opq = false;
+		break;
+	case MCDE_OVLYPIXFMT_YCbCr422:
+		ovly->regs.bits_per_pixel = 16;
+		ovly->regs.bpp = MCDE_EXTSRC0CONF_BPP_YCBCR422;
+		ovly->regs.bgr = false;
+		ovly->regs.bebo = false;
+		ovly->regs.opq = true;
+		break;
+	default:
+		break;
+	}
+
+	ovly->regs.ppl = ovly->w;
+	ovly->regs.lpf = ovly->h;
+	ovly->regs.cropx = ovly->src_x;
+	ovly->regs.cropy = ovly->src_y;
+	ovly->regs.xpos = ovly->dst_x;
+	ovly->regs.ypos = ovly->dst_y;
+	ovly->regs.z = ovly->dst_z > 0; /* 0 or 1 */
+	ovly->regs.col_conv = MCDE_OVL0CR_COLCCTRL_DISABLED;
+
+	ovly->transactionid = ++ovly->chnl->transactionid;
+
+	dev_vdbg(&mcde_dev->dev, "Overlay applied, chnl=%d\n", ovly->chnl->id);
+}
+
+static int init_clocks_and_power(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct mcde_platform_data *pdata = pdev->dev.platform_data;
+	if (pdata->regulator_id) {
+		regulator = regulator_get(&pdev->dev,
+				pdata->regulator_id);
+		if (IS_ERR(regulator)) {
+			ret = PTR_ERR(regulator);
+			dev_warn(&pdev->dev,
+				"%s: Failed to get regulator '%s'\n",
+				__func__, pdata->regulator_id);
+			regulator = NULL;
+			goto regulator_err;
+		}
+	} else {
+		dev_dbg(&pdev->dev, "%s: No regulator id supplied\n",
+								__func__);
+		regulator = NULL;
+	}
+	clock_dsi = clk_get(&pdev->dev, pdata->clock_dsi_id);
+	if (IS_ERR(clock_dsi)) {
+		ret = PTR_ERR(clock_dsi);
+		dev_warn(&pdev->dev, "%s: Failed to get clock '%s'\n",
+					__func__, pdata->clock_dsi_id);
+		goto clk_dsi_err;
+	}
+
+	clock_dsi_lp = clk_get(&pdev->dev, pdata->clock_dsi_lp_id);
+	if (IS_ERR(clock_dsi_lp)) {
+		ret = PTR_ERR(clock_dsi_lp);
+		dev_warn(&pdev->dev, "%s: Failed to get clock '%s'\n",
+					__func__, pdata->clock_dsi_lp_id);
+		goto clk_dsi_lp_err;
+	}
+
+	clock_mcde = clk_get(&pdev->dev, pdata->clock_mcde_id);
+	if (IS_ERR(clock_mcde)) {
+		ret = PTR_ERR(clock_mcde);
+		dev_warn(&pdev->dev, "%s: Failed to get clock '%s'\n",
+					__func__, pdata->clock_mcde_id);
+		goto clk_mcde_err;
+	}
+
+	return ret;
+
+clk_mcde_err:
+	clk_put(clock_dsi_lp);
+clk_dsi_lp_err:
+	clk_put(clock_dsi);
+clk_dsi_err:
+	if (regulator)
+		regulator_put(regulator);
+regulator_err:
+	return ret;
+}
+
+static void remove_clocks_and_power(struct platform_device *pdev)
+{
+	/* REVIEW: Release only if exist */
+	/* REVIEW: Remove make sure MCDE is done */
+	clk_put(clock_dsi);
+	clk_put(clock_dsi_lp);
+	clk_put(clock_mcde);
+	if (regulator)
+		regulator_put(regulator);
+}
+
+static int __devinit mcde_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	int i, irq;
+	struct resource *res;
+	struct mcde_platform_data *pdata = pdev->dev.platform_data;
+	u8 major_version;
+	u8 minor_version;
+	u8 development_version;
+
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "No platform data\n");
+		return -EINVAL;
+	}
+
+	num_dsilinks = pdata->num_dsilinks;
+	mcde_dev = pdev;
+
+	dsiio = kzalloc(num_dsilinks * sizeof(*dsiio), GFP_KERNEL);
+	if (!dsiio) {
+		ret = -ENOMEM;
+		goto failed_dsi_alloc;
+	}
+
+	/* Hook up irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		dev_dbg(&pdev->dev, "No irq defined\n");
+		ret = -EINVAL;
+		goto failed_irq_get;
+	}
+	ret = request_irq(irq, mcde_irq_handler, 0, "mcde", &pdev->dev);
+	if (ret) {
+		dev_dbg(&pdev->dev, "Failed to request irq (irq=%d)\n", irq);
+		goto failed_request_irq;
+	}
+
+	/* Map I/O */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_dbg(&pdev->dev, "No MCDE io defined\n");
+		ret = -EINVAL;
+		goto failed_get_mcde_io;
+	}
+	mcdeio = ioremap(res->start, res->end - res->start + 1);
+	if (!mcdeio) {
+		dev_dbg(&pdev->dev, "MCDE iomap failed\n");
+		ret = -EINVAL;
+		goto failed_map_mcde_io;
+	}
+	dev_info(&pdev->dev, "MCDE iomap: 0x%.8X->0x%.8X\n",
+		(u32)res->start, (u32)mcdeio);
+	for (i = 0; i < num_dsilinks; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1+i);
+		if (!res) {
+			dev_dbg(&pdev->dev, "No DSI%d io defined\n", i);
+			ret = -EINVAL;
+			goto failed_get_dsi_io;
+		}
+		dsiio[i] = ioremap(res->start, res->end - res->start + 1);
+		if (!dsiio[i]) {
+			dev_dbg(&pdev->dev, "MCDE DSI%d iomap failed\n", i);
+			ret = -EINVAL;
+			goto failed_map_dsi_io;
+		}
+		dev_info(&pdev->dev, "MCDE DSI%d iomap: 0x%.8X->0x%.8X\n",
+			i, (u32)res->start, (u32)dsiio[i]);
+	}
+
+	ret = init_clocks_and_power(pdev);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "%s: init_clocks_and_power failed\n"
+					, __func__);
+		goto failed_init_clocks;
+	}
+	ret = enable_clocks_and_power(pdev);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "%s: enable_clocks_and_power failed\n"
+					, __func__);
+		goto failed_enable_clocks;
+	}
+	update_mcde_registers();
+
+	major_version = MCDE_REG2VAL(MCDE_PID, MAJOR_VERSION,
+							mcde_rreg(MCDE_PID));
+	minor_version = MCDE_REG2VAL(MCDE_PID, MINOR_VERSION,
+							mcde_rreg(MCDE_PID));
+	development_version = MCDE_REG2VAL(MCDE_PID, DEVELOPMENT_VERSION,
+							mcde_rreg(MCDE_PID));
+
+	dev_info(&mcde_dev->dev, "MCDE HW revision %u.%u.%u.%u\n",
+			major_version, minor_version, development_version,
+					mcde_rfld(MCDE_PID, METALFIX_VERSION));
+
+	if (major_version == 3 && minor_version == 0 &&
+					development_version >= 8) {
+		hardware_version = MCDE_CHIP_VERSION_3_0_8;
+		dev_info(&mcde_dev->dev, "V2 HW\n");
+	} else if (major_version == 3 && minor_version == 0 &&
+					development_version >= 5) {
+		hardware_version = MCDE_CHIP_VERSION_3_0_5;
+		dev_info(&mcde_dev->dev, "V1 HW\n");
+	} else {
+		dev_err(&mcde_dev->dev, "Unsupported HW version\n");
+		ret = -ENOTSUPP;
+		goto failed_hardware_version;
+	}
+
+	mcde_is_enabled = true;
+
+	return 0;
+
+failed_hardware_version:
+	disable_clocks_and_power(pdev);
+failed_enable_clocks:
+	remove_clocks_and_power(pdev);
+failed_init_clocks:
+failed_map_dsi_io:
+failed_get_dsi_io:
+	for (i = 0; i < num_dsilinks; i++) {
+		if (dsiio[i])
+			iounmap(dsiio[i]);
+	}
+	iounmap(mcdeio);
+failed_map_mcde_io:
+failed_get_mcde_io:
+	free_irq(irq, &pdev->dev);
+failed_request_irq:
+failed_irq_get:
+	kfree(dsiio);
+	dsiio = NULL;
+failed_dsi_alloc:
+	return ret;
+}
+
+
+static int __devexit mcde_remove(struct platform_device *pdev)
+{
+	struct mcde_chnl_state *chnl = &channels[0];
+
+	for (; chnl < &channels[ARRAY_SIZE(channels)]; chnl++) {
+		if (del_timer(&chnl->auto_sync_timer))
+			dev_vdbg(&mcde_dev->dev,
+				"%s timer could not be stopped\n"
+				, __func__);
+	}
+	remove_clocks_and_power(pdev);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mcde_resume(struct platform_device *pdev)
+{
+	int ret;
+	struct mcde_chnl_state *chnl = &channels[0];
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+	ret = enable_clocks_and_power(pdev);
+	if (ret < 0) {
+		dev_dbg(&pdev->dev, "%s: Enable clocks and power failed\n"
+						, __func__);
+		goto clock_err;
+	}
+	update_mcde_registers();
+
+	for (; chnl < &channels[ARRAY_SIZE(channels)]; chnl++) {
+		if (chnl->inuse) {
+			(void)update_channel_static_registers(chnl);
+			update_channel_registers(chnl->id, &chnl->regs,
+						&chnl->port, chnl->fifo,
+						&chnl->vmode);
+			if (chnl->ovly0)
+				update_overlay_registers(chnl->ovly0->idx,
+						&chnl->ovly0->regs,
+						&chnl->port, chnl->fifo,
+						chnl->regs.x, chnl->regs.y,
+						chnl->regs.ppl, chnl->regs.lpf,
+						chnl->ovly0->stride,
+						chnl->vmode.interlaced);
+			if (chnl->ovly1)
+				update_overlay_registers(chnl->ovly1->idx,
+						&chnl->ovly1->regs,
+						&chnl->port, chnl->fifo,
+						chnl->regs.x, chnl->regs.y,
+						chnl->regs.ppl, chnl->regs.lpf,
+						chnl->ovly1->stride,
+						chnl->vmode.interlaced);
+		}
+	}
+
+	mcde_is_enabled = true;
+clock_err:
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM
+static int mcde_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct mcde_chnl_state *chnl = &channels[0];
+
+	dev_vdbg(&mcde_dev->dev, "%s\n", __func__);
+
+	/* This is added because of the auto sync feature */
+	for (; chnl < &channels[ARRAY_SIZE(channels)]; chnl++) {
+		mcde_chnl_stop_flow(chnl);
+		if (del_timer(&chnl->auto_sync_timer))
+			dev_vdbg(&mcde_dev->dev,
+				"%s timer could not be stopped\n"
+				, __func__);
+	}
+
+	mcde_is_enabled = false;
+
+	return disable_clocks_and_power(pdev);
+}
+#endif
+
+static struct platform_driver mcde_driver = {
+	.probe = mcde_probe,
+	.remove = mcde_remove,
+#ifdef CONFIG_PM
+	.suspend = mcde_suspend,
+	.resume = mcde_resume,
+#else
+	.suspend = NULL,
+	.resume = NULL,
+#endif
+	.driver = {
+		.name	= "mcde",
+	},
+};
+
+int __init mcde_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(channels); i++) {
+		channels[i].ovly0->chnl = &channels[i];
+		if (channels[i].ovly1)
+			channels[i].ovly1->chnl = &channels[i];
+		init_waitqueue_head(&channels[i].waitq_hw);
+		init_timer(&channels[i].auto_sync_timer);
+		channels[i].auto_sync_timer.function =
+					watchdog_auto_sync_timer_function;
+	}
+	for (i = 0; i < ARRAY_SIZE(overlays); i++)
+		init_waitqueue_head(&overlays[i].waitq_hw);
+
+	return platform_driver_register(&mcde_driver);
+}
+
+void mcde_exit(void)
+{
+	/* REVIEW: shutdown MCDE? */
+	platform_driver_unregister(&mcde_driver);
+}
diff --git a/drivers/video/mcde/mcde_mod.c b/drivers/video/mcde/mcde_mod.c
new file mode 100644
index 0000000..297857f
--- /dev/null
+++ b/drivers/video/mcde/mcde_mod.c
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include <video/mcde/mcde.h>
+#include <video/mcde/mcde_fb.h>
+#include <video/mcde/mcde_dss.h>
+#include <video/mcde/mcde_display.h>
+
+/* Module init */
+
+static int __init mcde_subsystem_init(void)
+{
+	int ret;
+	pr_info("MCDE subsystem init begin\n");
+
+	/* MCDE module init sequence */
+	ret = mcde_init();
+	if (ret)
+		return ret;
+	ret = mcde_display_init();
+	if (ret)
+		goto mcde_display_failed;
+	ret = mcde_dss_init();
+	if (ret)
+		goto mcde_dss_failed;
+	ret = mcde_fb_init();
+	if (ret)
+		goto mcde_fb_failed;
+	pr_info("MCDE subsystem init done\n");
+
+	return 0;
+mcde_fb_failed:
+	mcde_dss_exit();
+mcde_dss_failed:
+	mcde_display_exit();
+mcde_display_failed:
+	mcde_exit();
+	return ret;
+}
+#ifdef MODULE
+module_init(mcde_subsystem_init);
+#else
+fs_initcall(mcde_subsystem_init);
+#endif
+
+static void __exit mcde_module_exit(void)
+{
+	mcde_exit();
+	mcde_display_exit();
+	mcde_dss_exit();
+}
+module_exit(mcde_module_exit);
+
+MODULE_AUTHOR("Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ST-Ericsson MCDE driver");
+
diff --git a/drivers/video/mcde/mcde_regs.h b/drivers/video/mcde/mcde_regs.h
new file mode 100644
index 0000000..72e51f1
--- /dev/null
+++ b/drivers/video/mcde/mcde_regs.h
@@ -0,0 +1,5297 @@
+
+#define MCDE_VAL2REG(__reg, __fld, __val) \
+	(((__val) << __reg##_##__fld##_SHIFT) & __reg##_##__fld##_MASK)
+#define MCDE_REG2VAL(__reg, __fld, __val) \
+	(((__val) & __reg##_##__fld##_MASK) >> __reg##_##__fld##_SHIFT)
+
+#define MCDE_CR 0x00000000
+#define MCDE_CR_DSICMD2_EN_V1_SHIFT 0
+#define MCDE_CR_DSICMD2_EN_V1_MASK 0x00000001
+#define MCDE_CR_DSICMD2_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DSICMD2_EN_V1, __x)
+#define MCDE_CR_DSICMD1_EN_V1_SHIFT 1
+#define MCDE_CR_DSICMD1_EN_V1_MASK 0x00000002
+#define MCDE_CR_DSICMD1_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DSICMD1_EN_V1, __x)
+#define MCDE_CR_DSICMD0_EN_V1_SHIFT 2
+#define MCDE_CR_DSICMD0_EN_V1_MASK 0x00000004
+#define MCDE_CR_DSICMD0_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DSICMD0_EN_V1, __x)
+#define MCDE_CR_DSIVID2_EN_V1_SHIFT 3
+#define MCDE_CR_DSIVID2_EN_V1_MASK 0x00000008
+#define MCDE_CR_DSIVID2_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DSIVID2_EN_V1, __x)
+#define MCDE_CR_DSIVID1_EN_V1_SHIFT 4
+#define MCDE_CR_DSIVID1_EN_V1_MASK 0x00000010
+#define MCDE_CR_DSIVID1_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DSIVID1_EN_V1, __x)
+#define MCDE_CR_DSIVID0_EN_V1_SHIFT 5
+#define MCDE_CR_DSIVID0_EN_V1_MASK 0x00000020
+#define MCDE_CR_DSIVID0_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DSIVID0_EN_V1, __x)
+#define MCDE_CR_DBIC1_EN_V1_SHIFT 6
+#define MCDE_CR_DBIC1_EN_V1_MASK 0x00000040
+#define MCDE_CR_DBIC1_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DBIC1_EN_V1, __x)
+#define MCDE_CR_DBIC0_EN_V1_SHIFT 7
+#define MCDE_CR_DBIC0_EN_V1_MASK 0x00000080
+#define MCDE_CR_DBIC0_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DBIC0_EN_V1, __x)
+#define MCDE_CR_DPIB_EN_V1_SHIFT 8
+#define MCDE_CR_DPIB_EN_V1_MASK 0x00000100
+#define MCDE_CR_DPIB_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DPIB_EN_V1, __x)
+#define MCDE_CR_DPIA_EN_V1_SHIFT 9
+#define MCDE_CR_DPIA_EN_V1_MASK 0x00000200
+#define MCDE_CR_DPIA_EN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, DPIA_EN_V1, __x)
+#define MCDE_CR_IFIFOCTRLEN_SHIFT 15
+#define MCDE_CR_IFIFOCTRLEN_MASK 0x00008000
+#define MCDE_CR_IFIFOCTRLEN(__x) \
+	MCDE_VAL2REG(MCDE_CR, IFIFOCTRLEN, __x)
+#define MCDE_CR_F01MUX_V1_SHIFT 16
+#define MCDE_CR_F01MUX_V1_MASK 0x00010000
+#define MCDE_CR_F01MUX_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, F01MUX_V1, __x)
+#define MCDE_CR_FABMUX_V1_SHIFT 17
+#define MCDE_CR_FABMUX_V1_MASK 0x00020000
+#define MCDE_CR_FABMUX_V1(__x) \
+	MCDE_VAL2REG(MCDE_CR, FABMUX_V1, __x)
+#define MCDE_CR_AUTOCLKG_EN_SHIFT 30
+#define MCDE_CR_AUTOCLKG_EN_MASK 0x40000000
+#define MCDE_CR_AUTOCLKG_EN(__x) \
+	MCDE_VAL2REG(MCDE_CR, AUTOCLKG_EN, __x)
+#define MCDE_CR_MCDEEN_SHIFT 31
+#define MCDE_CR_MCDEEN_MASK 0x80000000
+#define MCDE_CR_MCDEEN(__x) \
+	MCDE_VAL2REG(MCDE_CR, MCDEEN, __x)
+#define MCDE_CONF0 0x00000004
+#define MCDE_CONF0_SYNCMUX0_SHIFT 0
+#define MCDE_CONF0_SYNCMUX0_MASK 0x00000001
+#define MCDE_CONF0_SYNCMUX0(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX0, __x)
+#define MCDE_CONF0_SYNCMUX1_SHIFT 1
+#define MCDE_CONF0_SYNCMUX1_MASK 0x00000002
+#define MCDE_CONF0_SYNCMUX1(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX1, __x)
+#define MCDE_CONF0_SYNCMUX2_SHIFT 2
+#define MCDE_CONF0_SYNCMUX2_MASK 0x00000004
+#define MCDE_CONF0_SYNCMUX2(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX2, __x)
+#define MCDE_CONF0_SYNCMUX3_SHIFT 3
+#define MCDE_CONF0_SYNCMUX3_MASK 0x00000008
+#define MCDE_CONF0_SYNCMUX3(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX3, __x)
+#define MCDE_CONF0_SYNCMUX4_SHIFT 4
+#define MCDE_CONF0_SYNCMUX4_MASK 0x00000010
+#define MCDE_CONF0_SYNCMUX4(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX4, __x)
+#define MCDE_CONF0_SYNCMUX5_SHIFT 5
+#define MCDE_CONF0_SYNCMUX5_MASK 0x00000020
+#define MCDE_CONF0_SYNCMUX5(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX5, __x)
+#define MCDE_CONF0_SYNCMUX6_SHIFT 6
+#define MCDE_CONF0_SYNCMUX6_MASK 0x00000040
+#define MCDE_CONF0_SYNCMUX6(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX6, __x)
+#define MCDE_CONF0_SYNCMUX7_SHIFT 7
+#define MCDE_CONF0_SYNCMUX7_MASK 0x00000080
+#define MCDE_CONF0_SYNCMUX7(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SYNCMUX7, __x)
+#define MCDE_CONF0_SWAP_A_C0_V1_SHIFT 8
+#define MCDE_CONF0_SWAP_A_C0_V1_MASK 0x00000100
+#define MCDE_CONF0_SWAP_A_C0_V1(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SWAP_A_C0_V1, __x)
+#define MCDE_CONF0_SWAP_B_C1_V1_SHIFT 9
+#define MCDE_CONF0_SWAP_B_C1_V1_MASK 0x00000200
+#define MCDE_CONF0_SWAP_B_C1_V1(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, SWAP_B_C1_V1, __x)
+#define MCDE_CONF0_FSYNCTRLA_V1_SHIFT 10
+#define MCDE_CONF0_FSYNCTRLA_V1_MASK 0x00000400
+#define MCDE_CONF0_FSYNCTRLA_V1(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, FSYNCTRLA_V1, __x)
+#define MCDE_CONF0_FSYNCTRLB_V1_SHIFT 11
+#define MCDE_CONF0_FSYNCTRLB_V1_MASK 0x00000800
+#define MCDE_CONF0_FSYNCTRLB_V1(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, FSYNCTRLB_V1, __x)
+#define MCDE_CONF0_IFIFOCTRLWTRMRKLVL_SHIFT 12
+#define MCDE_CONF0_IFIFOCTRLWTRMRKLVL_MASK 0x00007000
+#define MCDE_CONF0_IFIFOCTRLWTRMRKLVL(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, IFIFOCTRLWTRMRKLVL, __x)
+#define MCDE_CONF0_OUTMUX0_SHIFT 16
+#define MCDE_CONF0_OUTMUX0_MASK 0x00070000
+#define MCDE_CONF0_OUTMUX0(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, OUTMUX0, __x)
+#define MCDE_CONF0_OUTMUX1_SHIFT 19
+#define MCDE_CONF0_OUTMUX1_MASK 0x00380000
+#define MCDE_CONF0_OUTMUX1(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, OUTMUX1, __x)
+#define MCDE_CONF0_OUTMUX2_SHIFT 22
+#define MCDE_CONF0_OUTMUX2_MASK 0x01C00000
+#define MCDE_CONF0_OUTMUX2(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, OUTMUX2, __x)
+#define MCDE_CONF0_OUTMUX3_SHIFT 25
+#define MCDE_CONF0_OUTMUX3_MASK 0x0E000000
+#define MCDE_CONF0_OUTMUX3(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, OUTMUX3, __x)
+#define MCDE_CONF0_OUTMUX4_SHIFT 28
+#define MCDE_CONF0_OUTMUX4_MASK 0x70000000
+#define MCDE_CONF0_OUTMUX4(__x) \
+	MCDE_VAL2REG(MCDE_CONF0, OUTMUX4, __x)
+#define MCDE_SSP 0x00000008
+#define MCDE_SSP_SSPDATA_SHIFT 0
+#define MCDE_SSP_SSPDATA_MASK 0x000000FF
+#define MCDE_SSP_SSPDATA(__x) \
+	MCDE_VAL2REG(MCDE_SSP, SSPDATA, __x)
+#define MCDE_SSP_SSPCMD_SHIFT 8
+#define MCDE_SSP_SSPCMD_MASK 0x00000100
+#define MCDE_SSP_SSPCMD_DATA 0
+#define MCDE_SSP_SSPCMD_COMMAND 1
+#define MCDE_SSP_SSPCMD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_SSP, SSPCMD, MCDE_SSP_SSPCMD_##__x)
+#define MCDE_SSP_SSPCMD(__x) \
+	MCDE_VAL2REG(MCDE_SSP, SSPCMD, __x)
+#define MCDE_SSP_SSPEN_SHIFT 16
+#define MCDE_SSP_SSPEN_MASK 0x00010000
+#define MCDE_SSP_SSPEN(__x) \
+	MCDE_VAL2REG(MCDE_SSP, SSPEN, __x)
+#define MCDE_AIS 0x00000100
+#define MCDE_AIS_MCDEPPI_SHIFT 0
+#define MCDE_AIS_MCDEPPI_MASK 0x00000001
+#define MCDE_AIS_MCDEPPI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, MCDEPPI, __x)
+#define MCDE_AIS_MCDEOVLI_SHIFT 1
+#define MCDE_AIS_MCDEOVLI_MASK 0x00000002
+#define MCDE_AIS_MCDEOVLI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, MCDEOVLI, __x)
+#define MCDE_AIS_MCDECHNLI_SHIFT 2
+#define MCDE_AIS_MCDECHNLI_MASK 0x00000004
+#define MCDE_AIS_MCDECHNLI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, MCDECHNLI, __x)
+#define MCDE_AIS_MCDEERRI_SHIFT 3
+#define MCDE_AIS_MCDEERRI_MASK 0x00000008
+#define MCDE_AIS_MCDEERRI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, MCDEERRI, __x)
+#define MCDE_AIS_DSI0AI_SHIFT 4
+#define MCDE_AIS_DSI0AI_MASK 0x00000010
+#define MCDE_AIS_DSI0AI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, DSI0AI, __x)
+#define MCDE_AIS_DSI1AI_SHIFT 5
+#define MCDE_AIS_DSI1AI_MASK 0x00000020
+#define MCDE_AIS_DSI1AI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, DSI1AI, __x)
+#define MCDE_AIS_DSI2AI_SHIFT 6
+#define MCDE_AIS_DSI2AI_MASK 0x00000040
+#define MCDE_AIS_DSI2AI(__x) \
+	MCDE_VAL2REG(MCDE_AIS, DSI2AI, __x)
+#define MCDE_IMSCPP 0x00000104
+#define MCDE_IMSCPP_VCMPAIM_SHIFT 0
+#define MCDE_IMSCPP_VCMPAIM_MASK 0x00000001
+#define MCDE_IMSCPP_VCMPAIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, VCMPAIM, __x)
+#define MCDE_IMSCPP_VCMPBIM_SHIFT 1
+#define MCDE_IMSCPP_VCMPBIM_MASK 0x00000002
+#define MCDE_IMSCPP_VCMPBIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, VCMPBIM, __x)
+#define MCDE_IMSCPP_VSCC0IM_SHIFT 2
+#define MCDE_IMSCPP_VSCC0IM_MASK 0x00000004
+#define MCDE_IMSCPP_VSCC0IM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, VSCC0IM, __x)
+#define MCDE_IMSCPP_VSCC1IM_SHIFT 3
+#define MCDE_IMSCPP_VSCC1IM_MASK 0x00000008
+#define MCDE_IMSCPP_VSCC1IM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, VSCC1IM, __x)
+#define MCDE_IMSCPP_VCMPC0IM_SHIFT 4
+#define MCDE_IMSCPP_VCMPC0IM_MASK 0x00000010
+#define MCDE_IMSCPP_VCMPC0IM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, VCMPC0IM, __x)
+#define MCDE_IMSCPP_VCMPC1IM_SHIFT 5
+#define MCDE_IMSCPP_VCMPC1IM_MASK 0x00000020
+#define MCDE_IMSCPP_VCMPC1IM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, VCMPC1IM, __x)
+#define MCDE_IMSCPP_ROTFDIM_B_SHIFT 6
+#define MCDE_IMSCPP_ROTFDIM_B_MASK 0x00000040
+#define MCDE_IMSCPP_ROTFDIM_B(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, ROTFDIM_B, __x)
+#define MCDE_IMSCPP_ROTFDIM_A_SHIFT 7
+#define MCDE_IMSCPP_ROTFDIM_A_MASK 0x00000080
+#define MCDE_IMSCPP_ROTFDIM_A(__x) \
+	MCDE_VAL2REG(MCDE_IMSCPP, ROTFDIM_A, __x)
+#define MCDE_IMSCOVL 0x00000108
+#define MCDE_IMSCOVL_OVLRDIM_SHIFT 0
+#define MCDE_IMSCOVL_OVLRDIM_MASK 0x0000FFFF
+#define MCDE_IMSCOVL_OVLRDIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCOVL, OVLRDIM, __x)
+#define MCDE_IMSCOVL_OVLFDIM_SHIFT 16
+#define MCDE_IMSCOVL_OVLFDIM_MASK 0xFFFF0000
+#define MCDE_IMSCOVL_OVLFDIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCOVL, OVLFDIM, __x)
+#define MCDE_IMSCCHNL 0x0000010C
+#define MCDE_IMSCCHNL_CHNLRDIM_SHIFT 0
+#define MCDE_IMSCCHNL_CHNLRDIM_MASK 0x0000FFFF
+#define MCDE_IMSCCHNL_CHNLRDIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCCHNL, CHNLRDIM, __x)
+#define MCDE_IMSCCHNL_CHNLAIM_SHIFT 16
+#define MCDE_IMSCCHNL_CHNLAIM_MASK 0xFFFF0000
+#define MCDE_IMSCCHNL_CHNLAIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCCHNL, CHNLAIM, __x)
+#define MCDE_IMSCERR 0x00000110
+#define MCDE_IMSCERR_FUAIM_SHIFT 0
+#define MCDE_IMSCERR_FUAIM_MASK 0x00000001
+#define MCDE_IMSCERR_FUAIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, FUAIM, __x)
+#define MCDE_IMSCERR_FUBIM_SHIFT 1
+#define MCDE_IMSCERR_FUBIM_MASK 0x00000002
+#define MCDE_IMSCERR_FUBIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, FUBIM, __x)
+#define MCDE_IMSCERR_SCHBLCKDIM_SHIFT 2
+#define MCDE_IMSCERR_SCHBLCKDIM_MASK 0x00000004
+#define MCDE_IMSCERR_SCHBLCKDIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, SCHBLCKDIM, __x)
+#define MCDE_IMSCERR_ROTAFEIM_WRITE_SHIFT 3
+#define MCDE_IMSCERR_ROTAFEIM_WRITE_MASK 0x00000008
+#define MCDE_IMSCERR_ROTAFEIM_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, ROTAFEIM_WRITE, __x)
+#define MCDE_IMSCERR_ROTAFEIM_READ_SHIFT 4
+#define MCDE_IMSCERR_ROTAFEIM_READ_MASK 0x00000010
+#define MCDE_IMSCERR_ROTAFEIM_READ(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, ROTAFEIM_READ, __x)
+#define MCDE_IMSCERR_ROTBFEIM_WRITE_SHIFT 5
+#define MCDE_IMSCERR_ROTBFEIM_WRITE_MASK 0x00000020
+#define MCDE_IMSCERR_ROTBFEIM_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, ROTBFEIM_WRITE, __x)
+#define MCDE_IMSCERR_ROTBFEIM_READ_SHIFT 6
+#define MCDE_IMSCERR_ROTBFEIM_READ_MASK 0x00000040
+#define MCDE_IMSCERR_ROTBFEIM_READ(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, ROTBFEIM_READ, __x)
+#define MCDE_IMSCERR_FUC0IM_SHIFT 7
+#define MCDE_IMSCERR_FUC0IM_MASK 0x00000080
+#define MCDE_IMSCERR_FUC0IM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, FUC0IM, __x)
+#define MCDE_IMSCERR_FUC1IM_SHIFT 8
+#define MCDE_IMSCERR_FUC1IM_MASK 0x00000100
+#define MCDE_IMSCERR_FUC1IM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, FUC1IM, __x)
+#define MCDE_IMSCERR_OVLFERRIM_SHIFT 16
+#define MCDE_IMSCERR_OVLFERRIM_MASK 0xFFFF0000
+#define MCDE_IMSCERR_OVLFERRIM(__x) \
+	MCDE_VAL2REG(MCDE_IMSCERR, OVLFERRIM, __x)
+#define MCDE_RISPP 0x00000114
+#define MCDE_RISPP_VCMPARIS_SHIFT 0
+#define MCDE_RISPP_VCMPARIS_MASK 0x00000001
+#define MCDE_RISPP_VCMPARIS(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, VCMPARIS, __x)
+#define MCDE_RISPP_VCMPBRIS_SHIFT 1
+#define MCDE_RISPP_VCMPBRIS_MASK 0x00000002
+#define MCDE_RISPP_VCMPBRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, VCMPBRIS, __x)
+#define MCDE_RISPP_VSCC0RIS_SHIFT 2
+#define MCDE_RISPP_VSCC0RIS_MASK 0x00000004
+#define MCDE_RISPP_VSCC0RIS(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, VSCC0RIS, __x)
+#define MCDE_RISPP_VSCC1RIS_SHIFT 3
+#define MCDE_RISPP_VSCC1RIS_MASK 0x00000008
+#define MCDE_RISPP_VSCC1RIS(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, VSCC1RIS, __x)
+#define MCDE_RISPP_VCMPC0RIS_SHIFT 4
+#define MCDE_RISPP_VCMPC0RIS_MASK 0x00000010
+#define MCDE_RISPP_VCMPC0RIS(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, VCMPC0RIS, __x)
+#define MCDE_RISPP_VCMPC1RIS_SHIFT 5
+#define MCDE_RISPP_VCMPC1RIS_MASK 0x00000020
+#define MCDE_RISPP_VCMPC1RIS(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, VCMPC1RIS, __x)
+#define MCDE_RISPP_ROTFDRIS_B_SHIFT 6
+#define MCDE_RISPP_ROTFDRIS_B_MASK 0x00000040
+#define MCDE_RISPP_ROTFDRIS_B(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, ROTFDRIS_B, __x)
+#define MCDE_RISPP_ROTFDRIS_A_SHIFT 7
+#define MCDE_RISPP_ROTFDRIS_A_MASK 0x00000080
+#define MCDE_RISPP_ROTFDRIS_A(__x) \
+	MCDE_VAL2REG(MCDE_RISPP, ROTFDRIS_A, __x)
+#define MCDE_RISOVL 0x00000118
+#define MCDE_RISOVL_OVLRDRIS_SHIFT 0
+#define MCDE_RISOVL_OVLRDRIS_MASK 0x0000FFFF
+#define MCDE_RISOVL_OVLRDRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISOVL, OVLRDRIS, __x)
+#define MCDE_RISOVL_OVLFDRIS_SHIFT 16
+#define MCDE_RISOVL_OVLFDRIS_MASK 0xFFFF0000
+#define MCDE_RISOVL_OVLFDRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISOVL, OVLFDRIS, __x)
+#define MCDE_RISCHNL 0x0000011C
+#define MCDE_RISCHNL_CHNLRDRIS_SHIFT 0
+#define MCDE_RISCHNL_CHNLRDRIS_MASK 0x0000FFFF
+#define MCDE_RISCHNL_CHNLRDRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISCHNL, CHNLRDRIS, __x)
+#define MCDE_RISCHNL_CHNLARIS_SHIFT 16
+#define MCDE_RISCHNL_CHNLARIS_MASK 0xFFFF0000
+#define MCDE_RISCHNL_CHNLARIS(__x) \
+	MCDE_VAL2REG(MCDE_RISCHNL, CHNLARIS, __x)
+#define MCDE_RISERR 0x00000120
+#define MCDE_RISERR_FUARIS_SHIFT 0
+#define MCDE_RISERR_FUARIS_MASK 0x00000001
+#define MCDE_RISERR_FUARIS(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, FUARIS, __x)
+#define MCDE_RISERR_FUBRIS_SHIFT 1
+#define MCDE_RISERR_FUBRIS_MASK 0x00000002
+#define MCDE_RISERR_FUBRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, FUBRIS, __x)
+#define MCDE_RISERR_SCHBLCKDRIS_SHIFT 2
+#define MCDE_RISERR_SCHBLCKDRIS_MASK 0x00000004
+#define MCDE_RISERR_SCHBLCKDRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, SCHBLCKDRIS, __x)
+#define MCDE_RISERR_ROTAFERIS_WRITE_SHIFT 3
+#define MCDE_RISERR_ROTAFERIS_WRITE_MASK 0x00000008
+#define MCDE_RISERR_ROTAFERIS_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, ROTAFERIS_WRITE, __x)
+#define MCDE_RISERR_ROTAFERIS_READ_SHIFT 4
+#define MCDE_RISERR_ROTAFERIS_READ_MASK 0x00000010
+#define MCDE_RISERR_ROTAFERIS_READ(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, ROTAFERIS_READ, __x)
+#define MCDE_RISERR_ROTBFERIS_WRITE_SHIFT 5
+#define MCDE_RISERR_ROTBFERIS_WRITE_MASK 0x00000020
+#define MCDE_RISERR_ROTBFERIS_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, ROTBFERIS_WRITE, __x)
+#define MCDE_RISERR_ROTBFERIS_READ_SHIFT 6
+#define MCDE_RISERR_ROTBFERIS_READ_MASK 0x00000040
+#define MCDE_RISERR_ROTBFERIS_READ(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, ROTBFERIS_READ, __x)
+#define MCDE_RISERR_FUC0RIS_SHIFT 7
+#define MCDE_RISERR_FUC0RIS_MASK 0x00000080
+#define MCDE_RISERR_FUC0RIS(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, FUC0RIS, __x)
+#define MCDE_RISERR_FUC1RIS_SHIFT 8
+#define MCDE_RISERR_FUC1RIS_MASK 0x00000100
+#define MCDE_RISERR_FUC1RIS(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, FUC1RIS, __x)
+#define MCDE_RISERR_OVLFERRRIS_SHIFT 16
+#define MCDE_RISERR_OVLFERRRIS_MASK 0xFFFF0000
+#define MCDE_RISERR_OVLFERRRIS(__x) \
+	MCDE_VAL2REG(MCDE_RISERR, OVLFERRRIS, __x)
+#define MCDE_MISPP 0x00000124
+#define MCDE_MISPP_VCMPAMIS_SHIFT 0
+#define MCDE_MISPP_VCMPAMIS_MASK 0x00000001
+#define MCDE_MISPP_VCMPAMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, VCMPAMIS, __x)
+#define MCDE_MISPP_VCMPBMIS_SHIFT 1
+#define MCDE_MISPP_VCMPBMIS_MASK 0x00000002
+#define MCDE_MISPP_VCMPBMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, VCMPBMIS, __x)
+#define MCDE_MISPP_VSCC0MIS_SHIFT 2
+#define MCDE_MISPP_VSCC0MIS_MASK 0x00000004
+#define MCDE_MISPP_VSCC0MIS(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, VSCC0MIS, __x)
+#define MCDE_MISPP_VSCC1MIS_SHIFT 3
+#define MCDE_MISPP_VSCC1MIS_MASK 0x00000008
+#define MCDE_MISPP_VSCC1MIS(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, VSCC1MIS, __x)
+#define MCDE_MISPP_VCMPC0MIS_SHIFT 4
+#define MCDE_MISPP_VCMPC0MIS_MASK 0x00000010
+#define MCDE_MISPP_VCMPC0MIS(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, VCMPC0MIS, __x)
+#define MCDE_MISPP_VCMPC1MIS_SHIFT 5
+#define MCDE_MISPP_VCMPC1MIS_MASK 0x00000020
+#define MCDE_MISPP_VCMPC1MIS(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, VCMPC1MIS, __x)
+#define MCDE_MISPP_ROTFDMIS_A_SHIFT 6
+#define MCDE_MISPP_ROTFDMIS_A_MASK 0x00000040
+#define MCDE_MISPP_ROTFDMIS_A(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, ROTFDMIS_A, __x)
+#define MCDE_MISPP_ROTFDMIS_B_SHIFT 7
+#define MCDE_MISPP_ROTFDMIS_B_MASK 0x00000080
+#define MCDE_MISPP_ROTFDMIS_B(__x) \
+	MCDE_VAL2REG(MCDE_MISPP, ROTFDMIS_B, __x)
+#define MCDE_MISOVL 0x00000128
+#define MCDE_MISOVL_OVLRDMIS_SHIFT 0
+#define MCDE_MISOVL_OVLRDMIS_MASK 0x0000FFFF
+#define MCDE_MISOVL_OVLRDMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISOVL, OVLRDMIS, __x)
+#define MCDE_MISOVL_OVLFDMIS_SHIFT 16
+#define MCDE_MISOVL_OVLFDMIS_MASK 0xFFFF0000
+#define MCDE_MISOVL_OVLFDMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISOVL, OVLFDMIS, __x)
+#define MCDE_MISCHNL 0x0000012C
+#define MCDE_MISCHNL_CHNLRDMIS_SHIFT 0
+#define MCDE_MISCHNL_CHNLRDMIS_MASK 0x0000FFFF
+#define MCDE_MISCHNL_CHNLRDMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISCHNL, CHNLRDMIS, __x)
+#define MCDE_MISCHNL_CHNLAMIS_SHIFT 16
+#define MCDE_MISCHNL_CHNLAMIS_MASK 0xFFFF0000
+#define MCDE_MISCHNL_CHNLAMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISCHNL, CHNLAMIS, __x)
+#define MCDE_MISERR 0x00000130
+#define MCDE_MISERR_FUAMIS_SHIFT 0
+#define MCDE_MISERR_FUAMIS_MASK 0x00000001
+#define MCDE_MISERR_FUAMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, FUAMIS, __x)
+#define MCDE_MISERR_FUBMIS_SHIFT 1
+#define MCDE_MISERR_FUBMIS_MASK 0x00000002
+#define MCDE_MISERR_FUBMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, FUBMIS, __x)
+#define MCDE_MISERR_SCHBLCKDMIS_SHIFT 2
+#define MCDE_MISERR_SCHBLCKDMIS_MASK 0x00000004
+#define MCDE_MISERR_SCHBLCKDMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, SCHBLCKDMIS, __x)
+#define MCDE_MISERR_ROTAFEMIS_WRITE_SHIFT 3
+#define MCDE_MISERR_ROTAFEMIS_WRITE_MASK 0x00000008
+#define MCDE_MISERR_ROTAFEMIS_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, ROTAFEMIS_WRITE, __x)
+#define MCDE_MISERR_ROTAFEMIS_READ_SHIFT 4
+#define MCDE_MISERR_ROTAFEMIS_READ_MASK 0x00000010
+#define MCDE_MISERR_ROTAFEMIS_READ(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, ROTAFEMIS_READ, __x)
+#define MCDE_MISERR_ROTBFEMIS_WRITE_SHIFT 5
+#define MCDE_MISERR_ROTBFEMIS_WRITE_MASK 0x00000020
+#define MCDE_MISERR_ROTBFEMIS_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, ROTBFEMIS_WRITE, __x)
+#define MCDE_MISERR_ROTBFEMIS_READ_SHIFT 6
+#define MCDE_MISERR_ROTBFEMIS_READ_MASK 0x00000040
+#define MCDE_MISERR_ROTBFEMIS_READ(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, ROTBFEMIS_READ, __x)
+#define MCDE_MISERR_FUC0MIS_SHIFT 7
+#define MCDE_MISERR_FUC0MIS_MASK 0x00000080
+#define MCDE_MISERR_FUC0MIS(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, FUC0MIS, __x)
+#define MCDE_MISERR_FUC1MIS_SHIFT 8
+#define MCDE_MISERR_FUC1MIS_MASK 0x00000100
+#define MCDE_MISERR_FUC1MIS(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, FUC1MIS, __x)
+#define MCDE_MISERR_OVLFERMIS_SHIFT 16
+#define MCDE_MISERR_OVLFERMIS_MASK 0xFFFF0000
+#define MCDE_MISERR_OVLFERMIS(__x) \
+	MCDE_VAL2REG(MCDE_MISERR, OVLFERMIS, __x)
+#define MCDE_SISPP 0x00000134
+#define MCDE_SISPP_VCMPASIS_SHIFT 0
+#define MCDE_SISPP_VCMPASIS_MASK 0x00000001
+#define MCDE_SISPP_VCMPASIS(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, VCMPASIS, __x)
+#define MCDE_SISPP_VCMPBSIS_SHIFT 1
+#define MCDE_SISPP_VCMPBSIS_MASK 0x00000002
+#define MCDE_SISPP_VCMPBSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, VCMPBSIS, __x)
+#define MCDE_SISPP_VSCC0SIS_SHIFT 2
+#define MCDE_SISPP_VSCC0SIS_MASK 0x00000004
+#define MCDE_SISPP_VSCC0SIS(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, VSCC0SIS, __x)
+#define MCDE_SISPP_VSCC1SIS_SHIFT 3
+#define MCDE_SISPP_VSCC1SIS_MASK 0x00000008
+#define MCDE_SISPP_VSCC1SIS(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, VSCC1SIS, __x)
+#define MCDE_SISPP_VCMPC0SIS_SHIFT 4
+#define MCDE_SISPP_VCMPC0SIS_MASK 0x00000010
+#define MCDE_SISPP_VCMPC0SIS(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, VCMPC0SIS, __x)
+#define MCDE_SISPP_VCMPC1SIS_SHIFT 5
+#define MCDE_SISPP_VCMPC1SIS_MASK 0x00000020
+#define MCDE_SISPP_VCMPC1SIS(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, VCMPC1SIS, __x)
+#define MCDE_SISPP_ROTFDSIS_A_SHIFT 6
+#define MCDE_SISPP_ROTFDSIS_A_MASK 0x00000040
+#define MCDE_SISPP_ROTFDSIS_A(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, ROTFDSIS_A, __x)
+#define MCDE_SISPP_ROTFDSIS_B_SHIFT 7
+#define MCDE_SISPP_ROTFDSIS_B_MASK 0x00000080
+#define MCDE_SISPP_ROTFDSIS_B(__x) \
+	MCDE_VAL2REG(MCDE_SISPP, ROTFDSIS_B, __x)
+#define MCDE_SISOVL 0x00000138
+#define MCDE_SISOVL_OVLRDSIS_SHIFT 0
+#define MCDE_SISOVL_OVLRDSIS_MASK 0x0000FFFF
+#define MCDE_SISOVL_OVLRDSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISOVL, OVLRDSIS, __x)
+#define MCDE_SISOVL_OVLFDSIS_SHIFT 16
+#define MCDE_SISOVL_OVLFDSIS_MASK 0xFFFF0000
+#define MCDE_SISOVL_OVLFDSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISOVL, OVLFDSIS, __x)
+#define MCDE_SISCHNL 0x0000013C
+#define MCDE_SISCHNL_CHNLRDSIS_SHIFT 0
+#define MCDE_SISCHNL_CHNLRDSIS_MASK 0x0000FFFF
+#define MCDE_SISCHNL_CHNLRDSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISCHNL, CHNLRDSIS, __x)
+#define MCDE_SISCHNL_CHNLASIS_SHIFT 16
+#define MCDE_SISCHNL_CHNLASIS_MASK 0xFFFF0000
+#define MCDE_SISCHNL_CHNLASIS(__x) \
+	MCDE_VAL2REG(MCDE_SISCHNL, CHNLASIS, __x)
+#define MCDE_SISERR 0x00000140
+#define MCDE_SISERR_FUASIS_SHIFT 0
+#define MCDE_SISERR_FUASIS_MASK 0x00000001
+#define MCDE_SISERR_FUASIS(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, FUASIS, __x)
+#define MCDE_SISERR_FUBSIS_SHIFT 1
+#define MCDE_SISERR_FUBSIS_MASK 0x00000002
+#define MCDE_SISERR_FUBSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, FUBSIS, __x)
+#define MCDE_SISERR_SCHBLCKDSIS_SHIFT 2
+#define MCDE_SISERR_SCHBLCKDSIS_MASK 0x00000004
+#define MCDE_SISERR_SCHBLCKDSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, SCHBLCKDSIS, __x)
+#define MCDE_SISERR_ROTAFESIS_WRITE_SHIFT 3
+#define MCDE_SISERR_ROTAFESIS_WRITE_MASK 0x00000008
+#define MCDE_SISERR_ROTAFESIS_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, ROTAFESIS_WRITE, __x)
+#define MCDE_SISERR_ROTAFESIS_READ_SHIFT 4
+#define MCDE_SISERR_ROTAFESIS_READ_MASK 0x00000010
+#define MCDE_SISERR_ROTAFESIS_READ(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, ROTAFESIS_READ, __x)
+#define MCDE_SISERR_ROTBFESIS_WRITE_SHIFT 5
+#define MCDE_SISERR_ROTBFESIS_WRITE_MASK 0x00000020
+#define MCDE_SISERR_ROTBFESIS_WRITE(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, ROTBFESIS_WRITE, __x)
+#define MCDE_SISERR_ROTBFESIS_READ_SHIFT 6
+#define MCDE_SISERR_ROTBFESIS_READ_MASK 0x00000040
+#define MCDE_SISERR_ROTBFESIS_READ(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, ROTBFESIS_READ, __x)
+#define MCDE_SISERR_FUC0SIS_SHIFT 7
+#define MCDE_SISERR_FUC0SIS_MASK 0x00000080
+#define MCDE_SISERR_FUC0SIS(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, FUC0SIS, __x)
+#define MCDE_SISERR_FUC1SIS_SHIFT 8
+#define MCDE_SISERR_FUC1SIS_MASK 0x00000100
+#define MCDE_SISERR_FUC1SIS(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, FUC1SIS, __x)
+#define MCDE_SISERR_OVLFERSIS_SHIFT 16
+#define MCDE_SISERR_OVLFERSIS_MASK 0xFFFF0000
+#define MCDE_SISERR_OVLFERSIS(__x) \
+	MCDE_VAL2REG(MCDE_SISERR, OVLFERSIS, __x)
+#define MCDE_PID 0x000001FC
+#define MCDE_PID_METALFIX_VERSION_SHIFT 0
+#define MCDE_PID_METALFIX_VERSION_MASK 0x000000FF
+#define MCDE_PID_METALFIX_VERSION(__x) \
+	MCDE_VAL2REG(MCDE_PID, METALFIX_VERSION, __x)
+#define MCDE_PID_DEVELOPMENT_VERSION_SHIFT 8
+#define MCDE_PID_DEVELOPMENT_VERSION_MASK 0x0000FF00
+#define MCDE_PID_DEVELOPMENT_VERSION(__x) \
+	MCDE_VAL2REG(MCDE_PID, DEVELOPMENT_VERSION, __x)
+#define MCDE_PID_MINOR_VERSION_SHIFT 16
+#define MCDE_PID_MINOR_VERSION_MASK 0x00FF0000
+#define MCDE_PID_MINOR_VERSION(__x) \
+	MCDE_VAL2REG(MCDE_PID, MINOR_VERSION, __x)
+#define MCDE_PID_MAJOR_VERSION_SHIFT 24
+#define MCDE_PID_MAJOR_VERSION_MASK 0xFF000000
+#define MCDE_PID_MAJOR_VERSION(__x) \
+	MCDE_VAL2REG(MCDE_PID, MAJOR_VERSION, __x)
+#define MCDE_EXTSRC0A0 0x00000200
+#define MCDE_EXTSRC0A0_GROUPOFFSET 0x20
+#define MCDE_EXTSRC0A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC0A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC0A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC1A0 0x00000220
+#define MCDE_EXTSRC1A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC1A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC1A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC2A0 0x00000240
+#define MCDE_EXTSRC2A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC2A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC2A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC3A0 0x00000260
+#define MCDE_EXTSRC3A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC3A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC3A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC4A0 0x00000280
+#define MCDE_EXTSRC4A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC4A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC4A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC5A0 0x000002A0
+#define MCDE_EXTSRC5A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC5A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC5A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC6A0 0x000002C0
+#define MCDE_EXTSRC6A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC6A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC6A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC7A0 0x000002E0
+#define MCDE_EXTSRC7A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC7A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC7A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC8A0 0x00000300
+#define MCDE_EXTSRC8A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC8A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC8A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC9A0 0x00000320
+#define MCDE_EXTSRC9A0_BASEADDRESS0_SHIFT 3
+#define MCDE_EXTSRC9A0_BASEADDRESS0_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC9A0_BASEADDRESS0(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9A0, BASEADDRESS0, __x)
+#define MCDE_EXTSRC0A1 0x00000204
+#define MCDE_EXTSRC0A1_GROUPOFFSET 0x20
+#define MCDE_EXTSRC0A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC0A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC0A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC1A1 0x00000224
+#define MCDE_EXTSRC1A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC1A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC1A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC2A1 0x00000244
+#define MCDE_EXTSRC2A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC2A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC2A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC3A1 0x00000264
+#define MCDE_EXTSRC3A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC3A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC3A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC4A1 0x00000284
+#define MCDE_EXTSRC4A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC4A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC4A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC5A1 0x000002A4
+#define MCDE_EXTSRC5A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC5A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC5A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC6A1 0x000002C4
+#define MCDE_EXTSRC6A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC6A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC6A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC7A1 0x000002E4
+#define MCDE_EXTSRC7A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC7A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC7A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC8A1 0x00000304
+#define MCDE_EXTSRC8A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC8A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC8A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC9A1 0x00000324
+#define MCDE_EXTSRC9A1_BASEADDRESS1_SHIFT 3
+#define MCDE_EXTSRC9A1_BASEADDRESS1_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC9A1_BASEADDRESS1(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9A1, BASEADDRESS1, __x)
+#define MCDE_EXTSRC6A2 0x000002C8
+#define MCDE_EXTSRC6A2_BASEADDRESS2_SHIFT 3
+#define MCDE_EXTSRC6A2_BASEADDRESS2_MASK 0xFFFFFFF8
+#define MCDE_EXTSRC6A2_BASEADDRESS2(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6A2, BASEADDRESS2, __x)
+#define MCDE_EXTSRC0CONF 0x0000020C
+#define MCDE_EXTSRC0CONF_GROUPOFFSET 0x20
+#define MCDE_EXTSRC0CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC0CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC0CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BUF_ID, __x)
+#define MCDE_EXTSRC0CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC0CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC0CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BUF_NB, __x)
+#define MCDE_EXTSRC0CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC0CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC0CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC0CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC0CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC0CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC0CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC0CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC0CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC0CONF_BPP_RGB444 4
+#define MCDE_EXTSRC0CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC0CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC0CONF_BPP_RGB565 7
+#define MCDE_EXTSRC0CONF_BPP_RGB888 8
+#define MCDE_EXTSRC0CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC0CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC0CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC0CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BPP, MCDE_EXTSRC0CONF_BPP_##__x)
+#define MCDE_EXTSRC0CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BPP, __x)
+#define MCDE_EXTSRC0CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC0CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC0CONF_BGR_RGB 0
+#define MCDE_EXTSRC0CONF_BGR_BGR 1
+#define MCDE_EXTSRC0CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BGR, MCDE_EXTSRC0CONF_BGR_##__x)
+#define MCDE_EXTSRC0CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BGR, __x)
+#define MCDE_EXTSRC0CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC0CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC0CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC0CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC0CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BEBO, MCDE_EXTSRC0CONF_BEBO_##__x)
+#define MCDE_EXTSRC0CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BEBO, __x)
+#define MCDE_EXTSRC0CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC0CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC0CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC0CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC0CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BEPO, MCDE_EXTSRC0CONF_BEPO_##__x)
+#define MCDE_EXTSRC0CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CONF, BEPO, __x)
+#define MCDE_EXTSRC1CONF 0x0000022C
+#define MCDE_EXTSRC1CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC1CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC1CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BUF_ID, __x)
+#define MCDE_EXTSRC1CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC1CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC1CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BUF_NB, __x)
+#define MCDE_EXTSRC1CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC1CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC1CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC1CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC1CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC1CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC1CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC1CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC1CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC1CONF_BPP_RGB444 4
+#define MCDE_EXTSRC1CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC1CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC1CONF_BPP_RGB565 7
+#define MCDE_EXTSRC1CONF_BPP_RGB888 8
+#define MCDE_EXTSRC1CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC1CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC1CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC1CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BPP, MCDE_EXTSRC1CONF_BPP_##__x)
+#define MCDE_EXTSRC1CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BPP, __x)
+#define MCDE_EXTSRC1CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC1CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC1CONF_BGR_RGB 0
+#define MCDE_EXTSRC1CONF_BGR_BGR 1
+#define MCDE_EXTSRC1CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BGR, MCDE_EXTSRC1CONF_BGR_##__x)
+#define MCDE_EXTSRC1CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BGR, __x)
+#define MCDE_EXTSRC1CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC1CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC1CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC1CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC1CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BEBO, MCDE_EXTSRC1CONF_BEBO_##__x)
+#define MCDE_EXTSRC1CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BEBO, __x)
+#define MCDE_EXTSRC1CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC1CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC1CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC1CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC1CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BEPO, MCDE_EXTSRC1CONF_BEPO_##__x)
+#define MCDE_EXTSRC1CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CONF, BEPO, __x)
+#define MCDE_EXTSRC2CONF 0x0000024C
+#define MCDE_EXTSRC2CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC2CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC2CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BUF_ID, __x)
+#define MCDE_EXTSRC2CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC2CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC2CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BUF_NB, __x)
+#define MCDE_EXTSRC2CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC2CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC2CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC2CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC2CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC2CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC2CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC2CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC2CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC2CONF_BPP_RGB444 4
+#define MCDE_EXTSRC2CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC2CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC2CONF_BPP_RGB565 7
+#define MCDE_EXTSRC2CONF_BPP_RGB888 8
+#define MCDE_EXTSRC2CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC2CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC2CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC2CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BPP, MCDE_EXTSRC2CONF_BPP_##__x)
+#define MCDE_EXTSRC2CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BPP, __x)
+#define MCDE_EXTSRC2CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC2CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC2CONF_BGR_RGB 0
+#define MCDE_EXTSRC2CONF_BGR_BGR 1
+#define MCDE_EXTSRC2CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BGR, MCDE_EXTSRC2CONF_BGR_##__x)
+#define MCDE_EXTSRC2CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BGR, __x)
+#define MCDE_EXTSRC2CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC2CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC2CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC2CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC2CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BEBO, MCDE_EXTSRC2CONF_BEBO_##__x)
+#define MCDE_EXTSRC2CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BEBO, __x)
+#define MCDE_EXTSRC2CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC2CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC2CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC2CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC2CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BEPO, MCDE_EXTSRC2CONF_BEPO_##__x)
+#define MCDE_EXTSRC2CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CONF, BEPO, __x)
+#define MCDE_EXTSRC3CONF 0x0000026C
+#define MCDE_EXTSRC3CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC3CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC3CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BUF_ID, __x)
+#define MCDE_EXTSRC3CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC3CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC3CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BUF_NB, __x)
+#define MCDE_EXTSRC3CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC3CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC3CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC3CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC3CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC3CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC3CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC3CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC3CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC3CONF_BPP_RGB444 4
+#define MCDE_EXTSRC3CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC3CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC3CONF_BPP_RGB565 7
+#define MCDE_EXTSRC3CONF_BPP_RGB888 8
+#define MCDE_EXTSRC3CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC3CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC3CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC3CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BPP, MCDE_EXTSRC3CONF_BPP_##__x)
+#define MCDE_EXTSRC3CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BPP, __x)
+#define MCDE_EXTSRC3CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC3CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC3CONF_BGR_RGB 0
+#define MCDE_EXTSRC3CONF_BGR_BGR 1
+#define MCDE_EXTSRC3CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BGR, MCDE_EXTSRC3CONF_BGR_##__x)
+#define MCDE_EXTSRC3CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BGR, __x)
+#define MCDE_EXTSRC3CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC3CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC3CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC3CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC3CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BEBO, MCDE_EXTSRC3CONF_BEBO_##__x)
+#define MCDE_EXTSRC3CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BEBO, __x)
+#define MCDE_EXTSRC3CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC3CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC3CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC3CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC3CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BEPO, MCDE_EXTSRC3CONF_BEPO_##__x)
+#define MCDE_EXTSRC3CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CONF, BEPO, __x)
+#define MCDE_EXTSRC4CONF 0x0000028C
+#define MCDE_EXTSRC4CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC4CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC4CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BUF_ID, __x)
+#define MCDE_EXTSRC4CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC4CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC4CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BUF_NB, __x)
+#define MCDE_EXTSRC4CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC4CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC4CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC4CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC4CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC4CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC4CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC4CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC4CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC4CONF_BPP_RGB444 4
+#define MCDE_EXTSRC4CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC4CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC4CONF_BPP_RGB565 7
+#define MCDE_EXTSRC4CONF_BPP_RGB888 8
+#define MCDE_EXTSRC4CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC4CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC4CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC4CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BPP, MCDE_EXTSRC4CONF_BPP_##__x)
+#define MCDE_EXTSRC4CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BPP, __x)
+#define MCDE_EXTSRC4CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC4CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC4CONF_BGR_RGB 0
+#define MCDE_EXTSRC4CONF_BGR_BGR 1
+#define MCDE_EXTSRC4CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BGR, MCDE_EXTSRC4CONF_BGR_##__x)
+#define MCDE_EXTSRC4CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BGR, __x)
+#define MCDE_EXTSRC4CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC4CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC4CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC4CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC4CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BEBO, MCDE_EXTSRC4CONF_BEBO_##__x)
+#define MCDE_EXTSRC4CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BEBO, __x)
+#define MCDE_EXTSRC4CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC4CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC4CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC4CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC4CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BEPO, MCDE_EXTSRC4CONF_BEPO_##__x)
+#define MCDE_EXTSRC4CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CONF, BEPO, __x)
+#define MCDE_EXTSRC5CONF 0x000002AC
+#define MCDE_EXTSRC5CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC5CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC5CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BUF_ID, __x)
+#define MCDE_EXTSRC5CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC5CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC5CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BUF_NB, __x)
+#define MCDE_EXTSRC5CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC5CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC5CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC5CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC5CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC5CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC5CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC5CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC5CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC5CONF_BPP_RGB444 4
+#define MCDE_EXTSRC5CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC5CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC5CONF_BPP_RGB565 7
+#define MCDE_EXTSRC5CONF_BPP_RGB888 8
+#define MCDE_EXTSRC5CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC5CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC5CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC5CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BPP, MCDE_EXTSRC5CONF_BPP_##__x)
+#define MCDE_EXTSRC5CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BPP, __x)
+#define MCDE_EXTSRC5CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC5CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC5CONF_BGR_RGB 0
+#define MCDE_EXTSRC5CONF_BGR_BGR 1
+#define MCDE_EXTSRC5CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BGR, MCDE_EXTSRC5CONF_BGR_##__x)
+#define MCDE_EXTSRC5CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BGR, __x)
+#define MCDE_EXTSRC5CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC5CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC5CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC5CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC5CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BEBO, MCDE_EXTSRC5CONF_BEBO_##__x)
+#define MCDE_EXTSRC5CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BEBO, __x)
+#define MCDE_EXTSRC5CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC5CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC5CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC5CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC5CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BEPO, MCDE_EXTSRC5CONF_BEPO_##__x)
+#define MCDE_EXTSRC5CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CONF, BEPO, __x)
+#define MCDE_EXTSRC6CONF 0x000002CC
+#define MCDE_EXTSRC6CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC6CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC6CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BUF_ID, __x)
+#define MCDE_EXTSRC6CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC6CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC6CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BUF_NB, __x)
+#define MCDE_EXTSRC6CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC6CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC6CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC6CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC6CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC6CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC6CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC6CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC6CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC6CONF_BPP_RGB444 4
+#define MCDE_EXTSRC6CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC6CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC6CONF_BPP_RGB565 7
+#define MCDE_EXTSRC6CONF_BPP_RGB888 8
+#define MCDE_EXTSRC6CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC6CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC6CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC6CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BPP, MCDE_EXTSRC6CONF_BPP_##__x)
+#define MCDE_EXTSRC6CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BPP, __x)
+#define MCDE_EXTSRC6CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC6CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC6CONF_BGR_RGB 0
+#define MCDE_EXTSRC6CONF_BGR_BGR 1
+#define MCDE_EXTSRC6CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BGR, MCDE_EXTSRC6CONF_BGR_##__x)
+#define MCDE_EXTSRC6CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BGR, __x)
+#define MCDE_EXTSRC6CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC6CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC6CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC6CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC6CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BEBO, MCDE_EXTSRC6CONF_BEBO_##__x)
+#define MCDE_EXTSRC6CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BEBO, __x)
+#define MCDE_EXTSRC6CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC6CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC6CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC6CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC6CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BEPO, MCDE_EXTSRC6CONF_BEPO_##__x)
+#define MCDE_EXTSRC6CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CONF, BEPO, __x)
+#define MCDE_EXTSRC7CONF 0x000002EC
+#define MCDE_EXTSRC7CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC7CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC7CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BUF_ID, __x)
+#define MCDE_EXTSRC7CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC7CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC7CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BUF_NB, __x)
+#define MCDE_EXTSRC7CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC7CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC7CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC7CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC7CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC7CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC7CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC7CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC7CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC7CONF_BPP_RGB444 4
+#define MCDE_EXTSRC7CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC7CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC7CONF_BPP_RGB565 7
+#define MCDE_EXTSRC7CONF_BPP_RGB888 8
+#define MCDE_EXTSRC7CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC7CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC7CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC7CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BPP, MCDE_EXTSRC7CONF_BPP_##__x)
+#define MCDE_EXTSRC7CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BPP, __x)
+#define MCDE_EXTSRC7CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC7CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC7CONF_BGR_RGB 0
+#define MCDE_EXTSRC7CONF_BGR_BGR 1
+#define MCDE_EXTSRC7CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BGR, MCDE_EXTSRC7CONF_BGR_##__x)
+#define MCDE_EXTSRC7CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BGR, __x)
+#define MCDE_EXTSRC7CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC7CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC7CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC7CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC7CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BEBO, MCDE_EXTSRC7CONF_BEBO_##__x)
+#define MCDE_EXTSRC7CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BEBO, __x)
+#define MCDE_EXTSRC7CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC7CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC7CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC7CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC7CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BEPO, MCDE_EXTSRC7CONF_BEPO_##__x)
+#define MCDE_EXTSRC7CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CONF, BEPO, __x)
+#define MCDE_EXTSRC8CONF 0x0000030C
+#define MCDE_EXTSRC8CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC8CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC8CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BUF_ID, __x)
+#define MCDE_EXTSRC8CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC8CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC8CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BUF_NB, __x)
+#define MCDE_EXTSRC8CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC8CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC8CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC8CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC8CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC8CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC8CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC8CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC8CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC8CONF_BPP_RGB444 4
+#define MCDE_EXTSRC8CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC8CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC8CONF_BPP_RGB565 7
+#define MCDE_EXTSRC8CONF_BPP_RGB888 8
+#define MCDE_EXTSRC8CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC8CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC8CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC8CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BPP, MCDE_EXTSRC8CONF_BPP_##__x)
+#define MCDE_EXTSRC8CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BPP, __x)
+#define MCDE_EXTSRC8CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC8CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC8CONF_BGR_RGB 0
+#define MCDE_EXTSRC8CONF_BGR_BGR 1
+#define MCDE_EXTSRC8CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BGR, MCDE_EXTSRC8CONF_BGR_##__x)
+#define MCDE_EXTSRC8CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BGR, __x)
+#define MCDE_EXTSRC8CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC8CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC8CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC8CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC8CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BEBO, MCDE_EXTSRC8CONF_BEBO_##__x)
+#define MCDE_EXTSRC8CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BEBO, __x)
+#define MCDE_EXTSRC8CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC8CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC8CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC8CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC8CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BEPO, MCDE_EXTSRC8CONF_BEPO_##__x)
+#define MCDE_EXTSRC8CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CONF, BEPO, __x)
+#define MCDE_EXTSRC9CONF 0x0000032C
+#define MCDE_EXTSRC9CONF_BUF_ID_SHIFT 0
+#define MCDE_EXTSRC9CONF_BUF_ID_MASK 0x00000003
+#define MCDE_EXTSRC9CONF_BUF_ID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BUF_ID, __x)
+#define MCDE_EXTSRC9CONF_BUF_NB_SHIFT 2
+#define MCDE_EXTSRC9CONF_BUF_NB_MASK 0x0000000C
+#define MCDE_EXTSRC9CONF_BUF_NB(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BUF_NB, __x)
+#define MCDE_EXTSRC9CONF_PRI_OVLID_SHIFT 4
+#define MCDE_EXTSRC9CONF_PRI_OVLID_MASK 0x000000F0
+#define MCDE_EXTSRC9CONF_PRI_OVLID(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, PRI_OVLID, __x)
+#define MCDE_EXTSRC9CONF_BPP_SHIFT 8
+#define MCDE_EXTSRC9CONF_BPP_MASK 0x00000F00
+#define MCDE_EXTSRC9CONF_BPP_1BPP_PAL 0
+#define MCDE_EXTSRC9CONF_BPP_2BPP_PAL 1
+#define MCDE_EXTSRC9CONF_BPP_4BPP_PAL 2
+#define MCDE_EXTSRC9CONF_BPP_8BPP_PAL 3
+#define MCDE_EXTSRC9CONF_BPP_RGB444 4
+#define MCDE_EXTSRC9CONF_BPP_ARGB4444 5
+#define MCDE_EXTSRC9CONF_BPP_IRGB1555 6
+#define MCDE_EXTSRC9CONF_BPP_RGB565 7
+#define MCDE_EXTSRC9CONF_BPP_RGB888 8
+#define MCDE_EXTSRC9CONF_BPP_XRGB8888 9
+#define MCDE_EXTSRC9CONF_BPP_ARGB8888 10
+#define MCDE_EXTSRC9CONF_BPP_YCBCR422 11
+#define MCDE_EXTSRC9CONF_BPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BPP, MCDE_EXTSRC9CONF_BPP_##__x)
+#define MCDE_EXTSRC9CONF_BPP(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BPP, __x)
+#define MCDE_EXTSRC9CONF_BGR_SHIFT 12
+#define MCDE_EXTSRC9CONF_BGR_MASK 0x00001000
+#define MCDE_EXTSRC9CONF_BGR_RGB 0
+#define MCDE_EXTSRC9CONF_BGR_BGR 1
+#define MCDE_EXTSRC9CONF_BGR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BGR, MCDE_EXTSRC9CONF_BGR_##__x)
+#define MCDE_EXTSRC9CONF_BGR(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BGR, __x)
+#define MCDE_EXTSRC9CONF_BEBO_SHIFT 13
+#define MCDE_EXTSRC9CONF_BEBO_MASK 0x00002000
+#define MCDE_EXTSRC9CONF_BEBO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC9CONF_BEBO_BIG_ENDIAN 1
+#define MCDE_EXTSRC9CONF_BEBO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BEBO, MCDE_EXTSRC9CONF_BEBO_##__x)
+#define MCDE_EXTSRC9CONF_BEBO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BEBO, __x)
+#define MCDE_EXTSRC9CONF_BEPO_SHIFT 14
+#define MCDE_EXTSRC9CONF_BEPO_MASK 0x00004000
+#define MCDE_EXTSRC9CONF_BEPO_LITTLE_ENDIAN 0
+#define MCDE_EXTSRC9CONF_BEPO_BIG_ENDIAN 1
+#define MCDE_EXTSRC9CONF_BEPO_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BEPO, MCDE_EXTSRC9CONF_BEPO_##__x)
+#define MCDE_EXTSRC9CONF_BEPO(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CONF, BEPO, __x)
+#define MCDE_EXTSRC0CR 0x00000210
+#define MCDE_EXTSRC0CR_GROUPOFFSET 0x20
+#define MCDE_EXTSRC0CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC0CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC0CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC0CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC0CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC0CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CR, SEL_MOD, MCDE_EXTSRC0CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC0CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CR, SEL_MOD, __x)
+#define MCDE_EXTSRC0CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC0CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC0CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC0CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC0CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC0CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC0CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC0CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC0CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC0CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC0CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC0CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC0CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC0CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC1CR 0x00000230
+#define MCDE_EXTSRC1CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC1CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC1CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC1CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC1CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC1CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CR, SEL_MOD, MCDE_EXTSRC1CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC1CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CR, SEL_MOD, __x)
+#define MCDE_EXTSRC1CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC1CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC1CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC1CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC1CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC1CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC1CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC1CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC1CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC1CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC1CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC1CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC1CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC1CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC2CR 0x00000250
+#define MCDE_EXTSRC2CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC2CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC2CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC2CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC2CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC2CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CR, SEL_MOD, MCDE_EXTSRC2CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC2CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CR, SEL_MOD, __x)
+#define MCDE_EXTSRC2CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC2CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC2CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC2CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC2CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC2CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC2CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC2CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC2CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC2CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC2CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC2CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC2CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC2CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC3CR 0x00000270
+#define MCDE_EXTSRC3CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC3CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC3CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC3CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC3CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC3CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CR, SEL_MOD, MCDE_EXTSRC3CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC3CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CR, SEL_MOD, __x)
+#define MCDE_EXTSRC3CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC3CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC3CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC3CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC3CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC3CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC3CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC3CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC3CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC3CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC3CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC3CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC3CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC3CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC4CR 0x00000290
+#define MCDE_EXTSRC4CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC4CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC4CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC4CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC4CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC4CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CR, SEL_MOD, MCDE_EXTSRC4CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC4CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CR, SEL_MOD, __x)
+#define MCDE_EXTSRC4CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC4CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC4CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC4CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC4CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC4CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC4CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC4CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC4CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC4CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC4CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC4CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC4CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC4CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC5CR 0x000002B0
+#define MCDE_EXTSRC5CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC5CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC5CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC5CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC5CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC5CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CR, SEL_MOD, MCDE_EXTSRC5CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC5CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CR, SEL_MOD, __x)
+#define MCDE_EXTSRC5CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC5CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC5CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC5CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC5CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC5CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC5CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC5CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC5CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC5CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC5CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC5CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC5CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC5CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC6CR 0x000002D0
+#define MCDE_EXTSRC6CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC6CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC6CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC6CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC6CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC6CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CR, SEL_MOD, MCDE_EXTSRC6CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC6CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CR, SEL_MOD, __x)
+#define MCDE_EXTSRC6CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC6CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC6CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC6CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC6CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC6CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC6CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC6CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC6CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC6CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC6CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC6CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC6CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC6CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC7CR 0x000002F0
+#define MCDE_EXTSRC7CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC7CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC7CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC7CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC7CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC7CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CR, SEL_MOD, MCDE_EXTSRC7CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC7CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CR, SEL_MOD, __x)
+#define MCDE_EXTSRC7CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC7CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC7CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC7CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC7CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC7CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC7CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC7CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC7CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC7CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC7CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC7CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC7CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC7CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC8CR 0x00000310
+#define MCDE_EXTSRC8CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC8CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC8CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC8CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC8CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC8CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CR, SEL_MOD, MCDE_EXTSRC8CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC8CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CR, SEL_MOD, __x)
+#define MCDE_EXTSRC8CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC8CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC8CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC8CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC8CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC8CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC8CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC8CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC8CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC8CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC8CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC8CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC8CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC8CR, FORCE_FS_DIV, __x)
+#define MCDE_EXTSRC9CR 0x00000330
+#define MCDE_EXTSRC9CR_SEL_MOD_SHIFT 0
+#define MCDE_EXTSRC9CR_SEL_MOD_MASK 0x00000003
+#define MCDE_EXTSRC9CR_SEL_MOD_EXTERNAL_SEL 0
+#define MCDE_EXTSRC9CR_SEL_MOD_AUTO_TOGGLE 1
+#define MCDE_EXTSRC9CR_SEL_MOD_SOFTWARE_SEL 2
+#define MCDE_EXTSRC9CR_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CR, SEL_MOD, MCDE_EXTSRC9CR_SEL_MOD_##__x)
+#define MCDE_EXTSRC9CR_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CR, SEL_MOD, __x)
+#define MCDE_EXTSRC9CR_MULTIOVL_CTRL_SHIFT 2
+#define MCDE_EXTSRC9CR_MULTIOVL_CTRL_MASK 0x00000004
+#define MCDE_EXTSRC9CR_MULTIOVL_CTRL_ALL 0
+#define MCDE_EXTSRC9CR_MULTIOVL_CTRL_PRIMARY 1
+#define MCDE_EXTSRC9CR_MULTIOVL_CTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CR, MULTIOVL_CTRL, \
+	MCDE_EXTSRC9CR_MULTIOVL_CTRL_##__x)
+#define MCDE_EXTSRC9CR_MULTIOVL_CTRL(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CR, MULTIOVL_CTRL, __x)
+#define MCDE_EXTSRC9CR_FS_DIV_DISABLE_SHIFT 3
+#define MCDE_EXTSRC9CR_FS_DIV_DISABLE_MASK 0x00000008
+#define MCDE_EXTSRC9CR_FS_DIV_DISABLE(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CR, FS_DIV_DISABLE, __x)
+#define MCDE_EXTSRC9CR_FORCE_FS_DIV_SHIFT 4
+#define MCDE_EXTSRC9CR_FORCE_FS_DIV_MASK 0x00000010
+#define MCDE_EXTSRC9CR_FORCE_FS_DIV(__x) \
+	MCDE_VAL2REG(MCDE_EXTSRC9CR, FORCE_FS_DIV, __x)
+#define MCDE_OVL0CR 0x00000400
+#define MCDE_OVL0CR_GROUPOFFSET 0x20
+#define MCDE_OVL0CR_OVLEN_SHIFT 0
+#define MCDE_OVL0CR_OVLEN_MASK 0x00000001
+#define MCDE_OVL0CR_OVLEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, OVLEN, __x)
+#define MCDE_OVL0CR_COLCCTRL_SHIFT 1
+#define MCDE_OVL0CR_COLCCTRL_MASK 0x00000006
+#define MCDE_OVL0CR_COLCCTRL_DISABLED 0
+#define MCDE_OVL0CR_COLCCTRL_ENABLED_NO_SAT 1
+#define MCDE_OVL0CR_COLCCTRL_ENABLED_SAT 2
+#define MCDE_OVL0CR_COLCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, COLCCTRL, MCDE_OVL0CR_COLCCTRL_##__x)
+#define MCDE_OVL0CR_COLCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, COLCCTRL, __x)
+#define MCDE_OVL0CR_CKEYGEN_SHIFT 3
+#define MCDE_OVL0CR_CKEYGEN_MASK 0x00000008
+#define MCDE_OVL0CR_CKEYGEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, CKEYGEN, __x)
+#define MCDE_OVL0CR_ALPHAPMEN_SHIFT 4
+#define MCDE_OVL0CR_ALPHAPMEN_MASK 0x00000010
+#define MCDE_OVL0CR_ALPHAPMEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, ALPHAPMEN, __x)
+#define MCDE_OVL0CR_OVLF_SHIFT 5
+#define MCDE_OVL0CR_OVLF_MASK 0x00000020
+#define MCDE_OVL0CR_OVLF(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, OVLF, __x)
+#define MCDE_OVL0CR_OVLR_SHIFT 6
+#define MCDE_OVL0CR_OVLR_MASK 0x00000040
+#define MCDE_OVL0CR_OVLR(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, OVLR, __x)
+#define MCDE_OVL0CR_OVLB_SHIFT 7
+#define MCDE_OVL0CR_OVLB_MASK 0x00000080
+#define MCDE_OVL0CR_OVLB(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, OVLB, __x)
+#define MCDE_OVL0CR_FETCH_ROPC_SHIFT 8
+#define MCDE_OVL0CR_FETCH_ROPC_MASK 0x0000FF00
+#define MCDE_OVL0CR_FETCH_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, FETCH_ROPC, __x)
+#define MCDE_OVL0CR_STBPRIO_SHIFT 16
+#define MCDE_OVL0CR_STBPRIO_MASK 0x000F0000
+#define MCDE_OVL0CR_STBPRIO(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, STBPRIO, __x)
+#define MCDE_OVL0CR_BURSTSIZE_SHIFT 20
+#define MCDE_OVL0CR_BURSTSIZE_MASK 0x00F00000
+#define MCDE_OVL0CR_BURSTSIZE_1W 0
+#define MCDE_OVL0CR_BURSTSIZE_2W 1
+#define MCDE_OVL0CR_BURSTSIZE_4W 2
+#define MCDE_OVL0CR_BURSTSIZE_8W 3
+#define MCDE_OVL0CR_BURSTSIZE_16W 4
+#define MCDE_OVL0CR_BURSTSIZE_HW_1W 8
+#define MCDE_OVL0CR_BURSTSIZE_HW_2W 9
+#define MCDE_OVL0CR_BURSTSIZE_HW_4W 10
+#define MCDE_OVL0CR_BURSTSIZE_HW_8W 11
+#define MCDE_OVL0CR_BURSTSIZE_HW_16W 12
+#define MCDE_OVL0CR_BURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, BURSTSIZE, MCDE_OVL0CR_BURSTSIZE_##__x)
+#define MCDE_OVL0CR_BURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, BURSTSIZE, __x)
+#define MCDE_OVL0CR_MAXOUTSTANDING_SHIFT 24
+#define MCDE_OVL0CR_MAXOUTSTANDING_MASK 0x0F000000
+#define MCDE_OVL0CR_MAXOUTSTANDING_1_REQ 0
+#define MCDE_OVL0CR_MAXOUTSTANDING_2_REQ 1
+#define MCDE_OVL0CR_MAXOUTSTANDING_4_REQ 2
+#define MCDE_OVL0CR_MAXOUTSTANDING_8_REQ 3
+#define MCDE_OVL0CR_MAXOUTSTANDING_16_REQ 4
+#define MCDE_OVL0CR_MAXOUTSTANDING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, MAXOUTSTANDING, \
+	MCDE_OVL0CR_MAXOUTSTANDING_##__x)
+#define MCDE_OVL0CR_MAXOUTSTANDING(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, MAXOUTSTANDING, __x)
+#define MCDE_OVL0CR_ROTBURSTSIZE_SHIFT 28
+#define MCDE_OVL0CR_ROTBURSTSIZE_MASK 0xF0000000
+#define MCDE_OVL0CR_ROTBURSTSIZE_1W 0
+#define MCDE_OVL0CR_ROTBURSTSIZE_2W 1
+#define MCDE_OVL0CR_ROTBURSTSIZE_4W 2
+#define MCDE_OVL0CR_ROTBURSTSIZE_8W 3
+#define MCDE_OVL0CR_ROTBURSTSIZE_16W 4
+#define MCDE_OVL0CR_ROTBURSTSIZE_HW_1W 8
+#define MCDE_OVL0CR_ROTBURSTSIZE_HW_2W 9
+#define MCDE_OVL0CR_ROTBURSTSIZE_HW_4W 10
+#define MCDE_OVL0CR_ROTBURSTSIZE_HW_8W 11
+#define MCDE_OVL0CR_ROTBURSTSIZE_HW_16W 12
+#define MCDE_OVL0CR_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, ROTBURSTSIZE, MCDE_OVL0CR_ROTBURSTSIZE_##__x)
+#define MCDE_OVL0CR_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CR, ROTBURSTSIZE, __x)
+#define MCDE_OVL1CR 0x00000420
+#define MCDE_OVL1CR_OVLEN_SHIFT 0
+#define MCDE_OVL1CR_OVLEN_MASK 0x00000001
+#define MCDE_OVL1CR_OVLEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, OVLEN, __x)
+#define MCDE_OVL1CR_COLCCTRL_SHIFT 1
+#define MCDE_OVL1CR_COLCCTRL_MASK 0x00000006
+#define MCDE_OVL1CR_COLCCTRL_DISABLED 0
+#define MCDE_OVL1CR_COLCCTRL_ENABLED_NO_SAT 1
+#define MCDE_OVL1CR_COLCCTRL_ENABLED_SAT 2
+#define MCDE_OVL1CR_COLCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, COLCCTRL, MCDE_OVL1CR_COLCCTRL_##__x)
+#define MCDE_OVL1CR_COLCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, COLCCTRL, __x)
+#define MCDE_OVL1CR_CKEYGEN_SHIFT 3
+#define MCDE_OVL1CR_CKEYGEN_MASK 0x00000008
+#define MCDE_OVL1CR_CKEYGEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, CKEYGEN, __x)
+#define MCDE_OVL1CR_ALPHAPMEN_SHIFT 4
+#define MCDE_OVL1CR_ALPHAPMEN_MASK 0x00000010
+#define MCDE_OVL1CR_ALPHAPMEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, ALPHAPMEN, __x)
+#define MCDE_OVL1CR_OVLF_SHIFT 5
+#define MCDE_OVL1CR_OVLF_MASK 0x00000020
+#define MCDE_OVL1CR_OVLF(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, OVLF, __x)
+#define MCDE_OVL1CR_OVLR_SHIFT 6
+#define MCDE_OVL1CR_OVLR_MASK 0x00000040
+#define MCDE_OVL1CR_OVLR(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, OVLR, __x)
+#define MCDE_OVL1CR_OVLB_SHIFT 7
+#define MCDE_OVL1CR_OVLB_MASK 0x00000080
+#define MCDE_OVL1CR_OVLB(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, OVLB, __x)
+#define MCDE_OVL1CR_FETCH_ROPC_SHIFT 8
+#define MCDE_OVL1CR_FETCH_ROPC_MASK 0x0000FF00
+#define MCDE_OVL1CR_FETCH_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, FETCH_ROPC, __x)
+#define MCDE_OVL1CR_STBPRIO_SHIFT 16
+#define MCDE_OVL1CR_STBPRIO_MASK 0x000F0000
+#define MCDE_OVL1CR_STBPRIO(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, STBPRIO, __x)
+#define MCDE_OVL1CR_BURSTSIZE_SHIFT 20
+#define MCDE_OVL1CR_BURSTSIZE_MASK 0x00F00000
+#define MCDE_OVL1CR_BURSTSIZE_1W 0
+#define MCDE_OVL1CR_BURSTSIZE_2W 1
+#define MCDE_OVL1CR_BURSTSIZE_4W 2
+#define MCDE_OVL1CR_BURSTSIZE_8W 3
+#define MCDE_OVL1CR_BURSTSIZE_16W 4
+#define MCDE_OVL1CR_BURSTSIZE_HW_1W 8
+#define MCDE_OVL1CR_BURSTSIZE_HW_2W 9
+#define MCDE_OVL1CR_BURSTSIZE_HW_4W 10
+#define MCDE_OVL1CR_BURSTSIZE_HW_8W 11
+#define MCDE_OVL1CR_BURSTSIZE_HW_16W 12
+#define MCDE_OVL1CR_BURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, BURSTSIZE, MCDE_OVL1CR_BURSTSIZE_##__x)
+#define MCDE_OVL1CR_BURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, BURSTSIZE, __x)
+#define MCDE_OVL1CR_MAXOUTSTANDING_SHIFT 24
+#define MCDE_OVL1CR_MAXOUTSTANDING_MASK 0x0F000000
+#define MCDE_OVL1CR_MAXOUTSTANDING_1_REQ 0
+#define MCDE_OVL1CR_MAXOUTSTANDING_2_REQ 1
+#define MCDE_OVL1CR_MAXOUTSTANDING_4_REQ 2
+#define MCDE_OVL1CR_MAXOUTSTANDING_8_REQ 3
+#define MCDE_OVL1CR_MAXOUTSTANDING_16_REQ 4
+#define MCDE_OVL1CR_MAXOUTSTANDING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, MAXOUTSTANDING, \
+	MCDE_OVL1CR_MAXOUTSTANDING_##__x)
+#define MCDE_OVL1CR_MAXOUTSTANDING(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, MAXOUTSTANDING, __x)
+#define MCDE_OVL1CR_ROTBURSTSIZE_SHIFT 28
+#define MCDE_OVL1CR_ROTBURSTSIZE_MASK 0xF0000000
+#define MCDE_OVL1CR_ROTBURSTSIZE_1W 0
+#define MCDE_OVL1CR_ROTBURSTSIZE_2W 1
+#define MCDE_OVL1CR_ROTBURSTSIZE_4W 2
+#define MCDE_OVL1CR_ROTBURSTSIZE_8W 3
+#define MCDE_OVL1CR_ROTBURSTSIZE_16W 4
+#define MCDE_OVL1CR_ROTBURSTSIZE_HW_1W 8
+#define MCDE_OVL1CR_ROTBURSTSIZE_HW_2W 9
+#define MCDE_OVL1CR_ROTBURSTSIZE_HW_4W 10
+#define MCDE_OVL1CR_ROTBURSTSIZE_HW_8W 11
+#define MCDE_OVL1CR_ROTBURSTSIZE_HW_16W 12
+#define MCDE_OVL1CR_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, ROTBURSTSIZE, MCDE_OVL1CR_ROTBURSTSIZE_##__x)
+#define MCDE_OVL1CR_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CR, ROTBURSTSIZE, __x)
+#define MCDE_OVL2CR 0x00000440
+#define MCDE_OVL2CR_OVLEN_SHIFT 0
+#define MCDE_OVL2CR_OVLEN_MASK 0x00000001
+#define MCDE_OVL2CR_OVLEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, OVLEN, __x)
+#define MCDE_OVL2CR_COLCCTRL_SHIFT 1
+#define MCDE_OVL2CR_COLCCTRL_MASK 0x00000006
+#define MCDE_OVL2CR_COLCCTRL_DISABLED 0
+#define MCDE_OVL2CR_COLCCTRL_ENABLED_NO_SAT 1
+#define MCDE_OVL2CR_COLCCTRL_ENABLED_SAT 2
+#define MCDE_OVL2CR_COLCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, COLCCTRL, MCDE_OVL2CR_COLCCTRL_##__x)
+#define MCDE_OVL2CR_COLCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, COLCCTRL, __x)
+#define MCDE_OVL2CR_CKEYGEN_SHIFT 3
+#define MCDE_OVL2CR_CKEYGEN_MASK 0x00000008
+#define MCDE_OVL2CR_CKEYGEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, CKEYGEN, __x)
+#define MCDE_OVL2CR_ALPHAPMEN_SHIFT 4
+#define MCDE_OVL2CR_ALPHAPMEN_MASK 0x00000010
+#define MCDE_OVL2CR_ALPHAPMEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, ALPHAPMEN, __x)
+#define MCDE_OVL2CR_OVLF_SHIFT 5
+#define MCDE_OVL2CR_OVLF_MASK 0x00000020
+#define MCDE_OVL2CR_OVLF(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, OVLF, __x)
+#define MCDE_OVL2CR_OVLR_SHIFT 6
+#define MCDE_OVL2CR_OVLR_MASK 0x00000040
+#define MCDE_OVL2CR_OVLR(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, OVLR, __x)
+#define MCDE_OVL2CR_OVLB_SHIFT 7
+#define MCDE_OVL2CR_OVLB_MASK 0x00000080
+#define MCDE_OVL2CR_OVLB(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, OVLB, __x)
+#define MCDE_OVL2CR_FETCH_ROPC_SHIFT 8
+#define MCDE_OVL2CR_FETCH_ROPC_MASK 0x0000FF00
+#define MCDE_OVL2CR_FETCH_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, FETCH_ROPC, __x)
+#define MCDE_OVL2CR_STBPRIO_SHIFT 16
+#define MCDE_OVL2CR_STBPRIO_MASK 0x000F0000
+#define MCDE_OVL2CR_STBPRIO(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, STBPRIO, __x)
+#define MCDE_OVL2CR_BURSTSIZE_SHIFT 20
+#define MCDE_OVL2CR_BURSTSIZE_MASK 0x00F00000
+#define MCDE_OVL2CR_BURSTSIZE_1W 0
+#define MCDE_OVL2CR_BURSTSIZE_2W 1
+#define MCDE_OVL2CR_BURSTSIZE_4W 2
+#define MCDE_OVL2CR_BURSTSIZE_8W 3
+#define MCDE_OVL2CR_BURSTSIZE_16W 4
+#define MCDE_OVL2CR_BURSTSIZE_HW_1W 8
+#define MCDE_OVL2CR_BURSTSIZE_HW_2W 9
+#define MCDE_OVL2CR_BURSTSIZE_HW_4W 10
+#define MCDE_OVL2CR_BURSTSIZE_HW_8W 11
+#define MCDE_OVL2CR_BURSTSIZE_HW_16W 12
+#define MCDE_OVL2CR_BURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, BURSTSIZE, MCDE_OVL2CR_BURSTSIZE_##__x)
+#define MCDE_OVL2CR_BURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, BURSTSIZE, __x)
+#define MCDE_OVL2CR_MAXOUTSTANDING_SHIFT 24
+#define MCDE_OVL2CR_MAXOUTSTANDING_MASK 0x0F000000
+#define MCDE_OVL2CR_MAXOUTSTANDING_1_REQ 0
+#define MCDE_OVL2CR_MAXOUTSTANDING_2_REQ 1
+#define MCDE_OVL2CR_MAXOUTSTANDING_4_REQ 2
+#define MCDE_OVL2CR_MAXOUTSTANDING_8_REQ 3
+#define MCDE_OVL2CR_MAXOUTSTANDING_16_REQ 4
+#define MCDE_OVL2CR_MAXOUTSTANDING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, MAXOUTSTANDING, \
+	MCDE_OVL2CR_MAXOUTSTANDING_##__x)
+#define MCDE_OVL2CR_MAXOUTSTANDING(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, MAXOUTSTANDING, __x)
+#define MCDE_OVL2CR_ROTBURSTSIZE_SHIFT 28
+#define MCDE_OVL2CR_ROTBURSTSIZE_MASK 0xF0000000
+#define MCDE_OVL2CR_ROTBURSTSIZE_1W 0
+#define MCDE_OVL2CR_ROTBURSTSIZE_2W 1
+#define MCDE_OVL2CR_ROTBURSTSIZE_4W 2
+#define MCDE_OVL2CR_ROTBURSTSIZE_8W 3
+#define MCDE_OVL2CR_ROTBURSTSIZE_16W 4
+#define MCDE_OVL2CR_ROTBURSTSIZE_HW_1W 8
+#define MCDE_OVL2CR_ROTBURSTSIZE_HW_2W 9
+#define MCDE_OVL2CR_ROTBURSTSIZE_HW_4W 10
+#define MCDE_OVL2CR_ROTBURSTSIZE_HW_8W 11
+#define MCDE_OVL2CR_ROTBURSTSIZE_HW_16W 12
+#define MCDE_OVL2CR_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, ROTBURSTSIZE, MCDE_OVL2CR_ROTBURSTSIZE_##__x)
+#define MCDE_OVL2CR_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CR, ROTBURSTSIZE, __x)
+#define MCDE_OVL3CR 0x00000460
+#define MCDE_OVL3CR_OVLEN_SHIFT 0
+#define MCDE_OVL3CR_OVLEN_MASK 0x00000001
+#define MCDE_OVL3CR_OVLEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, OVLEN, __x)
+#define MCDE_OVL3CR_COLCCTRL_SHIFT 1
+#define MCDE_OVL3CR_COLCCTRL_MASK 0x00000006
+#define MCDE_OVL3CR_COLCCTRL_DISABLED 0
+#define MCDE_OVL3CR_COLCCTRL_ENABLED_NO_SAT 1
+#define MCDE_OVL3CR_COLCCTRL_ENABLED_SAT 2
+#define MCDE_OVL3CR_COLCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, COLCCTRL, MCDE_OVL3CR_COLCCTRL_##__x)
+#define MCDE_OVL3CR_COLCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, COLCCTRL, __x)
+#define MCDE_OVL3CR_CKEYGEN_SHIFT 3
+#define MCDE_OVL3CR_CKEYGEN_MASK 0x00000008
+#define MCDE_OVL3CR_CKEYGEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, CKEYGEN, __x)
+#define MCDE_OVL3CR_ALPHAPMEN_SHIFT 4
+#define MCDE_OVL3CR_ALPHAPMEN_MASK 0x00000010
+#define MCDE_OVL3CR_ALPHAPMEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, ALPHAPMEN, __x)
+#define MCDE_OVL3CR_OVLF_SHIFT 5
+#define MCDE_OVL3CR_OVLF_MASK 0x00000020
+#define MCDE_OVL3CR_OVLF(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, OVLF, __x)
+#define MCDE_OVL3CR_OVLR_SHIFT 6
+#define MCDE_OVL3CR_OVLR_MASK 0x00000040
+#define MCDE_OVL3CR_OVLR(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, OVLR, __x)
+#define MCDE_OVL3CR_OVLB_SHIFT 7
+#define MCDE_OVL3CR_OVLB_MASK 0x00000080
+#define MCDE_OVL3CR_OVLB(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, OVLB, __x)
+#define MCDE_OVL3CR_FETCH_ROPC_SHIFT 8
+#define MCDE_OVL3CR_FETCH_ROPC_MASK 0x0000FF00
+#define MCDE_OVL3CR_FETCH_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, FETCH_ROPC, __x)
+#define MCDE_OVL3CR_STBPRIO_SHIFT 16
+#define MCDE_OVL3CR_STBPRIO_MASK 0x000F0000
+#define MCDE_OVL3CR_STBPRIO(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, STBPRIO, __x)
+#define MCDE_OVL3CR_BURSTSIZE_SHIFT 20
+#define MCDE_OVL3CR_BURSTSIZE_MASK 0x00F00000
+#define MCDE_OVL3CR_BURSTSIZE_1W 0
+#define MCDE_OVL3CR_BURSTSIZE_2W 1
+#define MCDE_OVL3CR_BURSTSIZE_4W 2
+#define MCDE_OVL3CR_BURSTSIZE_8W 3
+#define MCDE_OVL3CR_BURSTSIZE_16W 4
+#define MCDE_OVL3CR_BURSTSIZE_HW_1W 8
+#define MCDE_OVL3CR_BURSTSIZE_HW_2W 9
+#define MCDE_OVL3CR_BURSTSIZE_HW_4W 10
+#define MCDE_OVL3CR_BURSTSIZE_HW_8W 11
+#define MCDE_OVL3CR_BURSTSIZE_HW_16W 12
+#define MCDE_OVL3CR_BURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, BURSTSIZE, MCDE_OVL3CR_BURSTSIZE_##__x)
+#define MCDE_OVL3CR_BURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, BURSTSIZE, __x)
+#define MCDE_OVL3CR_MAXOUTSTANDING_SHIFT 24
+#define MCDE_OVL3CR_MAXOUTSTANDING_MASK 0x0F000000
+#define MCDE_OVL3CR_MAXOUTSTANDING_1_REQ 0
+#define MCDE_OVL3CR_MAXOUTSTANDING_2_REQ 1
+#define MCDE_OVL3CR_MAXOUTSTANDING_4_REQ 2
+#define MCDE_OVL3CR_MAXOUTSTANDING_8_REQ 3
+#define MCDE_OVL3CR_MAXOUTSTANDING_16_REQ 4
+#define MCDE_OVL3CR_MAXOUTSTANDING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, MAXOUTSTANDING, \
+	MCDE_OVL3CR_MAXOUTSTANDING_##__x)
+#define MCDE_OVL3CR_MAXOUTSTANDING(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, MAXOUTSTANDING, __x)
+#define MCDE_OVL3CR_ROTBURSTSIZE_SHIFT 28
+#define MCDE_OVL3CR_ROTBURSTSIZE_MASK 0xF0000000
+#define MCDE_OVL3CR_ROTBURSTSIZE_1W 0
+#define MCDE_OVL3CR_ROTBURSTSIZE_2W 1
+#define MCDE_OVL3CR_ROTBURSTSIZE_4W 2
+#define MCDE_OVL3CR_ROTBURSTSIZE_8W 3
+#define MCDE_OVL3CR_ROTBURSTSIZE_16W 4
+#define MCDE_OVL3CR_ROTBURSTSIZE_HW_1W 8
+#define MCDE_OVL3CR_ROTBURSTSIZE_HW_2W 9
+#define MCDE_OVL3CR_ROTBURSTSIZE_HW_4W 10
+#define MCDE_OVL3CR_ROTBURSTSIZE_HW_8W 11
+#define MCDE_OVL3CR_ROTBURSTSIZE_HW_16W 12
+#define MCDE_OVL3CR_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, ROTBURSTSIZE, MCDE_OVL3CR_ROTBURSTSIZE_##__x)
+#define MCDE_OVL3CR_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CR, ROTBURSTSIZE, __x)
+#define MCDE_OVL4CR 0x00000480
+#define MCDE_OVL4CR_OVLEN_SHIFT 0
+#define MCDE_OVL4CR_OVLEN_MASK 0x00000001
+#define MCDE_OVL4CR_OVLEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, OVLEN, __x)
+#define MCDE_OVL4CR_COLCCTRL_SHIFT 1
+#define MCDE_OVL4CR_COLCCTRL_MASK 0x00000006
+#define MCDE_OVL4CR_COLCCTRL_DISABLED 0
+#define MCDE_OVL4CR_COLCCTRL_ENABLED_NO_SAT 1
+#define MCDE_OVL4CR_COLCCTRL_ENABLED_SAT 2
+#define MCDE_OVL4CR_COLCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, COLCCTRL, MCDE_OVL4CR_COLCCTRL_##__x)
+#define MCDE_OVL4CR_COLCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, COLCCTRL, __x)
+#define MCDE_OVL4CR_CKEYGEN_SHIFT 3
+#define MCDE_OVL4CR_CKEYGEN_MASK 0x00000008
+#define MCDE_OVL4CR_CKEYGEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, CKEYGEN, __x)
+#define MCDE_OVL4CR_ALPHAPMEN_SHIFT 4
+#define MCDE_OVL4CR_ALPHAPMEN_MASK 0x00000010
+#define MCDE_OVL4CR_ALPHAPMEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, ALPHAPMEN, __x)
+#define MCDE_OVL4CR_OVLF_SHIFT 5
+#define MCDE_OVL4CR_OVLF_MASK 0x00000020
+#define MCDE_OVL4CR_OVLF(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, OVLF, __x)
+#define MCDE_OVL4CR_OVLR_SHIFT 6
+#define MCDE_OVL4CR_OVLR_MASK 0x00000040
+#define MCDE_OVL4CR_OVLR(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, OVLR, __x)
+#define MCDE_OVL4CR_OVLB_SHIFT 7
+#define MCDE_OVL4CR_OVLB_MASK 0x00000080
+#define MCDE_OVL4CR_OVLB(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, OVLB, __x)
+#define MCDE_OVL4CR_FETCH_ROPC_SHIFT 8
+#define MCDE_OVL4CR_FETCH_ROPC_MASK 0x0000FF00
+#define MCDE_OVL4CR_FETCH_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, FETCH_ROPC, __x)
+#define MCDE_OVL4CR_STBPRIO_SHIFT 16
+#define MCDE_OVL4CR_STBPRIO_MASK 0x000F0000
+#define MCDE_OVL4CR_STBPRIO(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, STBPRIO, __x)
+#define MCDE_OVL4CR_BURSTSIZE_SHIFT 20
+#define MCDE_OVL4CR_BURSTSIZE_MASK 0x00F00000
+#define MCDE_OVL4CR_BURSTSIZE_1W 0
+#define MCDE_OVL4CR_BURSTSIZE_2W 1
+#define MCDE_OVL4CR_BURSTSIZE_4W 2
+#define MCDE_OVL4CR_BURSTSIZE_8W 3
+#define MCDE_OVL4CR_BURSTSIZE_16W 4
+#define MCDE_OVL4CR_BURSTSIZE_HW_1W 8
+#define MCDE_OVL4CR_BURSTSIZE_HW_2W 9
+#define MCDE_OVL4CR_BURSTSIZE_HW_4W 10
+#define MCDE_OVL4CR_BURSTSIZE_HW_8W 11
+#define MCDE_OVL4CR_BURSTSIZE_HW_16W 12
+#define MCDE_OVL4CR_BURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, BURSTSIZE, MCDE_OVL4CR_BURSTSIZE_##__x)
+#define MCDE_OVL4CR_BURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, BURSTSIZE, __x)
+#define MCDE_OVL4CR_MAXOUTSTANDING_SHIFT 24
+#define MCDE_OVL4CR_MAXOUTSTANDING_MASK 0x0F000000
+#define MCDE_OVL4CR_MAXOUTSTANDING_1_REQ 0
+#define MCDE_OVL4CR_MAXOUTSTANDING_2_REQ 1
+#define MCDE_OVL4CR_MAXOUTSTANDING_4_REQ 2
+#define MCDE_OVL4CR_MAXOUTSTANDING_8_REQ 3
+#define MCDE_OVL4CR_MAXOUTSTANDING_16_REQ 4
+#define MCDE_OVL4CR_MAXOUTSTANDING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, MAXOUTSTANDING, \
+	MCDE_OVL4CR_MAXOUTSTANDING_##__x)
+#define MCDE_OVL4CR_MAXOUTSTANDING(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, MAXOUTSTANDING, __x)
+#define MCDE_OVL4CR_ROTBURSTSIZE_SHIFT 28
+#define MCDE_OVL4CR_ROTBURSTSIZE_MASK 0xF0000000
+#define MCDE_OVL4CR_ROTBURSTSIZE_1W 0
+#define MCDE_OVL4CR_ROTBURSTSIZE_2W 1
+#define MCDE_OVL4CR_ROTBURSTSIZE_4W 2
+#define MCDE_OVL4CR_ROTBURSTSIZE_8W 3
+#define MCDE_OVL4CR_ROTBURSTSIZE_16W 4
+#define MCDE_OVL4CR_ROTBURSTSIZE_HW_1W 8
+#define MCDE_OVL4CR_ROTBURSTSIZE_HW_2W 9
+#define MCDE_OVL4CR_ROTBURSTSIZE_HW_4W 10
+#define MCDE_OVL4CR_ROTBURSTSIZE_HW_8W 11
+#define MCDE_OVL4CR_ROTBURSTSIZE_HW_16W 12
+#define MCDE_OVL4CR_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, ROTBURSTSIZE, MCDE_OVL4CR_ROTBURSTSIZE_##__x)
+#define MCDE_OVL4CR_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CR, ROTBURSTSIZE, __x)
+#define MCDE_OVL5CR 0x000004A0
+#define MCDE_OVL5CR_OVLEN_SHIFT 0
+#define MCDE_OVL5CR_OVLEN_MASK 0x00000001
+#define MCDE_OVL5CR_OVLEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, OVLEN, __x)
+#define MCDE_OVL5CR_COLCCTRL_SHIFT 1
+#define MCDE_OVL5CR_COLCCTRL_MASK 0x00000006
+#define MCDE_OVL5CR_COLCCTRL_DISABLED 0
+#define MCDE_OVL5CR_COLCCTRL_ENABLED_NO_SAT 1
+#define MCDE_OVL5CR_COLCCTRL_ENABLED_SAT 2
+#define MCDE_OVL5CR_COLCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, COLCCTRL, MCDE_OVL5CR_COLCCTRL_##__x)
+#define MCDE_OVL5CR_COLCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, COLCCTRL, __x)
+#define MCDE_OVL5CR_CKEYGEN_SHIFT 3
+#define MCDE_OVL5CR_CKEYGEN_MASK 0x00000008
+#define MCDE_OVL5CR_CKEYGEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, CKEYGEN, __x)
+#define MCDE_OVL5CR_ALPHAPMEN_SHIFT 4
+#define MCDE_OVL5CR_ALPHAPMEN_MASK 0x00000010
+#define MCDE_OVL5CR_ALPHAPMEN(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, ALPHAPMEN, __x)
+#define MCDE_OVL5CR_OVLF_SHIFT 5
+#define MCDE_OVL5CR_OVLF_MASK 0x00000020
+#define MCDE_OVL5CR_OVLF(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, OVLF, __x)
+#define MCDE_OVL5CR_OVLR_SHIFT 6
+#define MCDE_OVL5CR_OVLR_MASK 0x00000040
+#define MCDE_OVL5CR_OVLR(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, OVLR, __x)
+#define MCDE_OVL5CR_OVLB_SHIFT 7
+#define MCDE_OVL5CR_OVLB_MASK 0x00000080
+#define MCDE_OVL5CR_OVLB(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, OVLB, __x)
+#define MCDE_OVL5CR_FETCH_ROPC_SHIFT 8
+#define MCDE_OVL5CR_FETCH_ROPC_MASK 0x0000FF00
+#define MCDE_OVL5CR_FETCH_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, FETCH_ROPC, __x)
+#define MCDE_OVL5CR_STBPRIO_SHIFT 16
+#define MCDE_OVL5CR_STBPRIO_MASK 0x000F0000
+#define MCDE_OVL5CR_STBPRIO(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, STBPRIO, __x)
+#define MCDE_OVL5CR_BURSTSIZE_SHIFT 20
+#define MCDE_OVL5CR_BURSTSIZE_MASK 0x00F00000
+#define MCDE_OVL5CR_BURSTSIZE_1W 0
+#define MCDE_OVL5CR_BURSTSIZE_2W 1
+#define MCDE_OVL5CR_BURSTSIZE_4W 2
+#define MCDE_OVL5CR_BURSTSIZE_8W 3
+#define MCDE_OVL5CR_BURSTSIZE_16W 4
+#define MCDE_OVL5CR_BURSTSIZE_HW_1W 8
+#define MCDE_OVL5CR_BURSTSIZE_HW_2W 9
+#define MCDE_OVL5CR_BURSTSIZE_HW_4W 10
+#define MCDE_OVL5CR_BURSTSIZE_HW_8W 11
+#define MCDE_OVL5CR_BURSTSIZE_HW_16W 12
+#define MCDE_OVL5CR_BURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, BURSTSIZE, MCDE_OVL5CR_BURSTSIZE_##__x)
+#define MCDE_OVL5CR_BURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, BURSTSIZE, __x)
+#define MCDE_OVL5CR_MAXOUTSTANDING_SHIFT 24
+#define MCDE_OVL5CR_MAXOUTSTANDING_MASK 0x0F000000
+#define MCDE_OVL5CR_MAXOUTSTANDING_1_REQ 0
+#define MCDE_OVL5CR_MAXOUTSTANDING_2_REQ 1
+#define MCDE_OVL5CR_MAXOUTSTANDING_4_REQ 2
+#define MCDE_OVL5CR_MAXOUTSTANDING_8_REQ 3
+#define MCDE_OVL5CR_MAXOUTSTANDING_16_REQ 4
+#define MCDE_OVL5CR_MAXOUTSTANDING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, MAXOUTSTANDING, \
+	MCDE_OVL5CR_MAXOUTSTANDING_##__x)
+#define MCDE_OVL5CR_MAXOUTSTANDING(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, MAXOUTSTANDING, __x)
+#define MCDE_OVL5CR_ROTBURSTSIZE_SHIFT 28
+#define MCDE_OVL5CR_ROTBURSTSIZE_MASK 0xF0000000
+#define MCDE_OVL5CR_ROTBURSTSIZE_1W 0
+#define MCDE_OVL5CR_ROTBURSTSIZE_2W 1
+#define MCDE_OVL5CR_ROTBURSTSIZE_4W 2
+#define MCDE_OVL5CR_ROTBURSTSIZE_8W 3
+#define MCDE_OVL5CR_ROTBURSTSIZE_16W 4
+#define MCDE_OVL5CR_ROTBURSTSIZE_HW_1W 8
+#define MCDE_OVL5CR_ROTBURSTSIZE_HW_2W 9
+#define MCDE_OVL5CR_ROTBURSTSIZE_HW_4W 10
+#define MCDE_OVL5CR_ROTBURSTSIZE_HW_8W 11
+#define MCDE_OVL5CR_ROTBURSTSIZE_HW_16W 12
+#define MCDE_OVL5CR_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, ROTBURSTSIZE, MCDE_OVL5CR_ROTBURSTSIZE_##__x)
+#define MCDE_OVL5CR_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CR, ROTBURSTSIZE, __x)
+#define MCDE_OVL0CONF 0x00000404
+#define MCDE_OVL0CONF_GROUPOFFSET 0x20
+#define MCDE_OVL0CONF_PPL_SHIFT 0
+#define MCDE_OVL0CONF_PPL_MASK 0x000007FF
+#define MCDE_OVL0CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF, PPL, __x)
+#define MCDE_OVL0CONF_EXTSRC_ID_SHIFT 11
+#define MCDE_OVL0CONF_EXTSRC_ID_MASK 0x00007800
+#define MCDE_OVL0CONF_EXTSRC_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF, EXTSRC_ID, __x)
+#define MCDE_OVL0CONF_LPF_SHIFT 16
+#define MCDE_OVL0CONF_LPF_MASK 0x07FF0000
+#define MCDE_OVL0CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF, LPF, __x)
+#define MCDE_OVL1CONF 0x00000424
+#define MCDE_OVL1CONF_PPL_SHIFT 0
+#define MCDE_OVL1CONF_PPL_MASK 0x000007FF
+#define MCDE_OVL1CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF, PPL, __x)
+#define MCDE_OVL1CONF_EXTSRC_ID_SHIFT 11
+#define MCDE_OVL1CONF_EXTSRC_ID_MASK 0x00007800
+#define MCDE_OVL1CONF_EXTSRC_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF, EXTSRC_ID, __x)
+#define MCDE_OVL1CONF_LPF_SHIFT 16
+#define MCDE_OVL1CONF_LPF_MASK 0x07FF0000
+#define MCDE_OVL1CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF, LPF, __x)
+#define MCDE_OVL2CONF 0x00000444
+#define MCDE_OVL2CONF_PPL_SHIFT 0
+#define MCDE_OVL2CONF_PPL_MASK 0x000007FF
+#define MCDE_OVL2CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF, PPL, __x)
+#define MCDE_OVL2CONF_EXTSRC_ID_SHIFT 11
+#define MCDE_OVL2CONF_EXTSRC_ID_MASK 0x00007800
+#define MCDE_OVL2CONF_EXTSRC_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF, EXTSRC_ID, __x)
+#define MCDE_OVL2CONF_LPF_SHIFT 16
+#define MCDE_OVL2CONF_LPF_MASK 0x07FF0000
+#define MCDE_OVL2CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF, LPF, __x)
+#define MCDE_OVL3CONF 0x00000464
+#define MCDE_OVL3CONF_PPL_SHIFT 0
+#define MCDE_OVL3CONF_PPL_MASK 0x000007FF
+#define MCDE_OVL3CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF, PPL, __x)
+#define MCDE_OVL3CONF_EXTSRC_ID_SHIFT 11
+#define MCDE_OVL3CONF_EXTSRC_ID_MASK 0x00007800
+#define MCDE_OVL3CONF_EXTSRC_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF, EXTSRC_ID, __x)
+#define MCDE_OVL3CONF_LPF_SHIFT 16
+#define MCDE_OVL3CONF_LPF_MASK 0x07FF0000
+#define MCDE_OVL3CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF, LPF, __x)
+#define MCDE_OVL4CONF 0x00000484
+#define MCDE_OVL4CONF_PPL_SHIFT 0
+#define MCDE_OVL4CONF_PPL_MASK 0x000007FF
+#define MCDE_OVL4CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF, PPL, __x)
+#define MCDE_OVL4CONF_EXTSRC_ID_SHIFT 11
+#define MCDE_OVL4CONF_EXTSRC_ID_MASK 0x00007800
+#define MCDE_OVL4CONF_EXTSRC_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF, EXTSRC_ID, __x)
+#define MCDE_OVL4CONF_LPF_SHIFT 16
+#define MCDE_OVL4CONF_LPF_MASK 0x07FF0000
+#define MCDE_OVL4CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF, LPF, __x)
+#define MCDE_OVL5CONF 0x000004A4
+#define MCDE_OVL5CONF_PPL_SHIFT 0
+#define MCDE_OVL5CONF_PPL_MASK 0x000007FF
+#define MCDE_OVL5CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF, PPL, __x)
+#define MCDE_OVL5CONF_EXTSRC_ID_SHIFT 11
+#define MCDE_OVL5CONF_EXTSRC_ID_MASK 0x00007800
+#define MCDE_OVL5CONF_EXTSRC_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF, EXTSRC_ID, __x)
+#define MCDE_OVL5CONF_LPF_SHIFT 16
+#define MCDE_OVL5CONF_LPF_MASK 0x07FF0000
+#define MCDE_OVL5CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF, LPF, __x)
+#define MCDE_OVL0CONF2 0x00000408
+#define MCDE_OVL0CONF2_GROUPOFFSET 0x20
+#define MCDE_OVL0CONF2_BP_SHIFT 0
+#define MCDE_OVL0CONF2_BP_MASK 0x00000001
+#define MCDE_OVL0CONF2_BP_PER_PIXEL_ALPHA 0
+#define MCDE_OVL0CONF2_BP_CONSTANT_ALPHA 1
+#define MCDE_OVL0CONF2_BP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF2, BP, MCDE_OVL0CONF2_BP_##__x)
+#define MCDE_OVL0CONF2_BP(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF2, BP, __x)
+#define MCDE_OVL0CONF2_ALPHAVALUE_SHIFT 1
+#define MCDE_OVL0CONF2_ALPHAVALUE_MASK 0x000001FE
+#define MCDE_OVL0CONF2_ALPHAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF2, ALPHAVALUE, __x)
+#define MCDE_OVL0CONF2_OPQ_SHIFT 9
+#define MCDE_OVL0CONF2_OPQ_MASK 0x00000200
+#define MCDE_OVL0CONF2_OPQ(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF2, OPQ, __x)
+#define MCDE_OVL0CONF2_PIXOFF_SHIFT 10
+#define MCDE_OVL0CONF2_PIXOFF_MASK 0x0000FC00
+#define MCDE_OVL0CONF2_PIXOFF(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF2, PIXOFF, __x)
+#define MCDE_OVL0CONF2_PIXELFETCHERWATERMARKLEVEL_SHIFT 16
+#define MCDE_OVL0CONF2_PIXELFETCHERWATERMARKLEVEL_MASK 0x1FFF0000
+#define MCDE_OVL0CONF2_PIXELFETCHERWATERMARKLEVEL(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CONF2, PIXELFETCHERWATERMARKLEVEL, __x)
+#define MCDE_OVL1CONF2 0x00000428
+#define MCDE_OVL1CONF2_BP_SHIFT 0
+#define MCDE_OVL1CONF2_BP_MASK 0x00000001
+#define MCDE_OVL1CONF2_BP_PER_PIXEL_ALPHA 0
+#define MCDE_OVL1CONF2_BP_CONSTANT_ALPHA 1
+#define MCDE_OVL1CONF2_BP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF2, BP, MCDE_OVL1CONF2_BP_##__x)
+#define MCDE_OVL1CONF2_BP(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF2, BP, __x)
+#define MCDE_OVL1CONF2_ALPHAVALUE_SHIFT 1
+#define MCDE_OVL1CONF2_ALPHAVALUE_MASK 0x000001FE
+#define MCDE_OVL1CONF2_ALPHAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF2, ALPHAVALUE, __x)
+#define MCDE_OVL1CONF2_OPQ_SHIFT 9
+#define MCDE_OVL1CONF2_OPQ_MASK 0x00000200
+#define MCDE_OVL1CONF2_OPQ(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF2, OPQ, __x)
+#define MCDE_OVL1CONF2_PIXOFF_SHIFT 10
+#define MCDE_OVL1CONF2_PIXOFF_MASK 0x0000FC00
+#define MCDE_OVL1CONF2_PIXOFF(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF2, PIXOFF, __x)
+#define MCDE_OVL1CONF2_PIXELFETCHERWATERMARKLEVEL_SHIFT 16
+#define MCDE_OVL1CONF2_PIXELFETCHERWATERMARKLEVEL_MASK 0x1FFF0000
+#define MCDE_OVL1CONF2_PIXELFETCHERWATERMARKLEVEL(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CONF2, PIXELFETCHERWATERMARKLEVEL, __x)
+#define MCDE_OVL2CONF2 0x00000448
+#define MCDE_OVL2CONF2_BP_SHIFT 0
+#define MCDE_OVL2CONF2_BP_MASK 0x00000001
+#define MCDE_OVL2CONF2_BP_PER_PIXEL_ALPHA 0
+#define MCDE_OVL2CONF2_BP_CONSTANT_ALPHA 1
+#define MCDE_OVL2CONF2_BP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF2, BP, MCDE_OVL2CONF2_BP_##__x)
+#define MCDE_OVL2CONF2_BP(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF2, BP, __x)
+#define MCDE_OVL2CONF2_ALPHAVALUE_SHIFT 1
+#define MCDE_OVL2CONF2_ALPHAVALUE_MASK 0x000001FE
+#define MCDE_OVL2CONF2_ALPHAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF2, ALPHAVALUE, __x)
+#define MCDE_OVL2CONF2_OPQ_SHIFT 9
+#define MCDE_OVL2CONF2_OPQ_MASK 0x00000200
+#define MCDE_OVL2CONF2_OPQ(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF2, OPQ, __x)
+#define MCDE_OVL2CONF2_PIXOFF_SHIFT 10
+#define MCDE_OVL2CONF2_PIXOFF_MASK 0x0000FC00
+#define MCDE_OVL2CONF2_PIXOFF(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF2, PIXOFF, __x)
+#define MCDE_OVL2CONF2_PIXELFETCHERWATERMARKLEVEL_SHIFT 16
+#define MCDE_OVL2CONF2_PIXELFETCHERWATERMARKLEVEL_MASK 0x1FFF0000
+#define MCDE_OVL2CONF2_PIXELFETCHERWATERMARKLEVEL(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CONF2, PIXELFETCHERWATERMARKLEVEL, __x)
+#define MCDE_OVL3CONF2 0x00000468
+#define MCDE_OVL3CONF2_BP_SHIFT 0
+#define MCDE_OVL3CONF2_BP_MASK 0x00000001
+#define MCDE_OVL3CONF2_BP_PER_PIXEL_ALPHA 0
+#define MCDE_OVL3CONF2_BP_CONSTANT_ALPHA 1
+#define MCDE_OVL3CONF2_BP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF2, BP, MCDE_OVL3CONF2_BP_##__x)
+#define MCDE_OVL3CONF2_BP(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF2, BP, __x)
+#define MCDE_OVL3CONF2_ALPHAVALUE_SHIFT 1
+#define MCDE_OVL3CONF2_ALPHAVALUE_MASK 0x000001FE
+#define MCDE_OVL3CONF2_ALPHAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF2, ALPHAVALUE, __x)
+#define MCDE_OVL3CONF2_OPQ_SHIFT 9
+#define MCDE_OVL3CONF2_OPQ_MASK 0x00000200
+#define MCDE_OVL3CONF2_OPQ(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF2, OPQ, __x)
+#define MCDE_OVL3CONF2_PIXOFF_SHIFT 10
+#define MCDE_OVL3CONF2_PIXOFF_MASK 0x0000FC00
+#define MCDE_OVL3CONF2_PIXOFF(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF2, PIXOFF, __x)
+#define MCDE_OVL3CONF2_PIXELFETCHERWATERMARKLEVEL_SHIFT 16
+#define MCDE_OVL3CONF2_PIXELFETCHERWATERMARKLEVEL_MASK 0x1FFF0000
+#define MCDE_OVL3CONF2_PIXELFETCHERWATERMARKLEVEL(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CONF2, PIXELFETCHERWATERMARKLEVEL, __x)
+#define MCDE_OVL4CONF2 0x00000488
+#define MCDE_OVL4CONF2_BP_SHIFT 0
+#define MCDE_OVL4CONF2_BP_MASK 0x00000001
+#define MCDE_OVL4CONF2_BP_PER_PIXEL_ALPHA 0
+#define MCDE_OVL4CONF2_BP_CONSTANT_ALPHA 1
+#define MCDE_OVL4CONF2_BP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF2, BP, MCDE_OVL4CONF2_BP_##__x)
+#define MCDE_OVL4CONF2_BP(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF2, BP, __x)
+#define MCDE_OVL4CONF2_ALPHAVALUE_SHIFT 1
+#define MCDE_OVL4CONF2_ALPHAVALUE_MASK 0x000001FE
+#define MCDE_OVL4CONF2_ALPHAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF2, ALPHAVALUE, __x)
+#define MCDE_OVL4CONF2_OPQ_SHIFT 9
+#define MCDE_OVL4CONF2_OPQ_MASK 0x00000200
+#define MCDE_OVL4CONF2_OPQ(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF2, OPQ, __x)
+#define MCDE_OVL4CONF2_PIXOFF_SHIFT 10
+#define MCDE_OVL4CONF2_PIXOFF_MASK 0x0000FC00
+#define MCDE_OVL4CONF2_PIXOFF(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF2, PIXOFF, __x)
+#define MCDE_OVL4CONF2_PIXELFETCHERWATERMARKLEVEL_SHIFT 16
+#define MCDE_OVL4CONF2_PIXELFETCHERWATERMARKLEVEL_MASK 0x1FFF0000
+#define MCDE_OVL4CONF2_PIXELFETCHERWATERMARKLEVEL(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CONF2, PIXELFETCHERWATERMARKLEVEL, __x)
+#define MCDE_OVL5CONF2 0x000004A8
+#define MCDE_OVL5CONF2_BP_SHIFT 0
+#define MCDE_OVL5CONF2_BP_MASK 0x00000001
+#define MCDE_OVL5CONF2_BP_PER_PIXEL_ALPHA 0
+#define MCDE_OVL5CONF2_BP_CONSTANT_ALPHA 1
+#define MCDE_OVL5CONF2_BP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF2, BP, MCDE_OVL5CONF2_BP_##__x)
+#define MCDE_OVL5CONF2_BP(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF2, BP, __x)
+#define MCDE_OVL5CONF2_ALPHAVALUE_SHIFT 1
+#define MCDE_OVL5CONF2_ALPHAVALUE_MASK 0x000001FE
+#define MCDE_OVL5CONF2_ALPHAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF2, ALPHAVALUE, __x)
+#define MCDE_OVL5CONF2_OPQ_SHIFT 9
+#define MCDE_OVL5CONF2_OPQ_MASK 0x00000200
+#define MCDE_OVL5CONF2_OPQ(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF2, OPQ, __x)
+#define MCDE_OVL5CONF2_PIXOFF_SHIFT 10
+#define MCDE_OVL5CONF2_PIXOFF_MASK 0x0000FC00
+#define MCDE_OVL5CONF2_PIXOFF(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF2, PIXOFF, __x)
+#define MCDE_OVL5CONF2_PIXELFETCHERWATERMARKLEVEL_SHIFT 16
+#define MCDE_OVL5CONF2_PIXELFETCHERWATERMARKLEVEL_MASK 0x1FFF0000
+#define MCDE_OVL5CONF2_PIXELFETCHERWATERMARKLEVEL(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CONF2, PIXELFETCHERWATERMARKLEVEL, __x)
+#define MCDE_OVL0LJINC 0x0000040C
+#define MCDE_OVL0LJINC_GROUPOFFSET 0x20
+#define MCDE_OVL0LJINC_LJINC_SHIFT 0
+#define MCDE_OVL0LJINC_LJINC_MASK 0xFFFFFFFF
+#define MCDE_OVL0LJINC_LJINC(__x) \
+	MCDE_VAL2REG(MCDE_OVL0LJINC, LJINC, __x)
+#define MCDE_OVL1LJINC 0x0000042C
+#define MCDE_OVL1LJINC_LJINC_SHIFT 0
+#define MCDE_OVL1LJINC_LJINC_MASK 0xFFFFFFFF
+#define MCDE_OVL1LJINC_LJINC(__x) \
+	MCDE_VAL2REG(MCDE_OVL1LJINC, LJINC, __x)
+#define MCDE_OVL2LJINC 0x0000044C
+#define MCDE_OVL2LJINC_LJINC_SHIFT 0
+#define MCDE_OVL2LJINC_LJINC_MASK 0xFFFFFFFF
+#define MCDE_OVL2LJINC_LJINC(__x) \
+	MCDE_VAL2REG(MCDE_OVL2LJINC, LJINC, __x)
+#define MCDE_OVL3LJINC 0x0000046C
+#define MCDE_OVL3LJINC_LJINC_SHIFT 0
+#define MCDE_OVL3LJINC_LJINC_MASK 0xFFFFFFFF
+#define MCDE_OVL3LJINC_LJINC(__x) \
+	MCDE_VAL2REG(MCDE_OVL3LJINC, LJINC, __x)
+#define MCDE_OVL4LJINC 0x0000048C
+#define MCDE_OVL4LJINC_LJINC_SHIFT 0
+#define MCDE_OVL4LJINC_LJINC_MASK 0xFFFFFFFF
+#define MCDE_OVL4LJINC_LJINC(__x) \
+	MCDE_VAL2REG(MCDE_OVL4LJINC, LJINC, __x)
+#define MCDE_OVL5LJINC 0x000004AC
+#define MCDE_OVL5LJINC_LJINC_SHIFT 0
+#define MCDE_OVL5LJINC_LJINC_MASK 0xFFFFFFFF
+#define MCDE_OVL5LJINC_LJINC(__x) \
+	MCDE_VAL2REG(MCDE_OVL5LJINC, LJINC, __x)
+#define MCDE_OVL0CROP 0x00000410
+#define MCDE_OVL0CROP_GROUPOFFSET 0x20
+#define MCDE_OVL0CROP_TMRGN_SHIFT 0
+#define MCDE_OVL0CROP_TMRGN_MASK 0x003FFFFF
+#define MCDE_OVL0CROP_TMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CROP, TMRGN, __x)
+#define MCDE_OVL0CROP_LMRGN_SHIFT 22
+#define MCDE_OVL0CROP_LMRGN_MASK 0xFFC00000
+#define MCDE_OVL0CROP_LMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL0CROP, LMRGN, __x)
+#define MCDE_OVL1CROP 0x00000430
+#define MCDE_OVL1CROP_TMRGN_SHIFT 0
+#define MCDE_OVL1CROP_TMRGN_MASK 0x003FFFFF
+#define MCDE_OVL1CROP_TMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CROP, TMRGN, __x)
+#define MCDE_OVL1CROP_LMRGN_SHIFT 22
+#define MCDE_OVL1CROP_LMRGN_MASK 0xFFC00000
+#define MCDE_OVL1CROP_LMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL1CROP, LMRGN, __x)
+#define MCDE_OVL2CROP 0x00000450
+#define MCDE_OVL2CROP_TMRGN_SHIFT 0
+#define MCDE_OVL2CROP_TMRGN_MASK 0x003FFFFF
+#define MCDE_OVL2CROP_TMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CROP, TMRGN, __x)
+#define MCDE_OVL2CROP_LMRGN_SHIFT 22
+#define MCDE_OVL2CROP_LMRGN_MASK 0xFFC00000
+#define MCDE_OVL2CROP_LMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL2CROP, LMRGN, __x)
+#define MCDE_OVL3CROP 0x00000470
+#define MCDE_OVL3CROP_TMRGN_SHIFT 0
+#define MCDE_OVL3CROP_TMRGN_MASK 0x003FFFFF
+#define MCDE_OVL3CROP_TMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CROP, TMRGN, __x)
+#define MCDE_OVL3CROP_LMRGN_SHIFT 22
+#define MCDE_OVL3CROP_LMRGN_MASK 0xFFC00000
+#define MCDE_OVL3CROP_LMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL3CROP, LMRGN, __x)
+#define MCDE_OVL4CROP 0x00000490
+#define MCDE_OVL4CROP_TMRGN_SHIFT 0
+#define MCDE_OVL4CROP_TMRGN_MASK 0x003FFFFF
+#define MCDE_OVL4CROP_TMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CROP, TMRGN, __x)
+#define MCDE_OVL4CROP_LMRGN_SHIFT 22
+#define MCDE_OVL4CROP_LMRGN_MASK 0xFFC00000
+#define MCDE_OVL4CROP_LMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL4CROP, LMRGN, __x)
+#define MCDE_OVL5CROP 0x000004B0
+#define MCDE_OVL5CROP_TMRGN_SHIFT 0
+#define MCDE_OVL5CROP_TMRGN_MASK 0x003FFFFF
+#define MCDE_OVL5CROP_TMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CROP, TMRGN, __x)
+#define MCDE_OVL5CROP_LMRGN_SHIFT 22
+#define MCDE_OVL5CROP_LMRGN_MASK 0xFFC00000
+#define MCDE_OVL5CROP_LMRGN(__x) \
+	MCDE_VAL2REG(MCDE_OVL5CROP, LMRGN, __x)
+#define MCDE_OVL0COMP 0x00000414
+#define MCDE_OVL0COMP_GROUPOFFSET 0x20
+#define MCDE_OVL0COMP_XPOS_SHIFT 0
+#define MCDE_OVL0COMP_XPOS_MASK 0x000007FF
+#define MCDE_OVL0COMP_XPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL0COMP, XPOS, __x)
+#define MCDE_OVL0COMP_CH_ID_SHIFT 11
+#define MCDE_OVL0COMP_CH_ID_MASK 0x00007800
+#define MCDE_OVL0COMP_CH_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL0COMP, CH_ID, __x)
+#define MCDE_OVL0COMP_YPOS_SHIFT 16
+#define MCDE_OVL0COMP_YPOS_MASK 0x07FF0000
+#define MCDE_OVL0COMP_YPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL0COMP, YPOS, __x)
+#define MCDE_OVL0COMP_Z_SHIFT 27
+#define MCDE_OVL0COMP_Z_MASK 0x78000000
+#define MCDE_OVL0COMP_Z(__x) \
+	MCDE_VAL2REG(MCDE_OVL0COMP, Z, __x)
+#define MCDE_OVL1COMP 0x00000434
+#define MCDE_OVL1COMP_XPOS_SHIFT 0
+#define MCDE_OVL1COMP_XPOS_MASK 0x000007FF
+#define MCDE_OVL1COMP_XPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL1COMP, XPOS, __x)
+#define MCDE_OVL1COMP_CH_ID_SHIFT 11
+#define MCDE_OVL1COMP_CH_ID_MASK 0x00007800
+#define MCDE_OVL1COMP_CH_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL1COMP, CH_ID, __x)
+#define MCDE_OVL1COMP_YPOS_SHIFT 16
+#define MCDE_OVL1COMP_YPOS_MASK 0x07FF0000
+#define MCDE_OVL1COMP_YPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL1COMP, YPOS, __x)
+#define MCDE_OVL1COMP_Z_SHIFT 27
+#define MCDE_OVL1COMP_Z_MASK 0x78000000
+#define MCDE_OVL1COMP_Z(__x) \
+	MCDE_VAL2REG(MCDE_OVL1COMP, Z, __x)
+#define MCDE_OVL2COMP 0x00000454
+#define MCDE_OVL2COMP_XPOS_SHIFT 0
+#define MCDE_OVL2COMP_XPOS_MASK 0x000007FF
+#define MCDE_OVL2COMP_XPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL2COMP, XPOS, __x)
+#define MCDE_OVL2COMP_CH_ID_SHIFT 11
+#define MCDE_OVL2COMP_CH_ID_MASK 0x00007800
+#define MCDE_OVL2COMP_CH_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL2COMP, CH_ID, __x)
+#define MCDE_OVL2COMP_YPOS_SHIFT 16
+#define MCDE_OVL2COMP_YPOS_MASK 0x07FF0000
+#define MCDE_OVL2COMP_YPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL2COMP, YPOS, __x)
+#define MCDE_OVL2COMP_Z_SHIFT 27
+#define MCDE_OVL2COMP_Z_MASK 0x78000000
+#define MCDE_OVL2COMP_Z(__x) \
+	MCDE_VAL2REG(MCDE_OVL2COMP, Z, __x)
+#define MCDE_OVL3COMP 0x00000474
+#define MCDE_OVL3COMP_XPOS_SHIFT 0
+#define MCDE_OVL3COMP_XPOS_MASK 0x000007FF
+#define MCDE_OVL3COMP_XPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL3COMP, XPOS, __x)
+#define MCDE_OVL3COMP_CH_ID_SHIFT 11
+#define MCDE_OVL3COMP_CH_ID_MASK 0x00007800
+#define MCDE_OVL3COMP_CH_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL3COMP, CH_ID, __x)
+#define MCDE_OVL3COMP_YPOS_SHIFT 16
+#define MCDE_OVL3COMP_YPOS_MASK 0x07FF0000
+#define MCDE_OVL3COMP_YPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL3COMP, YPOS, __x)
+#define MCDE_OVL3COMP_Z_SHIFT 27
+#define MCDE_OVL3COMP_Z_MASK 0x78000000
+#define MCDE_OVL3COMP_Z(__x) \
+	MCDE_VAL2REG(MCDE_OVL3COMP, Z, __x)
+#define MCDE_OVL4COMP 0x00000494
+#define MCDE_OVL4COMP_XPOS_SHIFT 0
+#define MCDE_OVL4COMP_XPOS_MASK 0x000007FF
+#define MCDE_OVL4COMP_XPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL4COMP, XPOS, __x)
+#define MCDE_OVL4COMP_CH_ID_SHIFT 11
+#define MCDE_OVL4COMP_CH_ID_MASK 0x00007800
+#define MCDE_OVL4COMP_CH_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL4COMP, CH_ID, __x)
+#define MCDE_OVL4COMP_YPOS_SHIFT 16
+#define MCDE_OVL4COMP_YPOS_MASK 0x07FF0000
+#define MCDE_OVL4COMP_YPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL4COMP, YPOS, __x)
+#define MCDE_OVL4COMP_Z_SHIFT 27
+#define MCDE_OVL4COMP_Z_MASK 0x78000000
+#define MCDE_OVL4COMP_Z(__x) \
+	MCDE_VAL2REG(MCDE_OVL4COMP, Z, __x)
+#define MCDE_OVL5COMP 0x000004B4
+#define MCDE_OVL5COMP_XPOS_SHIFT 0
+#define MCDE_OVL5COMP_XPOS_MASK 0x000007FF
+#define MCDE_OVL5COMP_XPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL5COMP, XPOS, __x)
+#define MCDE_OVL5COMP_CH_ID_SHIFT 11
+#define MCDE_OVL5COMP_CH_ID_MASK 0x00007800
+#define MCDE_OVL5COMP_CH_ID(__x) \
+	MCDE_VAL2REG(MCDE_OVL5COMP, CH_ID, __x)
+#define MCDE_OVL5COMP_YPOS_SHIFT 16
+#define MCDE_OVL5COMP_YPOS_MASK 0x07FF0000
+#define MCDE_OVL5COMP_YPOS(__x) \
+	MCDE_VAL2REG(MCDE_OVL5COMP, YPOS, __x)
+#define MCDE_OVL5COMP_Z_SHIFT 27
+#define MCDE_OVL5COMP_Z_MASK 0x78000000
+#define MCDE_OVL5COMP_Z(__x) \
+	MCDE_VAL2REG(MCDE_OVL5COMP, Z, __x)
+#define MCDE_CHNL0CONF 0x00000600
+#define MCDE_CHNL0CONF_GROUPOFFSET 0x20
+#define MCDE_CHNL0CONF_PPL_SHIFT 0
+#define MCDE_CHNL0CONF_PPL_MASK 0x000007FF
+#define MCDE_CHNL0CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0CONF, PPL, __x)
+#define MCDE_CHNL0CONF_LPF_SHIFT 16
+#define MCDE_CHNL0CONF_LPF_MASK 0x07FF0000
+#define MCDE_CHNL0CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0CONF, LPF, __x)
+#define MCDE_CHNL1CONF 0x00000620
+#define MCDE_CHNL1CONF_PPL_SHIFT 0
+#define MCDE_CHNL1CONF_PPL_MASK 0x000007FF
+#define MCDE_CHNL1CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1CONF, PPL, __x)
+#define MCDE_CHNL1CONF_LPF_SHIFT 16
+#define MCDE_CHNL1CONF_LPF_MASK 0x07FF0000
+#define MCDE_CHNL1CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1CONF, LPF, __x)
+#define MCDE_CHNL2CONF 0x00000640
+#define MCDE_CHNL2CONF_PPL_SHIFT 0
+#define MCDE_CHNL2CONF_PPL_MASK 0x000007FF
+#define MCDE_CHNL2CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2CONF, PPL, __x)
+#define MCDE_CHNL2CONF_LPF_SHIFT 16
+#define MCDE_CHNL2CONF_LPF_MASK 0x07FF0000
+#define MCDE_CHNL2CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2CONF, LPF, __x)
+#define MCDE_CHNL3CONF 0x00000660
+#define MCDE_CHNL3CONF_PPL_SHIFT 0
+#define MCDE_CHNL3CONF_PPL_MASK 0x000007FF
+#define MCDE_CHNL3CONF_PPL(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3CONF, PPL, __x)
+#define MCDE_CHNL3CONF_LPF_SHIFT 16
+#define MCDE_CHNL3CONF_LPF_MASK 0x07FF0000
+#define MCDE_CHNL3CONF_LPF(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3CONF, LPF, __x)
+#define MCDE_CHNL0STAT 0x00000604
+#define MCDE_CHNL0STAT_GROUPOFFSET 0x20
+#define MCDE_CHNL0STAT_CHNLRD_SHIFT 0
+#define MCDE_CHNL0STAT_CHNLRD_MASK 0x00000001
+#define MCDE_CHNL0STAT_CHNLRD(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0STAT, CHNLRD, __x)
+#define MCDE_CHNL0STAT_CHNLA_SHIFT 1
+#define MCDE_CHNL0STAT_CHNLA_MASK 0x00000002
+#define MCDE_CHNL0STAT_CHNLA(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0STAT, CHNLA, __x)
+#define MCDE_CHNL0STAT_CHNLBLBCKGND_EN_SHIFT 16
+#define MCDE_CHNL0STAT_CHNLBLBCKGND_EN_MASK 0x00010000
+#define MCDE_CHNL0STAT_CHNLBLBCKGND_EN(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0STAT, CHNLBLBCKGND_EN, __x)
+#define MCDE_CHNL1STAT 0x00000624
+#define MCDE_CHNL1STAT_CHNLRD_SHIFT 0
+#define MCDE_CHNL1STAT_CHNLRD_MASK 0x00000001
+#define MCDE_CHNL1STAT_CHNLRD(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1STAT, CHNLRD, __x)
+#define MCDE_CHNL1STAT_CHNLA_SHIFT 1
+#define MCDE_CHNL1STAT_CHNLA_MASK 0x00000002
+#define MCDE_CHNL1STAT_CHNLA(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1STAT, CHNLA, __x)
+#define MCDE_CHNL1STAT_CHNLBLBCKGND_EN_SHIFT 16
+#define MCDE_CHNL1STAT_CHNLBLBCKGND_EN_MASK 0x00010000
+#define MCDE_CHNL1STAT_CHNLBLBCKGND_EN(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1STAT, CHNLBLBCKGND_EN, __x)
+#define MCDE_CHNL2STAT 0x00000644
+#define MCDE_CHNL2STAT_CHNLRD_SHIFT 0
+#define MCDE_CHNL2STAT_CHNLRD_MASK 0x00000001
+#define MCDE_CHNL2STAT_CHNLRD(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2STAT, CHNLRD, __x)
+#define MCDE_CHNL2STAT_CHNLA_SHIFT 1
+#define MCDE_CHNL2STAT_CHNLA_MASK 0x00000002
+#define MCDE_CHNL2STAT_CHNLA(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2STAT, CHNLA, __x)
+#define MCDE_CHNL2STAT_CHNLBLBCKGND_EN_SHIFT 16
+#define MCDE_CHNL2STAT_CHNLBLBCKGND_EN_MASK 0x00010000
+#define MCDE_CHNL2STAT_CHNLBLBCKGND_EN(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2STAT, CHNLBLBCKGND_EN, __x)
+#define MCDE_CHNL3STAT 0x00000664
+#define MCDE_CHNL3STAT_CHNLRD_SHIFT 0
+#define MCDE_CHNL3STAT_CHNLRD_MASK 0x00000001
+#define MCDE_CHNL3STAT_CHNLRD(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3STAT, CHNLRD, __x)
+#define MCDE_CHNL3STAT_CHNLA_SHIFT 1
+#define MCDE_CHNL3STAT_CHNLA_MASK 0x00000002
+#define MCDE_CHNL3STAT_CHNLA(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3STAT, CHNLA, __x)
+#define MCDE_CHNL3STAT_CHNLBLBCKGND_EN_SHIFT 16
+#define MCDE_CHNL3STAT_CHNLBLBCKGND_EN_MASK 0x00010000
+#define MCDE_CHNL3STAT_CHNLBLBCKGND_EN(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3STAT, CHNLBLBCKGND_EN, __x)
+#define MCDE_CHNL0SYNCHMOD 0x00000608
+#define MCDE_CHNL0SYNCHMOD_GROUPOFFSET 0x20
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_SHIFT 0
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_MASK 0x00000003
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_OUTPUT 0
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_AUTO 1
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_SOFTWARE 2
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_EXTERNAL 3
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0SYNCHMOD, SRC_SYNCH, \
+	MCDE_CHNL0SYNCHMOD_SRC_SYNCH_##__x)
+#define MCDE_CHNL0SYNCHMOD_SRC_SYNCH(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0SYNCHMOD, SRC_SYNCH, __x)
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_SHIFT 2
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_MASK 0x0000001C
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_FORMATTER 0
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_VSYNC0 1
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_VSYNC1 2
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0SYNCHMOD, OUT_SYNCH_SRC, \
+	MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC_##__x)
+#define MCDE_CHNL0SYNCHMOD_OUT_SYNCH_SRC(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0SYNCHMOD, OUT_SYNCH_SRC, __x)
+#define MCDE_CHNL1SYNCHMOD 0x00000628
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_SHIFT 0
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_MASK 0x00000003
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_OUTPUT 0
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_AUTO 1
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_SOFTWARE 2
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_EXTERNAL 3
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1SYNCHMOD, SRC_SYNCH, \
+	MCDE_CHNL1SYNCHMOD_SRC_SYNCH_##__x)
+#define MCDE_CHNL1SYNCHMOD_SRC_SYNCH(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1SYNCHMOD, SRC_SYNCH, __x)
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_SHIFT 2
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_MASK 0x0000001C
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_FORMATTER 0
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_VSYNC0 1
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_VSYNC1 2
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1SYNCHMOD, OUT_SYNCH_SRC, \
+	MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC_##__x)
+#define MCDE_CHNL1SYNCHMOD_OUT_SYNCH_SRC(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1SYNCHMOD, OUT_SYNCH_SRC, __x)
+#define MCDE_CHNL2SYNCHMOD 0x00000648
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_SHIFT 0
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_MASK 0x00000003
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_OUTPUT 0
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_AUTO 1
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_SOFTWARE 2
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_EXTERNAL 3
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2SYNCHMOD, SRC_SYNCH, \
+	MCDE_CHNL2SYNCHMOD_SRC_SYNCH_##__x)
+#define MCDE_CHNL2SYNCHMOD_SRC_SYNCH(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2SYNCHMOD, SRC_SYNCH, __x)
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_SHIFT 2
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_MASK 0x0000001C
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_FORMATTER 0
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_VSYNC0 1
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_VSYNC1 2
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2SYNCHMOD, OUT_SYNCH_SRC, \
+	MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC_##__x)
+#define MCDE_CHNL2SYNCHMOD_OUT_SYNCH_SRC(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2SYNCHMOD, OUT_SYNCH_SRC, __x)
+#define MCDE_CHNL3SYNCHMOD 0x00000668
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_SHIFT 0
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_MASK 0x00000003
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_OUTPUT 0
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_AUTO 1
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_SOFTWARE 2
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_EXTERNAL 3
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3SYNCHMOD, SRC_SYNCH, \
+	MCDE_CHNL3SYNCHMOD_SRC_SYNCH_##__x)
+#define MCDE_CHNL3SYNCHMOD_SRC_SYNCH(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3SYNCHMOD, SRC_SYNCH, __x)
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_SHIFT 2
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_MASK 0x0000001C
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_FORMATTER 0
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_VSYNC0 1
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_VSYNC1 2
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3SYNCHMOD, OUT_SYNCH_SRC, \
+	MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC_##__x)
+#define MCDE_CHNL3SYNCHMOD_OUT_SYNCH_SRC(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3SYNCHMOD, OUT_SYNCH_SRC, __x)
+#define MCDE_CHNL0SYNCHSW 0x0000060C
+#define MCDE_CHNL0SYNCHSW_GROUPOFFSET 0x20
+#define MCDE_CHNL0SYNCHSW_SW_TRIG_SHIFT 0
+#define MCDE_CHNL0SYNCHSW_SW_TRIG_MASK 0x00000001
+#define MCDE_CHNL0SYNCHSW_SW_TRIG(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0SYNCHSW, SW_TRIG, __x)
+#define MCDE_CHNL1SYNCHSW 0x0000062C
+#define MCDE_CHNL1SYNCHSW_SW_TRIG_SHIFT 0
+#define MCDE_CHNL1SYNCHSW_SW_TRIG_MASK 0x00000001
+#define MCDE_CHNL1SYNCHSW_SW_TRIG(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1SYNCHSW, SW_TRIG, __x)
+#define MCDE_CHNL2SYNCHSW 0x0000064C
+#define MCDE_CHNL2SYNCHSW_SW_TRIG_SHIFT 0
+#define MCDE_CHNL2SYNCHSW_SW_TRIG_MASK 0x00000001
+#define MCDE_CHNL2SYNCHSW_SW_TRIG(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2SYNCHSW, SW_TRIG, __x)
+#define MCDE_CHNL3SYNCHSW 0x0000066C
+#define MCDE_CHNL3SYNCHSW_SW_TRIG_SHIFT 0
+#define MCDE_CHNL3SYNCHSW_SW_TRIG_MASK 0x00000001
+#define MCDE_CHNL3SYNCHSW_SW_TRIG(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3SYNCHSW, SW_TRIG, __x)
+#define MCDE_CHNL0BCKGNDCOL 0x00000610
+#define MCDE_CHNL0BCKGNDCOL_GROUPOFFSET 0x20
+#define MCDE_CHNL0BCKGNDCOL_B_SHIFT 0
+#define MCDE_CHNL0BCKGNDCOL_B_MASK 0x000000FF
+#define MCDE_CHNL0BCKGNDCOL_B(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0BCKGNDCOL, B, __x)
+#define MCDE_CHNL0BCKGNDCOL_G_SHIFT 8
+#define MCDE_CHNL0BCKGNDCOL_G_MASK 0x0000FF00
+#define MCDE_CHNL0BCKGNDCOL_G(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0BCKGNDCOL, G, __x)
+#define MCDE_CHNL0BCKGNDCOL_R_SHIFT 16
+#define MCDE_CHNL0BCKGNDCOL_R_MASK 0x00FF0000
+#define MCDE_CHNL0BCKGNDCOL_R(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0BCKGNDCOL, R, __x)
+#define MCDE_CHNL1BCKGNDCOL 0x00000630
+#define MCDE_CHNL1BCKGNDCOL_B_SHIFT 0
+#define MCDE_CHNL1BCKGNDCOL_B_MASK 0x000000FF
+#define MCDE_CHNL1BCKGNDCOL_B(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1BCKGNDCOL, B, __x)
+#define MCDE_CHNL1BCKGNDCOL_G_SHIFT 8
+#define MCDE_CHNL1BCKGNDCOL_G_MASK 0x0000FF00
+#define MCDE_CHNL1BCKGNDCOL_G(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1BCKGNDCOL, G, __x)
+#define MCDE_CHNL1BCKGNDCOL_R_SHIFT 16
+#define MCDE_CHNL1BCKGNDCOL_R_MASK 0x00FF0000
+#define MCDE_CHNL1BCKGNDCOL_R(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1BCKGNDCOL, R, __x)
+#define MCDE_CHNL2BCKGNDCOL 0x00000650
+#define MCDE_CHNL2BCKGNDCOL_B_SHIFT 0
+#define MCDE_CHNL2BCKGNDCOL_B_MASK 0x000000FF
+#define MCDE_CHNL2BCKGNDCOL_B(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2BCKGNDCOL, B, __x)
+#define MCDE_CHNL2BCKGNDCOL_G_SHIFT 8
+#define MCDE_CHNL2BCKGNDCOL_G_MASK 0x0000FF00
+#define MCDE_CHNL2BCKGNDCOL_G(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2BCKGNDCOL, G, __x)
+#define MCDE_CHNL2BCKGNDCOL_R_SHIFT 16
+#define MCDE_CHNL2BCKGNDCOL_R_MASK 0x00FF0000
+#define MCDE_CHNL2BCKGNDCOL_R(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2BCKGNDCOL, R, __x)
+#define MCDE_CHNL3BCKGNDCOL 0x00000670
+#define MCDE_CHNL3BCKGNDCOL_B_SHIFT 0
+#define MCDE_CHNL3BCKGNDCOL_B_MASK 0x000000FF
+#define MCDE_CHNL3BCKGNDCOL_B(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3BCKGNDCOL, B, __x)
+#define MCDE_CHNL3BCKGNDCOL_G_SHIFT 8
+#define MCDE_CHNL3BCKGNDCOL_G_MASK 0x0000FF00
+#define MCDE_CHNL3BCKGNDCOL_G(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3BCKGNDCOL, G, __x)
+#define MCDE_CHNL3BCKGNDCOL_R_SHIFT 16
+#define MCDE_CHNL3BCKGNDCOL_R_MASK 0x00FF0000
+#define MCDE_CHNL3BCKGNDCOL_R(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3BCKGNDCOL, R, __x)
+#define MCDE_CHNL0PRIO_V1 0x00000614
+#define MCDE_CHNL0PRIO_V1_GROUPOFFSET 0x20
+#define MCDE_CHNL0PRIO_V1_CHNLPRIO_SHIFT 0
+#define MCDE_CHNL0PRIO_V1_CHNLPRIO_MASK 0x0000000F
+#define MCDE_CHNL0PRIO_V1_CHNLPRIO(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0PRIO_V1, CHNLPRIO, __x)
+#define MCDE_CHNL1PRIO_V1 0x00000634
+#define MCDE_CHNL1PRIO_V1_CHNLPRIO_SHIFT 0
+#define MCDE_CHNL1PRIO_V1_CHNLPRIO_MASK 0x0000000F
+#define MCDE_CHNL1PRIO_V1_CHNLPRIO(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1PRIO_V1, CHNLPRIO, __x)
+#define MCDE_CHNL2PRIO_V1 0x00000654
+#define MCDE_CHNL2PRIO_V1_CHNLPRIO_SHIFT 0
+#define MCDE_CHNL2PRIO_V1_CHNLPRIO_MASK 0x0000000F
+#define MCDE_CHNL2PRIO_V1_CHNLPRIO(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2PRIO_V1, CHNLPRIO, __x)
+#define MCDE_CHNL3PRIO_V1 0x00000674
+#define MCDE_CHNL3PRIO_V1_CHNLPRIO_SHIFT 0
+#define MCDE_CHNL3PRIO_V1_CHNLPRIO_MASK 0x0000000F
+#define MCDE_CHNL3PRIO_V1_CHNLPRIO(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3PRIO_V1, CHNLPRIO, __x)
+#define MCDE_CHNL0MUXING_V2 0x00000614
+#define MCDE_CHNL0MUXING_V2_GROUPOFFSET 0x20
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_SHIFT 0
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_MASK 0x00000007
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_FIFO_A 0
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_FIFO_B 1
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_FIFO_C0 2
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_FIFO_C1 3
+#define MCDE_CHNL0MUXING_V2_FIFO_ID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0MUXING_V2, FIFO_ID, \
+	MCDE_CHNL0MUXING_V2_FIFO_ID_##__x)
+#define MCDE_CHNL0MUXING_V2_FIFO_ID(__x) \
+	MCDE_VAL2REG(MCDE_CHNL0MUXING_V2, FIFO_ID, __x)
+#define MCDE_CHNL1MUXING_V2 0x00000634
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_SHIFT 0
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_MASK 0x00000007
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_FIFO_A 0
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_FIFO_B 1
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_FIFO_C0 2
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_FIFO_C1 3
+#define MCDE_CHNL1MUXING_V2_FIFO_ID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1MUXING_V2, FIFO_ID, \
+	MCDE_CHNL1MUXING_V2_FIFO_ID_##__x)
+#define MCDE_CHNL1MUXING_V2_FIFO_ID(__x) \
+	MCDE_VAL2REG(MCDE_CHNL1MUXING_V2, FIFO_ID, __x)
+#define MCDE_CHNL2MUXING_V2 0x00000654
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_SHIFT 0
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_MASK 0x00000007
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_FIFO_A 0
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_FIFO_B 1
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_FIFO_C0 2
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_FIFO_C1 3
+#define MCDE_CHNL2MUXING_V2_FIFO_ID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2MUXING_V2, FIFO_ID, \
+	MCDE_CHNL2MUXING_V2_FIFO_ID_##__x)
+#define MCDE_CHNL2MUXING_V2_FIFO_ID(__x) \
+	MCDE_VAL2REG(MCDE_CHNL2MUXING_V2, FIFO_ID, __x)
+#define MCDE_CHNL3MUXING_V2 0x00000674
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_SHIFT 0
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_MASK 0x00000007
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_FIFO_A 0
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_FIFO_B 1
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_FIFO_C0 2
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_FIFO_C1 3
+#define MCDE_CHNL3MUXING_V2_FIFO_ID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3MUXING_V2, FIFO_ID, \
+	MCDE_CHNL3MUXING_V2_FIFO_ID_##__x)
+#define MCDE_CHNL3MUXING_V2_FIFO_ID(__x) \
+	MCDE_VAL2REG(MCDE_CHNL3MUXING_V2, FIFO_ID, __x)
+#define MCDE_CRA0 0x00000800
+#define MCDE_CRA0_GROUPOFFSET 0x200
+#define MCDE_CRA0_FLOEN_SHIFT 0
+#define MCDE_CRA0_FLOEN_MASK 0x00000001
+#define MCDE_CRA0_FLOEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, FLOEN, __x)
+#define MCDE_CRA0_POWEREN_SHIFT 1
+#define MCDE_CRA0_POWEREN_MASK 0x00000002
+#define MCDE_CRA0_POWEREN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, POWEREN, __x)
+#define MCDE_CRA0_BLENDEN_SHIFT 2
+#define MCDE_CRA0_BLENDEN_MASK 0x00000004
+#define MCDE_CRA0_BLENDEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, BLENDEN, __x)
+#define MCDE_CRA0_AFLICKEN_SHIFT 3
+#define MCDE_CRA0_AFLICKEN_MASK 0x00000008
+#define MCDE_CRA0_AFLICKEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, AFLICKEN, __x)
+#define MCDE_CRA0_PALEN_SHIFT 4
+#define MCDE_CRA0_PALEN_MASK 0x00000010
+#define MCDE_CRA0_PALEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, PALEN, __x)
+#define MCDE_CRA0_DITHEN_SHIFT 5
+#define MCDE_CRA0_DITHEN_MASK 0x00000020
+#define MCDE_CRA0_DITHEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, DITHEN, __x)
+#define MCDE_CRA0_GAMEN_SHIFT 6
+#define MCDE_CRA0_GAMEN_MASK 0x00000040
+#define MCDE_CRA0_GAMEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, GAMEN, __x)
+#define MCDE_CRA0_KEYCTRL_SHIFT 7
+#define MCDE_CRA0_KEYCTRL_MASK 0x00000380
+#define MCDE_CRA0_KEYCTRL_OFF 0
+#define MCDE_CRA0_KEYCTRL_ALPHA_RGB 1
+#define MCDE_CRA0_KEYCTRL_RGB 2
+#define MCDE_CRA0_KEYCTRL_FALPHA_FRGB 4
+#define MCDE_CRA0_KEYCTRL_FRGB 5
+#define MCDE_CRA0_KEYCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, KEYCTRL, MCDE_CRA0_KEYCTRL_##__x)
+#define MCDE_CRA0_KEYCTRL(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, KEYCTRL, __x)
+#define MCDE_CRA0_BLENDCTRL_SHIFT 10
+#define MCDE_CRA0_BLENDCTRL_MASK 0x00000400
+#define MCDE_CRA0_BLENDCTRL_SOURCE 0
+#define MCDE_CRA0_BLENDCTRL_CONSTANT 1
+#define MCDE_CRA0_BLENDCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, BLENDCTRL, MCDE_CRA0_BLENDCTRL_##__x)
+#define MCDE_CRA0_BLENDCTRL(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, BLENDCTRL, __x)
+#define MCDE_CRA0_FLICKMODE_SHIFT 11
+#define MCDE_CRA0_FLICKMODE_MASK 0x00001800
+#define MCDE_CRA0_FLICKMODE_FORCE_FILTER_0 0
+#define MCDE_CRA0_FLICKMODE_ADAPTIVE 1
+#define MCDE_CRA0_FLICKMODE_TEST_MODE 2
+#define MCDE_CRA0_FLICKMODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, FLICKMODE, MCDE_CRA0_FLICKMODE_##__x)
+#define MCDE_CRA0_FLICKMODE(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, FLICKMODE, __x)
+#define MCDE_CRA0_FLOCKFORMAT_SHIFT 13
+#define MCDE_CRA0_FLOCKFORMAT_MASK 0x00002000
+#define MCDE_CRA0_FLOCKFORMAT_YCBCR 0
+#define MCDE_CRA0_FLOCKFORMAT_RGB 1
+#define MCDE_CRA0_FLOCKFORMAT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, FLOCKFORMAT, MCDE_CRA0_FLOCKFORMAT_##__x)
+#define MCDE_CRA0_FLOCKFORMAT(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, FLOCKFORMAT, __x)
+#define MCDE_CRA0_PALMODE_SHIFT 14
+#define MCDE_CRA0_PALMODE_MASK 0x00004000
+#define MCDE_CRA0_PALMODE_PALETTE 0
+#define MCDE_CRA0_PALMODE_GAMMA 1
+#define MCDE_CRA0_PALMODE(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, PALMODE, __x)
+#define MCDE_CRA0_OLEDEN_SHIFT 15
+#define MCDE_CRA0_OLEDEN_MASK 0x00008000
+#define MCDE_CRA0_OLEDEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, OLEDEN, __x)
+#define MCDE_CRA0_ALPHABLEND_SHIFT 16
+#define MCDE_CRA0_ALPHABLEND_MASK 0x00FF0000
+#define MCDE_CRA0_ALPHABLEND(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, ALPHABLEND, __x)
+#define MCDE_CRA0_ROTEN_SHIFT 24
+#define MCDE_CRA0_ROTEN_MASK 0x01000000
+#define MCDE_CRA0_ROTEN(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, ROTEN, __x)
+#define MCDE_CRA0_ROTBURSTSIZE_V1_SHIFT 25
+#define MCDE_CRA0_ROTBURSTSIZE_V1_MASK 0x0E000000
+#define MCDE_CRA0_ROTBURSTSIZE_V1_1W 0
+#define MCDE_CRA0_ROTBURSTSIZE_V1_2W 1
+#define MCDE_CRA0_ROTBURSTSIZE_V1_4W 2
+#define MCDE_CRA0_ROTBURSTSIZE_V1_8W 3
+#define MCDE_CRA0_ROTBURSTSIZE_V1_16W 4
+#define MCDE_CRA0_ROTBURSTSIZE_V1_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, ROTBURSTSIZE_V1, \
+	MCDE_CRA0_ROTBURSTSIZE_V1_##__x)
+#define MCDE_CRA0_ROTBURSTSIZE_V1(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, ROTBURSTSIZE_V1, __x)
+#define MCDE_CRA0_ROTBURSTSIZE_HW_V1_SHIFT 28
+#define MCDE_CRA0_ROTBURSTSIZE_HW_V1_MASK 0x10000000
+#define MCDE_CRA0_ROTBURSTSIZE_HW_V1(__x) \
+	MCDE_VAL2REG(MCDE_CRA0, ROTBURSTSIZE_HW_V1, __x)
+#define MCDE_CRB0 0x00000A00
+#define MCDE_CRB0_FLOEN_SHIFT 0
+#define MCDE_CRB0_FLOEN_MASK 0x00000001
+#define MCDE_CRB0_FLOEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, FLOEN, __x)
+#define MCDE_CRB0_POWEREN_SHIFT 1
+#define MCDE_CRB0_POWEREN_MASK 0x00000002
+#define MCDE_CRB0_POWEREN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, POWEREN, __x)
+#define MCDE_CRB0_BLENDEN_SHIFT 2
+#define MCDE_CRB0_BLENDEN_MASK 0x00000004
+#define MCDE_CRB0_BLENDEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, BLENDEN, __x)
+#define MCDE_CRB0_AFLICKEN_SHIFT 3
+#define MCDE_CRB0_AFLICKEN_MASK 0x00000008
+#define MCDE_CRB0_AFLICKEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, AFLICKEN, __x)
+#define MCDE_CRB0_PALEN_SHIFT 4
+#define MCDE_CRB0_PALEN_MASK 0x00000010
+#define MCDE_CRB0_PALEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, PALEN, __x)
+#define MCDE_CRB0_DITHEN_SHIFT 5
+#define MCDE_CRB0_DITHEN_MASK 0x00000020
+#define MCDE_CRB0_DITHEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, DITHEN, __x)
+#define MCDE_CRB0_GAMEN_SHIFT 6
+#define MCDE_CRB0_GAMEN_MASK 0x00000040
+#define MCDE_CRB0_GAMEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, GAMEN, __x)
+#define MCDE_CRB0_KEYCTRL_SHIFT 7
+#define MCDE_CRB0_KEYCTRL_MASK 0x00000380
+#define MCDE_CRB0_KEYCTRL_OFF 0
+#define MCDE_CRB0_KEYCTRL_ALPHA_RGB 1
+#define MCDE_CRB0_KEYCTRL_RGB 2
+#define MCDE_CRB0_KEYCTRL_FALPHA_FRGB 4
+#define MCDE_CRB0_KEYCTRL_FRGB 5
+#define MCDE_CRB0_KEYCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, KEYCTRL, MCDE_CRB0_KEYCTRL_##__x)
+#define MCDE_CRB0_KEYCTRL(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, KEYCTRL, __x)
+#define MCDE_CRB0_BLENDCTRL_SHIFT 10
+#define MCDE_CRB0_BLENDCTRL_MASK 0x00000400
+#define MCDE_CRB0_BLENDCTRL_SOURCE 0
+#define MCDE_CRB0_BLENDCTRL_CONSTANT 1
+#define MCDE_CRB0_BLENDCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, BLENDCTRL, MCDE_CRB0_BLENDCTRL_##__x)
+#define MCDE_CRB0_BLENDCTRL(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, BLENDCTRL, __x)
+#define MCDE_CRB0_FLICKMODE_SHIFT 11
+#define MCDE_CRB0_FLICKMODE_MASK 0x00001800
+#define MCDE_CRB0_FLICKMODE_FORCE_FILTER_0 0
+#define MCDE_CRB0_FLICKMODE_ADAPTIVE 1
+#define MCDE_CRB0_FLICKMODE_TEST_MODE 2
+#define MCDE_CRB0_FLICKMODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, FLICKMODE, MCDE_CRB0_FLICKMODE_##__x)
+#define MCDE_CRB0_FLICKMODE(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, FLICKMODE, __x)
+#define MCDE_CRB0_FLOCKFORMAT_SHIFT 13
+#define MCDE_CRB0_FLOCKFORMAT_MASK 0x00002000
+#define MCDE_CRB0_FLOCKFORMAT_YCBCR 0
+#define MCDE_CRB0_FLOCKFORMAT_RGB 1
+#define MCDE_CRB0_FLOCKFORMAT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, FLOCKFORMAT, MCDE_CRB0_FLOCKFORMAT_##__x)
+#define MCDE_CRB0_FLOCKFORMAT(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, FLOCKFORMAT, __x)
+#define MCDE_CRB0_PALMODE_SHIFT 14
+#define MCDE_CRB0_PALMODE_MASK 0x00004000
+#define MCDE_CRB0_PALMODE_PALETTE 0
+#define MCDE_CRB0_PALMODE_GAMMA 1
+#define MCDE_CRB0_PALMODE(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, PALMODE, __x)
+#define MCDE_CRB0_OLEDEN_SHIFT 15
+#define MCDE_CRB0_OLEDEN_MASK 0x00008000
+#define MCDE_CRB0_OLEDEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, OLEDEN, __x)
+#define MCDE_CRB0_ALPHABLEND_SHIFT 16
+#define MCDE_CRB0_ALPHABLEND_MASK 0x00FF0000
+#define MCDE_CRB0_ALPHABLEND(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, ALPHABLEND, __x)
+#define MCDE_CRB0_ROTEN_SHIFT 24
+#define MCDE_CRB0_ROTEN_MASK 0x01000000
+#define MCDE_CRB0_ROTEN(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, ROTEN, __x)
+#define MCDE_CRB0_ROTBURSTSIZE_V1_SHIFT 25
+#define MCDE_CRB0_ROTBURSTSIZE_V1_MASK 0x0E000000
+#define MCDE_CRB0_ROTBURSTSIZE_V1_1W 0
+#define MCDE_CRB0_ROTBURSTSIZE_V1_2W 1
+#define MCDE_CRB0_ROTBURSTSIZE_V1_4W 2
+#define MCDE_CRB0_ROTBURSTSIZE_V1_8W 3
+#define MCDE_CRB0_ROTBURSTSIZE_V1_16W 4
+#define MCDE_CRB0_ROTBURSTSIZE_V1_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, ROTBURSTSIZE_V1, \
+	MCDE_CRB0_ROTBURSTSIZE_V1_##__x)
+#define MCDE_CRB0_ROTBURSTSIZE_V1(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, ROTBURSTSIZE_V1, __x)
+#define MCDE_CRB0_ROTBURSTSIZE_HW_V1_SHIFT 28
+#define MCDE_CRB0_ROTBURSTSIZE_HW_V1_MASK 0x10000000
+#define MCDE_CRB0_ROTBURSTSIZE_HW_V1(__x) \
+	MCDE_VAL2REG(MCDE_CRB0, ROTBURSTSIZE_HW_V1, __x)
+#define MCDE_CRA1 0x00000804
+#define MCDE_CRA1_GROUPOFFSET 0x200
+#define MCDE_CRA1_PCD_SHIFT 0
+#define MCDE_CRA1_PCD_MASK 0x000003FF
+#define MCDE_CRA1_PCD(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, PCD, __x)
+#define MCDE_CRA1_CLKSEL_SHIFT 10
+#define MCDE_CRA1_CLKSEL_MASK 0x00001C00
+#define MCDE_CRA1_CLKSEL_LCD 0
+#define MCDE_CRA1_CLKSEL_HDMI 1
+#define MCDE_CRA1_CLKSEL_TV 2
+#define MCDE_CRA1_CLKSEL_EXT_TV1 3
+#define MCDE_CRA1_CLKSEL_EXT_TV2 4
+#define MCDE_CRA1_CLKSEL_166MHZ 5
+#define MCDE_CRA1_CLKSEL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, CLKSEL, MCDE_CRA1_CLKSEL_##__x)
+#define MCDE_CRA1_CLKSEL(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, CLKSEL, __x)
+#define MCDE_CRA1_CDWIN_SHIFT 13
+#define MCDE_CRA1_CDWIN_MASK 0x0001E000
+#define MCDE_CRA1_CDWIN_8BBP_C1 0
+#define MCDE_CRA1_CDWIN_12BBP_C1 1
+#define MCDE_CRA1_CDWIN_12BBP_C2 2
+#define MCDE_CRA1_CDWIN_16BBP_C1 3
+#define MCDE_CRA1_CDWIN_16BBP_C2 4
+#define MCDE_CRA1_CDWIN_18BBP_C1 5
+#define MCDE_CRA1_CDWIN_18BBP_C2 6
+#define MCDE_CRA1_CDWIN_24BBP 7
+#define MCDE_CRA1_CDWIN_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, CDWIN, MCDE_CRA1_CDWIN_##__x)
+#define MCDE_CRA1_CDWIN(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, CDWIN, __x)
+#define MCDE_CRA1_OUTBPP_SHIFT 25
+#define MCDE_CRA1_OUTBPP_MASK 0x1E000000
+#define MCDE_CRA1_OUTBPP_MONO1 0
+#define MCDE_CRA1_OUTBPP_MONO2 1
+#define MCDE_CRA1_OUTBPP_MONO4 2
+#define MCDE_CRA1_OUTBPP_MONO8 3
+#define MCDE_CRA1_OUTBPP_8BPP 4
+#define MCDE_CRA1_OUTBPP_12BPP 5
+#define MCDE_CRA1_OUTBPP_15BPP 6
+#define MCDE_CRA1_OUTBPP_16BPP 7
+#define MCDE_CRA1_OUTBPP_18BPP 8
+#define MCDE_CRA1_OUTBPP_24BPP 9
+#define MCDE_CRA1_OUTBPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, OUTBPP, MCDE_CRA1_OUTBPP_##__x)
+#define MCDE_CRA1_OUTBPP(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, OUTBPP, __x)
+#define MCDE_CRA1_BCD_SHIFT 29
+#define MCDE_CRA1_BCD_MASK 0x20000000
+#define MCDE_CRA1_BCD(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, BCD, __x)
+#define MCDE_CRA1_CLKTYPE_SHIFT 30
+#define MCDE_CRA1_CLKTYPE_MASK 0x40000000
+#define MCDE_CRA1_CLKTYPE_EXTERNAL 0
+#define MCDE_CRA1_CLKTYPE_INTERNAL 1
+#define MCDE_CRA1_CLKTYPE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, CLKTYPE, MCDE_CRA1_CLKTYPE_##__x)
+#define MCDE_CRA1_CLKTYPE(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, CLKTYPE, __x)
+#define MCDE_CRA1_TEFFECTEN_V1_SHIFT 31
+#define MCDE_CRA1_TEFFECTEN_V1_MASK 0x80000000
+#define MCDE_CRA1_TEFFECTEN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CRA1, TEFFECTEN_V1, __x)
+#define MCDE_CRB1 0x00000A04
+#define MCDE_CRB1_PCD_SHIFT 0
+#define MCDE_CRB1_PCD_MASK 0x000003FF
+#define MCDE_CRB1_PCD(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, PCD, __x)
+#define MCDE_CRB1_CLKSEL_SHIFT 10
+#define MCDE_CRB1_CLKSEL_MASK 0x00001C00
+#define MCDE_CRB1_CLKSEL_LCD 0
+#define MCDE_CRB1_CLKSEL_HDMI 1
+#define MCDE_CRB1_CLKSEL_TV 2
+#define MCDE_CRB1_CLKSEL_EXT_TV1 3
+#define MCDE_CRB1_CLKSEL_EXT_TV2 4
+#define MCDE_CRB1_CLKSEL_166MHZ 5
+#define MCDE_CRB1_CLKSEL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, CLKSEL, MCDE_CRB1_CLKSEL_##__x)
+#define MCDE_CRB1_CLKSEL(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, CLKSEL, __x)
+#define MCDE_CRB1_CDWIN_SHIFT 13
+#define MCDE_CRB1_CDWIN_MASK 0x0001E000
+#define MCDE_CRB1_CDWIN_8BBP_C1 0
+#define MCDE_CRB1_CDWIN_12BBP_C1 1
+#define MCDE_CRB1_CDWIN_12BBP_C2 2
+#define MCDE_CRB1_CDWIN_16BBP_C1 3
+#define MCDE_CRB1_CDWIN_16BBP_C2 4
+#define MCDE_CRB1_CDWIN_18BBP_C1 5
+#define MCDE_CRB1_CDWIN_18BBP_C2 6
+#define MCDE_CRB1_CDWIN_24BBP 7
+#define MCDE_CRB1_CDWIN_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, CDWIN, MCDE_CRB1_CDWIN_##__x)
+#define MCDE_CRB1_CDWIN(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, CDWIN, __x)
+#define MCDE_CRB1_OUTBPP_SHIFT 25
+#define MCDE_CRB1_OUTBPP_MASK 0x1E000000
+#define MCDE_CRB1_OUTBPP_MONO1 0
+#define MCDE_CRB1_OUTBPP_MONO2 1
+#define MCDE_CRB1_OUTBPP_MONO4 2
+#define MCDE_CRB1_OUTBPP_MONO8 3
+#define MCDE_CRB1_OUTBPP_8BPP 4
+#define MCDE_CRB1_OUTBPP_12BPP 5
+#define MCDE_CRB1_OUTBPP_15BPP 6
+#define MCDE_CRB1_OUTBPP_16BPP 7
+#define MCDE_CRB1_OUTBPP_18BPP 8
+#define MCDE_CRB1_OUTBPP_24BPP 9
+#define MCDE_CRB1_OUTBPP_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, OUTBPP, MCDE_CRB1_OUTBPP_##__x)
+#define MCDE_CRB1_OUTBPP(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, OUTBPP, __x)
+#define MCDE_CRB1_BCD_SHIFT 29
+#define MCDE_CRB1_BCD_MASK 0x20000000
+#define MCDE_CRB1_BCD(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, BCD, __x)
+#define MCDE_CRB1_CLKTYPE_SHIFT 30
+#define MCDE_CRB1_CLKTYPE_MASK 0x40000000
+#define MCDE_CRB1_CLKTYPE_EXTERNAL 0
+#define MCDE_CRB1_CLKTYPE_INTERNAL 1
+#define MCDE_CRB1_CLKTYPE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, CLKTYPE, MCDE_CRB1_CLKTYPE_##__x)
+#define MCDE_CRB1_CLKTYPE(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, CLKTYPE, __x)
+#define MCDE_CRB1_TEFFECTEN_V1_SHIFT 31
+#define MCDE_CRB1_TEFFECTEN_V1_MASK 0x80000000
+#define MCDE_CRB1_TEFFECTEN_V1(__x) \
+	MCDE_VAL2REG(MCDE_CRB1, TEFFECTEN_V1, __x)
+#define MCDE_COLKEYA 0x00000808
+#define MCDE_COLKEYA_GROUPOFFSET 0x200
+#define MCDE_COLKEYA_KEYB_SHIFT 0
+#define MCDE_COLKEYA_KEYB_MASK 0x000000FF
+#define MCDE_COLKEYA_KEYB(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYA, KEYB, __x)
+#define MCDE_COLKEYA_KEYG_SHIFT 8
+#define MCDE_COLKEYA_KEYG_MASK 0x0000FF00
+#define MCDE_COLKEYA_KEYG(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYA, KEYG, __x)
+#define MCDE_COLKEYA_KEYR_SHIFT 16
+#define MCDE_COLKEYA_KEYR_MASK 0x00FF0000
+#define MCDE_COLKEYA_KEYR(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYA, KEYR, __x)
+#define MCDE_COLKEYA_KEYA_SHIFT 24
+#define MCDE_COLKEYA_KEYA_MASK 0xFF000000
+#define MCDE_COLKEYA_KEYA(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYA, KEYA, __x)
+#define MCDE_COLKEYB 0x00000A08
+#define MCDE_COLKEYB_KEYB_SHIFT 0
+#define MCDE_COLKEYB_KEYB_MASK 0x000000FF
+#define MCDE_COLKEYB_KEYB(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYB, KEYB, __x)
+#define MCDE_COLKEYB_KEYG_SHIFT 8
+#define MCDE_COLKEYB_KEYG_MASK 0x0000FF00
+#define MCDE_COLKEYB_KEYG(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYB, KEYG, __x)
+#define MCDE_COLKEYB_KEYR_SHIFT 16
+#define MCDE_COLKEYB_KEYR_MASK 0x00FF0000
+#define MCDE_COLKEYB_KEYR(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYB, KEYR, __x)
+#define MCDE_COLKEYB_KEYA_SHIFT 24
+#define MCDE_COLKEYB_KEYA_MASK 0xFF000000
+#define MCDE_COLKEYB_KEYA(__x) \
+	MCDE_VAL2REG(MCDE_COLKEYB, KEYA, __x)
+#define MCDE_FCOLKEYA 0x0000080C
+#define MCDE_FCOLKEYA_GROUPOFFSET 0x200
+#define MCDE_FCOLKEYA_FKEYB_SHIFT 0
+#define MCDE_FCOLKEYA_FKEYB_MASK 0x000000FF
+#define MCDE_FCOLKEYA_FKEYB(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYA, FKEYB, __x)
+#define MCDE_FCOLKEYA_FKEYG_SHIFT 8
+#define MCDE_FCOLKEYA_FKEYG_MASK 0x0000FF00
+#define MCDE_FCOLKEYA_FKEYG(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYA, FKEYG, __x)
+#define MCDE_FCOLKEYA_FKEYR_SHIFT 16
+#define MCDE_FCOLKEYA_FKEYR_MASK 0x00FF0000
+#define MCDE_FCOLKEYA_FKEYR(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYA, FKEYR, __x)
+#define MCDE_FCOLKEYA_FKEYA_SHIFT 24
+#define MCDE_FCOLKEYA_FKEYA_MASK 0xFF000000
+#define MCDE_FCOLKEYA_FKEYA(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYA, FKEYA, __x)
+#define MCDE_FCOLKEYB 0x00000A0C
+#define MCDE_FCOLKEYB_FKEYB_SHIFT 0
+#define MCDE_FCOLKEYB_FKEYB_MASK 0x000000FF
+#define MCDE_FCOLKEYB_FKEYB(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYB, FKEYB, __x)
+#define MCDE_FCOLKEYB_FKEYG_SHIFT 8
+#define MCDE_FCOLKEYB_FKEYG_MASK 0x0000FF00
+#define MCDE_FCOLKEYB_FKEYG(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYB, FKEYG, __x)
+#define MCDE_FCOLKEYB_FKEYR_SHIFT 16
+#define MCDE_FCOLKEYB_FKEYR_MASK 0x00FF0000
+#define MCDE_FCOLKEYB_FKEYR(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYB, FKEYR, __x)
+#define MCDE_FCOLKEYB_FKEYA_SHIFT 24
+#define MCDE_FCOLKEYB_FKEYA_MASK 0xFF000000
+#define MCDE_FCOLKEYB_FKEYA(__x) \
+	MCDE_VAL2REG(MCDE_FCOLKEYB, FKEYA, __x)
+#define MCDE_RGBCONV1A 0x00000810
+#define MCDE_RGBCONV1A_GROUPOFFSET 0x200
+#define MCDE_RGBCONV1A_YR_GREEN_SHIFT 0
+#define MCDE_RGBCONV1A_YR_GREEN_MASK 0x000007FF
+#define MCDE_RGBCONV1A_YR_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV1A, YR_GREEN, __x)
+#define MCDE_RGBCONV1A_YR_RED_SHIFT 16
+#define MCDE_RGBCONV1A_YR_RED_MASK 0x07FF0000
+#define MCDE_RGBCONV1A_YR_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV1A, YR_RED, __x)
+#define MCDE_RGBCONV1B 0x00000A10
+#define MCDE_RGBCONV1B_YR_GREEN_SHIFT 0
+#define MCDE_RGBCONV1B_YR_GREEN_MASK 0x000007FF
+#define MCDE_RGBCONV1B_YR_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV1B, YR_GREEN, __x)
+#define MCDE_RGBCONV1B_YR_RED_SHIFT 16
+#define MCDE_RGBCONV1B_YR_RED_MASK 0x07FF0000
+#define MCDE_RGBCONV1B_YR_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV1B, YR_RED, __x)
+#define MCDE_RGBCONV2A 0x00000814
+#define MCDE_RGBCONV2A_GROUPOFFSET 0x200
+#define MCDE_RGBCONV2A_CR_RED_SHIFT 0
+#define MCDE_RGBCONV2A_CR_RED_MASK 0x000007FF
+#define MCDE_RGBCONV2A_CR_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV2A, CR_RED, __x)
+#define MCDE_RGBCONV2A_YR_BLUE_SHIFT 16
+#define MCDE_RGBCONV2A_YR_BLUE_MASK 0x07FF0000
+#define MCDE_RGBCONV2A_YR_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV2A, YR_BLUE, __x)
+#define MCDE_RGBCONV2B 0x00000A14
+#define MCDE_RGBCONV2B_CR_RED_SHIFT 0
+#define MCDE_RGBCONV2B_CR_RED_MASK 0x000007FF
+#define MCDE_RGBCONV2B_CR_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV2B, CR_RED, __x)
+#define MCDE_RGBCONV2B_YR_BLUE_SHIFT 16
+#define MCDE_RGBCONV2B_YR_BLUE_MASK 0x07FF0000
+#define MCDE_RGBCONV2B_YR_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV2B, YR_BLUE, __x)
+#define MCDE_RGBCONV3A 0x00000818
+#define MCDE_RGBCONV3A_GROUPOFFSET 0x200
+#define MCDE_RGBCONV3A_CR_BLUE_SHIFT 0
+#define MCDE_RGBCONV3A_CR_BLUE_MASK 0x000007FF
+#define MCDE_RGBCONV3A_CR_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV3A, CR_BLUE, __x)
+#define MCDE_RGBCONV3A_CR_GREEN_SHIFT 16
+#define MCDE_RGBCONV3A_CR_GREEN_MASK 0x07FF0000
+#define MCDE_RGBCONV3A_CR_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV3A, CR_GREEN, __x)
+#define MCDE_RGBCONV3B 0x00000A18
+#define MCDE_RGBCONV3B_CR_BLUE_SHIFT 0
+#define MCDE_RGBCONV3B_CR_BLUE_MASK 0x000007FF
+#define MCDE_RGBCONV3B_CR_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV3B, CR_BLUE, __x)
+#define MCDE_RGBCONV3B_CR_GREEN_SHIFT 16
+#define MCDE_RGBCONV3B_CR_GREEN_MASK 0x07FF0000
+#define MCDE_RGBCONV3B_CR_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV3B, CR_GREEN, __x)
+#define MCDE_RGBCONV4A 0x0000081C
+#define MCDE_RGBCONV4A_GROUPOFFSET 0x200
+#define MCDE_RGBCONV4A_CB_GREEN_SHIFT 0
+#define MCDE_RGBCONV4A_CB_GREEN_MASK 0x000007FF
+#define MCDE_RGBCONV4A_CB_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV4A, CB_GREEN, __x)
+#define MCDE_RGBCONV4A_CB_RED_SHIFT 16
+#define MCDE_RGBCONV4A_CB_RED_MASK 0x07FF0000
+#define MCDE_RGBCONV4A_CB_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV4A, CB_RED, __x)
+#define MCDE_RGBCONV4B 0x00000A1C
+#define MCDE_RGBCONV4B_CB_GREEN_SHIFT 0
+#define MCDE_RGBCONV4B_CB_GREEN_MASK 0x000007FF
+#define MCDE_RGBCONV4B_CB_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV4B, CB_GREEN, __x)
+#define MCDE_RGBCONV4B_CB_RED_SHIFT 16
+#define MCDE_RGBCONV4B_CB_RED_MASK 0x07FF0000
+#define MCDE_RGBCONV4B_CB_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV4B, CB_RED, __x)
+#define MCDE_RGBCONV5A 0x00000820
+#define MCDE_RGBCONV5A_GROUPOFFSET 0x200
+#define MCDE_RGBCONV5A_OFF_RED_SHIFT 0
+#define MCDE_RGBCONV5A_OFF_RED_MASK 0x000007FF
+#define MCDE_RGBCONV5A_OFF_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV5A, OFF_RED, __x)
+#define MCDE_RGBCONV5A_CB_BLUE_SHIFT 16
+#define MCDE_RGBCONV5A_CB_BLUE_MASK 0x07FF0000
+#define MCDE_RGBCONV5A_CB_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV5A, CB_BLUE, __x)
+#define MCDE_RGBCONV5B 0x00000A20
+#define MCDE_RGBCONV5B_OFF_RED_SHIFT 0
+#define MCDE_RGBCONV5B_OFF_RED_MASK 0x000007FF
+#define MCDE_RGBCONV5B_OFF_RED(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV5B, OFF_RED, __x)
+#define MCDE_RGBCONV5B_CB_BLUE_SHIFT 16
+#define MCDE_RGBCONV5B_CB_BLUE_MASK 0x07FF0000
+#define MCDE_RGBCONV5B_CB_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV5B, CB_BLUE, __x)
+#define MCDE_RGBCONV6A 0x00000824
+#define MCDE_RGBCONV6A_GROUPOFFSET 0x200
+#define MCDE_RGBCONV6A_OFF_BLUE_SHIFT 0
+#define MCDE_RGBCONV6A_OFF_BLUE_MASK 0x000007FF
+#define MCDE_RGBCONV6A_OFF_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV6A, OFF_BLUE, __x)
+#define MCDE_RGBCONV6A_OFF_GREEN_SHIFT 16
+#define MCDE_RGBCONV6A_OFF_GREEN_MASK 0x07FF0000
+#define MCDE_RGBCONV6A_OFF_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV6A, OFF_GREEN, __x)
+#define MCDE_RGBCONV6B 0x00000A24
+#define MCDE_RGBCONV6B_OFF_BLUE_SHIFT 0
+#define MCDE_RGBCONV6B_OFF_BLUE_MASK 0x000007FF
+#define MCDE_RGBCONV6B_OFF_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV6B, OFF_BLUE, __x)
+#define MCDE_RGBCONV6B_OFF_GREEN_SHIFT 16
+#define MCDE_RGBCONV6B_OFF_GREEN_MASK 0x07FF0000
+#define MCDE_RGBCONV6B_OFF_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_RGBCONV6B, OFF_GREEN, __x)
+#define MCDE_FFCOEF0 0x00000828
+#define MCDE_FFCOEF0_COEFF0_N1_SHIFT 0
+#define MCDE_FFCOEF0_COEFF0_N1_MASK 0x000000FF
+#define MCDE_FFCOEF0_COEFF0_N1(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF0, COEFF0_N1, __x)
+#define MCDE_FFCOEF0_COEFF0_N2_SHIFT 8
+#define MCDE_FFCOEF0_COEFF0_N2_MASK 0x0000FF00
+#define MCDE_FFCOEF0_COEFF0_N2(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF0, COEFF0_N2, __x)
+#define MCDE_FFCOEF0_COEFF0_N3_SHIFT 16
+#define MCDE_FFCOEF0_COEFF0_N3_MASK 0x00FF0000
+#define MCDE_FFCOEF0_COEFF0_N3(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF0, COEFF0_N3, __x)
+#define MCDE_FFCOEF0_T0_SHIFT 24
+#define MCDE_FFCOEF0_T0_MASK 0x0F000000
+#define MCDE_FFCOEF0_T0(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF0, T0, __x)
+#define MCDE_FFCOEF1 0x0000082C
+#define MCDE_FFCOEF1_COEFF1_N1_SHIFT 0
+#define MCDE_FFCOEF1_COEFF1_N1_MASK 0x000000FF
+#define MCDE_FFCOEF1_COEFF1_N1(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF1, COEFF1_N1, __x)
+#define MCDE_FFCOEF1_COEFF1_N2_SHIFT 8
+#define MCDE_FFCOEF1_COEFF1_N2_MASK 0x0000FF00
+#define MCDE_FFCOEF1_COEFF1_N2(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF1, COEFF1_N2, __x)
+#define MCDE_FFCOEF1_COEFF1_N3_SHIFT 16
+#define MCDE_FFCOEF1_COEFF1_N3_MASK 0x00FF0000
+#define MCDE_FFCOEF1_COEFF1_N3(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF1, COEFF1_N3, __x)
+#define MCDE_FFCOEF1_T1_SHIFT 24
+#define MCDE_FFCOEF1_T1_MASK 0x0F000000
+#define MCDE_FFCOEF1_T1(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF1, T1, __x)
+#define MCDE_FFCOEF2 0x00000830
+#define MCDE_FFCOEF2_COEFF2_N1_SHIFT 0
+#define MCDE_FFCOEF2_COEFF2_N1_MASK 0x000000FF
+#define MCDE_FFCOEF2_COEFF2_N1(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF2, COEFF2_N1, __x)
+#define MCDE_FFCOEF2_COEFF2_N2_SHIFT 8
+#define MCDE_FFCOEF2_COEFF2_N2_MASK 0x0000FF00
+#define MCDE_FFCOEF2_COEFF2_N2(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF2, COEFF2_N2, __x)
+#define MCDE_FFCOEF2_COEFF2_N3_SHIFT 16
+#define MCDE_FFCOEF2_COEFF2_N3_MASK 0x00FF0000
+#define MCDE_FFCOEF2_COEFF2_N3(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF2, COEFF2_N3, __x)
+#define MCDE_FFCOEF2_T2_SHIFT 24
+#define MCDE_FFCOEF2_T2_MASK 0x0F000000
+#define MCDE_FFCOEF2_T2(__x) \
+	MCDE_VAL2REG(MCDE_FFCOEF2, T2, __x)
+#define MCDE_MCDE_WDATAA_V2 0x00000834
+#define MCDE_MCDE_WDATAA_V2_GROUPOFFSET 0x200
+#define MCDE_MCDE_WDATAA_V2_DC_SHIFT 24
+#define MCDE_MCDE_WDATAA_V2_DC_MASK 0x01000000
+#define MCDE_MCDE_WDATAA_V2_DC(__x) \
+	MCDE_VAL2REG(MCDE_MCDE_WDATAA_V2, DC, __x)
+#define MCDE_MCDE_WDATAA_V2_DATAVALUE_SHIFT 0
+#define MCDE_MCDE_WDATAA_V2_DATAVALUE_MASK 0x00FFFFFF
+#define MCDE_MCDE_WDATAA_V2_DATAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_MCDE_WDATAA_V2, DATAVALUE, __x)
+#define MCDE_MCDE_WDATAB_V2 0x00000A34
+#define MCDE_MCDE_WDATAB_V2_DC_SHIFT 24
+#define MCDE_MCDE_WDATAB_V2_DC_MASK 0x01000000
+#define MCDE_MCDE_WDATAB_V2_DC(__x) \
+	MCDE_VAL2REG(MCDE_MCDE_WDATAB_V2, DC, __x)
+#define MCDE_MCDE_WDATAB_V2_DATAVALUE_SHIFT 0
+#define MCDE_MCDE_WDATAB_V2_DATAVALUE_MASK 0x00FFFFFF
+#define MCDE_MCDE_WDATAB_V2_DATAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_MCDE_WDATAB_V2, DATAVALUE, __x)
+#define MCDE_TVCRA 0x00000838
+#define MCDE_TVCRA_GROUPOFFSET 0x200
+#define MCDE_TVCRA_SEL_MOD_SHIFT 0
+#define MCDE_TVCRA_SEL_MOD_MASK 0x00000001
+#define MCDE_TVCRA_SEL_MOD_LCD 0
+#define MCDE_TVCRA_SEL_MOD_TV 1
+#define MCDE_TVCRA_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, SEL_MOD, MCDE_TVCRA_SEL_MOD_##__x)
+#define MCDE_TVCRA_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, SEL_MOD, __x)
+#define MCDE_TVCRA_INTEREN_SHIFT 1
+#define MCDE_TVCRA_INTEREN_MASK 0x00000002
+#define MCDE_TVCRA_INTEREN(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, INTEREN, __x)
+#define MCDE_TVCRA_IFIELD_SHIFT 2
+#define MCDE_TVCRA_IFIELD_MASK 0x00000004
+#define MCDE_TVCRA_IFIELD(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, IFIELD, __x)
+#define MCDE_TVCRA_TVMODE_SHIFT 3
+#define MCDE_TVCRA_TVMODE_MASK 0x00000038
+#define MCDE_TVCRA_TVMODE_SDTV_656P 0
+#define MCDE_TVCRA_TVMODE_HDTV_480P 1
+#define MCDE_TVCRA_TVMODE_HDTV_720P 2
+#define MCDE_TVCRA_TVMODE_SDTV_656P_LE 3
+#define MCDE_TVCRA_TVMODE_SDTV_656P_BE 4
+#define MCDE_TVCRA_TVMODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, TVMODE, MCDE_TVCRA_TVMODE_##__x)
+#define MCDE_TVCRA_TVMODE(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, TVMODE, __x)
+#define MCDE_TVCRA_SDTVMODE_SHIFT 6
+#define MCDE_TVCRA_SDTVMODE_MASK 0x000000C0
+#define MCDE_TVCRA_SDTVMODE_Y0CBY1CR 0
+#define MCDE_TVCRA_SDTVMODE_CBY0CRY1 1
+#define MCDE_TVCRA_SDTVMODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, SDTVMODE, MCDE_TVCRA_SDTVMODE_##__x)
+#define MCDE_TVCRA_SDTVMODE(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, SDTVMODE, __x)
+#define MCDE_TVCRA_AVRGEN_SHIFT 8
+#define MCDE_TVCRA_AVRGEN_MASK 0x00000100
+#define MCDE_TVCRA_AVRGEN(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, AVRGEN, __x)
+#define MCDE_TVCRA_CKINV_SHIFT 9
+#define MCDE_TVCRA_CKINV_MASK 0x00000200
+#define MCDE_TVCRA_CKINV(__x) \
+	MCDE_VAL2REG(MCDE_TVCRA, CKINV, __x)
+#define MCDE_TVCRB 0x00000A38
+#define MCDE_TVCRB_SEL_MOD_SHIFT 0
+#define MCDE_TVCRB_SEL_MOD_MASK 0x00000001
+#define MCDE_TVCRB_SEL_MOD_LCD 0
+#define MCDE_TVCRB_SEL_MOD_TV 1
+#define MCDE_TVCRB_SEL_MOD_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, SEL_MOD, MCDE_TVCRB_SEL_MOD_##__x)
+#define MCDE_TVCRB_SEL_MOD(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, SEL_MOD, __x)
+#define MCDE_TVCRB_INTEREN_SHIFT 1
+#define MCDE_TVCRB_INTEREN_MASK 0x00000002
+#define MCDE_TVCRB_INTEREN(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, INTEREN, __x)
+#define MCDE_TVCRB_IFIELD_SHIFT 2
+#define MCDE_TVCRB_IFIELD_MASK 0x00000004
+#define MCDE_TVCRB_IFIELD(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, IFIELD, __x)
+#define MCDE_TVCRB_TVMODE_SHIFT 3
+#define MCDE_TVCRB_TVMODE_MASK 0x00000038
+#define MCDE_TVCRB_TVMODE_SDTV_656P 0
+#define MCDE_TVCRB_TVMODE_HDTV_480P 1
+#define MCDE_TVCRB_TVMODE_HDTV_720P 2
+#define MCDE_TVCRB_TVMODE_SDTV_656P_LE 3
+#define MCDE_TVCRB_TVMODE_SDTV_656P_BE 4
+#define MCDE_TVCRB_TVMODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, TVMODE, MCDE_TVCRB_TVMODE_##__x)
+#define MCDE_TVCRB_TVMODE(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, TVMODE, __x)
+#define MCDE_TVCRB_SDTVMODE_SHIFT 6
+#define MCDE_TVCRB_SDTVMODE_MASK 0x000000C0
+#define MCDE_TVCRB_SDTVMODE_Y0CBY1CR 0
+#define MCDE_TVCRB_SDTVMODE_CBY0CRY1 1
+#define MCDE_TVCRB_SDTVMODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, SDTVMODE, MCDE_TVCRB_SDTVMODE_##__x)
+#define MCDE_TVCRB_SDTVMODE(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, SDTVMODE, __x)
+#define MCDE_TVCRB_AVRGEN_SHIFT 8
+#define MCDE_TVCRB_AVRGEN_MASK 0x00000100
+#define MCDE_TVCRB_AVRGEN(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, AVRGEN, __x)
+#define MCDE_TVCRB_CKINV_SHIFT 9
+#define MCDE_TVCRB_CKINV_MASK 0x00000200
+#define MCDE_TVCRB_CKINV(__x) \
+	MCDE_VAL2REG(MCDE_TVCRB, CKINV, __x)
+#define MCDE_TVBL1A 0x0000083C
+#define MCDE_TVBL1A_GROUPOFFSET 0x200
+#define MCDE_TVBL1A_BEL1_SHIFT 0
+#define MCDE_TVBL1A_BEL1_MASK 0x000007FF
+#define MCDE_TVBL1A_BEL1(__x) \
+	MCDE_VAL2REG(MCDE_TVBL1A, BEL1, __x)
+#define MCDE_TVBL1A_BSL1_SHIFT 16
+#define MCDE_TVBL1A_BSL1_MASK 0x07FF0000
+#define MCDE_TVBL1A_BSL1(__x) \
+	MCDE_VAL2REG(MCDE_TVBL1A, BSL1, __x)
+#define MCDE_TVBL1B 0x00000A3C
+#define MCDE_TVBL1B_BEL1_SHIFT 0
+#define MCDE_TVBL1B_BEL1_MASK 0x000007FF
+#define MCDE_TVBL1B_BEL1(__x) \
+	MCDE_VAL2REG(MCDE_TVBL1B, BEL1, __x)
+#define MCDE_TVBL1B_BSL1_SHIFT 16
+#define MCDE_TVBL1B_BSL1_MASK 0x07FF0000
+#define MCDE_TVBL1B_BSL1(__x) \
+	MCDE_VAL2REG(MCDE_TVBL1B, BSL1, __x)
+#define MCDE_TVISLA 0x00000840
+#define MCDE_TVISLA_GROUPOFFSET 0x200
+#define MCDE_TVISLA_FSL1_SHIFT 0
+#define MCDE_TVISLA_FSL1_MASK 0x000007FF
+#define MCDE_TVISLA_FSL1(__x) \
+	MCDE_VAL2REG(MCDE_TVISLA, FSL1, __x)
+#define MCDE_TVISLA_FSL2_SHIFT 16
+#define MCDE_TVISLA_FSL2_MASK 0x07FF0000
+#define MCDE_TVISLA_FSL2(__x) \
+	MCDE_VAL2REG(MCDE_TVISLA, FSL2, __x)
+#define MCDE_TVISLB 0x00000A40
+#define MCDE_TVISLB_FSL1_SHIFT 0
+#define MCDE_TVISLB_FSL1_MASK 0x000007FF
+#define MCDE_TVISLB_FSL1(__x) \
+	MCDE_VAL2REG(MCDE_TVISLB, FSL1, __x)
+#define MCDE_TVISLB_FSL2_SHIFT 16
+#define MCDE_TVISLB_FSL2_MASK 0x07FF0000
+#define MCDE_TVISLB_FSL2(__x) \
+	MCDE_VAL2REG(MCDE_TVISLB, FSL2, __x)
+#define MCDE_TVDVOA 0x00000844
+#define MCDE_TVDVOA_GROUPOFFSET 0x200
+#define MCDE_TVDVOA_DVO1_SHIFT 0
+#define MCDE_TVDVOA_DVO1_MASK 0x000007FF
+#define MCDE_TVDVOA_DVO1(__x) \
+	MCDE_VAL2REG(MCDE_TVDVOA, DVO1, __x)
+#define MCDE_TVDVOA_DVO2_SHIFT 16
+#define MCDE_TVDVOA_DVO2_MASK 0x07FF0000
+#define MCDE_TVDVOA_DVO2(__x) \
+	MCDE_VAL2REG(MCDE_TVDVOA, DVO2, __x)
+#define MCDE_TVDVOB 0x00000A44
+#define MCDE_TVDVOB_DVO1_SHIFT 0
+#define MCDE_TVDVOB_DVO1_MASK 0x000007FF
+#define MCDE_TVDVOB_DVO1(__x) \
+	MCDE_VAL2REG(MCDE_TVDVOB, DVO1, __x)
+#define MCDE_TVDVOB_DVO2_SHIFT 16
+#define MCDE_TVDVOB_DVO2_MASK 0x07FF0000
+#define MCDE_TVDVOB_DVO2(__x) \
+	MCDE_VAL2REG(MCDE_TVDVOB, DVO2, __x)
+#define MCDE_TVTIM1A 0x0000084C
+#define MCDE_TVTIM1A_GROUPOFFSET 0x200
+#define MCDE_TVTIM1A_DHO_SHIFT 0
+#define MCDE_TVTIM1A_DHO_MASK 0x000007FF
+#define MCDE_TVTIM1A_DHO(__x) \
+	MCDE_VAL2REG(MCDE_TVTIM1A, DHO, __x)
+#define MCDE_TVTIM1B 0x00000A4C
+#define MCDE_TVTIM1B_DHO_SHIFT 0
+#define MCDE_TVTIM1B_DHO_MASK 0x000007FF
+#define MCDE_TVTIM1B_DHO(__x) \
+	MCDE_VAL2REG(MCDE_TVTIM1B, DHO, __x)
+#define MCDE_TVLBALWA 0x00000850
+#define MCDE_TVLBALWA_GROUPOFFSET 0x200
+#define MCDE_TVLBALWA_ALW_SHIFT 0
+#define MCDE_TVLBALWA_ALW_MASK 0x000007FF
+#define MCDE_TVLBALWA_ALW(__x) \
+	MCDE_VAL2REG(MCDE_TVLBALWA, ALW, __x)
+#define MCDE_TVLBALWA_LBW_SHIFT 16
+#define MCDE_TVLBALWA_LBW_MASK 0x07FF0000
+#define MCDE_TVLBALWA_LBW(__x) \
+	MCDE_VAL2REG(MCDE_TVLBALWA, LBW, __x)
+#define MCDE_TVLBALWB 0x00000A50
+#define MCDE_TVLBALWB_ALW_SHIFT 0
+#define MCDE_TVLBALWB_ALW_MASK 0x000007FF
+#define MCDE_TVLBALWB_ALW(__x) \
+	MCDE_VAL2REG(MCDE_TVLBALWB, ALW, __x)
+#define MCDE_TVLBALWB_LBW_SHIFT 16
+#define MCDE_TVLBALWB_LBW_MASK 0x07FF0000
+#define MCDE_TVLBALWB_LBW(__x) \
+	MCDE_VAL2REG(MCDE_TVLBALWB, LBW, __x)
+#define MCDE_TVBL2A 0x00000854
+#define MCDE_TVBL2A_GROUPOFFSET 0x200
+#define MCDE_TVBL2A_BEL2_SHIFT 0
+#define MCDE_TVBL2A_BEL2_MASK 0x000007FF
+#define MCDE_TVBL2A_BEL2(__x) \
+	MCDE_VAL2REG(MCDE_TVBL2A, BEL2, __x)
+#define MCDE_TVBL2A_BSL2_SHIFT 16
+#define MCDE_TVBL2A_BSL2_MASK 0x07FF0000
+#define MCDE_TVBL2A_BSL2(__x) \
+	MCDE_VAL2REG(MCDE_TVBL2A, BSL2, __x)
+#define MCDE_TVBL2B 0x00000A54
+#define MCDE_TVBL2B_BEL2_SHIFT 0
+#define MCDE_TVBL2B_BEL2_MASK 0x000007FF
+#define MCDE_TVBL2B_BEL2(__x) \
+	MCDE_VAL2REG(MCDE_TVBL2B, BEL2, __x)
+#define MCDE_TVBL2B_BSL2_SHIFT 16
+#define MCDE_TVBL2B_BSL2_MASK 0x07FF0000
+#define MCDE_TVBL2B_BSL2(__x) \
+	MCDE_VAL2REG(MCDE_TVBL2B, BSL2, __x)
+#define MCDE_TVBLUA 0x00000858
+#define MCDE_TVBLUA_GROUPOFFSET 0x200
+#define MCDE_TVBLUA_TVBLU_SHIFT 0
+#define MCDE_TVBLUA_TVBLU_MASK 0x000000FF
+#define MCDE_TVBLUA_TVBLU(__x) \
+	MCDE_VAL2REG(MCDE_TVBLUA, TVBLU, __x)
+#define MCDE_TVBLUA_TVBCB_SHIFT 8
+#define MCDE_TVBLUA_TVBCB_MASK 0x0000FF00
+#define MCDE_TVBLUA_TVBCB(__x) \
+	MCDE_VAL2REG(MCDE_TVBLUA, TVBCB, __x)
+#define MCDE_TVBLUA_TVBCR_SHIFT 16
+#define MCDE_TVBLUA_TVBCR_MASK 0x00FF0000
+#define MCDE_TVBLUA_TVBCR(__x) \
+	MCDE_VAL2REG(MCDE_TVBLUA, TVBCR, __x)
+#define MCDE_TVBLUB 0x00000A58
+#define MCDE_TVBLUB_TVBLU_SHIFT 0
+#define MCDE_TVBLUB_TVBLU_MASK 0x000000FF
+#define MCDE_TVBLUB_TVBLU(__x) \
+	MCDE_VAL2REG(MCDE_TVBLUB, TVBLU, __x)
+#define MCDE_TVBLUB_TVBCB_SHIFT 8
+#define MCDE_TVBLUB_TVBCB_MASK 0x0000FF00
+#define MCDE_TVBLUB_TVBCB(__x) \
+	MCDE_VAL2REG(MCDE_TVBLUB, TVBCB, __x)
+#define MCDE_TVBLUB_TVBCR_SHIFT 16
+#define MCDE_TVBLUB_TVBCR_MASK 0x00FF0000
+#define MCDE_TVBLUB_TVBCR(__x) \
+	MCDE_VAL2REG(MCDE_TVBLUB, TVBCR, __x)
+#define MCDE_LCDTIM1A 0x00000860
+#define MCDE_LCDTIM1A_GROUPOFFSET 0x200
+#define MCDE_LCDTIM1A_IVP_SHIFT 19
+#define MCDE_LCDTIM1A_IVP_MASK 0x00080000
+#define MCDE_LCDTIM1A_IVP(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1A, IVP, __x)
+#define MCDE_LCDTIM1A_IVS_SHIFT 20
+#define MCDE_LCDTIM1A_IVS_MASK 0x00100000
+#define MCDE_LCDTIM1A_IVS(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1A, IVS, __x)
+#define MCDE_LCDTIM1A_IHS_SHIFT 21
+#define MCDE_LCDTIM1A_IHS_MASK 0x00200000
+#define MCDE_LCDTIM1A_IHS(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1A, IHS, __x)
+#define MCDE_LCDTIM1A_IPC_SHIFT 22
+#define MCDE_LCDTIM1A_IPC_MASK 0x00400000
+#define MCDE_LCDTIM1A_IPC(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1A, IPC, __x)
+#define MCDE_LCDTIM1A_IOE_SHIFT 23
+#define MCDE_LCDTIM1A_IOE_MASK 0x00800000
+#define MCDE_LCDTIM1A_IOE(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1A, IOE, __x)
+#define MCDE_LCDTIM1B 0x00000A60
+#define MCDE_LCDTIM1B_IVP_SHIFT 19
+#define MCDE_LCDTIM1B_IVP_MASK 0x00080000
+#define MCDE_LCDTIM1B_IVP(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1B, IVP, __x)
+#define MCDE_LCDTIM1B_IVS_SHIFT 20
+#define MCDE_LCDTIM1B_IVS_MASK 0x00100000
+#define MCDE_LCDTIM1B_IVS(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1B, IVS, __x)
+#define MCDE_LCDTIM1B_IHS_SHIFT 21
+#define MCDE_LCDTIM1B_IHS_MASK 0x00200000
+#define MCDE_LCDTIM1B_IHS(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1B, IHS, __x)
+#define MCDE_LCDTIM1B_IPC_SHIFT 22
+#define MCDE_LCDTIM1B_IPC_MASK 0x00400000
+#define MCDE_LCDTIM1B_IPC(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1B, IPC, __x)
+#define MCDE_LCDTIM1B_IOE_SHIFT 23
+#define MCDE_LCDTIM1B_IOE_MASK 0x00800000
+#define MCDE_LCDTIM1B_IOE(__x) \
+	MCDE_VAL2REG(MCDE_LCDTIM1B, IOE, __x)
+#define MCDE_DITCTRLA 0x00000864
+#define MCDE_DITCTRLA_GROUPOFFSET 0x200
+#define MCDE_DITCTRLA_TEMP_SHIFT 0
+#define MCDE_DITCTRLA_TEMP_MASK 0x00000001
+#define MCDE_DITCTRLA_TEMP(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLA, TEMP, __x)
+#define MCDE_DITCTRLA_COMP_SHIFT 1
+#define MCDE_DITCTRLA_COMP_MASK 0x00000002
+#define MCDE_DITCTRLA_COMP(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLA, COMP, __x)
+#define MCDE_DITCTRLA_MASK_SHIFT 4
+#define MCDE_DITCTRLA_MASK_MASK 0x00000010
+#define MCDE_DITCTRLA_MASK(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLA, MASK, __x)
+#define MCDE_DITCTRLA_FOFFX_SHIFT 5
+#define MCDE_DITCTRLA_FOFFX_MASK 0x000003E0
+#define MCDE_DITCTRLA_FOFFX(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLA, FOFFX, __x)
+#define MCDE_DITCTRLA_FOFFY_SHIFT 10
+#define MCDE_DITCTRLA_FOFFY_MASK 0x00007C00
+#define MCDE_DITCTRLA_FOFFY(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLA, FOFFY, __x)
+#define MCDE_DITCTRLB 0x00000A64
+#define MCDE_DITCTRLB_TEMP_SHIFT 0
+#define MCDE_DITCTRLB_TEMP_MASK 0x00000001
+#define MCDE_DITCTRLB_TEMP(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLB, TEMP, __x)
+#define MCDE_DITCTRLB_COMP_SHIFT 1
+#define MCDE_DITCTRLB_COMP_MASK 0x00000002
+#define MCDE_DITCTRLB_COMP(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLB, COMP, __x)
+#define MCDE_DITCTRLB_MASK_SHIFT 4
+#define MCDE_DITCTRLB_MASK_MASK 0x00000010
+#define MCDE_DITCTRLB_MASK(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLB, MASK, __x)
+#define MCDE_DITCTRLB_FOFFX_SHIFT 5
+#define MCDE_DITCTRLB_FOFFX_MASK 0x000003E0
+#define MCDE_DITCTRLB_FOFFX(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLB, FOFFX, __x)
+#define MCDE_DITCTRLB_FOFFY_SHIFT 10
+#define MCDE_DITCTRLB_FOFFY_MASK 0x00007C00
+#define MCDE_DITCTRLB_FOFFY(__x) \
+	MCDE_VAL2REG(MCDE_DITCTRLB, FOFFY, __x)
+#define MCDE_DITOFFA 0x00000868
+#define MCDE_DITOFFA_GROUPOFFSET 0x200
+#define MCDE_DITOFFA_XG_SHIFT 0
+#define MCDE_DITOFFA_XG_MASK 0x0000001F
+#define MCDE_DITOFFA_XG(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFA, XG, __x)
+#define MCDE_DITOFFA_YG_SHIFT 8
+#define MCDE_DITOFFA_YG_MASK 0x00001F00
+#define MCDE_DITOFFA_YG(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFA, YG, __x)
+#define MCDE_DITOFFA_XB_SHIFT 16
+#define MCDE_DITOFFA_XB_MASK 0x001F0000
+#define MCDE_DITOFFA_XB(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFA, XB, __x)
+#define MCDE_DITOFFA_YB_SHIFT 24
+#define MCDE_DITOFFA_YB_MASK 0x1F000000
+#define MCDE_DITOFFA_YB(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFA, YB, __x)
+#define MCDE_DITOFFB 0x00000A68
+#define MCDE_DITOFFB_XG_SHIFT 0
+#define MCDE_DITOFFB_XG_MASK 0x0000001F
+#define MCDE_DITOFFB_XG(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFB, XG, __x)
+#define MCDE_DITOFFB_YG_SHIFT 8
+#define MCDE_DITOFFB_YG_MASK 0x00001F00
+#define MCDE_DITOFFB_YG(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFB, YG, __x)
+#define MCDE_DITOFFB_XB_SHIFT 16
+#define MCDE_DITOFFB_XB_MASK 0x001F0000
+#define MCDE_DITOFFB_XB(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFB, XB, __x)
+#define MCDE_DITOFFB_YB_SHIFT 24
+#define MCDE_DITOFFB_YB_MASK 0x1F000000
+#define MCDE_DITOFFB_YB(__x) \
+	MCDE_VAL2REG(MCDE_DITOFFB, YB, __x)
+#define MCDE_PAL0A 0x0000086C
+#define MCDE_PAL0A_GROUPOFFSET 0x200
+#define MCDE_PAL0A_BLUE_SHIFT 0
+#define MCDE_PAL0A_BLUE_MASK 0x00000FFF
+#define MCDE_PAL0A_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_PAL0A, BLUE, __x)
+#define MCDE_PAL0A_GREEN_SHIFT 16
+#define MCDE_PAL0A_GREEN_MASK 0x0FFF0000
+#define MCDE_PAL0A_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_PAL0A, GREEN, __x)
+#define MCDE_PAL0B 0x00000A6C
+#define MCDE_PAL0B_BLUE_SHIFT 0
+#define MCDE_PAL0B_BLUE_MASK 0x00000FFF
+#define MCDE_PAL0B_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_PAL0B, BLUE, __x)
+#define MCDE_PAL0B_GREEN_SHIFT 16
+#define MCDE_PAL0B_GREEN_MASK 0x0FFF0000
+#define MCDE_PAL0B_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_PAL0B, GREEN, __x)
+#define MCDE_PAL1A 0x00000870
+#define MCDE_PAL1A_GROUPOFFSET 0x200
+#define MCDE_PAL1A_RED_SHIFT 0
+#define MCDE_PAL1A_RED_MASK 0x00000FFF
+#define MCDE_PAL1A_RED(__x) \
+	MCDE_VAL2REG(MCDE_PAL1A, RED, __x)
+#define MCDE_PAL1B 0x00000A70
+#define MCDE_PAL1B_RED_SHIFT 0
+#define MCDE_PAL1B_RED_MASK 0x00000FFF
+#define MCDE_PAL1B_RED(__x) \
+	MCDE_VAL2REG(MCDE_PAL1B, RED, __x)
+#define MCDE_ROTADD0A 0x00000874
+#define MCDE_ROTADD0A_GROUPOFFSET 0x200
+#define MCDE_ROTADD0A_ROTADD0_SHIFT 3
+#define MCDE_ROTADD0A_ROTADD0_MASK 0xFFFFFFF8
+#define MCDE_ROTADD0A_ROTADD0(__x) \
+	MCDE_VAL2REG(MCDE_ROTADD0A, ROTADD0, __x)
+#define MCDE_ROTADD0B 0x00000A74
+#define MCDE_ROTADD0B_ROTADD0_SHIFT 3
+#define MCDE_ROTADD0B_ROTADD0_MASK 0xFFFFFFF8
+#define MCDE_ROTADD0B_ROTADD0(__x) \
+	MCDE_VAL2REG(MCDE_ROTADD0B, ROTADD0, __x)
+#define MCDE_ROTADD1A 0x00000878
+#define MCDE_ROTADD1A_GROUPOFFSET 0x200
+#define MCDE_ROTADD1A_ROTADD1_SHIFT 3
+#define MCDE_ROTADD1A_ROTADD1_MASK 0xFFFFFFF8
+#define MCDE_ROTADD1A_ROTADD1(__x) \
+	MCDE_VAL2REG(MCDE_ROTADD1A, ROTADD1, __x)
+#define MCDE_ROTADD1B 0x00000A78
+#define MCDE_ROTADD1B_ROTADD1_SHIFT 3
+#define MCDE_ROTADD1B_ROTADD1_MASK 0xFFFFFFF8
+#define MCDE_ROTADD1B_ROTADD1(__x) \
+	MCDE_VAL2REG(MCDE_ROTADD1B, ROTADD1, __x)
+#define MCDE_ROTACONF 0x0000087C
+#define MCDE_ROTACONF_GROUPOFFSET 0x200
+#define MCDE_ROTACONF_ROTBURSTSIZE_SHIFT 0
+#define MCDE_ROTACONF_ROTBURSTSIZE_MASK 0x00000003
+#define MCDE_ROTACONF_ROTBURSTSIZE_1W 0
+#define MCDE_ROTACONF_ROTBURSTSIZE_2W 1
+#define MCDE_ROTACONF_ROTBURSTSIZE_4W 2
+#define MCDE_ROTACONF_ROTBURSTSIZE_8W 3
+#define MCDE_ROTACONF_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, ROTBURSTSIZE, \
+	MCDE_ROTACONF_ROTBURSTSIZE_##__x)
+#define MCDE_ROTACONF_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, ROTBURSTSIZE, __x)
+#define MCDE_ROTACONF_ROTBURSTSIZE_HW_SHIFT 2
+#define MCDE_ROTACONF_ROTBURSTSIZE_HW_MASK 0x00000004
+#define MCDE_ROTACONF_ROTBURSTSIZE_HW(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, ROTBURSTSIZE_HW, __x)
+#define MCDE_ROTACONF_ROTDIR_SHIFT 3
+#define MCDE_ROTACONF_ROTDIR_MASK 0x00000008
+#define MCDE_ROTACONF_ROTDIR_CCW 0
+#define MCDE_ROTACONF_ROTDIR_CW 1
+#define MCDE_ROTACONF_ROTDIR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, ROTDIR, MCDE_ROTACONF_ROTDIR_##__x)
+#define MCDE_ROTACONF_ROTDIR(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, ROTDIR, __x)
+#define MCDE_ROTACONF_WR_MAXOUT_SHIFT 4
+#define MCDE_ROTACONF_WR_MAXOUT_MASK 0x00000030
+#define MCDE_ROTACONF_WR_MAXOUT_1_REQ 0
+#define MCDE_ROTACONF_WR_MAXOUT_2_REQ 1
+#define MCDE_ROTACONF_WR_MAXOUT_4_REQ 2
+#define MCDE_ROTACONF_WR_MAXOUT_8_REQ 3
+#define MCDE_ROTACONF_WR_MAXOUT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, WR_MAXOUT, MCDE_ROTACONF_WR_MAXOUT_##__x)
+#define MCDE_ROTACONF_WR_MAXOUT(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, WR_MAXOUT, __x)
+#define MCDE_ROTACONF_RD_MAXOUT_SHIFT 6
+#define MCDE_ROTACONF_RD_MAXOUT_MASK 0x000000C0
+#define MCDE_ROTACONF_RD_MAXOUT_1_REQ 0
+#define MCDE_ROTACONF_RD_MAXOUT_2_REQ 1
+#define MCDE_ROTACONF_RD_MAXOUT_4_REQ 2
+#define MCDE_ROTACONF_RD_MAXOUT_8_REQ 3
+#define MCDE_ROTACONF_RD_MAXOUT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, RD_MAXOUT, MCDE_ROTACONF_RD_MAXOUT_##__x)
+#define MCDE_ROTACONF_RD_MAXOUT(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, RD_MAXOUT, __x)
+#define MCDE_ROTACONF_STRIP_WIDTH_SHIFT 8
+#define MCDE_ROTACONF_STRIP_WIDTH_MASK 0x00007F00
+#define MCDE_ROTACONF_STRIP_WIDTH_2PIX 0
+#define MCDE_ROTACONF_STRIP_WIDTH_4PIX 1
+#define MCDE_ROTACONF_STRIP_WIDTH_8PIX 2
+#define MCDE_ROTACONF_STRIP_WIDTH_16PIX 3
+#define MCDE_ROTACONF_STRIP_WIDTH_32PIX 4
+#define MCDE_ROTACONF_STRIP_WIDTH_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, STRIP_WIDTH, \
+	MCDE_ROTACONF_STRIP_WIDTH_##__x)
+#define MCDE_ROTACONF_STRIP_WIDTH(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, STRIP_WIDTH, __x)
+#define MCDE_ROTACONF_SINGLE_BUF_SHIFT 15
+#define MCDE_ROTACONF_SINGLE_BUF_MASK 0x00008000
+#define MCDE_ROTACONF_SINGLE_BUF(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, SINGLE_BUF, __x)
+#define MCDE_ROTACONF_WR_ROPC_SHIFT 16
+#define MCDE_ROTACONF_WR_ROPC_MASK 0x00FF0000
+#define MCDE_ROTACONF_WR_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, WR_ROPC, __x)
+#define MCDE_ROTACONF_RD_ROPC_SHIFT 24
+#define MCDE_ROTACONF_RD_ROPC_MASK 0xFF000000
+#define MCDE_ROTACONF_RD_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_ROTACONF, RD_ROPC, __x)
+#define MCDE_ROTBCONF 0x00000A7C
+#define MCDE_ROTBCONF_ROTBURSTSIZE_SHIFT 0
+#define MCDE_ROTBCONF_ROTBURSTSIZE_MASK 0x00000003
+#define MCDE_ROTBCONF_ROTBURSTSIZE_1W 0
+#define MCDE_ROTBCONF_ROTBURSTSIZE_2W 1
+#define MCDE_ROTBCONF_ROTBURSTSIZE_4W 2
+#define MCDE_ROTBCONF_ROTBURSTSIZE_8W 3
+#define MCDE_ROTBCONF_ROTBURSTSIZE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, ROTBURSTSIZE, \
+	MCDE_ROTBCONF_ROTBURSTSIZE_##__x)
+#define MCDE_ROTBCONF_ROTBURSTSIZE(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, ROTBURSTSIZE, __x)
+#define MCDE_ROTBCONF_ROTBURSTSIZE_HW_SHIFT 2
+#define MCDE_ROTBCONF_ROTBURSTSIZE_HW_MASK 0x00000004
+#define MCDE_ROTBCONF_ROTBURSTSIZE_HW(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, ROTBURSTSIZE_HW, __x)
+#define MCDE_ROTBCONF_ROTDIR_SHIFT 3
+#define MCDE_ROTBCONF_ROTDIR_MASK 0x00000008
+#define MCDE_ROTBCONF_ROTDIR_CCW 0
+#define MCDE_ROTBCONF_ROTDIR_CW 1
+#define MCDE_ROTBCONF_ROTDIR_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, ROTDIR, MCDE_ROTBCONF_ROTDIR_##__x)
+#define MCDE_ROTBCONF_ROTDIR(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, ROTDIR, __x)
+#define MCDE_ROTBCONF_WR_MAXOUT_SHIFT 4
+#define MCDE_ROTBCONF_WR_MAXOUT_MASK 0x00000030
+#define MCDE_ROTBCONF_WR_MAXOUT_1_REQ 0
+#define MCDE_ROTBCONF_WR_MAXOUT_2_REQ 1
+#define MCDE_ROTBCONF_WR_MAXOUT_4_REQ 2
+#define MCDE_ROTBCONF_WR_MAXOUT_8_REQ 3
+#define MCDE_ROTBCONF_WR_MAXOUT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, WR_MAXOUT, MCDE_ROTBCONF_WR_MAXOUT_##__x)
+#define MCDE_ROTBCONF_WR_MAXOUT(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, WR_MAXOUT, __x)
+#define MCDE_ROTBCONF_RD_MAXOUT_SHIFT 6
+#define MCDE_ROTBCONF_RD_MAXOUT_MASK 0x000000C0
+#define MCDE_ROTBCONF_RD_MAXOUT_1_REQ 0
+#define MCDE_ROTBCONF_RD_MAXOUT_2_REQ 1
+#define MCDE_ROTBCONF_RD_MAXOUT_4_REQ 2
+#define MCDE_ROTBCONF_RD_MAXOUT_8_REQ 3
+#define MCDE_ROTBCONF_RD_MAXOUT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, RD_MAXOUT, MCDE_ROTBCONF_RD_MAXOUT_##__x)
+#define MCDE_ROTBCONF_RD_MAXOUT(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, RD_MAXOUT, __x)
+#define MCDE_ROTBCONF_STRIP_WIDTH_SHIFT 8
+#define MCDE_ROTBCONF_STRIP_WIDTH_MASK 0x00007F00
+#define MCDE_ROTBCONF_STRIP_WIDTH_2PIX 0
+#define MCDE_ROTBCONF_STRIP_WIDTH_4PIX 1
+#define MCDE_ROTBCONF_STRIP_WIDTH_8PIX 2
+#define MCDE_ROTBCONF_STRIP_WIDTH_16PIX 3
+#define MCDE_ROTBCONF_STRIP_WIDTH_32PIX 4
+#define MCDE_ROTBCONF_STRIP_WIDTH_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, STRIP_WIDTH, \
+	MCDE_ROTBCONF_STRIP_WIDTH_##__x)
+#define MCDE_ROTBCONF_STRIP_WIDTH(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, STRIP_WIDTH, __x)
+#define MCDE_ROTBCONF_SINGLE_BUF_SHIFT 15
+#define MCDE_ROTBCONF_SINGLE_BUF_MASK 0x00008000
+#define MCDE_ROTBCONF_SINGLE_BUF(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, SINGLE_BUF, __x)
+#define MCDE_ROTBCONF_WR_ROPC_SHIFT 16
+#define MCDE_ROTBCONF_WR_ROPC_MASK 0x00FF0000
+#define MCDE_ROTBCONF_WR_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, WR_ROPC, __x)
+#define MCDE_ROTBCONF_RD_ROPC_SHIFT 24
+#define MCDE_ROTBCONF_RD_ROPC_MASK 0xFF000000
+#define MCDE_ROTBCONF_RD_ROPC(__x) \
+	MCDE_VAL2REG(MCDE_ROTBCONF, RD_ROPC, __x)
+#define MCDE_SYNCHCONFA 0x00000880
+#define MCDE_SYNCHCONFA_GROUPOFFSET 0x200
+#define MCDE_SYNCHCONFA_HWREQVEVENT_SHIFT 0
+#define MCDE_SYNCHCONFA_HWREQVEVENT_MASK 0x00000003
+#define MCDE_SYNCHCONFA_HWREQVEVENT_VSYNC 0
+#define MCDE_SYNCHCONFA_HWREQVEVENT_BACK_PORCH 1
+#define MCDE_SYNCHCONFA_HWREQVEVENT_ACTIVE_VIDEO 2
+#define MCDE_SYNCHCONFA_HWREQVEVENT_FRONT_PORCH 3
+#define MCDE_SYNCHCONFA_HWREQVEVENT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFA, HWREQVEVENT, \
+	MCDE_SYNCHCONFA_HWREQVEVENT_##__x)
+#define MCDE_SYNCHCONFA_HWREQVEVENT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFA, HWREQVEVENT, __x)
+#define MCDE_SYNCHCONFA_HWREQVCNT_SHIFT 2
+#define MCDE_SYNCHCONFA_HWREQVCNT_MASK 0x0000FFFC
+#define MCDE_SYNCHCONFA_HWREQVCNT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFA, HWREQVCNT, __x)
+#define MCDE_SYNCHCONFA_SWINTVEVENT_SHIFT 16
+#define MCDE_SYNCHCONFA_SWINTVEVENT_MASK 0x00030000
+#define MCDE_SYNCHCONFA_SWINTVEVENT_VSYNC 0
+#define MCDE_SYNCHCONFA_SWINTVEVENT_BACK_PORCH 1
+#define MCDE_SYNCHCONFA_SWINTVEVENT_ACTIVE_VIDEO 2
+#define MCDE_SYNCHCONFA_SWINTVEVENT_FRONT_PORCH 3
+#define MCDE_SYNCHCONFA_SWINTVEVENT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFA, SWINTVEVENT, \
+	MCDE_SYNCHCONFA_SWINTVEVENT_##__x)
+#define MCDE_SYNCHCONFA_SWINTVEVENT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFA, SWINTVEVENT, __x)
+#define MCDE_SYNCHCONFA_SWINTVCNT_SHIFT 18
+#define MCDE_SYNCHCONFA_SWINTVCNT_MASK 0xFFFC0000
+#define MCDE_SYNCHCONFA_SWINTVCNT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFA, SWINTVCNT, __x)
+#define MCDE_SYNCHCONFB 0x00000A80
+#define MCDE_SYNCHCONFB_HWREQVEVENT_SHIFT 0
+#define MCDE_SYNCHCONFB_HWREQVEVENT_MASK 0x00000003
+#define MCDE_SYNCHCONFB_HWREQVEVENT_VSYNC 0
+#define MCDE_SYNCHCONFB_HWREQVEVENT_BACK_PORCH 1
+#define MCDE_SYNCHCONFB_HWREQVEVENT_ACTIVE_VIDEO 2
+#define MCDE_SYNCHCONFB_HWREQVEVENT_FRONT_PORCH 3
+#define MCDE_SYNCHCONFB_HWREQVEVENT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFB, HWREQVEVENT, \
+	MCDE_SYNCHCONFB_HWREQVEVENT_##__x)
+#define MCDE_SYNCHCONFB_HWREQVEVENT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFB, HWREQVEVENT, __x)
+#define MCDE_SYNCHCONFB_HWREQVCNT_SHIFT 2
+#define MCDE_SYNCHCONFB_HWREQVCNT_MASK 0x0000FFFC
+#define MCDE_SYNCHCONFB_HWREQVCNT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFB, HWREQVCNT, __x)
+#define MCDE_SYNCHCONFB_SWINTVEVENT_SHIFT 16
+#define MCDE_SYNCHCONFB_SWINTVEVENT_MASK 0x00030000
+#define MCDE_SYNCHCONFB_SWINTVEVENT_VSYNC 0
+#define MCDE_SYNCHCONFB_SWINTVEVENT_BACK_PORCH 1
+#define MCDE_SYNCHCONFB_SWINTVEVENT_ACTIVE_VIDEO 2
+#define MCDE_SYNCHCONFB_SWINTVEVENT_FRONT_PORCH 3
+#define MCDE_SYNCHCONFB_SWINTVEVENT_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFB, SWINTVEVENT, \
+	MCDE_SYNCHCONFB_SWINTVEVENT_##__x)
+#define MCDE_SYNCHCONFB_SWINTVEVENT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFB, SWINTVEVENT, __x)
+#define MCDE_SYNCHCONFB_SWINTVCNT_SHIFT 18
+#define MCDE_SYNCHCONFB_SWINTVCNT_MASK 0xFFFC0000
+#define MCDE_SYNCHCONFB_SWINTVCNT(__x) \
+	MCDE_VAL2REG(MCDE_SYNCHCONFB, SWINTVCNT, __x)
+#define MCDE_CTRLA 0x00000884
+#define MCDE_CTRLA_GROUPOFFSET 0x200
+#define MCDE_CTRLA_FIFOWTRMRK_SHIFT 0
+#define MCDE_CTRLA_FIFOWTRMRK_MASK 0x000003FF
+#define MCDE_CTRLA_FIFOWTRMRK(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FIFOWTRMRK, __x)
+#define MCDE_CTRLA_FIFOEMPTY_SHIFT 12
+#define MCDE_CTRLA_FIFOEMPTY_MASK 0x00001000
+#define MCDE_CTRLA_FIFOEMPTY(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FIFOEMPTY, __x)
+#define MCDE_CTRLA_FIFOFULL_SHIFT 13
+#define MCDE_CTRLA_FIFOFULL_MASK 0x00002000
+#define MCDE_CTRLA_FIFOFULL(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FIFOFULL, __x)
+#define MCDE_CTRLA_FORMID_SHIFT 16
+#define MCDE_CTRLA_FORMID_MASK 0x00070000
+#define MCDE_CTRLA_FORMID_DSI0VID 0
+#define MCDE_CTRLA_FORMID_DSI0CMD 1
+#define MCDE_CTRLA_FORMID_DSI1VID 2
+#define MCDE_CTRLA_FORMID_DSI1CMD 3
+#define MCDE_CTRLA_FORMID_DSI2VID 4
+#define MCDE_CTRLA_FORMID_DSI2CMD 5
+#define MCDE_CTRLA_FORMID_DPIA 0
+#define MCDE_CTRLA_FORMID_DPIB 1
+#define MCDE_CTRLA_FORMID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FORMID, MCDE_CTRLA_FORMID_##__x)
+#define MCDE_CTRLA_FORMID(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FORMID, __x)
+#define MCDE_CTRLA_FORMTYPE_SHIFT 20
+#define MCDE_CTRLA_FORMTYPE_MASK 0x00700000
+#define MCDE_CTRLA_FORMTYPE_DPITV 0
+#define MCDE_CTRLA_FORMTYPE_DBI 1
+#define MCDE_CTRLA_FORMTYPE_DSI 2
+#define MCDE_CTRLA_FORMTYPE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FORMTYPE, MCDE_CTRLA_FORMTYPE_##__x)
+#define MCDE_CTRLA_FORMTYPE(__x) \
+	MCDE_VAL2REG(MCDE_CTRLA, FORMTYPE, __x)
+#define MCDE_CTRLB 0x00000A84
+#define MCDE_CTRLB_FIFOWTRMRK_SHIFT 0
+#define MCDE_CTRLB_FIFOWTRMRK_MASK 0x000003FF
+#define MCDE_CTRLB_FIFOWTRMRK(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FIFOWTRMRK, __x)
+#define MCDE_CTRLB_FIFOEMPTY_SHIFT 12
+#define MCDE_CTRLB_FIFOEMPTY_MASK 0x00001000
+#define MCDE_CTRLB_FIFOEMPTY(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FIFOEMPTY, __x)
+#define MCDE_CTRLB_FIFOFULL_SHIFT 13
+#define MCDE_CTRLB_FIFOFULL_MASK 0x00002000
+#define MCDE_CTRLB_FIFOFULL(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FIFOFULL, __x)
+#define MCDE_CTRLB_FORMID_SHIFT 16
+#define MCDE_CTRLB_FORMID_MASK 0x00070000
+#define MCDE_CTRLB_FORMID_DSI0VID 0
+#define MCDE_CTRLB_FORMID_DSI0CMD 1
+#define MCDE_CTRLB_FORMID_DSI1VID 2
+#define MCDE_CTRLB_FORMID_DSI1CMD 3
+#define MCDE_CTRLB_FORMID_DSI2VID 4
+#define MCDE_CTRLB_FORMID_DSI2CMD 5
+#define MCDE_CTRLB_FORMID_DPIA 0
+#define MCDE_CTRLB_FORMID_DPIB 1
+#define MCDE_CTRLB_FORMID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FORMID, MCDE_CTRLB_FORMID_##__x)
+#define MCDE_CTRLB_FORMID(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FORMID, __x)
+#define MCDE_CTRLB_FORMTYPE_SHIFT 20
+#define MCDE_CTRLB_FORMTYPE_MASK 0x00700000
+#define MCDE_CTRLB_FORMTYPE_DPITV 0
+#define MCDE_CTRLB_FORMTYPE_DBI 1
+#define MCDE_CTRLB_FORMTYPE_DSI 2
+#define MCDE_CTRLB_FORMTYPE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FORMTYPE, MCDE_CTRLB_FORMTYPE_##__x)
+#define MCDE_CTRLB_FORMTYPE(__x) \
+	MCDE_VAL2REG(MCDE_CTRLB, FORMTYPE, __x)
+#define MCDE_GAM0A 0x00000888
+#define MCDE_GAM0A_GROUPOFFSET 0x200
+#define MCDE_GAM0A_BLUE_SHIFT 0
+#define MCDE_GAM0A_BLUE_MASK 0x00FFFFFF
+#define MCDE_GAM0A_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_GAM0A, BLUE, __x)
+#define MCDE_GAM0B 0x00000A88
+#define MCDE_GAM0B_BLUE_SHIFT 0
+#define MCDE_GAM0B_BLUE_MASK 0x00FFFFFF
+#define MCDE_GAM0B_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_GAM0B, BLUE, __x)
+#define MCDE_GAM1A 0x0000088C
+#define MCDE_GAM1A_GROUPOFFSET 0x200
+#define MCDE_GAM1A_GREEN_SHIFT 0
+#define MCDE_GAM1A_GREEN_MASK 0x00FFFFFF
+#define MCDE_GAM1A_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_GAM1A, GREEN, __x)
+#define MCDE_GAM1B 0x00000A8C
+#define MCDE_GAM1B_GREEN_SHIFT 0
+#define MCDE_GAM1B_GREEN_MASK 0x00FFFFFF
+#define MCDE_GAM1B_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_GAM1B, GREEN, __x)
+#define MCDE_GAM2A 0x00000890
+#define MCDE_GAM2A_GROUPOFFSET 0x200
+#define MCDE_GAM2A_RED_SHIFT 0
+#define MCDE_GAM2A_RED_MASK 0x00FFFFFF
+#define MCDE_GAM2A_RED(__x) \
+	MCDE_VAL2REG(MCDE_GAM2A, RED, __x)
+#define MCDE_GAM2B 0x00000A90
+#define MCDE_GAM2B_RED_SHIFT 0
+#define MCDE_GAM2B_RED_MASK 0x00FFFFFF
+#define MCDE_GAM2B_RED(__x) \
+	MCDE_VAL2REG(MCDE_GAM2B, RED, __x)
+#define MCDE_OLEDCONV1A 0x00000894
+#define MCDE_OLEDCONV1A_GROUPOFFSET 0x200
+#define MCDE_OLEDCONV1A_ALPHA_RED_SHIFT 0
+#define MCDE_OLEDCONV1A_ALPHA_RED_MASK 0x00003FFF
+#define MCDE_OLEDCONV1A_ALPHA_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV1A, ALPHA_RED, __x)
+#define MCDE_OLEDCONV1A_ALPHA_GREEN_SHIFT 16
+#define MCDE_OLEDCONV1A_ALPHA_GREEN_MASK 0x3FFF0000
+#define MCDE_OLEDCONV1A_ALPHA_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV1A, ALPHA_GREEN, __x)
+#define MCDE_OLEDCONV1B 0x00000A94
+#define MCDE_OLEDCONV1B_ALPHA_RED_SHIFT 0
+#define MCDE_OLEDCONV1B_ALPHA_RED_MASK 0x00003FFF
+#define MCDE_OLEDCONV1B_ALPHA_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV1B, ALPHA_RED, __x)
+#define MCDE_OLEDCONV1B_ALPHA_GREEN_SHIFT 16
+#define MCDE_OLEDCONV1B_ALPHA_GREEN_MASK 0x3FFF0000
+#define MCDE_OLEDCONV1B_ALPHA_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV1B, ALPHA_GREEN, __x)
+#define MCDE_OLEDCONV2A 0x00000898
+#define MCDE_OLEDCONV2A_GROUPOFFSET 0x200
+#define MCDE_OLEDCONV2A_ALPHA_BLUE_SHIFT 0
+#define MCDE_OLEDCONV2A_ALPHA_BLUE_MASK 0x00003FFF
+#define MCDE_OLEDCONV2A_ALPHA_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV2A, ALPHA_BLUE, __x)
+#define MCDE_OLEDCONV2A_BETA_RED_SHIFT 16
+#define MCDE_OLEDCONV2A_BETA_RED_MASK 0x3FFF0000
+#define MCDE_OLEDCONV2A_BETA_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV2A, BETA_RED, __x)
+#define MCDE_OLEDCONV2B 0x00000A98
+#define MCDE_OLEDCONV2B_ALPHA_BLUE_SHIFT 0
+#define MCDE_OLEDCONV2B_ALPHA_BLUE_MASK 0x00003FFF
+#define MCDE_OLEDCONV2B_ALPHA_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV2B, ALPHA_BLUE, __x)
+#define MCDE_OLEDCONV2B_BETA_RED_SHIFT 16
+#define MCDE_OLEDCONV2B_BETA_RED_MASK 0x3FFF0000
+#define MCDE_OLEDCONV2B_BETA_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV2B, BETA_RED, __x)
+#define MCDE_OLEDCONV3A 0x0000089C
+#define MCDE_OLEDCONV3A_GROUPOFFSET 0x200
+#define MCDE_OLEDCONV3A_BETA_GREEN_SHIFT 0
+#define MCDE_OLEDCONV3A_BETA_GREEN_MASK 0x00003FFF
+#define MCDE_OLEDCONV3A_BETA_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV3A, BETA_GREEN, __x)
+#define MCDE_OLEDCONV3A_BETA_BLUE_SHIFT 16
+#define MCDE_OLEDCONV3A_BETA_BLUE_MASK 0x3FFF0000
+#define MCDE_OLEDCONV3A_BETA_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV3A, BETA_BLUE, __x)
+#define MCDE_OLEDCONV3B 0x00000A9C
+#define MCDE_OLEDCONV3B_BETA_GREEN_SHIFT 0
+#define MCDE_OLEDCONV3B_BETA_GREEN_MASK 0x00003FFF
+#define MCDE_OLEDCONV3B_BETA_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV3B, BETA_GREEN, __x)
+#define MCDE_OLEDCONV3B_BETA_BLUE_SHIFT 16
+#define MCDE_OLEDCONV3B_BETA_BLUE_MASK 0x3FFF0000
+#define MCDE_OLEDCONV3B_BETA_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV3B, BETA_BLUE, __x)
+#define MCDE_OLEDCONV4A 0x000008A0
+#define MCDE_OLEDCONV4A_GROUPOFFSET 0x200
+#define MCDE_OLEDCONV4A_GAMMA_RED_SHIFT 0
+#define MCDE_OLEDCONV4A_GAMMA_RED_MASK 0x00003FFF
+#define MCDE_OLEDCONV4A_GAMMA_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV4A, GAMMA_RED, __x)
+#define MCDE_OLEDCONV4A_GAMMA_GREEN_SHIFT 16
+#define MCDE_OLEDCONV4A_GAMMA_GREEN_MASK 0x3FFF0000
+#define MCDE_OLEDCONV4A_GAMMA_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV4A, GAMMA_GREEN, __x)
+#define MCDE_OLEDCONV4B 0x00000AA0
+#define MCDE_OLEDCONV4B_GAMMA_RED_SHIFT 0
+#define MCDE_OLEDCONV4B_GAMMA_RED_MASK 0x00003FFF
+#define MCDE_OLEDCONV4B_GAMMA_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV4B, GAMMA_RED, __x)
+#define MCDE_OLEDCONV4B_GAMMA_GREEN_SHIFT 16
+#define MCDE_OLEDCONV4B_GAMMA_GREEN_MASK 0x3FFF0000
+#define MCDE_OLEDCONV4B_GAMMA_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV4B, GAMMA_GREEN, __x)
+#define MCDE_OLEDCONV5A 0x000008A4
+#define MCDE_OLEDCONV5A_GROUPOFFSET 0x200
+#define MCDE_OLEDCONV5A_GAMMA_BLUE_SHIFT 0
+#define MCDE_OLEDCONV5A_GAMMA_BLUE_MASK 0x00003FFF
+#define MCDE_OLEDCONV5A_GAMMA_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV5A, GAMMA_BLUE, __x)
+#define MCDE_OLEDCONV5A_OFF_RED_SHIFT 16
+#define MCDE_OLEDCONV5A_OFF_RED_MASK 0x3FFF0000
+#define MCDE_OLEDCONV5A_OFF_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV5A, OFF_RED, __x)
+#define MCDE_OLEDCONV5B 0x00000AA4
+#define MCDE_OLEDCONV5B_GAMMA_BLUE_SHIFT 0
+#define MCDE_OLEDCONV5B_GAMMA_BLUE_MASK 0x00003FFF
+#define MCDE_OLEDCONV5B_GAMMA_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV5B, GAMMA_BLUE, __x)
+#define MCDE_OLEDCONV5B_OFF_RED_SHIFT 16
+#define MCDE_OLEDCONV5B_OFF_RED_MASK 0x3FFF0000
+#define MCDE_OLEDCONV5B_OFF_RED(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV5B, OFF_RED, __x)
+#define MCDE_OLEDCONV6A 0x000008A8
+#define MCDE_OLEDCONV6A_GROUPOFFSET 0x200
+#define MCDE_OLEDCONV6A_OFF_GREEN_SHIFT 0
+#define MCDE_OLEDCONV6A_OFF_GREEN_MASK 0x00003FFF
+#define MCDE_OLEDCONV6A_OFF_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV6A, OFF_GREEN, __x)
+#define MCDE_OLEDCONV6A_OFF_BLUE_SHIFT 16
+#define MCDE_OLEDCONV6A_OFF_BLUE_MASK 0x3FFF0000
+#define MCDE_OLEDCONV6A_OFF_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV6A, OFF_BLUE, __x)
+#define MCDE_OLEDCONV6B 0x00000AA8
+#define MCDE_OLEDCONV6B_OFF_GREEN_SHIFT 0
+#define MCDE_OLEDCONV6B_OFF_GREEN_MASK 0x00003FFF
+#define MCDE_OLEDCONV6B_OFF_GREEN(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV6B, OFF_GREEN, __x)
+#define MCDE_OLEDCONV6B_OFF_BLUE_SHIFT 16
+#define MCDE_OLEDCONV6B_OFF_BLUE_MASK 0x3FFF0000
+#define MCDE_OLEDCONV6B_OFF_BLUE(__x) \
+	MCDE_VAL2REG(MCDE_OLEDCONV6B, OFF_BLUE, __x)
+#define MCDE_CRC 0x00000C00
+#define MCDE_CRC_FLOEN_SHIFT 0
+#define MCDE_CRC_FLOEN_MASK 0x00000001
+#define MCDE_CRC_FLOEN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, FLOEN, __x)
+#define MCDE_CRC_POWEREN_SHIFT 1
+#define MCDE_CRC_POWEREN_MASK 0x00000002
+#define MCDE_CRC_POWEREN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, POWEREN, __x)
+#define MCDE_CRC_C1EN_SHIFT 2
+#define MCDE_CRC_C1EN_MASK 0x00000004
+#define MCDE_CRC_C1EN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, C1EN, __x)
+#define MCDE_CRC_C2EN_SHIFT 3
+#define MCDE_CRC_C2EN_MASK 0x00000008
+#define MCDE_CRC_C2EN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, C2EN, __x)
+#define MCDE_CRC_WMLVL1_SHIFT 4
+#define MCDE_CRC_WMLVL1_MASK 0x00000010
+#define MCDE_CRC_WMLVL1(__x) \
+	MCDE_VAL2REG(MCDE_CRC, WMLVL1, __x)
+#define MCDE_CRC_WMLVL2_SHIFT 5
+#define MCDE_CRC_WMLVL2_MASK 0x00000020
+#define MCDE_CRC_WMLVL2(__x) \
+	MCDE_VAL2REG(MCDE_CRC, WMLVL2, __x)
+#define MCDE_CRC_SYNCSEL_SHIFT 6
+#define MCDE_CRC_SYNCSEL_MASK 0x00000040
+#define MCDE_CRC_SYNCSEL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SYNCSEL, __x)
+#define MCDE_CRC_SYCEN0_SHIFT 7
+#define MCDE_CRC_SYCEN0_MASK 0x00000080
+#define MCDE_CRC_SYCEN0(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SYCEN0, __x)
+#define MCDE_CRC_SYCEN1_SHIFT 8
+#define MCDE_CRC_SYCEN1_MASK 0x00000100
+#define MCDE_CRC_SYCEN1(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SYCEN1, __x)
+#define MCDE_CRC_SIZE1_SHIFT 9
+#define MCDE_CRC_SIZE1_MASK 0x00000200
+#define MCDE_CRC_SIZE1(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SIZE1, __x)
+#define MCDE_CRC_SIZE2_SHIFT 10
+#define MCDE_CRC_SIZE2_MASK 0x00000400
+#define MCDE_CRC_SIZE2(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SIZE2, __x)
+#define MCDE_CRC_INBAND1_SHIFT 11
+#define MCDE_CRC_INBAND1_MASK 0x00000800
+#define MCDE_CRC_INBAND1(__x) \
+	MCDE_VAL2REG(MCDE_CRC, INBAND1, __x)
+#define MCDE_CRC_INBAND2_SHIFT 12
+#define MCDE_CRC_INBAND2_MASK 0x00001000
+#define MCDE_CRC_INBAND2(__x) \
+	MCDE_VAL2REG(MCDE_CRC, INBAND2, __x)
+#define MCDE_CRC_CLKSEL_SHIFT 13
+#define MCDE_CRC_CLKSEL_MASK 0x00006000
+#define MCDE_CRC_CLKSEL_166MHz 0
+#define MCDE_CRC_CLKSEL_48MHz 1
+#define MCDE_CRC_CLKSEL_LCD 2
+#define MCDE_CRC_CLKSEL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CLKSEL, MCDE_CRC_CLKSEL_##__x)
+#define MCDE_CRC_CLKSEL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CLKSEL, __x)
+#define MCDE_CRC_YUVCONVC1EN_SHIFT 15
+#define MCDE_CRC_YUVCONVC1EN_MASK 0x00008000
+#define MCDE_CRC_YUVCONVC1EN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, YUVCONVC1EN, __x)
+#define MCDE_CRC_CS1EN_SHIFT 16
+#define MCDE_CRC_CS1EN_MASK 0x00010000
+#define MCDE_CRC_CS1EN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CS1EN, __x)
+#define MCDE_CRC_CS2EN_SHIFT 17
+#define MCDE_CRC_CS2EN_MASK 0x00020000
+#define MCDE_CRC_CS2EN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CS2EN, __x)
+#define MCDE_CRC_RESEN_SHIFT 18
+#define MCDE_CRC_RESEN_MASK 0x00040000
+#define MCDE_CRC_RESEN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, RESEN, __x)
+#define MCDE_CRC_CS1POL_SHIFT 19
+#define MCDE_CRC_CS1POL_MASK 0x00080000
+#define MCDE_CRC_CS1POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CS1POL, __x)
+#define MCDE_CRC_CS2POL_SHIFT 20
+#define MCDE_CRC_CS2POL_MASK 0x00100000
+#define MCDE_CRC_CS2POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CS2POL, __x)
+#define MCDE_CRC_CD1POL_SHIFT 21
+#define MCDE_CRC_CD1POL_MASK 0x00200000
+#define MCDE_CRC_CD1POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CD1POL, __x)
+#define MCDE_CRC_CD2POL_SHIFT 22
+#define MCDE_CRC_CD2POL_MASK 0x00400000
+#define MCDE_CRC_CD2POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CD2POL, __x)
+#define MCDE_CRC_WR1POL_SHIFT 23
+#define MCDE_CRC_WR1POL_MASK 0x00800000
+#define MCDE_CRC_WR1POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, WR1POL, __x)
+#define MCDE_CRC_WR2POL_SHIFT 24
+#define MCDE_CRC_WR2POL_MASK 0x01000000
+#define MCDE_CRC_WR2POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, WR2POL, __x)
+#define MCDE_CRC_RD1POL_SHIFT 25
+#define MCDE_CRC_RD1POL_MASK 0x02000000
+#define MCDE_CRC_RD1POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, RD1POL, __x)
+#define MCDE_CRC_RD2POL_SHIFT 26
+#define MCDE_CRC_RD2POL_MASK 0x04000000
+#define MCDE_CRC_RD2POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, RD2POL, __x)
+#define MCDE_CRC_RES1POL_SHIFT 27
+#define MCDE_CRC_RES1POL_MASK 0x08000000
+#define MCDE_CRC_RES1POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, RES1POL, __x)
+#define MCDE_CRC_RES2POL_SHIFT 28
+#define MCDE_CRC_RES2POL_MASK 0x10000000
+#define MCDE_CRC_RES2POL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, RES2POL, __x)
+#define MCDE_CRC_SYNCCTRL_SHIFT 29
+#define MCDE_CRC_SYNCCTRL_MASK 0x60000000
+#define MCDE_CRC_SYNCCTRL_OFF 0
+#define MCDE_CRC_SYNCCTRL_C0 1
+#define MCDE_CRC_SYNCCTRL_C1 2
+#define MCDE_CRC_SYNCCTRL_PING_PONG 3
+#define MCDE_CRC_SYNCCTRL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SYNCCTRL, MCDE_CRC_SYNCCTRL_##__x)
+#define MCDE_CRC_SYNCCTRL(__x) \
+	MCDE_VAL2REG(MCDE_CRC, SYNCCTRL, __x)
+#define MCDE_CRC_CLAMPC1EN_SHIFT 31
+#define MCDE_CRC_CLAMPC1EN_MASK 0x80000000
+#define MCDE_CRC_CLAMPC1EN(__x) \
+	MCDE_VAL2REG(MCDE_CRC, CLAMPC1EN, __x)
+#define MCDE_PBCCRC0 0x00000C04
+#define MCDE_PBCCRC0_GROUPOFFSET 0x4
+#define MCDE_PBCCRC0_BSCM_SHIFT 0
+#define MCDE_PBCCRC0_BSCM_MASK 0x00000007
+#define MCDE_PBCCRC0_BSCM_1_8BIT 0
+#define MCDE_PBCCRC0_BSCM_2_8BIT 1
+#define MCDE_PBCCRC0_BSCM_3_8BIT 2
+#define MCDE_PBCCRC0_BSCM_1_16BIT 3
+#define MCDE_PBCCRC0_BSCM_2_16BIT 4
+#define MCDE_PBCCRC0_BSCM_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, BSCM, MCDE_PBCCRC0_BSCM_##__x)
+#define MCDE_PBCCRC0_BSCM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, BSCM, __x)
+#define MCDE_PBCCRC0_BSDM_SHIFT 3
+#define MCDE_PBCCRC0_BSDM_MASK 0x00000038
+#define MCDE_PBCCRC0_BSDM_1_8BIT 0
+#define MCDE_PBCCRC0_BSDM_2_8BIT 1
+#define MCDE_PBCCRC0_BSDM_3_8BIT 2
+#define MCDE_PBCCRC0_BSDM_1_16BIT 3
+#define MCDE_PBCCRC0_BSDM_2_16BIT 4
+#define MCDE_PBCCRC0_BSDM_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, BSDM, MCDE_PBCCRC0_BSDM_##__x)
+#define MCDE_PBCCRC0_BSDM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, BSDM, __x)
+#define MCDE_PBCCRC0_PDM_SHIFT 6
+#define MCDE_PBCCRC0_PDM_MASK 0x000000C0
+#define MCDE_PBCCRC0_PDM_NORMAL 0
+#define MCDE_PBCCRC0_PDM_16_TO_32 1
+#define MCDE_PBCCRC0_PDM_24_TO_32_RIGHT 2
+#define MCDE_PBCCRC0_PDM_24_TO_32_LEFT 3
+#define MCDE_PBCCRC0_PDM_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, PDM, MCDE_PBCCRC0_PDM_##__x)
+#define MCDE_PBCCRC0_PDM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, PDM, __x)
+#define MCDE_PBCCRC0_PDCTRL_SHIFT 12
+#define MCDE_PBCCRC0_PDCTRL_MASK 0x00001000
+#define MCDE_PBCCRC0_PDCTRL(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, PDCTRL, __x)
+#define MCDE_PBCCRC0_BPP_SHIFT 13
+#define MCDE_PBCCRC0_BPP_MASK 0x0000E000
+#define MCDE_PBCCRC0_BPP_8BPP 0
+#define MCDE_PBCCRC0_BPP_12BPP 1
+#define MCDE_PBCCRC0_BPP_15BPP 2
+#define MCDE_PBCCRC0_BPP_16BPP 3
+#define MCDE_PBCCRC0_BPP_18BPP 4
+#define MCDE_PBCCRC0_BPP_24BPP 5
+#define MCDE_PBCCRC0_BPP(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC0, BPP, __x)
+#define MCDE_PBCCRC1 0x00000C08
+#define MCDE_PBCCRC1_BSCM_SHIFT 0
+#define MCDE_PBCCRC1_BSCM_MASK 0x00000007
+#define MCDE_PBCCRC1_BSCM_1_8BIT 0
+#define MCDE_PBCCRC1_BSCM_2_8BIT 1
+#define MCDE_PBCCRC1_BSCM_3_8BIT 2
+#define MCDE_PBCCRC1_BSCM_1_16BIT 3
+#define MCDE_PBCCRC1_BSCM_2_16BIT 4
+#define MCDE_PBCCRC1_BSCM_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, BSCM, MCDE_PBCCRC1_BSCM_##__x)
+#define MCDE_PBCCRC1_BSCM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, BSCM, __x)
+#define MCDE_PBCCRC1_BSDM_SHIFT 3
+#define MCDE_PBCCRC1_BSDM_MASK 0x00000038
+#define MCDE_PBCCRC1_BSDM_1_8BIT 0
+#define MCDE_PBCCRC1_BSDM_2_8BIT 1
+#define MCDE_PBCCRC1_BSDM_3_8BIT 2
+#define MCDE_PBCCRC1_BSDM_1_16BIT 3
+#define MCDE_PBCCRC1_BSDM_2_16BIT 4
+#define MCDE_PBCCRC1_BSDM_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, BSDM, MCDE_PBCCRC1_BSDM_##__x)
+#define MCDE_PBCCRC1_BSDM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, BSDM, __x)
+#define MCDE_PBCCRC1_PDM_SHIFT 6
+#define MCDE_PBCCRC1_PDM_MASK 0x000000C0
+#define MCDE_PBCCRC1_PDM_NORMAL 0
+#define MCDE_PBCCRC1_PDM_16_TO_32 1
+#define MCDE_PBCCRC1_PDM_24_TO_32_RIGHT 2
+#define MCDE_PBCCRC1_PDM_24_TO_32_LEFT 3
+#define MCDE_PBCCRC1_PDM_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, PDM, MCDE_PBCCRC1_PDM_##__x)
+#define MCDE_PBCCRC1_PDM(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, PDM, __x)
+#define MCDE_PBCCRC1_PDCTRL_SHIFT 12
+#define MCDE_PBCCRC1_PDCTRL_MASK 0x00001000
+#define MCDE_PBCCRC1_PDCTRL(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, PDCTRL, __x)
+#define MCDE_PBCCRC1_BPP_SHIFT 13
+#define MCDE_PBCCRC1_BPP_MASK 0x0000E000
+#define MCDE_PBCCRC1_BPP_8BPP 0
+#define MCDE_PBCCRC1_BPP_12BPP 1
+#define MCDE_PBCCRC1_BPP_15BPP 2
+#define MCDE_PBCCRC1_BPP_16BPP 3
+#define MCDE_PBCCRC1_BPP_18BPP 4
+#define MCDE_PBCCRC1_BPP_24BPP 5
+#define MCDE_PBCCRC1_BPP(__x) \
+	MCDE_VAL2REG(MCDE_PBCCRC1, BPP, __x)
+#define MCDE_PBCBMRC00 0x00000C0C
+#define MCDE_PBCBMRC00_GROUPOFFSET 0x4
+#define MCDE_PBCBMRC00_MUXI_SHIFT 0
+#define MCDE_PBCBMRC00_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC00_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC00, MUXI, __x)
+#define MCDE_PBCBMRC01 0x00000C10
+#define MCDE_PBCBMRC01_MUXI_SHIFT 0
+#define MCDE_PBCBMRC01_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC01_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC01, MUXI, __x)
+#define MCDE_PBCBMRC02 0x00000C14
+#define MCDE_PBCBMRC02_MUXI_SHIFT 0
+#define MCDE_PBCBMRC02_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC02_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC02, MUXI, __x)
+#define MCDE_PBCBMRC03 0x00000C18
+#define MCDE_PBCBMRC03_MUXI_SHIFT 0
+#define MCDE_PBCBMRC03_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC03_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC03, MUXI, __x)
+#define MCDE_PBCBMRC04 0x00000C1C
+#define MCDE_PBCBMRC04_MUXI_SHIFT 0
+#define MCDE_PBCBMRC04_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC04_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC04, MUXI, __x)
+#define MCDE_PBCBMRC10 0x00000C20
+#define MCDE_PBCBMRC10_MUXI_SHIFT 0
+#define MCDE_PBCBMRC10_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC10_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC10, MUXI, __x)
+#define MCDE_PBCBMRC11 0x00000C24
+#define MCDE_PBCBMRC11_MUXI_SHIFT 0
+#define MCDE_PBCBMRC11_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC11_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC11, MUXI, __x)
+#define MCDE_PBCBMRC12 0x00000C28
+#define MCDE_PBCBMRC12_MUXI_SHIFT 0
+#define MCDE_PBCBMRC12_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC12_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC12, MUXI, __x)
+#define MCDE_PBCBMRC13 0x00000C2C
+#define MCDE_PBCBMRC13_MUXI_SHIFT 0
+#define MCDE_PBCBMRC13_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC13_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC13, MUXI, __x)
+#define MCDE_PBCBMRC14 0x00000C30
+#define MCDE_PBCBMRC14_MUXI_SHIFT 0
+#define MCDE_PBCBMRC14_MUXI_MASK 0xFFFFFFFF
+#define MCDE_PBCBMRC14_MUXI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBMRC14, MUXI, __x)
+#define MCDE_PBCBCRC00 0x00000C34
+#define MCDE_PBCBCRC00_GROUPOFFSET 0x4
+#define MCDE_PBCBCRC00_CTLI_SHIFT 0
+#define MCDE_PBCBCRC00_CTLI_MASK 0xFFFFFFFF
+#define MCDE_PBCBCRC00_CTLI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBCRC00, CTLI, __x)
+#define MCDE_PBCBCRC10 0x00000C38
+#define MCDE_PBCBCRC10_CTLI_SHIFT 0
+#define MCDE_PBCBCRC10_CTLI_MASK 0xFFFFFFFF
+#define MCDE_PBCBCRC10_CTLI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBCRC10, CTLI, __x)
+#define MCDE_PBCBCRC01 0x00000C48
+#define MCDE_PBCBCRC01_GROUPOFFSET 0x4
+#define MCDE_PBCBCRC01_CTLI_SHIFT 0
+#define MCDE_PBCBCRC01_CTLI_MASK 0xFFFFFFFF
+#define MCDE_PBCBCRC01_CTLI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBCRC01, CTLI, __x)
+#define MCDE_PBCBCRC11 0x00000C4C
+#define MCDE_PBCBCRC11_CTLI_SHIFT 0
+#define MCDE_PBCBCRC11_CTLI_MASK 0xFFFFFFFF
+#define MCDE_PBCBCRC11_CTLI(__x) \
+	MCDE_VAL2REG(MCDE_PBCBCRC11, CTLI, __x)
+#define MCDE_VSCRC0 0x00000C5C
+#define MCDE_VSCRC0_GROUPOFFSET 0x4
+#define MCDE_VSCRC0_VSPMIN_SHIFT 0
+#define MCDE_VSCRC0_VSPMIN_MASK 0x00000FFF
+#define MCDE_VSCRC0_VSPMIN(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSPMIN, __x)
+#define MCDE_VSCRC0_VSPMAX_SHIFT 12
+#define MCDE_VSCRC0_VSPMAX_MASK 0x00FFF000
+#define MCDE_VSCRC0_VSPMAX(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSPMAX, __x)
+#define MCDE_VSCRC0_VSPDIV_SHIFT 24
+#define MCDE_VSCRC0_VSPDIV_MASK 0x07000000
+#define MCDE_VSCRC0_VSPDIV(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSPDIV, __x)
+#define MCDE_VSCRC0_VSPOL_SHIFT 27
+#define MCDE_VSCRC0_VSPOL_MASK 0x08000000
+#define MCDE_VSCRC0_VSPOL_ACTIVE_HIGH 0
+#define MCDE_VSCRC0_VSPOL_ACTIVE_LOW 1
+#define MCDE_VSCRC0_VSPOL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSPOL, MCDE_VSCRC0_VSPOL_##__x)
+#define MCDE_VSCRC0_VSPOL(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSPOL, __x)
+#define MCDE_VSCRC0_VSSEL_SHIFT 28
+#define MCDE_VSCRC0_VSSEL_MASK 0x10000000
+#define MCDE_VSCRC0_VSSEL_VSYNC 0
+#define MCDE_VSCRC0_VSSEL_HSYNC 1
+#define MCDE_VSCRC0_VSSEL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSSEL, MCDE_VSCRC0_VSSEL_##__x)
+#define MCDE_VSCRC0_VSSEL(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSSEL, __x)
+#define MCDE_VSCRC0_VSDBL_SHIFT 29
+#define MCDE_VSCRC0_VSDBL_MASK 0xE0000000
+#define MCDE_VSCRC0_VSDBL(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC0, VSDBL, __x)
+#define MCDE_VSCRC1 0x00000C60
+#define MCDE_VSCRC1_VSPMIN_SHIFT 0
+#define MCDE_VSCRC1_VSPMIN_MASK 0x00000FFF
+#define MCDE_VSCRC1_VSPMIN(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSPMIN, __x)
+#define MCDE_VSCRC1_VSPMAX_SHIFT 12
+#define MCDE_VSCRC1_VSPMAX_MASK 0x00FFF000
+#define MCDE_VSCRC1_VSPMAX(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSPMAX, __x)
+#define MCDE_VSCRC1_VSPDIV_SHIFT 24
+#define MCDE_VSCRC1_VSPDIV_MASK 0x07000000
+#define MCDE_VSCRC1_VSPDIV(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSPDIV, __x)
+#define MCDE_VSCRC1_VSPOL_SHIFT 27
+#define MCDE_VSCRC1_VSPOL_MASK 0x08000000
+#define MCDE_VSCRC1_VSPOL_ACTIVE_HIGH 0
+#define MCDE_VSCRC1_VSPOL_ACTIVE_LOW 1
+#define MCDE_VSCRC1_VSPOL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSPOL, MCDE_VSCRC1_VSPOL_##__x)
+#define MCDE_VSCRC1_VSPOL(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSPOL, __x)
+#define MCDE_VSCRC1_VSSEL_SHIFT 28
+#define MCDE_VSCRC1_VSSEL_MASK 0x10000000
+#define MCDE_VSCRC1_VSSEL_VSYNC 0
+#define MCDE_VSCRC1_VSSEL_HSYNC 1
+#define MCDE_VSCRC1_VSSEL_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSSEL, MCDE_VSCRC1_VSSEL_##__x)
+#define MCDE_VSCRC1_VSSEL(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSSEL, __x)
+#define MCDE_VSCRC1_VSDBL_SHIFT 29
+#define MCDE_VSCRC1_VSDBL_MASK 0xE0000000
+#define MCDE_VSCRC1_VSDBL(__x) \
+	MCDE_VAL2REG(MCDE_VSCRC1, VSDBL, __x)
+#define MCDE_SCTRC 0x00000C64
+#define MCDE_SCTRC_SYNCDELC0_SHIFT 0
+#define MCDE_SCTRC_SYNCDELC0_MASK 0x000000FF
+#define MCDE_SCTRC_SYNCDELC0(__x) \
+	MCDE_VAL2REG(MCDE_SCTRC, SYNCDELC0, __x)
+#define MCDE_SCTRC_SYNCDELC1_SHIFT 8
+#define MCDE_SCTRC_SYNCDELC1_MASK 0x0000FF00
+#define MCDE_SCTRC_SYNCDELC1(__x) \
+	MCDE_VAL2REG(MCDE_SCTRC, SYNCDELC1, __x)
+#define MCDE_SCTRC_TRDELC_SHIFT 16
+#define MCDE_SCTRC_TRDELC_MASK 0x0FFF0000
+#define MCDE_SCTRC_TRDELC(__x) \
+	MCDE_VAL2REG(MCDE_SCTRC, TRDELC, __x)
+#define MCDE_SCSRC 0x00000C68
+#define MCDE_SCSRC_VSTAC0_SHIFT 0
+#define MCDE_SCSRC_VSTAC0_MASK 0x00000001
+#define MCDE_SCSRC_VSTAC0(__x) \
+	MCDE_VAL2REG(MCDE_SCSRC, VSTAC0, __x)
+#define MCDE_SCSRC_VSTAC1_SHIFT 1
+#define MCDE_SCSRC_VSTAC1_MASK 0x00000002
+#define MCDE_SCSRC_VSTAC1(__x) \
+	MCDE_VAL2REG(MCDE_SCSRC, VSTAC1, __x)
+#define MCDE_BCNR0 0x00000C6C
+#define MCDE_BCNR0_GROUPOFFSET 0x4
+#define MCDE_BCNR0_BCN_SHIFT 0
+#define MCDE_BCNR0_BCN_MASK 0x000000FF
+#define MCDE_BCNR0_BCN(__x) \
+	MCDE_VAL2REG(MCDE_BCNR0, BCN, __x)
+#define MCDE_BCNR1 0x00000C70
+#define MCDE_BCNR1_BCN_SHIFT 0
+#define MCDE_BCNR1_BCN_MASK 0x000000FF
+#define MCDE_BCNR1_BCN(__x) \
+	MCDE_VAL2REG(MCDE_BCNR1, BCN, __x)
+#define MCDE_CSCDTR0 0x00000C74
+#define MCDE_CSCDTR0_GROUPOFFSET 0x4
+#define MCDE_CSCDTR0_CSACT_SHIFT 0
+#define MCDE_CSCDTR0_CSACT_MASK 0x000000FF
+#define MCDE_CSCDTR0_CSACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR0, CSACT, __x)
+#define MCDE_CSCDTR0_CSDEACT_SHIFT 8
+#define MCDE_CSCDTR0_CSDEACT_MASK 0x0000FF00
+#define MCDE_CSCDTR0_CSDEACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR0, CSDEACT, __x)
+#define MCDE_CSCDTR0_CDACT_SHIFT 16
+#define MCDE_CSCDTR0_CDACT_MASK 0x00FF0000
+#define MCDE_CSCDTR0_CDACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR0, CDACT, __x)
+#define MCDE_CSCDTR0_CDDEACT_SHIFT 24
+#define MCDE_CSCDTR0_CDDEACT_MASK 0xFF000000
+#define MCDE_CSCDTR0_CDDEACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR0, CDDEACT, __x)
+#define MCDE_CSCDTR1 0x00000C78
+#define MCDE_CSCDTR1_CSACT_SHIFT 0
+#define MCDE_CSCDTR1_CSACT_MASK 0x000000FF
+#define MCDE_CSCDTR1_CSACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR1, CSACT, __x)
+#define MCDE_CSCDTR1_CSDEACT_SHIFT 8
+#define MCDE_CSCDTR1_CSDEACT_MASK 0x0000FF00
+#define MCDE_CSCDTR1_CSDEACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR1, CSDEACT, __x)
+#define MCDE_CSCDTR1_CDACT_SHIFT 16
+#define MCDE_CSCDTR1_CDACT_MASK 0x00FF0000
+#define MCDE_CSCDTR1_CDACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR1, CDACT, __x)
+#define MCDE_CSCDTR1_CDDEACT_SHIFT 24
+#define MCDE_CSCDTR1_CDDEACT_MASK 0xFF000000
+#define MCDE_CSCDTR1_CDDEACT(__x) \
+	MCDE_VAL2REG(MCDE_CSCDTR1, CDDEACT, __x)
+#define MCDE_RDWRTR0 0x00000C7C
+#define MCDE_RDWRTR0_GROUPOFFSET 0x4
+#define MCDE_RDWRTR0_RWACT_SHIFT 0
+#define MCDE_RDWRTR0_RWACT_MASK 0x000000FF
+#define MCDE_RDWRTR0_RWACT(__x) \
+	MCDE_VAL2REG(MCDE_RDWRTR0, RWACT, __x)
+#define MCDE_RDWRTR0_RWDEACT_SHIFT 8
+#define MCDE_RDWRTR0_RWDEACT_MASK 0x0000FF00
+#define MCDE_RDWRTR0_RWDEACT(__x) \
+	MCDE_VAL2REG(MCDE_RDWRTR0, RWDEACT, __x)
+#define MCDE_RDWRTR0_MOTINT_SHIFT 16
+#define MCDE_RDWRTR0_MOTINT_MASK 0x00010000
+#define MCDE_RDWRTR0_MOTINT(__x) \
+	MCDE_VAL2REG(MCDE_RDWRTR0, MOTINT, __x)
+#define MCDE_RDWRTR1 0x00000C80
+#define MCDE_RDWRTR1_RWACT_SHIFT 0
+#define MCDE_RDWRTR1_RWACT_MASK 0x000000FF
+#define MCDE_RDWRTR1_RWACT(__x) \
+	MCDE_VAL2REG(MCDE_RDWRTR1, RWACT, __x)
+#define MCDE_RDWRTR1_RWDEACT_SHIFT 8
+#define MCDE_RDWRTR1_RWDEACT_MASK 0x0000FF00
+#define MCDE_RDWRTR1_RWDEACT(__x) \
+	MCDE_VAL2REG(MCDE_RDWRTR1, RWDEACT, __x)
+#define MCDE_RDWRTR1_MOTINT_SHIFT 16
+#define MCDE_RDWRTR1_MOTINT_MASK 0x00010000
+#define MCDE_RDWRTR1_MOTINT(__x) \
+	MCDE_VAL2REG(MCDE_RDWRTR1, MOTINT, __x)
+#define MCDE_DOTR0 0x00000C84
+#define MCDE_DOTR0_GROUPOFFSET 0x4
+#define MCDE_DOTR0_DOACT_SHIFT 0
+#define MCDE_DOTR0_DOACT_MASK 0x000000FF
+#define MCDE_DOTR0_DOACT(__x) \
+	MCDE_VAL2REG(MCDE_DOTR0, DOACT, __x)
+#define MCDE_DOTR0_DODEACT_SHIFT 8
+#define MCDE_DOTR0_DODEACT_MASK 0x0000FF00
+#define MCDE_DOTR0_DODEACT(__x) \
+	MCDE_VAL2REG(MCDE_DOTR0, DODEACT, __x)
+#define MCDE_DOTR1 0x00000C88
+#define MCDE_DOTR1_DOACT_SHIFT 0
+#define MCDE_DOTR1_DOACT_MASK 0x000000FF
+#define MCDE_DOTR1_DOACT(__x) \
+	MCDE_VAL2REG(MCDE_DOTR1, DOACT, __x)
+#define MCDE_DOTR1_DODEACT_SHIFT 8
+#define MCDE_DOTR1_DODEACT_MASK 0x0000FF00
+#define MCDE_DOTR1_DODEACT(__x) \
+	MCDE_VAL2REG(MCDE_DOTR1, DODEACT, __x)
+#define MCDE_WCMDC0_V1 0x00000C8C
+#define MCDE_WCMDC0_V1_GROUPOFFSET 0x4
+#define MCDE_WCMDC0_V1_COMMANDVALUE_SHIFT 0
+#define MCDE_WCMDC0_V1_COMMANDVALUE_MASK 0x00FFFFFF
+#define MCDE_WCMDC0_V1_COMMANDVALUE(__x) \
+	MCDE_VAL2REG(MCDE_WCMDC0_V1, COMMANDVALUE, __x)
+#define MCDE_WCMDC1_V1 0x00000C90
+#define MCDE_WCMDC1_V1_COMMANDVALUE_SHIFT 0
+#define MCDE_WCMDC1_V1_COMMANDVALUE_MASK 0x00FFFFFF
+#define MCDE_WCMDC1_V1_COMMANDVALUE(__x) \
+	MCDE_VAL2REG(MCDE_WCMDC1_V1, COMMANDVALUE, __x)
+#define MCDE_WDATADC0 0x00000C94
+#define MCDE_WDATADC0_GROUPOFFSET 0x4
+#define MCDE_WDATADC0_DATAVALUE_SHIFT 0
+#define MCDE_WDATADC0_DATAVALUE_MASK 0x00FFFFFF
+#define MCDE_WDATADC0_DATAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_WDATADC0, DATAVALUE, __x)
+#define MCDE_WDATADC1 0x00000C98
+#define MCDE_WDATADC1_DATAVALUE_SHIFT 0
+#define MCDE_WDATADC1_DATAVALUE_MASK 0x00FFFFFF
+#define MCDE_WDATADC1_DATAVALUE(__x) \
+	MCDE_VAL2REG(MCDE_WDATADC1, DATAVALUE, __x)
+#define MCDE_RDATADC0 0x00000C9C
+#define MCDE_RDATADC0_GROUPOFFSET 0x4
+#define MCDE_RDATADC0_DATAREADFROMDISPLAYMODULE_SHIFT 0
+#define MCDE_RDATADC0_DATAREADFROMDISPLAYMODULE_MASK 0x0000FFFF
+#define MCDE_RDATADC0_DATAREADFROMDISPLAYMODULE(__x) \
+	MCDE_VAL2REG(MCDE_RDATADC0, DATAREADFROMDISPLAYMODULE, __x)
+#define MCDE_RDATADC0_STARTREAD_SHIFT 16
+#define MCDE_RDATADC0_STARTREAD_MASK 0x00010000
+#define MCDE_RDATADC0_STARTREAD(__x) \
+	MCDE_VAL2REG(MCDE_RDATADC0, STARTREAD, __x)
+#define MCDE_RDATADC1 0x00000CA0
+#define MCDE_RDATADC1_DATAREADFROMDISPLAYMODULE_SHIFT 0
+#define MCDE_RDATADC1_DATAREADFROMDISPLAYMODULE_MASK 0x0000FFFF
+#define MCDE_RDATADC1_DATAREADFROMDISPLAYMODULE(__x) \
+	MCDE_VAL2REG(MCDE_RDATADC1, DATAREADFROMDISPLAYMODULE, __x)
+#define MCDE_RDATADC1_STARTREAD_SHIFT 16
+#define MCDE_RDATADC1_STARTREAD_MASK 0x00010000
+#define MCDE_RDATADC1_STARTREAD(__x) \
+	MCDE_VAL2REG(MCDE_RDATADC1, STARTREAD, __x)
+#define MCDE_STATC_V1 0x00000CA4
+#define MCDE_STATC_V1_STATBUSY0_SHIFT 0
+#define MCDE_STATC_V1_STATBUSY0_MASK 0x00000001
+#define MCDE_STATC_V1_STATBUSY0(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, STATBUSY0, __x)
+#define MCDE_STATC_V1_FIFOEMPTY0_SHIFT 1
+#define MCDE_STATC_V1_FIFOEMPTY0_MASK 0x00000002
+#define MCDE_STATC_V1_FIFOEMPTY0(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOEMPTY0, __x)
+#define MCDE_STATC_V1_FIFOFULL0_SHIFT 2
+#define MCDE_STATC_V1_FIFOFULL0_MASK 0x00000004
+#define MCDE_STATC_V1_FIFOFULL0(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOFULL0, __x)
+#define MCDE_STATC_V1_FIFOCMDEMPTY0_SHIFT 3
+#define MCDE_STATC_V1_FIFOCMDEMPTY0_MASK 0x00000008
+#define MCDE_STATC_V1_FIFOCMDEMPTY0(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOCMDEMPTY0, __x)
+#define MCDE_STATC_V1_FIFOCMDFULL0_SHIFT 4
+#define MCDE_STATC_V1_FIFOCMDFULL0_MASK 0x00000010
+#define MCDE_STATC_V1_FIFOCMDFULL0(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOCMDFULL0, __x)
+#define MCDE_STATC_V1_STATBUSY1_SHIFT 5
+#define MCDE_STATC_V1_STATBUSY1_MASK 0x00000020
+#define MCDE_STATC_V1_STATBUSY1(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, STATBUSY1, __x)
+#define MCDE_STATC_V1_FIFOEMPTY1_SHIFT 6
+#define MCDE_STATC_V1_FIFOEMPTY1_MASK 0x00000040
+#define MCDE_STATC_V1_FIFOEMPTY1(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOEMPTY1, __x)
+#define MCDE_STATC_V1_FIFOFULL1_SHIFT 7
+#define MCDE_STATC_V1_FIFOFULL1_MASK 0x00000080
+#define MCDE_STATC_V1_FIFOFULL1(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOFULL1, __x)
+#define MCDE_STATC_V1_FIFOCMDEMPTY1_SHIFT 8
+#define MCDE_STATC_V1_FIFOCMDEMPTY1_MASK 0x00000100
+#define MCDE_STATC_V1_FIFOCMDEMPTY1(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOCMDEMPTY1, __x)
+#define MCDE_STATC_V1_FIFOCMDFULL1_SHIFT 9
+#define MCDE_STATC_V1_FIFOCMDFULL1_MASK 0x00000200
+#define MCDE_STATC_V1_FIFOCMDFULL1(__x) \
+	MCDE_VAL2REG(MCDE_STATC_V1, FIFOCMDFULL1, __x)
+#define MCDE_CTRLC0 0x00000CA8
+#define MCDE_CTRLC0_GROUPOFFSET 0x4
+#define MCDE_CTRLC0_FIFOWTRMRK_SHIFT 0
+#define MCDE_CTRLC0_FIFOWTRMRK_MASK 0x000000FF
+#define MCDE_CTRLC0_FIFOWTRMRK(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FIFOWTRMRK, __x)
+#define MCDE_CTRLC0_FIFOEMPTY_SHIFT 12
+#define MCDE_CTRLC0_FIFOEMPTY_MASK 0x00001000
+#define MCDE_CTRLC0_FIFOEMPTY(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FIFOEMPTY, __x)
+#define MCDE_CTRLC0_FIFOFULL_SHIFT 13
+#define MCDE_CTRLC0_FIFOFULL_MASK 0x00002000
+#define MCDE_CTRLC0_FIFOFULL(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FIFOFULL, __x)
+#define MCDE_CTRLC0_FORMID_SHIFT 16
+#define MCDE_CTRLC0_FORMID_MASK 0x00070000
+#define MCDE_CTRLC0_FORMID_DSI0VID 0
+#define MCDE_CTRLC0_FORMID_DSI0CMD 1
+#define MCDE_CTRLC0_FORMID_DSI1VID 2
+#define MCDE_CTRLC0_FORMID_DSI1CMD 3
+#define MCDE_CTRLC0_FORMID_DSI2VID 4
+#define MCDE_CTRLC0_FORMID_DSI2CMD 5
+#define MCDE_CTRLC0_FORMID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FORMID, MCDE_CTRLC0_FORMID_##__x)
+#define MCDE_CTRLC0_FORMID(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FORMID, __x)
+#define MCDE_CTRLC0_FORMTYPE_SHIFT 20
+#define MCDE_CTRLC0_FORMTYPE_MASK 0x00700000
+#define MCDE_CTRLC0_FORMTYPE_DPITV 0
+#define MCDE_CTRLC0_FORMTYPE_DBI 1
+#define MCDE_CTRLC0_FORMTYPE_DSI 2
+#define MCDE_CTRLC0_FORMTYPE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FORMTYPE, MCDE_CTRLC0_FORMTYPE_##__x)
+#define MCDE_CTRLC0_FORMTYPE(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC0, FORMTYPE, __x)
+#define MCDE_CTRLC1 0x00000CAC
+#define MCDE_CTRLC1_FIFOWTRMRK_SHIFT 0
+#define MCDE_CTRLC1_FIFOWTRMRK_MASK 0x000000FF
+#define MCDE_CTRLC1_FIFOWTRMRK(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FIFOWTRMRK, __x)
+#define MCDE_CTRLC1_FIFOEMPTY_SHIFT 12
+#define MCDE_CTRLC1_FIFOEMPTY_MASK 0x00001000
+#define MCDE_CTRLC1_FIFOEMPTY(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FIFOEMPTY, __x)
+#define MCDE_CTRLC1_FIFOFULL_SHIFT 13
+#define MCDE_CTRLC1_FIFOFULL_MASK 0x00002000
+#define MCDE_CTRLC1_FIFOFULL(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FIFOFULL, __x)
+#define MCDE_CTRLC1_FORMID_SHIFT 16
+#define MCDE_CTRLC1_FORMID_MASK 0x00070000
+#define MCDE_CTRLC1_FORMID_DSI0VID 0
+#define MCDE_CTRLC1_FORMID_DSI0CMD 1
+#define MCDE_CTRLC1_FORMID_DSI1VID 2
+#define MCDE_CTRLC1_FORMID_DSI1CMD 3
+#define MCDE_CTRLC1_FORMID_DSI2VID 4
+#define MCDE_CTRLC1_FORMID_DSI2CMD 5
+#define MCDE_CTRLC1_FORMID_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FORMID, MCDE_CTRLC1_FORMID_##__x)
+#define MCDE_CTRLC1_FORMID(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FORMID, __x)
+#define MCDE_CTRLC1_FORMTYPE_SHIFT 20
+#define MCDE_CTRLC1_FORMTYPE_MASK 0x00700000
+#define MCDE_CTRLC1_FORMTYPE_DPITV 0
+#define MCDE_CTRLC1_FORMTYPE_DBI 1
+#define MCDE_CTRLC1_FORMTYPE_DSI 2
+#define MCDE_CTRLC1_FORMTYPE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FORMTYPE, MCDE_CTRLC1_FORMTYPE_##__x)
+#define MCDE_CTRLC1_FORMTYPE(__x) \
+	MCDE_VAL2REG(MCDE_CTRLC1, FORMTYPE, __x)
+#define MCDE_DSIVID0CONF0 0x00000E00
+#define MCDE_DSIVID0CONF0_GROUPOFFSET 0x20
+#define MCDE_DSIVID0CONF0_BLANKING_SHIFT 0
+#define MCDE_DSIVID0CONF0_BLANKING_MASK 0x000000FF
+#define MCDE_DSIVID0CONF0_BLANKING(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, BLANKING, __x)
+#define MCDE_DSIVID0CONF0_VID_MODE_SHIFT 12
+#define MCDE_DSIVID0CONF0_VID_MODE_MASK 0x00001000
+#define MCDE_DSIVID0CONF0_VID_MODE_CMD 0
+#define MCDE_DSIVID0CONF0_VID_MODE_VID 1
+#define MCDE_DSIVID0CONF0_VID_MODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, VID_MODE, \
+	MCDE_DSIVID0CONF0_VID_MODE_##__x)
+#define MCDE_DSIVID0CONF0_VID_MODE(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, VID_MODE, __x)
+#define MCDE_DSIVID0CONF0_CMD8_SHIFT 13
+#define MCDE_DSIVID0CONF0_CMD8_MASK 0x00002000
+#define MCDE_DSIVID0CONF0_CMD8(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, CMD8, __x)
+#define MCDE_DSIVID0CONF0_BIT_SWAP_SHIFT 16
+#define MCDE_DSIVID0CONF0_BIT_SWAP_MASK 0x00010000
+#define MCDE_DSIVID0CONF0_BIT_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, BIT_SWAP, __x)
+#define MCDE_DSIVID0CONF0_BYTE_SWAP_SHIFT 17
+#define MCDE_DSIVID0CONF0_BYTE_SWAP_MASK 0x00020000
+#define MCDE_DSIVID0CONF0_BYTE_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, BYTE_SWAP, __x)
+#define MCDE_DSIVID0CONF0_DCSVID_NOTGEN_SHIFT 18
+#define MCDE_DSIVID0CONF0_DCSVID_NOTGEN_MASK 0x00040000
+#define MCDE_DSIVID0CONF0_DCSVID_NOTGEN(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, DCSVID_NOTGEN, __x)
+#define MCDE_DSIVID0CONF0_PACKING_SHIFT 20
+#define MCDE_DSIVID0CONF0_PACKING_MASK 0x00700000
+#define MCDE_DSIVID0CONF0_PACKING_RGB565 0
+#define MCDE_DSIVID0CONF0_PACKING_RGB666 1
+#define MCDE_DSIVID0CONF0_PACKING_RGB888 2
+#define MCDE_DSIVID0CONF0_PACKING_BGR888 3
+#define MCDE_DSIVID0CONF0_PACKING_HDTV 7
+#define MCDE_DSIVID0CONF0_PACKING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, PACKING, \
+	MCDE_DSIVID0CONF0_PACKING_##__x)
+#define MCDE_DSIVID0CONF0_PACKING(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CONF0, PACKING, __x)
+#define MCDE_DSICMD0CONF0 0x00000E20
+#define MCDE_DSICMD0CONF0_BLANKING_SHIFT 0
+#define MCDE_DSICMD0CONF0_BLANKING_MASK 0x000000FF
+#define MCDE_DSICMD0CONF0_BLANKING(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, BLANKING, __x)
+#define MCDE_DSICMD0CONF0_VID_MODE_SHIFT 12
+#define MCDE_DSICMD0CONF0_VID_MODE_MASK 0x00001000
+#define MCDE_DSICMD0CONF0_VID_MODE_CMD 0
+#define MCDE_DSICMD0CONF0_VID_MODE_VID 1
+#define MCDE_DSICMD0CONF0_VID_MODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, VID_MODE, \
+	MCDE_DSICMD0CONF0_VID_MODE_##__x)
+#define MCDE_DSICMD0CONF0_VID_MODE(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, VID_MODE, __x)
+#define MCDE_DSICMD0CONF0_CMD8_SHIFT 13
+#define MCDE_DSICMD0CONF0_CMD8_MASK 0x00002000
+#define MCDE_DSICMD0CONF0_CMD8(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, CMD8, __x)
+#define MCDE_DSICMD0CONF0_BIT_SWAP_SHIFT 16
+#define MCDE_DSICMD0CONF0_BIT_SWAP_MASK 0x00010000
+#define MCDE_DSICMD0CONF0_BIT_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, BIT_SWAP, __x)
+#define MCDE_DSICMD0CONF0_BYTE_SWAP_SHIFT 17
+#define MCDE_DSICMD0CONF0_BYTE_SWAP_MASK 0x00020000
+#define MCDE_DSICMD0CONF0_BYTE_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, BYTE_SWAP, __x)
+#define MCDE_DSICMD0CONF0_DCSVID_NOTGEN_SHIFT 18
+#define MCDE_DSICMD0CONF0_DCSVID_NOTGEN_MASK 0x00040000
+#define MCDE_DSICMD0CONF0_DCSVID_NOTGEN(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, DCSVID_NOTGEN, __x)
+#define MCDE_DSICMD0CONF0_PACKING_SHIFT 20
+#define MCDE_DSICMD0CONF0_PACKING_MASK 0x00700000
+#define MCDE_DSICMD0CONF0_PACKING_RGB565 0
+#define MCDE_DSICMD0CONF0_PACKING_RGB666 1
+#define MCDE_DSICMD0CONF0_PACKING_RGB888 2
+#define MCDE_DSICMD0CONF0_PACKING_BGR888 3
+#define MCDE_DSICMD0CONF0_PACKING_HDTV 7
+#define MCDE_DSICMD0CONF0_PACKING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, PACKING, \
+	MCDE_DSICMD0CONF0_PACKING_##__x)
+#define MCDE_DSICMD0CONF0_PACKING(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CONF0, PACKING, __x)
+#define MCDE_DSIVID1CONF0 0x00000E40
+#define MCDE_DSIVID1CONF0_BLANKING_SHIFT 0
+#define MCDE_DSIVID1CONF0_BLANKING_MASK 0x000000FF
+#define MCDE_DSIVID1CONF0_BLANKING(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, BLANKING, __x)
+#define MCDE_DSIVID1CONF0_VID_MODE_SHIFT 12
+#define MCDE_DSIVID1CONF0_VID_MODE_MASK 0x00001000
+#define MCDE_DSIVID1CONF0_VID_MODE_CMD 0
+#define MCDE_DSIVID1CONF0_VID_MODE_VID 1
+#define MCDE_DSIVID1CONF0_VID_MODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, VID_MODE, \
+	MCDE_DSIVID1CONF0_VID_MODE_##__x)
+#define MCDE_DSIVID1CONF0_VID_MODE(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, VID_MODE, __x)
+#define MCDE_DSIVID1CONF0_CMD8_SHIFT 13
+#define MCDE_DSIVID1CONF0_CMD8_MASK 0x00002000
+#define MCDE_DSIVID1CONF0_CMD8(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, CMD8, __x)
+#define MCDE_DSIVID1CONF0_BIT_SWAP_SHIFT 16
+#define MCDE_DSIVID1CONF0_BIT_SWAP_MASK 0x00010000
+#define MCDE_DSIVID1CONF0_BIT_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, BIT_SWAP, __x)
+#define MCDE_DSIVID1CONF0_BYTE_SWAP_SHIFT 17
+#define MCDE_DSIVID1CONF0_BYTE_SWAP_MASK 0x00020000
+#define MCDE_DSIVID1CONF0_BYTE_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, BYTE_SWAP, __x)
+#define MCDE_DSIVID1CONF0_DCSVID_NOTGEN_SHIFT 18
+#define MCDE_DSIVID1CONF0_DCSVID_NOTGEN_MASK 0x00040000
+#define MCDE_DSIVID1CONF0_DCSVID_NOTGEN(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, DCSVID_NOTGEN, __x)
+#define MCDE_DSIVID1CONF0_PACKING_SHIFT 20
+#define MCDE_DSIVID1CONF0_PACKING_MASK 0x00700000
+#define MCDE_DSIVID1CONF0_PACKING_RGB565 0
+#define MCDE_DSIVID1CONF0_PACKING_RGB666 1
+#define MCDE_DSIVID1CONF0_PACKING_RGB888 2
+#define MCDE_DSIVID1CONF0_PACKING_BGR888 3
+#define MCDE_DSIVID1CONF0_PACKING_HDTV 7
+#define MCDE_DSIVID1CONF0_PACKING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, PACKING, \
+	MCDE_DSIVID1CONF0_PACKING_##__x)
+#define MCDE_DSIVID1CONF0_PACKING(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CONF0, PACKING, __x)
+#define MCDE_DSICMD1CONF0 0x00000E60
+#define MCDE_DSICMD1CONF0_BLANKING_SHIFT 0
+#define MCDE_DSICMD1CONF0_BLANKING_MASK 0x000000FF
+#define MCDE_DSICMD1CONF0_BLANKING(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, BLANKING, __x)
+#define MCDE_DSICMD1CONF0_VID_MODE_SHIFT 12
+#define MCDE_DSICMD1CONF0_VID_MODE_MASK 0x00001000
+#define MCDE_DSICMD1CONF0_VID_MODE_CMD 0
+#define MCDE_DSICMD1CONF0_VID_MODE_VID 1
+#define MCDE_DSICMD1CONF0_VID_MODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, VID_MODE, \
+	MCDE_DSICMD1CONF0_VID_MODE_##__x)
+#define MCDE_DSICMD1CONF0_VID_MODE(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, VID_MODE, __x)
+#define MCDE_DSICMD1CONF0_CMD8_SHIFT 13
+#define MCDE_DSICMD1CONF0_CMD8_MASK 0x00002000
+#define MCDE_DSICMD1CONF0_CMD8(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, CMD8, __x)
+#define MCDE_DSICMD1CONF0_BIT_SWAP_SHIFT 16
+#define MCDE_DSICMD1CONF0_BIT_SWAP_MASK 0x00010000
+#define MCDE_DSICMD1CONF0_BIT_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, BIT_SWAP, __x)
+#define MCDE_DSICMD1CONF0_BYTE_SWAP_SHIFT 17
+#define MCDE_DSICMD1CONF0_BYTE_SWAP_MASK 0x00020000
+#define MCDE_DSICMD1CONF0_BYTE_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, BYTE_SWAP, __x)
+#define MCDE_DSICMD1CONF0_DCSVID_NOTGEN_SHIFT 18
+#define MCDE_DSICMD1CONF0_DCSVID_NOTGEN_MASK 0x00040000
+#define MCDE_DSICMD1CONF0_DCSVID_NOTGEN(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, DCSVID_NOTGEN, __x)
+#define MCDE_DSICMD1CONF0_PACKING_SHIFT 20
+#define MCDE_DSICMD1CONF0_PACKING_MASK 0x00700000
+#define MCDE_DSICMD1CONF0_PACKING_RGB565 0
+#define MCDE_DSICMD1CONF0_PACKING_RGB666 1
+#define MCDE_DSICMD1CONF0_PACKING_RGB888 2
+#define MCDE_DSICMD1CONF0_PACKING_BGR888 3
+#define MCDE_DSICMD1CONF0_PACKING_HDTV 7
+#define MCDE_DSICMD1CONF0_PACKING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, PACKING, \
+	MCDE_DSICMD1CONF0_PACKING_##__x)
+#define MCDE_DSICMD1CONF0_PACKING(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CONF0, PACKING, __x)
+#define MCDE_DSIVID2CONF0 0x00000E80
+#define MCDE_DSIVID2CONF0_BLANKING_SHIFT 0
+#define MCDE_DSIVID2CONF0_BLANKING_MASK 0x000000FF
+#define MCDE_DSIVID2CONF0_BLANKING(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, BLANKING, __x)
+#define MCDE_DSIVID2CONF0_VID_MODE_SHIFT 12
+#define MCDE_DSIVID2CONF0_VID_MODE_MASK 0x00001000
+#define MCDE_DSIVID2CONF0_VID_MODE_CMD 0
+#define MCDE_DSIVID2CONF0_VID_MODE_VID 1
+#define MCDE_DSIVID2CONF0_VID_MODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, VID_MODE, \
+	MCDE_DSIVID2CONF0_VID_MODE_##__x)
+#define MCDE_DSIVID2CONF0_VID_MODE(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, VID_MODE, __x)
+#define MCDE_DSIVID2CONF0_CMD8_SHIFT 13
+#define MCDE_DSIVID2CONF0_CMD8_MASK 0x00002000
+#define MCDE_DSIVID2CONF0_CMD8(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, CMD8, __x)
+#define MCDE_DSIVID2CONF0_BIT_SWAP_SHIFT 16
+#define MCDE_DSIVID2CONF0_BIT_SWAP_MASK 0x00010000
+#define MCDE_DSIVID2CONF0_BIT_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, BIT_SWAP, __x)
+#define MCDE_DSIVID2CONF0_BYTE_SWAP_SHIFT 17
+#define MCDE_DSIVID2CONF0_BYTE_SWAP_MASK 0x00020000
+#define MCDE_DSIVID2CONF0_BYTE_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, BYTE_SWAP, __x)
+#define MCDE_DSIVID2CONF0_DCSVID_NOTGEN_SHIFT 18
+#define MCDE_DSIVID2CONF0_DCSVID_NOTGEN_MASK 0x00040000
+#define MCDE_DSIVID2CONF0_DCSVID_NOTGEN(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, DCSVID_NOTGEN, __x)
+#define MCDE_DSIVID2CONF0_PACKING_SHIFT 20
+#define MCDE_DSIVID2CONF0_PACKING_MASK 0x00700000
+#define MCDE_DSIVID2CONF0_PACKING_RGB565 0
+#define MCDE_DSIVID2CONF0_PACKING_RGB666 1
+#define MCDE_DSIVID2CONF0_PACKING_RGB888 2
+#define MCDE_DSIVID2CONF0_PACKING_BGR888 3
+#define MCDE_DSIVID2CONF0_PACKING_HDTV 7
+#define MCDE_DSIVID2CONF0_PACKING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, PACKING, \
+	MCDE_DSIVID2CONF0_PACKING_##__x)
+#define MCDE_DSIVID2CONF0_PACKING(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CONF0, PACKING, __x)
+#define MCDE_DSICMD2CONF0 0x00000EA0
+#define MCDE_DSICMD2CONF0_BLANKING_SHIFT 0
+#define MCDE_DSICMD2CONF0_BLANKING_MASK 0x000000FF
+#define MCDE_DSICMD2CONF0_BLANKING(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, BLANKING, __x)
+#define MCDE_DSICMD2CONF0_VID_MODE_SHIFT 12
+#define MCDE_DSICMD2CONF0_VID_MODE_MASK 0x00001000
+#define MCDE_DSICMD2CONF0_VID_MODE_CMD 0
+#define MCDE_DSICMD2CONF0_VID_MODE_VID 1
+#define MCDE_DSICMD2CONF0_VID_MODE_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, VID_MODE, \
+	MCDE_DSICMD2CONF0_VID_MODE_##__x)
+#define MCDE_DSICMD2CONF0_VID_MODE(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, VID_MODE, __x)
+#define MCDE_DSICMD2CONF0_CMD8_SHIFT 13
+#define MCDE_DSICMD2CONF0_CMD8_MASK 0x00002000
+#define MCDE_DSICMD2CONF0_CMD8(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, CMD8, __x)
+#define MCDE_DSICMD2CONF0_BIT_SWAP_SHIFT 16
+#define MCDE_DSICMD2CONF0_BIT_SWAP_MASK 0x00010000
+#define MCDE_DSICMD2CONF0_BIT_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, BIT_SWAP, __x)
+#define MCDE_DSICMD2CONF0_BYTE_SWAP_SHIFT 17
+#define MCDE_DSICMD2CONF0_BYTE_SWAP_MASK 0x00020000
+#define MCDE_DSICMD2CONF0_BYTE_SWAP(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, BYTE_SWAP, __x)
+#define MCDE_DSICMD2CONF0_DCSVID_NOTGEN_SHIFT 18
+#define MCDE_DSICMD2CONF0_DCSVID_NOTGEN_MASK 0x00040000
+#define MCDE_DSICMD2CONF0_DCSVID_NOTGEN(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, DCSVID_NOTGEN, __x)
+#define MCDE_DSICMD2CONF0_PACKING_SHIFT 20
+#define MCDE_DSICMD2CONF0_PACKING_MASK 0x00700000
+#define MCDE_DSICMD2CONF0_PACKING_RGB565 0
+#define MCDE_DSICMD2CONF0_PACKING_RGB666 1
+#define MCDE_DSICMD2CONF0_PACKING_RGB888 2
+#define MCDE_DSICMD2CONF0_PACKING_BGR888 3
+#define MCDE_DSICMD2CONF0_PACKING_HDTV 7
+#define MCDE_DSICMD2CONF0_PACKING_ENUM(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, PACKING, \
+	MCDE_DSICMD2CONF0_PACKING_##__x)
+#define MCDE_DSICMD2CONF0_PACKING(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CONF0, PACKING, __x)
+#define MCDE_DSIVID0FRAME 0x00000E04
+#define MCDE_DSIVID0FRAME_GROUPOFFSET 0x20
+#define MCDE_DSIVID0FRAME_FRAME_SHIFT 0
+#define MCDE_DSIVID0FRAME_FRAME_MASK 0x00FFFFFF
+#define MCDE_DSIVID0FRAME_FRAME(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0FRAME, FRAME, __x)
+#define MCDE_DSICMD0FRAME 0x00000E24
+#define MCDE_DSICMD0FRAME_FRAME_SHIFT 0
+#define MCDE_DSICMD0FRAME_FRAME_MASK 0x00FFFFFF
+#define MCDE_DSICMD0FRAME_FRAME(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0FRAME, FRAME, __x)
+#define MCDE_DSIVID1FRAME 0x00000E44
+#define MCDE_DSIVID1FRAME_FRAME_SHIFT 0
+#define MCDE_DSIVID1FRAME_FRAME_MASK 0x00FFFFFF
+#define MCDE_DSIVID1FRAME_FRAME(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1FRAME, FRAME, __x)
+#define MCDE_DSICMD1FRAME 0x00000E64
+#define MCDE_DSICMD1FRAME_FRAME_SHIFT 0
+#define MCDE_DSICMD1FRAME_FRAME_MASK 0x00FFFFFF
+#define MCDE_DSICMD1FRAME_FRAME(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1FRAME, FRAME, __x)
+#define MCDE_DSIVID2FRAME 0x00000E84
+#define MCDE_DSIVID2FRAME_FRAME_SHIFT 0
+#define MCDE_DSIVID2FRAME_FRAME_MASK 0x00FFFFFF
+#define MCDE_DSIVID2FRAME_FRAME(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2FRAME, FRAME, __x)
+#define MCDE_DSICMD2FRAME 0x00000EA4
+#define MCDE_DSICMD2FRAME_FRAME_SHIFT 0
+#define MCDE_DSICMD2FRAME_FRAME_MASK 0x00FFFFFF
+#define MCDE_DSICMD2FRAME_FRAME(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2FRAME, FRAME, __x)
+#define MCDE_DSIVID0PKT 0x00000E08
+#define MCDE_DSIVID0PKT_GROUPOFFSET 0x20
+#define MCDE_DSIVID0PKT_PACKET_SHIFT 0
+#define MCDE_DSIVID0PKT_PACKET_MASK 0x0000FFFF
+#define MCDE_DSIVID0PKT_PACKET(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0PKT, PACKET, __x)
+#define MCDE_DSICMD0PKT 0x00000E28
+#define MCDE_DSICMD0PKT_PACKET_SHIFT 0
+#define MCDE_DSICMD0PKT_PACKET_MASK 0x0000FFFF
+#define MCDE_DSICMD0PKT_PACKET(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0PKT, PACKET, __x)
+#define MCDE_DSIVID1PKT 0x00000E48
+#define MCDE_DSIVID1PKT_PACKET_SHIFT 0
+#define MCDE_DSIVID1PKT_PACKET_MASK 0x0000FFFF
+#define MCDE_DSIVID1PKT_PACKET(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1PKT, PACKET, __x)
+#define MCDE_DSICMD1PKT 0x00000E68
+#define MCDE_DSICMD1PKT_PACKET_SHIFT 0
+#define MCDE_DSICMD1PKT_PACKET_MASK 0x0000FFFF
+#define MCDE_DSICMD1PKT_PACKET(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1PKT, PACKET, __x)
+#define MCDE_DSIVID2PKT 0x00000E88
+#define MCDE_DSIVID2PKT_PACKET_SHIFT 0
+#define MCDE_DSIVID2PKT_PACKET_MASK 0x0000FFFF
+#define MCDE_DSIVID2PKT_PACKET(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2PKT, PACKET, __x)
+#define MCDE_DSICMD2PKT 0x00000EA8
+#define MCDE_DSICMD2PKT_PACKET_SHIFT 0
+#define MCDE_DSICMD2PKT_PACKET_MASK 0x0000FFFF
+#define MCDE_DSICMD2PKT_PACKET(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2PKT, PACKET, __x)
+#define MCDE_DSIVID0SYNC 0x00000E0C
+#define MCDE_DSIVID0SYNC_GROUPOFFSET 0x20
+#define MCDE_DSIVID0SYNC_DMA_SHIFT 0
+#define MCDE_DSIVID0SYNC_DMA_MASK 0x00000FFF
+#define MCDE_DSIVID0SYNC_DMA(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0SYNC, DMA, __x)
+#define MCDE_DSIVID0SYNC_SW_SHIFT 16
+#define MCDE_DSIVID0SYNC_SW_MASK 0x0FFF0000
+#define MCDE_DSIVID0SYNC_SW(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0SYNC, SW, __x)
+#define MCDE_DSICMD0SYNC 0x00000E2C
+#define MCDE_DSICMD0SYNC_DMA_SHIFT 0
+#define MCDE_DSICMD0SYNC_DMA_MASK 0x00000FFF
+#define MCDE_DSICMD0SYNC_DMA(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0SYNC, DMA, __x)
+#define MCDE_DSICMD0SYNC_SW_SHIFT 16
+#define MCDE_DSICMD0SYNC_SW_MASK 0x0FFF0000
+#define MCDE_DSICMD0SYNC_SW(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0SYNC, SW, __x)
+#define MCDE_DSIVID1SYNC 0x00000E4C
+#define MCDE_DSIVID1SYNC_DMA_SHIFT 0
+#define MCDE_DSIVID1SYNC_DMA_MASK 0x00000FFF
+#define MCDE_DSIVID1SYNC_DMA(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1SYNC, DMA, __x)
+#define MCDE_DSIVID1SYNC_SW_SHIFT 16
+#define MCDE_DSIVID1SYNC_SW_MASK 0x0FFF0000
+#define MCDE_DSIVID1SYNC_SW(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1SYNC, SW, __x)
+#define MCDE_DSICMD1SYNC 0x00000E6C
+#define MCDE_DSICMD1SYNC_DMA_SHIFT 0
+#define MCDE_DSICMD1SYNC_DMA_MASK 0x00000FFF
+#define MCDE_DSICMD1SYNC_DMA(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1SYNC, DMA, __x)
+#define MCDE_DSICMD1SYNC_SW_SHIFT 16
+#define MCDE_DSICMD1SYNC_SW_MASK 0x0FFF0000
+#define MCDE_DSICMD1SYNC_SW(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1SYNC, SW, __x)
+#define MCDE_DSIVID2SYNC 0x00000E8C
+#define MCDE_DSIVID2SYNC_DMA_SHIFT 0
+#define MCDE_DSIVID2SYNC_DMA_MASK 0x00000FFF
+#define MCDE_DSIVID2SYNC_DMA(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2SYNC, DMA, __x)
+#define MCDE_DSIVID2SYNC_SW_SHIFT 16
+#define MCDE_DSIVID2SYNC_SW_MASK 0x0FFF0000
+#define MCDE_DSIVID2SYNC_SW(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2SYNC, SW, __x)
+#define MCDE_DSICMD2SYNC 0x00000EAC
+#define MCDE_DSICMD2SYNC_DMA_SHIFT 0
+#define MCDE_DSICMD2SYNC_DMA_MASK 0x00000FFF
+#define MCDE_DSICMD2SYNC_DMA(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2SYNC, DMA, __x)
+#define MCDE_DSICMD2SYNC_SW_SHIFT 16
+#define MCDE_DSICMD2SYNC_SW_MASK 0x0FFF0000
+#define MCDE_DSICMD2SYNC_SW(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2SYNC, SW, __x)
+#define MCDE_DSIVID0CMDW 0x00000E10
+#define MCDE_DSIVID0CMDW_GROUPOFFSET 0x20
+#define MCDE_DSIVID0CMDW_CMDW_CONTINUE_SHIFT 0
+#define MCDE_DSIVID0CMDW_CMDW_CONTINUE_MASK 0x0000FFFF
+#define MCDE_DSIVID0CMDW_CMDW_CONTINUE(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CMDW, CMDW_CONTINUE, __x)
+#define MCDE_DSIVID0CMDW_CMDW_START_SHIFT 16
+#define MCDE_DSIVID0CMDW_CMDW_START_MASK 0xFFFF0000
+#define MCDE_DSIVID0CMDW_CMDW_START(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0CMDW, CMDW_START, __x)
+#define MCDE_DSICMD0CMDW 0x00000E30
+#define MCDE_DSICMD0CMDW_CMDW_CONTINUE_SHIFT 0
+#define MCDE_DSICMD0CMDW_CMDW_CONTINUE_MASK 0x0000FFFF
+#define MCDE_DSICMD0CMDW_CMDW_CONTINUE(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CMDW, CMDW_CONTINUE, __x)
+#define MCDE_DSICMD0CMDW_CMDW_START_SHIFT 16
+#define MCDE_DSICMD0CMDW_CMDW_START_MASK 0xFFFF0000
+#define MCDE_DSICMD0CMDW_CMDW_START(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0CMDW, CMDW_START, __x)
+#define MCDE_DSIVID1CMDW 0x00000E50
+#define MCDE_DSIVID1CMDW_CMDW_CONTINUE_SHIFT 0
+#define MCDE_DSIVID1CMDW_CMDW_CONTINUE_MASK 0x0000FFFF
+#define MCDE_DSIVID1CMDW_CMDW_CONTINUE(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CMDW, CMDW_CONTINUE, __x)
+#define MCDE_DSIVID1CMDW_CMDW_START_SHIFT 16
+#define MCDE_DSIVID1CMDW_CMDW_START_MASK 0xFFFF0000
+#define MCDE_DSIVID1CMDW_CMDW_START(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1CMDW, CMDW_START, __x)
+#define MCDE_DSICMD1CMDW 0x00000E70
+#define MCDE_DSICMD1CMDW_CMDW_CONTINUE_SHIFT 0
+#define MCDE_DSICMD1CMDW_CMDW_CONTINUE_MASK 0x0000FFFF
+#define MCDE_DSICMD1CMDW_CMDW_CONTINUE(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CMDW, CMDW_CONTINUE, __x)
+#define MCDE_DSICMD1CMDW_CMDW_START_SHIFT 16
+#define MCDE_DSICMD1CMDW_CMDW_START_MASK 0xFFFF0000
+#define MCDE_DSICMD1CMDW_CMDW_START(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1CMDW, CMDW_START, __x)
+#define MCDE_DSIVID2CMDW 0x00000E90
+#define MCDE_DSIVID2CMDW_CMDW_CONTINUE_SHIFT 0
+#define MCDE_DSIVID2CMDW_CMDW_CONTINUE_MASK 0x0000FFFF
+#define MCDE_DSIVID2CMDW_CMDW_CONTINUE(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CMDW, CMDW_CONTINUE, __x)
+#define MCDE_DSIVID2CMDW_CMDW_START_SHIFT 16
+#define MCDE_DSIVID2CMDW_CMDW_START_MASK 0xFFFF0000
+#define MCDE_DSIVID2CMDW_CMDW_START(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2CMDW, CMDW_START, __x)
+#define MCDE_DSICMD2CMDW 0x00000EB0
+#define MCDE_DSICMD2CMDW_CMDW_CONTINUE_SHIFT 0
+#define MCDE_DSICMD2CMDW_CMDW_CONTINUE_MASK 0x0000FFFF
+#define MCDE_DSICMD2CMDW_CMDW_CONTINUE(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CMDW, CMDW_CONTINUE, __x)
+#define MCDE_DSICMD2CMDW_CMDW_START_SHIFT 16
+#define MCDE_DSICMD2CMDW_CMDW_START_MASK 0xFFFF0000
+#define MCDE_DSICMD2CMDW_CMDW_START(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2CMDW, CMDW_START, __x)
+#define MCDE_DSIVID0DELAY0 0x00000E14
+#define MCDE_DSIVID0DELAY0_GROUPOFFSET 0x20
+#define MCDE_DSIVID0DELAY0_INTPKTDEL_SHIFT 0
+#define MCDE_DSIVID0DELAY0_INTPKTDEL_MASK 0x0000FFFF
+#define MCDE_DSIVID0DELAY0_INTPKTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0DELAY0, INTPKTDEL, __x)
+#define MCDE_DSICMD0DELAY0 0x00000E34
+#define MCDE_DSICMD0DELAY0_INTPKTDEL_SHIFT 0
+#define MCDE_DSICMD0DELAY0_INTPKTDEL_MASK 0x0000FFFF
+#define MCDE_DSICMD0DELAY0_INTPKTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0DELAY0, INTPKTDEL, __x)
+#define MCDE_DSIVID1DELAY0 0x00000E54
+#define MCDE_DSIVID1DELAY0_INTPKTDEL_SHIFT 0
+#define MCDE_DSIVID1DELAY0_INTPKTDEL_MASK 0x0000FFFF
+#define MCDE_DSIVID1DELAY0_INTPKTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1DELAY0, INTPKTDEL, __x)
+#define MCDE_DSICMD1DELAY0 0x00000E74
+#define MCDE_DSICMD1DELAY0_INTPKTDEL_SHIFT 0
+#define MCDE_DSICMD1DELAY0_INTPKTDEL_MASK 0x0000FFFF
+#define MCDE_DSICMD1DELAY0_INTPKTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1DELAY0, INTPKTDEL, __x)
+#define MCDE_DSIVID2DELAY0 0x00000E94
+#define MCDE_DSIVID2DELAY0_INTPKTDEL_SHIFT 0
+#define MCDE_DSIVID2DELAY0_INTPKTDEL_MASK 0x0000FFFF
+#define MCDE_DSIVID2DELAY0_INTPKTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2DELAY0, INTPKTDEL, __x)
+#define MCDE_DSICMD2DELAY0 0x00000EB4
+#define MCDE_DSICMD2DELAY0_INTPKTDEL_SHIFT 0
+#define MCDE_DSICMD2DELAY0_INTPKTDEL_MASK 0x0000FFFF
+#define MCDE_DSICMD2DELAY0_INTPKTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2DELAY0, INTPKTDEL, __x)
+#define MCDE_DSIVID0DELAY1 0x00000E18
+#define MCDE_DSIVID0DELAY1_GROUPOFFSET 0x20
+#define MCDE_DSIVID0DELAY1_TEREQDEL_SHIFT 0
+#define MCDE_DSIVID0DELAY1_TEREQDEL_MASK 0x00000FFF
+#define MCDE_DSIVID0DELAY1_TEREQDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0DELAY1, TEREQDEL, __x)
+#define MCDE_DSIVID0DELAY1_FRAMESTARTDEL_SHIFT 16
+#define MCDE_DSIVID0DELAY1_FRAMESTARTDEL_MASK 0x00FF0000
+#define MCDE_DSIVID0DELAY1_FRAMESTARTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID0DELAY1, FRAMESTARTDEL, __x)
+#define MCDE_DSICMD0DELAY1 0x00000E38
+#define MCDE_DSICMD0DELAY1_TEREQDEL_SHIFT 0
+#define MCDE_DSICMD0DELAY1_TEREQDEL_MASK 0x00000FFF
+#define MCDE_DSICMD0DELAY1_TEREQDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0DELAY1, TEREQDEL, __x)
+#define MCDE_DSICMD0DELAY1_FRAMESTARTDEL_SHIFT 16
+#define MCDE_DSICMD0DELAY1_FRAMESTARTDEL_MASK 0x00FF0000
+#define MCDE_DSICMD0DELAY1_FRAMESTARTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD0DELAY1, FRAMESTARTDEL, __x)
+#define MCDE_DSIVID1DELAY1 0x00000E58
+#define MCDE_DSIVID1DELAY1_TEREQDEL_SHIFT 0
+#define MCDE_DSIVID1DELAY1_TEREQDEL_MASK 0x00000FFF
+#define MCDE_DSIVID1DELAY1_TEREQDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1DELAY1, TEREQDEL, __x)
+#define MCDE_DSIVID1DELAY1_FRAMESTARTDEL_SHIFT 16
+#define MCDE_DSIVID1DELAY1_FRAMESTARTDEL_MASK 0x00FF0000
+#define MCDE_DSIVID1DELAY1_FRAMESTARTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID1DELAY1, FRAMESTARTDEL, __x)
+#define MCDE_DSICMD1DELAY1 0x00000E78
+#define MCDE_DSICMD1DELAY1_TEREQDEL_SHIFT 0
+#define MCDE_DSICMD1DELAY1_TEREQDEL_MASK 0x00000FFF
+#define MCDE_DSICMD1DELAY1_TEREQDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1DELAY1, TEREQDEL, __x)
+#define MCDE_DSICMD1DELAY1_FRAMESTARTDEL_SHIFT 16
+#define MCDE_DSICMD1DELAY1_FRAMESTARTDEL_MASK 0x00FF0000
+#define MCDE_DSICMD1DELAY1_FRAMESTARTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD1DELAY1, FRAMESTARTDEL, __x)
+#define MCDE_DSIVID2DELAY1 0x00000E98
+#define MCDE_DSIVID2DELAY1_TEREQDEL_SHIFT 0
+#define MCDE_DSIVID2DELAY1_TEREQDEL_MASK 0x00000FFF
+#define MCDE_DSIVID2DELAY1_TEREQDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2DELAY1, TEREQDEL, __x)
+#define MCDE_DSIVID2DELAY1_FRAMESTARTDEL_SHIFT 16
+#define MCDE_DSIVID2DELAY1_FRAMESTARTDEL_MASK 0x00FF0000
+#define MCDE_DSIVID2DELAY1_FRAMESTARTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSIVID2DELAY1, FRAMESTARTDEL, __x)
+#define MCDE_DSICMD2DELAY1 0x00000EB8
+#define MCDE_DSICMD2DELAY1_TEREQDEL_SHIFT 0
+#define MCDE_DSICMD2DELAY1_TEREQDEL_MASK 0x00000FFF
+#define MCDE_DSICMD2DELAY1_TEREQDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2DELAY1, TEREQDEL, __x)
+#define MCDE_DSICMD2DELAY1_FRAMESTARTDEL_SHIFT 16
+#define MCDE_DSICMD2DELAY1_FRAMESTARTDEL_MASK 0x00FF0000
+#define MCDE_DSICMD2DELAY1_FRAMESTARTDEL(__x) \
+	MCDE_VAL2REG(MCDE_DSICMD2DELAY1, FRAMESTARTDEL, __x)
diff --git a/include/video/mcde/mcde.h b/include/video/mcde/mcde.h
new file mode 100644
index 0000000..27a3f3f
--- /dev/null
+++ b/include/video/mcde/mcde.h
@@ -0,0 +1,387 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE base driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+#ifndef __MCDE__H__
+#define __MCDE__H__
+
+/* Physical interface types */
+enum mcde_port_type {
+	MCDE_PORTTYPE_DSI = 0,
+	MCDE_PORTTYPE_DPI = 1,
+};
+
+/* Interface mode */
+enum mcde_port_mode {
+	MCDE_PORTMODE_CMD = 0,
+	MCDE_PORTMODE_VID = 1,
+};
+
+/* MCDE fifos */
+enum mcde_fifo {
+	MCDE_FIFO_A  = 0,
+	MCDE_FIFO_B  = 1,
+	MCDE_FIFO_C0 = 2,
+	MCDE_FIFO_C1 = 3,
+};
+
+/* MCDE channels (pixel pipelines) */
+enum mcde_chnl {
+	MCDE_CHNL_A  = 0,
+	MCDE_CHNL_B  = 1,
+	MCDE_CHNL_C0 = 2,
+	MCDE_CHNL_C1 = 3,
+};
+
+/* Channel path */
+#define MCDE_CHNLPATH(__chnl, __fifo, __type, __ifc, __link) \
+	(((__chnl) << 16) | ((__fifo) << 12) | \
+	 ((__type) << 8) | ((__ifc) << 4) | ((__link) << 0))
+enum mcde_chnl_path {
+	/* Channel A */
+	MCDE_CHNLPATH_CHNLA_FIFOA_DPI_0 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DPI, 0, 0),
+	MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC0_0 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 0, 0),
+	MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC0_1 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 0, 1),
+	MCDE_CHNLPATH_CHNLA_FIFOC0_DSI_IFC0_2 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_C0, MCDE_PORTTYPE_DSI, 0, 2),
+	MCDE_CHNLPATH_CHNLA_FIFOC0_DSI_IFC1_0 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_C0, MCDE_PORTTYPE_DSI, 1, 0),
+	MCDE_CHNLPATH_CHNLA_FIFOC0_DSI_IFC1_1 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_C0, MCDE_PORTTYPE_DSI, 1, 1),
+	MCDE_CHNLPATH_CHNLA_FIFOA_DSI_IFC1_2 = MCDE_CHNLPATH(MCDE_CHNL_A,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 1, 2),
+	/* Channel B */
+	MCDE_CHNLPATH_CHNLB_FIFOB_DPI_1 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DPI, 0, 1),
+	MCDE_CHNLPATH_CHNLB_FIFOB_DSI_IFC0_0 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DSI, 0, 0),
+	MCDE_CHNLPATH_CHNLB_FIFOB_DSI_IFC0_1 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DSI, 0, 1),
+	MCDE_CHNLPATH_CHNLB_FIFOC1_DSI_IFC0_2 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_C1, MCDE_PORTTYPE_DSI, 0, 2),
+	MCDE_CHNLPATH_CHNLB_FIFOC1_DSI_IFC1_0 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_C1, MCDE_PORTTYPE_DSI, 1, 0),
+	MCDE_CHNLPATH_CHNLB_FIFOC1_DSI_IFC1_1 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_C1, MCDE_PORTTYPE_DSI, 1, 1),
+	MCDE_CHNLPATH_CHNLB_FIFOB_DSI_IFC1_2 = MCDE_CHNLPATH(MCDE_CHNL_B,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DSI, 1, 2),
+	/* Channel C0 */
+	MCDE_CHNLPATH_CHNLC0_FIFOA_DSI_IFC0_0 = MCDE_CHNLPATH(MCDE_CHNL_C0,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 0, 0),
+	MCDE_CHNLPATH_CHNLC0_FIFOA_DSI_IFC0_1 = MCDE_CHNLPATH(MCDE_CHNL_C0,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 0, 1),
+	MCDE_CHNLPATH_CHNLC0_FIFOC0_DSI_IFC0_2 = MCDE_CHNLPATH(MCDE_CHNL_C0,
+		MCDE_FIFO_C0, MCDE_PORTTYPE_DSI, 0, 2),
+	MCDE_CHNLPATH_CHNLC0_FIFOC0_DSI_IFC1_0 = MCDE_CHNLPATH(MCDE_CHNL_C0,
+		MCDE_FIFO_C0, MCDE_PORTTYPE_DSI, 1, 0),
+	MCDE_CHNLPATH_CHNLC0_FIFOC0_DSI_IFC1_1 = MCDE_CHNLPATH(MCDE_CHNL_C0,
+		MCDE_FIFO_C0, MCDE_PORTTYPE_DSI, 1, 1),
+	MCDE_CHNLPATH_CHNLC0_FIFOA_DSI_IFC1_2 = MCDE_CHNLPATH(MCDE_CHNL_C0,
+		MCDE_FIFO_A, MCDE_PORTTYPE_DSI, 1, 2),
+	/* Channel C1 */
+	MCDE_CHNLPATH_CHNLC1_FIFOB_DSI_IFC0_0 = MCDE_CHNLPATH(MCDE_CHNL_C1,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DSI, 0, 0),
+	MCDE_CHNLPATH_CHNLC1_FIFOB_DSI_IFC0_1 = MCDE_CHNLPATH(MCDE_CHNL_C1,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DSI, 0, 1),
+	MCDE_CHNLPATH_CHNLC1_FIFOC1_DSI_IFC0_2 = MCDE_CHNLPATH(MCDE_CHNL_C1,
+		MCDE_FIFO_C1, MCDE_PORTTYPE_DSI, 0, 2),
+	MCDE_CHNLPATH_CHNLC1_FIFOC1_DSI_IFC1_0 = MCDE_CHNLPATH(MCDE_CHNL_C1,
+		MCDE_FIFO_C1, MCDE_PORTTYPE_DSI, 1, 0),
+	MCDE_CHNLPATH_CHNLC1_FIFOC1_DSI_IFC1_1 = MCDE_CHNLPATH(MCDE_CHNL_C1,
+		MCDE_FIFO_C1, MCDE_PORTTYPE_DSI, 1, 1),
+	MCDE_CHNLPATH_CHNLC1_FIFOB_DSI_IFC1_2 = MCDE_CHNLPATH(MCDE_CHNL_C1,
+		MCDE_FIFO_B, MCDE_PORTTYPE_DSI, 1, 2),
+};
+
+/* Update sync mode */
+enum mcde_sync_src {
+	MCDE_SYNCSRC_OFF = 0, /* No sync */
+	MCDE_SYNCSRC_TE0 = 1, /* MCDE ext TE0 */
+	MCDE_SYNCSRC_TE1 = 2, /* MCDE ext TE1 */
+	MCDE_SYNCSRC_BTA = 3, /* DSI BTA */
+};
+
+/* Interface pixel formats (output) */
+/*
+* REVIEW: Define formats
+* Add explanatory comments how the formats are ordered in memory
+*/
+enum mcde_port_pix_fmt {
+	/* MIPI standard formats */
+
+	MCDE_PORTPIXFMT_DPI_16BPP_C1 =     0x21,
+	MCDE_PORTPIXFMT_DPI_16BPP_C2 =     0x22,
+	MCDE_PORTPIXFMT_DPI_16BPP_C3 =     0x23,
+	MCDE_PORTPIXFMT_DPI_18BPP_C1 =     0x24,
+	MCDE_PORTPIXFMT_DPI_18BPP_C2 =     0x25,
+	MCDE_PORTPIXFMT_DPI_24BPP =        0x26,
+
+	MCDE_PORTPIXFMT_DSI_16BPP =        0x31,
+	MCDE_PORTPIXFMT_DSI_18BPP =        0x32,
+	MCDE_PORTPIXFMT_DSI_18BPP_PACKED = 0x33,
+	MCDE_PORTPIXFMT_DSI_24BPP =        0x34,
+
+	/* Custom formats */
+	MCDE_PORTPIXFMT_DSI_YCBCR422 =     0x40,
+};
+
+struct mcde_col_convert {
+	u16 matrix[3][3];
+	u16 offset[3];
+};
+
+struct mcde_port {
+	enum mcde_port_type type;
+	enum mcde_port_mode mode;
+	enum mcde_port_pix_fmt pixel_format;
+	u8 ifc;
+	u8 link;
+	enum mcde_sync_src sync_src;
+	bool update_auto_trig;
+	union {
+		struct {
+			u8 virt_id;
+			u8 num_data_lanes;
+			u8 ui;
+			bool clk_cont;
+		} dsi;
+		struct {
+			u8 bus_width;
+		} dpi;
+	} phy;
+};
+
+/* Overlay pixel formats (input) *//* REVIEW: Define byte order */
+enum mcde_ovly_pix_fmt {
+	MCDE_OVLYPIXFMT_RGB565   = 1,
+	MCDE_OVLYPIXFMT_RGBA5551 = 2,
+	MCDE_OVLYPIXFMT_RGBA4444 = 3,
+	MCDE_OVLYPIXFMT_RGB888   = 4,
+	MCDE_OVLYPIXFMT_RGBX8888 = 5,
+	MCDE_OVLYPIXFMT_RGBA8888 = 6,
+	MCDE_OVLYPIXFMT_YCbCr422 = 7,/* REVIEW: Capitalize */
+};
+
+/* Display power modes */
+enum mcde_display_power_mode {
+	MCDE_DISPLAY_PM_OFF     = 0, /* Power off */
+	MCDE_DISPLAY_PM_STANDBY = 1, /* DCS sleep mode */
+	MCDE_DISPLAY_PM_ON      = 2, /* DCS normal mode, display on */
+};
+
+/* Display rotation */
+enum mcde_display_rotation {
+	MCDE_DISPLAY_ROT_0       = 0,
+	MCDE_DISPLAY_ROT_90_CCW  = 90,
+	MCDE_DISPLAY_ROT_180_CCW = 180,
+	MCDE_DISPLAY_ROT_270_CCW = 270,
+	MCDE_DISPLAY_ROT_90_CW   = MCDE_DISPLAY_ROT_270_CCW,
+	MCDE_DISPLAY_ROT_180_CW  = MCDE_DISPLAY_ROT_180_CCW,
+	MCDE_DISPLAY_ROT_270_CW  = MCDE_DISPLAY_ROT_90_CCW,
+};
+
+/* REVIEW: Verify */
+#define MCDE_MIN_WIDTH  16
+#define MCDE_MIN_HEIGHT 16
+#define MCDE_MAX_WIDTH  2048
+#define MCDE_MAX_HEIGHT 2048
+#define MCDE_BUF_START_ALIGMENT 8
+#define MCDE_BUF_LINE_ALIGMENT 8
+
+#define MCDE_FIFO_AB_SIZE 640
+#define MCDE_FIFO_C0C1_SIZE 160
+
+#define MCDE_PIXFETCH_LARGE_WTRMRKLVL 128
+#define MCDE_PIXFETCH_MEDIUM_WTRMRKLVL 32
+#define MCDE_PIXFETCH_SMALL_WTRMRKLVL 16
+
+/* Tv-out defines */
+#define MCDE_CONFIG_TVOUT_HBORDER 2
+#define MCDE_CONFIG_TVOUT_VBORDER 2
+#define MCDE_CONFIG_TVOUT_BACKGROUND_LUMINANCE		0x83
+#define MCDE_CONFIG_TVOUT_BACKGROUND_CHROMINANCE_CB	0x9C
+#define MCDE_CONFIG_TVOUT_BACKGROUND_CHROMINANCE_CR	0x2C
+
+/* In seconds */
+#define MCDE_AUTO_SYNC_WATCHDOG 5
+
+/* Hardware versions */
+#define MCDE_CHIP_VERSION_3_0_8 2
+#define MCDE_CHIP_VERSION_3_0_5 1
+#define MCDE_CHIP_VERSION_3	0
+
+/* DSI modes */
+#define DSI_VIDEO_MODE	0
+#define DSI_CMD_MODE	1
+
+/* Video mode descriptor */
+struct mcde_video_mode {/* REVIEW: Join 1 & 2 */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;	/* pixel clock in ps (pico seconds) */
+	u32 hbp;	/* hor back porch = left_margin */
+	u32 hfp;	/* hor front porch equals to right_margin */
+	u32 vbp1;	/* field 1: vert back porch equals to upper_margin */
+	u32 vfp1;	/* field 1: vert front porch equals to lower_margin */
+	u32 vbp2;	/* field 2: vert back porch equals to upper_margin */
+	u32 vfp2;	/* field 2: vert front porch equals to lower_margin */
+	bool interlaced;
+};
+
+struct mcde_rectangle {
+	u16 x;
+	u16 y;
+	u16 w;
+	u16 h;
+};
+
+struct mcde_overlay_info {
+	u32 paddr;
+	u16 stride; /* buffer line len in bytes */
+	enum mcde_ovly_pix_fmt fmt;
+
+	u16 src_x;
+	u16 src_y;
+	u16 dst_x;
+	u16 dst_y;
+	u16 dst_z;
+	u16 w;
+	u16 h;
+	struct mcde_rectangle dirty;
+};
+
+struct mcde_overlay {
+	struct kobject kobj;
+	struct list_head list; /* mcde_display_device.ovlys */
+
+	struct mcde_display_device *ddev;
+	struct mcde_overlay_info info;
+	struct mcde_ovly_state *state;
+};
+
+struct mcde_chnl_state;
+
+struct mcde_chnl_state *mcde_chnl_get(enum mcde_chnl chnl_id,
+			enum mcde_fifo fifo, const struct mcde_port *port);
+int mcde_chnl_set_pixel_format(struct mcde_chnl_state *chnl,
+					enum mcde_port_pix_fmt pix_fmt);
+void mcde_chnl_set_col_convert(struct mcde_chnl_state *chnl,
+					struct mcde_col_convert *col_convert);
+int mcde_chnl_set_video_mode(struct mcde_chnl_state *chnl,
+					struct mcde_video_mode *vmode);
+/* TODO: Remove rotbuf* parameters when ESRAM allocator is implemented*/
+int mcde_chnl_set_rotation(struct mcde_chnl_state *chnl,
+		enum mcde_display_rotation rotation, u32 rotbuf1, u32 rotbuf2);
+int mcde_chnl_enable_synchronized_update(struct mcde_chnl_state *chnl,
+								bool enable);
+int mcde_chnl_set_power_mode(struct mcde_chnl_state *chnl,
+				enum mcde_display_power_mode power_mode);
+
+int mcde_chnl_apply(struct mcde_chnl_state *chnl);
+int mcde_chnl_update(struct mcde_chnl_state *chnl,
+					struct mcde_rectangle *update_area);
+void mcde_chnl_put(struct mcde_chnl_state *chnl);
+
+void mcde_chnl_stop_flow(struct mcde_chnl_state *chnl);
+
+/* MCDE overlay */
+struct mcde_ovly_state;
+
+struct mcde_ovly_state *mcde_ovly_get(struct mcde_chnl_state *chnl);
+void mcde_ovly_set_source_buf(struct mcde_ovly_state *ovly,
+	u32 paddr);
+void mcde_ovly_set_source_info(struct mcde_ovly_state *ovly,
+	u32 stride, enum mcde_ovly_pix_fmt pix_fmt);
+void mcde_ovly_set_source_area(struct mcde_ovly_state *ovly,
+	u16 x, u16 y, u16 w, u16 h);
+void mcde_ovly_set_dest_pos(struct mcde_ovly_state *ovly,
+	u16 x, u16 y, u8 z);
+void mcde_ovly_apply(struct mcde_ovly_state *ovly);
+void mcde_ovly_put(struct mcde_ovly_state *ovly);
+
+/* MCDE dsi */
+
+#define DCS_CMD_ENTER_IDLE_MODE       0x39
+#define DCS_CMD_ENTER_INVERT_MODE     0x21
+#define DCS_CMD_ENTER_NORMAL_MODE     0x13
+#define DCS_CMD_ENTER_PARTIAL_MODE    0x12
+#define DCS_CMD_ENTER_SLEEP_MODE      0x10
+#define DCS_CMD_EXIT_IDLE_MODE        0x38
+#define DCS_CMD_EXIT_INVERT_MODE      0x20
+#define DCS_CMD_EXIT_SLEEP_MODE       0x11
+#define DCS_CMD_GET_ADDRESS_MODE      0x0B
+#define DCS_CMD_GET_BLUE_CHANNEL      0x08
+#define DCS_CMD_GET_DIAGNOSTIC_RESULT 0x0F
+#define DCS_CMD_GET_DISPLAY_MODE      0x0D
+#define DCS_CMD_GET_GREEN_CHANNEL     0x07
+#define DCS_CMD_GET_PIXEL_FORMAT      0x0C
+#define DCS_CMD_GET_POWER_MODE        0x0A
+#define DCS_CMD_GET_RED_CHANNEL       0x06
+#define DCS_CMD_GET_SCANLINE          0x45
+#define DCS_CMD_GET_SIGNAL_MODE       0x0E
+#define DCS_CMD_NOP                   0x00
+#define DCS_CMD_READ_DDB_CONTINUE     0xA8
+#define DCS_CMD_READ_DDB_START        0xA1
+#define DCS_CMD_READ_MEMORY_CONTINE   0x3E
+#define DCS_CMD_READ_MEMORY_START     0x2E
+#define DCS_CMD_SET_ADDRESS_MODE      0x36
+#define DCS_CMD_SET_COLUMN_ADDRESS    0x2A
+#define DCS_CMD_SET_DISPLAY_OFF       0x28
+#define DCS_CMD_SET_DISPLAY_ON        0x29
+#define DCS_CMD_SET_GAMMA_CURVE       0x26
+#define DCS_CMD_SET_PAGE_ADDRESS      0x2B
+#define DCS_CMD_SET_PARTIAL_AREA      0x30
+#define DCS_CMD_SET_PIXEL_FORMAT      0x3A
+#define DCS_CMD_SET_SCROLL_AREA       0x33
+#define DCS_CMD_SET_SCROLL_START      0x37
+#define DCS_CMD_SET_TEAR_OFF          0x34
+#define DCS_CMD_SET_TEAR_ON           0x35
+#define DCS_CMD_SET_TEAR_SCANLINE     0x44
+#define DCS_CMD_SOFT_RESET            0x01
+#define DCS_CMD_WRITE_LUT             0x2D
+#define DCS_CMD_WRITE_CONTINUE        0x3C
+#define DCS_CMD_WRITE_START           0x2C
+
+#define MCDE_MAX_DCS_READ   4
+#define MCDE_MAX_DCS_WRITE 15
+
+int mcde_dsi_dcs_write(struct mcde_chnl_state *chnl, u8 cmd, u8* data, int len);
+int mcde_dsi_dcs_read(struct mcde_chnl_state *chnl, u8 cmd, u8* data, int *len);
+
+/* MCDE */
+
+/* Driver data */
+#define MCDE_IRQ     "MCDE IRQ"
+#define MCDE_IO_AREA "MCDE I/O Area"
+
+struct mcde_platform_data {
+	/* DSI */
+	int num_dsilinks;
+
+	/* DPI */
+	u8 outmux[5]; /* MCDE_CONF0.OUTMUXx */
+	u8 syncmux;   /* MCDE_CONF0.SYNCMUXx */
+
+	const char *regulator_id;
+	const char *clock_dsi_id;
+	const char *clock_dsi_lp_id;
+	const char *clock_mcde_id;
+
+	int (*platform_enable)(void);
+	int (*platform_disable)(void);
+};
+
+int mcde_init(void);
+void mcde_exit(void);
+
+#endif /* __MCDE__H__ */
+
diff --git a/include/video/mcde/mcde_display-generic_dsi.h b/include/video/mcde/mcde_display-generic_dsi.h
new file mode 100644
index 0000000..4879061
--- /dev/null
+++ b/include/video/mcde/mcde_display-generic_dsi.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE generic DCS display driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+#ifndef __MCDE_DISPLAY_GENERIC__H__
+#define __MCDE_DISPLAY_GENERIC__H__
+
+#include <linux/regulator/consumer.h>
+
+#include "mcde_display.h"
+
+struct mcde_display_generic_platform_data {
+	/* Platform info */
+	int reset_gpio;
+	bool reset_high;
+	const char *regulator_id;
+	int reset_delay; /* ms */
+	u32 ddb_id;
+
+	/* Driver data */
+	bool generic_platform_enable;
+	struct regulator *regulator;
+	int max_supply_voltage;
+	int min_supply_voltage;
+};
+
+#endif /* __MCDE_DISPLAY_GENERIC__H__ */
+
diff --git a/include/video/mcde/mcde_display.h b/include/video/mcde/mcde_display.h
new file mode 100644
index 0000000..8dfdbb5
--- /dev/null
+++ b/include/video/mcde/mcde_display.h
@@ -0,0 +1,139 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * ST-Ericsson MCDE display driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+#ifndef __MCDE_DISPLAY__H__
+#define __MCDE_DISPLAY__H__
+
+#include <linux/device.h>
+#include <linux/pm.h>
+
+#include <video/mcde/mcde.h>
+
+#define UPDATE_FLAG_PIXEL_FORMAT	0x1
+#define UPDATE_FLAG_VIDEO_MODE		0x2
+#define UPDATE_FLAG_ROTATION		0x4
+
+#define to_mcde_display_device(__dev) \
+	container_of((__dev), struct mcde_display_device, dev)
+
+struct mcde_display_device {
+	/* MCDE driver static */
+	struct device     dev;
+	const char       *name;
+	int               id;
+	struct mcde_port *port;
+
+	/* MCDE dss driver internal */
+	bool initialized;
+	enum mcde_chnl chnl_id;
+	enum mcde_fifo fifo;
+	bool first_update;
+
+	bool enabled;
+	struct mcde_chnl_state *chnl_state;
+	struct list_head ovlys;
+	struct mcde_rectangle update_area;
+	/* TODO: Remove once ESRAM allocator is done */
+	u32 rotbuf1;
+	u32 rotbuf2;
+
+	/* Display driver internal */
+	u16 native_x_res;
+	u16 native_y_res;
+	u16 physical_width;
+	u16 physical_height;
+	enum mcde_display_power_mode power_mode;
+	enum mcde_ovly_pix_fmt default_pixel_format;
+	enum mcde_ovly_pix_fmt pixel_format;
+	enum mcde_display_rotation rotation;
+	bool synchronized_update;
+	struct mcde_video_mode video_mode;
+	int update_flags;
+
+	/* Driver API */
+	void (*get_native_resolution)(struct mcde_display_device *dev,
+		u16 *x_res, u16 *y_res);
+	enum mcde_ovly_pix_fmt (*get_default_pixel_format)(
+		struct mcde_display_device *dev);
+	void (*get_physical_size)(struct mcde_display_device *dev,
+		u16 *x_size, u16 *y_size);
+
+	int (*set_power_mode)(struct mcde_display_device *dev,
+		enum mcde_display_power_mode power_mode);
+	enum mcde_display_power_mode (*get_power_mode)(
+		struct mcde_display_device *dev);
+
+	int (*try_video_mode)(struct mcde_display_device *dev,
+		struct mcde_video_mode *video_mode);
+	int (*set_video_mode)(struct mcde_display_device *dev,
+		struct mcde_video_mode *video_mode);
+	void (*get_video_mode)(struct mcde_display_device *dev,
+		struct mcde_video_mode *video_mode);
+
+	int (*set_pixel_format)(struct mcde_display_device *dev,
+		enum mcde_ovly_pix_fmt pix_fmt);
+	enum mcde_ovly_pix_fmt (*get_pixel_format)(
+		struct mcde_display_device *dev);
+	enum mcde_port_pix_fmt (*get_port_pixel_format)(
+		struct mcde_display_device *dev);
+
+	int (*set_rotation)(struct mcde_display_device *dev,
+		enum mcde_display_rotation rotation);
+	enum mcde_display_rotation (*get_rotation)(
+		struct mcde_display_device *dev);
+
+	int (*set_synchronized_update)(struct mcde_display_device *dev,
+		bool enable);
+	bool (*get_synchronized_update)(struct mcde_display_device *dev);
+
+	int (*apply_config)(struct mcde_display_device *dev);
+	int (*invalidate_area)(struct mcde_display_device *dev,
+						struct mcde_rectangle *area);
+	int (*update)(struct mcde_display_device *dev);
+	int (*prepare_for_update)(struct mcde_display_device *dev,
+		u16 x, u16 y, u16 w, u16 h);
+	int (*on_first_update)(struct mcde_display_device *dev);
+	int (*platform_enable)(struct mcde_display_device *dev);
+	int (*platform_disable)(struct mcde_display_device *dev);
+};
+
+struct mcde_display_driver {
+	int (*probe)(struct mcde_display_device *dev);
+	int (*remove)(struct mcde_display_device *dev);
+	void (*shutdown)(struct mcde_display_device *dev);
+	int (*suspend)(struct mcde_display_device *dev,
+		pm_message_t state);
+	int (*resume)(struct mcde_display_device *dev);
+
+	struct device_driver driver;
+};
+
+/* MCDE dsi (Used by MCDE display drivers) */
+
+int mcde_display_dsi_dcs_write(struct mcde_display_device *dev,
+	u8 cmd, u8 *data, int len);
+int mcde_display_dsi_dcs_read(struct mcde_display_device *dev,
+	u8 cmd, u8 *data, int *len);
+int mcde_display_dsi_bta_sync(struct mcde_display_device *dev);
+
+/* MCDE display bus */
+
+int mcde_display_driver_register(struct mcde_display_driver *drv);
+void mcde_display_driver_unregister(struct mcde_display_driver *drv);
+int mcde_display_device_register(struct mcde_display_device *dev);
+void mcde_display_device_unregister(struct mcde_display_device *dev);
+
+void mcde_display_init_device(struct mcde_display_device *dev);
+
+int mcde_display_init(void);
+void mcde_display_exit(void);
+
+#endif /* __MCDE_DISPLAY__H__ */
+
diff --git a/include/video/mcde/mcde_dss.h b/include/video/mcde/mcde_dss.h
new file mode 100644
index 0000000..a32b2df
--- /dev/null
+++ b/include/video/mcde/mcde_dss.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright (C) ST-Ericsson AB 2010
+ *
+ * ST-Ericsson MCDE display sub system driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+#ifndef __MCDE_DSS__H__
+#define __MCDE_DSS__H__
+
+#include <linux/kobject.h>
+#include <linux/notifier.h>
+
+#include "mcde.h"
+#include "mcde_display.h"
+
+/* Public MCDE dss (Used by MCDE fb ioctl & MCDE display sysfs) */
+
+int mcde_dss_enable_display(struct mcde_display_device *ddev);
+void mcde_dss_disable_display(struct mcde_display_device *ddev);
+int mcde_dss_apply_channel(struct mcde_display_device *ddev);
+struct mcde_overlay *mcde_dss_create_overlay(struct mcde_display_device *ddev,
+	struct mcde_overlay_info *info);
+void mcde_dss_destroy_overlay(struct mcde_overlay *ovl);
+int mcde_dss_enable_overlay(struct mcde_overlay *ovl);
+void mcde_dss_disable_overlay(struct mcde_overlay *ovl);
+int mcde_dss_apply_overlay(struct mcde_overlay *ovl,
+						struct mcde_overlay_info *info);
+int mcde_dss_update_overlay(struct mcde_overlay *ovl);
+
+void mcde_dss_get_native_resolution(struct mcde_display_device *ddev,
+	u16 *x_res, u16 *y_res);
+enum mcde_ovl_pix_fmt mcde_dss_get_default_color_format(
+	struct mcde_display_device *ddev);
+void mcde_dss_get_physical_size(struct mcde_display_device *ddev,
+	u16 *x_size, u16 *y_size); /* mm */
+
+int mcde_dss_try_video_mode(struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode);
+int mcde_dss_set_video_mode(struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode);
+void mcde_dss_get_video_mode(struct mcde_display_device *ddev,
+	struct mcde_video_mode *video_mode);
+
+int mcde_dss_set_pixel_format(struct mcde_display_device *ddev,
+	enum mcde_ovly_pix_fmt pix_fmt);
+int mcde_dss_get_pixel_format(struct mcde_display_device *ddev);
+
+int mcde_dss_set_rotation(struct mcde_display_device *ddev,
+	enum mcde_display_rotation rotation);
+enum mcde_display_rotation mcde_dss_get_rotation(
+	struct mcde_display_device *ddev);
+
+int mcde_dss_set_synchronized_update(struct mcde_display_device *ddev,
+	bool enable);
+bool mcde_dss_get_synchronized_update(struct mcde_display_device *ddev);
+
+/* MCDE dss events */
+
+/*      A display device and driver has been loaded, probed and bound */
+#define MCDE_DSS_EVENT_DISPLAY_REGISTERED    1
+/*      A display device has been removed */
+#define MCDE_DSS_EVENT_DISPLAY_UNREGISTERED  2
+
+/*      Note! Notifier callback will be called holding the dev sem */
+int mcde_dss_register_notifier(struct notifier_block *nb);
+int mcde_dss_unregister_notifier(struct notifier_block *nb);
+
+/* MCDE dss driver */
+
+int mcde_dss_init(void);
+void mcde_dss_exit(void);
+
+#endif /* __MCDE_DSS__H__ */
+
diff --git a/include/video/mcde/mcde_fb.h b/include/video/mcde/mcde_fb.h
new file mode 100644
index 0000000..8aa3d13
--- /dev/null
+++ b/include/video/mcde/mcde_fb.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) ST-Ericsson AB 2010
+ *
+ * ST-Ericsson MCDE display sub system frame buffer driver
+ *
+ * Author: Marcus Lorentzon <marcus.xm.lorentzon@stericsson.com>
+ * for ST-Ericsson.
+ *
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+#ifndef __MCDE_FB__H__
+#define __MCDE_FB__H__
+
+#include <linux/fb.h>
+#include <linux/ioctl.h>
+#if !defined(__KERNEL__) && !defined(_KERNEL)
+#include <stdint.h>
+#else
+#include <linux/types.h>
+#endif
+
+#ifdef __KERNEL__
+#include "mcde_dss.h"
+#endif
+
+#ifdef __KERNEL__
+#define to_mcde_fb(x) ((struct mcde_fb *)(x)->par)
+
+#define MCDE_FB_MAX_NUM_OVERLAYS 3
+
+struct mcde_fb {
+	int num_ovlys;
+	struct mcde_overlay *ovlys[MCDE_FB_MAX_NUM_OVERLAYS];
+	u32 pseudo_palette[17];
+	enum mcde_ovly_pix_fmt pix_fmt;
+	int id;
+};
+
+/* MCDE fbdev API */
+struct fb_info *mcde_fb_create(struct mcde_display_device *ddev,
+		uint16_t w, uint16_t h, uint16_t vw, uint16_t vh,
+		enum mcde_ovly_pix_fmt pix_fmt,	uint32_t rotate);
+
+int mcde_fb_attach_overlay(struct fb_info *fb_info,
+	struct mcde_overlay *ovl);
+void mcde_fb_destroy(struct fb_info *fb_info);
+
+/* MCDE fb driver */
+int mcde_fb_init(void);
+void mcde_fb_exit(void);
+#endif
+
+#endif /* __MCDE_FB__H__ */
+
-- 
1.6.3.3
