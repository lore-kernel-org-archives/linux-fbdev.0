From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 12 Sep 2012 04:34:24 +0000
Subject: [PATCH] video: exynos_dp: add bit-masking for LINK_TRAINING_CTL register
Message-Id: <002701cd909f$e2b2c960$a8185c20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds bit-masking for LINK_TRAINING_CTL register, when
pre-emphasis level is set. The bit 3 and bit 2 of LINK_TRAINING_CTL
register are used for pre-emphasis level setting, so other bits
should be masked.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_reg.c |   16 ++++++++++++----
 drivers/video/exynos/exynos_dp_reg.h |    1 +
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 20e441f..365be69 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -895,7 +895,9 @@ void exynos_dp_set_lane0_pre_emphasis(struct exynos_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = level << PRE_EMPHASIS_SET_SHIFT;
+	reg = readl(dp->reg_base + EXYNOS_DP_LN0_LINK_TRAINING_CTL);
+	reg &= ~PRE_EMPHASIS_SET_MASK;
+	reg |= level << PRE_EMPHASIS_SET_SHIFT;
 	writel(reg, dp->reg_base + EXYNOS_DP_LN0_LINK_TRAINING_CTL);
 }
 
@@ -903,7 +905,9 @@ void exynos_dp_set_lane1_pre_emphasis(struct exynos_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = level << PRE_EMPHASIS_SET_SHIFT;
+	reg = readl(dp->reg_base + EXYNOS_DP_LN1_LINK_TRAINING_CTL);
+	reg &= ~PRE_EMPHASIS_SET_MASK;
+	reg |= level << PRE_EMPHASIS_SET_SHIFT;
 	writel(reg, dp->reg_base + EXYNOS_DP_LN1_LINK_TRAINING_CTL);
 }
 
@@ -911,7 +915,9 @@ void exynos_dp_set_lane2_pre_emphasis(struct exynos_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = level << PRE_EMPHASIS_SET_SHIFT;
+	reg = readl(dp->reg_base + EXYNOS_DP_LN2_LINK_TRAINING_CTL);
+	reg &= ~PRE_EMPHASIS_SET_MASK;
+	reg |= level << PRE_EMPHASIS_SET_SHIFT;
 	writel(reg, dp->reg_base + EXYNOS_DP_LN2_LINK_TRAINING_CTL);
 }
 
@@ -919,7 +925,9 @@ void exynos_dp_set_lane3_pre_emphasis(struct exynos_dp_device *dp, u32 level)
 {
 	u32 reg;
 
-	reg = level << PRE_EMPHASIS_SET_SHIFT;
+	reg = readl(dp->reg_base + EXYNOS_DP_LN3_LINK_TRAINING_CTL);
+	reg &= ~PRE_EMPHASIS_SET_MASK;
+	reg |= level << PRE_EMPHASIS_SET_SHIFT;
 	writel(reg, dp->reg_base + EXYNOS_DP_LN3_LINK_TRAINING_CTL);
 }
 
diff --git a/drivers/video/exynos/exynos_dp_reg.h b/drivers/video/exynos/exynos_dp_reg.h
index 125b27c..9e9af50 100644
--- a/drivers/video/exynos/exynos_dp_reg.h
+++ b/drivers/video/exynos/exynos_dp_reg.h
@@ -285,6 +285,7 @@
 #define SW_TRAINING_PATTERN_SET_NORMAL		(0x0 << 0)
 
 /* EXYNOS_DP_LN0_LINK_TRAINING_CTL */
+#define PRE_EMPHASIS_SET_MASK			(0x3 << 3)
 #define PRE_EMPHASIS_SET_SHIFT			(3)
 
 /* EXYNOS_DP_DEBUG_CTL */
-- 
1.7.1


