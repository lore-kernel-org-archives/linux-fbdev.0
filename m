From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:13 +0000
Subject: [PATCH 14/65] OMAPDSS: setup manager with dispc_mgr_setup()
Message-Id: <1321953724-6350-15-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Change manager configuration to be similar to overlay configuration by
creating dispc_mgr_setup() which takes omap_overlay_manager_info as
parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |   26 ++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h     |   11 ++---------
 drivers/video/omap2/dss/manager.c |    9 +--------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ab86a78..3f2efdc 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -996,7 +996,7 @@ void dispc_enable_gamma_table(bool enable)
 	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
 }
 
-void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable)
+static void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable)
 {
 	u16 reg;
 
@@ -1010,7 +1010,7 @@ void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable)
 	REG_FLD_MOD(reg, enable, 15, 15);
 }
 
-void dispc_mgr_set_cpr_coef(enum omap_channel channel,
+static void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs)
 {
 	u32 coef_r, coef_g, coef_b;
@@ -2158,7 +2158,7 @@ void dispc_set_loadmode(enum omap_dss_load_mode mode)
 }
 
 
-void dispc_mgr_set_default_color(enum omap_channel channel, u32 color)
+static void dispc_mgr_set_default_color(enum omap_channel channel, u32 color)
 {
 	dispc_write_reg(DISPC_DEFAULT_COLOR(channel), color);
 }
@@ -2176,7 +2176,7 @@ u32 dispc_mgr_get_default_color(enum omap_channel channel)
 	return l;
 }
 
-void dispc_mgr_set_trans_key(enum omap_channel ch,
+static void dispc_mgr_set_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type type,
 		u32 trans_key)
 {
@@ -2209,7 +2209,7 @@ void dispc_mgr_get_trans_key(enum omap_channel ch,
 		*trans_key = dispc_read_reg(DISPC_TRANS_COLOR(ch));
 }
 
-void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable)
+static void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable)
 {
 	if (ch = OMAP_DSS_CHANNEL_LCD)
 		REG_FLD_MOD(DISPC_CONFIG, enable, 10, 10);
@@ -2219,7 +2219,8 @@ void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable)
 		REG_FLD_MOD(DISPC_CONFIG2, enable, 10, 10);
 }
 
-void dispc_mgr_enable_alpha_fixed_zorder(enum omap_channel ch, bool enable)
+static void dispc_mgr_enable_alpha_fixed_zorder(enum omap_channel ch,
+		bool enable)
 {
 	if (!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER))
 		return;
@@ -2263,6 +2264,19 @@ bool dispc_mgr_trans_key_enabled(enum omap_channel ch)
 	return enabled;
 }
 
+void dispc_mgr_setup(enum omap_channel channel,
+		struct omap_overlay_manager_info *info)
+{
+	dispc_mgr_set_default_color(channel, info->default_color);
+	dispc_mgr_set_trans_key(channel, info->trans_key_type, info->trans_key);
+	dispc_mgr_enable_trans_key(channel, info->trans_enabled);
+	dispc_mgr_enable_alpha_fixed_zorder(channel,
+			info->partial_alpha_enabled);
+	if (dss_has_feature(FEAT_CPR)) {
+		dispc_mgr_enable_cpr(channel, info->cpr_enable);
+		dispc_mgr_set_cpr_coef(channel, &info->cpr_coefs);
+	}
+}
 
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bc1b2cc..3e01bba 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -405,9 +405,6 @@ void dispc_ovl_set_channel_out(enum omap_plane plane,
 
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
 void dispc_mgr_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
-void dispc_mgr_enable_cpr(enum omap_channel channel, bool enable);
-void dispc_mgr_set_cpr_coef(enum omap_channel channel,
-		struct omap_dss_cpr_coefs *coefs);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
@@ -418,16 +415,10 @@ void dispc_mgr_enable_stallmode(enum omap_channel channel, bool enable);
 void dispc_mgr_set_tft_data_lines(enum omap_channel channel, u8 data_lines);
 void dispc_mgr_set_lcd_display_type(enum omap_channel channel,
 		enum omap_lcd_display_type type);
-void dispc_mgr_set_default_color(enum omap_channel channel, u32 color);
 u32 dispc_mgr_get_default_color(enum omap_channel channel);
-void dispc_mgr_set_trans_key(enum omap_channel ch,
-		enum omap_dss_trans_key_type type,
-		u32 trans_key);
 void dispc_mgr_get_trans_key(enum omap_channel ch,
 		enum omap_dss_trans_key_type *type,
 		u32 *trans_key);
-void dispc_mgr_enable_trans_key(enum omap_channel ch, bool enable);
-void dispc_mgr_enable_alpha_fixed_zorder(enum omap_channel ch, bool enable);
 bool dispc_mgr_trans_key_enabled(enum omap_channel ch);
 bool dispc_mgr_alpha_fixed_zorder_enabled(enum omap_channel ch);
 void dispc_mgr_set_lcd_timings(enum omap_channel channel,
@@ -440,6 +431,8 @@ int dispc_mgr_set_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
 int dispc_mgr_get_clock_div(enum omap_channel channel,
 		struct dispc_clock_info *cinfo);
+void dispc_mgr_setup(enum omap_channel channel,
+		struct omap_overlay_manager_info *info);
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 42740d3..fc19f01 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -803,14 +803,7 @@ static void configure_manager(enum omap_channel channel)
 	/* picking info from the cache */
 	mi = &dss_cache.manager_cache[channel].info;
 
-	dispc_mgr_set_default_color(channel, mi->default_color);
-	dispc_mgr_set_trans_key(channel, mi->trans_key_type, mi->trans_key);
-	dispc_mgr_enable_trans_key(channel, mi->trans_enabled);
-	dispc_mgr_enable_alpha_fixed_zorder(channel, mi->partial_alpha_enabled);
-	if (dss_has_feature(FEAT_CPR)) {
-		dispc_mgr_enable_cpr(channel, mi->cpr_enable);
-		dispc_mgr_set_cpr_coef(channel, &mi->cpr_coefs);
-	}
+	dispc_mgr_setup(channel, mi);
 }
 
 /* configure_dispc() tries to write values from cache to shadow registers.
-- 
1.7.4.1

