From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 02 Aug 2012 06:26:11 +0000
Subject: [PATCH] video: exynos-mipi-dsi: Add missing static storage class specifiers
Message-Id: <1343888051-406-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes the following sparse warnings:
drivers/video/exynos/exynos_mipi_dsi.c:208:22: warning:
symbol 'exynos_mipi_dsi_find_lcd_device' was not declared. Should it be static?
drivers/video/exynos/exynos_mipi_dsi.c:268:22: warning:
symbol 'exynos_mipi_dsi_bind_lcd_ddi' was not declared. Should it be static?

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/exynos/exynos_mipi_dsi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 4bc2b8a..ef68228 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -205,7 +205,8 @@ int exynos_mipi_dsi_register_lcd_device(struct mipi_dsim_lcd_device *lcd_dev)
 	return 0;
 }
 
-struct mipi_dsim_ddi *exynos_mipi_dsi_find_lcd_device(struct mipi_dsim_lcd_driver *lcd_drv)
+static struct mipi_dsim_ddi *exynos_mipi_dsi_find_lcd_device(
+					struct mipi_dsim_lcd_driver *lcd_drv)
 {
 	struct mipi_dsim_ddi *dsim_ddi, *next;
 	struct mipi_dsim_lcd_device *lcd_dev;
@@ -265,7 +266,8 @@ int exynos_mipi_dsi_register_lcd_driver(struct mipi_dsim_lcd_driver *lcd_drv)
 
 }
 
-struct mipi_dsim_ddi *exynos_mipi_dsi_bind_lcd_ddi(struct mipi_dsim_device *dsim,
+static struct mipi_dsim_ddi *exynos_mipi_dsi_bind_lcd_ddi(
+						struct mipi_dsim_device *dsim,
 						const char *name)
 {
 	struct mipi_dsim_ddi *dsim_ddi, *next;
-- 
1.7.4.1

