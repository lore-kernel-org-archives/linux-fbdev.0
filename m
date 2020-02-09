From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Sun, 09 Feb 2020 03:53:41 +0000
Subject: [PATCH v5 14/18] drm/i915: Disable DIPs when LSPCON is used
Message-Id: <20200209035345.357436-15-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200209035345.357436-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200209035345.357436-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

When LSPCON is used, DIPs(Data Island Packets of DP or HDMI) will not be
used. Therefore it explicitly disables DIPs on encoder->pre_enable
callback.

It resolves below issue
 - reproduce step of issue
 1) Boot or Pause & Resume system
 2) Do not enable SPD (Source Product Description) DIP
 3) When driver tries to read a DIP Ctl register,
    it is written that SDP DIP is enabled.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 7f29b08ea202..195e66744c1e 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3627,6 +3627,22 @@ static void intel_ddi_pre_enable_hdmi(struct intel_encoder *encoder,
 				       crtc_state, conn_state);
 }
 
+static void intel_ddi_disable_dips(struct intel_encoder *encoder,
+				   const struct intel_crtc_state *crtc_state)
+{
+	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
+	i915_reg_t reg = HSW_TVIDEO_DIP_CTL(crtc_state->cpu_transcoder);
+	u32 dip_enable = VIDEO_DIP_ENABLE_VSC_HSW | VIDEO_DIP_ENABLE_AVI_HSW |
+			 VIDEO_DIP_ENABLE_GCP_HSW | VIDEO_DIP_ENABLE_VS_HSW |
+			 VIDEO_DIP_ENABLE_GMP_HSW | VIDEO_DIP_ENABLE_SPD_HSW |
+			 VIDEO_DIP_ENABLE_DRM_GLK;
+	u32 val = intel_de_read(dev_priv, reg);
+
+	val &= ~dip_enable;
+	intel_de_write(dev_priv, reg, val);
+	intel_de_posting_read(dev_priv, reg);
+}
+
 static void intel_ddi_pre_enable(struct intel_encoder *encoder,
 				 const struct intel_crtc_state *crtc_state,
 				 const struct drm_connector_state *conn_state)
@@ -3666,6 +3682,13 @@ static void intel_ddi_pre_enable(struct intel_encoder *encoder,
 			struct intel_digital_port *dig_port  					enc_to_dig_port(encoder);
 
+			/*
+			 * When LSPCON is used, DIPs (Data Island Packets of DP
+			 * or HDMI) will not be used.
+			 * Therefore we explicitly disable DIPs here.
+			 */
+			intel_ddi_disable_dips(encoder, crtc_state);
+
 			dig_port->set_infoframes(encoder,
 						 crtc_state->has_infoframe,
 						 crtc_state, conn_state);
-- 
2.24.1
