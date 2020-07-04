From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 04 Jul 2020 14:35:44 +0000
Subject: [PATCH v1 1/1] dt-bindings: fix simple-framebuffer example
Message-Id: <20200704143544.789345-2-sam@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200704143544.789345-1-sam@ravnborg.org>
In-Reply-To: <20200704143544.789345-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Hans de Goede <hdegoede@redhat.com>, Sam Ravnborg <sam@ravnborg.org>

Now that dt-extract-example gained support for using root nodes
in examples, update the example for the simple-frambuffer binding to use it.

This gives us a better example and kill a long standing warning:

simple-framebuffer.example.dts:23.16-39.11:
Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node

Note: To get the update dt-extract-example execute:
pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
---
 .../bindings/display/simple-framebuffer.yaml  | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
index 1db608c9eef5..6f23ea14132b 100644
--- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
+++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
@@ -152,28 +152,29 @@ additionalProperties: false
 
 examples:
   - |
-    aliases {
-      display0 = &lcdc0;
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            #address-cells = <1>;
+            #size-cells = <1>;
+            stdout-path = "display0";
+            framebuffer0: framebuffer@1d385000 {
+                compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
+                allwinner,pipeline = "de_be0-lcd0";
+                reg = <0x1d385000 3840000>;
+                width = <1600>;
+                height = <1200>;
+                stride = <3200>;
+                format = "r5g6b5";
+                clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+                lcd-supply = <&reg_dc1sw>;
+                display = <&lcdc0>;
+            };
+        };
     };
 
-    chosen {
-      #address-cells = <1>;
-      #size-cells = <1>;
-      stdout-path = "display0";
-      framebuffer0: framebuffer@1d385000 {
-        compatible = "allwinner,simple-framebuffer", "simple-framebuffer";
-        allwinner,pipeline = "de_be0-lcd0";
-        reg = <0x1d385000 3840000>;
-        width = <1600>;
-        height = <1200>;
-        stride = <3200>;
-        format = "r5g6b5";
-        clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
-        lcd-supply = <&reg_dc1sw>;
-        display = <&lcdc0>;
-      };
-    };
-
-    lcdc0: lcdc { };
-
 ...
-- 
2.25.1
