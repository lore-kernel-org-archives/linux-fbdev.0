From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 10:21:08 +0000
Subject: [PATCH v3 3/8] video: exynos_dp: Get pll lock before pattern set
Message-Id: <011f01cdb81a$9bf1fbc0$d3d5f340$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

According to the exynos datasheet (Figure 49-10), we should wait for PLL
lock before programming the training pattern when doing software eDP
link training.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 13bb10d..878b4b6 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -264,7 +264,7 @@ static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
 static int exynos_dp_link_start(struct exynos_dp_device *dp)
 {
 	u8 buf[4];
-	int lane, lane_count, retval;
+	int lane, lane_count, pll_tries, retval;
 
 	lane_count = dp->link_train.lane_count;
 
@@ -297,6 +297,18 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 		exynos_dp_set_lane_lane_pre_emphasis(dp,
 			PRE_EMPHASIS_LEVEL_0, lane);
 
+	/* Wait for PLL lock */
+	pll_tries = 0;
+	while (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED) {
+		if (pll_tries = DP_TIMEOUT_LOOP_COUNT) {
+			dev_err(dp->dev, "Wait for PLL lock timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		pll_tries++;
+		usleep_range(90, 120);
+	}
+
 	/* Set training pattern 1 */
 	exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
 
-- 
1.7.1


