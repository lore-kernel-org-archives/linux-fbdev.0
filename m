From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 17 Apr 2020 15:55:49 +0000
Subject: [PATCH 4/8] drm/rcar: stop using 'imply' for dependencies
Message-Id: <20200417155553.675905-5-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417155553.675905-1-arnd@arndb.de>
In-Reply-To: <20200417155553.675905-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, linux-fbdev@vger.kernel.org
Cc: marex@denx.de, dsd@laptop.org, Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>, airlied@linux.ie, masahiroy@kernel.org, Nicolas Pitre <nico@fluxnic.net>, Saeed Mahameed <saeedm@mellanox.com>, thellstrom@vmware.com, haojian.zhuang@gmail.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, kieran.bingham+renesas@ideasonboard.com, linux-graphics-maintainer@vmware.com, Laurent.pinchart@ideasonboard.com, jfrederich@gmail.com, robert.jarzmik@free.fr, daniel@zonque.org

The meaning of the 'imply' keyword has changed recently, and neither the
old meaning (select the symbol if its dependencies are met) nor the new
meaning (enable it by default, but let the user set any other setting)
is what we want here.

Work around this by adding two more Kconfig options that lead to
the correct behavior: if DRM_RCAR_USE_CMM and DRM_RCAR_USE_LVDS
are enabled, that portion of the driver becomes usable, and no
configuration results in a link error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rcar-du/Kconfig | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index 0919f1f159a4..d2fcec807dfa 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -4,8 +4,6 @@ config DRM_RCAR_DU
 	depends on DRM && OF
 	depends on ARM || ARM64
 	depends on ARCH_RENESAS || COMPILE_TEST
-	imply DRM_RCAR_CMM
-	imply DRM_RCAR_LVDS
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
@@ -14,13 +12,17 @@ config DRM_RCAR_DU
 	  Choose this option if you have an R-Car chipset.
 	  If M is selected the module will be called rcar-du-drm.
 
-config DRM_RCAR_CMM
-	tristate "R-Car DU Color Management Module (CMM) Support"
-	depends on DRM && OF
+config DRM_RCAR_USE_CMM
+	bool "R-Car DU Color Management Module (CMM) Support"
 	depends on DRM_RCAR_DU
+	default DRM_RCAR_DU
 	help
 	  Enable support for R-Car Color Management Module (CMM).
 
+config DRM_RCAR_CMM
+	def_tristate DRM_RCAR_DU
+	depends on DRM_RCAR_USE_CMM
+
 config DRM_RCAR_DW_HDMI
 	tristate "R-Car DU Gen3 HDMI Encoder Support"
 	depends on DRM && OF
@@ -28,15 +30,20 @@ config DRM_RCAR_DW_HDMI
 	help
 	  Enable support for R-Car Gen3 internal HDMI encoder.
 
-config DRM_RCAR_LVDS
-	tristate "R-Car DU LVDS Encoder Support"
-	depends on DRM && DRM_BRIDGE && OF
+config DRM_RCAR_USE_LVDS
+	bool "R-Car DU LVDS Encoder Support"
+	depends on DRM_BRIDGE && OF
+	default DRM_RCAR_DU
 	select DRM_PANEL
 	select OF_FLATTREE
 	select OF_OVERLAY
 	help
 	  Enable support for the R-Car Display Unit embedded LVDS encoders.
 
+config DRM_RCAR_LVDS
+	def_tristate DRM_RCAR_DU
+	depends on DRM_RCAR_USE_LVDS
+
 config DRM_RCAR_VSP
 	bool "R-Car DU VSP Compositor Support" if ARM
 	default y if ARM64
-- 
2.26.0
