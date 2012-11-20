From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 20 Nov 2012 15:54:56 +0000
Subject: [PATCH v12 6/6] drm_modes: add of_videomode helpers
Message-Id: <1353426896-6045-7-git-send-email-s.trumtrar@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de>
In-Reply-To: <1353426896-6045-1-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Add helper to get drm_display_mode from devicetree.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
Acked-by: Thierry Reding <thierry.reding@avionic-design.de>
Tested-by: Thierry Reding <thierry.reding@avionic-design.de>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/drm_modes.c |   35 ++++++++++++++++++++++++++++++++++-
 include/drm/drmP.h          |    6 ++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 0073b27..04feef8 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -35,7 +35,8 @@
 #include <linux/export.h>
 #include <drm/drmP.h>
 #include <drm/drm_crtc.h>
-#include <linux/videomode.h>
+#include <linux/of.h>
+#include <linux/of_videomode.h>
 
 /**
  * drm_mode_debug_printmodeline - debug print a mode
@@ -541,6 +542,38 @@ int drm_display_mode_from_videomode(const struct videomode *vm,
 EXPORT_SYMBOL_GPL(drm_display_mode_from_videomode);
 #endif
 
+#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
+/**
+ * of_get_drm_display_mode - get a drm_display_mode from devicetree
+ * @np: device_node with the timing specification
+ * @dmode: will be set to the return value
+ * @index: index into the list of display timings in devicetree
+ *
+ * This function is expensive and should only be used, if only one mode is to be
+ * read from DT. To get multiple modes start with of_get_display_timings and
+ * work with that instead.
+ */
+int of_get_drm_display_mode(const struct device_node *np,
+			    struct drm_display_mode *dmode, unsigned int index)
+{
+	struct videomode vm;
+	int ret;
+
+	ret = of_get_videomode(np, &vm, index);
+	if (ret)
+		return ret;
+
+	drm_display_mode_from_videomode(&vm, dmode);
+
+	pr_info("%s: got %dx%d display mode from %s\n", __func__, vm.hactive,
+		vm.vactive, np->name);
+	drm_mode_debug_printmodeline(dmode);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_get_drm_display_mode);
+#endif
+
 /**
  * drm_mode_set_name - set the name on a mode
  * @mode: name will be set in this mode
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index de2f6cf..377280f 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -56,6 +56,7 @@
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/videomode.h>
 #if defined(__alpha__) || defined(__powerpc__)
 #include <asm/pgtable.h>	/* For pte_wrprotect */
@@ -1459,6 +1460,11 @@ drm_mode_create_from_cmdline_mode(struct drm_device *dev,
 extern int drm_display_mode_from_videomode(const struct videomode *vm,
 					   struct drm_display_mode *dmode);
 #endif
+#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
+extern int of_get_drm_display_mode(const struct device_node *np,
+				   struct drm_display_mode *dmode,
+				   unsigned int index);
+#endif
 
 /* Modesetting support */
 extern void drm_vblank_pre_modeset(struct drm_device *dev, int crtc);
-- 
1.7.10.4

