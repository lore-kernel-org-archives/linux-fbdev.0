From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:08:00 +0000
Subject: [PATCH 1010/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120800.17423-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, luis@debethencourt.com, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
index f9ec5c0..cc19dc8 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
@@ -579,7 +579,7 @@ static ssize_t mb862xxfb_show_dispregs(struct device *dev,
 	return ptr - buf;
 }
 
-static DEVICE_ATTR(dispregs, 0444, mb862xxfb_show_dispregs, NULL);
+static DEVICE_ATTR(dispregs, S_IRUSR | S_IRGRP | S_IROTH, mb862xxfb_show_dispregs, NULL);
 
 static irqreturn_t mb862xx_intr(int irq, void *dev_id)
 {
-- 
2.9.2

