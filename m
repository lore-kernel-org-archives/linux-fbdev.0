From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 31 Oct 2012 17:15:51 +0000
Subject: [PATCH] video: exynos_dp: Fix bug when checking dp->irq
Message-Id: <1351703751-3916-1-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix a bug where we check !dp->irq instead of the correct check for
-ENXIO.

Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Olof Johansson <olofj@chromium.org>
---
 drivers/video/exynos/exynos_dp_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index f761ec2..39271eb 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -882,7 +882,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 	}
 
 	dp->irq = platform_get_irq(pdev, 0);
-	if (!dp->irq) {
+	if (dp->irq = -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
 		return -ENODEV;
 	}
-- 
1.7.7.3

