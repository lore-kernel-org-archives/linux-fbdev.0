From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:09 +0000
Subject: [PATCH v2 08/15] drm/fbconv: Add plane-state check and update
Message-Id: <20191014140416.28517-9-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

For the update of the primary plane, we copy the content of a SHMEM buffer
object to the hardware's on-screen buffer; doing a format conversion if
necessary. This is able to support all combinations of framebuffers and
hardware, and should work with any fbdev driver.

Occasionally, fbdev drivers require an update of the hardware's gamma
tables to not show distorted colors. We also do this during the plane
update.

There's no support for horizontal panning, as fbdev drivers vary widely
in their capability to do this. Vertical panning is supported to the
extend allowed by available video ram. However, this whole functionality
is more interesting for porting drivers and not directly required by
fbconv itself.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig             |   1 +
 drivers/gpu/drm/drm_fbconv_helper.c | 500 +++++++++++++++++++++++++++-
 include/drm/drm_fbconv_helper.h     |   9 +
 3 files changed, 507 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ed689201ec81..2ce7749c3157 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -160,6 +160,7 @@ config DRM_DP_CEC
 config DRM_FBCONV_HELPER
 	tristate "Enable fbdev conversion helpers"
 	depends on DRM
+	select DRM_GEM_SHMEM_HELPER
 	help
 	  Provides helpers for running DRM on top of fbdev drivers. Choose
 	  this option if you're converting an fbdev driver to DRM. The
diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index 4cda1f15e072..cf218016ac05 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -5,12 +5,17 @@
 #include <linux/fb.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_fbconv_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_format_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 /*
  * Format conversion helpers
@@ -728,10 +733,192 @@ static const struct drm_connector_funcs connector_funcs = {
 	.atomic_print_state = NULL
 };
 
+/*
+ * Colormap updates
+ */
+
+/* provides a default colormap for palette modes */
+static int create_palette_cmap(struct fb_cmap *cmap,
+			       const struct fb_var_screeninfo *fb_var)
+{
+	__u32 len;
+	const struct fb_cmap *default_cmap;
+	int ret;
+
+	len = max3(fb_var->red.length,
+		   fb_var->green.length,
+		   fb_var->blue.length);
+	if (!len || (len > 31)) {
+		DRM_ERROR("fbconv: Gamma LUT has invalid bit count of %u\n",
+			  (unsigned int)len);
+		return -EINVAL;
+	}
+
+	default_cmap = fb_default_cmap(1ul << len);
+	if (!default_cmap) {
+		DRM_ERROR("fbconv: fb_default_cmap() failed\n");
+		return -EINVAL;
+	}
+
+	ret = fb_alloc_cmap(cmap, default_cmap->len, 0);
+	if (ret) {
+		DRM_ERROR("fbconv: fb_alloc_cmap() failed: %d\n", ret);
+		return ret;
+	}
+	ret = fb_copy_cmap(default_cmap, cmap);
+	if (ret) {
+		DRM_ERROR("fbconv: fb_copy_cmap() failed: %d\n", ret);
+		goto err_fb_dealloc_cmap;
+	}
+
+	return 0;
+
+err_fb_dealloc_cmap:
+	fb_dealloc_cmap(cmap);
+	return ret;
+}
+
+/* provides a linear color ramp for RGB modes */
+static int create_linear_cmap(struct fb_cmap *cmap,
+			      const struct fb_var_screeninfo *fb_var)
+{
+	int ret;
+	size_t i;
+	unsigned int j;
+	u16 *lut;
+	u16 incr;
+	u16 *gamma_lut[3];
+	__u32 len;
+	const __u32 gamma_len[3] = {
+		fb_var->red.length,
+		fb_var->green.length,
+		fb_var->blue.length
+	};
+
+	len = max3(gamma_len[0], gamma_len[1], gamma_len[2]);
+	if (!len || (len > 8)) {
+		DRM_ERROR("fbconv: gamma LUT has invalid bit count of %u\n",
+			  (unsigned int)len);
+		return -EINVAL;
+	}
+
+	ret = fb_alloc_cmap(cmap, 1ul << len, 0);
+	if (ret) {
+		DRM_ERROR("fbconv: fb_alloc_cmap() failed: %d\n", ret);
+		return ret;
+	}
+
+	gamma_lut[0] = cmap->red;
+	gamma_lut[1] = cmap->green;
+	gamma_lut[2] = cmap->blue;
+
+	for (i = 0; i < ARRAY_SIZE(gamma_lut); ++i) {
+		lut = gamma_lut[i];
+		len = 1ul << gamma_len[i];
+		incr = 0x10000u >> gamma_len[i];
+		for (j = 0; j < len; ++j, ++lut)
+			*lut = incr * j;
+
+		/* In order to have no intensity at index 0 and full
+		 * intensity at the final index of the LUT, we fix-up the
+		 * table's final entries. The fix-up makes intensity grow
+		 * faster near the final entries of the gamma LUT. The human
+		 * eye is more sensitive to changes to the lower intensities,
+		 * so this is probably not directly perceivable.
+		 */
+		for (lut -= gamma_len[i], j = gamma_len[i]; j > 0; ++lut) {
+			--j;
+			/* subtract 1 to not overflow the LUT's final entry */
+			*lut += (incr >> j) - 1;
+		}
+	}
+
+	return 0;
+}
+
+static int set_cmap(struct fb_info *fb_info)
+{
+	struct fb_cmap cmap;
+	int ret;
+
+	memset(&cmap, 0, sizeof(cmap));
+
+	switch (fb_info->fix.visual) {
+	case FB_VISUAL_PSEUDOCOLOR:
+		ret = create_palette_cmap(&cmap, &fb_info->var);
+		break;
+	case FB_VISUAL_DIRECTCOLOR:
+		ret = create_linear_cmap(&cmap, &fb_info->var);
+		break;
+	default:
+		return 0;
+	}
+	if (ret)
+		return ret;
+
+	ret = fb_set_cmap(&cmap, fb_info);
+	if (ret) {
+		DRM_ERROR("fbconv: fb_set_cmap() failed: %d\n", ret);
+		goto err_fb_dealloc_cmap;
+	}
+	fb_dealloc_cmap(&cmap);
+
+	return 0;
+
+err_fb_dealloc_cmap:
+	fb_dealloc_cmap(&cmap);
+	return ret;
+}
+
 /*
  * Simple display pipe
  */
 
