From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:52 +0000
Subject: [PATCH 1000/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120652.16743-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/bf537-lq035.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/bf537-lq035.c b/drivers/video/fbdev/bf537-lq035.c
index ef29fb4..a0c869f 100644
--- a/drivers/video/fbdev/bf537-lq035.c
+++ b/drivers/video/fbdev/bf537-lq035.c
@@ -66,7 +66,7 @@ MODULE_PARM_DESC(bgr,
 	"BGR use 16-bit BGR-565 instead of RGB-565");
 
 static int nocursor = 1;
-module_param(nocursor, int, 0644);
+module_param(nocursor, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nocursor, "cursor enable/disable");
 
 static unsigned long current_brightness;  /* backlight */
-- 
2.9.2

