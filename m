From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Fri, 02 Apr 2010 18:57:38 +0000
Subject: [PATCH] mb862xxfb: fix acceleration module license
Message-Id: <20100402115738.b7adabf0.randy.dunlap@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

mb862xxfb_accel built as a separate module, but it does not
have a MODULE_LICENSE, so it taints the kernel.  Add a
MODULE_LICENSE to it (same as mb862xxfb license).

mb862xxfb_accel: module license 'unspecified' taints kernel.

or should mb862xxfb_accel be built into the mb862xxfb
binary file instead?

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
Cc: Valentin Sitdikov <valentin.sitdikov@siemens.com>
---
 drivers/video/mb862xx/mb862xxfb_accel.c |    3 +++
 1 file changed, 3 insertions(+)

--- lnx-2634-rc3.orig/drivers/video/mb862xx/mb862xxfb_accel.c
+++ lnx-2634-rc3/drivers/video/mb862xx/mb862xxfb_accel.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #if defined(CONFIG_OF)
 #include <linux/of_platform.h>
@@ -329,3 +330,5 @@ void mb862xxfb_init_accel(struct fb_info
 	info->fix.accel = 0xff;	/*FIXME: add right define */
 }
 EXPORT_SYMBOL(mb862xxfb_init_accel);
+
+MODULE_LICENSE("GPL v2");