+static void drm_fbconv_update_fb_var_screeninfo_from_crtc_state(
+	struct fb_var_screeninfo *fb_var, struct drm_crtc_state *crtc_state)
+{
+	drm_fbconv_update_fb_var_screeninfo_from_mode(
+		fb_var, &crtc_state->adjusted_mode);
+}
+
+static int drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
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
+	cpp = fb->format[0].cpp[0];
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
+	ret = drm_fbconv_update_fb_var_screeninfo_from_format(
+		fb_var, fb->format[0].format);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 /**
  * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
  *	struct drm_simple_display_pipe_funcs.mode_valid
@@ -767,6 +954,52 @@ bool drm_fbconv_simple_display_pipe_mode_fixup(
 }
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_mode_fixup);
 
+/**
+ * drm_fbconv_blit_rect - copy an area of pixel data from a framebuffer
+ *	to the hardware buffer
+ * @dst:	the on-screen hardware buffer
+ * @vaddr:	the source buffer in kernel address space
+ * @fb:		the framebuffer of the source buffer
+ * @rect:	the area to copy
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise.
+ *
+ * This function copies the pixel data from a DRM framebuffer to a hardware
+ * buffer; doing necessary format conversion in the process. Not all
+ * combinations of source and destination formats are currently supported.
+ */
+int drm_fbconv_blit_rect(void *dst, void *vaddr, struct drm_framebuffer *fb,
+			 struct drm_rect *rect)
+{
+	struct drm_device *dev = fb->dev;
+
+	if (!vaddr)
+		return 0; /* no framebuffer set for plane; no error */
+
+	if (dev->mode_config.preferred_depth = (fb->format->cpp[0] * 8))
+		drm_fb_memcpy_dstclip(dst, vaddr, fb, rect);
+
+	else if (fb->format->cpp[0] = 4 &&
+		 dev->mode_config.preferred_depth = 16)
+		drm_fb_xrgb8888_to_rgb565_dstclip(dst, fb->pitches[0],
+						  vaddr, fb, rect, false);
+
+	else if (fb->format->cpp[0] = 4 &&
+		 dev->mode_config.preferred_depth = 24)
+		drm_fb_xrgb8888_to_rgb888_dstclip(dst, fb->pitches[0],
+						  vaddr, fb, rect);
+
+	else {
+		/* TODO: add the missing conversion */
+		DRM_ERROR("fbconv: mismatching pixel formats\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_fbconv_blit_rect);
+
 /**
  * drm_fbconv_simple_display_pipe_enable - default implementation for
  *	struct drm_simple_display_pipe_funcs.enable
@@ -803,6 +1036,100 @@ drm_fbconv_simple_display_pipe_check(struct drm_simple_display_pipe *pipe,
 				     struct drm_plane_state *plane_state,
 				     struct drm_crtc_state *crtc_state)
 {
+	struct drm_fbconv_modeset *modeset;
+	struct fb_videomode fb_mode, fb_var_mode;
+	int ret;
+	struct fb_var_screeninfo fb_var;
+
+	/*
+	 * CRTC check
+	 */
+
+	modeset = drm_fbconv_modeset_of_pipe(pipe);
+
+	/* DRM porting notes: when fbcon takes over the console, it regularly
+	 * changes the display mode. Where's apparently no way to detect this
+	 * directly from fbcon itself. DRM's mode information might therefore
+	 * be out of data, after it takes over the display at a later time.
+	 * Here, we test the CRTC's current mode with the fbdev state. If they
+	 * do not match, we request a mode change from DRM. If you port an
+	 * fbdev driver to DRM, you can remove this code section, DRM will
+	 * be in full control of the display device and doesn't have to react
+	 * to changes from external sources.
+	 */
+
+	if (!crtc_state->mode_changed && crtc_state->adjusted_mode.clock) {
+		drm_fbconv_init_fb_videomode_from_mode(
+			&fb_mode, &crtc_state->adjusted_mode);
+		fb_var_to_videomode(&fb_var_mode, &modeset->fb_info->var);
+		if (!fb_mode_is_equal(&fb_mode, &fb_var_mode))
+			crtc_state->mode_changed = true;
+	}
+
+	/* TODO: The vblank interrupt is currently not supported. We set
+	 * the corresponding flag as a workaround. Some fbdev drivers
+	 * support FBIO_WAITFORVSYNC, which we might use for querying
+	 * vblanks.
+	 *
+	 * DRM porting notes: if you're porting an fbdev driver to DRM,
+	 * remove this line and instead signal a vblank event from the
+	 * interrupt handler.
+	 */
+	crtc_state->no_vblank = true;
+
+	/*
+	 * Plane check
+	 */
+
+	if (!plane_state->crtc)
+		return 0;
+
+	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						  1 << 16, 1 << 16,
+						  false, true);
+	if (ret < 0)
+		return ret;
+
+	if (!plane_state->visible || !plane_state->fb)
+		return 0;
+
+	/* Virtual screen sizes are not supported.
+	 */
+
+	if (drm_rect_width(&plane_state->dst) != plane_state->fb->width ||
+	    drm_rect_height(&plane_state->dst) != plane_state->fb->height) {
+		DRM_ERROR("fbconv: virtual screen sizes not supported\n");
+		return -EINVAL;
+	}
+	if (plane_state->dst.x1 || plane_state->dst.y1) {
+		DRM_ERROR("fbconv: virtual screen offset not supported\n");
+		return -EINVAL;
+	}
+
+	/* Pixel formats have to be compatible with fbdev. This is
+	 * usually some variation of XRGB.
+	 */
+
+	if (!pipe->plane.state ||
+	    !pipe->plane.state->fb ||
+	    pipe->plane.state->fb->format[0].format !+		plane_state->fb->format[0].format) {
+
+		if (modeset->fb_info->fbops->fb_check_var) {
+			memcpy(&fb_var, &modeset->fb_info->var,
+			       sizeof(fb_var));
+			drm_fbconv_update_fb_var_screeninfo_from_crtc_state(
+				&fb_var, crtc_state);
+			drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
+				&fb_var, plane_state->fb,
+				modeset->fb_info->fix.smem_len);
+			ret = modeset->fb_info->fbops->fb_check_var(
+				&fb_var, modeset->fb_info);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_check);
@@ -816,7 +1143,119 @@ EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_check);
 void
 drm_fbconv_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 				      struct drm_plane_state *old_plane_state)
