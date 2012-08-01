From: Archit Taneja <archit@ti.com>
Date: Wed, 01 Aug 2012 10:43:24 +0000
Subject: [RFC 13/17] OMAPDSS: SDI: Create a function to set timings
Message-Id: <1343817088-29645-14-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
In-Reply-To: <1343817088-29645-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com, Archit Taneja <archit@ti.com>

Create function omapdss_sdi_set_timings(), this can be used by a SDI panel
driver without disabling/enabling the SDI interface. This is similar to the
set_timings op of the DPI interface driver. It calls sdi_set_mode() which only
configures the DISPC timings and DSS/DISPC clock dividers.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |   13 +------------
 drivers/video/omap2/dss/sdi.c                  |   19 +++++++++++++++++++
 include/video/omapdss.h                        |    2 ++
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index eaeed43..11bdc88 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -731,18 +731,7 @@ static int acx_panel_resume(struct omap_dss_device *dssdev)
 static void acx_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	int r;
-
-	if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE)
-		omapdss_sdi_display_disable(dssdev);
-
-	dssdev->panel.timings = *timings;
-
-	if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE) {
-		r = omapdss_sdi_display_enable(dssdev);
-		if (r)
-			dev_err(&dssdev->dev, "%s enable failed\n", __func__);
-	}
+	omapdss_sdi_set_timings(dssdev, timings);
 }
 
 static int acx_panel_check_timings(struct omap_dss_device *dssdev,
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index f2d3f45..d88243f 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -155,6 +155,25 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
+void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	int r;
+
+	dssdev->panel.timings = *timings;
+
+	if (dssdev->state = OMAP_DSS_DISPLAY_ACTIVE) {
+		r = dispc_runtime_get();
+		if (r)
+			return;
+
+		sdi_set_mode(dssdev);
+
+		dispc_runtime_put();
+	}
+}
+EXPORT_SYMBOL(omapdss_sdi_set_timings);
+
 static int __init sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a2cd133..54ba639 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -760,6 +760,8 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
+void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
-- 
1.7.9.5

