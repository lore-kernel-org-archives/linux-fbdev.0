From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 17 Nov 2014 15:37:05 +0000
Subject: [PATCH v2 2/2] dt-bindings: simplefb-sunxi: Add sunxi simplefb extensions
Message-Id: <1416238625-28590-3-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416238625-28590-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1416238625-28590-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

If pre-filled framebuffer nodes are used, the firmware may need extra
properties to find the right node. This documents the properties to use
for this on sunxi platforms.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
 .../bindings/video/simple-framebuffer-sunxi.txt    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt b/Documentation/devicetree/bindings/video/simple-framebuffer-sunxi.txt
new file mode 100644
index 0000000..4188606
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
+on which pipeline is being used. As such they are solely intended for
+firmware / bootloader use, and the OS should ignore them.
+
+Required properties:
+- compatible: "sunxi,framebuffer"
+- sunxi,pipeline, one of:
+  "de_be0-lcd0"
+  "de_be1-lcd1"
+  "de_be0-lcd0-hdmi"
+  "de_be1-lcd1-hdmi"
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
+		sunxi,pipeline = "de_be0-lcd0-hdmi";
+		clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 43>,
+			 <&ahb_gates 44>;
+		status = "disabled";
+	};
+};
-- 
2.1.0

