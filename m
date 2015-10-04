From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 04 Oct 2015 10:31:23 +0000
Subject: [PATCH v2] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <1443954683-13126-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

Add documentation for the PXA frambuffer devicetree binding.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: Philipp's review on the whole binding
---
 .../devicetree/bindings/video/marvell,pxafb.txt    | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/marvell,pxafb.txt

diff --git a/Documentation/devicetree/bindings/video/marvell,pxafb.txt b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
new file mode 100644
index 000000000000..4d6bd490680d
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
@@ -0,0 +1,80 @@
+PXA LCDC Framebuffer
+--------------------
+
+Required properties:
+ - compatible :
+	"marvell,pxa2xx-lcdc",
+ - reg : Should contain 1 register ranges(address and length).
+	 Can contain an additional register range(address and length)
+	 for fixed framebuffer memory. Useful for dedicated memories.
+ - interrupts : framebuffer controller interrupt
+
+Required nodes:
+ - clocks: phandle to input clocks.
+ - port: connection to the LCD panel (see video-interfaces.txt)
+	 This nodes must have its properties bus-width and remote-endpoint set.
+	 This should be in the board dts.
+
+Example:
+
+	lcd-controller@40500000 {
+		compatible = "marvell,pxa2xx-lcdc";
+		reg = <0x44000000 0x10000>;
+		interrupts = <17>;
+		clocks = <&clks CLK_LCD>;
+		interrupts = <23>;
+		status = "okay";
+
+		port {
+			lcdc_out: endpoint {
+				remote-endpoint = <&panel_in>;
+				bus-width = <16>;
+			};
+		};
+	};
+
+PXA LCDC Display
+----------------
+Required properties (as per of_videomode_helper):
+ - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
+		    "color-tft", "smart-panel"
+
+Optional properties (as per of_videomode_helper):
+ - power-supply: power supply regulator to the LCD to power it on or off
+		 (see regulator.txt)
+ - backlight: backlight control (see backlight.txt)
+
+Required nodes:
+ - port: connection to the LCD controller
+ - display-timings: panel timings (see display-timing.txt)
+
+Example:
+	panel {
+		compatible = "toshiba,ltm0305a776";
+		lcd-type = "color-tft";
+
+		power-supply = <&lcd_supply>;
+		backlight = <&lcd_backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lcdc_out>;
+			};
+		};
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: 240p {
+				/* 240x320p24 */
+				clock-frequency = <4545000>;
+				hactive = <240>;
+				vactive = <320>;
+				hfront-porch = <4>;
+				hback-porch = <6>;
+				hsync-len = <4>;
+				vback-porch = <5>;
+				vfront-porch = <3>;
+				vsync-len = <2>;
+			};
+		};
+	};
-- 
2.1.4

