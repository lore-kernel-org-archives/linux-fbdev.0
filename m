From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 25 May 2012 07:21:08 +0000
Subject: [PATCH 2/3] video: exynos_dp: move sw reset prioir to enabling sw defined function
Message-Id: <001e01cd3a46$f4658cb0$dd30a610$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The sw reset should be called prioir to enabling sw defined function,
according to datasheet.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    2 ++
 drivers/video/exynos/exynos_dp_core.h |    1 +
 drivers/video/exynos/exynos_dp_reg.c  |    7 +++++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index aabd214..b446f7e 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -27,6 +27,8 @@ static int exynos_dp_init_dp(struct exynos_dp_device *dp)
 {
 	exynos_dp_reset(dp);
 
+	exynos_dp_swreset(dp);
+
 	/* SW defined function Normal operation */
 	exynos_dp_enable_sw_function(dp);
 
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 8f596b9..1e0f998 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -41,6 +41,7 @@ void exynos_dp_lane_swap(struct exynos_dp_device *dp, bool enable);
 void exynos_dp_init_analog_param(struct exynos_dp_device *dp);
 void exynos_dp_init_interrupt(struct exynos_dp_device *dp);
 void exynos_dp_reset(struct exynos_dp_device *dp);
+void exynos_dp_swreset(struct exynos_dp_device *dp);
 void exynos_dp_config_interrupt(struct exynos_dp_device *dp);
 u32 exynos_dp_get_pll_lock_status(struct exynos_dp_device *dp);
 void exynos_dp_set_pll_power_down(struct exynos_dp_device *dp, bool enable);
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 99bafb8..6ce76d5 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -109,8 +109,6 @@ void exynos_dp_reset(struct exynos_dp_device *dp)
 {
 	u32 reg;
 
-	writel(RESET_DP_TX, dp->reg_base + EXYNOS_DP_TX_SW_RESET);
-
 	exynos_dp_stop_video(dp);
 	exynos_dp_enable_video_mute(dp, 0);
 
@@ -155,6 +153,11 @@ void exynos_dp_reset(struct exynos_dp_device *dp)
 	exynos_dp_init_interrupt(dp);
 }
 
+void exynos_dp_swreset(struct exynos_dp_device *dp)
+{
+	writel(RESET_DP_TX, dp->reg_base + EXYNOS_DP_TX_SW_RESET);
+}
+
 void exynos_dp_config_interrupt(struct exynos_dp_device *dp)
 {
 	u32 reg;
-- 
1.7.1


