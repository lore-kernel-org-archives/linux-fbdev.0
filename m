From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 13 Nov 2014 19:23:11 +0000
Subject: [PATCH v4 1/4] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <1415906594-2461-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since simplefb nodes do not relate directly to hw typically they have been
placed in the root of the devicetree. As the represent runtime information
having them as sub-nodes of /chosen is more logical, specify this.

Also specify when to set the chosen stdout-path property to a simplefb node.

For reliable handover to a hardware specific driver, that driver needs to
know which simplefb to unregister when taking over, specify how the hw driver
can find the matching simplefb node.

Last add some advice on how to fill and use simplefb nodes from a firmware
pov.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
--
Changes in v2:
-Add stdout-path to the example code
Changes in v3:
-Specify that the node name must be "framebuffer@<address>"
-Specify that the link to link simplefb node and display hw nodes to one
 another for handover goes into the simplefb node, and must be called "display"
-Specify how aliases may be used to tell the OS how to number displays
-Update the example to reflect these changes
Changes in v4:
-Keep the size of the reg property in the example as it was before
---
 .../bindings/video/simple-framebuffer.txt          | 49 +++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index 8f35718..c548f33 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -4,6 +4,31 @@ A simple frame-buffer describes a frame-buffer setup by firmware or
 the bootloader, with the assumption that the display hardware has already
 been set up to scan out from the memory pointed to by the reg property.
 
+Since simplefb nodes represent runtime information they must be sub-nodes of
+the chosen node (*). Simplefb nodes must be named "framebuffer@<address>".
+
+If a simplefb node represents the preferred console for user interaction,
+then the chosen node's stdout-path property must point to it.
+
+If the devicetree contains nodes for the display hardware used by a simplefb,
+then the simplefb node must contain a property called "display", which
+contains a phandle pointing to the primary display hw node, so that the OS
+knows which simplefb to disable when handing over control to a driver for the
+real hardware. The bindings for the hw nodes must specify which node is
+considered the primary node.
+
+It is advised to add display# aliases to help the OS determine how to number
+things. If display# aliases are used, then if the simplefb node contains a
+"display" property then the /aliases/display# path must point to the display
+hw node the "display" property points to, otherwise it must point directly
+to the simplefb node.
+
+It is advised that devicetree files contain pre-filled, disabled framebuffer
+nodes, so that the firmware only needs to update the mode information and
+enable them. This way if e.g. later on support for more display clocks get
+added, the simplefb nodes will already contain this info and the firmware
+does not need to be updated.
+
 Required properties:
 - compatible: "simple-framebuffer"
 - reg: Should contain the location and size of the framebuffer memory.
@@ -19,14 +44,36 @@ Optional properties:
            are expected to already be configured correctly. The OS must
            ensure these clocks are not modified or disabled while the
            simple framebuffer remains active.
+- display : phandle pointing to the primary display hardware node
 
 Example:
 
-	framebuffer {
+aliases {
+	display0 = &lcdc0;
+}
+
+chosen {
+	framebuffer0: framebuffer@1d385000 {
 		compatible = "simple-framebuffer";
 		reg = <0x1d385000 (1600 * 1200 * 2)>;
 		width = <1600>;
 		height = <1200>;
 		stride = <(1600 * 2)>;
 		format = "r5g6b5";
+		clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>;
+		display = <&lcdc0>;
+	};
+	stdout-path = &framebuffer0;
+};
+
+soc@01c00000 {
+	lcdc0: lcdc@1c0c000 {
+		compatible = "allwinner,sun4i-a10-lcdc";
+		...
 	};
+};
+
+
+*) Older devicetree files may have a compatible = "simple-framebuffer" node
+in a different place, operating systems must first enumerate any compatible
+nodes found under chosen and then check for other compatible nodes.
-- 
2.1.0

