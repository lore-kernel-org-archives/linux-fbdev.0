From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:44 +0000
Subject: [PATCH 11/11] drm/fbdevdrm: Detect and validate display modes
Message-Id: <20190326091744.11542-12-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Mode detection currently reports the modes listed in fb_info::modelist.
The list is either build from EDID information or, more often, a list of
previously set modes. A later update to the mode detection could also
take into account the modes in fb_monspecs::modedb or test pre-defined
VESA modes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 163 +++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
index 87f56ec76edf..e89eca4b58df 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
@@ -21,9 +21,16 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/fb.h>
+#include "fbdevdrm_device.h"
 #include "fbdevdrm_modes.h"
 #include "fbdevdrm_primary.h"
 
+static struct fbdevdrm_modeset* fbdevdrm_modeset_of_connector(
+	struct drm_connector *connector)
+{
+	return container_of(connector, struct fbdevdrm_modeset, connector);
+}
+
 static struct fbdevdrm_modeset* fbdevdrm_modeset_of_crtc(
 	struct drm_crtc *crtc)
 {
@@ -353,11 +360,130 @@ static const struct drm_encoder_funcs fbdevdrm_encoder_funcs = {
  * Connector
  */
 
-static int connector_helper_get_modes(struct drm_connector *connector)
+static int update_display_info(struct drm_display_info *info, struct fb_info *fb_info)
+{
+	int num_pixel;
+
+	if (fb_info->fix.type != FB_TYPE_PACKED_PIXELS)
+		return -EINVAL; /* rule out text mode, etc. */
+
+	if (fb_info->fix.id[0]) {
+		strncpy(info->name, fb_info->fix.id, sizeof(info->name) - 1);
+		info->name[sizeof(info->name) - 1] = '\0';
+	} else {
+		memset(info->name, '\0', sizeof(info->name));
+	}
+
+	info->width_mm = fb_info->var.width;
+	info->height_mm = fb_info->var.height;
+	info->pixel_clock = PICOS2KHZ(fb_info->var.pixclock);
+
+	num_pixel = 0;
+	if (fb_info->var.red.length)
+		++num_pixel;
+	if (fb_info->var.green.length)
+		++num_pixel;
+	if (fb_info->var.blue.length)
+		++num_pixel;
+	if (fb_info->var.transp.length)
+		++num_pixel;
+
+	if (num_pixel)
+		info->bpc = fb_info->var.bits_per_pixel;
+	else
+		info->bpc = 0;
+
+	info->subpixel_order = SubPixelUnknown;
+	info->color_formats = DRM_COLOR_FORMAT_RGB444;
+	info->bus_formats = &info->color_formats;
+	info->num_bus_formats = 1;
+	info->bus_flags = 0;
+	info->max_tmds_clock = 0;
+	info->dvi_dual = false;
+	info->has_hdmi_infoframe = false;
+	info->edid_hdmi_dc_modes = 0;
+	info->cea_rev = 0;
+	memset(&info->hdmi, 0, sizeof(info->hdmi));
+	info->non_desktop = 0;
+
+	return 0;
+}
+
+static int drm_mode_probed_add_from_fb_videomode(
+	struct drm_connector *connector, const struct fb_videomode *fb_mode,
+	struct fb_info *fb_info)
 {
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_create_from_fb_videomode(connector->dev, fb_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	mode->width_mm = fb_info->var.width;
+	mode->height_mm = fb_info->var.height;
+
+	drm_mode_probed_add(connector, mode);
+
+	/* update connector properties from display mode */
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		connector->interlace_allowed = true;
+	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
+		connector->doublescan_allowed = true;
+	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
+		connector->stereo_allowed = true;
+
 	return 0;
 }
 
+static int connector_helper_get_modes(struct drm_connector *connector)
+{
+	struct fbdevdrm_modeset *modeset;
+	struct list_head *pos;
+	int ret, num_modes = 0;
+
+	modeset = fbdevdrm_modeset_of_connector(connector);
+
+	ret = update_display_info(&connector->display_info, modeset->fb_info);
+	if (ret)
+		return 0;
+
+	/* update connector properties from video modes */
+	connector->interlace_allowed = 0;
+	connector->doublescan_allowed = 0;
+	connector->stereo_allowed = 0;
+
+	if (!num_modes && modeset->fb_info->mode) {
+		ret = drm_mode_probed_add_from_fb_videomode(
+			connector, modeset->fb_info->mode, modeset->fb_info);
+		if (!ret)
+			++num_modes;
+	}
+
+	if (!num_modes) {
+
+		/* DRM backporting notes: we go through all modes in the
+		 * fb_info's mode list and convert each to a DRM modes. If
+		 * you convert an fbdev driver to DRM, replace this code
+		 * with an actual hardware query. This will usually involve
+		 * reading the monitor EDID via DDC.
+		 */
+
+		list_for_each(pos, &modeset->fb_info->modelist) {
+			const struct fb_modelist *modelist +				container_of(pos, struct fb_modelist, list);
+
+			ret = drm_mode_probed_add_from_fb_videomode(
+				connector,  &modelist->mode,
+				modeset->fb_info);
+			if (ret < 0)
+				continue;
+			++num_modes;
+		}
+	}
+
+	return num_modes;
+}
+
 static int connector_helper_detect_ctx(struct drm_connector *connector,
 				       struct drm_modeset_acquire_ctx *ctx,
 				       bool force)
@@ -368,6 +494,21 @@ static int connector_helper_detect_ctx(struct drm_connector *connector,
 static enum drm_mode_status connector_helper_mode_valid(
 	struct drm_connector *connector, struct drm_display_mode *mode)
 {
+	struct fb_var_screeninfo fb_var;
+	int ret;
+	struct fbdevdrm_modeset *modeset = fbdevdrm_modeset_of_connector(connector);
+
+	/* fb_validate_mode() requires fb_info->monspecs to contain valid
+	 * data. Skip the test if the maximum clock looks bogus. */
+	if (!modeset->fb_info->monspecs.dclkmax)
+		return MODE_OK;
+
+	fbdevdrm_init_fb_var_screeninfo_from_mode(&fb_var, mode);
+
+	ret = fb_validate_mode(&fb_var, modeset->fb_info);
+	if (ret < 0)
+		return MODE_BAD;
+
 	return MODE_OK;
 }
 
@@ -444,6 +585,26 @@ static const struct drm_connector_funcs fbdevdrm_connector_funcs = {
 static enum drm_mode_status mode_config_mode_valid(
 	struct drm_device *dev, const struct drm_display_mode *mode)
 {
+	/* TODO: maybe detect maximum depth */
+	static const unsigned int max_bpp = 4; /* 32-bit depth */
+
+	size_t vram_size_2, fb_size;
+	struct fbdevdrm_device *fdev = fbdevdrm_device_of_dev(dev);
+
+	/* DRM porting note: The atomic mode-setting framework requires
+	 * two framebuffers to be present in VRAM during page flips. This
+	 * is a problem for modes that require buffers larger than half
+	 * the VRAM size. This can happen on older graphics cards with less
+	 * than 16 MiB of VRAM. There's no point in reporting such modes,
+	 * so we sort them out. If you're porting an fbdevdriver to DRM, you
+	 * may want to keep this policy if the device has limited VRAM.
+	 */
+	vram_size_2 = fdev->ttm.vram_size / 2;
+
+	fb_size = mode->hdisplay * mode->vdisplay * max_bpp;
+	if (fb_size > vram_size_2)
+		return MODE_MEM;
+
 	return MODE_OK;
 }
 
-- 
2.21.0
