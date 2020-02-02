From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Sun, 02 Feb 2020 15:49:22 +0000
Subject: [PATCH v2 02/18] drm/i915: Add DP VSC SDP payload data to intel_crtc_state.infoframes
Message-Id: <20200202154938.1129610-3-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200202154938.1129610-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200202154938.1129610-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

In order to support state readout for DP VSC SDP, we need to have a
structure which holds DP VSC SDP payload data such as
"union hdmi_infoframe drm" which is used for DRM infoframe.

And In order to support DP HDR10, we have to support VSC SDP and
HDR Metadata Infoframe SDP. As we will use drm member variable of
intel_crtc_state.infoframes, we only need to add vsc sdp member variable
to intel_crtc_state.infoframes.

Because DP SDP payload type does not have common structure like as
"union hdmi_infoframe", it adds "struct intel_dp_vsc_sdp"
to intel_display_types.h

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 33ba93863488..81112d63342c 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -780,6 +780,17 @@ enum intel_output_format {
 	INTEL_OUTPUT_FORMAT_YCBCR444,
 };
 
+struct intel_dp_vsc_sdp {
+	unsigned char sdp_type; /* Secondary-data Packet Type */
+	unsigned char revision; /* Revision Number */
+	unsigned char length; /* Number of Valid Data Bytes */
+	enum dp_colorspace colorspace;
+	enum dp_colorimetry colorimetry;
+	int bpc;
+	enum dp_dynamic_range dynamic_range;
+	enum dp_content_type content_type;
+};
+
 struct intel_crtc_state {
 	/*
 	 * uapi (drm) state. This is the software state shown to userspace.
@@ -1021,6 +1032,7 @@ struct intel_crtc_state {
 		union hdmi_infoframe spd;
 		union hdmi_infoframe hdmi;
 		union hdmi_infoframe drm;
+		struct intel_dp_vsc_sdp vsc;
 	} infoframes;
 
 	/* HDMI scrambling status */
-- 
2.24.1
