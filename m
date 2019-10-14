From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:11 +0000
Subject: [PATCH v2 10/15] drm/fbconv: Reimplement several fbdev interfaces
Message-Id: <20191014140416.28517-11-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

This patch reimplements fb_blank(), fb_pan_display(), fb_set_cmap() and
fb_set_var() for fbconv helpers. The goal is to have all calls to driver
callback functions located within fbconv and to reduce the amount of
contained work to a minimum.

Some noteable differences to fbdev include:

  * Code related to fbcon has been left out. Console support is
    emulated by DRM and the drivers don't interact directly with
    it.

  * No events are sent out. As the fbconv helpers are not part of
    the fbdev framework, there are no event listeners anyway.

  * Code related to ioctl and user-space has been left out as
    well. User-space interfaces are provided by DRM.

  * Error messages have been added.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbconv_helper.c | 240 +++++++++++++++++++++++++---
 1 file changed, 220 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index ca8b43c91266..f7f247e30a3d 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -737,6 +737,55 @@ static const struct drm_connector_funcs connector_funcs = {
  * Colormap updates
  */
 
+static int drm_fbconv_set_cmap(struct fb_cmap *cmap, struct fb_info *fb_info)
+{
+	int i, start, res;
+	u16 *red, *green, *blue, *transp;
+	u_int hred, hgreen, hblue, htransp = 0xffff;
+
+	red = cmap->red;
+	green = cmap->green;
+	blue = cmap->blue;
+	transp = cmap->transp;
+	start = cmap->start;
+
+	if (start < 0 || (!fb_info->fbops->fb_setcolreg &&
+			  !fb_info->fbops->fb_setcmap)) {
+		DRM_ERROR("fbconv: Palette not supported.\n");
+		return -EINVAL;
+	}
+
+	if (fb_info->fbops->fb_setcmap) {
+		res = fb_info->fbops->fb_setcmap(cmap, fb_info);
+		if (res) {
+			DRM_ERROR("fbconv: fbops->fb_setcmap() failed: %d\n",
+				  res);
+			return res;
+		}
+	} else {
+		for (i = 0; i < cmap->len; i++) {
+			hred = *red++;
+			hgreen = *green++;
+			hblue = *blue++;
+			if (transp)
+				htransp = *transp++;
+			res = fb_info->fbops->fb_setcolreg(start++,
+							   hred, hgreen, hblue,
+							   htransp, fb_info);
+			if (res) {
+				DRM_ERROR("fbconv: fbops->fb_setcolreg() failed: %d\n",
+					  res);
+				/* cmap handling is a mess; don't err here */
+				break;
+			}
+		}
+	}
+
+	fb_copy_cmap(cmap, &fb_info->cmap);
+
+	return 0;
+}
+
 /* provides a default colormap for palette modes */
 static int create_palette_cmap(struct fb_cmap *cmap,
 			       const struct fb_var_screeninfo *fb_var)
@@ -856,11 +905,9 @@ static int set_cmap(struct fb_info *fb_info)
 	if (ret)
 		return ret;
 
-	ret = fb_set_cmap(&cmap, fb_info);
-	if (ret) {
-		DRM_ERROR("fbconv: fb_set_cmap() failed: %d\n", ret);
+	ret = drm_fbconv_set_cmap(&cmap, fb_info);
+	if (ret)
 		goto err_fb_dealloc_cmap;
-	}
 	fb_dealloc_cmap(&cmap);
 
 	return 0;
@@ -891,7 +938,7 @@ static int drm_fbconv_update_fb_var_screeninfo_from_framebuffer(
 
 	/* Our virtual screen covers all the graphics memory (sans some
 	 * trailing bytes). This allows for setting the scanout buffer's
-	 * address with fb_pan_display().
+	 * address with drm_fbconv_pan_display().
 	 */
 
 	width = fb->pitches[0];
@@ -937,6 +984,165 @@ static int drm_fbconv_update_fb_var_screeninfo_from_simple_display_pipe(
 	return 0;
 }
 
+static int drm_fbconv_blank(struct fb_info *fb_info, int blank)
+{
+	int ret = -EINVAL;
+
+	if (fb_info->fbops->fb_blank) {
+		ret = fb_info->fbops->fb_blank(blank, fb_info);
+		if (ret) {
+			DRM_ERROR("fbconv: fbops->fb_blank() failed: %d\n",
+				  ret);
+		}
+	}
+	return ret;
+}
+
+static int drm_fbconv_pan_display(struct fb_info *fb_info,
+				  struct fb_var_screeninfo *var)
+{
+	struct fb_fix_screeninfo *fix = &fb_info->fix;
+	unsigned int yres = fb_info->var.yres;
+	int err;
+
+	if (var->yoffset > 0) {
+		if (var->vmode & FB_VMODE_YWRAP) {
+			if (!fix->ywrapstep ||
+			    (var->yoffset % fix->ywrapstep)) {
+				DRM_ERROR("fbconv: Invalid fix->ywrapstep: %d\n",
+					  fix->ywrapstep);
+				return -EINVAL;
+			}
+			yres = 0;
+		} else if (!fix->ypanstep || (var->yoffset % fix->ypanstep)) {
+			DRM_ERROR("fbconv: Invalid fix->ypanstep: %d\n",
+				  fix->ypanstep);
+			return -EINVAL;
+		}
+	}
+
+	if (var->xoffset > 0) {
+		if (!fix->xpanstep || (var->xoffset % fix->xpanstep)) {
+			DRM_ERROR("fbconv: Invalid fix->xpanstep: %d\n",
+				  fix->xpanstep);
+			return -EINVAL;
+		}
+	}
+
+	if (!fb_info->fbops->fb_pan_display ||
+	    var->yoffset > fb_info->var.yres_virtual - yres ||
+	    var->xoffset > fb_info->var.xres_virtual - fb_info->var.xres) {
+		DRM_ERROR("fbconv: Display panning unsupported\n");
+		return -EINVAL;
+	}
+
+	err = fb_info->fbops->fb_pan_display(var, fb_info);
+	if (err) {
+		DRM_ERROR("fbconv: fbops->pan_display() failed: %d", err);
+		return err;
+	}
+
+	fb_info->var.xoffset = var->xoffset;
+	fb_info->var.yoffset = var->yoffset;
+
+	if (var->vmode & FB_VMODE_YWRAP)
+		fb_info->var.vmode |= FB_VMODE_YWRAP;
+	else
+		fb_info->var.vmode &= ~FB_VMODE_YWRAP;
+
+	return 0;
+}
+
+static int drm_fbconv_set_var(struct fb_info *fb_info,
+			      struct fb_var_screeninfo *var)
+{
+	int ret = 0;
+	u32 activate;
+	struct fb_var_screeninfo old_var;
+	struct fb_videomode mode;
+
+	if (var->activate & FB_ACTIVATE_INV_MODE) {
+		struct fb_videomode mode1, mode2;
+
+		fb_var_to_videomode(&mode1, var);
+		fb_var_to_videomode(&mode2, &fb_info->var);
+		/* make sure we don't delete the videomode of current var */
+		ret = fb_mode_is_equal(&mode1, &mode2);
+		if (ret) {
+			DRM_ERROR("fbconv: fb_mode_is_equal() failed: %d\n",
+				  ret);
+			return -EINVAL;
+		}
+
+		fb_delete_videomode(&mode1, &fb_info->modelist);
+
+		return 0;
+	}
+
+	if (!(var->activate & FB_ACTIVATE_FORCE) &&
+	    !memcmp(&fb_info->var, var, sizeof(*var)))
+		return 0;
+
+	activate = var->activate;
+
+	/* When using FOURCC mode, make sure the red, green, blue and
+	 * transp fields are set to 0.
+	 */
+	if ((fb_info->fix.capabilities & FB_CAP_FOURCC) && var->grayscale > 1) {
+		if (var->red.offset     || var->green.offset    ||
+		    var->blue.offset    || var->transp.offset   ||
+		    var->red.length     || var->green.length    ||
+		    var->blue.length    || var->transp.length   ||
+		    var->red.msb_right  || var->green.msb_right ||
+		    var->blue.msb_right || var->transp.msb_right) {
+			DRM_ERROR("fbconv: Invalid color offsets in FOURCC mode\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!fb_info->fbops->fb_check_var) {
+		*var = fb_info->var;
+		return 0;
+	}
+
+	ret = fb_info->fbops->fb_check_var(var, fb_info);
+	if (ret) {
+		DRM_ERROR("fbconv: fbops->fb_check_var() failed: %d\n", ret);
+		return ret;
+	}
+
+	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
+		return 0;
+
+	old_var = fb_info->var;
+	fb_info->var = *var;
+
+	if (fb_info->fbops->fb_set_par) {
+		ret = fb_info->fbops->fb_set_par(fb_info);
+		if (ret) {
+			fb_info->var = old_var;
+			DRM_ERROR("fbconv: fbops->fb_set_par() failed: %d\n",
+				  ret);
+			return ret;
+		}
+	}
+
+	drm_fbconv_pan_display(fb_info, &fb_info->var);
+	drm_fbconv_set_cmap(&fb_info->cmap, fb_info);
+	fb_var_to_videomode(&mode, &fb_info->var);
+
+	if (fb_info->modelist.prev && fb_info->modelist.next &&
+	    !list_empty(&fb_info->modelist))
+		ret = fb_add_videomode(&mode, &fb_info->modelist);
+
+	if (ret) {
+		DRM_ERROR("fbconv: fb_add_videomode() failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * drm_fbconv_simple_display_pipe_mode_valid - default implementation for
  *	struct drm_simple_display_pipe_funcs.mode_valid
@@ -1105,13 +1311,11 @@ drm_fbconv_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	fb_var.activate = FB_ACTIVATE_NOW;
 
-	ret = fb_set_var(modeset->fb_info, &fb_var);
-	if (ret) {
-		DRM_ERROR("fbconv: fb_set_var() failed: %d\n", ret);
+	ret = drm_fbconv_set_var(modeset->fb_info, &fb_var);
+	if (ret)
 		return;
-	}
 
-	fb_blank(modeset->fb_info, FB_BLANK_UNBLANK);
+	drm_fbconv_blank(modeset->fb_info, FB_BLANK_UNBLANK);
 
 	drm_fbconv_blit_fullscreen(modeset->blit.screen_base,
 				   modeset->blit.vmap,
@@ -1129,7 +1333,7 @@ drm_fbconv_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
 	struct drm_fbconv_modeset *modeset = drm_fbconv_modeset_of_pipe(pipe);
 
-	fb_blank(modeset->fb_info, FB_BLANK_POWERDOWN);
+	drm_fbconv_blank(modeset->fb_info, FB_BLANK_POWERDOWN);
 }
 EXPORT_SYMBOL(drm_fbconv_simple_display_pipe_disable);
 
@@ -1295,7 +1499,7 @@ drm_fbconv_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 
 	if (!pipe->plane.state->fb) {
 		/* No framebuffer installed; blank display. */
-		fb_blank(modeset->fb_info, FB_BLANK_NORMAL);
+		drm_fbconv_blank(modeset->fb_info, FB_BLANK_NORMAL);
 		return;
 	}
 
@@ -1315,11 +1519,9 @@ drm_fbconv_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 
 		fb_var.activate = FB_ACTIVATE_NOW;
 
-		ret = fb_set_var(modeset->fb_info, &fb_var);
-		if (ret) {
-			DRM_ERROR("fbconv: fb_set_var() failed: %d\n", ret);
+		ret = drm_fbconv_set_var(modeset->fb_info, &fb_var);
+		if (ret)
 			return;
-		}
 	}
 
 	if (!old_plane_state->fb || /* first-time update */
@@ -1344,11 +1546,9 @@ drm_fbconv_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 	fb_var.xoffset = 0;
 	fb_var.yoffset = 0;
 
-	ret = fb_pan_display(modeset->fb_info, &fb_var);
-	if (ret) {
-		DRM_ERROR("fbconv: fb_pan_display() failed: %d\n", ret);
+	ret = drm_fbconv_pan_display(modeset->fb_info, &fb_var);
+	if (ret)
 		return;
-	}
 
 	do_blit = drm_atomic_helper_damage_merged(old_plane_state,
 						  pipe->plane.state,
-- 
2.23.0
