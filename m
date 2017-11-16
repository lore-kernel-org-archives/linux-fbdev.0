From: Kiran Gunda <kgunda@codeaurora.org>
Date: Thu, 16 Nov 2017 12:30:37 +0000
Subject: [PATCH V1 4/4] qcom: spmi-wled: Add auto-calibration logic support
Message-Id: <1510834717-21765-5-git-send-email-kgunda@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-1-git-send-email-kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

The auto-calibration algorithm checks if the current WLED sink
configuration is valid. It tries enabling every sink and checks
if the OVP fault is observed. Based on this information it
detects and enables the valid sink configuration. Auto calibration
will be triggered when the OVP fault interrupts are seen frequently
thereby it tries to fix the sink configuration.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/qcom-spmi-wled.txt     |   5 +
 drivers/video/backlight/qcom-spmi-wled.c           | 304 ++++++++++++++++++++-
 2 files changed, 306 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
index d39ee93..f06c0cd 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
@@ -94,6 +94,11 @@ The PMIC is connected to the host processor via SPMI bus.
 	Definition: Interrupt names associated with the interrupts.
 		    Currently supported interrupts are "sc-irq" and "ovp-irq".
 
+- qcom,auto-calibration
+	Usage:      optional
+	Value type: <bool>
+	Definition: Enables auto-calibration of the WLED sink configuration.
+
 Example:
 
 qcom-wled@d800 {
diff --git a/drivers/video/backlight/qcom-spmi-wled.c b/drivers/video/backlight/qcom-spmi-wled.c
index 8b2a77a..aee5c56 100644
--- a/drivers/video/backlight/qcom-spmi-wled.c
+++ b/drivers/video/backlight/qcom-spmi-wled.c
@@ -38,11 +38,14 @@
 #define  QCOM_WLED_CTRL_SC_FAULT_BIT		BIT(2)
 
 #define QCOM_WLED_CTRL_INT_RT_STS		0x10
+#define  QCOM_WLED_CTRL_OVP_FLT_RT_STS_BIT	BIT(1)
 
 #define QCOM_WLED_CTRL_MOD_ENABLE		0x46
 #define  QCOM_WLED_CTRL_MOD_EN_MASK		BIT(7)
 #define  QCOM_WLED_CTRL_MODULE_EN_SHIFT		7
 
+#define QCOM_WLED_CTRL_FDBK_OP			0x48
+
 #define QCOM_WLED_CTRL_SWITCH_FREQ		0x4c
 #define  QCOM_WLED_CTRL_SWITCH_FREQ_MASK	GENMASK(3, 0)
 
@@ -99,6 +102,7 @@ struct qcom_wled_config {
 	int ovp_irq;
 	bool en_cabc;
 	bool ext_pfet_sc_pro_en;
+	bool auto_calib_enabled;
 };
 
 struct qcom_wled {
@@ -108,18 +112,25 @@ struct qcom_wled {
 	struct mutex lock;
 	struct qcom_wled_config cfg;
 	ktime_t last_sc_event_time;
+	ktime_t start_ovp_fault_time;
 	u16 sink_addr;
 	u16 ctrl_addr;
+	u16 auto_calibration_ovp_count;
 	u32 brightness;
 	u32 sc_count;
 	bool prev_state;
 	bool ovp_irq_disabled;
+	bool auto_calib_done;
+	bool force_mod_disable;
 };
 
 static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
 {
 	int rc;
 
+	if (wled->force_mod_disable)
+		return 0;
+
 	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
 			QCOM_WLED_CTRL_MOD_ENABLE, QCOM_WLED_CTRL_MOD_EN_MASK,
 			val << QCOM_WLED_CTRL_MODULE_EN_SHIFT);
@@ -187,12 +198,10 @@ static int qcom_wled_set_brightness(struct qcom_wled *wled, u16 brightness)
 	v[1] = (brightness >> 8) & 0xf;
 
 	for (i = 0; (string_cfg >> i) != 0; i++) {
-		if (string_cfg & BIT(i)) {
 			rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
 					QCOM_WLED_SINK_BRIGHT_LSB_REG(i), v, 2);
 			if (rc < 0)
 				return rc;
-		}
 	}
 
 	return 0;
@@ -294,6 +303,262 @@ static irqreturn_t qcom_wled_sc_irq_handler(int irq, void *_wled)
 	return IRQ_HANDLED;
 }
 
