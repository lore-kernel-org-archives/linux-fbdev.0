From: H Hartley Sweeten <hartleys@visionengravers.com>
Date: Thu, 03 May 2012 00:47:26 +0000
Subject: [PATCH] backlight: apple_bl.c: include header for exported symbol prototypes
Message-Id: <201205021747.26813.hartleys@visionengravers.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-fbdev@vger.kernel.org, rpurdie@rpsys.net, FlorianSchandinat@gmx.de

Include the header to pickup the exported symbol prototype.

Quites the sparse warning:

warning: symbol 'apple_bl_register' was not declared. Should it be static?
warning: symbol 'apple_bl_unregister' was not declared. Should it be static?

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

---

diff --git a/drivers/video/backlight/apple_bl.c b/drivers/video/backlight/apple_bl.c
index a523b25..ef5ca0d 100644
--- a/drivers/video/backlight/apple_bl.c
+++ b/drivers/video/backlight/apple_bl.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/atomic.h>
+#include <linux/apple_bl.h>
 
 static struct backlight_device *apple_backlight_device;
 
