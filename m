From: James Simmons <jsimmons@infradead.org>
Date: Sat, 13 Mar 2010 14:47:52 +0000
Subject: [PATCH] drm modes to fbdev mode patch
Message-Id: <alpine.LFD.2.00.1003131440230.12031@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI development list <dri-devel@lists.sourceforge.net>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>


For the fbdev layer the you have your struct fb_var_screeninfo and also 
struct fb_videomode. The struct fb_videomode was developed for the modes
database we have. Struct fb_var_screeninfo is more than just resolution 
data which is why we create struct fb_videomode. The really nice thing 
is that the conversion from fb_var to fb_videomode always fixes the 
pixclock to the proper values so you don't need the pixclock = 0 work 
around. I tested this patch with the intelfb driver and had no problem.
I have used it in the past with a KMS enabled tdfx drver I wrote. In the 
future this function can be used for fbdev level mode setting. Please try 
it out and i hope it can be merged. Thanks.

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 5054970..467ac68 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -581,6 +581,60 @@ int drm_fb_helper_setcolreg(unsigned regno,
 }
 EXPORT_SYMBOL(drm_fb_helper_setcolreg);
 
+void drm_display_mode_to_fbmode(struct drm_display_mode *mode,
+                                struct fb_videomode *fbmode)
+{
+	fbmode->xres = mode->hdisplay;
+	fbmode->yres = mode->vdisplay;
+	fbmode->right_margin = mode->hsync_start - mode->hdisplay;
+	fbmode->lower_margin = mode->vsync_start - mode->vdisplay;
+	fbmode->hsync_len = mode->hsync_end - mode->hsync_start;
+	fbmode->vsync_len = mode->vsync_end - mode->vsync_start;
+	fbmode->left_margin = mode->htotal - mode->hsync_end;
+	fbmode->upper_margin = mode->vtotal - mode->vsync_end;
+	fbmode->refresh = mode->vrefresh;
+	fbmode->name = mode->name;
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		fbmode->vmode |= FB_VMODE_INTERLACED;
+
+	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
+		fbmode->vmode |= FB_VMODE_DOUBLE;
+
+	/* Doing a var to fb_videomode always create a proper pixclock
+	 * we can trust, but the reverse is not true. So we create
+	 * a proper pixclock from the refresh rate wanted. */
+	fbmode->pixclock = mode->vrefresh * mode->vtotal;
+	fbmode->pixclock *= mode->htotal;
+	fbmode->pixclock /= 1000;
+	fbmode->pixclock = KHZ2PICOS(fbmode->pixclock);
+}
+EXPORT_SYMBOL(drm_display_mode_to_fbmode);
+
+void fbmode_to_drm_display_mode(struct fb_videomode *fbmode,
+                                struct drm_display_mode *mode)
+{
+	mode->hdisplay = fbmode->xres;
+	mode->vdisplay = fbmode->yres;
+	mode->hsync_start = mode->hdisplay + fbmode->right_margin;
+	mode->vsync_start = mode->vdisplay + fbmode->lower_margin;
+	mode->hsync_end = mode->hsync_start + fbmode->hsync_len;
+	mode->vsync_end = mode->vsync_start + fbmode->vsync_len;
+	mode->htotal = mode->hsync_end + fbmode->left_margin;
+	mode->vtotal = mode->vsync_end + fbmode->upper_margin;
+	mode->vrefresh = fbmode->refresh;
+	mode->clock = PICOS2KHZ(fbmode->pixclock);
+
+	if ((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_INTERLACED)
+		mode->flags |= DRM_MODE_FLAG_INTERLACE;
+
+	if ((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_DOUBLE)
+		mode->flags |= DRM_MODE_FLAG_DBLSCAN;
+
+	drm_mode_set_name(mode);
+}
+EXPORT_SYMBOL(fbmode_to_drm_display_mode);
+
 int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 			    struct fb_info *info)
 {
@@ -762,6 +816,7 @@ int drm_fb_helper_single_fb_probe(struct drm_device *dev,
 	int crtc_count = 0;
 	int ret, i, conn_count = 0;
 	struct fb_info *info;
+	struct fb_videomode fbmode;
 	struct drm_framebuffer *fb;
 	struct drm_mode_set *modeset = NULL;
 	struct drm_fb_helper *fb_helper;
@@ -891,8 +946,11 @@ int drm_fb_helper_single_fb_probe(struct drm_device *dev,
 	fb_helper->crtc_count = crtc_count;
 	fb_helper->fb = fb;
 
+	/* Convert from drm mode to fb_var_screeninfo */
+	drm_display_mode_to_fbmode(modeset->mode, &fbmode);
+	fb_videomode_to_var(&info->var, &fbmode);
+
 	if (new_fb) {
-		info->var.pixclock = 0;
 		ret = fb_alloc_cmap(&info->cmap, modeset->crtc->gamma_size, 0);
 		if (ret)
 			return ret;
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 58c892a..29fdb01 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -99,6 +99,10 @@ int drm_fb_helper_setcolreg(unsigned regno,
 			    struct fb_info *info);
 
 void drm_fb_helper_restore(void);
+void drm_display_mode_to_fbmode(struct drm_display_mode *mode,
+				struct fb_videomode *fbmode);
+void fbmode_to_drm_display_mode(struct fb_videomode *fbmode,
+				struct drm_display_mode *mode);
 void drm_fb_helper_fill_var(struct fb_info *info, struct drm_framebuffer *fb,
 			    uint32_t fb_width, uint32_t fb_height);
 void drm_fb_helper_fill_fix(struct fb_info *info, uint32_t pitch,
