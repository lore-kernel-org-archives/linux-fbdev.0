From: Kiran Gunda <kgunda@codeaurora.org>
Date: Thu, 16 Nov 2017 12:30:36 +0000
Subject: [PATCH V1 3/4] qcom: spmi-wled: Add support for OVP interrupt handling
Message-Id: <1510834717-21765-4-git-send-email-kgunda@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm-owner@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>

WLED peripheral has over voltage protection(OVP) circuitry and the OVP
fault is notified through an interrupt. Though this fault condition rising
is due to an incorrect hardware configuration is mitigated in the hardware,
it still needs to be detected and handled. Add support for it.

When WLED module is enabled, keep OVP fault interrupt disabled for 10 ms to
account for soft start delay.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 .../bindings/leds/backlight/qcom-spmi-wled.txt     |  7 +-
 drivers/video/backlight/qcom-spmi-wled.c           | 83 ++++++++++++++++++++++
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
index 768608c..d39ee93 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
@@ -92,7 +92,7 @@ The PMIC is connected to the host processor via SPMI bus.
 	Usage:      optional
 	Value type: <string>
 	Definition: Interrupt names associated with the interrupts.
-		    Must be "sc-irq".
+		    Currently supported interrupts are "sc-irq" and "ovp-irq".
 
 Example:
 
@@ -102,8 +102,9 @@ qcom-wled@d800 {
 	reg-names = "qcom-wled-ctrl-base", "qcom-wled-sink-base";
 	label = "backlight";
 
-	interrupts = <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
-	interrupt-names = "sc-irq";
+	interrupts = <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>,
+			<0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "sc-irq", "ovp-irq";
 	qcom,fs-current-limit = <25000>;
 	qcom,current-boost-limit = <970>;
 	qcom,switching-freq = <800>;
diff --git a/drivers/video/backlight/qcom-spmi-wled.c b/drivers/video/backlight/qcom-spmi-wled.c
index 7dbaaa7..8b2a77a 100644
--- a/drivers/video/backlight/qcom-spmi-wled.c
+++ b/drivers/video/backlight/qcom-spmi-wled.c
@@ -29,9 +29,15 @@
 #define QCOM_WLED_SC_DLY_MS			20
 #define QCOM_WLED_SC_CNT_MAX			5
 #define QCOM_WLED_SC_RESET_CNT_DLY_US		1000000
+#define QCOM_WLED_SOFT_START_DLY_US		10000
 
 /* WLED control registers */
 #define QCOM_WLED_CTRL_FAULT_STATUS		0x08
+#define  QCOM_WLED_CTRL_ILIM_FAULT_BIT		BIT(0)
+#define  QCOM_WLED_CTRL_OVP_FAULT_BIT		BIT(1)
+#define  QCOM_WLED_CTRL_SC_FAULT_BIT		BIT(2)
+
+#define QCOM_WLED_CTRL_INT_RT_STS		0x10
 
 #define QCOM_WLED_CTRL_MOD_ENABLE		0x46
 #define  QCOM_WLED_CTRL_MOD_EN_MASK		BIT(7)
@@ -90,6 +96,7 @@ struct qcom_wled_config {
 	u32 fs_current;
 	u32 string_cfg;
 	int sc_irq;
+	int ovp_irq;
 	bool en_cabc;
 	bool ext_pfet_sc_pro_en;
 };
@@ -106,6 +113,7 @@ struct qcom_wled {
 	u32 brightness;
 	u32 sc_count;
 	bool prev_state;
+	bool ovp_irq_disabled;
 };
 
 static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
@@ -115,6 +123,28 @@ static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
 	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
 			QCOM_WLED_CTRL_MOD_ENABLE, QCOM_WLED_CTRL_MOD_EN_MASK,
 			val << QCOM_WLED_CTRL_MODULE_EN_SHIFT);
