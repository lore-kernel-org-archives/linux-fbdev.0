From: yu kuai <yukuai3@huawei.com>
Date: Sun, 19 Jan 2020 12:19:45 +0000
Subject: [PATCH] video: remove set but not used variable 'ulScaleRight'
Message-Id: <20200119121945.12517-1-yukuai3@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zhengbin13@huawei.com, yukuai3@huawei.com

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/kyro/STG4000OverlayDevice.c: In function
‘SetOverlayViewPort’:
drivers/video/fbdev/kyro/STG4000OverlayDevice.c:334:19: warning:
variable ‘ulScaleRight’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 0aeeaa10708b..9fde0e3b69ec 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -331,7 +331,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 	u32 ulScale;
 	u32 ulLeft, ulRight;
 	u32 ulSrcLeft, ulSrcRight;
-	u32 ulScaleLeft, ulScaleRight;
+	u32 ulScaleLeft;
 	u32 ulhDecim;
 	u32 ulsVal;
 	u32 ulVertDecFactor;
@@ -470,7 +470,6 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		 * round down the pixel pos to the nearest 8 pixels.
 		 */
 		ulScaleLeft = ulSrcLeft;
-		ulScaleRight = ulSrcRight;
 
 		/* shift fxscale until it is in the range of the scaler */
 		ulhDecim = 0;
-- 
2.17.2
