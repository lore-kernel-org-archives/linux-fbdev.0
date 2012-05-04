From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 04 May 2012 06:25:36 +0000
Subject: [PATCH v2] video: exynos_dp: remove unnecessary header includes
Message-Id: <004d01cd29be$b79eb8d0$26dc2a70$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove unnecessary headers from the file.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_core.c |    2 --
 drivers/video/exynos/exynos_dp_reg.c  |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
index 6e9f3ce..ef4d1ab 100644
--- a/drivers/video/exynos/exynos_dp_core.c
+++ b/drivers/video/exynos/exynos_dp_core.c
@@ -21,8 +21,6 @@
 
 #include <video/exynos_dp.h>
 
-#include <plat/cpu.h>
-
 #include "exynos_dp_core.h"
 
 static int exynos_dp_init_dp(struct exynos_dp_device *dp)
diff --git a/drivers/video/exynos/exynos_dp_reg.c b/drivers/video/exynos/exynos_dp_reg.c
index 3863726..99bafb8 100644
--- a/drivers/video/exynos/exynos_dp_reg.c
+++ b/drivers/video/exynos/exynos_dp_reg.c
@@ -16,8 +16,6 @@
 
 #include <video/exynos_dp.h>
 
-#include <plat/cpu.h>
-
 #include "exynos_dp_core.h"
 #include "exynos_dp_reg.h"
 
-- 
1.7.1


