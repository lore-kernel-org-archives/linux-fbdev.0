From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 24 Oct 2012 09:29:00 +0000
Subject: [PATCH 09/20] OMAPDSS: add dispc_ovl_enabled()
Message-Id: <1351070951-18616-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add new dispc function, dispc_ovl_enabled(). This returns if the overlay
enable bit is set in the registers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +++++
 drivers/video/omap2/dss/dss.h   |    1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b5cdbaf..3fd60ce 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2589,6 +2589,11 @@ int dispc_ovl_enable(enum omap_plane plane, bool enable)
 	return 0;
 }
 
+bool dispc_ovl_enabled(enum omap_plane plane)
+{
+	return REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
+}
+
 static void dispc_mgr_disable_isr(void *data, u32 mask)
 {
 	struct completion *compl = data;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b007aee..be7678c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -428,6 +428,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct omap_video_timings *mgr_timings,
 		bool mem_to_mem);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
+bool dispc_ovl_enabled(enum omap_plane plane);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
 
-- 
1.7.9.5

