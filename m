From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:43 +0000
Subject: [PATCH 10/11] drm/fbdevdrm: Add CRTC
Message-Id: <20190326091744.11542-11-tzimmermann@suse.de>
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
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 150 +++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
index 3473b85acbf1..87f56ec76edf 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
@@ -18,10 +18,18 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/fb.h>
+#include "fbdevdrm_modes.h"
 #include "fbdevdrm_primary.h"
 
+static struct fbdevdrm_modeset* fbdevdrm_modeset_of_crtc(
+	struct drm_crtc *crtc)
+{
+	return container_of(crtc, struct fbdevdrm_modeset, crtc);
+}
+
 /*
  * CRTC
  */
@@ -29,18 +37,124 @@
 static enum drm_mode_status crtc_helper_mode_valid(
 	struct drm_crtc *crtc, const struct drm_display_mode *mode)
 {
+	static const unsigned char bits_per_pixel[] = {
+		32, 16, 8, 24, 15
+	};
+
+	struct fbdevdrm_modeset *modeset;
+	struct fb_var_screeninfo fb_var;
+	size_t i;
+	int ret;
+
+	modeset = fbdevdrm_modeset_of_crtc(crtc);
+
+	if (!modeset->fb_info->fbops->fb_check_var)
+		return MODE_OK;
+
+	for (i = 0; i < ARRAY_SIZE(bits_per_pixel); ++i) {
+
+		memcpy(&fb_var, &modeset->fb_info->var, sizeof(fb_var));
+		fbdevdrm_update_fb_var_screeninfo_from_mode(&fb_var, mode);
+		fb_var.bits_per_pixel = bits_per_pixel[i];
+
+		ret = modeset->fb_info->fbops->fb_check_var(&fb_var, modeset->fb_info);
+		if (ret)
+			continue; /* generally not supported */
+		if ((mode->hdisplay != fb_var.xres) ||
+		    (mode->vdisplay != fb_var.yres))
+			continue; /* unsupported resolution */
+		if (KHZ2PICOS(mode->clock) != fb_var.pixclock)
+			continue; /* unsupported pixel clock */
+
+		break; /* mode successfully tested */
+	}
+	if (i = ARRAY_SIZE(bits_per_pixel))
+		return MODE_BAD; /* mode is not support */
+
 	return MODE_OK;
 }
 
+static int fbdevdrm_update_fb_var_screeninfo_from_crtc(
+	struct fb_var_screeninfo *fb_var, struct drm_crtc* crtc)
+{
+	struct drm_plane *primary = crtc->primary;
+	struct fbdevdrm_modeset *modeset = fbdevdrm_modeset_of_crtc(crtc);
+
+	if (primary && primary->state && primary->state->fb)
+		return fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
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
 static bool crtc_helper_mode_fixup(struct drm_crtc *crtc,
 				   const struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
 {
+	struct fbdevdrm_modeset *modeset;
+	struct fb_var_screeninfo fb_var;
+	int ret;
+
+	modeset = fbdevdrm_modeset_of_crtc(crtc);
+
+	if (!modeset->fb_info->fbops->fb_check_var)
+		return true;
+
+	fbdevdrm_init_fb_var_screeninfo_from_mode(&fb_var, mode);
+
+	ret = fbdevdrm_update_fb_var_screeninfo_from_crtc(&fb_var, crtc);
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
 
 static void crtc_helper_mode_set_nofb(struct drm_crtc *crtc)
-{ }
+{
+	struct fbdevdrm_modeset *modeset;
+	struct fb_var_screeninfo fb_var;
+	int ret;
+
+	/* As this is atomic mode setting, any function call is not
+	 * allowed to fail. If it does, an additional test should be
+	 * added to crtc_helper_atomic_check().
+	 */
+
+	modeset = fbdevdrm_modeset_of_crtc(crtc);
+
+	memset(&fb_var, 0, sizeof(fb_var));
+	fbdevdrm_update_fb_var_screeninfo_from_mode(&fb_var, &crtc->state->adjusted_mode);
+
+	if (crtc->primary && crtc->primary->state && crtc->primary->state->fb) {
+		ret = fbdevdrm_update_fb_var_screeninfo_from_framebuffer(
+			&fb_var, crtc->primary->state->fb,
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
+		DRM_ERROR("fbdevdrm: fb_set_var() failed: %d\n", ret);
+		return;
+	}
+}
 
 static int crtc_helper_mode_set_base_atomic(struct drm_crtc *crtc,
 					    struct drm_framebuffer *fb,
@@ -53,6 +167,40 @@ static int crtc_helper_mode_set_base_atomic(struct drm_crtc *crtc,
 static int crtc_helper_atomic_check(struct drm_crtc *crtc,
 				    struct drm_crtc_state *state)
 {
+	struct fbdevdrm_modeset *modeset;
+	struct fb_videomode fb_mode, fb_var_mode;
+
+	modeset = fbdevdrm_modeset_of_crtc(crtc);
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
+	if (!state->mode_changed && state->adjusted_mode.clock) {
+		fbdevdrm_init_fb_videomode_from_mode(&fb_mode, &state->adjusted_mode);
+		fb_var_to_videomode(&fb_var_mode, &modeset->fb_info->var);
+		if (!fb_mode_is_equal(&fb_mode, &fb_var_mode))
+			state->mode_changed = true;
+	}
+
+	/* TODO: The vblank interupt is currently not supported. We set
+	 * the corresponding flag as a workaround. Some fbdev drivers
+	 * support FBIO_WAITFORVSYNC, which we might use for querying
+	 * vblanks.
+	 *
+	 * DRM porting notes: if you're porting an fbdev driver to DRM,
+	 * remove this line and instead signal a vblank event from the
+	 * interupt handler.
+	 */
+	state->no_vblank = true;
+
 	return 0;
 }
 
-- 
2.21.0
