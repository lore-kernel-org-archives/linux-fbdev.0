From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 21 Oct 2015 05:59:00 +0000
Subject: [PATCH RFC v2 1/2] dt-bindings: simplefb: Support a list of regulator supply properties
Message-Id: <1445407141-16459-2-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445407141-16459-1-git-send-email-wens@csie.org>
In-Reply-To: <1445407141-16459-1-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The physical display tied to the framebuffer may have regulators
providing power to it, such as power for LCDs or interface conversion
chips.

The number of regulators in use may vary, but the regulator supply
binding can not be a list. Work around this by adding a "num-supplies"
property to communicate the number of supplies, and a list of 0 ~ N
"vinN-supply" properties for the actual regulator supply.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../devicetree/bindings/video/simple-framebuffer.txt        | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index 4474ef6e0b95..8c9e9f515c87 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -47,10 +47,14 @@ Required properties:
   - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
 
 Optional properties:
-- clocks : List of clocks used by the framebuffer. Clocks listed here
-           are expected to already be configured correctly. The OS must
-           ensure these clocks are not modified or disabled while the
-           simple framebuffer remains active.
+- clocks : List of clocks used by the framebuffer.
+- *-supply : Any number of regulators used by the framebuffer. These should
+	     be named according to the names in the device's design.
+
+  The above resources are expected to already be configured correctly.
+  The OS must ensure they are not modified or disabled while the simple
+  framebuffer remains active.
+
 - display : phandle pointing to the primary display hardware node
 
 Example:
@@ -68,6 +72,7 @@ chosen {
 		stride = <(1600 * 2)>;
 		format = "r5g6b5";
 		clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+		lcd-supply = <&reg_dc1sw>;
 		display = <&lcdc0>;
 	};
 	stdout-path = "display0";
-- 
2.6.1

