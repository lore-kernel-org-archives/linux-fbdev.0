From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:50 +0000
Subject: [PATCH 22/23] OMAPDSS: change internal dispc functions to static
Message-Id: <1449676791-26304-23-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A bunch of dispc functions are only used inside dispc, so we can make
them static.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 15 ++++++++++-----
 drivers/video/fbdev/omap2/dss/dss.h   |  5 -----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 822add50f92e..346822b55947 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -251,6 +251,11 @@ struct color_conv_coef {
 	int full_range;
 };
 
+static unsigned long dispc_fclk_rate(void);
+static unsigned long dispc_core_clk_rate(void);
+static unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
+static unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
+
 static unsigned long dispc_plane_pclk_rate(enum omap_plane plane);
 static unsigned long dispc_plane_lclk_rate(enum omap_plane plane);
 
@@ -2952,7 +2957,7 @@ static void dispc_mgr_set_lcd_type_tft(enum omap_channel channel)
 	mgr_fld_write(channel, DISPC_MGR_FLD_STNTFT, 1);
 }
 
-void dispc_set_loadmode(enum omap_dss_load_mode mode)
+static void dispc_set_loadmode(enum omap_dss_load_mode mode)
 {
 	REG_FLD_MOD(DISPC_CONFIG, mode, 2, 1);
 }
@@ -3311,7 +3316,7 @@ static void dispc_mgr_get_lcd_divisor(enum omap_channel channel, int *lck_div,
 	*pck_div = FLD_GET(l, 7, 0);
 }
 
-unsigned long dispc_fclk_rate(void)
+static unsigned long dispc_fclk_rate(void)
 {
 	struct dss_pll *pll;
 	unsigned long r = 0;
@@ -3342,7 +3347,7 @@ unsigned long dispc_fclk_rate(void)
 	return r;
 }
 
-unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
+static unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 {
 	struct dss_pll *pll;
 	int lcd;
@@ -3383,7 +3388,7 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 	}
 }
 
-unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
+static unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 {
 	unsigned long r;
 
@@ -3408,7 +3413,7 @@ void dispc_set_tv_pclk(unsigned long pclk)
 	dispc.tv_pclk_rate = pclk;
 }
 
-unsigned long dispc_core_clk_rate(void)
+static unsigned long dispc_core_clk_rate(void)
 {
 	return dispc.core_clk_rate;
 }
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 2406bcdb831a..fec68d8939bc 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -378,7 +378,6 @@ void dispc_lcd_enable_signal(bool enable);
 void dispc_pck_free_enable(bool enable);
 void dispc_enable_fifomerge(bool enable);
 void dispc_enable_gamma_table(bool enable);
-void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
 typedef bool (*dispc_div_calc_func)(int lckd, int pckd, unsigned long lck,
 		unsigned long pck, void *data);
@@ -388,7 +387,6 @@ bool dispc_div_calc(unsigned long dispc,
 
 bool dispc_mgr_timings_ok(enum omap_channel channel,
 		const struct omap_video_timings *timings);
-unsigned long dispc_fclk_rate(void);
 int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
 
@@ -398,9 +396,6 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update);
 
-unsigned long dispc_mgr_lclk_rate(enum omap_channel channel);
-unsigned long dispc_mgr_pclk_rate(enum omap_channel channel);
-unsigned long dispc_core_clk_rate(void);
 void dispc_mgr_set_clock_div(enum omap_channel channel,
 		const struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
-- 
2.5.0

