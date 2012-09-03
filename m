From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 03 Sep 2012 08:50:24 +0000
Subject: [PATCH] video: exynos_dp: replace link_status with link_align to check channel equalization
Message-Id: <000001cd89b1$2852e3b0$78f8ab10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

To check channel equalization, the value of LANE_ALIGN_STATUS_UPDATED is
necessary in exynos_dp_channel_eq_ok(). Also, link_align includes this value.
However, link_status does not include this value, so it makes the problem
that channel equalization is failed during link training.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index f57c915..cdc1398 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -587,7 +587,7 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
 			dp->link_train.training_lane[lane] = training_lane;
 		}
 
-		if (exynos_dp_channel_eq_ok(link_status, lane_count) = 0) {
+		if (exynos_dp_channel_eq_ok(link_align, lane_count) = 0) {
 			/* traing pattern Set to Normal */
 			exynos_dp_training_pattern_dis(dp);
 
-- 
1.7.1

