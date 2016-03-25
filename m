From: Shashank Sharma <shashank.sharma@intel.com>
Date: Fri, 25 Mar 2016 08:29:35 +0000
Subject: [PATCH 5/5] drm/i915: Add support for new aspect ratios
Message-Id: <1458893855-3930-6-git-send-email-shashank.sharma@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
In-Reply-To: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-fbdev@vger.kernel.org
Cc: daniel.vetter@intel.com, intel-gfx@lists.freedesktop.org, plagnioj@jcrosoft.com

HDMI 2.0/CEA-861-F introduces two new aspect ratios:
- 64:27
- 256:135

This patch adds support for these aspect ratios in
I915 driver, at various places.

Signed-off-by: Shashank Sharma <shashank.sharma@intel.com>
---
 drivers/gpu/drm/drm_modes.c       | 12 ++++++++++++
 drivers/gpu/drm/i915/intel_hdmi.c |  6 ++++++
 drivers/gpu/drm/i915/intel_sdvo.c |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 6e66136..11f219a 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1482,6 +1482,12 @@ void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 	case HDMI_PICTURE_ASPECT_16_9:
 		out->flags |= DRM_MODE_FLAG_PAR16_9;
 		break;
+	case HDMI_PICTURE_ASPECT_64_27:
+		out->flags |= DRM_MODE_FLAG_PAR64_27;
+		break;
+	case DRM_MODE_PICTURE_ASPECT_256_135:
+		out->flags |= DRM_MODE_FLAG_PAR256_135;
+		break;
 	case HDMI_PICTURE_ASPECT_NONE:
 	case HDMI_PICTURE_ASPECT_RESERVED:
 	default:
@@ -1544,6 +1550,12 @@ int drm_mode_convert_umode(struct drm_display_mode *out,
 	case DRM_MODE_FLAG_PAR16_9:
 		out->picture_aspect_ratio |= HDMI_PICTURE_ASPECT_16_9;
 		break;
+	case DRM_MODE_FLAG_PAR64_27:
+		out->picture_aspect_ratio |= HDMI_PICTURE_ASPECT_64_27;
+		break;
+	case DRM_MODE_FLAG_PAR256_135:
+		out->picture_aspect_ratio |= HDMI_PICTURE_ASPECT_256_135;
+		break;
 	default:
 		out->picture_aspect_ratio = HDMI_PICTURE_ASPECT_NONE;
 	}
diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index e2dab48..bc8e2c8 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -1545,6 +1545,12 @@ intel_hdmi_set_property(struct drm_connector *connector,
 		case DRM_MODE_PICTURE_ASPECT_16_9:
 			intel_hdmi->aspect_ratio = HDMI_PICTURE_ASPECT_16_9;
 			break;
+		case DRM_MODE_PICTURE_ASPECT_64_27:
+			intel_hdmi->aspect_ratio = HDMI_PICTURE_ASPECT_64_27;
+			break;
+		case DRM_MODE_PICTURE_ASPECT_256_135:
+			intel_hdmi->aspect_ratio = HDMI_PICTURE_ASPECT_256_135;
+			break;
 		default:
 			return -EINVAL;
 		}
diff --git a/drivers/gpu/drm/i915/intel_sdvo.c b/drivers/gpu/drm/i915/intel_sdvo.c
index fae64bc..370e4f9 100644
--- a/drivers/gpu/drm/i915/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/intel_sdvo.c
@@ -2071,6 +2071,12 @@ intel_sdvo_set_property(struct drm_connector *connector,
 		case DRM_MODE_PICTURE_ASPECT_16_9:
 			intel_sdvo->aspect_ratio = HDMI_PICTURE_ASPECT_16_9;
 			break;
+		case DRM_MODE_PICTURE_ASPECT_64_27:
+			intel_sdvo->aspect_ratio = HDMI_PICTURE_ASPECT_64_27;
+			break;
+		case DRM_MODE_PICTURE_ASPECT_256_135:
+			intel_sdvo->aspect_ratio = HDMI_PICTURE_ASPECT_256_135;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
1.9.1

