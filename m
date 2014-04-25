From: Jyri Sarha <jsarha@ti.com>
Date: Fri, 25 Apr 2014 21:16:50 +0000
Subject: [PATCH RFC 12/17] ARM: omap4-panda-common.dtsi: Add HDMI audio nodes
Message-Id: <ab87bed1e3101f9839dd42ad0ae6cbe61ef85d60.1398453425.git.jsarha@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1398453425.git.jsarha@ti.com>
In-Reply-To: <cover.1398453425.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, detheridge-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>

Adds a simple-card sound node for HDMI audio, the associated
hdmi-codec node, and sound-dai-cells propeties to the DAI nodes.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index d2c45bf..c04f453 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -41,7 +41,7 @@
 		};
 	};
 
-	sound: sound {
+	sound: sound@0 {
 		compatible = "ti,abe-twl6040";
 		ti,model = "PandaBoard";
 
@@ -65,6 +65,24 @@
 			"AFMR", "Line In";
 	};
 
+	sound@1 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,cpu {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi_audio>;
+		};
+	};
+
+	hdmi_audio: hdmi_audio@0 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,hdmi-audio";
+		status = "okay";
+	};
+
 	/* HS USB Port 1 Power */
 	hsusb1_power: hsusb1_power_reg {
 		compatible = "regulator-fixed";
@@ -512,6 +530,7 @@
 };
 
 &hdmi {
+	#sound-dai-cells = <0>;
 	status = "ok";
 	vdda-supply = <&vdac>;
 
-- 
1.7.9.5

