From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 25 Jul 2017 17:38:52 +0000
Subject: [RESEND PATCH v2 2/2] drm/exynos/decon: Add include guard to the Exynos7 header
Message-Id: <1501004332-8093-2-git-send-email-krzk@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501004332-8093-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1501004332-8093-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Inki Dae <inki.dae@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>

Although header is included only once but still having an include guard
is a good practice.  To avoid confusion, add SoC prefix to existing
Exynos5433 header include guard.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Just re-order patches in patchset and slightly adjust include guard
   name.
---
 drivers/gpu/drm/exynos/regs-decon5433.h | 6 +++---
 drivers/gpu/drm/exynos/regs-decon7.h    | 5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/regs-decon5433.h b/drivers/gpu/drm/exynos/regs-decon5433.h
index 78957c9626f5..19ad9e47945e 100644
--- a/drivers/gpu/drm/exynos/regs-decon5433.h
+++ b/drivers/gpu/drm/exynos/regs-decon5433.h
@@ -6,8 +6,8 @@
  * published by the Free Software Foundationr
  */
 
-#ifndef EXYNOS_REGS_DECON_H
-#define EXYNOS_REGS_DECON_H
+#ifndef EXYNOS_REGS_DECON5433_H
+#define EXYNOS_REGS_DECON5433_H
 
 /* Exynos543X DECON */
 #define DECON_VIDCON0			0x0000
@@ -206,4 +206,4 @@
 #define CRCCTRL_CRCEN			(0x1 << 0)
 #define CRCCTRL_MASK			(0x7)
 
-#endif /* EXYNOS_REGS_DECON_H */
+#endif /* EXYNOS_REGS_DECON5433_H */
diff --git a/drivers/gpu/drm/exynos/regs-decon7.h b/drivers/gpu/drm/exynos/regs-decon7.h
index 339ea1007ff5..5df7765d2397 100644
--- a/drivers/gpu/drm/exynos/regs-decon7.h
+++ b/drivers/gpu/drm/exynos/regs-decon7.h
@@ -8,6 +8,9 @@
  * option) any later version.
  */
 
+#ifndef EXYNOS_REGS_DECON7_H
+#define EXYNOS_REGS_DECON7_H
+
 /* VIDCON0 */
 #define VIDCON0					0x00
 
@@ -346,3 +349,5 @@
 
 #define DECON_UPDATE_SLAVE_SYNC			(1 << 4)
 #define DECON_UPDATE_STANDALONE_F		(1 << 0)
+
+#endif /* EXYNOS_REGS_DECON7_H */
-- 
2.7.4

