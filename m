From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 23 Aug 2012 10:55:13 +0000
Subject: [PATCH 2/2] video: exynos_dp: move setting analog parameter and interrupt to after sw reset
Message-Id: <000b01cd811d$c5890b60$509b2220$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SW reset sets DP TX to initial value, so configurations for analog parameter
and interrupt are not set properly. Therefore, exynos_dp_init_analog_param()
and exynos_dp_init_interrupt() should be moved to after sw reset is called,
in order to set these values properly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    3 +++
 drivers/video/exynos/exynos_dp_reg.c  |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index c6c016a..8113698 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -29,6 +29,9 @@ static int exynos_dp_init_dp(struct exynos_dp_device *dp)
 
 	exynos_dp_swreset(dp);
 
+	exynos_dp_init_analog_param(dp);
+	exynos_dp_init_interrupt(dp);
+
 	/* SW defined function Normal operation */
 	exynos_dp_enable_sw_function(dp);
 
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index e29497b..9a862f5 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -148,9 +148,6 @@ void exynos_dp_reset(struct exynos_dp_device *dp)
 	writel(0x2, dp->reg_base + EXYNOS_DP_M_AUD_GEN_FILTER_TH);
 
 	writel(0x00000101, dp->reg_base + EXYNOS_DP_SOC_GENERAL_CTL);
-
-	exynos_dp_init_analog_param(dp);
-	exynos_dp_init_interrupt(dp);
 }
 
 void exynos_dp_swreset(struct exynos_dp_device *dp)
-- 
1.7.1


