From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Thu, 07 May 2020 13:27:00 +0000
Subject: [PATCH v11 08/14] drm/i915: Add state readout for DP HDR Metadata Infoframe SDP
Message-Id: <20200507132706.2058969-9-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200507132706.2058969-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200507132706.2058969-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Added state readout for DP HDR Metadata Infoframe SDP.

v9: Rebased
v10: Rebased

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 4cfb749dea0c..109c60710310 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4234,6 +4234,9 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 				    pipe_config->fec_enable);
 		}
 
+		pipe_config->infoframes.enable |+			intel_hdmi_infoframes_enabled(encoder, pipe_config);
+
 		break;
 	case TRANS_DDI_MODE_SELECT_DP_MST:
 		pipe_config->output_types |= BIT(INTEL_OUTPUT_DP_MST);
@@ -4245,6 +4248,9 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 					REG_FIELD_GET(TRANS_DDI_MST_TRANSPORT_SELECT_MASK, temp);
 
 		intel_dp_get_m_n(intel_crtc, pipe_config);
+
+		pipe_config->infoframes.enable |+			intel_hdmi_infoframes_enabled(encoder, pipe_config);
 		break;
 	default:
 		break;
@@ -4299,6 +4305,8 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 
 	if (INTEL_GEN(dev_priv) >= 8)
 		bdw_get_trans_port_sync_config(pipe_config);
+
+	intel_read_dp_sdp(encoder, pipe_config, HDMI_PACKET_TYPE_GAMUT_METADATA);
 }
 
 static enum intel_output_type
-- 
2.25.0
