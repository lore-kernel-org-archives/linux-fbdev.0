From: Tomi Valkeinen <tomi.valkeinen@TI.COM>
Date: Thu, 15 Nov 2012 15:58:19 +0000
Subject: [PATCH 11/32] OMAPDSS: DISPC: pass pclk & lclk to check_horiz_timing_omap3
Message-Id: <1352995120-3288-12-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@TI.COM>, Rob Clark <rob@TI.COM>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@TI.COM>

In order to make the scaling calculations independent of the current
hardware configuration (e.g. which manager is connected to this output),
we need to change the calc funcs to get all the variables needed for the
calculations via parameters.

This patch changes check_horiz_timing_omap3() to get pclk and lclk as
parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3025792..cd3dec6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1989,7 +1989,7 @@ static void calc_tiler_rotation_offset(u16 screen_width, u16 width,
  * This function is used to avoid synclosts in OMAP3, because of some
  * undocumented horizontal position and timing related limitations.
  */
-static int check_horiz_timing_omap3(enum omap_plane plane,
+static int check_horiz_timing_omap3(unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *t, u16 pos_x,
 		u16 width, u16 height, u16 out_width, u16 out_height)
 {
@@ -1997,8 +1997,6 @@ static int check_horiz_timing_omap3(enum omap_plane plane,
 	unsigned long nonactive;
 	static const u8 limits[3] = { 8, 10, 20 };
 	u64 val, blank;
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
-	unsigned long lclk = dispc_plane_lclk_rate(plane);
 	int i;
 
 	nonactive = t->x_res + t->hfp + t->hsw + t->hbp - out_width;
@@ -2186,6 +2184,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 	const int maxsinglelinewidth  			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	unsigned long pclk = dispc_plane_pclk_rate(plane);
+	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
@@ -2193,7 +2192,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 		*core_clk = calc_core_clk_five_taps(pclk, mgr_timings,
 			in_width, in_height, out_width, out_height, color_mode);
 
-		error = check_horiz_timing_omap3(plane, mgr_timings,
+		error = check_horiz_timing_omap3(pclk, lclk, mgr_timings,
 				pos_x, in_width, in_height, out_width,
 				out_height);
 
@@ -2221,8 +2220,8 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
-	if (check_horiz_timing_omap3(plane, mgr_timings, pos_x, width, height,
-		out_width, out_height)){
+	if (check_horiz_timing_omap3(pclk, lclk, mgr_timings, pos_x, width,
+				height, out_width, out_height)){
 			DSSERR("horizontal timing too tight\n");
 			return -EINVAL;
 	}
-- 
1.7.10.4

