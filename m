From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Feb 2013 05:25:19 +0000
Subject: [PATCH 2/2 RESEND] video: exynos_dp: move disable_irq() to exynos_dp_suspend()
Message-Id: <000901ce0d98$5794c240$06be46c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000801ce0d98$2e103fd0$8a30bf70$%han@samsung.com>
In-Reply-To: <000801ce0d98$2e103fd0$8a30bf70$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jingoo Han' <jg1.han@samsung.com>

From: Ajay Kumar <ajaykumar.rs@samsung.com>

disable_irq() should be moved to exynos_dp_suspend(), because
enable_irq() is called at exynos_dp_resume().

Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index c7374c0..de9d4da 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -1124,8 +1124,6 @@ static int exynos_dp_remove(struct platform_device *pdev)
 	struct exynos_dp_platdata *pdata = pdev->dev.platform_data;
 	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
 
-	disable_irq(dp->irq);
-
 	flush_work(&dp->hotplug_work);
 
 	if (pdev->dev.of_node) {
@@ -1148,6 +1146,8 @@ static int exynos_dp_suspend(struct device *dev)
 	struct exynos_dp_platdata *pdata = dev->platform_data;
 	struct exynos_dp_device *dp = dev_get_drvdata(dev);
 
+	disable_irq(dp->irq);
+
 	flush_work(&dp->hotplug_work);
 
 	if (dev->of_node) {
-- 
1.7.2.5


