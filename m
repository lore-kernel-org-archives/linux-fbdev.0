From: Marek Belisko <marek@goldelico.com>
Date: Wed, 12 Nov 2014 22:10:45 +0000
Subject: [PATCH v2 3/5] arm: dts: omap3-gta04: Add handling for tv output
Message-Id: <1415830247-31633-4-git-send-email-marek@goldelico.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830247-31633-1-git-send-email-marek@goldelico.com>
In-Reply-To: <1415830247-31633-1-git-send-email-marek@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add handling for gta04 tv out chain:
venc -> opa362 -> svideo

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 48 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index fd34f91..b50dc10 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -83,6 +83,41 @@
 		compatible = "usb-nop-xceiv";
 		reset-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
 	};
+
+	tv0: connector@1 {
+		compatible = "svideo-connector";
+		label = "tv";
+
+		port {
+			tv_connector_in: endpoint {
+				remote-endpoint = <&opa_out>;
+			};
+		};
+	};
+
+	tv_amp: opa362 {
+		compatible = "ti,opa362";
+		gpios = <&gpio1 23 0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				opa_in: endpoint@0 {
+					remote-endpoint = <&venc_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				opa_out: endpoint@0 {
+					remote-endpoint = <&tv_connector_in>;
+				};
+			};
+		};
+	};
 };
 
 &omap3_pmx_core {
@@ -396,6 +431,19 @@
 	};
 };
 
+&venc {
+	status = "okay";
+
+	vdda-supply = <&vdac>;
+
+	port {
+		venc_out: endpoint {
+			remote-endpoint = <&opa_in>;
+			ti,channels = <2>;
+		};
+	};
+};
+
 &gpmc {
 	ranges = <0 0 0x30000000 0x04>; /* CS0: NAND */
 
-- 
1.9.1

