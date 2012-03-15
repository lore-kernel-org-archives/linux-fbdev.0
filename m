From: Grazvydas Ignotas <notasas@gmail.com>
Date: Thu, 15 Mar 2012 18:00:24 +0000
Subject: [PATCH 2/2] OMAPDSS: TPO-TD03MTEA1: add set/check timing functions
Message-Id: <1331834424-485-2-git-send-email-notasas@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331834424-485-1-git-send-email-notasas@gmail.com>
In-Reply-To: <1331834424-485-1-git-send-email-notasas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grazvydas Ignotas <notasas@gmail.com>

On pandora we use .set_timings to alter refresh rate,
so add .check_timings/.set_timings functions.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index bb3da0b..be89801 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -477,6 +477,18 @@ static void tpo_td043_remove(struct omap_dss_device *dssdev)
 		gpio_free(nreset_gpio);
 }
 
+static void tpo_td043_set_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	dpi_set_timings(dssdev, timings);
+}
+
+static int tpo_td043_check_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	return dpi_check_timings(dssdev, timings);
+}
+
 static struct omap_dss_driver tpo_td043_driver = {
 	.probe		= tpo_td043_probe,
 	.remove		= tpo_td043_remove,
@@ -488,6 +500,9 @@ static struct omap_dss_driver tpo_td043_driver = {
 	.set_mirror	= tpo_td043_set_hmirror,
 	.get_mirror	= tpo_td043_get_hmirror,
 
+	.set_timings	= tpo_td043_set_timings,
+	.check_timings	= tpo_td043_check_timings,
+
 	.driver         = {
 		.name	= "tpo_td043mtea1_panel",
 		.owner  = THIS_MODULE,
-- 
1.7.0.4

