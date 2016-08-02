From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:08:43 +0000
Subject: [PATCH 1017/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120843.17896-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, bp@suse.de, mcgrof@suse.com, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/s3fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 13b1090..d51e85c 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -158,14 +158,14 @@ MODULE_AUTHOR("(c) 2006-2007 Ondrej Zajicek <santiago@crfreenet.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("fbdev driver for S3 Trio/Virge");
 
-module_param(mode_option, charp, 0444);
+module_param(mode_option, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
-module_param_named(mode, mode_option, charp, 0444);
+module_param_named(mode, mode_option, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode, "Default video mode ('640x480-8@60', etc) (deprecated)");
-module_param(mtrr, int, 0444);
+module_param(mtrr, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, default=1)");
 
-module_param(fasttext, int, 0644);
+module_param(fasttext, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(fasttext, "Enable S3 fast text mode (1=enable, 0=disable, default=1)");
 
 
-- 
2.9.2

