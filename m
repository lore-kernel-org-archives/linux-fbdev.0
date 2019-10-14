From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:08 +0000
Subject: [PATCH v2 07/15] drm/fbconv: Add modesetting infrastructure
Message-Id: <20191014140416.28517-8-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

Modesetting for fbconv supports a single display pipeline with CRTC,
primary plane, encoder and connector. It's implementation is based on
struct drm_simple_display_pipe, which fits this use case nicely.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbconv_helper.c | 382 ++++++++++++++++++++++++++++
 include/drm/drm_fbconv_helper.h     |  78 ++++++
 2 files changed, 460 insertions(+)

diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index e5a58a361ae9..4cda1f15e072 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -4,8 +4,13 @@
 
 #include <linux/fb.h>
 
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_fbconv_helper.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
 
 /*
  * Format conversion helpers
@@ -635,3 +640,380 @@ void drm_fbconv_init_fb_var_screeninfo_from_mode(
 	drm_fbconv_update_fb_var_screeninfo_from_mode(fb_var, mode);
 }
 EXPORT_SYMBOL(drm_fbconv_init_fb_var_screeninfo_from_mode);
+
+/*
+ * Connector
+ */
+
+static int connector_helper_get_modes(struct drm_connector *connector)
+{
+	return 0;
+}
+
+static int connector_helper_detect_ctx(struct drm_connector *connector,
+				       struct drm_modeset_acquire_ctx *ctx,
+				       bool force)
+{
+	return connector_status_connected;
+}
+
+static enum drm_mode_status connector_helper_mode_valid(
+	struct drm_connector *connector, struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static int connector_helper_atomic_check(struct drm_connector *connector,
+					 struct drm_atomic_state *state)
+{
+	return 0;
+}
+
+static void connector_helper_atomic_commit(struct drm_connector *connector,
+					   struct drm_connector_state *state)
+{ }
+
+static const struct drm_connector_helper_funcs connector_helper_funcs = {
+	.get_modes = connector_helper_get_modes,
+	.detect_ctx = connector_helper_detect_ctx,
+	.mode_valid = connector_helper_mode_valid,
+	.best_encoder = NULL, /* use default */
+	.atomic_best_encoder = NULL, /* use best_encoder instead */
+	.atomic_check = connector_helper_atomic_check,
+	.atomic_commit = connector_helper_atomic_commit
+};
+
+static enum drm_connector_status connector_detect(
+	struct drm_connector *connector, bool force)
+{
+	return connector_status_connected;
+}
+
+static void connector_force(struct drm_connector *connector)
+{ }
+
+static void connector_destroy(struct drm_connector *connector)
+{ }
+
+static int connector_atomic_set_property(struct drm_connector *connector,
+					 struct drm_connector_state *state,
+					 struct drm_property *property,
+					 uint64_t val)
+{
+	return -EINVAL;
+}
+
+static int connector_atomic_get_property(
+	struct drm_connector *connector,
+	const struct drm_connector_state *state, struct drm_property *property,
+	uint64_t *val)
+{
+	return -EINVAL;
+}
+
+static const struct drm_connector_funcs connector_funcs = {
+	.dpms = NULL, /* not used by atomic drivers */
+	.reset = drm_atomic_helper_connector_reset,
+	.detect = connector_detect,
+	.force = connector_force,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.set_property = NULL,
+	.late_register = NULL,
+	.early_unregister = NULL,
+	.destroy = connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.atomic_set_property = connector_atomic_set_property,
+	.atomic_get_property = connector_atomic_get_property,
+	.atomic_print_state = NULL
+};
+
+/*
+ * Simple display pipe
+ */
+
+/**
+ * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
+ *	struct drm_simple_display_pipe_funcs.mode_valid
+ * @crtc:	the DRM CRTC structure
+ * @mode:	the display mode to validate
+ * Returns:
+ *	MODE_OK on success, or
+ *	a MODE constant otherwise
+ */
+enum drm_mode_status
+drm_fbconv_simple_display_pipe_mode_valid(struct drm_crtc *crtc,
+					  const struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_mode_valid);
+
+/**
+ * drm_fbconv_simple_display_pipe_mode_fixup - default implementation for
+ *	struct drm_simple_display_pipe_funcs.mode_fixup
+ * @crtc:		the DRM CRTC structure
+ * @mode:		the display mode
+ * @adjusted_mode:	the adjusted display mode
+ * Returns:
+ *	true on success, or
+ *	false otherwise
+ */
+bool drm_fbconv_simple_display_pipe_mode_fixup(
+	struct drm_crtc *crtc, const struct drm_display_mode *mode,
+	struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_mode_fixup);
+
+/**
+ * drm_fbconv_simple_display_pipe_enable - default implementation for
+ *	struct drm_simple_display_pipe_funcs.enable
+ * @pipe:		the display pipe structure
+ * @crtc_state:		the new CRTC state
+ * @plane_state:	the new plane state
+ */
+void
+drm_fbconv_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_plane_state *plane_state)
+{ }
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_enable);
+
+/**
+ * drm_fbconv_simple_display_pipe_disable - default implementation for
+ *	struct drm_simple_display_pipe_funcs.disable
+ * @pipe:		the display pipe structure
+ */
+void
+drm_fbconv_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
+{ }
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_disable);
+
+/**
+ * drm_fbconv_simple_display_pipe_check - default implementation for
+ *	struct drm_simple_display_pipe_funcs.check
+ * @pipe:		the display pipe structure
+ * @plane_state:	the new plane state
+ * @crtc_state:		the new CRTC state
+ */
+int
+drm_fbconv_simple_display_pipe_check(struct drm_simple_display_pipe *pipe,
+				     struct drm_plane_state *plane_state,
+				     struct drm_crtc_state *crtc_state)
+{
+	return 0;
+}
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_check);
+
+/**
+ * drm_fbconv_simple_display_pipe_mode_update - default implementation for
+ *	struct drm_simple_display_pipe_funcs.update
+ * @pipe:		the display pipe structure
+ * @old_plane_state:	the old plane state
+ */
+void
+drm_fbconv_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
+				      struct drm_plane_state *old_plane_state)
+{ }
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_update);
+
+/**
+ * drm_fbconv_simple_display_pipe_prepare_fb - default implementation for
+ *	struct drm_simple_display_pipe_funcs.prepare_fb
+ * @pipe:		the display pipe structure
+ * @plane_state:	the new plane state
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise.
+ *
+ * The implementation of struct drm_simple_display_pipe_funcs.prepare_fb
+ * maps the framebuffer's buffer object and the fbdev's screen memory, if
+ * necessary. After converting the fbdev driver to DRM, only the buffer-object
+ * mapping should remaing. See drm_fbconv_simple_display_pipe_cleanup_fb() for
+ * the corresponding clean-up helper.
+ */
+int
+drm_fbconv_simple_display_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
+					  struct drm_plane_state *plane_state)
+{ }
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_prepare_fb);
+
+/**
+ * drm_fbconv_simple_display_pipe_cleanup_fb - default implementation for
+ *	struct drm_simple_display_pipe_funcs.cleanup_fb
+ * @pipe:		the display pipe structure
+ * @plane_state:	the old plane state
+ *
+ * This function cleans up the framebuffer state after a plane update. See
+ * drm_fbconv_simple_display_pipe_prepare_fb() for the corresponding prepare
+ * helper.
+ */
+void
+drm_fbconv_simple_display_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
+					  struct drm_plane_state *plane_state)
+{ }
+
+static const struct drm_simple_display_pipe_funcs simple_display_pipe_funcs = {
+	.mode_valid = drm_fbconv_simple_display_pipe_mode_valid,
+	.mode_fixup = drm_fbconv_simple_display_pipe_mode_fixup,
+	.enable	    = drm_fbconv_simple_display_pipe_enable,
+	.disable    = drm_fbconv_simple_display_pipe_disable,
+	.check	    = drm_fbconv_simple_display_pipe_check,
+	.update	    = drm_fbconv_simple_display_pipe_update,
+	.prepare_fb = drm_fbconv_simple_display_pipe_prepare_fb,
+	.cleanup_fb = drm_fbconv_simple_display_pipe_cleanup_fb,
+};
+
+/*
+ * Mode config
+ */
+
+static enum drm_mode_status mode_config_mode_valid(
+	struct drm_device *dev, const struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static const struct drm_mode_config_funcs mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.get_format_info = NULL,
+	/* DRM porting notes: the output_poll_changed callback is used by
+	 * fb helpers to implement fbdev emulation. If you're porting an
+	 * fbdev driver to DRM and enable fbdev emulation, this callback
+	 * will become useful.
+	 */
+	.output_poll_changed = drm_fb_helper_output_poll_changed,
+	.mode_valid = mode_config_mode_valid,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_state_alloc = NULL,
+	.atomic_state_clear = NULL,
+	.atomic_state_free = NULL
+};
+
+/**
+ * drm_fbconv_modeset_init - initializes an fbconv modesetting structure
+ * @modeset:		the fbconv modesetting structure to initialize
+ * @dev:		the DRM device
+ * @fb_info:		the fbdev driver's fb_info structure
+ * @max_width:		the maximum display width that is supported by
+ *                      the device
+ * @max_height:		the maximum display height that is supported by
+ *                      the device
+ * @preferred_depth:	the device's preferred color depth
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise
+ *
+ * This function initializes an instance of struct drm_fbconv_modeset. The
+ * supplied values for max_width, max_height, and max_depth should match the
+ * devices capabilities and be supported by the fbdev driver. DRM helpers
+ * will use these to auto-configure and validate display settings.
+ */
+int drm_fbconv_modeset_init(struct drm_fbconv_modeset *modeset,
+			    struct drm_device *dev, struct fb_info *fb_info,
+			    unsigned int max_width, unsigned int max_height,
+			    unsigned int preferred_depth)
+{
+	struct drm_mode_config *mode_config = &dev->mode_config;
+
+	modeset->dev = dev;
+	modeset->fb_info = fb_info;
+
+	drm_mode_config_init(dev);
+
+	mode_config->max_width = (int)max_width;
+	mode_config->max_height = (int)max_height;
+	mode_config->fb_base = fb_info->fix.smem_start;
+	mode_config->preferred_depth = preferred_depth;
+	mode_config->prefer_shadow_fbdev = true;
+	mode_config->funcs = &mode_config_funcs;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_fbconv_modeset_init);
+
+/**
+ * drm_fbconv_modeset_cleanup - Cleans up an fbconv modesetting structure
+ * @modeset:	the fbconv modesetting structure to clean up
+ */
+void drm_fbconv_modeset_cleanup(struct drm_fbconv_modeset *modeset)
+{
+	drm_mode_config_cleanup(modeset->dev);
+}
+EXPORT_SYMBOL(drm_fbconv_modeset_cleanup);
+
+/**
+ * drm_fbconv_modeset_setup_pipe - sets up the display pipeline for fbconv
+ * @modeset:		an fbconv modesetting structure
+ * @funcs:		an implementation of
+ *                      struct drm_simple_display_pipe_funcs, or NULL
+ * @formats:		the device's supported display formats
+ * @format_count:	the number of entries in @formats
+ * @format_modifiers:	DRM format modifiers, or NULL
+ * @connector:		the DRM connector, or NULL
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise
+ *
+ * This function sets up the display pipeline for an initialized instance of
+ * struct drm_fbconv_modeset. For maximum compatibility with userspace, the
+ * provided list of formats should contain at least DRM_FORMAT_XRGB8888 and
+ * DRM_FORMAT_RGB565. The necessary conversion to the hardware's actual
+ * configuration can be performed by drm_fbconv_simple_display_pipe_update().
+ *
+ * The values for @funcs, @format_modifiers, and @connector should be NULL
+ * by default. Explicitly settings these parameters will only be helpful for
+ * refactoring an fbdev driver into a DRM driver.
+ */
+int
+drm_fbconv_modeset_setup_pipe(struct drm_fbconv_modeset *modeset,
+			      const struct drm_simple_display_pipe_funcs *funcs,
+			      const uint32_t *formats,
+			      unsigned int format_count,
+			      const uint64_t *format_modifiers,
+			      struct drm_connector *connector)
+{
+	int ret;
+
+	/* DRM porting note: Now let's enable the display pipeline. If
+	 * you're porting a framebuffer driver to DRM, you may want to
+	 * set the correct connector type or replace the simple display
+	 * pipeline with something more sophisticated.
+	 */
+
+	if (!funcs)
+		funcs = &simple_display_pipe_funcs;
+
+	if (!connector) {
+		connector = &modeset->connector;
+
+		ret = drm_connector_init(modeset->dev, connector,
+					 &connector_funcs,
+					 DRM_MODE_CONNECTOR_Unknown);
+		if (ret)
+			return ret;
+		drm_connector_helper_add(connector, &connector_helper_funcs);
+
+		ret = drm_connector_register(connector);
+		if (ret < 0)
+			return ret;
+
+	}
+
+	ret = drm_simple_display_pipe_init(modeset->dev, &modeset->pipe,
+					   funcs, formats, format_count,
+					   format_modifiers, connector);
+	if (ret)
+		return ret;
+
+	/* Final step: resetting the device's mode config creates
+	 * state for all objects in the mode-setting pipeline.
+	 */
+	drm_mode_config_reset(modeset->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_fbconv_modeset_setup_pipe);
diff --git a/include/drm/drm_fbconv_helper.h b/include/drm/drm_fbconv_helper.h
index cbb13228c76c..79716af687c1 100644
--- a/include/drm/drm_fbconv_helper.h
+++ b/include/drm/drm_fbconv_helper.h
@@ -3,7 +3,11 @@
 #ifndef DRM_FBCONV_HELPER_H
 #define DRM_FBCONV_HELPER_H
 
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_simple_kms_helper.h>
 
 struct drm_device;
 struct drm_display_mode;
@@ -51,4 +55,78 @@ void drm_fbconv_update_fb_var_screeninfo_from_mode(
 void drm_fbconv_init_fb_var_screeninfo_from_mode(
 	struct fb_var_screeninfo *var, const struct drm_display_mode *mode);
 
+/*
+ * Simple display pipe
+ */
+
+enum drm_mode_status
+drm_fbconv_simple_display_pipe_mode_valid(struct drm_crtc *crtc,
+					  const struct drm_display_mode *mode);
+
+bool drm_fbconv_simple_display_pipe_mode_fixup(
+	struct drm_crtc *crtc, const struct drm_display_mode *mode,
+	struct drm_display_mode *adjusted_mode);
+
+void
+drm_fbconv_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
+				      struct drm_crtc_state *crtc_state,
+				      struct drm_plane_state *plane_state);
+
+void
+drm_fbconv_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe);
+
+int
+drm_fbconv_simple_display_pipe_check(struct drm_simple_display_pipe *pipe,
+				     struct drm_plane_state *plane_state,
+				     struct drm_crtc_state *crtc_state);
+
+void
+drm_fbconv_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
+				      struct drm_plane_state *old_plane_state);
+
+int
+drm_fbconv_simple_display_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
+					  struct drm_plane_state *plane_state);
+
+void
+drm_fbconv_simple_display_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
+					  struct drm_plane_state *plane_state);
+
+/*
+ * Modeset helpers
+ */
+
+/**
+ * struct drm_fbconv_modeset - contains state for fbconv modesetting
+ * @connector:	the DRM connector
+ * @pipe:	the modesetting pipeline
+ * @dev:	the DRM device
+ * @fb_info:	the fbdev driver's fb_info structure
+ */
+struct drm_fbconv_modeset {
+	struct drm_connector connector;
+	struct drm_simple_display_pipe pipe;
+
+	struct drm_device *dev;
+	struct fb_info *fb_info;
+};
+
+static inline struct drm_fbconv_modeset *drm_fbconv_modeset_of_pipe(
+	struct drm_simple_display_pipe *pipe)
+{
+	return container_of(pipe, struct drm_fbconv_modeset, pipe);
+}
+
+int drm_fbconv_modeset_init(struct drm_fbconv_modeset *modeset,
+			    struct drm_device *dev, struct fb_info *fb_info,
+			    unsigned int max_width, unsigned int max_height,
+			    unsigned int preferred_depth);
+void drm_fbconv_modeset_cleanup(struct drm_fbconv_modeset *modeset);
+
+int drm_fbconv_modeset_setup_pipe(
+	struct drm_fbconv_modeset *modeset,
+	const struct drm_simple_display_pipe_funcs *funcs,
+	const uint32_t *formats, unsigned int format_count,
+	const uint64_t *format_modifiers, struct drm_connector *connector);
+
 #endif
-- 
2.23.0
