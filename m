From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:34 +0000
Subject: [PATCH RFC 8/9] drm/omap: move omapdss & displays under omapdrm
Message-Id: <1449757535-5674-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that omapfb has its own copy of omapdss and display drivers, we can
move omapdss and display drivers which omapdrm uses to omapdrm's
directory.

We also need to change the main drm Makefile so that omapdrm directory
is always entered, because omapdss has a file that always needs to be
built-in.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/Makefile                                               | 2 +-
 drivers/gpu/drm/omapdrm/Kconfig                                        | 3 ++-
 drivers/gpu/drm/omapdrm/Makefile                                       | 3 +++
 .../fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/Kconfig      | 0
 .../fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/Makefile     | 0
 .../displays-new => gpu/drm/omapdrm/displays}/connector-analog-tv.c    | 0
 .../omap2/displays-new => gpu/drm/omapdrm/displays}/connector-dvi.c    | 0
 .../omap2/displays-new => gpu/drm/omapdrm/displays}/connector-hdmi.c   | 0
 .../omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-opa362.c   | 0
 .../omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-tfp410.c   | 0
 .../displays-new => gpu/drm/omapdrm/displays}/encoder-tpd12s015.c      | 0
 .../fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-dpi.c  | 0
 .../omap2/displays-new => gpu/drm/omapdrm/displays}/panel-dsi-cm.c     | 0
 .../drm/omapdrm/displays}/panel-lgphilips-lb035q02.c                   | 0
 .../displays-new => gpu/drm/omapdrm/displays}/panel-nec-nl8048hl11.c   | 0
 .../drm/omapdrm/displays}/panel-sharp-ls037v7dw01.c                    | 0
 .../displays-new => gpu/drm/omapdrm/displays}/panel-sony-acx565akm.c   | 0
 .../displays-new => gpu/drm/omapdrm/displays}/panel-tpo-td028ttec1.c   | 0
 .../displays-new => gpu/drm/omapdrm/displays}/panel-tpo-td043mtea1.c   | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/Kconfig             | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/Makefile            | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/apply.c             | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/core.c              | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc-compat.c      | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc-compat.h      | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.c             | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.h             | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc_coefs.c       | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/display-sysfs.c     | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/display.c           | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dpi.c               | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dsi.c               | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss-of.c            | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.c               | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.h               | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss_features.c      | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss_features.h      | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi.h              | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4.c             | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.c        | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.h        | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5.c             | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.c        | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.h        | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_common.c       | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_phy.c          | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_pll.c          | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_wp.c           | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/manager-sysfs.c     | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/manager.c           | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/omapdss-boot-init.c | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/output.c            | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay-sysfs.c     | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay.c           | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/pll.c               | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/rfbi.c              | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/sdi.c               | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/venc.c              | 0
 drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/video-pll.c         | 0
 drivers/video/fbdev/omap2/Kconfig                                      | 2 --
 drivers/video/fbdev/omap2/Makefile                                     | 2 --
 61 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/Kconfig (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/Makefile (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/connector-analog-tv.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/connector-dvi.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/connector-hdmi.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-opa362.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-tfp410.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-tpd12s015.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-dpi.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-dsi-cm.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-lgphilips-lb035q02.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-nec-nl8048hl11.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-sharp-ls037v7dw01.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-sony-acx565akm.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-tpo-td028ttec1.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-tpo-td043mtea1.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/Kconfig (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/Makefile (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/apply.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/core.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc-compat.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc-compat.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc_coefs.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/display-sysfs.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/display.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dpi.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dsi.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss-of.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss_features.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss_features.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.h (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_common.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_phy.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_pll.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_wp.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/manager-sysfs.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/manager.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/omapdss-boot-init.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/output.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay-sysfs.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/pll.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/rfbi.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/sdi.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/venc.c (100%)
 rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/video-pll.c (100%)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 1e9ff4c3e3db..db6245f4b961 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_DRM_ARMADA) += armada/
 obj-$(CONFIG_DRM_ATMEL_HLCDC)	+= atmel-hlcdc/
 obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
 obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
-obj-$(CONFIG_DRM_OMAP)	+= omapdrm/
+obj-y			+= omapdrm/
 obj-y			+= tilcdc/
 obj-$(CONFIG_DRM_QXL) += qxl/
 obj-$(CONFIG_DRM_BOCHS) += bochs/
diff --git a/drivers/gpu/drm/omapdrm/Kconfig b/drivers/gpu/drm/omapdrm/Kconfig
index 6c220cd3497a..49b5b7df6ba4 100644
--- a/drivers/gpu/drm/omapdrm/Kconfig
+++ b/drivers/gpu/drm/omapdrm/Kconfig
@@ -1,4 +1,3 @@
-
 config DRM_OMAP
 	tristate "OMAP DRM"
 	depends on DRM
@@ -24,3 +23,5 @@ config DRM_OMAP_NUM_CRTCS
 	  Select the number of video overlays which can be used as framebuffers.
 	  The remaining overlays are reserved for video.
 
+source "drivers/gpu/drm/omapdrm/dss/Kconfig"
+source "drivers/gpu/drm/omapdrm/displays/Kconfig"
diff --git a/drivers/gpu/drm/omapdrm/Makefile b/drivers/gpu/drm/omapdrm/Makefile
index 778372b062ad..d48d97f80e8c 100644
--- a/drivers/gpu/drm/omapdrm/Makefile
+++ b/drivers/gpu/drm/omapdrm/Makefile
@@ -3,6 +3,9 @@
 # Direct Rendering Infrastructure (DRI)
 #
 
+obj-y += dss/
+obj-y += displays/
+
 ccflags-y := -Iinclude/drm -Werror
 omapdrm-y := omap_drv.o \
 	omap_irq.o \
diff --git a/drivers/video/fbdev/omap2/displays-new/Kconfig b/drivers/gpu/drm/omapdrm/displays/Kconfig
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/Kconfig
rename to drivers/gpu/drm/omapdrm/displays/Kconfig
diff --git a/drivers/video/fbdev/omap2/displays-new/Makefile b/drivers/gpu/drm/omapdrm/displays/Makefile
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/Makefile
rename to drivers/gpu/drm/omapdrm/displays/Makefile
diff --git a/drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c b/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/connector-analog-tv.c
rename to drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
diff --git a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c b/drivers/gpu/drm/omapdrm/displays/connector-dvi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/connector-dvi.c
rename to drivers/gpu/drm/omapdrm/displays/connector-dvi.c
diff --git a/drivers/video/fbdev/omap2/displays-new/connector-hdmi.c b/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/connector-hdmi.c
rename to drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-opa362.c b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/encoder-opa362.c
rename to drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
rename to drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
rename to drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-dpi.c
rename to drivers/gpu/drm/omapdrm/displays/panel-dpi.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c
rename to drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-lgphilips-lb035q02.c
rename to drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c b/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-nec-nl8048hl11.c
rename to drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-sharp-ls037v7dw01.c
rename to drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-sony-acx565akm.c
rename to drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-tpo-td028ttec1.c
rename to drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
diff --git a/drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
similarity index 100%
rename from drivers/video/fbdev/omap2/displays-new/panel-tpo-td043mtea1.c
rename to drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
diff --git a/drivers/video/fbdev/omap2/dss/Kconfig b/drivers/gpu/drm/omapdrm/dss/Kconfig
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/Kconfig
rename to drivers/gpu/drm/omapdrm/dss/Kconfig
diff --git a/drivers/video/fbdev/omap2/dss/Makefile b/drivers/gpu/drm/omapdrm/dss/Makefile
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/Makefile
rename to drivers/gpu/drm/omapdrm/dss/Makefile
diff --git a/drivers/video/fbdev/omap2/dss/apply.c b/drivers/gpu/drm/omapdrm/dss/apply.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/apply.c
rename to drivers/gpu/drm/omapdrm/dss/apply.c
diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/gpu/drm/omapdrm/dss/core.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/core.c
rename to drivers/gpu/drm/omapdrm/dss/core.c
diff --git a/drivers/video/fbdev/omap2/dss/dispc-compat.c b/drivers/gpu/drm/omapdrm/dss/dispc-compat.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dispc-compat.c
rename to drivers/gpu/drm/omapdrm/dss/dispc-compat.c
diff --git a/drivers/video/fbdev/omap2/dss/dispc-compat.h b/drivers/gpu/drm/omapdrm/dss/dispc-compat.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dispc-compat.h
rename to drivers/gpu/drm/omapdrm/dss/dispc-compat.h
diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dispc.c
rename to drivers/gpu/drm/omapdrm/dss/dispc.c
diff --git a/drivers/video/fbdev/omap2/dss/dispc.h b/drivers/gpu/drm/omapdrm/dss/dispc.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dispc.h
rename to drivers/gpu/drm/omapdrm/dss/dispc.h
diff --git a/drivers/video/fbdev/omap2/dss/dispc_coefs.c b/drivers/gpu/drm/omapdrm/dss/dispc_coefs.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dispc_coefs.c
rename to drivers/gpu/drm/omapdrm/dss/dispc_coefs.c
diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/gpu/drm/omapdrm/dss/display-sysfs.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/display-sysfs.c
rename to drivers/gpu/drm/omapdrm/dss/display-sysfs.c
diff --git a/drivers/video/fbdev/omap2/dss/display.c b/drivers/gpu/drm/omapdrm/dss/display.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/display.c
rename to drivers/gpu/drm/omapdrm/dss/display.c
diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/gpu/drm/omapdrm/dss/dpi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dpi.c
rename to drivers/gpu/drm/omapdrm/dss/dpi.c
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dsi.c
rename to drivers/gpu/drm/omapdrm/dss/dsi.c
diff --git a/drivers/video/fbdev/omap2/dss/dss-of.c b/drivers/gpu/drm/omapdrm/dss/dss-of.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dss-of.c
rename to drivers/gpu/drm/omapdrm/dss/dss-of.c
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dss.c
rename to drivers/gpu/drm/omapdrm/dss/dss.c
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/gpu/drm/omapdrm/dss/dss.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dss.h
rename to drivers/gpu/drm/omapdrm/dss/dss.h
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/gpu/drm/omapdrm/dss/dss_features.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dss_features.c
rename to drivers/gpu/drm/omapdrm/dss/dss_features.c
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.h b/drivers/gpu/drm/omapdrm/dss/dss_features.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/dss_features.h
rename to drivers/gpu/drm/omapdrm/dss/dss_features.h
diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/gpu/drm/omapdrm/dss/hdmi.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi.h
rename to drivers/gpu/drm/omapdrm/dss/hdmi.h
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi4.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi4.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi4_core.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi4_core.h b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi4_core.h
rename to drivers/gpu/drm/omapdrm/dss/hdmi4_core.h
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi5.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi5.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi5_core.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi5_core.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi5_core.h b/drivers/gpu/drm/omapdrm/dss/hdmi5_core.h
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi5_core.h
rename to drivers/gpu/drm/omapdrm/dss/hdmi5_core.h
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_common.c b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi_common.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi_common.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi_phy.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi_pll.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
diff --git a/drivers/video/fbdev/omap2/dss/hdmi_wp.c b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/hdmi_wp.c
rename to drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
diff --git a/drivers/video/fbdev/omap2/dss/manager-sysfs.c b/drivers/gpu/drm/omapdrm/dss/manager-sysfs.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/manager-sysfs.c
rename to drivers/gpu/drm/omapdrm/dss/manager-sysfs.c
diff --git a/drivers/video/fbdev/omap2/dss/manager.c b/drivers/gpu/drm/omapdrm/dss/manager.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/manager.c
rename to drivers/gpu/drm/omapdrm/dss/manager.c
diff --git a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
rename to drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
diff --git a/drivers/video/fbdev/omap2/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/output.c
rename to drivers/gpu/drm/omapdrm/dss/output.c
diff --git a/drivers/video/fbdev/omap2/dss/overlay-sysfs.c b/drivers/gpu/drm/omapdrm/dss/overlay-sysfs.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/overlay-sysfs.c
rename to drivers/gpu/drm/omapdrm/dss/overlay-sysfs.c
diff --git a/drivers/video/fbdev/omap2/dss/overlay.c b/drivers/gpu/drm/omapdrm/dss/overlay.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/overlay.c
rename to drivers/gpu/drm/omapdrm/dss/overlay.c
diff --git a/drivers/video/fbdev/omap2/dss/pll.c b/drivers/gpu/drm/omapdrm/dss/pll.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/pll.c
rename to drivers/gpu/drm/omapdrm/dss/pll.c
diff --git a/drivers/video/fbdev/omap2/dss/rfbi.c b/drivers/gpu/drm/omapdrm/dss/rfbi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/rfbi.c
rename to drivers/gpu/drm/omapdrm/dss/rfbi.c
diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/gpu/drm/omapdrm/dss/sdi.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/sdi.c
rename to drivers/gpu/drm/omapdrm/dss/sdi.c
diff --git a/drivers/video/fbdev/omap2/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/venc.c
rename to drivers/gpu/drm/omapdrm/dss/venc.c
diff --git a/drivers/video/fbdev/omap2/dss/video-pll.c b/drivers/gpu/drm/omapdrm/dss/video-pll.c
similarity index 100%
rename from drivers/video/fbdev/omap2/dss/video-pll.c
rename to drivers/gpu/drm/omapdrm/dss/video-pll.c
diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
index 7fbdb583de8c..0921c4de8407 100644
--- a/drivers/video/fbdev/omap2/Kconfig
+++ b/drivers/video/fbdev/omap2/Kconfig
@@ -1,7 +1,5 @@
 if ARCH_OMAP2PLUS
 
-source "drivers/video/fbdev/omap2/dss/Kconfig"
 source "drivers/video/fbdev/omap2/omapfb/Kconfig"
-source "drivers/video/fbdev/omap2/displays-new/Kconfig"
 
 endif
diff --git a/drivers/video/fbdev/omap2/Makefile b/drivers/video/fbdev/omap2/Makefile
index a52b716a40c1..71ab5ac91106 100644
--- a/drivers/video/fbdev/omap2/Makefile
+++ b/drivers/video/fbdev/omap2/Makefile
@@ -1,3 +1 @@
-obj-y += dss/
-obj-y += displays-new/
 obj-y += omapfb/
-- 
2.5.0

