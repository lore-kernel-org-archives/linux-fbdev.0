From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Nov 2014 09:02:31 +0000
Subject: [PATCH] dt-bindings: simplefb: Document naming scheme for pre-populated simplefb nodes
Message-Id: <1415955751-6316-1-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since we advice to use pre-populated simeplfb nodes in dt files, where the
firmware then only needs to fill in the mode info + address and enable it,
we should also specify how these pre-populated nodes should be named so
that the firmware can find and enable the right one.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/video/simple-framebuffer.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index c548f33..01dc948 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -29,6 +29,13 @@ enable them. This way if e.g. later on support for more display clocks get
 added, the simplefb nodes will already contain this info and the firmware
 does not need to be updated.
 
+If pre-filled framebuffer nodes are used, they should be named
+"framebuffer#-<output>", e.g. "framebuffer0-hdmi". The output should be
+included in the name since different outputs typically require different
+clocks and the clocks are part of the pre-populated nodes. The firmware must
+rename the nodes to the standard "framebuffer@<address>" using the runtime
+chosen address when enabling the nodes.
+
 Required properties:
 - compatible: "simple-framebuffer"
 - reg: Should contain the location and size of the framebuffer memory.
-- 
2.1.0

