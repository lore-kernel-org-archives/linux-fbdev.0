From: Shashank Sharma <shashank.sharma@intel.com>
Date: Fri, 25 Mar 2016 08:29:32 +0000
Subject: [PATCH 2/5] drm: Add aspect ratio parsing in DRM layer
Message-Id: <1458893855-3930-3-git-send-email-shashank.sharma@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
In-Reply-To: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-fbdev@vger.kernel.org
Cc: daniel.vetter@intel.com, intel-gfx@lists.freedesktop.org, plagnioj@jcrosoft.com

Current DRM layer functions dont parse aspect ratio information
while converting a user mode->kernel mode or viceversa. This
causes modeset to pick mode with wrong aspect ratio, eventually
cauing failures in HDMI compliance test cases, due to wrong VIC.

This patch adds aspect ratio information in DRM's mode conversion
and mode comparision functions, to make sure kernel picks mode
with right aspect ratio (as per the VIC).

Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
Signed-off-by: Lin, Jia <lin.a.jia@intel.com>
Signed-off-by: Akashdeep Sharma <akashdeep.sharma@intel.com>
---
 drivers/gpu/drm/drm_modes.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index f7448a5..6e66136 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -939,6 +939,9 @@ bool drm_mode_equal_no_clocks(const struct drm_display_mode *mode1, const struct
 	    (mode2->flags & DRM_MODE_FLAG_3D_MASK))
 		return false;
 
+	if (mode1->picture_aspect_ratio != mode2->picture_aspect_ratio)
+		return false;
+
 	return drm_mode_equal_no_clocks_no_stereo(mode1, mode2);
 }
 EXPORT_SYMBOL(drm_mode_equal_no_clocks);
@@ -967,6 +970,7 @@ bool drm_mode_equal_no_clocks_no_stereo(const struct drm_display_mode *mode1,
 	    mode1->vsync_end = mode2->vsync_end &&
 	    mode1->vtotal = mode2->vtotal &&
 	    mode1->vscan = mode2->vscan &&
+	    mode1->picture_aspect_ratio = mode2->picture_aspect_ratio &&
 	    (mode1->flags & ~DRM_MODE_FLAG_3D_MASK) =
 	     (mode2->flags & ~DRM_MODE_FLAG_3D_MASK))
 		return true;
@@ -1469,6 +1473,22 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 	out->vrefresh = in->vrefresh;
 	out->flags = in->flags;
 	out->type = in->type;
+	out->flags &= ~DRM_MODE_FLAG_PARMASK;
+
+	switch (in->picture_aspect_ratio) {
+	case HDMI_PICTURE_ASPECT_4_3:
+		out->flags |= DRM_MODE_FLAG_PAR4_3;
+		break;
+	case HDMI_PICTURE_ASPECT_16_9:
+		out->flags |= DRM_MODE_FLAG_PAR16_9;
+		break;
+	case HDMI_PICTURE_ASPECT_NONE:
+	case HDMI_PICTURE_ASPECT_RESERVED:
+	default:
+		out->flags |= DRM_MODE_FLAG_PARNONE;
+		break;
+	}
+
 	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
 	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
 }
@@ -1514,6 +1534,20 @@ int drm_mode_convert_umode(struct drm_display_mode *out,
 	strncpy(out->name, in->name, DRM_DISPLAY_MODE_LEN);
 	out->name[DRM_DISPLAY_MODE_LEN-1] = 0;
 
+	/* Clearing picture aspect ratio bits from out flags */
+	out->flags &= ~DRM_MODE_FLAG_PARMASK;
+
+	switch (in->flags & DRM_MODE_FLAG_PARMASK) {
+	case DRM_MODE_FLAG_PAR4_3:
+		out->picture_aspect_ratio |= HDMI_PICTURE_ASPECT_4_3;
+		break;
+	case DRM_MODE_FLAG_PAR16_9:
+		out->picture_aspect_ratio |= HDMI_PICTURE_ASPECT_16_9;
+		break;
+	default:
+		out->picture_aspect_ratio = HDMI_PICTURE_ASPECT_NONE;
+	}
+
 	out->status = drm_mode_validate_basic(out);
 	if (out->status != MODE_OK)
 		goto out;
-- 
1.9.1

