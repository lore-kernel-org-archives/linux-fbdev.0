From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 17 Nov 2014 11:34:46 +0000
Subject: [PATCH 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <1416224086-5698-3-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1416224086-5698-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

If pre-filled framebuffer nodes are used, the firmware may need extra
properties to find the right node. This documents the properties to use
for this on sunxi platforms.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
new file mode 100644
index 0000000..84ca264
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
@@ -0,0 +1,33 @@
+Sunxi specific Simple Framebuffer bindings
+
+This binding documents sunxi specific extensions to the simple-framebuffer
+bindings. The sunxi simplefb u-boot code relies on the devicetree containing
+pre-populated simplefb nodes.
+
+These extensions are intended so that u-boot can select the right node based
+on which pipeline and output is being used. As such they are solely intended
+for firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "sunxi,framebuffer"
+- sunxi,pipeline:
+  <0> for the de_be0 -> lcdc0 -> output pipeline
+  <1> for the de_be1 -> lcdc1 -> output pipeline
+- sunxi,output: One of: "hdmi", "lcd", "vga", and "composite"  
+
+Example:
+
+chosen {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	framebuffer@0 {
+		compatible = "sunxi,framebuffer", "simple-framebuffer";
+		sunxi,pipeline = <0>;
+		sunxi,output = "hdmi";
+		clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+			 <&ahb_gates 44>;
+		status = "disabled";
+	};
+};
-- 
2.1.0

