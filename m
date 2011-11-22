From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Nov 2011 09:21:03 +0000
Subject: [PATCH 04/65] OMAPDSS: DISPC: make dispc_ovl_set_channel_out() public
Message-Id: <1321953724-6350-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Make dispc_ovl_set_channel_out() public so that later patches can handle
changing overlay's manager.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    3 +--
 drivers/video/omap2/dss/dss.h   |    2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5c81533..b2865ef 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -875,8 +875,7 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
-static void dispc_ovl_set_channel_out(enum omap_plane plane,
-		enum omap_channel channel)
+void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 {
 	int shift;
 	u32 val;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 7d2b6dd..f899f0f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -402,6 +402,8 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		bool ilace, enum omap_channel channel, bool replication,
 		u32 fifo_low, u32 fifo_high);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
+void dispc_ovl_set_channel_out(enum omap_plane plane,
+		enum omap_channel channel);
 
 
 void dispc_mgr_enable_fifohandcheck(enum omap_channel channel, bool enable);
-- 
1.7.4.1

