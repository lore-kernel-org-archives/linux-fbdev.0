From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 09 Nov 2012 05:51:27 +0000
Subject: [PATCH v4 5/8] video: exynos_dp: Fix bug when checking dp->irq
Message-Id: <001d01cdbe3e$42ecd700$c8c68500$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

Fix a bug where we check !dp->irq instead of the correct check for
-ENXIO.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 4a6ed2f..be3df15 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -883,7 +883,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 	}
 
 	dp->irq = platform_get_irq(pdev, 0);
-	if (!dp->irq) {
+	if (dp->irq = -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
 		return -ENODEV;
 	}
-- 
1.7.1


