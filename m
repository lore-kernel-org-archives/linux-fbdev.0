From: Kiran Gunda <kgunda@codeaurora.org>
Date: Fri, 01 Nov 2019 06:38:57 +0000
Subject: [PATCH V10 1/8] backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
Message-Id: <1572589624-6095-2-git-send-email-kgunda@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1572589624-6095-1-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>, Andy Gross <agross@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Kiran Gunda <kgunda@codeaurora.org>

pm8941-wled.c driver is supporting the WLED peripheral
on pm8941. Rename it to qcom-wled.c so that it can support
WLED on multiple PMICs.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-
 drivers/video/backlight/Kconfig                                   | 8 ++++----
 drivers/video/backlight/Makefile                                  | 2 +-
 drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
 rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)

diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
similarity index 95%
rename from Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
rename to Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
index e5b294d..fb39e32 100644
--- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
@@ -1,4 +1,4 @@
-Binding for Qualcomm PM8941 WLED driver
+Binding for Qualcomm Technologies, Inc. WLED driver
 
 Required properties:
 - compatible: should be "qcom,pm8941-wled"
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 40676be..73442bdf 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -282,12 +282,12 @@ config BACKLIGHT_TOSA
 	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
 	  for its backlight
 
-config BACKLIGHT_PM8941_WLED
-	tristate "Qualcomm PM8941 WLED Driver"
+config BACKLIGHT_QCOM_WLED
+	tristate "Qualcomm PMIC WLED Driver"
 	select REGMAP
 	help
-	  If you have the Qualcomm PM8941, say Y to enable a driver for the
-	  WLED block.
+	  If you have the Qualcomm PMIC, say Y to enable a driver for the
+	  WLED block. Currently it supports PM8941 and PMI8998.
 
 config BACKLIGHT_SAHARA
 	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 63c507c..6f87770 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -48,8 +48,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
 obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
 obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
-obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
 obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
+obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
 obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
 obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
 obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/qcom-wled.c
similarity index 100%
rename from drivers/video/backlight/pm8941-wled.c
rename to drivers/video/backlight/qcom-wled.c
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project