+#define AUTO_CALIB_BRIGHTNESS		200
+static int qcom_wled_auto_calibrate(struct qcom_wled *wled)
+{
+	int rc = 0, i;
+	u32 sink_config = 0, int_sts;
+	u8 reg = 0, sink_test = 0, sink_valid = 0;
+	u8 string_cfg = wled->cfg.string_cfg;
+
+	/* read configured sink configuration */
+	rc = regmap_read(wled->regmap, wled->sink_addr +
+			QCOM_WLED_SINK_CURR_SINK_EN, &sink_config);
+	if (rc < 0) {
+		pr_err("Failed to read SINK configuration rc=%d\n", rc);
+		goto failed_calib;
+	}
+
+	/* disable the module before starting calibration */
+	rc = regmap_update_bits(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_MOD_ENABLE,
+			QCOM_WLED_CTRL_MOD_EN_MASK, 0);
+	if (rc < 0) {
+		pr_err("Failed to disable WLED module rc=%d\n",	rc);
+		goto failed_calib;
+	}
+
+	/* set low brightness across all sinks */
+	rc = qcom_wled_set_brightness(wled, AUTO_CALIB_BRIGHTNESS);
+	if (rc < 0) {
+		pr_err("Failed to set brightness for calibration rc=%d\n", rc);
+		goto failed_calib;
+	}
+
+	if (wled->cfg.en_cabc) {
+		for (i = 0; (string_cfg >> i) != 0; i++) {
+			reg = 0;
+			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
+					QCOM_WLED_SINK_CABC_REG(i),
+					QCOM_WLED_SINK_CABC_MASK, reg);
+			if (rc < 0)
+				goto failed_calib;
+		}
+	}
+
+	/* disable all sinks */
+	rc = regmap_write(wled->regmap,
+			wled->sink_addr + QCOM_WLED_SINK_CURR_SINK_EN, 0);
+	if (rc < 0) {
+		pr_err("Failed to disable all sinks rc=%d\n", rc);
+		goto failed_calib;
+	}
+
+	/* iterate through the strings one by one */
+	for (i = 0; (string_cfg >> i) != 0; i++) {
+		sink_test = 1 << (QCOM_WLED_SINK_CURR_SINK_SHFT + i);
+
+		/* Enable feedback control */
+		rc = regmap_write(wled->regmap, wled->ctrl_addr +
+				QCOM_WLED_CTRL_FDBK_OP, i + 1);
+		if (rc < 0) {
+			pr_err("Failed to enable feedback for SINK %d rc = %d\n",
+				i + 1, rc);
+			goto failed_calib;
+		}
+
+		/* enable the sink */
+		rc = regmap_write(wled->regmap, wled->sink_addr +
+				QCOM_WLED_SINK_CURR_SINK_EN, sink_test);
+		if (rc < 0) {
+			pr_err("Failed to configure SINK %d rc=%d\n",
+						i + 1, rc);
+			goto failed_calib;
+		}
+
+		/* Enable the module */
+		rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
+				QCOM_WLED_CTRL_MOD_ENABLE,
+				QCOM_WLED_CTRL_MOD_EN_MASK,
+				QCOM_WLED_CTRL_MOD_EN_MASK);
+		if (rc < 0) {
+			pr_err("Failed to enable WLED module rc=%d\n", rc);
+			goto failed_calib;
+		}
+
+		usleep_range(QCOM_WLED_SOFT_START_DLY_US,
+				QCOM_WLED_SOFT_START_DLY_US + 1000);
+
+		rc = regmap_read(wled->regmap, wled->ctrl_addr +
+				QCOM_WLED_CTRL_INT_RT_STS, &int_sts);
+		if (rc < 0) {
+			pr_err("Error in reading WLED_INT_RT_STS rc=%d\n", rc);
+			goto failed_calib;
+		}
+
+		if (int_sts & QCOM_WLED_CTRL_OVP_FAULT_BIT)
+			pr_debug("WLED OVP fault detected with SINK %d\n",
+						i + 1);
+		else
+			sink_valid |= sink_test;
+
+		/* Disable the module */
+		rc = regmap_update_bits(wled->regmap,
+				wled->ctrl_addr + QCOM_WLED_CTRL_MOD_ENABLE,
+				QCOM_WLED_CTRL_MOD_EN_MASK, 0);
+		if (rc < 0) {
+			pr_err("Failed to disable WLED module rc=%d\n", rc);
+			goto failed_calib;
+		}
+	}
+
+	if (sink_valid = sink_config) {
+		pr_debug("WLED auto-calibration complete, default sink-config=%x OK!\n",
+						sink_config);
+	} else {
+		pr_warn("Invalid WLED default sink config=%x changing it to=%x\n",
+						sink_config, sink_valid);
+		sink_config = sink_valid;
+	}
+
+	if (!sink_config) {
+		pr_warn("No valid WLED sinks found\n");
+		wled->force_mod_disable = true;
+		goto failed_calib;
+	}
+
+	/* write the new sink configuration */
+	rc = regmap_write(wled->regmap,
+			wled->sink_addr + QCOM_WLED_SINK_CURR_SINK_EN,
+			sink_config);
+	if (rc < 0) {
+		pr_err("Failed to reconfigure the default sink rc=%d\n", rc);
+		goto failed_calib;
+	}
+
+	/* MODULATOR_EN setting for valid sinks */
+	for (i = 0; (string_cfg >> i) != 0; i++) {
+		if (wled->cfg.en_cabc) {
+			reg = QCOM_WLED_SINK_CABC_EN;
+			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
+					QCOM_WLED_SINK_CABC_REG(i),
+					QCOM_WLED_SINK_CABC_MASK, reg);
+			if (rc < 0)
+				goto failed_calib;
+		}
+
+		if (sink_config & (1 << (QCOM_WLED_SINK_CURR_SINK_SHFT + i)))
+			reg = QCOM_WLED_SINK_REG_STR_MOD_EN;
+		else
+			reg = 0x0; /* disable modulator_en for unused sink */
+
+		rc = regmap_write(wled->regmap, wled->sink_addr +
+				QCOM_WLED_SINK_MOD_EN_REG(i), reg);
+		if (rc < 0) {
+			pr_err("Failed to configure MODULATOR_EN rc=%d\n", rc);
+			goto failed_calib;
+		}
+	}
+
+	/* restore the feedback setting */
+	rc = regmap_write(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_FDBK_OP, 0);
+	if (rc < 0) {
+		pr_err("Failed to restore feedback setting rc=%d\n", rc);
+		goto failed_calib;
+	}
+
+	/* restore  brightness */
+	rc = qcom_wled_set_brightness(wled, wled->brightness);
+	if (rc < 0) {
+		pr_err("Failed to set brightness after calibration rc=%d\n",
+			rc);
+		goto failed_calib;
+	}
+
+	rc = regmap_update_bits(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_MOD_ENABLE,
+			QCOM_WLED_CTRL_MOD_EN_MASK,
+			QCOM_WLED_CTRL_MOD_EN_MASK);
+	if (rc < 0) {
+		pr_err("Failed to enable WLED module rc=%d\n", rc);
+		goto failed_calib;
+	}
+
+	/* delay for WLED soft-start */
+	usleep_range(QCOM_WLED_SOFT_START_DLY_US,
+			QCOM_WLED_SOFT_START_DLY_US + 1000);
+
+failed_calib:
+	return rc;
+}
+
+#define WLED_AUTO_CAL_OVP_COUNT		5
+#define WLED_AUTO_CAL_CNT_DLY_US	1000000	/* 1 second */
+static bool qcom_wled_auto_cal_required(struct qcom_wled *wled)
+{
+	s64 elapsed_time_us;
+
+	/*
+	 * Check if the OVP fault was an occasional one
+	 * or if its firing continuously, the latter qualifies
+	 * for an auto-calibration check.
+	 */
+	if (!wled->auto_calibration_ovp_count) {
+		wled->start_ovp_fault_time = ktime_get();
+		wled->auto_calibration_ovp_count++;
+	} else {
+		elapsed_time_us = ktime_us_delta(ktime_get(),
+				wled->start_ovp_fault_time);
+		if (elapsed_time_us > WLED_AUTO_CAL_CNT_DLY_US)
+			wled->auto_calibration_ovp_count = 0;
+		else
+			wled->auto_calibration_ovp_count++;
+
+		if (wled->auto_calibration_ovp_count >+				WLED_AUTO_CAL_OVP_COUNT) {
+			wled->auto_calibration_ovp_count = 0;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static int qcom_wled_auto_calibrate_at_init(struct qcom_wled *wled)
+{
+	int rc;
+	u32 fault_status = 0, rt_status = 0;
+
+	if (!wled->cfg.auto_calib_enabled)
+		return 0;
+
+	rc = regmap_read(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_INT_RT_STS,
+			&rt_status);
+	if (rc < 0)
+		pr_err("Failed to read RT status rc=%d\n", rc);
+
+	rc = regmap_read(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_FAULT_STATUS,
+			&fault_status);
+	if (rc < 0)
+		pr_err("Failed to read fault status rc=%d\n", rc);
+
+	if ((rt_status & QCOM_WLED_CTRL_OVP_FLT_RT_STS_BIT) ||
+			(fault_status & QCOM_WLED_CTRL_OVP_FAULT_BIT)) {
+		mutex_lock(&wled->lock);
+		rc = qcom_wled_auto_calibrate(wled);
+		if (rc < 0)
+			pr_err("Failed auto-calibration rc=%d\n", rc);
+		else
+			wled->auto_calib_done = true;
+		mutex_unlock(&wled->lock);
+	}
+
+	return rc;
+}
+
 static irqreturn_t qcom_wled_ovp_irq_handler(int irq, void *_wled)
 {
 	struct qcom_wled *wled = _wled;
@@ -319,6 +584,33 @@ static irqreturn_t qcom_wled_ovp_irq_handler(int irq, void *_wled)
 		pr_err("WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
 			int_sts, fault_sts);
 
+	if (fault_sts & QCOM_WLED_CTRL_OVP_FAULT_BIT) {
+		if (wled->cfg.auto_calib_enabled && !wled->auto_calib_done) {
+			if (qcom_wled_auto_cal_required(wled)) {
+				mutex_lock(&wled->lock);
+				if (wled->cfg.ovp_irq > 0 &&
+						!wled->ovp_irq_disabled) {
+					disable_irq_nosync(wled->cfg.ovp_irq);
+					wled->ovp_irq_disabled = true;
+				}
+
+				rc = qcom_wled_auto_calibrate(wled);
+				if (rc < 0)
+					pr_err("Failed auto-calibration rc=%d\n",
+						rc);
+				else
+					wled->auto_calib_done = true;
+
+				if (wled->cfg.ovp_irq > 0 &&
+						wled->ovp_irq_disabled) {
+					enable_irq(wled->cfg.ovp_irq);
+					wled->ovp_irq_disabled = false;
+				}
+				mutex_unlock(&wled->lock);
+			}
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -394,6 +686,10 @@ static int qcom_wled_setup(struct qcom_wled *wled)
 		return rc;
 	}
 
+	rc = qcom_wled_auto_calibrate_at_init(wled);
+	if (rc < 0)
+		pr_err("Failed to auto-calibrate at init rc=%d\n", rc);
+
 	if (sc_irq >= 0) {
 		rc = devm_request_threaded_irq(&wled->pdev->dev, sc_irq,
 				NULL, qcom_wled_sc_irq_handler, IRQF_ONESHOT,
@@ -432,7 +728,7 @@ static int qcom_wled_setup(struct qcom_wled *wled)
 				NULL, qcom_wled_ovp_irq_handler, IRQF_ONESHOT,
 				"qcom_wled_ovp_irq", wled);
 		if (rc < 0) {
-			dev_err(&wled->pdev->dev, "Unable to request ovp(%d) IRQ(err:%d)\n",
+			pr_err("Unable to request ovp(%d) IRQ(err:%d)\n",
 				ovp_irq, rc);
 			return rc;
 		}
@@ -457,6 +753,7 @@ static int qcom_wled_setup(struct qcom_wled *wled)
 	.string_cfg = 0xf,
 	.en_cabc = 0,
 	.ext_pfet_sc_pro_en = 1,
+	.auto_calib_enabled = 1,
 };
 
 struct qcom_wled_var_cfg {
@@ -563,6 +860,7 @@ static int qcom_wled_configure(struct qcom_wled *wled, struct device *dev)
 	} bool_opts[] = {
 		{ "qcom,en-cabc", &cfg->en_cabc, },
 		{ "qcom,ext-pfet-sc-pro", &cfg->ext_pfet_sc_pro_en, },
+		{ "qcom,auto-calibration", &cfg->auto_calib_enabled, },
 	};
 
 	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

