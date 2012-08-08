From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:24 +0000
Subject: [PATCH 10/10] video: exynos_dp: Enable hotplug interrupts
Message-Id: <1344398064-13563-11-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Enable hotplug interrupts and move the hotplug scheduling into the
interrupt handler. This allows us to introduce a screen at any time
while we're running.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
---
 drivers/video/exynos/exynos_dp_core.c |   40 +++++++++++++++++++++++++-------
 drivers/video/exynos/exynos_dp_core.h |    9 +++++++
 drivers/video/exynos/exynos_dp_reg.c  |   35 ++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index eb5816f..5279027 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -47,10 +47,6 @@ static int exynos_dp_detect_hpd(struct exynos_dp_device *dp)
 {
 	int timeout_loop = 0;
 
-	exynos_dp_init_hpd(dp);
-
-	usleep_range(200, 210);
-
 	while (exynos_dp_get_plug_in_status(dp) != 0) {
 		timeout_loop++;
 		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
@@ -829,8 +825,32 @@ static void exynos_dp_enable_scramble(struct exynos_dp_device *dp, bool enable)
 static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
 {
 	struct exynos_dp_device *dp = arg;
-
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
 
@@ -843,7 +863,7 @@ static void exynos_dp_hotplug(struct work_struct *work)
 
 	ret = exynos_dp_detect_hpd(dp);
 	if (ret) {
-		dev_err(dp->dev, "unable to detect hpd\n");
+		/* Cable has been disconnected, we're done */
 		return;
 	}
 
@@ -941,7 +961,6 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 	exynos_dp_init_dp(dp);
 
 	platform_set_drvdata(pdev, dp);
-	schedule_work(&dp->hotplug_work);
 
 	return 0;
 
@@ -975,6 +994,8 @@ static int exynos_dp_suspend(struct device *dev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
+	disable_irq(dp->irq);
+
 	if (work_pending(&dp->hotplug_work))
 		flush_work_sync(&dp->hotplug_work);
 
@@ -998,7 +1019,8 @@ static int exynos_dp_resume(struct device *dev)
 	clk_enable(dp->clock);
 
 	exynos_dp_init_dp(dp);
-	schedule_work(&dp->hotplug_work);
+
+	enable_irq(dp->irq);
 
 	return 0;
 }
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index cf1010b..a5795dd 100644
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
index 389e0f0..5906fc7 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -327,7 +327,7 @@ void exynos_dp_init_analog_func(struct exynos_dp_device *dp)
 	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_2);
 }
 
-void exynos_dp_init_hpd(struct exynos_dp_device *dp)
+void exynos_dp_clear_hotplug_interrupts(struct exynos_dp_device *dp)
 {
 	u32 reg;
 
@@ -336,10 +336,43 @@ void exynos_dp_init_hpd(struct exynos_dp_device *dp)
 
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
+
+	/* Unmask hotplug interrupts */
+	reg = HOTPLUG_CHG | HPD_LOST | PLUG;
+	writel(reg, dp->reg_base + EXYNOS_DP_COMMON_INT_MASK_4);
+
+	reg = INT_HPD;
+	writel(reg, dp->reg_base + EXYNOS_DP_INT_STA_MASK);
+}
+
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
 }
 
 void exynos_dp_reset_aux(struct exynos_dp_device *dp)
-- 
1.7.7.3

