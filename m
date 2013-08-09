From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 Aug 2013 08:39:00 +0000
Subject: [RFC 15/22] ARM: omap3-beagle.dts: add display information
Message-Id: <1376037547-10859-16-git-send-email-tomi.valkeinen@ti.com>
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
 arch/arm/boot/dts/omap3-beagle.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index dfd8310..17cb9b0 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -180,3 +180,32 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio1_pins>;
 };
+
+&dpi {
+	vdds_dsi-supply = <&vpll2>;
+};
+
+/ {
+	aliases {
+		display0 = &dvi0;
+		display1 = &tv0;
+	};
+
+	tfp410: encoder@0 {
+		compatible = "ti,tfp410";
+		video-source = <&dpi>;
+		data-lines = <24>;
+		gpios = <&gpio5 10 0>;	/* 170, power-down */
+	};
+
+	dvi0: connector@0 {
+		compatible = "ti,dvi_connector";
+		video-source = <&tfp410>;
+		i2c-bus = <&i2c3>;
+	};
+
+	tv0: connector@1 {
+		compatible = "ti,svideo_connector";
+		video-source = <&venc>;
+	};
+};
-- 
1.8.1.2

