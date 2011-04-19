From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 19 Apr 2011 09:22:20 +0000
Subject: [PATCH 17/19] OMAP: DSS2: Taal: Separate panel reset
Message-Id: <1303204942-25450-18-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate panel reset code to a function of its own. This will keep the
code cleaner in the future when panel reset is called from multiple
locations.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 3192dd7..2f7a223 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1018,6 +1018,15 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	td->enabled = 0;
 }
 
+static int taal_panel_reset(struct omap_dss_device *dssdev)
+{
+	dev_err(&dssdev->dev, "performing LCD reset\n");
+
+	taal_power_off(dssdev);
+	taal_hw_reset(dssdev);
+	return taal_power_on(dssdev);
+}
+
 static int taal_enable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
@@ -1582,9 +1591,7 @@ static void taal_esd_work(struct work_struct *work)
 err:
 	dev_err(&dssdev->dev, "performing LCD reset\n");
 
-	taal_power_off(dssdev);
-	taal_hw_reset(dssdev);
-	taal_power_on(dssdev);
+	taal_panel_reset(dssdev);
 
 	dsi_bus_unlock();
 
-- 
1.7.1

