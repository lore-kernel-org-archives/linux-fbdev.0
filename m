From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:07:12 +0000
Subject: [PATCH 1003/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120712.16947-1-baolex.ni@intel.com>
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
 drivers/video/fbdev/bfin-t350mcqb-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/bfin-t350mcqb-fb.c b/drivers/video/fbdev/bfin-t350mcqb-fb.c
index e5ee4d9..2f251f7 100644
--- a/drivers/video/fbdev/bfin-t350mcqb-fb.c
+++ b/drivers/video/fbdev/bfin-t350mcqb-fb.c
@@ -95,7 +95,7 @@ struct bfin_t350mcqbfb_info {
 };
 
 static int nocursor;
-module_param(nocursor, int, 0644);
+module_param(nocursor, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nocursor, "cursor enable/disable");
 
 #define PPI_TX_MODE		0x2
-- 
2.9.2

