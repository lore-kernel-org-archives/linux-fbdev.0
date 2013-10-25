From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 25 Oct 2013 05:24:44 +0000
Subject: [PATCH 1/1] video: exynos_mipi_dsi: Unlock the mutex before returning
Message-Id: <1382677964-15298-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Mutex should be unlocked before returning. Fixes mutex lock-unlock
imbalance issue.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/exynos/exynos_mipi_dsi_common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
index 520fc9b..649d9e6 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -376,6 +376,7 @@ int exynos_mipi_dsi_rd_data(struct mipi_dsim_device *dsim, unsigned int data_id,
 			"data id %x is not supported current DSI spec.\n",
 			data_id);
 
+		mutex_unlock(&dsim->lock);
 		return -EINVAL;
 	}
 
-- 
1.7.9.5

