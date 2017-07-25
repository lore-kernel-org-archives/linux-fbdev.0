From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 25 Jul 2017 17:38:51 +0000
Subject: [RESEND PATCH v2 1/2] drm/exynos/decon: Move headers from global to local place
Message-Id: <1501004332-8093-1-git-send-email-krzk@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>

The DECON headers contain only defines for registers.  There are no
other drivers using them so this should be put locally to the Exynos DRM
driver.  Keeping headers local helps managing the code.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Just re-order patches in patchset.
---
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c                          | 3 +--
 drivers/gpu/drm/exynos/exynos7_drm_decon.c                             | 2 +-
 .../exynos5433_decon.h => drivers/gpu/drm/exynos/regs-decon5433.h      | 0
 include/video/exynos7_decon.h => drivers/gpu/drm/exynos/regs-decon7.h  | 3 +--
 4 files changed, 3 insertions(+), 5 deletions(-)
 rename include/video/exynos5433_decon.h => drivers/gpu/drm/exynos/regs-decon5433.h (100%)
 rename include/video/exynos7_decon.h => drivers/gpu/drm/exynos/regs-decon7.h (99%)

diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 5792ca88ab7a..5aca8c16f2bc 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -19,13 +19,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
-#include <video/exynos5433_decon.h>
-
 #include "exynos_drm_drv.h"
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_plane.h"
 #include "exynos_drm_iommu.h"
+#include "regs-decon5433.h"
 
 #define DSD_CFG_MUX 0x1004
 #define DSD_CFG_MUX_TE_UNMASK_GLOBAL BIT(13)
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 3e88269fdc2e..387e436c97d2 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -25,13 +25,13 @@
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
-#include <video/exynos7_decon.h>
 
 #include "exynos_drm_crtc.h"
 #include "exynos_drm_plane.h"
 #include "exynos_drm_drv.h"
 #include "exynos_drm_fb.h"
 #include "exynos_drm_iommu.h"
+#include "regs-decon7.h"
 
 /*
  * DECON stands for Display and Enhancement controller.
diff --git a/include/video/exynos5433_decon.h b/drivers/gpu/drm/exynos/regs-decon5433.h
similarity index 100%
rename from include/video/exynos5433_decon.h
rename to drivers/gpu/drm/exynos/regs-decon5433.h
diff --git a/include/video/exynos7_decon.h b/drivers/gpu/drm/exynos/regs-decon7.h
similarity index 99%
rename from include/video/exynos7_decon.h
rename to drivers/gpu/drm/exynos/regs-decon7.h
index a62b11b613f6..339ea1007ff5 100644
--- a/include/video/exynos7_decon.h
+++ b/drivers/gpu/drm/exynos/regs-decon7.h
@@ -1,5 +1,4 @@
-/* include/video/exynos7_decon.h
- *
+/*
  * Copyright (c) 2014 Samsung Electronics Co., Ltd.
  * Author: Ajay Kumar <ajaykumar.rs@samsung.com>
  *
-- 
2.7.4

