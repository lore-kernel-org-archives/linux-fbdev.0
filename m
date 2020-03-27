From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Fri, 27 Mar 2020 07:29:08 +0000
Subject: [PATCH v8 05/14] drm/i915: Include DP HDR Metadata Infoframe SDP in the crtc state dump
Message-Id: <20200327072917.3676391-6-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200327072917.3676391-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200327072917.3676391-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com, linux-fbdev@vger.kernel.org, uma.shankar@intel.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org

Dump out the DP HDR Metadata Infoframe SDP in the normal crtc state dump.

HDMI Dynamic Range and Mastering (DRM) infoframe and DP HDR Metadata
Infoframe SDP use the same member variable in infoframes of crtc state.

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index abe9425d815f..ed331f4b78ac 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -13076,6 +13076,9 @@ static void intel_dump_pipe_config(const struct intel_crtc_state *pipe_config,
 	if (pipe_config->infoframes.enable &
 	    intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_DRM))
 		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.drm);
+	if (pipe_config->infoframes.enable &
+	    intel_hdmi_infoframe_enable(HDMI_PACKET_TYPE_GAMUT_METADATA))
+		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.drm);
 
 	drm_dbg_kms(&dev_priv->drm, "requested mode:\n");
 	drm_mode_debug_printmodeline(&pipe_config->hw.mode);
-- 
2.25.0
