From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 17 Oct 2012 11:20:34 +0000
Subject: [PATCH 8/9] OMAPDSS: DISPC: add dispc_mgr_get_sync_lost_irq()
Message-Id: <1350472835-28727-9-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add function that returns the sync lost irq mask for the given channel.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +++++
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 492740e..82339ad 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -543,6 +543,11 @@ u32 dispc_mgr_get_framedone_irq(enum omap_channel channel)
 	return mgr_desc[channel].framedone_irq;
 }
 
+u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel)
+{
+	return mgr_desc[channel].sync_lost_irq;
+}
+
 u32 dispc_wb_get_framedone_irq(void)
 {
 	return DISPC_IRQ_FRAMEDONEWB;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 373847c..b6e3a06 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -460,6 +460,7 @@ void dispc_ovl_set_channel_out(enum omap_plane plane,
 
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel);
 u32 dispc_mgr_get_framedone_irq(enum omap_channel channel);
+u32 dispc_mgr_get_sync_lost_irq(enum omap_channel channel);
 bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
-- 
1.7.9.5

