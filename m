From: Archit Taneja <archit@ti.com>
Date: Tue, 27 Dec 2011 12:48:55 +0000
Subject: [RFC PATCH 12/29] OMAPDSS: Writeback: Add check for color_mode in dss_wb_simple_check()
Message-Id: <1324989432-3625-13-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a check for the color_mode parameter provided by the user in
dss_wb_simple_check().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/writeback.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 8b2c9b8..540e61d 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -153,6 +153,13 @@ int dss_wb_simple_check(struct omap_dss_writeback *wb,
 		return -EINVAL;
 	}
 
+	if ((dss_feat_get_supported_color_modes(wb->plane_id) &
+			info->color_mode) = 0) {
+		DSSERR("wb_simple_check: wb%d doesn't support mode %d\n",
+			wb->id, info->color_mode);
+		return -EINVAL;
+	}
+
 	if (info->capture_rate < 0 || info->capture_rate > 7) {
 		DSSERR("wb_simple_check: capture rate cannot be %d\n",
 			info->capture_rate);
-- 
1.7.4.1

