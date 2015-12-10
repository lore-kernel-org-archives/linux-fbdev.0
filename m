From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:35 +0000
Subject: [PATCH RFC 9/9] drm/omap: make omapdrm select OMAP2_DSS
Message-Id: <1449757535-5674-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that omapdss is only for omapdrm, we can change omapdrm to select
OMAP2_DSS to enable omapdss if omapdrm is enabled, instead of omapdrm
depending on omapdss.

We can also change omapdss and the display drivers to depend on
DRM_OMAP, so that they are only visible under omapdrm in menuconfig.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/Kconfig          | 7 +++++--
 drivers/gpu/drm/omapdrm/displays/Kconfig | 3 +--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
index 49b5b7df6ba4..336ad4de9981 100644
--- a/drivers/gpu/drm/omapdrm/Kconfig
+++ b/drivers/gpu/drm/omapdrm/Kconfig
@@ -2,7 +2,7 @@ config DRM_OMAP
 	tristate "OMAP DRM"
 	depends on DRM
 	depends on ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM
-	depends on OMAP2_DSS
+	select OMAP2_DSS
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	select FB_SYS_FILLRECT
@@ -13,15 +13,18 @@ config DRM_OMAP
 	help
 	  DRM display driver for OMAP2/3/4 based boards.
 
+if DRM_OMAP
+
 config DRM_OMAP_NUM_CRTCS
 	int "Number of CRTCs"
 	range 1 10
 	default 1  if ARCH_OMAP2 || ARCH_OMAP3
 	default 2  if ARCH_OMAP4
-	depends on DRM_OMAP
 	help
 	  Select the number of video overlays which can be used as framebuffers.
 	  The remaining overlays are reserved for video.
 
 source "drivers/gpu/drm/omapdrm/dss/Kconfig"
 source "drivers/gpu/drm/omapdrm/displays/Kconfig"
+
+endif
diff --git a/drivers/gpu/drm/omapdrm/displays/Kconfig b/drivers/gpu/drm/omapdrm/displays/Kconfig
index 574710141a61..2a618afe0f53 100644
--- a/drivers/gpu/drm/omapdrm/displays/Kconfig
+++ b/drivers/gpu/drm/omapdrm/displays/Kconfig
@@ -1,5 +1,4 @@
-menu "OMAP Display Device Drivers (new device model)"
-        depends on OMAP2_DSS
+menu "OMAPDRM External Display Device Drivers"
 
 config DISPLAY_ENCODER_OPA362
 	tristate "OPA362 external analog amplifier"
-- 
2.5.0

