From: Kiran Gunda <kgunda@codeaurora.org>
Date: Thu, 16 Nov 2017 12:30:34 +0000
Subject: [PATCH V1 1/4] qcom: spmi-wled: Add support for qcom wled driver
Message-Id: <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-1-git-send-email-kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

WLED driver provides the interface to the display driver to
adjust the brightness of the display backlight.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/qcom-spmi-wled.txt     |  90 ++++
 drivers/video/backlight/Kconfig                    |   9 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/qcom-spmi-wled.c           | 504 +++++++++++++++++++++
 4 files changed, 604 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
 create mode 100644 drivers/video/backlight/qcom-spmi-wled.c

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
new file mode 100644
index 0000000..f1ea25b
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
@@ -0,0 +1,90 @@
+Binding for Qualcomm WLED driver
+
+WLED (White Light Emitting Diode) driver is used for controlling display
+backlight that is part of PMIC on Qualcomm Technologies reference platforms.
+The PMIC is connected to the host processor via SPMI bus.
+
+- compatible
+	Usage:      required
+	Value type: <string>
+	Definition: should be "qcom,pm8998-spmi-wled".
+
+- reg
+	Usage:      required
+	Value type: <prop-encoded-array>
+	Definition:  Base address and size of the WLED modules.
+
+- reg-names
+	Usage:      required
+	Value type: <string>
+	Definition:  Names associated with base addresses. should be
+		     "qcom-wled-ctrl-base", "qcom-wled-sink-base".
+
+- label
+	Usage:      required
+	Value type: <string>
+	Definition: The name of the backlight device.
+
+- default-brightness
+	Usage:      optional
+	Value type: <u32>
+	Definition: brightness value on boot, value from: 0-4095
+		    default: 2048
+
+- qcom,fs-current-limit
+	Usage:      optional
+	Value type: <u32>
+	Definition: per-string full scale current limit in uA. value from
+		    0 to 30000 with 5000 uA resolution. default: 25000 uA
+
+- qcom,current-boost-limit
+	Usage:      optional
+	Value type: <u32>
+	Definition: ILIM threshold in mA. values are 105, 280, 450, 620, 970,
+		    1150, 1300, 1500. default: 970 mA
+
+- qcom,switching-freq
+	Usage:      optional
+	Value type: <u32>
+	Definition: Switching frequency in KHz. values are
+		    600, 640, 685, 738, 800, 872, 960, 1066, 1200, 1371,
+		    1600, 1920, 2400, 3200, 4800, 9600.
+		    default: 800 KHz
+
+- qcom,ovp
+	Usage:      optional
+	Value type: <u32>
+	Definition: Over-voltage protection limit in mV. values are 31100,
+		    29600, 19600, 18100.
+	            default: 29600 mV
+
+- qcom,string-cfg
+	Usage:      optional
+	Value type: <u32>
+	Definition: Bit mask of the wled strings. Bit 0 to 3 indicates strings
+		    0 to 3 respectively. Wled module has four strings of leds
+		    numbered from 0 to 3. Each string of leds are operated
+		    individually. Specify the strings using the bit mask. Any
+		    combination of led strings can be used.
+		    default value is 15 (b1111).
+
+- qcom,en-cabc
+	Usage:      optional
+	Value type: <bool>
+	Definition: Specify if cabc (content adaptive backlight control) is
+		    needed.
+
+Example:
+
+qcom-wled@d800 {
+	compatible = "qcom,pm8998-spmi-wled";
+	reg = <0xd800 0xd900>;
+	reg-names = "qcom-wled-ctrl-base", "qcom-wled-sink-base";
+	label = "backlight";
+
+	qcom,fs-current-limit = <25000>;
+	qcom,current-boost-limit = <970>;
+	qcom,switching-freq = <800>;
+	qcom,ovp = <29600>;
+	qcom,string-cfg = <15>;
+};
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 4e1d2ad..19ea799 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -306,6 +306,15 @@ config BACKLIGHT_PM8941_WLED
 	  If you have the Qualcomm PM8941, say Y to enable a driver for the
 	  WLED block.
 
