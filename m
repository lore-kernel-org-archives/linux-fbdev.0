From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Jan 2013 07:38:32 +0000
Subject: [PATCH 2/2] video: exynos_dp: move disable_irq() to exynos_dp_suspend()
Message-Id: <00cc01cdfdf3$a39dcb00$ead96100$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Ajay Kumar <ajaykumar.rs@samsung.com>

disable_irq() should be moved to exynos_dp_suspend(), because
enable_irq() is called at exynos_dp_resume().

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index c7374c0..9ba973a 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -1124,8 +1124,6 @@ static int exynos_dp_remove(struct platform_device *pdev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
-	disable_irq(dp->irq);
-
 	flush_work(&dp->hotplug_work);
 
 	if (pdev->dev.of_node) {
@@ -1138,7 +1136,6 @@ static int exynos_dp_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(dp->clock);
 
-
 	return 0;
 }
 
@@ -1148,6 +1145,8 @@ static int exynos_dp_suspend(struct device *dev)
 	struct exynos_dp_platdata *pdata = dev->platform_data;
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
+	disable_irq(dp->irq);
+
 	flush_work(&dp->hotplug_work);
 
 	if (dev->of_node) {
-- 
1.7.2.5


