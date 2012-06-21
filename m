From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 21 Jun 2012 09:57:23 +0000
Subject: [PATCH] video: exynos_dp: remove duplicated declarations from header file
Message-Id: <000601cd4f94$415cd750$c41685f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some functions are declared twice in header file; thus, these
declarations are unnecessary.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 1e0f998..8526e54 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -85,10 +85,6 @@ void exynos_dp_set_link_bandwidth(struct exynos_dp_device *dp, u32 bwtype);
 void exynos_dp_get_link_bandwidth(struct exynos_dp_device *dp, u32 *bwtype);
 void exynos_dp_set_lane_count(struct exynos_dp_device *dp, u32 count);
 void exynos_dp_get_lane_count(struct exynos_dp_device *dp, u32 *count);
-void exynos_dp_set_link_bandwidth(struct exynos_dp_device *dp, u32 bwtype);
-void exynos_dp_get_link_bandwidth(struct exynos_dp_device *dp, u32 *bwtype);
-void exynos_dp_set_lane_count(struct exynos_dp_device *dp, u32 count);
-void exynos_dp_get_lane_count(struct exynos_dp_device *dp, u32 *count);
 void exynos_dp_enable_enhanced_mode(struct exynos_dp_device *dp, bool enable);
 void exynos_dp_set_training_pattern(struct exynos_dp_device *dp,
 				 enum pattern_set pattern);
-- 
1.7.1


