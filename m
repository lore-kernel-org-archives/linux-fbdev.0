From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Jun 2011 08:45:25 +0000
Subject: [PATCH 3/4] OMAP: DSS2: DSI: sync when disabling a display
Message-Id: <1308732326-17278-4-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When the panel driver calls omapdss_dsi_display_disable() it is possible
that there are still some unsent packets in the TX fifo.

Add dsi_sync_vc() calls in the beginning of
omapdss_dsi_display_disable() to make sure the TX fifos are empty.

This allows us to remove the msleep(10) hack from panel-taal.c

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    5 +----
 drivers/video/omap2/dss/dsi.c             |    5 +++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 4cb0449..4e888ac 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1247,11 +1247,8 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 	int r;
 
 	r = taal_dcs_write_0(td, DCS_DISPLAY_OFF);
-	if (!r) {
+	if (!r)
 		r = taal_sleep_in(td);
-		/* HACK: wait a bit so that the message goes through */
-		msleep(10);
-	}
 
 	if (r) {
 		dev_err(&dssdev->dev,
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b6a57bb..62b11c5 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4263,6 +4263,11 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 
 	mutex_lock(&dsi->lock);
 
+	dsi_sync_vc(dsidev, 0);
+	dsi_sync_vc(dsidev, 1);
+	dsi_sync_vc(dsidev, 2);
+	dsi_sync_vc(dsidev, 3);
+
 	dsi_display_uninit_dispc(dssdev);
 
 	dsi_display_uninit_dsi(dssdev, disconnect_lanes, enter_ulps);
-- 
1.7.4.1

