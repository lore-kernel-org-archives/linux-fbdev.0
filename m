From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:07:40 +0000
Subject: [PATCH 1007/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120740.17219-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, hsweeten@visionengravers.com, mcgrof@suse.com, olof@lixom.net, linus.walleij@linaro.org, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/ep93xx-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 75f0db2..ad824d3 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -119,7 +119,7 @@ struct ep93xx_fbi {
 };
 
 static int check_screenpage_bug = 1;
-module_param(check_screenpage_bug, int, 0644);
+module_param(check_screenpage_bug, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(check_screenpage_bug,
 		 "Check for bit 27 screen page bug. Default = 1");
 
-- 
2.9.2

