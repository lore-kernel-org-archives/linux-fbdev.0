From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 05 Nov 2012 07:44:25 +0000
Subject: [PATCH v3 2/2] video: exynos_dp: Fix incorrect setting for INT_CTL
Message-Id: <003401cdbb29$60b46220$221d2660$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

INT_CTL register contains bits INT_POL0 and INT_POL1, and not INT_POL.
This patch fixes the wrong register setting for INT_CTL.

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Tested with Exynos5250

 drivers/video/exynos/exynos_dp_reg.c |    2 +-
 drivers/video/exynos/exynos_dp_reg.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 3f5ca8a..cc7765f 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -88,7 +88,7 @@ void exynos_dp_init_analog_param(struct exynos_dp_device *dp)
 void exynos_dp_init_interrupt(struct exynos_dp_device *dp)
 {
 	/* Set interrupt pin assertion polarity as high */
-	writel(INT_POL, dp->reg_base + EXYNOS_DP_INT_CTL);
+	writel(INT_POL1 | INT_POL0, dp->reg_base + EXYNOS_DP_INT_CTL);
 
 	/* Clear pending regisers */
 	writel(0xff, dp->reg_base + EXYNOS_DP_COMMON_INT_STA_1);
diff --git a/drivers/video/exynos/exynos_dp_reg.h b/drivers/video/exynos/exynos_dp_reg.h
index 1f2f014..2e9bd0e 100644
--- a/drivers/video/exynos/exynos_dp_reg.h
+++ b/drivers/video/exynos/exynos_dp_reg.h
@@ -242,7 +242,8 @@
 
 /* EXYNOS_DP_INT_CTL */
 #define SOFT_INT_CTRL				(0x1 << 2)
-#define INT_POL					(0x1 << 0)
+#define INT_POL1				(0x1 << 1)
+#define INT_POL0				(0x1 << 0)
 
 /* EXYNOS_DP_SYS_CTL_1 */
 #define DET_STA					(0x1 << 2)
-- 
1.7.1


