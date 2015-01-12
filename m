From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2015 20:10:12 +0000
Subject: [PATCH v2 1/2] drm: Drop superfluous "select VT_HW_CONSOLE_BINDING"
Message-Id: <1421093413-26336-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Airlie <airlied@linux.ie>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

commit 765d5b9c2b72f5b9 ("fbdev: fbcon: select VT_HW_CONSOLE_BINDING")
made FRAMEBUFFER_CONSOLE always select VT_HW_CONSOLE_BINDING, but forgot
to remove

	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE

from the individual drivers' sections that already did this before.

Remove it, also from new drivers.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Split in two (drm and video) patches,
  - Fix recently added rockchip.
---
 drivers/gpu/drm/exynos/Kconfig   | 1 -
 drivers/gpu/drm/rockchip/Kconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/Kconfig b/drivers/gpu/drm/exynos/Kconfig
index 7f9f6f9e9b7e7992..c072999b7e0345c6 100644
--- a/drivers/gpu/drm/exynos/Kconfig
+++ b/drivers/gpu/drm/exynos/Kconfig
@@ -6,7 +6,6 @@ config DRM_EXYNOS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have a Samsung SoC EXYNOS chipset.
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index ca9f085efa922982..8652dad82009e3ce 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -7,7 +7,6 @@ config DRM_ROCKCHIP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
 	select VIDEOMODE_HELPERS
 	help
 	  Choose this option if you have a Rockchip soc chipset.
-- 
1.9.1

