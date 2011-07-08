From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 08 Jul 2011 09:04:38 +0000
Subject: [PATCH] carminefb: Fix module parameters permissions
Message-Id: <201107081104.38854.jdelvare@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The third parameter of module_param is supposed to be an octal value.
The missing leading "0" causes the following:

$ ls -l /sys/module/carminefb/parameters/
total 0
-rw-rwxr-- 1 root root 4096 Jul  8 08:55 fb_displays
-rw-rwxr-- 1 root root 4096 Jul  8 08:55 fb_mode
-rw-rwxr-- 1 root root 4096 Jul  8 08:55 fb_mode_str

After fixing the perm parameter, we get the expected:

$ ls -l /sys/module/carminefb/parameters/
total 0
-r--r--r-- 1 root root 4096 Jul  8 08:56 fb_displays
-r--r--r-- 1 root root 4096 Jul  8 08:56 fb_mode
-r--r--r-- 1 root root 4096 Jul  8 08:56 fb_mode_str

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: stable@kernel.org
---
 drivers/video/carminefb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-3.0-rc6.orig/drivers/video/carminefb.c	2011-07-08 08:47:52.000000000 +0200
+++ linux-3.0-rc6/drivers/video/carminefb.c	2011-07-08 08:55:21.000000000 +0200
@@ -32,11 +32,11 @@
 #define CARMINEFB_DEFAULT_VIDEO_MODE	1
 
 static unsigned int fb_mode = CARMINEFB_DEFAULT_VIDEO_MODE;
-module_param(fb_mode, uint, 444);
+module_param(fb_mode, uint, 0444);
 MODULE_PARM_DESC(fb_mode, "Initial video mode as integer.");
 
 static char *fb_mode_str;
-module_param(fb_mode_str, charp, 444);
+module_param(fb_mode_str, charp, 0444);
 MODULE_PARM_DESC(fb_mode_str, "Initial video mode in characters.");
 
 /*
@@ -46,7 +46,7 @@ MODULE_PARM_DESC(fb_mode_str, "Initial v
  * 0b010 Display 1
  */
 static int fb_displays = CARMINE_USE_DISPLAY0 | CARMINE_USE_DISPLAY1;
-module_param(fb_displays, int, 444);
+module_param(fb_displays, int, 0444);
 MODULE_PARM_DESC(fb_displays, "Bit mode, which displays are used");
 
 struct carmine_hw {

-- 
Jean Delvare
Suse L3
