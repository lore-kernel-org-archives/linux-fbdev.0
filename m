From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:38 +0000
Subject: [PATCH 0998/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120638.16607-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, bp@suse.de, mcgrof@suse.com, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/arkfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 6a317de..5fe2922 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -102,14 +102,14 @@ MODULE_AUTHOR("(c) 2007 Ondrej Zajicek <santiago@crfreenet.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("fbdev driver for ARK 2000PV");
 
-module_param(mode_option, charp, 0444);
+module_param(mode_option, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
-module_param_named(mode, mode_option, charp, 0444);
+module_param_named(mode, mode_option, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc) (deprecated)");
 
 static int threshold = 4;
 
-module_param(threshold, int, 0644);
+module_param(threshold, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(threshold, "FIFO threshold");
 
 
-- 
2.9.2

