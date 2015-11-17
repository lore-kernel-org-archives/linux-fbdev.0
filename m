From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 17 Nov 2015 04:31:02 +0000
Subject: [PATCH v5 1/2] dt-bindings: simplefb: Support regulator supply properties
Message-Id: <1447734663-19189-2-git-send-email-wens@csie.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447734663-19189-1-git-send-email-wens@csie.org>
In-Reply-To: <1447734663-19189-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The physical display tied to the framebuffer may have regulators
providing power to it, such as power for LCDs or interface conversion
chips.

The number of regulators in use may vary, but the regulator supply
binding can not be a list. Instead just support any named regulator
supply properties under the device node. These should be properly
named to match the device schematics / design. The driver should
take care to go through them all.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/display/simple-framebuffer.txt      | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.txt b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
index 4474ef6e0b95..8c9e9f515c87 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.txt
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
2.6.2

