From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 12 Nov 2014 16:15:49 +0000
Subject: [PATCH v5 2/5] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <1415808952-23549-3-git-send-email-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415808952-23549-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

A simple-framebuffer node represents a framebuffer setup by the firmware /
bootloader. Such a framebuffer may have a number of clocks in use, add a
property to communicate this to the OS.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Mike Turquette <mturquette@linaro.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Grant Likely <grant.likely@linaro.org>

--
Changes in v2:
-Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
Changes in v3:
-Updated description to make clear simplefb deals with more then just memory
Changes in v5:
-Improved clocks property description
---
 .../devicetree/bindings/video/simple-framebuffer.txt         | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
index 70c26f3..8f35718 100644
--- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
+++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
@@ -1,8 +1,8 @@
 Simple Framebuffer
 
-A simple frame-buffer describes a raw memory region that may be rendered to,
-with the assumption that the display hardware has already been set up to scan
-out from that buffer.
+A simple frame-buffer describes a frame-buffer setup by firmware or
+the bootloader, with the assumption that the display hardware has already
+been set up to scan out from the memory pointed to by the reg property.
 
 Required properties:
 - compatible: "simple-framebuffer"
@@ -14,6 +14,12 @@ Required properties:
   - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
   - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
 
+Optional properties:
+- clocks : List of clocks used by the framebuffer. Clocks listed here
+           are expected to already be configured correctly. The OS must
+           ensure these clocks are not modified or disabled while the
+           simple framebuffer remains active.
+
 Example:
 
 	framebuffer {
-- 
2.1.0

