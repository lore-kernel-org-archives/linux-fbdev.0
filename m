From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 14 Nov 2011 15:01:45 +0000
Subject: [PATCH 3/3] OMAPDSS: DISPC: skip scaling calculations when not scaling
Message-Id: <1321282905-12939-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321282905-12939-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Current code calculates scaling factors for video overlays even when the
overlays are not scaled. Change the code to skip calculations when not
scaling.

This optimizes the code a bit, but also fixes a problem when configuring
an overlay for a disabled display: if the display is disabled we don't
necessarily know the pixel clock used when the display is enabled, and
in some cases (like HDMI) the pixel clock is set to zero until a proper
video mode is set later. A wrong pixel clock will mess up the
scaling calculations, causing an error like:

omapdss DISPC error: failed to set up scaling, required fclk rate = 0
Hz, current fclk rate = 170666666 Hz

A proper fix would be to check later whether the clocks are enough for the
scaling, at the point when the overlay or display is actually enabled,
but this patch removes the problem for now.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3532782..5c81533 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1720,12 +1720,11 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 	unsigned long fclk = 0;
 
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) = 0) {
-		if (width != out_width || height != out_height)
-			return -EINVAL;
-		else
-			return 0;
-	}
+	if (width = out_width && height = out_height)
+		return 0;
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) = 0)
+		return -EINVAL;
 
 	if (out_width < width / maxdownscale ||
 			out_width > width * 8)
-- 
1.7.4.1

