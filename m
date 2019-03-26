From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:41 +0000
Subject: [PATCH 08/11] drm/fbdevdrm: Add mode conversion DRM <-> fbdev
Message-Id: <20190326091744.11542-9-tzimmermann@suse.de>
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
 drivers/gpu/drm/fbdevdrm/Makefile         |   1 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c | 153 ++++++++++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h |  46 +++++++
 3 files changed, 200 insertions(+)
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h

diff --git a/drivers/gpu/drm/fbdevdrm/Makefile b/drivers/gpu/drm/fbdevdrm/Makefile
index aef60d0f4888..2ca906a3258b 100644
--- a/drivers/gpu/drm/fbdevdrm/Makefile
+++ b/drivers/gpu/drm/fbdevdrm/Makefile
@@ -3,6 +3,7 @@ fbdevdrm-y := fbdevdrm_bo.o \
 	      fbdevdrm_device.o \
 	      fbdevdrm_drv.o \
 	      fbdevdrm_format.o \
+	      fbdevdrm_modes.o \
 	      fbdevdrm_modeset.o \
 	      fbdevdrm_ttm.o
 
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
new file mode 100644
index 000000000000..bd3ad691e7ce
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
@@ -0,0 +1,153 @@
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
+#include "fbdevdrm_modes.h"
+#include <drm/drm_modes.h>
+#include <linux/fb.h>
+
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
+
+void drm_mode_update_from_fb_var_screeninfo(
+	struct drm_display_mode *mode, const struct fb_var_screeninfo *fb_var)
+{
+	struct fb_videomode fb_mode;
+
+	fb_var_to_videomode(&fb_mode, fb_var);
+	drm_mode_update_from_fb_videomode(mode, &fb_mode);
+}
+
+struct drm_display_mode* drm_mode_create_from_fb_videomode(
+	struct drm_device *dev, const struct fb_videomode *fb_mode)
+{
+	/* cleared to '0' */
+	struct drm_display_mode *mode = drm_mode_create(dev);
+	if (!mode)
+		return NULL;
+
+	drm_mode_update_from_fb_videomode(mode, fb_mode);
+
+	return mode;
+}
+
+void
+fbdevdrm_update_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+				       const struct drm_display_mode *mode)
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
+
+void
+fbdevdrm_init_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+				     const struct drm_display_mode *mode)
+{
+	memset(fb_mode, 0, sizeof(*fb_mode));
+	fbdevdrm_update_fb_videomode_from_mode(fb_mode, mode);
+}
+
+void
+fbdevdrm_update_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *fb_var,
+					    const struct drm_display_mode *mode)
+{
+	struct fb_videomode fb_mode;
+	fbdevdrm_init_fb_videomode_from_mode(&fb_mode, mode);
+	fb_videomode_to_var(fb_var, &fb_mode);
+
+	fb_var->height = mode->height_mm;
+	fb_var->width = mode->width_mm;
+}
+
+void
+fbdevdrm_init_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *fb_var,
+					  const struct drm_display_mode *mode)
+{
+	memset(fb_var, 0, sizeof(*fb_var));
+	fbdevdrm_update_fb_var_screeninfo_from_mode(fb_var, mode);
+}
diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
new file mode 100644
index 000000000000..f88a86a83858
--- /dev/null
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
@@ -0,0 +1,46 @@
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
+#ifndef FBDEVDRM_MODES_H
+#define FBDEVDRM_MODES_H
+
+struct drm_device;
+struct drm_display_mode;
+struct fb_videomode;
+struct fb_var_screeninfo;
+
+void drm_mode_update_from_fb_videomode(struct drm_display_mode *mode,
+				       const struct fb_videomode *fb_mode);
+
+void drm_mode_update_from_fb_var_screeninfo(
+	struct drm_display_mode *mode, const struct fb_var_screeninfo *fb_var);
+
+struct drm_display_mode* drm_mode_create_from_fb_videomode(
+	struct drm_device *dev, const struct fb_videomode *fb_mode);
+
+void
+fbdevdrm_update_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+				       const struct drm_display_mode *mode);
+
+void
+fbdevdrm_init_fb_videomode_from_mode(struct fb_videomode *fb_mode,
+				     const struct drm_display_mode *mode);
+
+void
+fbdevdrm_update_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *var,
+					    const struct drm_display_mode *mode);
+
+void
+fbdevdrm_init_fb_var_screeninfo_from_mode(struct fb_var_screeninfo *var,
+					  const struct drm_display_mode *mode);
+
+#endif
-- 
2.21.0
