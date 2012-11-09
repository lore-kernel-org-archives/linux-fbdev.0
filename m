From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 09 Nov 2012 05:53:00 +0000
Subject: [PATCH v4 7/8] video: exynos_dp: Move hotplug into a workqueue
Message-Id: <001f01cdbe3e$79aa8300$6cff8900$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Move the hotplug related code from probe and resume into a workqueue.
This allows us to initialize the DP driver (and resume it) when there
is no monitor connected.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |   93 +++++++++++++++++---------------
 drivers/video/exynos/exynos_dp_core.h |    1 +
 2 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index edb3bfe..79ba1ea 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -837,6 +837,45 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void exynos_dp_hotplug(struct work_struct *work)
+{
+	struct exynos_dp_device *dp;
+	int ret;
+
+	dp = container_of(work, struct exynos_dp_device, hotplug_work);
+
+	ret = exynos_dp_detect_hpd(dp);
+	if (ret) {
+		dev_err(dp->dev, "unable to detect hpd\n");
+		return;
+	}
+
+	ret = exynos_dp_handle_edid(dp);
+	if (ret) {
+		dev_err(dp->dev, "unable to handle edid\n");
+		return;
+	}
+
+	ret = exynos_dp_set_link_train(dp, dp->video_info->lane_count,
+					dp->video_info->link_rate);
+	if (ret) {
+		dev_err(dp->dev, "unable to do link train\n");
+		return;
+	}
+
+	exynos_dp_enable_scramble(dp, 1);
+	exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
+	exynos_dp_enable_enhanced_mode(dp, 1);
+
+	exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
+	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
+
+	exynos_dp_init_video(dp);
+	ret = exynos_dp_config_video(dp, dp->video_info);
+	if (ret)
+		dev_err(dp->dev, "unable to config video\n");
+}
+
 static int __devinit exynos_dp_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -882,6 +921,8 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	INIT_WORK(&dp->hotplug_work, exynos_dp_hotplug);
+
 	ret = devm_request_irq(&pdev->dev, dp->irq, exynos_dp_irq_handler, 0,
 				"exynos-dp", dp);
 	if (ret) {
@@ -895,36 +936,8 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 
 	exynos_dp_init_dp(dp);
 
-	ret = exynos_dp_detect_hpd(dp);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to detect hpd\n");
-		return ret;
-	}
-
-	exynos_dp_handle_edid(dp);
-
-	ret = exynos_dp_set_link_train(dp, dp->video_info->lane_count,
-				dp->video_info->link_rate);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to do link train\n");
-		return ret;
-	}
-
-	exynos_dp_enable_scramble(dp, 1);
-	exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
-	exynos_dp_enable_enhanced_mode(dp, 1);
-
-	exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
-	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
-
-	exynos_dp_init_video(dp);
-	ret = exynos_dp_config_video(dp, dp->video_info);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to config video\n");
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, dp);
+	schedule_work(&dp->hotplug_work);
 
 	return 0;
 }
@@ -934,6 +947,9 @@ static int __devexit exynos_dp_remove(struct platform_device *pdev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
+	if (work_pending(&dp->hotplug_work))
+		flush_work(&dp->hotplug_work);
+
 	if (pdata && pdata->phy_exit)
 		pdata->phy_exit();
 
@@ -949,6 +965,9 @@ static int exynos_dp_suspend(struct device *dev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
+	if (work_pending(&dp->hotplug_work))
+		flush_work(&dp->hotplug_work);
+
 	if (pdata && pdata->phy_exit)
 		pdata->phy_exit();
 
@@ -970,21 +989,7 @@ static int exynos_dp_resume(struct device *dev)
 
 	exynos_dp_init_dp(dp);
 
-	exynos_dp_detect_hpd(dp);
-	exynos_dp_handle_edid(dp);
-
-	exynos_dp_set_link_train(dp, dp->video_info->lane_count,
-				dp->video_info->link_rate);
-
-	exynos_dp_enable_scramble(dp, 1);
-	exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
-	exynos_dp_enable_enhanced_mode(dp, 1);
-
-	exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
-	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
-
-	exynos_dp_init_video(dp);
-	exynos_dp_config_video(dp, dp->video_info);
+	schedule_work(&dp->hotplug_work);
 
 	return 0;
 }
diff --git a/drivers/video/exynos/exynos_dp_core.h b/drivers/video/exynos/exynos_dp_core.h
index 57b8a65..66f11f4 100644
--- a/drivers/video/exynos/exynos_dp_core.h
+++ b/drivers/video/exynos/exynos_dp_core.h
@@ -32,6 +32,7 @@ struct exynos_dp_device {
 
 	struct video_info	*video_info;
 	struct link_train	link_train;
+	struct work_struct	hotplug_work;
 };
 
 /* exynos_dp_reg.c */
-- 
1.7.1


