From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 04 Apr 2012 07:00:00 +0000
Subject: [PATCH] video: exynos_dp: replace char pointer with char array for adjust_request variable
Message-Id: <001501cd1230$8d4211e0$a7c635a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The char pointer for adjust_request variable is replaced with char array
to fix possible null pointer dereference when clock recovery is failed.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 2a4481c..6e9f3ce 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -478,7 +478,7 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 	int lane_count;
 	u8 buf[5];
 
-	u8 *adjust_request;
+	u8 adjust_request[2];
 	u8 voltage_swing;
 	u8 pre_emphasis;
 	u8 training_lane;
@@ -493,8 +493,8 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
 		/* set training pattern 2 for EQ */
 		exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
 
-		adjust_request = link_status + (DPCD_ADDR_ADJUST_REQUEST_LANE0_1
-						- DPCD_ADDR_LANE0_1_STATUS);
+		adjust_request[0] = link_status[4];
+		adjust_request[1] = link_status[5];
 
 		exynos_dp_get_adjust_train(dp, adjust_request);
 
@@ -566,7 +566,7 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 	u8 buf[5];
 	u32 reg;
 
-	u8 *adjust_request;
+	u8 adjust_request[2];
 
 	udelay(400);
 
@@ -575,8 +575,8 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 	lane_count = dp->link_train.lane_count;
 
 	if (exynos_dp_clock_recovery_ok(link_status, lane_count) = 0) {
-		adjust_request = link_status + (DPCD_ADDR_ADJUST_REQUEST_LANE0_1
-						- DPCD_ADDR_LANE0_1_STATUS);
+		adjust_request[0] = link_status[4];
+		adjust_request[1] = link_status[5];
 
 		if (exynos_dp_channel_eq_ok(link_status, lane_count) = 0) {
 			/* traing pattern Set to Normal */
-- 
1.7.1


