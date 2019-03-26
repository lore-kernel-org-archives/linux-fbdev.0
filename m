From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:42 +0000
Subject: [PATCH 09/11] drm/fbdevdrm: Add primary plane
Message-Id: <20190326091744.11542-10-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/Makefile           |   1 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c   |  42 ++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h   |   7 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c |   9 +-
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |   2 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c | 498 ++++++++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h |  27 ++
 7 files changed, 585 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h

diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
index 2ca906a3258b..5507152d8187 100644
--- a/drivers/gpu/drm/fbdevdrm/Makefile
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -5,6 +5,7 @@ fbdevdrm-y := fbdevdrm_bo.o \
 	      fbdevdrm_format.o \
 	      fbdevdrm_modes.o \
 	      fbdevdrm_modeset.o \
+	      fbdevdrm_primary.o \
 	      fbdevdrm_ttm.o
 
 obj-$(CONFIG_DRM_FBDEVDRM) += fbdevdrm.o
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
index bd3ad691e7ce..8dea7ef369dc 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
@@ -11,8 +11,12 @@
  */
 
 #include "fbdevdrm_modes.h"
+#include <drm/drm.h>
+#include <linux/sched.h> /* for TASK_COMM_LEN in <drm/drm_framebuffer.h> */
+#include <drm/drm_framebuffer.h>
 #include <drm/drm_modes.h>
 #include <linux/fb.h>
+#include "fbdevdrm_format.h"
 
 void drm_mode_update_from_fb_videomode(struct drm_display_mode *mode,
 				       const struct fb_videomode *fb_mode)
@@ -151,3 +155,41 @@ fbdevdrm_init_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *fb_var,
 	memset(fb_var, 0, sizeof(*fb_var));
 	fbdevdrm_update_fb_var_screeninfo_from_mode(fb_var, mode);
 }
+
+int fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
+	struct fb_var_screeninfo *fb_var, struct drm_framebuffer *fb,
+	size_t vram_size)
+{
+	unsigned int width, pitch;
+	uint64_t cpp, lines;
+	int ret;
+
+	/* Our virtual screen covers all the graphics memory (sans some
+	 * trailing bytes). This allows for setting the scanout buffer's
+	 * address with fb_pan_display().
+	 */
+
+	width = fb->pitches[0];
+	cpp = drm_format_plane_cpp(fb->format[0].format, 0);
+	do_div(width, cpp);
+
+	if (width > (__u32)-1)
+		return -EINVAL; /* would overflow fb_var->xres_virtual */
+
+	pitch = fb->pitches[0];
+	lines = vram_size;
+	do_div(lines, pitch);
+
+	if (lines > (__u32)-1)
+		return -EINVAL; /* would overflow fb_var->yres_virtual */
+
+	fb_var->xres_virtual = width;
+	fb_var->yres_virtual = lines;
+
+	ret = fbdevdrm_update_fb_var_screeninfo_from_format(
+		fb_var, fb->format[0].format);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
index f88a86a83858..925eea78e3f0 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
@@ -13,8 +13,11 @@
 #ifndef FBDEVDRM_MODES_H
 #define FBDEVDRM_MODES_H
 
+#include <linux/types.h>
+
 struct drm_device;
 struct drm_display_mode;
+struct drm_framebuffer;
 struct fb_videomode;
 struct fb_var_screeninfo;
 
@@ -43,4 +46,8 @@ void
 fbdevdrm_init_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *var,
 					  const struct drm_display_mode *mode);
 
+int fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
+	struct fb_var_screeninfo *fb_var, struct drm_framebuffer *fb,
+	size_t vram_size);
+
 #endif
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
index 585f3478f190..3473b85acbf1 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
@@ -20,6 +20,7 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/fb.h>
+#include "fbdevdrm_primary.h"
 
 /*
  * CRTC
@@ -376,7 +377,13 @@ int fbdevdrm_modeset_init(struct fbdevdrm_modeset *modeset,
 	 * connect them with each other.
 	 */
 
