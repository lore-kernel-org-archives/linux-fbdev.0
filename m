From: Donghwa Lee <dh09.lee@samsung.com>
Date: Mon, 07 May 2012 00:20:51 +0000
Subject: [PATCH] video: EXYNOS: changes mipi dsi regulator name from vdd10 to vdd11
Message-Id: <4FA71563.5050401@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

MIPI DSI uses 1.1v regulator, so change its supply name.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 95e33f0..2e779d3 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -58,7 +58,7 @@ static struct mipi_dsim_platform_data *to_dsim_plat(struct platform_device
 }
 
 static struct regulator_bulk_data supplies[] = {
-	{ .supply = "vdd10", },
+	{ .supply = "vdd11", },
 	{ .supply = "vdd18", },
 };
 
-- 
1.7.4.1
