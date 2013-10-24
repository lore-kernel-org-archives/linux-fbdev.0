From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Thu, 24 Oct 2013 15:39:34 +0000
Subject: [PATCH] drivers: video: exynos: Fix compiler Warning
Message-Id: <1382628454-11951-1-git-send-email-kishon@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOesGMhwotSY-1WQmt+wtsrsH2m30VE=j-MwyhpYU3mt_PSPPw@mail.gmail.com>
In-Reply-To: <CAOesGMhwotSY-1WQmt+wtsrsH2m30VE=j-MwyhpYU3mt_PSPPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Fixed the following compilation warning:
../../drivers/video/exynos/exynos_mipi_dsi.c: In function
'exynos_mipi_dsi_blank_mode':
../../drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning: unused
variable 'pdev' [-Wunused-variable]
  struct platform_device *pdev = to_platform_device(dsim->dev);

Reported-by: Olof Johansson <olof@lixom.net>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/video/exynos/exynos_mipi_dsi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
index 00b3a52..cee9602 100644
--- a/drivers/video/exynos/exynos_mipi_dsi.c
+++ b/drivers/video/exynos/exynos_mipi_dsi.c
@@ -141,7 +141,6 @@ static int exynos_mipi_dsi_early_blank_mode(struct mipi_dsim_device *dsim,
 
 static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
 {
-	struct platform_device *pdev = to_platform_device(dsim->dev);
 	struct mipi_dsim_lcd_driver *client_drv = dsim->dsim_lcd_drv;
 	struct mipi_dsim_lcd_device *client_dev = dsim->dsim_lcd_dev;
 
-- 
1.7.10.4

