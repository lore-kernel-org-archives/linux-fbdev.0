From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Nov 2012 15:58:09 +0000
Subject: [PATCH 01/32] OMAPDSS: remove declarations for non-existing functions
Message-Id: <1352995120-3288-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove dispc_mgr_is_channel_enabled() and dss_mgr_get_timings()
declarations, as the function doesn't exist.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 84a7f6a..8adf8be 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -197,7 +197,6 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings);
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config);
-const struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr);
 
 bool dss_ovl_is_enabled(struct omap_overlay *ovl);
 int dss_ovl_enable(struct omap_overlay *ovl);
@@ -444,7 +443,6 @@ void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
 void dispc_mgr_enable_sync(enum omap_channel channel);
 void dispc_mgr_disable_sync(enum omap_channel channel);
-bool dispc_mgr_is_channel_enabled(enum omap_channel channel);
 void dispc_mgr_set_lcd_config(enum omap_channel channel,
 		const struct dss_lcd_mgr_config *config);
 void dispc_mgr_set_timings(enum omap_channel channel,
-- 
1.7.10.4

