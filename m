From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sat, 03 Oct 2015 16:11:34 +0000
Subject: [PATCH] video: fbdev: add Marvell PXA framebuffer binding
Message-Id: <1443888694-12311-1-git-send-email-robert.jarzmik@free.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

Add documentation for the PXA frambuffer devicetree binding.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org

---
 .../devicetree/bindings/video/marvell,pxafb.txt    | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/marvell,pxafb.txt

diff --git a/Documentation/devicetree/bindings/video/marvell,pxafb.txt b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
new file mode 100644
index 000000000000..489055bf3c57
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/marvell,pxafb.txt
@@ -0,0 +1,75 @@
+PXA LCDC Framebuffer
+-----------------------------------------------------
+
+Required properties:
+- compatible :
+	"marvell,pxa2xx-fb",
+- reg : Should contain 1 register ranges(address and length).
+	Can contain an additional register range(address and length)
+	for fixed framebuffer memory. Useful for dedicated memories.
+- interrupts : framebuffer controller interrupt
+- display: a phandle pointing to the display node
+
+Required nodes:
+- display: a display node is required to initialize the lcd panel
+	   This should be in the board dts.
+- default-mode: a videomode within the display with timing parameters
+		as specified below.
+- bits-per-pixel: pixel data bus width of the LCD panel
+
+Optional properties:
+- lcd-supply: Regulator for LCD supply voltage.
+- enable-transparency-bit: if framebuffer colorspace reserves a bit for
+			   transparency
+- enable-greyscale-cmap: true if palette is a grayscale based instead of color
+
+Example:
+
+	fb0: video@0x44000000 {
+		compatible = "marvell,pxa2xx-fb";
+		reg = <0x44000000 0x10000>;
+		interrupts = <17>;
+		clocks = <&clks CLK_LCD>;
+		interrupts = <23>;
+		display = <&display0>;
+		status = "okay";
+
+		enable-transparency-bit = <0>;
+		enable-greyscale-cmap = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+PXA LCDC Display
+-----------------------------------------------------
+Required properties (as per of_videomode_helper):
+ - lcd-type: either "mono-stn", "mono-dstn", "color-stn", "color-dstn",
+   	     	    "color-tft", "smart-panel"
+ - bits-per-pixel: LCD data bus width
+
+Optional properties (as per of_videomode_helper):
+ - power-regulator: power supply regulator to the LCD to power it on or off
+
+Example:
+	display0: display {
+		lcd-type = "color-tft";
+		bits-per-pixel = <16>;
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
+				pixelclk-active = <0>;
+				de-active = <1>;
+			};
+		};
+	};
-- 
2.1.4

