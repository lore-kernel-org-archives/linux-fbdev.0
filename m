From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 10:26:46 +0000
Subject: [PATCH v3 6/8] video: exynos_dp: Remove sink control to D0
Message-Id: <012401cdb81b$65127a70$2f376f50$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <012201cdb81a$f3117340$d93459c0$%han@samsung.com>
In-Reply-To: <012201cdb81a$f3117340$d93459c0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

According to DP spec, it is not required in the Link Training
procedure.

[jg1.han@samsung.com: modified the commit message]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Add 'From: Sean Paul <seanpaul@chromium.org>'

 drivers/video/exynos/exynos_dp_core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 8ab95c3..c2b6bf2 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -277,12 +277,6 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
 	for (lane = 0; lane < lane_count; lane++)
 		dp->link_train.cr_loop[lane] = 0;
 
-	/* Set sink to D0 (Sink Not Ready) mode. */
-	retval = exynos_dp_write_byte_to_dpcd(dp, DPCD_ADDR_SINK_POWER_STATE,
-			DPCD_SET_POWER_STATE_D0);
-	if (retval)
-		return retval;
-
 	/* Set link rate and count as you want to establish*/
 	exynos_dp_set_link_bandwidth(dp, dp->link_train.link_rate);
 	exynos_dp_set_lane_count(dp, dp->link_train.lane_count);
-- 
1.7.1


