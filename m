From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:39 +0000
Subject: [PATCH 06/11] drm/fbdevdrm: Add modesetting infrastructure
Message-Id: <20190326091744.11542-7-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Modesetting for fbdevdrm supports a single display pipeline with CRTC,
primary plane, encoder and connector.

The fbdev device would have been an ideal candidate for using
|struct drm_simple_display_pipe|. To better illustrate the conversion
from fbdev to DRM drivers, fbdevdrm used the regular DRM data structures
instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/Makefile           |   1 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c  |   7 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h  |   2 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c     |   4 +-
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 430 ++++++++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |  36 ++
 6 files changed, 479 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h

diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
index fdfdb5233831..b8fab9d52faa 100644
--- a/drivers/gpu/drm/fbdevdrm/Makefile
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -2,6 +2,7 @@ ccflags-y = -Iinclude/drm
 fbdevdrm-y := fbdevdrm_bo.o \
 	      fbdevdrm_device.o \
 	      fbdevdrm_drv.o \
+	      fbdevdrm_modeset.o \
 	      fbdevdrm_ttm.o
 
 obj-$(CONFIG_DRM_FBDEVDRM) += fbdevdrm.o
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
index c8054eac271d..bb034f3d9392 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
@@ -37,10 +37,16 @@ int fbdevdrm_device_init(struct fbdevdrm_device *fdev, struct drm_driver *drv,
 	if (ret)
 		goto err_drm_dev_fini;
 
+	ret = fbdevdrm_modeset_init(&fdev->modeset, &fdev->dev, fb_info);
+	if (ret)
+		goto err_fbdevdrm_ttm_cleanup;
+
 	INIT_LIST_HEAD(&fdev->device_list);
 
 	return 0;
 
+err_fbdevdrm_ttm_cleanup:
+	fbdevdrm_ttm_cleanup(&fdev->ttm);
 err_drm_dev_fini:
 	drm_dev_fini(&fdev->dev);
 	return ret;
@@ -55,6 +61,7 @@ void fbdevdrm_device_cleanup(struct fbdevdrm_device *fdev)
 			  "in device list\n");
 	}
 
+	fbdevdrm_modeset_cleanup(&fdev->modeset);
 	fbdevdrm_ttm_cleanup(&fdev->ttm);
 
 	drm_dev_fini(dev);
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
index 381d9cfb1450..4068d12e3270 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
@@ -16,6 +16,7 @@
 #include <drm/drm_device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include "fbdevdrm_modeset.h"
 #include "fbdevdrm_ttm.h"
 
 struct drm_driver;
