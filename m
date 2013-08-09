From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 08:38:58 +0000
Subject: [RFC 13/22] ARM: omap4-sdp.dts: add display information
Message-Id: <1376037547-10859-14-git-send-email-tomi.valkeinen@ti.com>
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
 arch/arm/boot/dts/omap4-sdp.dts | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7951b4e..49f98b1 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -532,3 +532,73 @@
 	mode = <3>;
 	power = <50>;
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
+		display0 = &lcd0;
+		display1 = &lcd1;
+		display2 = &hdmi0;
+	};
+
+	lcd0: display@0 {
+		compatible = "tpo,taal", "panel-dsi-cm";
+
+		video-source = <&dsi1>;
+
+		lanes = <
+			0       /* clk + */
+			1       /* clk - */
+			2       /* data1 + */
+			3       /* data1 - */
+			4       /* data2 + */
+			5       /* data2 - */
+		>;
+
+		gpios = <&gpio4 6 0>;	/* 102, reset */
+	};
+
+	lcd1: display@1 {
+		compatible = "tpo,taal", "panel-dsi-cm";
+
+		video-source = <&dsi2>;
+
+		lanes = <
+			0       /* clk + */
+			1       /* clk - */
+			2       /* data1 + */
+			3       /* data1 - */
+			4       /* data2 + */
+			5       /* data2 - */
+		>;
+
+		gpios = <&gpio4 8 0>;	/* 104, reset */
+	};
+
+	tpd12s015: encoder@0 {
+		compatible = "ti,tpd12s015";
+
+		video-source = <&hdmi>;
+
+		gpios = <&gpio2 28 0>,	/* 60, CT CP HPD */
+			<&gpio2 9 0>,	/* 41, LS OE */
+			<&gpio2 31 0>;	/* 63, HPD */
+	};
+
+	hdmi0: connector@0 {
+		compatible = "ti,hdmi_connector";
+
+		video-source = <&tpd12s015>;
+	};
+};
-- 
1.8.1.2

