From: Marcin Slusarz <marcin.slusarz@gmail.com>
Date: Tue, 20 Jul 2010 19:19:23 +0000
Subject: [PATCH] vga16fb: refuse to load in face of other driver
Message-Id: <20100720191923.GA11056@joi.lan>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org

We don't want vga16fb to mess with hardware initialized by other driver.
Detect it and refuse to load.
It fixes nouveau interrupt storm on some machines.

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
---
 drivers/video/vga16fb.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index 28ccab4..4505446 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
 
+#include <asm/fb.h>
 #include <asm/io.h>
 #include <video/vga.h>
 
@@ -1415,7 +1416,7 @@ static struct platform_device *vga16fb_device;
 
 static int __init vga16fb_init(void)
 {
-	int ret;
+	int ret, i;
 #ifndef MODULE
 	char *option = NULL;
 
@@ -1424,6 +1425,16 @@ static int __init vga16fb_init(void)
 
 	vga16fb_setup(option);
 #endif
+	for (i = 0 ; i < FB_MAX; i++) {
+		if (!registered_fb[i])
+			continue;
+		if (fb_is_primary_device(registered_fb[i])) {
+			printk(KERN_INFO "vga16fb: %s is driving the primary card, refusing to load\n",
+				registered_fb[i]->fix.id);
+			return -EBUSY;
+		}
+	}
+
 	ret = platform_driver_register(&vga16fb_driver);
 
 	if (!ret) {
-- 
1.7.1


