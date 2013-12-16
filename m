From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Dec 2013 14:56:20 +0000
Subject: [PATCHv2 13/27] ARM: omap3.dtsi: add omapdss information
Message-Id: <1387205794-32246-14-git-send-email-tomi.valkeinen@ti.com>
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
 arch/arm/boot/dts/omap3.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index daabf99d402a..c646fa9ae5d3 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -630,5 +630,40 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 		};
+
+		dss: dss@48050000 {
+			compatible = "ti,omap3-dss", "simple-bus";
+			reg = <0x48050000 0x200>;
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
+				reg = <0x4804fc00 0x400>;
+				interrupts = <25>;
+				ti,hwmods = "dss_dsi1";
+			};
+
+			rfbi: encoder@48050800 {
+				compatible = "ti,omap3-rfbi";
+				reg = <0x48050800 0x100>;
+				ti,hwmods = "dss_rfbi";
+			};
+
+			venc: encoder@48050c00 {
+				compatible = "ti,omap3-venc";
+				reg = <0x48050c00 0x100>;
+				ti,hwmods = "dss_venc";
+			};
+		};
 	};
 };
-- 
1.8.3.2

