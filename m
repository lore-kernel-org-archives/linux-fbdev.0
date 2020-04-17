From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Fri, 17 Apr 2020 11:58:17 +0000
Subject: [PATCH v10 04/14] drm/i915: Include HDMI DRM infoframe in the crtc state dump
Message-Id: <20200417120040.3432332-5-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200417120040.3432332-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200417120040.3432332-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, jani.nikula@intel.com, dri-devel@lists.freedesktop.org, uma.shankar@intel.com, laurent.pinchart@ideasonboard.com

Dump out the HDMI Dynamic Range and Mastering (DRM) infoframe in the
normal crtc state dump.

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index af5b4055b38a..b9bf9bce49d6 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -13001,6 +13001,9 @@ static void intel_dump_pipe_config(const struct intel_crtc_state *pipe_config,
 	if (pipe_config->infoframes.enable &
 	    intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_VENDOR))
 		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.hdmi);
+	if (pipe_config->infoframes.enable &
+	    intel_hdmi_infoframe_enable(HDMI_INFOFRAME_TYPE_DRM))
+		intel_dump_infoframe(dev_priv, &pipe_config->infoframes.drm);
 
 	drm_dbg_kms(&dev_priv->drm, "requested mode:\n");
 	drm_mode_debug_printmodeline(&pipe_config->hw.mode);
-- 
2.25.0
