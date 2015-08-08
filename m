From: Petr Cvek <petr.cvek@tul.cz>
Date: Sat, 08 Aug 2015 18:20:20 +0000
Subject: [PATCH v1, TRIVIAL] Fix pxafb nonstd field documentation and add errata info
Message-Id: <55C64864.6070405@tul.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Fix pxafb nonstd field documentation and add warning comment to Kconfig
and pxafb.c (errata: YUV420 hangs LCD).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 Documentation/fb/pxafb.txt  | 8 ++++----
 drivers/video/fbdev/Kconfig | 5 +++++
 drivers/video/fbdev/pxafb.c | 4 ++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/fb/pxafb.txt b/Documentation/fb/pxafb.txt
index d143a0a..dbbf5eb 100644
--- a/Documentation/fb/pxafb.txt
+++ b/Documentation/fb/pxafb.txt
@@ -123,12 +123,12 @@ Overlay Support for PXA27x and later LCD controllers
      framebuffer framework, application has to take care of the offsets
      and lengths of each component within the framebuffer.
 
-  4. var->nonstd is used to pass starting (x, y) position and color format,
+  4. var->nonstd is used to pass starting (y, x) position and color format,
      the detailed bit fields are shown below:
 
     31                23  20         10          0
      +-----------------+---+----------+----------+
-     |  ... unused ... |FOR|   XPOS   |   YPOS   |
+     |  ... unused ... |FOR|   YPOS   |   XPOS   | (as in OVLxC2 register)
      +-----------------+---+----------+----------+
 
      FOR  - color format, as defined by OVERLAY_FORMAT_* in pxafb.h
@@ -136,7 +136,7 @@ Overlay Support for PXA27x and later LCD controllers
 	    1 - YUV444 PACKED
 	    2 - YUV444 PLANAR
 	    3 - YUV422 PLANAR
-	    4 - YUR420 PLANAR
+	    4 - YUV420 PLANAR
 
-     XPOS - starting horizontal position
      YPOS - starting vertical position
+     XPOS - starting horizontal position
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2d98de5..8f485ec 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1893,6 +1893,11 @@ config FB_PXA_OVERLAY
 	bool "Support PXA27x/PXA3xx Overlay(s) as framebuffer"
 	default n
 	depends on FB_PXA && (PXA27x || PXA3xx)
+	---help---
+	  Using the overlay 2 and YUV420 mode on a PXA27x C0 chip revision will
+	  hang the LCD until the next SoC restart (errata E24).
+
+	  If unsure, say N or check /proc/cpuinfo for "CPU revision : 4".
 
 config FB_PXA_SMARTPANEL
 	bool "PXA Smartpanel LCD support"
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 7245611..e573699 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -30,6 +30,10 @@
  *
  *   Copyright (C) 2006-2008 Marvell International Ltd.
  *   All Rights Reserved
+ *
+ * NOTICE
+ * According to PXA27x errata E24 an enable of the overlay 2 in YUV420 mode
+ * on C0 chip revision will hang the LCD until the next SoC reset.
  */
 
 #include <linux/module.h>
-- 
1.7.12.1


