From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:08:56 +0000
Subject: [PATCH 1019/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120856.18032-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/tdfxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 621fa44..c09ff44 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1645,7 +1645,7 @@ MODULE_AUTHOR("Hannu Mallat <hmallat@cc.hut.fi>");
 MODULE_DESCRIPTION("3Dfx framebuffer device driver");
 MODULE_LICENSE("GPL");
 
-module_param(hwcursor, int, 0644);
+module_param(hwcursor, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
 module_param(mode_option, charp, 0);
-- 
2.9.2