-	ret = drm_crtc_init_with_planes(dev, &modeset->crtc, NULL, NULL,
+	ret = fbdevdrm_init_primary_plane_from_fb_info(
+		&modeset->primary_plane, dev, 0, fb_info);
+	if (ret)
+		goto err_drm_mode_config_cleanup;
+
+	ret = drm_crtc_init_with_planes(dev, &modeset->crtc,
+					&modeset->primary_plane, NULL,
 					&fbdevdrm_crtc_funcs, NULL);
 	if (ret)
 		goto err_drm_mode_config_cleanup;
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
index 21e87caa8196..ec753014aba1 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
@@ -16,11 +16,13 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_plane.h>
 
 struct drm_device;
 struct fb_info;
 
 struct fbdevdrm_modeset {
+	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
new file mode 100644
index 000000000000..8ba8e6bd1c14
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
@@ -0,0 +1,498 @@
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
+#include "fbdevdrm_primary.h"
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_plane.h>
+#include <linux/fb.h>
+#include "fbdevdrm_bo.h"
+#include "fbdevdrm_format.h"
+#include "fbdevdrm_modes.h"
+#include "fbdevdrm_modeset.h"
+
+static struct fbdevdrm_modeset* fbdevdrm_modeset_of_primary_plane(
+	struct drm_plane *primary_plane)
+{
+	return container_of(primary_plane, struct fbdevdrm_modeset,
+			    primary_plane);
+}
+
+/*
+ * Primary plane
+ */
+
+static int primary_plane_helper_prepare_fb(struct drm_plane *plane,
+					   struct drm_plane_state *new_state)
+{
+        struct drm_gem_object *gem;
+        struct fbdevdrm_bo *fbo;
+	int ret;
+
+	if (!new_state->fb)
+		return 0;
+
+	gem = new_state->fb->obj[0];
+	fbo = fbdevdrm_bo_of_gem(gem);
+
+        ret = fbdevdrm_bo_pin(fbo, TTM_PL_FLAG_VRAM);
+        if (ret)
+                return ret;
+
+	return 0;
+}
+
+static void primary_plane_helper_cleanup_fb(struct drm_plane *plane,
+					    struct drm_plane_state *old_state)
+{
+        struct drm_gem_object *gem;
+        struct fbdevdrm_bo *fbo;
+
+	if (!old_state->fb)
+		return;
+
+	gem = old_state->fb->obj[0];
+	fbo = fbdevdrm_bo_of_gem(gem);
+
+	fbdevdrm_bo_unpin(fbo);
+}
+
+static void fbdevdrm_update_fb_var_screeninfo_from_crtc_state(
+	struct fb_var_screeninfo *fb_var, struct drm_crtc_state* crtc_state)
+{
+	fbdevdrm_update_fb_var_screeninfo_from_mode(fb_var, &crtc_state->adjusted_mode);
+}
+
+static int primary_plane_helper_atomic_check(struct drm_plane *plane,
+					     struct drm_plane_state *state)
+{
+	struct drm_crtc_state *new_crtc_state;
+	int ret;
+	struct fbdevdrm_modeset *modeset;
+	struct fb_var_screeninfo fb_var;
+
+	if (!state->crtc)
+		return 0;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(state->state,
+						       state->crtc);
+	if (!new_crtc_state)
+		return 0;
+
+	ret = drm_atomic_helper_check_plane_state(state, new_crtc_state,
+						  1 << 16, 1 << 16,
+						  false, true);
+	if (ret < 0) {
+		DRM_ERROR("fbdrmdev: %s:%d ret=%d:\n", __func__, __LINE__, ret);
+		return ret;
+	}
+
+	if (!state->visible || !state->fb)
+		return 0;
+
+	/* Virtual screen sizes are not supported.
+	 */
+
+	if (drm_rect_width(&state->dst) != state->fb->width ||
+	    drm_rect_height(&state->dst) != state->fb->height) {
+		DRM_ERROR("fbdevdrm: %s:%d: virtual screen sizes not supported\n", __func__, __LINE__);
+		return -EINVAL;
+	}
+	if (state->dst.x1 || state->dst.y1) {
+		DRM_ERROR("fbdevdrm: %s:%d: virtual screen offset not supported\n", __func__, __LINE__);
+		return -EINVAL;
+	}
+
+	/* Pixel formats have to be compatible with fbdev. This is
+	 * usually some variation of XRGB.
+	 */
+
+	if (!plane->state ||
+	    !plane->state->fb ||
+	    plane->state->fb->format[0].format != state->fb->format[0].format) {
+
+		modeset = fbdevdrm_modeset_of_primary_plane(plane);
+
+		if (modeset->fb_info->fbops->fb_check_var) {
+			memcpy(&fb_var, &modeset->fb_info->var,
+			       sizeof(fb_var));
+			fbdevdrm_update_fb_var_screeninfo_from_crtc_state(
+				&fb_var, new_crtc_state);
+			fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
+				&fb_var, state->fb,
+				modeset->fb_info->fix.smem_len);
+			ret = modeset->fb_info->fbops->fb_check_var(
+				&fb_var, modeset->fb_info);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int set_palette_cmap(struct fb_info* fb_info)
+{
+	__u32 len;
+	const struct fb_cmap* default_cmap;
+	struct fb_cmap cmap;
+	int ret;
+	const __u32 gamma_len[3] = {
+		fb_info->var.red.length,
+		fb_info->var.green.length,
+		fb_info->var.blue.length
+	};
+
+	len = max3(gamma_len[0], gamma_len[1], gamma_len[2]);
+	if (!len || (len > 31)) {
+		DRM_ERROR("fbdevdrm: gamma LUT has invalid bit count"
+			  " of %u\n", (unsigned int)len);
+		return -EINVAL;
+	}
+
+	default_cmap = fb_default_cmap(1ul << len);
+	if (!default_cmap)
+		return -EINVAL;
+
+	memset(&cmap, 0, sizeof(cmap));
+	ret = fb_alloc_cmap(&cmap, default_cmap->len, 0);
+	if (ret)
+		return ret;
+	ret = fb_copy_cmap(default_cmap, &cmap);
+	if (ret)
+		goto err_fb_dealloc_cmap;
+	ret = fb_set_cmap(&cmap, fb_info);
+	if (ret)
+		return ret;
+	fb_dealloc_cmap(&cmap);
+
+	return 0;
+
+err_fb_dealloc_cmap:
+	fb_dealloc_cmap(&cmap);
+	return ret;
+}
+
+static int set_linear_cmap(struct fb_info* fb_info)
+{
+	struct fb_cmap cmap;
+	int ret;
+	size_t i;
+	unsigned int j;
+	u16 *lut;
+	u16 incr;
+	u16 *gamma_lut[3];
+	__u32 len;
+	const __u32 gamma_len[3] = {
+		fb_info->var.red.length,
+		fb_info->var.green.length,
+		fb_info->var.blue.length
+	};
+
+	len = max3(gamma_len[0], gamma_len[1], gamma_len[2]);
+	if (!len || (len > 8)) {
+		DRM_ERROR("fbdevdrm: gamma LUT has invalid bit count"
+			  " of %u\n", (unsigned int)len);
+		return -EINVAL;
+	}
+
+	memset(&cmap, 0, sizeof(cmap));
+	ret = fb_alloc_cmap(&cmap, 1ul << len, 0);
+	if (ret)
+		return ret;
+
+	gamma_lut[0] = cmap.red;
+	gamma_lut[1] = cmap.green;
+	gamma_lut[2] = cmap.blue;
+
+	for (i = 0; i < ARRAY_SIZE(gamma_lut); ++i) {
+		lut = gamma_lut[i];
+		len = 1ul << gamma_len[i];
+		incr = 0x10000u >> gamma_len[i];
+		for (j = 0; j < len; ++j, ++lut) {
+			*lut = incr * j;
+		}
+		/* In order to have no intensity at index 0 and full
+		 * intensity at the final index of the LUT, we fix-up the
+		 * table's final entries. The fix-up makes intensity grow
+		 * faster near the final entries of the gamma LUT. The human
+		 * eye is more sensitive to changes to the lower intensities,
+		 * so this is probably not directly perceivable.
+		 */
+		for (lut -= gamma_len[i], j = gamma_len[i]; j > 0; ++lut) {
+			--j;
+			*lut += (incr >> j) - 1; /* subtract 1 to not
+						  * overflow the LUT's
+						  * final entry */
+		}
+	}
+
+	ret = fb_set_cmap(&cmap, fb_info);
+	if (ret)
+		goto err_fb_dealloc_cmap;
+	fb_dealloc_cmap(&cmap);
+
+	return 0;
+
+err_fb_dealloc_cmap:
+	fb_dealloc_cmap(&cmap);
+	return -EINVAL;
+}
+
+static int set_cmap(struct fb_info *fb_info)
+{
+	int ret = 0;
+
+	switch (fb_info->fix.visual) {
+	case FB_VISUAL_PSEUDOCOLOR:
+		ret = set_palette_cmap(fb_info);
+		break;
+	case FB_VISUAL_DIRECTCOLOR:
+		ret = set_linear_cmap(fb_info);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void primary_plane_helper_atomic_update(
+	struct drm_plane *plane, struct drm_plane_state *old_state)
+{
+	struct fbdevdrm_modeset *modeset;
+	uint32_t format;
+	struct fb_var_screeninfo fb_var;
+	int ret;
+        struct drm_gem_object *gem;
+        struct fbdevdrm_bo *fbo;
+	__u32 line_length;
+	uint64_t yoffset;
+	uint32_t xoffset;
+
+	modeset = fbdevdrm_modeset_of_primary_plane(plane);
+
+	format = fbdevdrm_format_of_fb_info(modeset->fb_info);
+
+	/* DRM porting notes: Some fbdev drivers report alpha channels for
+	 * their framebuffer, even though they don't support transparent
+	 * primary planes. For the format test below, we ignore the alpha
+	 * channel and use the non-transparent equivalent of the pixel format.
+	 * If you're porting an fbdev driver to DRM, remove this switch
+	 * statement and report the correct format instead.
+	 */
+	switch (format) {
+	case DRM_FORMAT_ARGB8888:
+		format = DRM_FORMAT_XRGB8888;
+		break;
+	case DRM_FORMAT_ABGR8888:
+		format = DRM_FORMAT_XBGR8888;
+		break;
+	case DRM_FORMAT_RGBA8888:
+		format = DRM_FORMAT_RGBX8888;
+		break;
+	case DRM_FORMAT_BGRA8888:
+		format = DRM_FORMAT_BGRX8888;
+		break;
+	default:
+		break;
+	}
+
+	if ((format != plane->state->fb->format[0].format) ||
+	    (modeset->fb_info->var.xres_virtual != plane->state->fb->width)) {
+
+		/* Pixel format changed, update fb_info accordingly
+		 */
+
+		memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var));
+		ret = fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
+			&fb_var, plane->state->fb,
+			modeset->fb_info->fix.smem_len);
+		if (ret)
+			return;
+
+		fb_var.activate = FB_ACTIVATE_NOW;
+
+		ret = fb_set_var(modeset->fb_info, &fb_var);
+		if (ret) {
+			DRM_ERROR("fbdevdrm: fb_set_var() failed: %d\n", ret);
+			return;
+		}
+	}
+
+	if (!old_state->fb || /* first-time update */
+	    (format != plane->state->fb->format[0].format)) {
+
+		/* DRM porting notes: Below we set the LUTs for palette and
+		 * gamma correction. This is required by some fbdev drivers,
+		 * such as nvidiafb and atyfb, which don't initialize the
+		 * table to pass-through the framebuffer values unchanged. This
+		 * is actually CRTC state, but the respective function
+		 * crtc_helper_mode_set_nofb() is only called when a CRTC
+		 * property changes, changes in color formats are not handled
+		 * there. When you're porting a fbdev driver to DRM, remove
+		 * the call. Gamma LUTs are CRTC properties and should be
+		 * handled there. Either remove gamma correction or set up
+		 * the respective CRTC properties for userspace.
+		 */
+		set_cmap(modeset->fb_info);
+	}
+
+	/* With the fb interface, we cannot directly program
+	 * the scanout buffer's address. Instead we use the
+	 * panning function to point the graphics card to the
+	 * buffer's location.
+	 */
+
+	gem = plane->state->fb->obj[0];
+	fbo = fbdevdrm_bo_of_gem(gem);
+
+	line_length = plane->state->fb->pitches[0];
+	yoffset = fbo->bo.offset;
+	xoffset = do_div(yoffset, line_length);
+	if (yoffset > (__u32)-1) {
+		/* The value of yoffset doesn't fit into a 32-bit value,
+		 * so we cannot use it for display panning. Either the
+		 * graphics card has GiBs of VRAM or this is a bug with
+		 * memory management. */
+		DRM_ERROR("fbdevdrm: buffer object is not aligned to a "
+			  "multiple of the scanline size.\n");
+		return;
+	} else if (xoffset) {
+		/* The buffer starts in the middle of a scanline. The
+		 * memory manager should have prevented this. This
+		 * problem indicates a bug with the buffer aligning. */
+		DRM_ERROR("fbdevdrm: buffer object is not aligned to a "
+			  "multiple of the scanline size.\n");
+		return;
+	}
+
+	memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var));
+	fb_var.xoffset = xoffset;
+	fb_var.yoffset = yoffset;
+
+	ret = fb_pan_display(modeset->fb_info, &fb_var);
+	if (ret) {
+		DRM_ERROR("fbdevdrm: fb_pan_display() failed: %d\n", ret);
+		return;
+	}
+}
+
+static void primary_plane_helper_atomic_disable(
+	struct drm_plane *plane, struct drm_plane_state *old_state)
+{ }
+
+static int primary_plane_helper_atomic_async_check(
+	struct drm_plane *plane, struct drm_plane_state *state)
+{
+	return 0;
+}
+
+static void primary_plane_helper_atomic_async_update(
+	struct drm_plane *plane, struct drm_plane_state *new_state)
+{
+	drm_plane_cleanup(plane);
+}
+
+static const struct drm_plane_helper_funcs primary_plane_helper_funcs = {
+	.prepare_fb = primary_plane_helper_prepare_fb,
+	.cleanup_fb = primary_plane_helper_cleanup_fb,
+	.atomic_check = primary_plane_helper_atomic_check,
+	.atomic_update = primary_plane_helper_atomic_update,
+	.atomic_disable = primary_plane_helper_atomic_disable,
+	.atomic_async_check = primary_plane_helper_atomic_async_check,
+	.atomic_async_update = primary_plane_helper_atomic_async_update
+};
+
+static void primary_plane_destroy(struct drm_plane *plane)
+{
+	drm_plane_cleanup(plane);
+}
+
+static const struct drm_plane_funcs primary_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	.destroy = primary_plane_destroy,
+	.reset = drm_atomic_helper_plane_reset,
+	.set_property = NULL, /* unused */
+	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.atomic_set_property = NULL, /* unused */
+	.atomic_get_property = NULL, /* unused */
+	.late_register = NULL, /* unused */
+	.early_unregister = NULL, /* unused */
+	.atomic_print_state = NULL, /* unused */
+	.format_mod_supported = NULL /* unused */
+};
+
+static const uint32_t*
+formats_from_fb_info(const struct fb_info* fb_info, unsigned int* format_count)
+{
+	/* TODO: Detect the actually supported formats or have some
+	 *       sort of whitelist for known hardware devices.
+	 */
+	static const uint32_t formats[] = {
+		DRM_FORMAT_XRGB8888,
+		DRM_FORMAT_RGB565
+	};
+
+	*format_count = ARRAY_SIZE(formats);
+
+	return formats;
+}
+
+int fbdevdrm_init_primary_plane_from_fb_info(struct drm_plane *plane,
+					     struct drm_device *dev,
+					     uint32_t possible_crtcs,
+					     struct fb_info *fb_info)
+{
+	uint32_t cur_format;
+	const uint32_t* format;
+	unsigned int format_count;
+	int ret;
+
+	/* We first try to find the supported pixel formats from the
+	 * fb_info's hardware settings. If that fails, we take the
+	 * current settings. */
+	format = formats_from_fb_info(fb_info, &format_count);
+	if (!format_count) {
+		cur_format = fbdevdrm_format_of_fb_info(fb_info);
+		format = &cur_format;
+		format_count = 1;
+	}
+	if (!format_count)
+		return -ENODEV;
+
+	ret = drm_universal_plane_init(dev, plane, possible_crtcs,
+				       &primary_plane_funcs,
+				       format, format_count,
+				       NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret < 0)
+		return ret;
+	drm_plane_helper_add(plane, &primary_plane_helper_funcs);
+
+	ret = drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
+						 DRM_MODE_ROTATE_0);
+	if (ret < 0)
+		goto err_drm_plane_cleanup;
+
+	ret = drm_plane_create_zpos_immutable_property(plane, 0);
+	if (ret < 0)
+		goto err_drm_plane_cleanup;
+
+	return 0;
+
+err_drm_plane_cleanup:
+	drm_plane_cleanup(plane);
+	return ret;
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
new file mode 100644
index 000000000000..529c272c6e0b
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
@@ -0,0 +1,27 @@
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
+#ifndef FBDEVDRM_PRIMARY_H
+#define FBDEVDRM_PRIMARY_H
+
+#include <linux/types.h>
+
+struct drm_device;
+struct drm_plane;
+struct fb_info;
+
+int fbdevdrm_init_primary_plane_from_fb_info(struct drm_plane *plane,
+					     struct drm_device *dev,
+					     uint32_t possible_crtcs,
+					     struct fb_info *fb_info);
+
+#endif
-- 
2.21.0