+config BACKLIGHT_QCOM_SPMI_WLED
+	tristate "Qualcomm WLED Driver"
+	select REGMAP
+	help
+	  If you have the Qualcomm WLED used for backlight control, say Y to
+	  enable a driver for the  WLED block. This driver provides the
+	  interface to the display driver to adjust the brightness of the
+	  display backlight. This supports PMI8998 currently.
+
 config BACKLIGHT_SAHARA
 	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
 	depends on X86
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 5e28f01..f6627e5 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
 obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
 obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
+obj-$(CONFIG_BACKLIGHT_QCOM_SPMI_WLED)	+= qcom-spmi-wled.o
 obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
 obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
 obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
diff --git a/drivers/video/backlight/qcom-spmi-wled.c b/drivers/video/backlight/qcom-spmi-wled.c
new file mode 100644
index 0000000..14c3adc
--- /dev/null
+++ b/drivers/video/backlight/qcom-spmi-wled.c
@@ -0,0 +1,504 @@
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/backlight.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+
+/* General definitions */
+#define QCOM_WLED_DEFAULT_BRIGHTNESS		2048
+#define  QCOM_WLED_MAX_BRIGHTNESS		4095
+
+/* WLED control registers */
+#define QCOM_WLED_CTRL_MOD_ENABLE		0x46
+#define  QCOM_WLED_CTRL_MOD_EN_MASK		BIT(7)
+#define  QCOM_WLED_CTRL_MODULE_EN_SHIFT		7
+
+#define QCOM_WLED_CTRL_SWITCH_FREQ		0x4c
+#define  QCOM_WLED_CTRL_SWITCH_FREQ_MASK	GENMASK(3, 0)
+
+#define QCOM_WLED_CTRL_OVP			0x4d
+#define  QCOM_WLED_CTRL_OVP_MASK		GENMASK(1, 0)
+
+#define QCOM_WLED_CTRL_ILIM			0x4e
+#define  QCOM_WLED_CTRL_ILIM_MASK		GENMASK(2, 0)
+
+/* WLED sink registers */
+#define QCOM_WLED_SINK_CURR_SINK_EN		0x46
+#define  QCOM_WLED_SINK_CURR_SINK_MASK		GENMASK(7, 4)
+#define  QCOM_WLED_SINK_CURR_SINK_SHFT		0x04
+
+#define QCOM_WLED_SINK_SYNC			0x47
+#define  QCOM_WLED_SINK_SYNC_MASK		GENMASK(3, 0)
+#define  QCOM_WLED_SINK_SYNC_LED1		BIT(0)
+#define  QCOM_WLED_SINK_SYNC_LED2		BIT(1)
+#define  QCOM_WLED_SINK_SYNC_LED3		BIT(2)
+#define  QCOM_WLED_SINK_SYNC_LED4		BIT(3)
+#define  QCOM_WLED_SINK_SYNC_CLEAR		0x00
+
+#define QCOM_WLED_SINK_MOD_EN_REG(n)		(0x50 + (n * 0x10))
+#define  QCOM_WLED_SINK_REG_STR_MOD_MASK	BIT(7)
+#define  QCOM_WLED_SINK_REG_STR_MOD_EN		BIT(7)
+
+#define QCOM_WLED_SINK_SYNC_DLY_REG(n)		(0x51 + (n * 0x10))
+#define QCOM_WLED_SINK_FS_CURR_REG(n)		(0x52 + (n * 0x10))
+#define  QCOM_WLED_SINK_FS_MASK			GENMASK(3, 0)
+
+#define QCOM_WLED_SINK_CABC_REG(n)		(0x56 + (n * 0x10))
+#define  QCOM_WLED_SINK_CABC_MASK		BIT(7)
+#define  QCOM_WLED_SINK_CABC_EN			BIT(7)
+
+#define QCOM_WLED_SINK_BRIGHT_LSB_REG(n)	(0x57 + (n * 0x10))
+#define QCOM_WLED_SINK_BRIGHT_MSB_REG(n)	(0x58 + (n * 0x10))
+
+struct qcom_wled_config {
+	u32 i_boost_limit;
+	u32 ovp;
+	u32 switch_freq;
+	u32 fs_current;
+	u32 string_cfg;
+	bool en_cabc;
+};
+
+struct qcom_wled {
+	const char *name;
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	u16 sink_addr;
+	u16 ctrl_addr;
+	u32 brightness;
+	bool prev_state;
+
+	struct qcom_wled_config cfg;
+};
+
+static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
+{
+	int rc;
+
+	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+			QCOM_WLED_CTRL_MOD_ENABLE, QCOM_WLED_CTRL_MOD_EN_MASK,
+			val << QCOM_WLED_CTRL_MODULE_EN_SHIFT);
+	return rc;
+}
+
+static int qcom_wled_get_brightness(struct backlight_device *bl)
+{
+	struct qcom_wled *wled = bl_get_data(bl);
+
+	return wled->brightness;
+}
+
+static int qcom_wled_sync_toggle(struct qcom_wled *wled)
+{
+	int rc;
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->sink_addr + QCOM_WLED_SINK_SYNC,
+			QCOM_WLED_SINK_SYNC_MASK, QCOM_WLED_SINK_SYNC_MASK);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->sink_addr + QCOM_WLED_SINK_SYNC,
+			QCOM_WLED_SINK_SYNC_MASK, QCOM_WLED_SINK_SYNC_CLEAR);
+
+	return rc;
+}
+
+static int qcom_wled_set_brightness(struct qcom_wled *wled, u16 brightness)
+{
+	int rc, i;
+	u16 low_limit = QCOM_WLED_MAX_BRIGHTNESS * 4 / 1000;
+	u8 string_cfg = wled->cfg.string_cfg;
+	u8 v[2];
+
+	/* WLED's lower limit of operation is 0.4% */
+	if (brightness > 0 && brightness < low_limit)
+		brightness = low_limit;
+
+	v[0] = brightness & 0xff;
+	v[1] = (brightness >> 8) & 0xf;
+
+	for (i = 0; (string_cfg >> i) != 0; i++) {
+		if (string_cfg & BIT(i)) {
+			rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
+					QCOM_WLED_SINK_BRIGHT_LSB_REG(i), v, 2);
+			if (rc < 0)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+static int qcom_wled_update_status(struct backlight_device *bl)
+{
+	struct qcom_wled *wled = bl_get_data(bl);
+	u16 brightness = bl->props.brightness;
+	int rc;
+
+	if (bl->props.power != FB_BLANK_UNBLANK ||
+	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
+	    bl->props.state & BL_CORE_FBBLANK)
+		brightness = 0;
+
+	if (brightness) {
+		rc = qcom_wled_set_brightness(wled, brightness);
+		if (rc < 0) {
+			pr_err("wled failed to set brightness rc:%d\n", rc);
+			return rc;
+		}
+
+		if (!!brightness != wled->prev_state) {
+			rc = qcom_wled_module_enable(wled, !!brightness);
+			if (rc < 0) {
+				pr_err("wled enable failed rc:%d\n", rc);
+				return rc;
+			}
+		}
+	} else {
+		rc = qcom_wled_module_enable(wled, brightness);
+		if (rc < 0) {
+			pr_err("wled disable failed rc:%d\n", rc);
+			return rc;
+		}
+	}
+
+	wled->prev_state = !!brightness;
+
+	rc = qcom_wled_sync_toggle(wled);
+	if (rc < 0) {
+		pr_err("wled sync failed rc:%d\n", rc);
+		return rc;
+	}
+
+	wled->brightness = brightness;
+
+	return rc;
+}
+
+static int qcom_wled_setup(struct qcom_wled *wled)
+{
+	int rc, temp, i;
+	u8 sink_en = 0;
+	u8 string_cfg = wled->cfg.string_cfg;
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_OVP,
+			QCOM_WLED_CTRL_OVP_MASK, wled->cfg.ovp);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_ILIM,
+			QCOM_WLED_CTRL_ILIM_MASK, wled->cfg.i_boost_limit);
+	if (rc < 0)
+		return rc;
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_SWITCH_FREQ,
+			QCOM_WLED_CTRL_SWITCH_FREQ_MASK, wled->cfg.switch_freq);
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; (string_cfg >> i) != 0; i++) {
+		if (string_cfg & BIT(i)) {
+			u16 addr = wled->sink_addr +
+					QCOM_WLED_SINK_MOD_EN_REG(i);
+
+			rc = regmap_update_bits(wled->regmap, addr,
+					QCOM_WLED_SINK_REG_STR_MOD_MASK,
+					QCOM_WLED_SINK_REG_STR_MOD_EN);
+			if (rc < 0)
+				return rc;
+
+			addr = wled->sink_addr +
+					QCOM_WLED_SINK_FS_CURR_REG(i);
+			rc = regmap_update_bits(wled->regmap, addr,
+					QCOM_WLED_SINK_FS_MASK,
+					wled->cfg.fs_current);
+			if (rc < 0)
+				return rc;
+
+			addr = wled->sink_addr +
+					QCOM_WLED_SINK_CABC_REG(i);
+			rc = regmap_update_bits(wled->regmap, addr,
+					QCOM_WLED_SINK_CABC_MASK,
+					wled->cfg.en_cabc ?
+					QCOM_WLED_SINK_CABC_EN : 0);
+			if (rc)
+				return rc;
+
+			temp = i + QCOM_WLED_SINK_CURR_SINK_SHFT;
+			sink_en |= 1 << temp;
+		}
+	}
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->sink_addr + QCOM_WLED_SINK_CURR_SINK_EN,
+			QCOM_WLED_SINK_CURR_SINK_MASK, sink_en);
+	if (rc < 0)
+		return rc;
+
+	rc = qcom_wled_sync_toggle(wled);
+	if (rc < 0) {
+		pr_err("Failed to toggle sync reg rc:%d\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static const struct qcom_wled_config wled_config_defaults = {
+	.i_boost_limit = 4,
+	.fs_current = 10,
+	.ovp = 1,
+	.switch_freq = 11,
+	.string_cfg = 0xf,
+	.en_cabc = 0,
+};
+
+struct qcom_wled_var_cfg {
+	const u32 *values;
+	u32 (*fn)(u32);
+	int size;
+};
+
+static const u32 wled_i_boost_limit_values[] = {
+	105, 280, 450, 620, 970, 1150, 1300, 1500,
+};
+
+static const struct qcom_wled_var_cfg wled_i_boost_limit_cfg = {
+	.values = wled_i_boost_limit_values,
+	.size = ARRAY_SIZE(wled_i_boost_limit_values),
+};
+
+static const u32 wled_fs_current_values[] = {
+	0, 2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000,
+	22500, 25000, 27500, 30000,
+};
+
+static const struct qcom_wled_var_cfg wled_fs_current_cfg = {
+	.values = wled_fs_current_values,
+	.size = ARRAY_SIZE(wled_fs_current_values),
+};
+
+static const u32 wled_ovp_values[] = {
+	31100, 29600, 19600, 18100,
+};
+
+static const struct qcom_wled_var_cfg wled_ovp_cfg = {
+	.values = wled_ovp_values,
+	.size = ARRAY_SIZE(wled_ovp_values),
+};
+
+static u32 qcom_wled_switch_freq_values_fn(u32 idx)
+{
+	return 19200 / (2 * (1 + idx));
+}
+
+static const struct qcom_wled_var_cfg wled_switch_freq_cfg = {
+	.fn = qcom_wled_switch_freq_values_fn,
+	.size = 16,
+};
+
+static const struct qcom_wled_var_cfg wled_string_cfg = {
+	.size = 16,
+};
+
+static u32 qcom_wled_values(const struct qcom_wled_var_cfg *cfg, u32 idx)
+{
+	if (idx >= cfg->size)
+		return UINT_MAX;
+	if (cfg->fn)
+		return cfg->fn(idx);
+	if (cfg->values)
+		return cfg->values[idx];
+	return idx;
+}
+
+static int qcom_wled_configure(struct qcom_wled *wled, struct device *dev)
+{
+	struct qcom_wled_config *cfg = &wled->cfg;
+	const __be32 *prop_addr;
+	u32 val, c;
+	int rc, i, j;
+
+	const struct {
+		const char *name;
+		u32 *val_ptr;
+		const struct qcom_wled_var_cfg *cfg;
+	} u32_opts[] = {
+		{
+			"qcom,current-boost-limit",
+			&cfg->i_boost_limit,
+			.cfg = &wled_i_boost_limit_cfg,
+		},
+		{
+			"qcom,fs-current-limit",
+			&cfg->fs_current,
+			.cfg = &wled_fs_current_cfg,
+		},
+		{
+			"qcom,ovp",
+			&cfg->ovp,
+			.cfg = &wled_ovp_cfg,
+		},
+		{
+			"qcom,switching-freq",
+			&cfg->switch_freq,
+			.cfg = &wled_switch_freq_cfg,
+		},
+		{
+			"qcom,string-cfg",
+			&cfg->string_cfg,
+			.cfg = &wled_string_cfg,
+		},
+	};
+
+	const struct {
+		const char *name;
+		bool *val_ptr;
+	} bool_opts[] = {
+		{ "qcom,en-cabc", &cfg->en_cabc, },
+	};
+
+	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
+	if (!prop_addr) {
+		pr_err("invalid IO resources\n");
+		return -EINVAL;
+	}
+	wled->ctrl_addr = be32_to_cpu(*prop_addr);
+
+	prop_addr = of_get_address(dev->of_node, 1, NULL, NULL);
+	if (!prop_addr) {
+		pr_err("invalid IO resources\n");
+		return -EINVAL;
+	}
+	wled->sink_addr = be32_to_cpu(*prop_addr);
+	rc = of_property_read_string(dev->of_node, "label", &wled->name);
+	if (rc < 0)
+		wled->name = dev->of_node->name;
+
+	*cfg = wled_config_defaults;
+	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
+		rc = of_property_read_u32(dev->of_node, u32_opts[i].name, &val);
+		if (rc = -EINVAL) {
+			continue;
+		} else if (rc < 0) {
+			pr_err("error reading '%s'\n", u32_opts[i].name);
+			return rc;
+		}
+
+		c = UINT_MAX;
+		for (j = 0; c != val; j++) {
+			c = qcom_wled_values(u32_opts[i].cfg, j);
+			if (c = UINT_MAX) {
+				pr_err("invalid value for '%s'\n",
+					u32_opts[i].name);
+				return -EINVAL;
+			}
+
+			if (c = val)
+				break;
+		}
+
+		pr_debug("'%s' = %u\n", u32_opts[i].name, c);
+		*u32_opts[i].val_ptr = j;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(bool_opts); ++i) {
+		if (of_property_read_bool(dev->of_node, bool_opts[i].name))
+			*bool_opts[i].val_ptr = true;
+	}
+
+	return 0;
+}
+
+static const struct backlight_ops qcom_wled_ops = {
+	.update_status = qcom_wled_update_status,
+	.get_brightness = qcom_wled_get_brightness,
+};
+
+static int qcom_wled_probe(struct platform_device *pdev)
+{
+	struct backlight_properties props;
+	struct backlight_device *bl;
+	struct qcom_wled *wled;
+	struct regmap *regmap;
+	u32 val;
+	int rc;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		pr_err("Unable to get regmap\n");
+		return -EINVAL;
+	}
+
+	wled = devm_kzalloc(&pdev->dev, sizeof(*wled), GFP_KERNEL);
+	if (!wled)
+		return -ENOMEM;
+
+	wled->regmap = regmap;
+	wled->pdev = pdev;
+
+	rc = qcom_wled_configure(wled, &pdev->dev);
+	if (rc < 0) {
+		pr_err("wled configure failed rc:%d\n", rc);
+		return rc;
+	}
+
+	rc = qcom_wled_setup(wled);
+	if (rc < 0) {
+		pr_err("wled setup failed rc:%d\n", rc);
+		return rc;
+	}
+
+	val = QCOM_WLED_DEFAULT_BRIGHTNESS;
+	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
+	wled->brightness = val;
+
+	platform_set_drvdata(pdev, wled);
+
+	memset(&props, 0, sizeof(struct backlight_properties));
+	props.type = BACKLIGHT_RAW;
+	props.brightness = val;
+	props.max_brightness = QCOM_WLED_MAX_BRIGHTNESS;
+	bl = devm_backlight_device_register(&pdev->dev, pdev->name,
+					    &pdev->dev, wled,
+					    &qcom_wled_ops, &props);
+	return PTR_ERR_OR_ZERO(bl);
+}
+
+static const struct of_device_id qcom_wled_match_table[] = {
+	{ .compatible = "qcom,pm8998-spmi-wled",},
+	{ },
+};
+
+static struct platform_driver qcom_wled_driver = {
+	.probe = qcom_wled_probe,
+	.driver	= {
+		.name = "qcom-spmi-wled",
+		.of_match_table	= qcom_wled_match_table,
+	},
+};
+
+module_platform_driver(qcom_wled_driver);
+
+MODULE_DESCRIPTION("Qualcomm SPMI PMIC WLED driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

