From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 01 Nov 2012 10:29:07 +0000
Subject: [PATCH v3 8/8] video: exynos_dp: Enable hotplug interrupts
Message-Id: <012601cdb81b$b9906c10$2cb14430$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Enable hotplug interrupts and move the hotplug scheduling into the
interrupt handler. This allows us to introduce a screen at any time
while we're running.

[jg1.han@samsung.com: moved the bit masking of hotplug interrupts]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |   38 ++++++++++++++++++++++++++-------
 drivers/video/exynos/exynos_dp_core.h |    9 +++++++
 drivers/video/exynos/exynos_dp_reg.c  |   38 +++++++++++++++++++++++++++-----
 3 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index ffb6d6d..963e3c7 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -48,10 +48,6 @@ static int exynos_dp_detect_hpd(struct exynos_dp_device *dp)
 {
 	int timeout_loop = 0;
 
-	exynos_dp_init_hpd(dp);
-
-	usleep_range(200, 210);
-
 	while (exynos_dp_get_plug_in_status(dp) != 0) {
 		timeout_loop++;
 		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
@@ -870,7 +866,32 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
 {
 	struct exynos_dp_device *dp = arg;
 
-	dev_err(dp->dev, "exynos_dp_irq_handler\n");
+	enum dp_irq_type irq_type;
+
+	irq_type = exynos_dp_get_irq_type(dp);
+	switch (irq_type) {
+	case DP_IRQ_TYPE_HP_CABLE_IN:
+		dev_dbg(dp->dev, "Received irq - cable in\n");
+		schedule_work(&dp->hotplug_work);
+		exynos_dp_clear_hotplug_interrupts(dp);
+		break;
+	case DP_IRQ_TYPE_HP_CABLE_OUT:
+		dev_dbg(dp->dev, "Received irq - cable out\n");
+		exynos_dp_clear_hotplug_interrupts(dp);
+		break;
+	case DP_IRQ_TYPE_HP_CHANGE:
+		/*
+		 * We get these change notifications once in a while, but there
+		 * is nothing we can do with them. Just ignore it for now and
+		 * only handle cable changes.
+		 */
+		dev_dbg(dp->dev, "Received irq - hotplug change; ignoring.\n");
+		exynos_dp_clear_hotplug_interrupts(dp);
+		break;
+	default:
+		dev_err(dp->dev, "Received irq - unknown type!\n");
+		break;
+	}
 	return IRQ_HANDLED;
 }
 
@@ -883,7 +904,7 @@ static void exynos_dp_hotplug(struct work_struct *work)
 
 	ret = exynos_dp_detect_hpd(dp);
 	if (ret) {
-		dev_err(dp->dev, "unable to detect hpd\n");
+		/* Cable has been disconnected, we're done */
 		return;
 	}
 
@@ -974,7 +995,6 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 	exynos_dp_init_dp(dp);
 
 	platform_set_drvdata(pdev, dp);
-	schedule_work(&dp->hotplug_work);
 
 	return 0;
 }
@@ -1002,6 +1022,8 @@ static int exynos_dp_suspend(struct device *dev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
+	disable_irq(dp->irq);
+
 	if (work_pending(&dp->hotplug_work))
 		flush_work(&dp->hotplug_work);
 
@@ -1026,7 +1048,7 @@ static int exynos_dp_resume(struct device *dev)
 
 	exynos_dp_init_dp(dp);
 
-	schedule_work(&dp->hotplug_work);
+	enable_irq(dp->irq);
 
 	return 0;
 }
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 66f11f4..520486e 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -13,6 +13,13 @@
 #ifndef _EXYNOS_DP_CORE_H
 #define _EXYNOS_DP_CORE_H
 
+enum dp_irq_type {
+	DP_IRQ_TYPE_HP_CABLE_IN,
+	DP_IRQ_TYPE_HP_CABLE_OUT,
+	DP_IRQ_TYPE_HP_CHANGE,
+	DP_IRQ_TYPE_UNKNOWN,
+};
+
 struct link_train {
 	int eq_loop;
 	int cr_loop[4];
@@ -51,6 +58,8 @@ void exynos_dp_set_analog_power_down(struct exynos_dp_device *dp,
 				bool enable);
 void exynos_dp_init_analog_func(struct exynos_dp_device *dp);
 void exynos_dp_init_hpd(struct exynos_dp_device *dp);
+enum dp_irq_type exynos_dp_get_irq_type(struct exynos_dp_device *dp);
+void exynos_dp_clear_hotplug_interrupts(struct exynos_dp_device *dp);
 void exynos_dp_reset_aux(struct exynos_dp_device *dp);
 void exynos_dp_init_aux(struct exynos_dp_device *dp);
 int exynos_dp_get_plug_in_status(struct exynos_dp_device *dp);
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index dc09278..af7dae1 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -19,11 +19,11 @@
 #include "exynos_dp_core.h"
 #include "exynos_dp_reg.h"
 
-#define COMMON_INT_MASK_1 (0)
-#define COMMON_INT_MASK_2 (0)
-#define COMMON_INT_MASK_3 (0)
-#define COMMON_INT_MASK_4 (0)
-#define INT_STA_MASK (0)
+#define COMMON_INT_MASK_1	0
+#define COMMON_INT_MASK_2	0
+#define COMMON_INT_MASK_3	0
+#define COMMON_INT_MASK_4	(HOTPLUG_CHG | HPD_LOST | PLUG)
+#define INT_STA_MASK		INT_HPD
 
 void exynos_dp_enable_video_mute(struct exynos_dp_device *dp, bool enable)
 {
@@ -324,7 +324,7 @@ void exynos_dp_init_analog_func(struct exynos_dp_device *dp)
 	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
 }
 
-void exynos_dp_init_hpd(struct exynos_dp_device *dp)
+void exynos_dp_clear_hotplug_interrupts(struct exynos_dp_device *dp)
 {
 	u32 reg;
 
@@ -333,12 +333,38 @@ void exynos_dp_init_hpd(struct exynos_dp_device *dp)
 
 	reg = INT_HPD;
 	writel(reg, dp->reg_base + EXYNOS_DP_INT_STA);
+}
+
+void exynos_dp_init_hpd(struct exynos_dp_device *dp)
+{
+	u32 reg;
+
+	exynos_dp_clear_hotplug_interrupts(dp);
 
 	reg = readl(dp->reg_base + EXYNOS_DP_SYS_CTL_3);
 	reg &= ~(F_HPD | HPD_CTRL);
 	writel(reg, dp->reg_base + EXYNOS_DP_SYS_CTL_3);
 }
 
+enum dp_irq_type exynos_dp_get_irq_type(struct exynos_dp_device *dp)
+{
+	u32 reg;
+
+	/* Parse hotplug interrupt status register */
+	reg = readl(dp->reg_base + EXYNOS_DP_COMMON_INT_STA_4);
+
+	if (reg & PLUG)
+		return DP_IRQ_TYPE_HP_CABLE_IN;
+
+	if (reg & HPD_LOST)
+		return DP_IRQ_TYPE_HP_CABLE_OUT;
+
+	if (reg & HOTPLUG_CHG)
+		return DP_IRQ_TYPE_HP_CHANGE;
+
+	return DP_IRQ_TYPE_UNKNOWN;
+}
+
 void exynos_dp_reset_aux(struct exynos_dp_device *dp)
 {
 	u32 reg;
-- 
1.7.1


