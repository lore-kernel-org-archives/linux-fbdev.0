From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:07 +0000
Subject: [PATCH v2 06/15] drm/fbconv: Add mode conversion DRM <-> fbdev
Message-Id: <20191014140416.28517-7-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

DRM uses struct drm_display_mode to describe a display mode. The
conversion functions fill it from fbdev data strucutures, and vice
versa.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbconv_helper.c | 201 ++++++++++++++++++++++++++++
 include/drm/drm_fbconv_helper.h     |  31 +++++
 2 files changed, 232 insertions(+)

diff --git a/drivers/gpu/drm/drm_fbconv_helper.c b/drivers/gpu/drm/drm_fbconv_helper.c
index af45358a156a..e5a58a361ae9 100644
--- a/drivers/gpu/drm/drm_fbconv_helper.c
+++ b/drivers/gpu/drm/drm_fbconv_helper.c
@@ -5,6 +5,7 @@
 #include <linux/fb.h>
 
 #include <drm/drm_fbconv_helper.h>
+#include <drm/drm_modes.h>
 
 /*
  * Format conversion helpers
@@ -434,3 +435,203 @@ int drm_fbconv_update_fb_var_screeninfo_from_format(
 	return 0;
 }
 EXPORT_SYMBOL(drm_fbconv_update_fb_var_screeninfo_from_format);
+
+/*
+ * Mode conversion helpers
+ */
+
+/**
+ * drm_mode_update_from_fb_videomode - Sets a drm_display mode struecture
+ *	from an fb_videomode structure
+ * @mode:	the DRM display mode structure to update
+ * @fb_mode:	an fb_videomode structure
+ */
+void drm_mode_update_from_fb_videomode(struct drm_display_mode *mode,
+				       const struct fb_videomode *fb_mode)
+{
+	mode->type = DRM_MODE_TYPE_DRIVER;
+
+	mode->clock = PICOS2KHZ(fb_mode->pixclock);
+
+	mode->hdisplay = fb_mode->xres;
+	mode->hsync_start = mode->hdisplay + fb_mode->right_margin;
+	mode->hsync_end = mode->hsync_start + fb_mode->hsync_len;
+	mode->htotal = mode->hsync_end + fb_mode->left_margin;
+	mode->hskew = 0;
+
+	mode->vdisplay = fb_mode->yres;
+	mode->vsync_start = mode->vdisplay + fb_mode->lower_margin;
+	mode->vsync_end = mode->vsync_start + fb_mode->vsync_len;
+	mode->vtotal = mode->vsync_end + fb_mode->upper_margin;
+	mode->vscan = 0;
+
+	mode->flags = 0;
+
+	if (fb_mode->sync & FB_SYNC_HOR_HIGH_ACT)
+		mode->flags |= DRM_MODE_FLAG_PHSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_NHSYNC;
+
+	if (fb_mode->sync & FB_SYNC_VERT_HIGH_ACT)
+		mode->flags |= DRM_MODE_FLAG_PVSYNC;
+	else
+		mode->flags |= DRM_MODE_FLAG_NVSYNC;
+
+	if (fb_mode->sync & FB_SYNC_COMP_HIGH_ACT)
+		mode->flags |= DRM_MODE_FLAG_CSYNC | DRM_MODE_FLAG_PCSYNC;
+
+	if (fb_mode->vmode & FB_VMODE_INTERLACED)
+		mode->flags |= DRM_MODE_FLAG_INTERLACE;
+
+	if (fb_mode->vmode & FB_VMODE_DOUBLE)
+		mode->flags |= DRM_MODE_FLAG_DBLSCAN;
+
+	mode->width_mm = 0;
+	mode->height_mm = 0;
+
+	mode->vrefresh = fb_mode->refresh;
+	mode->hsync = mode->clock / mode->vtotal;
+
+	/* final step; depends on previous setup */
+	if (fb_mode->name) {
+		strncpy(mode->name, fb_mode->name, sizeof(mode->name) - 1);
+		mode->name[sizeof(mode->name) - 1] = '\0';
+	} else {
+		drm_mode_set_name(mode);
+	}
+}
+EXPORT_SYMBOL(drm_mode_update_from_fb_videomode);
+
+/**
+ * drm_mode_update_from_fb_var_screeninfo - Sets a drm_display mode structure
+ *	from an fb_var_screenmode structure
+ * @mode:	the DRM display mode structure to update
+ * @fb_var:	an fb_var_screeninfo structure
+ */
+void drm_mode_update_from_fb_var_screeninfo(
+	struct drm_display_mode *mode, const struct fb_var_screeninfo *fb_var)
+{
+	struct fb_videomode fb_mode;
+
+	fb_var_to_videomode(&fb_mode, fb_var);
+	drm_mode_update_from_fb_videomode(mode, &fb_mode);
+}
+EXPORT_SYMBOL(drm_mode_update_from_fb_var_screeninfo);
+
+/**
+ * drm_mode_create_from_fb_videomode - Creates a drm_display mode structure
+ *	from an fb_videomode structure
+ * @dev:	the new mode's DRM device
+ * @fb_mode:	an fb_videomode structure
+ * Returns:
+ *	A newly allocated DRM display mode structure on success, or
+ *	NULL otherwise
+ */
+struct drm_display_mode * drm_mode_create_from_fb_videomode(
+	struct drm_device *dev, const struct fb_videomode *fb_mode)
+{
+	/* cleared to '0' */
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_create(dev);
+	if (!mode)
+		return NULL;
+
+	drm_mode_update_from_fb_videomode(mode, fb_mode);
+
+	return mode;
+}
+EXPORT_SYMBOL(drm_mode_create_from_fb_videomode);
+
+/**
+ * drm_fbconv_update_fb_videomode_from_mode - updates an fb_videomode
+ *	structure from a DRM display mode
+ * @fb_mode:	the fb_videomode structure to update
+ * @mode:	a DRM display mode
+ */
+void
+drm_fbconv_update_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+					 const struct drm_display_mode *mode)
+{
+	fb_mode->name = NULL;
+	fb_mode->refresh = mode->vrefresh;
+	fb_mode->xres = mode->hdisplay;
+	fb_mode->yres = mode->vdisplay;
+	fb_mode->pixclock = KHZ2PICOS(mode->clock);
+	fb_mode->left_margin = mode->htotal - mode->hsync_end;
+	fb_mode->right_margin = mode->hsync_start - mode->hdisplay;
+	fb_mode->upper_margin = mode->vtotal - mode->vsync_end;
+	fb_mode->lower_margin = mode->vsync_start - mode->vdisplay;
+	fb_mode->hsync_len = mode->hsync_end - mode->hsync_start;
+	fb_mode->vsync_len = mode->vsync_end - mode->vsync_start;
+
+	fb_mode->sync = 0;
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		fb_mode->sync |= FB_SYNC_HOR_HIGH_ACT;
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		fb_mode->sync |= FB_SYNC_VERT_HIGH_ACT;
+	if (mode->flags & (DRM_MODE_FLAG_CSYNC | DRM_MODE_FLAG_PCSYNC))
+		fb_mode->sync |= FB_SYNC_COMP_HIGH_ACT;
+
+	fb_mode->vmode = 0;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		fb_mode->vmode |= FB_VMODE_INTERLACED;
+	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
+		fb_mode->vmode |= FB_VMODE_DOUBLE;
+
+	fb_mode->flag = 0;
+}
+EXPORT_SYMBOL(drm_fbconv_update_fb_videomode_from_mode);
+
+/**
+ * drm_fbconv_init_fb_videomode_from_mode - initializes an fb_videomode
+ *	structure from a DRM display mode
+ * @fb_mode:	the fb_videomode structure to update
+ * @mode:	a DRM display mode
+ *
+ * This is the same as drm_fbconv_update_fb_videomode_from_mode(), but
+ * first clears the fb_screeninfo structure to 0.
+ */
+void drm_fbconv_init_fb_videomode_from_mode(
+	struct fb_videomode *fb_mode, const struct drm_display_mode *mode)
+{
+	memset(fb_mode, 0, sizeof(*fb_mode));
+	drm_fbconv_update_fb_videomode_from_mode(fb_mode, mode);
+}
+EXPORT_SYMBOL(drm_fbconv_init_fb_videomode_from_mode);
+
+/**
+ * drm_fbconv_update_fb_var_screeninfo_from_mode - updates an
+ *	fb_var_screeninfo structure from a DRM display mode
+ * @fb_var:	the fb_var_screeninfo structure to update
+ * @mode:	a DRM display mode
+ */
+void drm_fbconv_update_fb_var_screeninfo_from_mode(
+	struct fb_var_screeninfo *fb_var, const struct drm_display_mode *mode)
+{
+	struct fb_videomode fb_mode;
+
+	drm_fbconv_init_fb_videomode_from_mode(&fb_mode, mode);
+	fb_videomode_to_var(fb_var, &fb_mode);
+
+	fb_var->height = mode->height_mm;
+	fb_var->width = mode->width_mm;
+}
+EXPORT_SYMBOL(drm_fbconv_update_fb_var_screeninfo_from_mode);
+
+/**
+ * drm_fbconv_init_fb_var_screeninfo_from_mode - initialize an
+ *	fb_var_screeninfo structure from a DRM display mode
+ * @fb_var:	the fb_var_screeninfo structure to update
+ * @mode:	a DRM display mode
+ *
+ * This is the same as drm_fbconv_update_fb_var_screeninfo_from_mode(), but
+ * first clears the fb_screeninfo structure to 0.
+ */
+void drm_fbconv_init_fb_var_screeninfo_from_mode(
+	struct fb_var_screeninfo *fb_var, const struct drm_display_mode *mode)
+{
+	memset(fb_var, 0, sizeof(*fb_var));
+	drm_fbconv_update_fb_var_screeninfo_from_mode(fb_var, mode);
+}
+EXPORT_SYMBOL(drm_fbconv_init_fb_var_screeninfo_from_mode);
diff --git a/include/drm/drm_fbconv_helper.h b/include/drm/drm_fbconv_helper.h
index 6b2ed12b579a..cbb13228c76c 100644
--- a/include/drm/drm_fbconv_helper.h
+++ b/include/drm/drm_fbconv_helper.h
@@ -5,8 +5,12 @@
 
 #include <drm/drm_fourcc.h>
 