-{ }
+{
+	struct drm_fbconv_modeset *modeset;
+	uint32_t format;
+	struct fb_var_screeninfo fb_var;
+	int ret;
+	bool do_blit;
+	struct drm_rect rect;
+	struct drm_crtc *crtc = &pipe->crtc;
+
+	/*
+	 * Plane update
+	 */
+
+	modeset = drm_fbconv_modeset_of_pipe(pipe);
+
+	format = drm_fbconv_format_of_fb_info(modeset->fb_info);
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
+	if (!pipe->plane.state->fb) {
+		/* No framebuffer installed; blank display. */
+		fb_blank(modeset->fb_info, FB_BLANK_NORMAL);
+		return;
+	}
+
+	if ((format != pipe->plane.state->fb->format[0].format) ||
+	    (modeset->fb_info->var.xres_virtual !+	    pipe->plane.state->fb->width)) {
+
+		/* Pixel format changed, update fb_info accordingly
+		 */
+
+		memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var));
+		ret = drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
+			&fb_var, pipe->plane.state->fb,
+			modeset->fb_info->fix.smem_len);
+		if (ret)
+			return;
+
+		fb_var.activate = FB_ACTIVATE_NOW;
+
+		ret = fb_set_var(modeset->fb_info, &fb_var);
+		if (ret) {
+			DRM_ERROR("fbconv: fb_set_var() failed: %d\n", ret);
+			return;
+		}
+	}
+
+	if (!old_plane_state->fb || /* first-time update */
+	    (format != pipe->plane.state->fb->format[0].format)) {
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
+	memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var));
+	fb_var.xoffset = 0;
+	fb_var.yoffset = 0;
+
+	ret = fb_pan_display(modeset->fb_info, &fb_var);
+	if (ret) {
+		DRM_ERROR("fbconv: fb_pan_display() failed: %d\n", ret);
+		return;
+	}
+
+	do_blit = drm_atomic_helper_damage_merged(old_plane_state,
+						  pipe->plane.state,
+						  &rect);
+	if (do_blit)
+		drm_fbconv_blit_rect(modeset->blit.screen_base,
+				     modeset->blit.vmap, pipe->plane.state->fb,
+				     &rect);
+
+	if (crtc->state->event) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		crtc->state->event = NULL;
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
+}
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_update);
 
 /**
@@ -837,7 +1276,48 @@ EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_update);
 int
 drm_fbconv_simple_display_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
 					  struct drm_plane_state *plane_state)
-{ }
+{
+	struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
+	struct fb_info *fb_info = modeset->fb_info;
+	struct drm_framebuffer *fb = plane_state->fb;
+	bool unmap_screen_base = false;
+	void *screen_base;
+	void *vmap;
+	int ret;
+
+	if (!fb)
+		return 0;
+
+	screen_base = fb_info->screen_base;
+
+	if (!screen_base) {
+		screen_base = ioremap(fb_info->fix.smem_start,
+				      fb_info->fix.smem_len);
+		if (!screen_base) {
+			DRM_ERROR("fbconv: ioremap() failed\n");
+			return -ENOMEM;
+		}
+		unmap_screen_base = true;
+	}
+
+	vmap = drm_gem_shmem_vmap(fb->obj[0]);
+	if (!vmap) {
+		DRM_ERROR("fbconv: drm_gem_shmem_vmap() failed\n");
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	modeset->blit.vmap = vmap;
+	modeset->blit.screen_base = screen_base;
+	modeset->blit.unmap_screen_base = unmap_screen_base;
+
+	return 0;
+
+err_iounmap:
+	if (unmap_screen_base)
+		iounmap(screen_base);
+	return ret;
+}
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_prepare_fb);
 
 /**
@@ -853,7 +1333,21 @@ EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_prepare_fb);
 void
 drm_fbconv_simple_display_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
 					  struct drm_plane_state *plane_state)
-{ }
+{
+	struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
+	struct drm_framebuffer *fb = plane_state->fb;
+
+	if (!fb)
+		return;
+
+	drm_gem_shmem_vunmap(fb->obj[0], modeset->blit.vmap);
+
+	if (modeset->blit.unmap_screen_base)
+		iounmap(modeset->blit.screen_base);
+
+	memset(&modeset->blit, 0, sizeof(modeset->blit));
+}
+EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_cleanup_fb);
 
 static const struct drm_simple_display_pipe_funcs simple_display_pipe_funcs = {
 	.mode_valid = drm_fbconv_simple_display_pipe_mode_valid,
diff --git a/include/drm/drm_fbconv_helper.h b/include/drm/drm_fbconv_helper.h
index 79716af687c1..3e62b5e80af6 100644
--- a/include/drm/drm_fbconv_helper.h
+++ b/include/drm/drm_fbconv_helper.h
@@ -92,6 +92,9 @@ void
 drm_fbconv_simple_display_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
 					  struct drm_plane_state *plane_state);
 
+int drm_fbconv_blit_rect(void *dst, void *vaddr, struct drm_framebuffer *fb,
+			 struct drm_rect *rect);
+
 /*
  * Modeset helpers
  */
@@ -107,6 +110,12 @@ struct drm_fbconv_modeset {
 	struct drm_connector connector;
 	struct drm_simple_display_pipe pipe;
 
+	struct {
+		void *vmap;
+		void *screen_base;
+		bool unmap_screen_base;
+	} blit;
+
 	struct drm_device *dev;
 	struct fb_info *fb_info;
 };
-- 
2.23.0
