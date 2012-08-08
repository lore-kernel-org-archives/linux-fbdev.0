From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:18 +0000
Subject: [PATCH 04/10] video: exynos_dp: Get pll lock before pattern set
Message-Id: <1344398064-13563-5-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

According to the exynos datasheet (Figure 49-10), we should wait for PLL
lock before programming the training pattern when doing software eDP
link training.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Mandeep Singh Baines <msb@chromium.org>
---
 drivers/video/exynos/exynos_dp_core.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 3deded2..207bd7e 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -23,6 +23,8 @@
 
 #include "exynos_dp_core.h"
 
+#define PLL_MAX_TRIES 100
+
 static int exynos_dp_init_dp(struct exynos_dp_device *dp)
 {
 	exynos_dp_reset(dp);
@@ -260,7 +262,7 @@ static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
 
 static int exynos_dp_link_start(struct exynos_dp_device *dp)
 {
-	int ret, lane, lane_count;
+	int ret, lane, lane_count, pll_tries;
 	u8 buf[4];
 
 	lane_count = dp->link_train.lane_count;
@@ -293,6 +295,16 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 		exynos_dp_set_lane_lane_pre_emphasis(dp,
 			PRE_EMPHASIS_LEVEL_0, lane);
 
+	/* Wait for PLL lock */
+	pll_tries = 0;
+	while (exynos_dp_get_pll_lock_status(dp) = PLL_UNLOCKED) {
+		if (pll_tries = PLL_MAX_TRIES)
+			return -ETIMEDOUT;
+
+		pll_tries++;
+		udelay(100);
+	}
+
 	/* Set training pattern 1 */
 	exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
 
-- 
1.7.7.3

