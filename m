From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:08:11 +0000
Subject: [PATCH 1012/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120811.17558-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, robdclark@gmail.com, airlied@gmail.com, peter.ujfalusi@ti.com, dan.carpenter@oracle.com, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index d63e598..f3711a7 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -405,7 +405,7 @@ static const struct of_device_id dsi_of_match[];
 
 #ifdef DSI_PERF_MEASURE
 static bool dsi_perf;
-module_param(dsi_perf, bool, 0644);
+module_param(dsi_perf, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 #endif
 
 static inline struct dsi_data *dsi_get_dsidrv_data(struct platform_device *dsidev)
-- 
2.9.2

