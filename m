From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 21 Sep 2012 05:18:46 +0000
Subject: [PATCH v2 1/2] video: exynos_mipi_dsi: Remove unused code
Message-Id: <1348204007-1347-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This code is never executed and hence removed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Inki Dae <inki.dae@samsung.com>

---
 drivers/video/exynos/exynos_mipi_dsi_common.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
index 47b533a..7cc4113 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -288,9 +288,6 @@ int exynos_mipi_dsi_wr_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 		mutex_unlock(&dsim->lock);
 		return -EINVAL;
 	}
-
-	mutex_unlock(&dsim->lock);
-	return 0;
 }
 
 static unsigned int exynos_mipi_dsi_long_data_rd(struct mipi_dsim_device *dsim,
-- 
1.7.4.1

