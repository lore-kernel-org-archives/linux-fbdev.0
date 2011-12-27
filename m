From: Archit Taneja <archit@ti.com>
Date: Tue, 27 Dec 2011 12:49:07 +0000
Subject: [RFC PATCH 24/29] OMAPDSS: Writeback: Use panel driver ops to configure mirroring rotation and buffe
Message-Id: <1324989432-3625-25-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add rotation and mirroring ops to writeback panel driver. Use these ops to
get/set wb info.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/writeback.c |   79 +++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 82d601c..215958e 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -287,9 +287,83 @@ static int writeback_panel_resume(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+static int writeback_panel_rotate(struct omap_dss_device *dssdev, u8 rotate)
+{
+	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	info.rotation = rotate;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set rotation %d\n", rotate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static u8 writeback_panel_get_rotate(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	return info.rotation;
+}
+
+static int writeback_panel_mirror(struct omap_dss_device *dssdev, bool mirror)
+{
+	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	info.mirror = mirror;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set mirror %d\n", mirror);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static bool writeback_panel_get_mirror(struct omap_dss_device *dssdev)
+{
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	return info.mirror;
+}
+
 static void writeback_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
+	struct omap_dss_writeback_info info;
+
+	wb->get_wb_info(wb, &info);
+
+	info.buf_width = timings->x_res;
+	info.buf_height = timings->y_res;
+
+	r = wb->set_wb_info(wb, &info);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to set timings %d, %d\n",
+			timings->x_res, timings->y_res);
+		return;
+	}
+
 	dssdev->panel.timings.x_res = timings->x_res;
 	dssdev->panel.timings.y_res = timings->y_res;
 }
@@ -315,6 +389,11 @@ static struct omap_dss_driver writeback_panel_driver = {
 	.suspend = writeback_panel_suspend,
 	.resume = writeback_panel_resume,
 
+	.set_rotate = writeback_panel_rotate,
+	.get_rotate = writeback_panel_get_rotate,
+	.set_mirror = writeback_panel_mirror,
+	.get_mirror = writeback_panel_get_mirror,
+
 	.set_timings = writeback_panel_set_timings,
 	.get_timings = writeback_panel_get_timings,
 	.check_timings = writeback_panel_check_timings,
-- 
1.7.4.1

