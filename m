From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 23 Aug 2012 10:54:16 +0000
Subject: [PATCH 1/2] video: exynos_dp: change return type of exynos_dp_init_video to void
Message-Id: <000a01cd811d$a408b080$ec1a1180$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch changes return type of exynos_dp_init_video to void,
because the return value is unnecessary.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.h |    2 +-
 drivers/video/exynos/exynos_dp_reg.c  |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 8526e54..1e244ea 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -105,7 +105,7 @@ u32 exynos_dp_get_lane1_link_training(struct exynos_dp_device *dp);
 u32 exynos_dp_get_lane2_link_training(struct exynos_dp_device *dp);
 u32 exynos_dp_get_lane3_link_training(struct exynos_dp_device *dp);
 void exynos_dp_reset_macro(struct exynos_dp_device *dp);
-int exynos_dp_init_video(struct exynos_dp_device *dp);
+void exynos_dp_init_video(struct exynos_dp_device *dp);
 
 void exynos_dp_set_video_color_format(struct exynos_dp_device *dp,
 				u32 color_depth,
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 2db5b9a..e29497b 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -994,7 +994,7 @@ void exynos_dp_reset_macro(struct exynos_dp_device *dp)
 	writel(reg, dp->reg_base + EXYNOS_DP_PHY_TEST);
 }
 
-int exynos_dp_init_video(struct exynos_dp_device *dp)
+void exynos_dp_init_video(struct exynos_dp_device *dp)
 {
 	u32 reg;
 
@@ -1012,8 +1012,6 @@ int exynos_dp_init_video(struct exynos_dp_device *dp)
 
 	reg = VID_HRES_TH(2) | VID_VRES_TH(0);
 	writel(reg, dp->reg_base + EXYNOS_DP_VIDEO_CTL_8);
-
-	return 0;
 }
 
 void exynos_dp_set_video_color_format(struct exynos_dp_device *dp,
-- 
1.7.1


