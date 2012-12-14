From: Jonghwan Choi <jhbird.choi@samsung.com>
Date: Fri, 14 Dec 2012 08:33:15 +0000
Subject: [PATCH] video: exynos_mipi_dsi: Add missing mutex_unlock
Message-Id: <000801cdd9d5$a9536a10$fbfa3e30$%choi@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add a mutex_unlock on the error path.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/video/exynos/exynos_mipi_dsi_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c
b/drivers/video/exynos/exynos_mipi_dsi_common.c
index 3cd29a4..bd7f4f2 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -377,6 +377,7 @@ int exynos_mipi_dsi_rd_data(struct mipi_dsim_device
*dsim, unsigned int data_id,
 			"data id %x is not supported current DSI spec.\n",
 			data_id);
 
+		mutex_unlock(&dsim->lock);
 		return -EINVAL;
 	}
 
-- 
1.7.4.1

