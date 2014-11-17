From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 17 Nov 2014 15:37:04 +0000
Subject: [PATCH v2 1/2] dt-bindings: simplefb: Drop the advice about using a specific path for nodes
Message-Id: <1416238625-28590-2-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1416238625-28590-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1416238625-28590-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This goes contrary to how devicetree usually works, so drop it. Instead if
the firmware needs to be able to find a specific node it should use a
platform specific compatible + properties for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Grant Likely <grant.likely@linaro.org>
---
 Documentation/devicetree/bindings/video/simple-framebuffer.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index f8fb7e6..4474ef6 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -31,12 +31,10 @@ enable them. This way if e.g. later on support for more display clocks get
 added, the simplefb nodes will already contain this info and the firmware
 does not need to be updated.
 
-If pre-filled framebuffer nodes are used, they should be named
-"framebuffer#-<output>", e.g. "framebuffer0-hdmi". The output should be
-included in the name since different outputs typically require different
-clocks and the clocks are part of the pre-populated nodes. The firmware must
-rename the nodes to the standard "framebuffer@<address>" name using the
-runtime chosen address when enabling the nodes.
+If pre-filled framebuffer nodes are used, the firmware may need extra
+information to find the right node. In that case an extra platform specific
+compatible and platform specific properties should be used and documented,
+see e.g. simple-framebuffer-sunxi.txt .
 
 Required properties:
 - compatible: "simple-framebuffer"
-- 
2.1.0

