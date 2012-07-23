From: Donghwa Lee <dh09.lee@samsung.com>
Date: Mon, 23 Jul 2012 02:25:30 +0000
Subject: [PATCH] video: exynos mipi dsi: Fix mipi dsi regulators handling issue
Message-Id: <500CB61A.6000106@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

When FB_BLANK_UNLANK event occured, exynos mipi dsi regulators have to turn on.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 6c1f5c3..9390640 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -154,7 +154,7 @@ static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
 		if (client_drv && client_drv->power_on)
 			client_drv->power_on(client_dev, 1);
 
-		exynos_mipi_regulator_disable(dsim);
+		exynos_mipi_regulator_enable(dsim);
 
 		/* enable MIPI-DSI PHY. */
 		if (dsim->pd->phy_enable)
-- 
1.7.4.1