@@ -26,6 +27,7 @@ struct fbdevdrm_device {
 	struct fb_info *fb_info;
 
 	struct fbdevdrm_ttm ttm;
+	struct fbdevdrm_modeset modeset;
 
 	struct list_head device_list; /* entry in global device list */
 };
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
index 4724e3df6ace..dff9f44f05bd 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
@@ -148,7 +148,9 @@ static struct drm_driver fbdevdrm_drv = {
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESCRIPTION,
 	.date = DRIVER_DATE,
-	.driver_features = DRIVER_GEM,
+	.driver_features = DRIVER_ATOMIC |
+			   DRIVER_GEM |
+			   DRIVER_MODESET,
 	.fops = &driver_fops
 };
 
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
new file mode 100644
index 000000000000..585f3478f190
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
@@ -0,0 +1,430 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * One purpose of this driver is to allow for easy conversion of framebuffer
+ * drivers to DRM. As a special exception to the GNU GPL, you are allowed to
+ * relicense this file under the terms of a license of your choice if you're
+ * porting a framebuffer driver. In order to do so, update the SPDX license
+ * identifier to the new license and remove this exception.
+ *
+ * If you add code to this file, please ensure that it's compatible with the
+ * stated exception.
+ */
+
+#include "fbdevdrm_modeset.h"
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_modeset_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
+#include <linux/fb.h>
+
+/*
+ * CRTC
+ */
+
+static enum drm_mode_status crtc_helper_mode_valid(
+	struct drm_crtc *crtc, const struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static bool crtc_helper_mode_fixup(struct drm_crtc *crtc,
+				   const struct drm_display_mode *mode,
+				   struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void crtc_helper_mode_set_nofb(struct drm_crtc *crtc)
+{ }
+
+static int crtc_helper_mode_set_base_atomic(struct drm_crtc *crtc,
+					    struct drm_framebuffer *fb,
+					    int x, int y,
+					    enum mode_set_atomic mode)
+{
+	return 0;
+}
+
+static int crtc_helper_atomic_check(struct drm_crtc *crtc,
+				    struct drm_crtc_state *state)
+{
+	return 0;
+}
+
+static void crtc_helper_atomic_begin(
+	struct drm_crtc *crtc, struct drm_crtc_state *old_crtc_state)
+{ }
+
+static void crtc_helper_atomic_flush(
+	struct drm_crtc *crtc, struct drm_crtc_state *old_crtc_state)
+{ }
+
+static void crtc_helper_atomic_enable(
+	struct drm_crtc *crtc, struct drm_crtc_state *old_crtc_state)
+{ }
+
+static void crtc_helper_atomic_disable(
+	struct drm_crtc *crtc, struct drm_crtc_state *old_crtc_state)
+{ }
+
+static const struct drm_crtc_helper_funcs fbdevdrm_crtc_helper_funcs = {
+	.dpms = NULL, /* legacy */
+	.prepare = NULL, /* legacy */
+	.commit = NULL, /* legacy */
+	.mode_valid = crtc_helper_mode_valid,
+	.mode_fixup = crtc_helper_mode_fixup,
+	.mode_set = NULL, /* legacy */
+	.mode_set_nofb = crtc_helper_mode_set_nofb,
+	.mode_set_base = NULL, /* legacy */
+	.mode_set_base_atomic = crtc_helper_mode_set_base_atomic,
+	.disable = NULL, /* legacy */
+	.atomic_check = crtc_helper_atomic_check,
+	.atomic_begin = crtc_helper_atomic_begin,
+	.atomic_flush = crtc_helper_atomic_flush,
+	.atomic_enable = crtc_helper_atomic_enable,
+	.atomic_disable = crtc_helper_atomic_disable,
+};
+
+static void crtc_destroy(struct drm_crtc *crtc)
+{ }
+
+static int crtc_atomic_set_property(struct drm_crtc *crtc,
+				    struct drm_crtc_state *state,
+				    struct drm_property *property,
+				    uint64_t val)
+{
+	return -EINVAL;
+}
+
+static int crtc_atomic_get_property(struct drm_crtc *crtc,
+				    const struct drm_crtc_state *state,
+				    struct drm_property *property,
+				    uint64_t *val)
+{
+	return -EINVAL;
+}
+
+static int crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	return -ENODEV;
+}
+
+static void crtc_disable_vblank(struct drm_crtc *crtc)
+{ }
+
+static const struct drm_crtc_funcs fbdevdrm_crtc_funcs = {
+	.reset = drm_atomic_helper_crtc_reset,
+	.cursor_set = NULL, /* not supported by fbdev */
+	.cursor_set2 = NULL,
+	.cursor_move = NULL,
+	.gamma_set = NULL, /* not supported by fbdev */
+	.destroy = crtc_destroy,
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = NULL,
+	.page_flip_target = NULL,
+	.set_property = NULL, /* unused in atomic drivers */
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_set_property = crtc_atomic_set_property,
+	.atomic_get_property = crtc_atomic_get_property,
+	.late_register = NULL,
+	.early_unregister = NULL,
+	.set_crc_source = NULL,
+	.atomic_print_state = NULL,
+	.get_vblank_counter = NULL, /* not supported by fbdev */
+	.enable_vblank = crtc_enable_vblank,
+	.disable_vblank = crtc_disable_vblank
+};
+
+/*
+ * Encoder
+ */
+
+static enum drm_mode_status encoder_helper_mode_valid(
+	struct drm_encoder *crtc, const struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static bool encoder_helper_mode_fixup(struct drm_encoder *encoder,
+				      const struct drm_display_mode *mode,
+				      struct drm_display_mode *adjusted_mode)
+{
+	return true;
+}
+
+static void encoder_helper_atomic_mode_set(
+	struct drm_encoder *encoder, struct drm_crtc_state *crtc_state,
+	struct drm_connector_state *conn_state)
+{ }
+
+static void encoder_helper_disable(struct drm_encoder *encoder)
+{ }
+
+static void encoder_helper_enable(struct drm_encoder *encoder)
+{ }
+
+static int encoder_helper_atomic_check(struct drm_encoder *encoder,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	return 0;
+}
+
+static const struct drm_encoder_helper_funcs fbdevdrm_encoder_helper_funcs = {
+	.dpms = NULL, /* legacy */
+	.mode_valid = encoder_helper_mode_valid,
+	.mode_fixup = encoder_helper_mode_fixup,
+	.prepare = NULL, /* legacy */
+	.commit = NULL, /* legacy */
+	.mode_set = NULL, /* legacy */
+	.atomic_mode_set = encoder_helper_atomic_mode_set,
+	.get_crtc = NULL, /* legacy */
+	.detect = NULL, /* legacy */
+	.disable = encoder_helper_disable,
+	.enable = encoder_helper_enable,
+	.atomic_check = encoder_helper_atomic_check
+};
+
+static void encoder_destroy(struct drm_encoder *encoder)
+{ }
+
+static const struct drm_encoder_funcs fbdevdrm_encoder_funcs = {
+	.reset = NULL,
+	.destroy = encoder_destroy,
+	.late_register = NULL,
+	.early_unregister = NULL,
+};
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
+					 struct drm_connector_state *state)
+{
+	return 0;
+}
+
+static void connector_helper_atomic_commit(struct drm_connector *connector,
+					   struct drm_connector_state *state)
+{ }
+
+static const struct drm_connector_helper_funcs
+	fbdevdrm_connector_helper_funcs = {
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
+static const struct drm_connector_funcs fbdevdrm_connector_funcs = {
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
+ * Mode config
+ */
+
+static enum drm_mode_status mode_config_mode_valid(
+	struct drm_device *dev, const struct drm_display_mode *mode)
+{
+	return MODE_OK;
+}
+
+static const struct drm_mode_config_funcs fbdevdrm_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create,
+	.get_format_info = NULL,
+	/* DRM porting notes: the output_poll_changed callback is used by
+	 * fb helpers to implement fbdev emulation. As fbdevdrm is built
+	 * upon fbdev, this is basically the opposite. If you're porting
+	 * an fbdev driver to DRM and enable fbdev emulation, this callback
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
+/*
+ * Public interface
+ */
+
+static int update_mode_config_from_fb_info(struct drm_mode_config* mode_config, struct fb_info *fb_info)
+{
+	/* DRM backporting notes: This function only exists to work around
+	 * the fact that we don't know the hardware limitations. Here we
+	 * test for the maximum supported resolution. If you're converting
+	 * an fbdev driver to DRM, remove this function and simply fill in
+	 * the actual hardware limits in the mode_config structure.
+	 */
+
+	struct list_head *pos;
+	u32 xres = 0;
+	u32 yres = 0;
+	int num_modes = 0;
+
+	list_for_each(pos, &fb_info->modelist) {
+		const struct fb_modelist *modelist +			container_of(pos, struct fb_modelist, list);
+		if (modelist->mode.xres > xres)
+			xres = modelist->mode.xres;
+		if (modelist->mode.yres > yres)
+			yres = modelist->mode.yres;
+
+		++num_modes;
+	}
+
+	if (!xres || !yres)
+		return -ENODEV;
+
+	mode_config->max_width = (int)xres;
+	mode_config->max_height = (int)yres;
+	mode_config->fb_base = fb_info->fix.smem_start;
+
+	/* TODO: get preferred depth from screeninfo */
+	mode_config->preferred_depth = 32;
+
+	return 0;
+}
+
+int fbdevdrm_modeset_init(struct fbdevdrm_modeset *modeset,
+			  struct drm_device *dev, struct fb_info *fb_info)
+{
+	int ret;
+
+	modeset->dev = dev;
+	modeset->fb_info = fb_info;
+
+	drm_mode_config_init(dev);
+	ret = update_mode_config_from_fb_info(&dev->mode_config, fb_info);
+	if (ret)
+		goto err_drm_mode_config_cleanup;
+	dev->mode_config.funcs = &fbdevdrm_mode_config_funcs;
+
+	/* One by one, we enable all stages of the display pipeline and
+	 * connect them with each other.
+	 */
+
+	ret = drm_crtc_init_with_planes(dev, &modeset->crtc, NULL, NULL,
+					&fbdevdrm_crtc_funcs, NULL);
+	if (ret)
+		goto err_drm_mode_config_cleanup;
+	drm_crtc_helper_add(&modeset->crtc, &fbdevdrm_crtc_helper_funcs);
+
+	/* Use DRM_MODE_ENCODER_TYPE_DAC. It's true for many of the fbdev
+	 * devices and doesn't imply hotplugging. */
+	ret = drm_encoder_init(dev, &modeset->encoder,
+			       &fbdevdrm_encoder_funcs,
+			       DRM_MODE_ENCODER_DAC, NULL);
+	if (ret)
+		goto err_drm_mode_config_cleanup;
+	drm_encoder_helper_add(&modeset->encoder,
+			       &fbdevdrm_encoder_helper_funcs);
+
+	modeset->encoder.possible_crtcs = (1ul << modeset->crtc.index);
+
+	ret = drm_connector_init(dev, &modeset->connector,
+				 &fbdevdrm_connector_funcs,
+				 DRM_MODE_CONNECTOR_VGA);
+	if (ret)
+		goto err_drm_mode_config_cleanup;
+	drm_connector_helper_add(&modeset->connector,
+				 &fbdevdrm_connector_helper_funcs);
+
+	ret = drm_connector_register(&modeset->connector);
+	if (ret < 0)
+		goto err_drm_mode_config_cleanup;
+
+	ret = drm_connector_attach_encoder(&modeset->connector,
+					   &modeset->encoder);
+	if (ret)
+		goto err_drm_mode_config_cleanup;
+
+	/* Final step: resetting the device's mode config creates
+	 * state for all objects in the mode-setting pipeline.
+	 */
+	drm_mode_config_reset(dev);
+
+	return 0;
+
+err_drm_mode_config_cleanup:
+	/* Also removes all CRTCs, encoders and connectors that we added. */
+	drm_mode_config_cleanup(dev);
+	return ret;
+}
+
+void fbdevdrm_modeset_cleanup(struct fbdevdrm_modeset *modeset)
+{
+	drm_mode_config_cleanup(modeset->dev);
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
new file mode 100644
index 000000000000..21e87caa8196
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * One purpose of this driver is to allow for easy conversion of framebuffer
+ * drivers to DRM. As a special exception to the GNU GPL, you are allowed to
+ * relicense this file under the terms of a license of your choice if you're
+ * porting a framebuffer driver. In order to do so, update the SPDX license
+ * identifier to the new license and remove this exception.
+ *
+ * If you add code to this file, please ensure that it's compatible with the
+ * stated exception.
+ */
+
+#ifndef FBDEVDRM_MODESET_H
+#define FBDEVDRM_MODESET_H
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+
+struct drm_device;
+struct fb_info;
+
+struct fbdevdrm_modeset {
+	struct drm_crtc crtc;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+
+	struct drm_device *dev;
+	struct fb_info *fb_info;
+};
+
+int fbdevdrm_modeset_init(struct fbdevdrm_modeset *modeset,
+			  struct drm_device *dev, struct fb_info *fb_info);
+void fbdevdrm_modeset_cleanup(struct fbdevdrm_modeset *modeset);
+
+#endif
-- 
2.21.0
