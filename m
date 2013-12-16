From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Dec 2013 14:56:21 +0000
Subject: [PATCHv2 14/27] ARM: omap4.dtsi: add omapdss information
Message-Id: <1387205794-32246-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e05853afcd..a515f524ef3a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -705,5 +705,59 @@
 			dmas = <&sdma 117>, <&sdma 116>;
 			dma-names = "tx", "rx";
 		};
+
+		dss: dss@58000000 {
+			compatible = "ti,omap4-dss", "simple-bus";
+			reg = <0x58000000 0x80>;
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@58001000 {
+				compatible = "ti,omap4-dispc";
+				reg = <0x58001000 0x1000>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			rfbi: encoder@58002000  {
+				compatible = "ti,omap4-rfbi";
+				reg = <0x58002000 0x1000>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+			/*
+			 * Accessing venc registers cause a crash on omap4, so
+			 * this is disabled for now.
+			 */
+			venc: encoder@58003000 {
+				compatible = "ti,omap4-venc";
+				reg = <0x58003000 0x1000>;
+				ti,hwmods = "dss_venc";
+				status = "disabled";
+			};
+
+			dsi1: encoder@58004000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58004000 0x200>;
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dsi1";
+			};
+
+			dsi2: encoder@58005000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58005000 0x200>;
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dsi2";
+			};
+
+			hdmi: encoder@58006000 {
+				compatible = "ti,omap4-hdmi";
+				reg = <0x58006000 0x1000>;
+				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_hdmi";
+			};
+		};
 	};
 };
-- 
1.8.3.2

