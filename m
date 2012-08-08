From: Sean Paul <seanpaul@chromium.org>
Date: Wed, 08 Aug 2012 03:54:23 +0000
Subject: [PATCH 09/10] video: exynos_dp: Fix bug when checking dp->irq
Message-Id: <1344398064-13563-10-git-send-email-seanpaul@chromium.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix a bug where we check !dp->irq instead of the correct check for
-ENXIO.

BUG=None
TEST=None

Change-Id: Ibcdd16fb71eb41e4380ac8911ad6063634ff80e2
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-on: https://gerrit.chromium.org/gerrit/29144
Reviewed-by: Olof Johansson <olofj@chromium.org>
---
 drivers/video/exynos/exynos_dp_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 68ad494..eb5816f 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -919,7 +919,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
 	}
 
 	dp->irq = platform_get_irq(pdev, 0);
-	if (!dp->irq) {
+	if (dp->irq = -ENXIO) {
 		dev_err(&pdev->dev, "failed to get irq\n");
 		ret = -ENODEV;
 		goto err_clock;
-- 
1.7.7.3

