From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:08:49 +0000
Subject: [PATCH 1018/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120849.17964-1-baolex.ni@intel.com>
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
 drivers/video/fbdev/sm501fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index d0a4e2f..60fcda1 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1215,7 +1215,7 @@ static ssize_t sm501fb_crtsrc_store(struct device *dev,
 }
 
 /* Prepare the device_attr for registration with sysfs later */
-static DEVICE_ATTR(crt_src, 0664, sm501fb_crtsrc_show, sm501fb_crtsrc_store);
+static DEVICE_ATTR(crt_src, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, sm501fb_crtsrc_show, sm501fb_crtsrc_store);
 
 /* sm501fb_show_regs
  *
@@ -1252,7 +1252,7 @@ static ssize_t sm501fb_debug_show_crt(struct device *dev,
 	return ptr - buf;
 }
 
-static DEVICE_ATTR(fbregs_crt, 0444, sm501fb_debug_show_crt, NULL);
+static DEVICE_ATTR(fbregs_crt, S_IRUSR | S_IRGRP | S_IROTH, sm501fb_debug_show_crt, NULL);
 
 /* sm501fb_debug_show_pnl
  *
@@ -1271,7 +1271,7 @@ static ssize_t sm501fb_debug_show_pnl(struct device *dev,
 	return ptr - buf;
 }
 
-static DEVICE_ATTR(fbregs_pnl, 0444, sm501fb_debug_show_pnl, NULL);
+static DEVICE_ATTR(fbregs_pnl, S_IRUSR | S_IRGRP | S_IROTH, sm501fb_debug_show_pnl, NULL);
 
 /* acceleration operations */
 static int sm501fb_sync(struct fb_info *info)
-- 
2.9.2

