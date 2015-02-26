From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Feb 2015 12:48:58 +0000
Subject: [PATCH 04/15] OMAPDSS: TFP410: fix input sync signals
Message-Id: <1424954949-12801-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1424954949-12801-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

TFP410 requires that DE is active high and the data and syncs are driven
on rising pixel clock edge. However, at the moment the driver doesn't
request such syncs, and the end result is that the sync settings depend
on default values, which are not right in all cases.

Set the sync values explicitly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
index 92919a74e715..d9048b3df495 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tfp410.c
@@ -114,12 +114,21 @@ static void tfp410_disable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 }
 
+static void tfp410_fix_timings(struct omap_video_timings *timings)
+{
+	timings->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	timings->sync_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
+	timings->de_level = OMAPDSS_SIG_ACTIVE_HIGH;
+}
+
 static void tfp410_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
+	tfp410_fix_timings(timings);
+
 	ddata->timings = *timings;
 	dssdev->panel.timings = *timings;
 
@@ -140,6 +149,8 @@ static int tfp410_check_timings(struct omap_dss_device *dssdev,
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
+	tfp410_fix_timings(timings);
+
 	return in->ops.dpi->check_timings(in, timings);
 }
 
-- 
2.3.0

