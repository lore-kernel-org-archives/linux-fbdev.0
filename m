From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Fri, 27 Mar 2020 07:29:12 +0000
Subject: [PATCH v8 09/14] drm/i915: Add state readout for DP VSC SDP
Message-Id: <20200327072917.3676391-10-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200327072917.3676391-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200327072917.3676391-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com, linux-fbdev@vger.kernel.org, uma.shankar@intel.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org

Added state readout for DP VSC SDP and enabled state validation
for DP VSC SDP.

v2: Minor style fix
v3: Replace a structure name to drm_dp_vsc_sdp from intel_dp_vsc_sdp
v4: Use struct drm_device logging macros

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c     |  1 +
 drivers/gpu/drm/i915/display/intel_display.c | 43 ++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index c2c5feff46bf..f58a539d51c2 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4014,6 +4014,7 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
 			     &pipe_config->infoframes.drm);
 
 	intel_read_dp_sdp(encoder, pipe_config, HDMI_PACKET_TYPE_GAMUT_METADATA);
+	intel_read_dp_sdp(encoder, pipe_config, DP_SDP_VSC);
 }
 
 static enum intel_output_type
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index caa8fdeb9c33..0d40f76b844b 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -13539,6 +13539,13 @@ intel_compare_infoframe(const union hdmi_infoframe *a,
 	return memcmp(a, b, sizeof(*a)) = 0;
 }
 
+static bool
+intel_compare_dp_vsc_sdp(const struct drm_dp_vsc_sdp *a,
+			 const struct drm_dp_vsc_sdp *b)
+{
+	return memcmp(a, b, sizeof(*a)) = 0;
+}
+
 static void
 pipe_config_infoframe_mismatch(struct drm_i915_private *dev_priv,
 			       bool fastset, const char *name,
@@ -13564,6 +13571,31 @@ pipe_config_infoframe_mismatch(struct drm_i915_private *dev_priv,
 	}
 }
 
+static void
+pipe_config_dp_vsc_sdp_mismatch(struct drm_i915_private *dev_priv,
+				bool fastset, const char *name,
+				const struct drm_dp_vsc_sdp *a,
+				const struct drm_dp_vsc_sdp *b)
+{
+	if (fastset) {
+		if (!drm_debug_enabled(DRM_UT_KMS))
+			return;
+
+		drm_dbg_kms(&dev_priv->drm,
+			    "fastset mismatch in %s dp sdp\n", name);
+		drm_dbg_kms(&dev_priv->drm, "expected:\n");
+		drm_dp_vsc_sdp_log(KERN_DEBUG, dev_priv->drm.dev, a);
+		drm_dbg_kms(&dev_priv->drm, "found:\n");
+		drm_dp_vsc_sdp_log(KERN_DEBUG, dev_priv->drm.dev, b);
+	} else {
+		drm_err(&dev_priv->drm, "mismatch in %s dp sdp\n", name);
+		drm_err(&dev_priv->drm, "expected:\n");
+		drm_dp_vsc_sdp_log(KERN_ERR, dev_priv->drm.dev, a);
+		drm_err(&dev_priv->drm, "found:\n");
+		drm_dp_vsc_sdp_log(KERN_ERR, dev_priv->drm.dev, b);
+	}
+}
+
 static void __printf(4, 5)
 pipe_config_mismatch(bool fastset, const struct intel_crtc *crtc,
 		     const char *name, const char *format, ...)
@@ -13765,6 +13797,16 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 	} \
 } while (0)
 
+#define PIPE_CONF_CHECK_DP_VSC_SDP(name) do { \
+	if (!intel_compare_dp_vsc_sdp(&current_config->infoframes.name, \
+				      &pipe_config->infoframes.name)) { \
+		pipe_config_dp_vsc_sdp_mismatch(dev_priv, fastset, __stringify(name), \
+						&current_config->infoframes.name, \
+						&pipe_config->infoframes.name); \
+		ret = false; \
+	} \
+} while (0)
+
 #define PIPE_CONF_CHECK_COLOR_LUT(name1, name2, bit_precision) do { \
 	if (current_config->name1 != pipe_config->name1) { \
 		pipe_config_mismatch(fastset, crtc, __stringify(name1), \
@@ -13940,6 +13982,7 @@ intel_pipe_config_compare(const struct intel_crtc_state *current_config,
 	PIPE_CONF_CHECK_INFOFRAME(spd);
 	PIPE_CONF_CHECK_INFOFRAME(hdmi);
 	PIPE_CONF_CHECK_INFOFRAME(drm);
+	PIPE_CONF_CHECK_DP_VSC_SDP(vsc);
 
 	PIPE_CONF_CHECK_X(sync_mode_slaves_mask);
 	PIPE_CONF_CHECK_I(master_transcoder);
-- 
2.25.0
