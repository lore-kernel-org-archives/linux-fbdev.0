From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 08 Mar 2012 15:35:54 +0000
Subject: [PATCH] fb: exynos: Fix MIPI/DSI front/back porch settings
Message-Id: <1331220954-13177-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The exynos_mipi_dsi_set_main_disp_[hv]porch() functions take front and
back porch arguments in that order. This maps to the fb_videomode
right/lower_margin and left/upper_margin respectively. Fix the caller
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/exynos/exynos_mipi_dsi_common.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_common.c b/drivers/video/exynos/exynos_mipi_dsi_common.c
index 14909c1..99f6451 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_common.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_common.c
@@ -738,11 +738,11 @@ int exynos_mipi_dsi_set_display_mode(struct mipi_dsim_device *dsim,
 		if (dsim_config->auto_vertical_cnt = 0) {
 			exynos_mipi_dsi_set_main_disp_vporch(dsim,
 				dsim_config->cmd_allow,
-				timing->upper_margin,
-				timing->lower_margin);
+				timing->lower_margin,
+				timing->upper_margin);
 			exynos_mipi_dsi_set_main_disp_hporch(dsim,
-				timing->left_margin,
-				timing->right_margin);
+				timing->right_margin,
+				timing->left_margin);
 			exynos_mipi_dsi_set_main_disp_sync_area(dsim,
 				timing->vsync_len,
 				timing->hsync_len);
-- 
Regards,

Laurent Pinchart

