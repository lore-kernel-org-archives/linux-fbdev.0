From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Sun, 26 Feb 2012 13:52:02 +0000
Subject: [PATCH] pxafb: do console locking before calling fb_blank()
Message-Id: <1330264322-5938-1-git-send-email-anarsoul@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Otherwise we hit WARN_CONSOLE_UNLOCKED in do_unblank_screen

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/video/pxafb.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 1d1e4f1..c176561 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -54,6 +54,7 @@
 #include <linux/mutex.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/console.h>
 
 #include <mach/hardware.h>
 #include <asm/io.h>
@@ -730,9 +731,12 @@ static int overlayfb_open(struct fb_info *info, int user)
 	if (user = 0)
 		return -ENODEV;
 
-	if (ofb->usage++ = 0)
+	if (ofb->usage++ = 0) {
 		/* unblank the base framebuffer */
+		console_lock();
 		fb_blank(&ofb->fbi->fb, FB_BLANK_UNBLANK);
+		console_unlock();
+	}
 
 	return 0;
 }
-- 
1.7.9.2