+	if (rc < 0)
+		return rc;
+	/*
+	 * Wait for at least 10ms before enabling OVP fault interrupt after
+	 * enabling the module so that soft start is completed. Keep the OVP
+	 * interrupt disabled when the module is disabled.
+	 */
+	if (val) {
+		usleep_range(QCOM_WLED_SOFT_START_DLY_US,
+				QCOM_WLED_SOFT_START_DLY_US + 1000);
+
+		if (wled->cfg.ovp_irq > 0 && wled->ovp_irq_disabled) {
+			enable_irq(wled->cfg.ovp_irq);
+			wled->ovp_irq_disabled = false;
+		}
+	} else {
+		if (wled->cfg.ovp_irq > 0 && !wled->ovp_irq_disabled) {
+			disable_irq(wled->cfg.ovp_irq);
+			wled->ovp_irq_disabled = true;
+		}
+	}
+
 	return rc;
 }
 
@@ -264,12 +294,42 @@ static irqreturn_t qcom_wled_sc_irq_handler(int irq, void *_wled)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t qcom_wled_ovp_irq_handler(int irq, void *_wled)
+{
+	struct qcom_wled *wled = _wled;
+	int rc;
+	u32 int_sts, fault_sts;
+
+	rc = regmap_read(wled->regmap,
+			wled->ctrl_addr + QCOM_WLED_CTRL_INT_RT_STS, &int_sts);
+	if (rc < 0) {
+		pr_err("Error in reading WLED_INT_RT_STS rc=%d\n", rc);
+		return IRQ_HANDLED;
+	}
+
+	rc = regmap_read(wled->regmap, wled->ctrl_addr +
+			QCOM_WLED_CTRL_FAULT_STATUS, &fault_sts);
+	if (rc < 0) {
+		pr_err("Error in reading WLED_FAULT_STATUS rc=%d\n", rc);
+		return IRQ_HANDLED;
+	}
+
+	if (fault_sts &
+		(QCOM_WLED_CTRL_OVP_FAULT_BIT | QCOM_WLED_CTRL_ILIM_FAULT_BIT))
+		pr_err("WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
+			int_sts, fault_sts);
+
+	return IRQ_HANDLED;
+}
+
 static int qcom_wled_setup(struct qcom_wled *wled)
 {
 	int rc, temp, i;
 	u8 sink_en = 0;
+	u32 val;
 	u8 string_cfg = wled->cfg.string_cfg;
 	int sc_irq = wled->cfg.sc_irq;
+	int ovp_irq = wled->cfg.ovp_irq;
 
 	rc = regmap_update_bits(wled->regmap,
 			wled->ctrl_addr + QCOM_WLED_CTRL_OVP,
@@ -367,6 +427,25 @@ static int qcom_wled_setup(struct qcom_wled *wled)
 		}
 	}
 
+	if (ovp_irq >= 0) {
+		rc = devm_request_threaded_irq(&wled->pdev->dev, ovp_irq,
+				NULL, qcom_wled_ovp_irq_handler, IRQF_ONESHOT,
+				"qcom_wled_ovp_irq", wled);
+		if (rc < 0) {
+			dev_err(&wled->pdev->dev, "Unable to request ovp(%d) IRQ(err:%d)\n",
+				ovp_irq, rc);
+			return rc;
+		}
+
+		rc = regmap_read(wled->regmap, wled->ctrl_addr +
+				QCOM_WLED_CTRL_MOD_ENABLE, &val);
+		/* disable the OVP irq only if the module is not enabled */
+		if (!rc && !(val & QCOM_WLED_CTRL_MOD_EN_MASK)) {
+			disable_irq(ovp_irq);
+			wled->ovp_irq_disabled = true;
+		}
+	}
+
 	return 0;
 }
 
@@ -539,6 +618,10 @@ static int qcom_wled_configure(struct qcom_wled *wled, struct device *dev)
 	if (wled->cfg.sc_irq < 0)
 		dev_dbg(&wled->pdev->dev, "sc irq is not used\n");
 
+	wled->cfg.ovp_irq = platform_get_irq_byname(wled->pdev, "ovp-irq");
+	if (wled->cfg.ovp_irq < 0)
+		dev_dbg(&wled->pdev->dev, "ovp irq is not used\n");
+
 	return 0;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

