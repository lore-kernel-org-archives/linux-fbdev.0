From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:07:46 +0000
Subject: [PATCH 1008/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120746.17287-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-geode@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, linus.walleij@linaro.org, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/geode/gx1fb_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
index 9bee874..51f70e3 100644
--- a/drivers/video/fbdev/geode/gx1fb_core.c
+++ b/drivers/video/fbdev/geode/gx1fb_core.c
@@ -461,13 +461,13 @@ static void gx1fb_cleanup(void)
 module_init(gx1fb_init);
 module_exit(gx1fb_cleanup);
 
-module_param_string(mode, mode_option, sizeof(mode_option), 0444);
+module_param_string(mode, mode_option, sizeof(mode_option), S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode, "video mode (<x>x<y>[-<bpp>][@<refr>])");
 
-module_param_named(crt, crt_option, int, 0444);
+module_param_named(crt, crt_option, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(crt, "enable CRT output. 0 = off, 1 = on (default)");
 
-module_param_string(panel, panel_option, sizeof(panel_option), 0444);
+module_param_string(panel, panel_option, sizeof(panel_option), S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(panel, "size of attached flat panel (<x>x<y>)");
 
 MODULE_DESCRIPTION("framebuffer driver for the AMD Geode GX1");
-- 
2.9.2

