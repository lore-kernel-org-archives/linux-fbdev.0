From: Jason Yan <yanaijie@huawei.com>
Date: Thu, 27 Aug 2020 13:00:08 +0000
Subject: [PATCH] video: fbdev: remove set but not used 'ulBestVCO'
Message-Id: <20200827130008.428706-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com, yanaijie@huawei.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>

This addresses the following gcc warning with "make W=1":

drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
‘ProgramClock’:
drivers/video/fbdev/kyro/STG4000InitDevice.c:123:6: warning: variable
‘ulBestVCO’ set but not used [-Wunused-but-set-variable]
  123 |  u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
      |      ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/kyro/STG4000InitDevice.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index edaeec2d9590..21875d3c2dc2 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -120,7 +120,7 @@ u32 ProgramClock(u32 refClock,
 {
 	u32 R = 0, F = 0, OD = 0, ODIndex = 0;
 	u32 ulBestR = 0, ulBestF = 0, ulBestOD = 0;
-	u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
+	u32 ulBestClk = 0, ulBestScore = 0;
 	u32 ulScore, ulPhaseScore, ulVcoScore;
 	u32 ulTmp = 0, ulVCO;
 	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
@@ -189,7 +189,6 @@ u32 ProgramClock(u32 refClock,
 						ulScore = ulPhaseScore + ulVcoScore;
 
 						if (!ulBestScore) {
-							ulBestVCO = ulVCO;
 							ulBestOD = OD;
 							ulBestF = F;
 							ulBestR = R;
@@ -206,7 +205,6 @@ u32 ProgramClock(u32 refClock,
                           but we shall keep this code in case new restrictions come into play
                           --------------------------------------------------------------------------*/
 						if ((ulScore >= ulBestScore) && (OD > 0)) {
-							ulBestVCO = ulVCO;
 							ulBestOD = OD;
 							ulBestF = F;
 							ulBestR = R;
-- 
2.25.4
