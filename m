From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:10 +0000
Subject: [PATCH v2 09/15] drm/fbconv: Mode-setting pipeline enable / disable
Message-Id: <20191014140416.28517-10-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

The display mode is set by converting the DRM display mode to an
fb_info state and handling it to the fbdev driver's fb_setvar()
function. This also requires a color depth, which we take from the
value of struct drm_mode_config.preferred_depth

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbconv_helper.c | 113 +++++++++++++++++++++++++++-
 include/drm/drm_fbconv_helper.h     |   2 +
 2 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index cf218016ac05..ca8b43c91266 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -919,6 +919,24 @@ static int drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
 	return 0;
 }
 
+static int drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
+	struct fb_var_screeninfo *fb_var, struct drm_simple_display_pipe *pipe)
+{
+	struct drm_plane *primary = pipe->crtc.primary;
+	struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
+
+	if (primary && primary->state && primary->state->fb)
+		return drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
+			fb_var, primary->state->fb,
+			modeset->fb_info->fix.smem_len);
+
+	fb_var->xres_virtual = fb_var->xres;
+	fb_var->yres_virtual = fb_var->yres;
+	fb_var->bits_per_pixel = modeset->dev->mode_config.preferred_depth;
+
+	return 0;
+}
+
 /**
  * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
  *	struct drm_simple_display_pipe_funcs.mode_valid
@@ -950,6 +968,28 @@ bool drm_fbconv_simple_display_pipe_mode_fixup(
 	struct drm_crtc *crtc, const struct drm_display_mode *mode,
 	struct drm_display_mode *adjusted_mode)
 {
+	struct drm_simple_display_pipe *pipe +		container_of(crtc, struct drm_simple_display_pipe, crtc);
+	struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
+	struct fb_var_screeninfo fb_var;
+	int ret;
+
+	if (!modeset->fb_info->fbops->fb_check_var)
+		return true;
+
+	drm_fbconv_init_fb_var_screeninfo_from_mode(&fb_var, mode);
+
+	ret = drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
+		&fb_var, &modeset->pipe);
+	if (ret)
+		return true;
+
+	ret = modeset->fb_info->fbops->fb_check_var(&fb_var, modeset->fb_info);
+	if (ret < 0)
+		return false;
+
+	drm_mode_update_from_fb_var_screeninfo(adjusted_mode, &fb_var);
+
 	return true;
 }
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_mode_fixup);
@@ -1000,6 +1040,32 @@ int drm_fbconv_blit_rect(void *dst, void *vaddr, struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(drm_fbconv_blit_rect);
 
+/**
+ * drm_fbconv_blit_fullscreen - copy all pixel data from a framebuffer
+ *	to the hardware buffer
+ * @dst:	the on-screen hardware buffer
+ * @vaddr:	the source buffer in kernel address space
+ * @fb:		the framebuffer of the source buffer
+ * Returns:
+ *	0 on success, or
+ *	a negative error code otherwise.
+ *
+ * This function is equivalent to drm_fbconv_blit_rect(), but copies the
+ * framebuffer's complete content.
+ */
+int drm_fbconv_blit_fullscreen(void *dst, void *vaddr,
+			       struct drm_framebuffer *fb)
+{
+	struct drm_rect fullscreen = {
+		.x1 = 0,
+		.x2 = fb->width,
+		.y1 = 0,
+		.y2 = fb->height,
+	};
+	return drm_fbconv_blit_rect(dst, vaddr, fb, &fullscreen);
+}
+EXPORT_SYMBOL(drm_fbconv_blit_fullscreen);
+
 /**
  * drm_fbconv_simple_display_pipe_enable - default implementation for
  *	struct drm_simple_display_pipe_funcs.enable
@@ -1011,7 +1077,46 @@ void
 drm_fbconv_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 				      struct drm_crtc_state *crtc_state,
 				      struct drm_plane_state *plane_state)
-{ }
+{
+	struct drm_fbconv_modeset *modeset;
+	struct fb_var_screeninfo fb_var;
+	int ret;
+
+	/* As this is atomic mode setting, any function call is not
+	 * allowed to fail. If it does, an additional test should be
+	 * added to simple_display_pipe_check().
+	 */
+
+	modeset = drm_fbconv_modeset_of_pipe(pipe);
+
+	drm_fbconv_init_fb_var_screeninfo_from_mode(
+		&fb_var, &crtc_state->adjusted_mode);
+
+	if (plane_state && plane_state->fb) {
+		ret = drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
+			&fb_var, plane_state->fb,
+			modeset->fb_info->fix.smem_len);
+		if (ret)
+			return;
+	} else {
+		fb_var.xres_virtual = fb_var.xres;
+		fb_var.yres_virtual = fb_var.yres;
+	}
+
+	fb_var.activate = FB_ACTIVATE_NOW;
+
+	ret = fb_set_var(modeset->fb_info, &fb_var);
+	if (ret) {
+		DRM_ERROR("fbconv: fb_set_var() failed: %d\n", ret);
+		return;
+	}
+
+	fb_blank(modeset->fb_info, FB_BLANK_UNBLANK);
+
+	drm_fbconv_blit_fullscreen(modeset->blit.screen_base,
+				   modeset->blit.vmap,
+				   plane_state->fb);
+}
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_enable);
 
 /**
@@ -1021,7 +1126,11 @@ EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_enable);
  */
 void
 drm_fbconv_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
-{ }
+{
+	struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
+
+	fb_blank(modeset->fb_info, FB_BLANK_POWERDOWN);
+}
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_disable);
 
 /**
diff --git a/include/drm/drm_fbconv_helper.h b/include/drm/drm_fbconv_helper.h
index 3e62b5e80af6..c7d211f40462 100644
--- a/include/drm/drm_fbconv_helper.h
+++ b/include/drm/drm_fbconv_helper.h
@@ -94,6 +94,8 @@ drm_fbconv_simple_display_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
 
 int drm_fbconv_blit_rect(void *dst, void *vaddr, struct drm_framebuffer *fb,
 			 struct drm_rect *rect);
+int drm_fbconv_blit_fullscreen(void *dst, void *vaddr,
+			       struct drm_framebuffer *fb);
 
 /*
  * Modeset helpers
-- 
2.23.0
