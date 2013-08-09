From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 08:38:57 +0000
Subject: [RFC 12/22] ARM: omap4-panda.dts: add display information
Message-Id: <1376037547-10859-13-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1376037547-10859-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index faa95b5..fa65b19 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -357,3 +357,51 @@
 &usbhsehci {
 	phys = <&hsusb1_phy>;
 };
+
+&dsi1 {
+	vdds_dsi-supply = <&vcxio>;
+};
+
+&dsi2 {
+	vdds_dsi-supply = <&vcxio>;
+};
+
+&hdmi {
+	vdda_hdmi_dac-supply = <&vdac>;
+};
+
+/ {
+	aliases {
+		display0 = &dvi0;
+		display1 = &hdmi0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		video-source = <&dpi>;
+		data-lines = <24>;
+		gpios = <&gpio1 0 0>;	/* 0, power-down */
+	};
+
+	dvi0: connector@0 {
+		compatible = "ti,dvi_connector";
+		video-source = <&tfp410>;
+		i2c-bus = <&i2c3>;
+	};
+
+	tpd12s015: encoder@1 {
+		compatible = "ti,tpd12s015";
+
+		video-source = <&hdmi>;
+
+		gpios = <&gpio2 28 0>,	/* 60, CT CP HPD */
+			<&gpio2 9 0>,	/* 41, LS OE */
+			<&gpio2 31 0>;	/* 63, HPD */
+	};
+
+	hdmi0: connector@1 {
+		compatible = "ti,hdmi_connector";
+
+		video-source = <&tpd12s015>;
+	};
+};
-- 
1.8.1.2