+struct drm_device;
+struct drm_display_mode;
 struct fb_info;
 struct fb_var_screeninfo;
+struct fb_var_screeninfo;
+struct fb_videomode;
 
 /*
  * Format conversion helpers
@@ -20,4 +24,31 @@ uint32_t drm_fbconv_format_of_fb_info(const struct fb_info *fb_info);
 int drm_fbconv_update_fb_var_screeninfo_from_format(
 	struct fb_var_screeninfo *fb_var, uint32_t format);
 
+/*
+ * Mode conversion helpers
+ */
+
+void drm_mode_update_from_fb_videomode(struct drm_display_mode *mode,
+				       const struct fb_videomode *fb_mode);
+
+void drm_mode_update_from_fb_var_screeninfo(
+	struct drm_display_mode *mode, const struct fb_var_screeninfo *fb_var);
+
+struct drm_display_mode * drm_mode_create_from_fb_videomode(
+	struct drm_device *dev, const struct fb_videomode *fb_mode);
+
+void
+drm_fbconv_update_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+					 const struct drm_display_mode *mode);
+
+void
+drm_fbconv_init_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+				       const struct drm_display_mode *mode);
+
+void drm_fbconv_update_fb_var_screeninfo_from_mode(
+	struct fb_var_screeninfo *var, const struct drm_display_mode *mode);
+
+void drm_fbconv_init_fb_var_screeninfo_from_mode(
+	struct fb_var_screeninfo *var, const struct drm_display_mode *mode);
+
 #endif
-- 
2.23.0
