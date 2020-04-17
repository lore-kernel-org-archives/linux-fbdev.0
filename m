From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Fri, 17 Apr 2020 11:58:26 +0000
Subject: [PATCH v10 08/14] drm/i915: Add state readout for DP HDR Metadata Infoframe SDP
Message-Id: <20200417120040.3432332-9-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417120040.3432332-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200417120040.3432332-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, uma.shankar@intel.com, laurent.pinchart@ideasonboard.com

Added state readout for DP HDR Metadata Infoframe SDP.

v9: Rebased
v10: Rebased

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index d9278d7553ee..5dbb54b88d0e 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4145,6 +4145,9 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 				    pipe_config->fec_enable);
 		}
 
+		pipe_config->infoframes.enable |+			intel_hdmi_infoframes_enabled(encoder, pipe_config);
+
 		break;
 	case TRANS_DDI_MODE_SELECT_DP_MST:
 		pipe_config->output_types |= BIT(INTEL_OUTPUT_DP_MST);
@@ -4156,6 +4159,9 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 					REG_FIELD_GET(TRANS_DDI_MST_TRANSPORT_SELECT_MASK, temp);
 
 		intel_dp_get_m_n(intel_crtc, pipe_config);
+
+		pipe_config->infoframes.enable |+			intel_hdmi_infoframes_enabled(encoder, pipe_config);
 		break;
 	default:
 		break;
@@ -4210,6 +4216,8 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 
 	if (INTEL_GEN(dev_priv) >= 8)
 		bdw_get_trans_port_sync_config(pipe_config);
+
+	intel_read_dp_sdp(encoder, pipe_config, HDMI_PACKET_TYPE_GAMUT_METADATA);
 }
 
 static enum intel_output_type
-- 
2.25.0
