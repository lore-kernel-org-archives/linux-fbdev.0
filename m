From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 27 Mar 2013 06:58:25 +0000
Subject: [PATCHv2 5/5] videomode: videomode_from_timing work
Message-Id: <1364367505-4366-6-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

We currently have videomode_from_timing(), which takes one
display_timing entry from display_timings.

To make it easier to use display_timing without display_timings, this
patch renames videomode_from_timing() to videomode_from_timings(), and
adds a new videomode_from_timing() which just converts a given
display_timing to videomode.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/tilcdc/tilcdc_panel.c |    2 +-
 drivers/video/of_videomode.c          |    2 +-
 drivers/video/videomode.c             |   25 ++++++++++++++++---------
 include/video/videomode.h             |   15 +++++++++++++--
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index 580b74e..90ee497 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -173,7 +173,7 @@ static int panel_connector_get_modes(struct drm_connector *connector)
 		struct drm_display_mode *mode = drm_mode_create(dev);
 		struct videomode vm;
 
-		if (videomode_from_timing(timings, &vm, i))
+		if (videomode_from_timings(timings, &vm, i))
 			break;
 
 		drm_display_mode_from_videomode(&vm, mode);
diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
index 5b8066c..111c2d1 100644
--- a/drivers/video/of_videomode.c
+++ b/drivers/video/of_videomode.c
@@ -43,7 +43,7 @@ int of_get_videomode(struct device_node *np, struct videomode *vm,
 	if (index = OF_USE_NATIVE_MODE)
 		index = disp->native_mode;
 
-	ret = videomode_from_timing(disp, vm, index);
+	ret = videomode_from_timings(disp, vm, index);
 	if (ret)
 		return ret;
 
diff --git a/drivers/video/videomode.c b/drivers/video/videomode.c
index a3d95f2..df375c9 100644
--- a/drivers/video/videomode.c
+++ b/drivers/video/videomode.c
@@ -11,15 +11,9 @@
 #include <video/display_timing.h>
 #include <video/videomode.h>
 
-int videomode_from_timing(const struct display_timings *disp,
-			  struct videomode *vm, unsigned int index)
+void videomode_from_timing(const struct display_timing *dt,
+			  struct videomode *vm)
 {
-	struct display_timing *dt;
-
-	dt = display_timings_get(disp, index);
-	if (!dt)
-		return -EINVAL;
-
 	vm->pixelclock = dt->pixelclock.typ;
 	vm->hactive = dt->hactive.typ;
 	vm->hfront_porch = dt->hfront_porch.typ;
@@ -32,7 +26,20 @@ int videomode_from_timing(const struct display_timings *disp,
 	vm->vsync_len = dt->vsync_len.typ;
 
 	vm->flags = dt->flags;
+}
+EXPORT_SYMBOL_GPL(videomode_from_timing);
+
+int videomode_from_timings(const struct display_timings *disp,
+			  struct videomode *vm, unsigned int index)
+{
+	struct display_timing *dt;
+
+	dt = display_timings_get(disp, index);
+	if (!dt)
+		return -EINVAL;
+
+	videomode_from_timing(dt, vm);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(videomode_from_timing);
+EXPORT_SYMBOL_GPL(videomode_from_timings);
diff --git a/include/video/videomode.h b/include/video/videomode.h
index 8b12e60..3f1049d 100644
--- a/include/video/videomode.h
+++ b/include/video/videomode.h
@@ -34,14 +34,25 @@ struct videomode {
 
 /**
  * videomode_from_timing - convert display timing to videomode
+ * @dt: display_timing structure
+ * @vm: return value
+ *
+ * DESCRIPTION:
+ * This function converts a struct display_timing to a struct videomode.
+ */
+void videomode_from_timing(const struct display_timing *dt,
+			  struct videomode *vm);
+
+/**
+ * videomode_from_timings - convert one display timings entry to videomode
  * @disp: structure with all possible timing entries
  * @vm: return value
  * @index: index into the list of display timings in devicetree
  *
  * DESCRIPTION:
- * This function converts a struct display_timing to a struct videomode.
+ * This function converts one struct display_timing entry to a struct videomode.
  */
-int videomode_from_timing(const struct display_timings *disp,
+int videomode_from_timings(const struct display_timings *disp,
 			  struct videomode *vm, unsigned int index);
 
 #endif
-- 
1.7.10.4

