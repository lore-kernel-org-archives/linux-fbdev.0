From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 15:55:51 +0000
Subject: [PATCH 6/8] drm: decouple from CONFIG_FB
Message-Id: <20200417155553.675905-7-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, dsd@laptop.org, Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>, airlied@linux.ie, masahiroy@kernel.org, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, kieran.bingham+renesas@ideasonboard.com, linux-graphics-maintainer@vmware.com, Laurent.pinchart@ideasonboard.com, jfrederich@gmail.com, robert.jarzmik@free.fr, daniel@zonque.org

CONFIG_DRM_KMS_FB_HELPER selects CONFIG_FB, which is something it
really should not, to avoid circular dependencies and accidentally
including potentially dangerous user interfaces in the kernel,
so change this into a 'depends on' check.

Two device drivers currently select CONFIG_DRM_KMS_FB_HELPER, but
as far as I can tell, they do not really need to any more, so those
selects can be removed.

This leaves DRM_FBDEV_EMULATION as the only thing that rightfully
selects CONFIG_DRM_KMS_FB_HELPER, and this now has to depend on
CONFIG_FB and its dependencies.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/Kconfig       | 5 +++--
 drivers/gpu/drm/mxsfb/Kconfig | 1 -
 drivers/gpu/drm/zte/Kconfig   | 1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 43594978958e..7c3109133685 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -80,7 +80,7 @@ config DRM_KMS_HELPER
 config DRM_KMS_FB_HELPER
 	bool
 	depends on DRM_KMS_HELPER
-	select FB
+	depends on FB
 	select FRAMEBUFFER_CONSOLE if !EXPERT
 	select FRAMEBUFFER_CONSOLE_DETECT_PRIMARY if FRAMEBUFFER_CONSOLE
 	select FB_SYS_FOPS
@@ -111,7 +111,8 @@ config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
 
 config DRM_FBDEV_EMULATION
 	bool "Enable legacy fbdev support for your modesetting driver"
-	depends on DRM
+	depends on DRM && FB
+	depends on FB=y || DRM=m
 	select DRM_KMS_HELPER
 	select DRM_KMS_FB_HELPER
 	default y
diff --git a/drivers/gpu/drm/mxsfb/Kconfig b/drivers/gpu/drm/mxsfb/Kconfig
index 0dca8f27169e..33916b7b2c50 100644
--- a/drivers/gpu/drm/mxsfb/Kconfig
+++ b/drivers/gpu/drm/mxsfb/Kconfig
@@ -10,7 +10,6 @@ config DRM_MXSFB
 	depends on COMMON_CLK
 	select DRM_MXS
 	select DRM_KMS_HELPER
-	select DRM_KMS_FB_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_PANEL
 	help
diff --git a/drivers/gpu/drm/zte/Kconfig b/drivers/gpu/drm/zte/Kconfig
index 90ebaedc11fd..aa8594190b50 100644
--- a/drivers/gpu/drm/zte/Kconfig
+++ b/drivers/gpu/drm/zte/Kconfig
@@ -3,7 +3,6 @@ config DRM_ZTE
 	tristate "DRM Support for ZTE SoCs"
 	depends on DRM && ARCH_ZX
 	select DRM_KMS_CMA_HELPER
-	select DRM_KMS_FB_HELPER
 	select DRM_KMS_HELPER
 	select SND_SOC_HDMI_CODEC if SND_SOC
 	select VIDEOMODE_HELPERS
-- 
2.26.0
