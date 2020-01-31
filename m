From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Fri, 31 Jan 2020 21:46:47 +0000
Subject: [PATCH 04/18] drm/i915/dp: Add compute routine for DP HDR Metadata Infoframe SDP
Message-Id: <20200131214701.1085737-5-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200131214701.1085737-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200131214701.1085737-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

It stores computed dp hdr metadata infoframe sdp to infoframes.drm of
crtc state. It referenced intel_hdmi_compute_drm_infoframe().

While computing, we'll also fill out the inforames.enable bitmask
appropriately.

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 705d36b548b1..64e697445085 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -2463,6 +2463,26 @@ static void intel_dp_compute_vsc_sdp(struct intel_dp *intel_dp,
 					 &crtc_state->infoframes.vsc);
 }
 
+static void
+intel_dp_compute_hdr_metadata_infoframe_sdp(struct intel_crtc_state *crtc_state,
+					    const struct drm_connector_state *conn_state)
+{
+	int ret;
+	struct hdmi_drm_infoframe *drm_infoframe = &crtc_state->infoframes.drm.drm;
+
+	if (!conn_state->hdr_output_metadata)
+		return;
+
+	ret = drm_hdmi_infoframe_set_hdr_metadata(drm_infoframe, conn_state);
+
+	if (ret) {
+		DRM_DEBUG_KMS("couldn't set HDR metadata in infoframe\n");
+		return;
+	}
+
+	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(HDMI_PACKET_TYPE_GAMUT_METADATA);
+}
+
 int
 intel_dp_compute_config(struct intel_encoder *encoder,
 			struct intel_crtc_state *pipe_config,
@@ -2569,6 +2589,7 @@ intel_dp_compute_config(struct intel_encoder *encoder,
 
 	intel_psr_compute_config(intel_dp, pipe_config);
 	intel_dp_compute_vsc_sdp(intel_dp, pipe_config, conn_state);
+	intel_dp_compute_hdr_metadata_infoframe_sdp(pipe_config, conn_state);
 
 	return 0;
 }
-- 
2.24.1
