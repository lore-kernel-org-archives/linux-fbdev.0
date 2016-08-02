From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:07:25 +0000
Subject: [PATCH 1005/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120725.17083-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/carminefb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/carminefb.c b/drivers/video/fbdev/carminefb.c
index 65f7c15..8481cb8 100644
--- a/drivers/video/fbdev/carminefb.c
+++ b/drivers/video/fbdev/carminefb.c
@@ -33,11 +33,11 @@
 #define CARMINEFB_DEFAULT_VIDEO_MODE	1
 
 static unsigned int fb_mode = CARMINEFB_DEFAULT_VIDEO_MODE;
-module_param(fb_mode, uint, 0444);
+module_param(fb_mode, uint, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fb_mode, "Initial video mode as integer.");
 
 static char *fb_mode_str;
-module_param(fb_mode_str, charp, 0444);
+module_param(fb_mode_str, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fb_mode_str, "Initial video mode in characters.");
 
 /*
@@ -47,7 +47,7 @@ MODULE_PARM_DESC(fb_mode_str, "Initial video mode in characters.");
  * 0b010 Display 1
  */
 static int fb_displays = CARMINE_USE_DISPLAY0 | CARMINE_USE_DISPLAY1;
-module_param(fb_displays, int, 0444);
+module_param(fb_displays, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fb_displays, "Bit mode, which displays are used");
 
 struct carmine_hw {
-- 
2.9.2

