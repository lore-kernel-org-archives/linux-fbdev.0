From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Jan 2014 10:56:56 +0000
Subject: [PATCHv3 24/41] ARM: omap4.dtsi: add omapdss information
Message-Id: <1390301833-24944-25-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add DT data for OMAP4 display subsystem, which contains the following
blocks:

dss - the wrapper/glue for the display modules
dispc - display controller
dsi - MIPI DSI encoder (two independent modules)
rfbi - MIPI DBI encoder
venc - analog TV encoder
hdmi - HDMI encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 65 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e05853afcd..19498b2fa316 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -705,5 +705,70 @@
 			dmas = <&sdma 117>, <&sdma 116>;
 			dma-names = "tx", "rx";
 		};
+
+		dss: dss@58000000 {
+			compatible = "ti,omap4-dss", "simple-bus";
+			reg = <0x58000000 0x80>;
+			status = "disabled";
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
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: encoder@58003000 {
+				compatible = "ti,omap4-venc";
+				reg = <0x58003000 0x1000>;
+				status = "disabled";
+				ti,hwmods = "dss_venc";
+			};
+
+			dsi1: encoder@58004000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58004000 0x200>,
+				      <0x58004200 0x40>,
+				      <0x58004300 0x20>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi1";
+			};
+
+			dsi2: encoder@58005000 {
+				compatible = "ti,omap4-dsi";
+				reg = <0x58005000 0x200>,
+				      <0x58005200 0x40>,
+				      <0x58005300 0x20>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi2";
+			};
+
+			hdmi: encoder@58006000 {
+				compatible = "ti,omap4-hdmi";
+				reg = <0x58006000 0x200>,
+				      <0x58006200 0x100>,
+				      <0x58006300 0x100>,
+				      <0x58006400 0x1000>;
+				reg-names = "wp", "pll", "phy", "core";
+				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_hdmi";
+			};
+		};
 	};
 };
-- 
1.8.3.2

