From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 11:20:29 +0000
Subject: [PATCH 3/9] OMAPDSS: DISPC: constify function parameters
Message-Id: <1350472835-28727-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add consts to dispc function parameters which do not modify the passed
structs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 +++++-----
 drivers/video/omap2/dss/dss.h   |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b43477a..4dfc90a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1076,7 +1076,7 @@ static void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable)
 }
 
 static void dispc_mgr_set_cpr_coef(enum omap_channel channel,
-		struct omap_dss_cpr_coefs *coefs)
+		const struct omap_dss_cpr_coefs *coefs)
 {
 	u32 coef_r, coef_g, coef_b;
 
@@ -2505,7 +2505,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool mem_to_mem)
 {
 	int r;
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	const struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	enum omap_channel channel;
 
 	channel = dispc_ovl_get_channel_out(plane);
@@ -2842,7 +2842,7 @@ static void dispc_mgr_enable_alpha_fixed_zorder(enum omap_channel ch,
 }
 
 void dispc_mgr_setup(enum omap_channel channel,
-		struct omap_overlay_manager_info *info)
+		const struct omap_overlay_manager_info *info)
 {
 	dispc_mgr_set_default_color(channel, info->default_color);
 	dispc_mgr_set_trans_key(channel, info->trans_key_type, info->trans_key);
@@ -3012,7 +3012,7 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 
 /* change name to mode? */
 void dispc_mgr_set_timings(enum omap_channel channel,
-		struct omap_video_timings *timings)
+		const struct omap_video_timings *timings)
 {
 	unsigned xtot, ytot;
 	unsigned long ht, vt;
@@ -3533,7 +3533,7 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 }
 
 void dispc_mgr_set_clock_div(enum omap_channel channel,
-		struct dispc_clock_info *cinfo)
+		const struct dispc_clock_info *cinfo)
 {
 	DSSDBG("lck = %lu (%u)\n", cinfo->lck, cinfo->lck_div);
 	DSSDBG("pck = %lu (%u)\n", cinfo->pck, cinfo->pck_div);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6728892..eaf0856 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -475,16 +475,16 @@ void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_type_tft(enum omap_channel channel);
 void dispc_mgr_set_timings(enum omap_channel channel,
-		struct omap_video_timings *timings);
+		const struct omap_video_timings *timings);
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
 unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
 unsigned long dispc_core_clk_rate(void);
 void dispc_mgr_set_clock_div(enum omap_channel channel,
-		struct dispc_clock_info *cinfo);
+		const struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 void dispc_mgr_setup(enum omap_channel channel,
-		struct omap_overlay_manager_info *info);
+		const struct omap_overlay_manager_info *info);
 
 u32 dispc_wb_get_framedone_irq(void);
 bool dispc_wb_go_busy(void);
-- 
1.7.9.5

