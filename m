From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 03 Jul 2014 13:40:00 +0000
Subject: [PATCH 4/4] arm/dts: am437x GP HDMI support
Message-Id: <1404394800-18138-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

AM437x GP board has both LCD and HDMI outputs. The active display is
selected with a GPIO, which affects video and audio signal routing, and
LCD backlight.

Managing the gpio dynamically has proven rather difficult, so the
approach taken here is just to have two separate .dts files for LCD/HDMI
use cases. The HDMI dts file includes the base file, which has LCD
support, and overrides and adds the necessary items.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile               |  3 +-
 arch/arm/boot/dts/am437x-gp-evm-hdmi.dts | 70 ++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am437x-gp-evm-hdmi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5a1fba6d10b5..3065fb2d113b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -302,7 +302,8 @@ dtb-$(CONFIG_ARCH_OMAP4) += omap4-duovero-parlor.dtb \
 	omap4-var-stk-om44.dtb
 dtb-$(CONFIG_SOC_AM43XX) += am43x-epos-evm.dtb \
 	am437x-gp-evm.dtb \
-	am43x-epos-evm-hdmi.dtb
+	am43x-epos-evm-hdmi.dtb \
+	am437x-gp-evm-hdmi.dtb
 dtb-$(CONFIG_SOC_OMAP5) += omap5-cm-t54.dtb \
 	omap5-sbc-t54.dtb \
 	omap5-uevm.dtb
diff --git a/arch/arm/boot/dts/am437x-gp-evm-hdmi.dts b/arch/arm/boot/dts/am437x-gp-evm-hdmi.dts
new file mode 100644
index 000000000000..9380a422227b
--- /dev/null
+++ b/arch/arm/boot/dts/am437x-gp-evm-hdmi.dts
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* AM437x GP EVM with HDMI output */
+
+#include "am437x-gp-evm.dts"
+
+/ {
+	aliases {
+		display0 = &hdmi;
+	};
+
+	hdmi: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "b";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+};
+
+&i2c1 {
+	sii9022@3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		/* XXX 'SelLCDorHDMI' Gpio, LOW to select HDMI */
+		reset-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&dss {
+	port {
+		dpi_out: endpoint@0 {
+			remote-endpoint = <&sii9022_in>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1

