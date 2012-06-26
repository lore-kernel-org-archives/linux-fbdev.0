From: Archit Taneja <archit@ti.com>
Date: Tue, 26 Jun 2012 09:48:46 +0000
Subject: [PATCH 09/17] OMAPFB: Map the newly added omap_video_timings fields with fb sync flags
Message-Id: <1340703414-1915-11-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Use the newly added fields in omap_video_timings(hsync, vsync and data_enable
logic levels and data, hsync and vsync latching related info) to
configure/retrieve corresponding sync flags in fb_var_screeninfo and
fb_videomode.

Out of the new fields, hsync_level and vsync_level can be mapped to the fb sync
flags FB_SYNC_HOR_HIGH_ACT and FB_SYNC_VERT_HIGH_ACT.

When converting fb mode to omap_video_timings, the fields which don't have an
equivalent parameter in fb are set to  the default values.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 1dd8f2c..7c99725 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -733,6 +733,10 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 		var->lower_margin = timings.vfp;
 		var->hsync_len = timings.hsw;
 		var->vsync_len = timings.vsw;
+		var->sync |= timings.hsync_level = OMAPDSS_SIG_ACTIVE_HIGH ?
+				FB_SYNC_HOR_HIGH_ACT : 0;
+		var->sync |= timings.vsync_level = OMAPDSS_SIG_ACTIVE_HIGH ?
+				FB_SYNC_VERT_HIGH_ACT : 0;
 	} else {
 		var->pixclock = 0;
 		var->left_margin = 0;
@@ -741,11 +745,11 @@ int check_fb_var(struct fb_info *fbi, struct fb_var_screeninfo *var)
 		var->lower_margin = 0;
 		var->hsync_len = 0;
 		var->vsync_len = 0;
+		var->sync = 0;
 	}
 
 	/* TODO: get these from panel->config */
 	var->vmode              = FB_VMODE_NONINTERLACED;
-	var->sync               = 0;
 
 	return 0;
 }
@@ -2053,6 +2057,15 @@ static int omapfb_mode_to_timings(const char *mode_str,
 	timings->vsw = var->vsync_len;
 	timings->x_res = var->xres;
 	timings->y_res = var->yres;
+	timings->hsync_level = var->sync & FB_SYNC_HOR_HIGH_ACT ?
+				OMAPDSS_SIG_ACTIVE_HIGH :
+				OMAPDSS_SIG_ACTIVE_LOW;
+	timings->vsync_level = var->sync & FB_SYNC_VERT_HIGH_ACT ?
+				OMAPDSS_SIG_ACTIVE_HIGH :
+				OMAPDSS_SIG_ACTIVE_LOW;
+	timings->pclk_edge = OMAPDSS_SIG_ACTIVE_HIGH;
+	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	timings->hsync_vsync_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 
 	switch (var->bits_per_pixel) {
 	case 16:
@@ -2187,6 +2200,15 @@ static void fb_videomode_to_omap_timings(struct fb_videomode *m,
 	t->vsw = m->vsync_len;
 	t->vfp = m->lower_margin;
 	t->vbp = m->upper_margin;
+	t->hsync_level = m->sync & FB_SYNC_HOR_HIGH_ACT ?
+				OMAPDSS_SIG_ACTIVE_HIGH :
+				OMAPDSS_SIG_ACTIVE_LOW;
+	t->vsync_level = m->sync & FB_SYNC_VERT_HIGH_ACT ?
+				OMAPDSS_SIG_ACTIVE_HIGH :
+				OMAPDSS_SIG_ACTIVE_LOW;
+	t->pclk_edge = OMAPDSS_SIG_ACTIVE_HIGH;
+	t->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+	t->hsync_vsync_edge = OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES;
 }
 
 static int omapfb_find_best_mode(struct omap_dss_device *display,
-- 
1.7.9.5

