From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 17 Jul 2015 13:33:18 +0000
Subject: [PATCH 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <1437139280-7375-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Now since all cleanups are done and the code is ready to be merged lets
move it out of staging into fbdev location.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/Kconfig                                    |  2 --
 drivers/staging/Makefile                                   |  1 -
 drivers/staging/sm7xxfb/Kconfig                            | 13 -------------
 drivers/staging/sm7xxfb/Makefile                           |  1 -
 drivers/staging/sm7xxfb/TODO                               | 12 ------------
 drivers/video/fbdev/Kconfig                                | 14 ++++++++++++++
 drivers/video/fbdev/Makefile                               |  1 +
 drivers/{staging/sm7xxfb/sm7xx.h => video/fbdev/sm712.h}   |  0
 .../{staging/sm7xxfb/sm7xxfb.c => video/fbdev/sm712fb.c}   |  2 +-
 9 files changed, 16 insertions(+), 30 deletions(-)
 delete mode 100644 drivers/staging/sm7xxfb/Kconfig
 delete mode 100644 drivers/staging/sm7xxfb/Makefile
 delete mode 100644 drivers/staging/sm7xxfb/TODO
 rename drivers/{staging/sm7xxfb/sm7xx.h => video/fbdev/sm712.h} (100%)
 rename drivers/{staging/sm7xxfb/sm7xxfb.c => video/fbdev/sm712fb.c} (99%)

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7f6cae5..a969276 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -56,8 +56,6 @@ source "drivers/staging/vt6656/Kconfig"
 
 source "drivers/staging/iio/Kconfig"
 
-source "drivers/staging/sm7xxfb/Kconfig"
-
 source "drivers/staging/sm750fb/Kconfig"
 
 source "drivers/staging/xgifb/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 347f647..2747c82 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_VT6655)		+= vt6655/
 obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_IIO)		+= iio/
-obj-$(CONFIG_FB_SM7XX)		+= sm7xxfb/
 obj-$(CONFIG_FB_SM750)		+= sm750fb/
 obj-$(CONFIG_FB_XGI)		+= xgifb/
 obj-$(CONFIG_USB_EMXX)		+= emxx_udc/
diff --git a/drivers/staging/sm7xxfb/Kconfig b/drivers/staging/sm7xxfb/Kconfig
deleted file mode 100644
index e2922ae..0000000
--- a/drivers/staging/sm7xxfb/Kconfig
+++ /dev/null
@@ -1,13 +0,0 @@
-config FB_SM7XX
-	tristate "Silicon Motion SM7XX framebuffer support"
-	depends on FB && PCI
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  Frame buffer driver for the Silicon Motion SM710, SM712, SM721
-	  and SM722 chips.
-
-	  This driver is also available as a module. The module will be
-	  called sm7xxfb. If you want to compile it as a module, say M
-	  here and read <file:Documentation/kbuild/modules.txt>.
diff --git a/drivers/staging/sm7xxfb/Makefile b/drivers/staging/sm7xxfb/Makefile
deleted file mode 100644
index 48f471c..0000000
--- a/drivers/staging/sm7xxfb/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_FB_SM7XX) += sm7xxfb.o
diff --git a/drivers/staging/sm7xxfb/TODO b/drivers/staging/sm7xxfb/TODO
deleted file mode 100644
index 7cb0b24..0000000
--- a/drivers/staging/sm7xxfb/TODO
+++ /dev/null
@@ -1,12 +0,0 @@
-TODO:
-- Dual head support
-- 2D acceleration support
-- use kernel coding style
-- refine the code and remove unused code
-- move it to drivers/video/fbdev/sm7xxfb.c
-
-Please send any patches to
-	Greg Kroah-Hartman <greg@kroah.com>
-	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
-	Teddy Wang <teddy.wang@siliconmotion.com>
-	Sudip Mukherjee <sudip@vectorindia.org>
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2d98de5..2307909 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2475,3 +2475,17 @@ config FB_SSD1307
 	help
 	  This driver implements support for the Solomon SSD1307
 	  OLED controller over I2C.
+
+config FB_SM712
+	tristate "Silicon Motion SM712 framebuffer support"
+	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  Frame buffer driver for the Silicon Motion SM710, SM712, SM721
+	  and SM722 chips.
+
+	  This driver is also available as a module. The module will be
+	  called sm712fb. If you want to compile it as a module, say M
+	  here and read <file:Documentation/kbuild/modules.txt>.
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index cecea50..50ed1b4 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_FB_JZ4740)		  += jz4740_fb.o
 obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
 obj-$(CONFIG_FB_HYPERV)		  += hyperv_fb.o
 obj-$(CONFIG_FB_OPENCORES)	  += ocfb.o
+obj-$(CONFIG_FB_SM712)		  += sm712fb.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/video/fbdev/sm712.h
similarity index 100%
rename from drivers/staging/sm7xxfb/sm7xx.h
rename to drivers/video/fbdev/sm712.h
diff --git a/drivers/staging/sm7xxfb/sm7xxfb.c b/drivers/video/fbdev/sm712fb.c
similarity index 99%
rename from drivers/staging/sm7xxfb/sm7xxfb.c
rename to drivers/video/fbdev/sm712fb.c
index 07c2199..629bfa2 100644
--- a/drivers/staging/sm7xxfb/sm7xxfb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -32,7 +32,7 @@
 #include <linux/pm.h>
 #endif
 
-#include "sm7xx.h"
+#include "sm712.h"
 
 /*
 * Private structure
-- 
1.8.1.2

