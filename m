From: Archit Taneja <archit@ti.com>
Date: Thu, 09 Aug 2012 11:56:35 +0000
Subject: [PATCH v2 09/13] OMAPDSS: SDI: Create a function to set timings
Message-Id: <1344512989-4071-10-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
 <1344512989-4071-1-git-send-email-archit@ti.com>
In-Reply-To: <1344512989-4071-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Create function omapdss_sdi_set_timings(). Configuring new timings is done the
same way as before, SDI is disabled, and re-enabled with the new timings in
dssdev. This just moves the code from the panel drivers to the SDI driver.

The panel drivers shouldn't be aware of how SDI manages to configure a new set
of timings. This should be taken care of by the SDI driver itself.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |   13 +------------
 drivers/video/omap2/dss/sdi.c                  |   17 +++++++++++++++++
 include/video/omapdss.h                        |    2 ++
 3 files changed, 20 insertions(+), 12 deletions(-)

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
index 5d31699..0474962 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -146,6 +146,23 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
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
+		omapdss_sdi_display_disable(dssdev);
+
+		r = omapdss_sdi_display_enable(dssdev);
+		if (r)
+			DSSERR("failed to set new timings\n");
+	}
+}
+EXPORT_SYMBOL(omapdss_sdi_set_timings);
+
 static int __init sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a85b3fb..c5c013e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -761,6 +761,8 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
+void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings);
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
-- 
1.7.9.5

