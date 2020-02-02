From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Sun, 02 Feb 2020 15:49:28 +0000
Subject: [PATCH v2 08/18] drm/i915/dp: Add logging function for DP VSC SDP
Message-Id: <20200202154938.1129610-9-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200202154938.1129610-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200202154938.1129610-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

When receiving video it is very useful to be able to log DP VSC SDP.
This greatly simplifies debugging.

v2: Minor style fix

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 174 ++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.h |   4 +
 2 files changed, 178 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index d84317dc26d1..85fa17ab8403 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5091,6 +5091,180 @@ void intel_read_dp_sdp(struct intel_encoder *encoder,
 	}
 }
 
+static const char *dp_colorspace_get_name(enum dp_colorspace colorspace)
+{
+	if (colorspace < 0 || colorspace > DP_COLORSPACE_RESERVED)
+		return "Invalid";
+
+	switch (colorspace) {
+	case DP_COLORSPACE_RGB:
+		return "RGB";
+	case DP_COLORSPACE_YUV444:
+		return "YUV444";
+	case DP_COLORSPACE_YUV422:
+		return "YUV422";
+	case DP_COLORSPACE_YUV420:
+		return "YUV420";
+	case DP_COLORSPACE_Y_ONLY:
+		return "Y_ONLY";
+	case DP_COLORSPACE_RAW:
+		return "RAW";
+	default:
+		return "Reserved";
+	}
+}
+
+static const char *dp_colorimetry_get_name(enum dp_colorspace colorspace,
+					   enum dp_colorimetry colorimetry)
+{
+	if (colorspace < 0 || colorspace > DP_COLORSPACE_RESERVED)
+		return "Invalid";
+
+	switch (colorimetry) {
+	case DP_COLORIMETRY_DEFAULT:
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "sRGB";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "BT.601";
+		case DP_COLORSPACE_Y_ONLY:
+			return "DICOM PS3.14";
+		case DP_COLORSPACE_RAW:
+			return "Custom Color Profile";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_RGB_WIDE_FIXED: /* and DP_COLORIMETRY_BT709_YCC */
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "Wide Fixed";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "BT.709";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_RGB_WIDE_FLOAT: /* and DP_COLORIMETRY_XVYCC_601 */
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "Wide Float";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "xvYCC 601";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_OPRGB: /* and DP_COLORIMETRY_XVYCC_709 */
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "OpRGB";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "xvYCC 709";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_DCI_P3_RGB: /* and DP_COLORIMETRY_SYCC_601 */
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "DCI-P3";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "sYCC 601";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_RGB_CUSTOM: /* and DP_COLORIMETRY_OPYCC_601 */
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "Custom Profile";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "OpYCC 601";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_BT2020_RGB: /* and DP_COLORIMETRY_BT2020_CYCC */
+		switch (colorspace) {
+		case DP_COLORSPACE_RGB:
+			return "BT.2020 RGB";
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "BT.2020 CYCC";
+		default:
+			return "Reserved";
+		}
+	case DP_COLORIMETRY_BT2020_YCC:
+		switch (colorspace) {
+		case DP_COLORSPACE_YUV444:
+		case DP_COLORSPACE_YUV422:
+		case DP_COLORSPACE_YUV420:
+			return "BT.2020 YCC";
+		default:
+			return "Reserved";
+		}
+	default:
+		return "Invalid";
+	}
+}
+
+static const char *dp_dynamic_range_get_name(enum dp_dynamic_range dynamic_range)
+{
+	switch (dynamic_range) {
+	case DP_DYNAMIC_RANGE_VESA:
+		return "VESA range";
+	case DP_DYNAMIC_RANGE_CTA:
+		return "CTA range";
+	default:
+		return "Invalid";
+	}
+}
+
+static const char *dp_content_type_get_name(enum dp_content_type content_type)
+{
+	switch (content_type) {
+	case DP_CONTENT_TYPE_NOT_DEFINED:
+		return "Not defined";
+	case DP_CONTENT_TYPE_GRAPHICS:
+		return "Graphics";
+	case DP_CONTENT_TYPE_PHOTO:
+		return "Photo";
+	case DP_CONTENT_TYPE_VIDEO:
+		return "Video";
+	case DP_CONTENT_TYPE_GAME:
+		return "Game";
+	default:
+		return "Reserved";
+	}
+}
+
+void intel_dp_vsc_sdp_log(const char *level, struct device *dev,
+			  const struct intel_dp_vsc_sdp *vsc)
+{
+#define DP_SDP_LOG(fmt, ...) dev_printk(level, dev, fmt, ##__VA_ARGS__)
+	DP_SDP_LOG("DP SDP: %s, revision %u, length %u\n", "VSC",
+		   vsc->revision, vsc->length);
+	DP_SDP_LOG("    colorspace: %s\n",
+		   dp_colorspace_get_name(vsc->colorspace));
+	DP_SDP_LOG("    colorimetry: %s\n",
+		   dp_colorimetry_get_name(vsc->colorspace, vsc->colorimetry));
+	DP_SDP_LOG("    bpc: %u\n", vsc->bpc);
+	DP_SDP_LOG("    dynamic range: %s\n",
+		   dp_dynamic_range_get_name(vsc->dynamic_range));
+	DP_SDP_LOG("    content type: %s\n",
+		   dp_content_type_get_name(vsc->content_type));
+#undef DP_SDP_LOG
+}
+
+
 static void
 intel_dp_setup_vsc_sdp(struct intel_dp *intel_dp,
 		       const struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index e8f9ba962d09..03b300b58fd0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -7,6 +7,7 @@
 #define __INTEL_DP_H__
 
 #include <linux/types.h>
+#include <linux/device.h>
 
 #include <drm/i915_drm.h>
 
@@ -23,6 +24,7 @@ struct intel_crtc_state;
 struct intel_digital_port;
 struct intel_dp;
 struct intel_encoder;
+struct intel_dp_vsc_sdp;
 
 struct link_config_limits {
 	int min_clock, max_clock;
@@ -122,6 +124,8 @@ void intel_dp_set_infoframes(struct intel_encoder *encoder, bool enable,
 void intel_read_dp_sdp(struct intel_encoder *encoder,
 		       struct intel_crtc_state *crtc_state,
 		       unsigned int type);
+void intel_dp_vsc_sdp_log(const char *level, struct device *dev,
+			  const struct intel_dp_vsc_sdp *vsc);
 bool intel_digital_port_connected(struct intel_encoder *encoder);
 
 static inline unsigned int intel_dp_unused_lane_mask(int lane_count)
-- 
2.24.1
