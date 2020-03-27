From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Fri, 27 Mar 2020 07:29:14 +0000
Subject: [PATCH v8 11/14] drm/i915: Program DP SDPs on pipe updates
Message-Id: <20200327072917.3676391-12-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200327072917.3676391-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200327072917.3676391-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: jani.nikula@intel.com, linux-fbdev@vger.kernel.org, uma.shankar@intel.com, laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org

Call intel_dp_set_infoframes() function on pipe updates to make sure
that we send VSC SDP and HDR Metadata Infoframe SDP (when applicable)
on fastsets.

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index f58a539d51c2..57def3ae53b4 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3711,6 +3711,7 @@ static void intel_ddi_update_pipe_dp(struct intel_encoder *encoder,
 	intel_ddi_set_dp_msa(crtc_state, conn_state);
 
 	intel_psr_update(intel_dp, crtc_state);
+	intel_dp_set_infoframes(encoder, true, crtc_state, conn_state);
 	intel_edp_drrs_enable(intel_dp, crtc_state);
 
 	intel_panel_update_backlight(encoder, crtc_state, conn_state);
-- 
2.25.0
