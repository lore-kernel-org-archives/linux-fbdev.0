From: Archit Taneja <archit@ti.com>
Date: Tue, 27 Dec 2011 12:49:03 +0000
Subject: [RFC PATCH 20/29] OMAPDSS: Writeback: Add writeback capabilities
Message-Id: <1324989432-3625-21-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a capabilities parameter of type omap_overlay_caps to omap_dss_writeback.
These caps let us reuse some of the DISPC overlay functions. Set the
capabilities so the writeback supports scaling and pre multiplied alpha.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/writeback.c |    3 +++
 include/video/omapdss.h             |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 540e61d..14103bf 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -90,6 +90,9 @@ void dss_init_writeback(void)
 		wb->id = i;
 		wb->plane_id = OMAP_DSS_WB + i;
 
+		wb->caps = OMAP_DSS_OVL_CAP_SCALE |
+				OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA;
+
 		wb->set_wb_info = &dss_wb_set_info;
 		wb->get_wb_info = &dss_wb_get_info;
 	}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 49e3ccb..291457c 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -493,6 +493,9 @@ struct omap_dss_writeback {
 	int id;
 	int plane_id;
 
+	/* overlay-like capabilities writeback supports */
+	enum omap_overlay_caps caps;
+
 	/* dummy panel we are connected to */
 	struct omap_dss_device *dssdev;
 
-- 
1.7.4.1

