From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:07:53 +0000
Subject: [PATCH 1009/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120753.17355-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com, bp@suse.de, mcgrof@suse.com, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/i740fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/i740fb.c b/drivers/video/fbdev/i740fb.c
index cf5ccd0..5cc240c 100644
--- a/drivers/video/fbdev/i740fb.c
+++ b/drivers/video/fbdev/i740fb.c
@@ -1301,8 +1301,8 @@ MODULE_AUTHOR("(c) 2011 Ondrej Zary <linux@rainbow-software.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("fbdev driver for Intel740");
 
-module_param(mode_option, charp, 0444);
+module_param(mode_option, charp, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode_option, "Default video mode ('640x480-8@60', etc)");
 
-module_param(mtrr, int, 0444);
+module_param(mtrr, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mtrr, "Enable write-combining with MTRR (1=enable, 0=disable, default=1)");
-- 
2.9.2

