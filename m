From: Davor Joja <davorjoja@logicbricks.com>
Date: Wed, 11 Mar 2015 15:27:11 +0000
Subject: [PATCH 10/10] bindings: video: Xylon framebuffer driver binding
Message-Id: <8195d8ed-e97c-4a77-8a0d-7d8dd6f199b4@mail.xylon.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
In-Reply-To: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, geert@linux-m68k.org
Cc: Davor Joja <davorjoja@logicbricks.com>

Xylon framebuffer driver binding description.

Signed-off-by: Davor Joja <davorjoja@logicbricks.com>
---
 .../devicetree/bindings/video/xylon-fb.txt         | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/video/xylon-fb.txt

diff --git a/Documentation/devicetree/bindings/video/xylon-fb.txt b/Documentation/devicetree/bindings/video/xylon-fb.txt
new file mode 100644
index 0000000..665166f
--- /dev/null
+++ b/Documentation/devicetree/bindings/video/xylon-fb.txt
@@ -0,0 +1,52 @@
+Binding for Xylon FB driver
+
+Xylon FB driver supports Xylon configurable video controller
+logiCVC FPGA IP core device.
+
+Required properties:
+ - compatible: value must be "xylon,fb-3.00.a"
+ - device: the phandle for logiCVC video controller device
+
+Optional properties:
+ - clocks: the phandle for the pixel clock generator
+ - console-layer: layer ID for FB console (0 - 4)
+      If omitted, FB console started on default layer ID 0.
+      Note: FB console can be started only on layer configured with one
+      of parameters combination below:
+      ===================
+      bits-per-pixel    type    transparency
+      ===================
+             8           yuv       clut32
+             8           rgb       clut16
+             8           rgb       clut32
+             8           rgb       layer
+            16           rgb       layer
+            32           rgb       layer
+            32           rgb       pixel
+      ===================
+
+ - edid-video-mode: video mode set to preferred EDID resolution
+      If omitted, configured according to "video-mode" property.
+ - edid-print: prints EDID description in system log
+      Must be used only with "edid-video-mode".
+      If omitted, functionality is not available.
+ - vsync-irq: generate interrupt on vertical synchronization pulse
+ - video-mode: preferred video mode resolution
+      If omitted, configures logiCVC to default video resolution "1024x768".
+   - M: Coordinated Video Timings (CVT)
+   - R: reduced video timings for digital displays
+   - i: calculate for an interlaced mode
+   - m: add margins to calculation calculation
+        (1.8% of xres rounded down to 8 pixels and 1.8% of yres).
+Example:
+
+	xylon_fb {
+		compatible = "xylon,fb-3.00.a";
+		clocks = <&clkout_0>;
+		device = <&logicvc_0>;
+		console-layer = <0>;
+		edid-video-mode;
+		edid-print;
+		vsync-irq;
+		video-mode = "1920x1080MR";
+	};
\ No newline at end of file
-- 
1.9.1

