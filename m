From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 21 Jan 2014 10:56:55 +0000
Subject: [PATCHv3 23/41] ARM: omap3.dtsi: add omapdss information
Message-Id: <1390301833-24944-24-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add DT data for OMAP3 display subsystem, which contains the following
blocks:

dss - the wrapper/glue for the display modules
dispc - display controller
dsi - MIPI DSI encoder
rfbi - MIPI DBI encoder
venc - analog TV encoder

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99d402a..d942f9a4723f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -630,5 +630,47 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 		};
+
+		dss: dss@48050000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x48050000 0x200>;
+			status = "disabled";
+			ti,hwmods = "dss_core";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			dispc@48050400 {
+				compatible = "ti,omap3-dispc";
+				reg = <0x48050400 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dispc";
+			};
+
+			dsi: encoder@4804fc00 {
+				compatible = "ti,omap3-dsi";
+				reg = <0x4804fc00 0x200>,
+				      <0x4804fe00 0x40>,
+				      <0x4804ff00 0x20>;
+				reg-names = "proto", "phy", "pll";
+				interrupts = <25>;
+				status = "disabled";
+				ti,hwmods = "dss_dsi1";
+			};
+
+			rfbi: encoder@48050800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x48050800 0x100>;
+				status = "disabled";
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: encoder@48050c00 {
+				compatible = "ti,omap3-venc";
+				reg = <0x48050c00 0x100>;
+				status = "disabled";
+				ti,hwmods = "dss_venc";
+			};
+		};
 	};
 };
-- 
1.8.3.2

