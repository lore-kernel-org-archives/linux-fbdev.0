From: James Simmons <jsimmons@infradead.org>
Date: Sun, 14 Mar 2010 00:52:04 +0000
Subject: [PATCH v2] drm modes to fbdev mode patch
Message-Id: <alpine.LFD.2.00.1003140047140.23796@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003131440230.12031@casper.infradead.org>
	<20100313153147.GD4536@sci.fi>
In-Reply-To: <20100313153147.GD4536@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>


Here is the second version of the patch. It address the issues you brought 
up. 

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 5054970..0c8c756 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -581,6 +581,101 @@ int drm_fb_helper_setcolreg(unsigned regno,
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
+
+	/* Doing a var to fb_videomode always create a proper pixclock
+	 * we can trust, but the reverse is not true. So we create
+	 * a proper pixclock from the refresh rate wanted. */
+	fbmode->pixclock = mode->vrefresh * mode->vtotal;
+	fbmode->pixclock *= mode->htotal;
+	fbmode->pixclock /= 1000;
+	fbmode->pixclock = KHZ2PICOS(fbmode->pixclock);
+
+	/* No mapping for sync on green or external sync from drm */
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		fbmode->vmode |= FB_SYNC_HOR_HIGH_ACT;
+
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		fbmode->vmode &= ~FB_SYNC_HOR_HIGH_ACT;
+
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		fbmode->vmode |= FB_SYNC_VERT_HIGH_ACT;
+
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		fbmode->vmode &= ~FB_SYNC_VERT_HIGH_ACT;
+
+	if (mode->flags & (DRM_MODE_FLAG_CSYNC | DRM_MODE_FLAG_PCSYNC |
+			   DRM_MODE_FLAG_NCSYNC))
+		fbmode->vmode |= FB_SYNC_COMP_HIGH_ACT;
+
+	if (mode->flags & DRM_MODE_FLAG_BCAST)
+		fbmode->vmode |= FB_SYNC_BROADCAST;
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		if (!(mode->flags & DRM_MODE_FLAG_DBLSCAN))
+			fbmode->vmode |= FB_VMODE_INTERLACED;
+
+	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
+		if (!(mode->flags & DRM_MODE_FLAG_INTERLACE))
+			fbmode->vmode |= FB_VMODE_INTERLACED;
+}
+EXPORT_SYMBOL(drm_display_mode_to_fbmode);
+
+/* No sync on green or external sync */
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
+	/* No mapping for sync on green or external sync to drm */
+	if (fbmode->vmode & FB_SYNC_HOR_HIGH_ACT)
+		mode->flags |= DRM_MODE_FLAG_PHSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_NHSYNC;
+
+	if (fbmode->vmode & FB_SYNC_VERT_HIGH_ACT)
+		mode->flags |= DRM_MODE_FLAG_PVSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_NVSYNC;
+
+	if (fbmode->vmode & FB_SYNC_COMP_HIGH_ACT)
+		mode->flags |= DRM_MODE_FLAG_CSYNC;
+
+	if (fbmode->vmode & FB_SYNC_BROADCAST)
+		mode->flags |= DRM_MODE_FLAG_BCAST;	
+
+	if ((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_INTERLACED)
+		if (!((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_DOUBLE))
+			mode->flags |= DRM_MODE_FLAG_INTERLACE;
+
+	if ((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_DOUBLE)
+		if (!((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_INTERLACED))
+			mode->flags |= DRM_MODE_FLAG_DBLSCAN;
+
+	drm_mode_set_name(mode);
+}
+EXPORT_SYMBOL(fbmode_to_drm_display_mode);
+
 int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 			    struct fb_info *info)
 {
@@ -762,6 +857,7 @@ int drm_fb_helper_single_fb_probe(struct drm_device *dev,
 	int crtc_count = 0;
 	int ret, i, conn_count = 0;
 	struct fb_info *info;
+	struct fb_videomode fbmode;
 	struct drm_framebuffer *fb;
 	struct drm_mode_set *modeset = NULL;
 	struct drm_fb_helper *fb_helper;
@@ -780,7 +876,7 @@ int drm_fb_helper_single_fb_probe(struct drm_device *dev,
 
 		if (!fb_help_conn)
 			continue;
-		
+
 		cmdline_mode = &fb_help_conn->cmdline_mode;
 
 		if (cmdline_mode->bpp_specified) {
@@ -891,8 +987,11 @@ int drm_fb_helper_single_fb_probe(struct drm_device *dev,
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
