From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Date: Thu, 07 May 2020 13:27:04 +0000
Subject: [PATCH v11 12/14] drm/i915: Stop sending DP SDPs on ddi disable
Message-Id: <20200507132706.2058969-13-gwan-gyeong.mun@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200507132706.2058969-1-gwan-gyeong.mun@intel.com>
In-Reply-To: <20200507132706.2058969-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-gfx@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Call intel_dp_set_infoframes(false) function on intel_ddi_post_disable_dp()
to make sure not to send VSC SDP and HDR Metadata Infoframe SDP.

v5: Polish commit message [Uma]

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index e0862b899f1b..d88431ebb34e 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3472,6 +3472,8 @@ static void intel_ddi_post_disable_dp(struct intel_atomic_state *state,
 					  INTEL_OUTPUT_DP_MST);
 	enum phy phy = intel_port_to_phy(dev_priv, encoder->port);
 
+	intel_dp_set_infoframes(encoder, false, old_crtc_state, old_conn_state);
+
 	/*
 	 * Power down sink before disabling the port, otherwise we end
 	 * up getting interrupts from the sink on detecting link loss.
-- 
2.25.0
