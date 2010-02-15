From: Bernie Thompson <bernie@plugable.com>
Date: Mon, 15 Feb 2010 14:46:35 +0000
Subject: [PATCH 9/10] udlfb: explicit dependencies and warnings
Message-Id: <1266245195.4353.3304.camel@bernie-aspireone>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Specify Kconfig dependencies, and include warnings for building as a module

udlfb is dependent on FB_DEFERRED_IO, FB_SYS_*, and FB_MODE_HELPERS

Because many kernels do not include defio (which cannot be built
as a module), yet users want to be able to build udlfb as a module later,
udlfb has ifdefs and these dependency warnings to help udlfb build with or
without certain dependencies, but also print warnings for any lost function.

Even though this kind of flexibility isn't common, we've gotten feedback
from a significant portion of users that they were frustrated without it.

Signed-off-by: Bernie Thompson <bernie@plugable.com>
---
 drivers/staging/udlfb/Kconfig |   14 ++++++++++----
 drivers/staging/udlfb/udlfb.c |   14 ++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

Index: linux-next/drivers/staging/udlfb/Kconfig
=================================--- linux-next.orig/drivers/staging/udlfb/Kconfig	2010-02-14 20:21:30.000000000 -0800
+++ linux-next/drivers/staging/udlfb/Kconfig	2010-02-14 20:27:02.000000000 -0800
@@ -1,8 +1,14 @@
 config FB_UDL
 	tristate "Displaylink USB Framebuffer support"
 	depends on FB && USB
+	select FB_MODE_HELPERS
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
 	---help---
-	  This is an experimental driver for DisplayLink USB devices
-	  that provides a framebuffer device.  A normal framebuffer can
-	  be used with this driver, or xorg can be run on the device
-	  using it.
+	  This is a kernel framebuffer driver for DisplayLink USB devices.
+	  Supports fbdev clients like xf86-video-fbdev, kdrive, fbi, and
+	  mplayer -vo fbdev. Supports all USB 2.0 era DisplayLink devices.
+	  To compile as a module, choose M here: the module name is udlfb.
Index: linux-next/drivers/staging/udlfb/udlfb.c
=================================--- linux-next.orig/drivers/staging/udlfb/udlfb.c	2010-02-14 20:27:01.000000000 -0800
+++ linux-next/drivers/staging/udlfb/udlfb.c	2010-02-14 20:27:02.000000000 -0800
@@ -56,6 +56,20 @@ static struct usb_device_id id_table[]  };
 MODULE_DEVICE_TABLE(usb, id_table);
 
+#ifndef CONFIG_FB_DEFERRED_IO
+#warning message "kernel FB_DEFFERRED_IO option to support generic fbdev apps"
+#endif
+
+#ifndef CONFIG_FB_SYS_IMAGEBLIT
+#ifndef CONFIG_FB_SYS_IMAGEBLIT_MODULE
+#warning message "FB_SYS_* in kernel or module option to support fb console"
+#endif
+#endif
+
+#ifndef CONFIG_FB_MODE_HELPERS
+#warning message "kernel FB_MODE_HELPERS required. Expect build break"
+#endif
+
 /* dlfb keeps a list of urbs for efficient bulk transfers */
 static void dlfb_urb_completion(struct urb *urb);
 static struct urb *dlfb_get_urb(struct dlfb_data *dev);


