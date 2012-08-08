From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:19 +0000
Subject: [PATCH 05/10] video: exynos_dp: Remove sink control to D0
Message-Id: <1344398064-13563-6-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Don't reset the sink power to D0. Removing this for three reasons:

1) It's not required in the SW link training documentation
2) The comment is incorrect, D0 is normal operation, not "power down"
3) It seems to change things in the link training that causes glitches

Signed-off-by: Sean Paul <seanpaul@chromium.org>
---
 drivers/video/exynos/exynos_dp_core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 207bd7e..1c998d9 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -273,12 +273,6 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 	for (lane = 0; lane < lane_count; lane++)
 		dp->link_train.cr_loop[lane] = 0;
 
-	/* Set sink to D0 (Sink Not Ready) mode. */
-	ret = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
-				DPCD_SET_POWER_STATE_D0);
-	if (ret)
-		return ret;
-
 	/* Set link rate and count as you want to establish*/
 	exynos_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
 	exynos_dp_set_lane_count(dp, dp->link_train.lane_count);
-- 
1.7.7.3

