From: Leela Krishna Amudala <l.krishna@samsung.com>
Date: Tue, 07 Aug 2012 09:49:58 +0000
Subject: [PATCH V3 4/5] driver: Include the modified FIMD header file
Message-Id: <1344332279-16736-5-git-send-email-l.krishna@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344332279-16736-1-git-send-email-l.krishna@samsung.com>
In-Reply-To: <1344332279-16736-1-git-send-email-l.krishna@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, m.szyprowski@samsung.com

The fimd register headers have been moved to include/video/
hence, modifying the driver files accordingly.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c |    2 +-
 drivers/video/s3c-fb.c                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index a68d2b3..24c0bd4 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -19,8 +19,8 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 
+#include <video/samsung_fimd.h>
 #include <drm/exynos_drm.h>
-#include <plat/regs-fb-v4.h>
 
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fbdev.h"
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 69bf9d0..901729e 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -25,8 +25,8 @@
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
 
+#include <video/samsung_fimd.h>
 #include <mach/map.h>
-#include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
 
 /* This driver will export a number of framebuffer interfaces depending
-- 
1.7.0.4

