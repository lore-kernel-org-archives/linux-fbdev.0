From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Apr 2014 10:17:06 +0000
Subject: [PATCH 10/23] ARM: dts: omap5.dtsi: add DSS nodes
Message-Id: <1398334639-14172-11-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add OMAP5 DSS nodes to omap5.dtsi.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5.dtsi | 70 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6f3de22fb266..b2a28e6575df 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -863,6 +863,76 @@
 
 			#thermal-sensor-cells = <1>;
 		};
+
+		dss: dss@58000000 {
+			compatible = "ti,omap5-dss";
+			reg = <0x58000000 0x80>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			clocks = <&dss_dss_clk>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@58001000 {
+				compatible = "ti,omap5-dispc";
+				reg = <0x58001000 0x1000>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				ti,hwmods = "dss_dispc";
+				clocks = <&dss_dss_clk>;
+				clock-names = "fck";
+			};
+
+			rfbi: encoder@58002000  {
+				compatible = "ti,omap5-rfbi";
+				reg = <0x58002000 0x100>;
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+				clocks = <&dss_dss_clk>, <&dss_l3_iclk>;
+				clock-names = "fck", "ick";
+			};
+
+			dsi1: encoder@58004000 {
+				compatible = "ti,omap5-dsi";
+				reg = <0x58004000 0x200>,
+				      <0x58004200 0x40>,
+				      <0x58004300 0x40>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi1";
+				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+
+			dsi2: encoder@58005000 {
+				compatible = "ti,omap5-dsi";
+				reg = <0x58009000 0x200>,
+				      <0x58009200 0x40>,
+				      <0x58009300 0x40>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi2";
+				clocks = <&dss_dss_clk>, <&dss_sys_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+
+			hdmi: encoder@58060000 {
+				compatible = "ti,omap5-hdmi";
+				reg = <0x58040000 0x400>,
+				      <0x58040200 0x80>,
+				      <0x58040300 0x80>,
+				      <0x58060000 0x19000>;
+				reg-names = "wp", "pll", "phy", "core";
+				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+				ti,hwmods = "dss_hdmi";
+				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
+				clock-names = "fck", "sys_clk";
+			};
+		};
 	};
 };
 
-- 
1.9.1

