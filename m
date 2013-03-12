From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 12 Mar 2013 10:19:34 +0000
Subject: [PATCH 1/5] videomode: simplify videomode Kconfig and Makefile
Message-Id: <1363083578-17062-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch simplifies videomode related Kconfig and Makefile. After this
patch, there's only one non-user selectable Kconfig option left,
VIDEOMODE_HELPERS. The reasons for the change:

* Videomode helper functions are not something that should be shown in
  the kernel configuration options. The related code should just be
  included if it's needed, i.e. selected by drivers using videomode.

* There's no need to have separate Kconfig options for videomode and
  display_timing. First of all, the amount of code for both is quite
  small. Second, videomode depends on display_timing, and display_timing
  in itself is not really useful, so both would be included in any case.

* CONFIG_VIDEOMODE is a bit vague name, and CONFIG_VIDEOMODE_HELPERS
  describes better what's included.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/drm_modes.c    |    8 ++++----
 drivers/gpu/drm/tilcdc/Kconfig |    3 +--
 drivers/video/Kconfig          |   22 ++--------------------
 drivers/video/Makefile         |    8 ++++----
 drivers/video/fbmon.c          |    8 ++++----
 5 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 04fa6f1..0698c0e 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -506,7 +506,7 @@ drm_gtf_mode(struct drm_device *dev, int hdisplay, int vdisplay, int vrefresh,
 }
 EXPORT_SYMBOL(drm_gtf_mode);
 
-#if IS_ENABLED(CONFIG_VIDEOMODE)
+#ifdef CONFIG_VIDEOMODE_HELPERS
 int drm_display_mode_from_videomode(const struct videomode *vm,
 				    struct drm_display_mode *dmode)
 {
@@ -540,9 +540,8 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(drm_display_mode_from_videomode);
-#endif
 
-#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
+#ifdef CONFIG_OF
 /**
  * of_get_drm_display_mode - get a drm_display_mode from devicetree
  * @np: device_node with the timing specification
@@ -572,7 +571,8 @@ int of_get_drm_display_mode(struct device_node *np,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_drm_display_mode);
-#endif
+#endif /* CONFIG_OF */
+#endif /* CONFIG_VIDEOMODE_HELPERS */
 
 /**
  * drm_mode_set_name - set the name on a mode
diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
index d24d040..e461e99 100644
--- a/drivers/gpu/drm/tilcdc/Kconfig
+++ b/drivers/gpu/drm/tilcdc/Kconfig
@@ -4,8 +4,7 @@ config DRM_TILCDC
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
-	select OF_VIDEOMODE
-	select OF_DISPLAY_TIMING
+	select VIDEOMODE_HELPERS
 	select BACKLIGHT_CLASS_DEVICE
 	help
 	  Choose this option if you have an TI SoC with LCDC display
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..2a81b11 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -31,26 +31,8 @@ config VIDEO_OUTPUT_CONTROL
 	  This framework adds support for low-level control of the video 
 	  output switch.
 
-config DISPLAY_TIMING
-       bool
-
-config VIDEOMODE
-       bool
-
-config OF_DISPLAY_TIMING
-	bool "Enable device tree display timing support"
-	depends on OF
-	select DISPLAY_TIMING
-	help
-	  helper to parse display timings from the devicetree
-
-config OF_VIDEOMODE
-	bool "Enable device tree videomode support"
-	depends on OF
-	select VIDEOMODE
-	select OF_DISPLAY_TIMING
-	help
-	  helper to get videomodes from the devicetree
+config VIDEOMODE_HELPERS
+	bool
 
 config HDMI
 	bool
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 9df3873..e414378 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -171,7 +171,7 @@ obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
 
 #video output switch sysfs driver
 obj-$(CONFIG_VIDEO_OUTPUT_CONTROL) += output.o
-obj-$(CONFIG_DISPLAY_TIMING) += display_timing.o
-obj-$(CONFIG_OF_DISPLAY_TIMING) += of_display_timing.o
-obj-$(CONFIG_VIDEOMODE) += videomode.o
-obj-$(CONFIG_OF_VIDEOMODE) += of_videomode.o
+obj-$(CONFIG_VIDEOMODE_HELPERS) += display_timing.o videomode.o
+ifeq ($(CONFIG_OF),y)
+obj-$(CONFIG_VIDEOMODE_HELPERS) += of_display_timing.o of_videomode.o
+endif
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 94ad0f7..368cedf 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1376,7 +1376,7 @@ int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_inf
 	return err;
 }
 
-#if IS_ENABLED(CONFIG_VIDEOMODE)
+#ifdef CONFIG_VIDEOMODE_HELPERS
 int fb_videomode_from_videomode(const struct videomode *vm,
 				struct fb_videomode *fbmode)
 {
@@ -1424,9 +1424,8 @@ int fb_videomode_from_videomode(const struct videomode *vm,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fb_videomode_from_videomode);
-#endif
 
-#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
+#ifdef CONFIG_OF
 static inline void dump_fb_videomode(const struct fb_videomode *m)
 {
 	pr_debug("fb_videomode = %ux%u@%uHz (%ukHz) %u %u %u %u %u %u %u %u %u\n",
@@ -1465,7 +1464,8 @@ int of_get_fb_videomode(struct device_node *np, struct fb_videomode *fb,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_fb_videomode);
-#endif
+#endif /* CONFIG_OF */
+#endif /* CONFIG_VIDEOMODE_HELPERS */
 
 #else
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
-- 
1.7.10.4

