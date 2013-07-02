From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Jul 2013 11:26:54 +0000
Subject: [PATCH] video: exynos: Ensure definitions match prototypes
Message-Id: <1372764414-9102-1-git-send-email-broonie@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

Ensure that the definitions of functions match the prototypes used by
other modules by including the header with the prototypes in the files
with the definitions.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
index 15c5abd..c148d06 100644
--- a/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
+++ b/drivers/video/exynos/exynos_mipi_dsi_lowlevel.c
@@ -27,6 +27,7 @@
 #include <video/exynos_mipi_dsim.h>
 
 #include "exynos_mipi_dsi_regs.h"
+#include "exynos_mipi_dsi_lowlevel.h"
 
 void exynos_mipi_dsi_func_reset(struct mipi_dsim_device *dsim)
 {
-- 
1.8.3.1

