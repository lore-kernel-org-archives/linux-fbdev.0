From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 04 May 2012 01:48:42 +0000
Subject: [PATCH] video: exynos_dp: remove unnecessary header includes
Message-Id: <003101cd2998$091e4940$1b5adbc0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Remove unnecessary headers from the file.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/exynos/exynos_dp_reg.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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


