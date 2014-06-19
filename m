From: Alexander Shiyan <shc_work@mail.ru>
Date: Thu, 19 Jun 2014 16:21:17 +0000
Subject: [PATCH v2 2/2] video: clps711x: Add bindings documentation for CLPS711X framebuffer
Message-Id: <1403194877-32616-1-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>

Add OF document for Cirrus Logic CLPS711X framebuffer driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../bindings/video/cirrus,clps711x-fb.txt          | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt

diff --git a/Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt b/Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt
new file mode 100644
index 0000000..6fc3c6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/cirrus,clps711x-fb.txt
@@ -0,0 +1,47 @@
+* Currus Logic CLPS711X Framebuffer
+
+Required properties:
+- compatible: Shall contain "cirrus,clps711x-fb".
+- reg       : Physical base address and length of the controller's registers +
+              location and size of the framebuffer memory.
+- clocks    : phandle + clock specifier pair of the FB reference clock.
+- display   : phandle to a display node as described in
+              Documentation/devicetree/bindings/video/display-timing.txt.
+              Additionally, the display node has to define properties:
+  - bits-per-pixel: Bits per pixel.
+  - ac-prescale   : LCD AC bias frequency. This frequency is the required
+                    AC bias frequency for a given manufacturer's LCD plate.
+  - cmap-invert   : Invert the color levels (Optional).
+
+Optional properties:
+- lcd-supply: Regulator for LCD supply voltage.
+
+Example:
+	fb: fb@800002c0 {
+		compatible = "cirrus,ep7312-fb", "cirrus,clps711x-fb";
+		reg = <0x800002c0 0xd44>, <0x60000000 0xc000>;
+		clocks = <&clks 2>;
+		lcd-supply = <&reg5v0>;
+		display = <&display>;
+	};
+
+	display: display {
+		model = "320x240x4";
+		native-mode = <&timing0>;
+		bits-per-pixel = <4>;
+		ac-prescale = <17>;
+
+		display-timings {
+			timing0: 320x240 {
+				hactive = <320>;
+				hback-porch = <0>;
+				hfront-porch = <0>;
+				hsync-len = <0>;
+				vactive = <240>;
+				vback-porch = <0>;
+				vfront-porch = <0>;
+				vsync-len = <0>;
+				clock-frequency = <6500000>;
+			};
+		};
+	};
-- 
1.8.5.5

