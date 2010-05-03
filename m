From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Date: Mon, 03 May 2010 06:18:25 +0000
Subject: [PATCH v2 05/21] OMAP: DSS2: Taal: Remove platform enable/disable
Message-Id: <7a01973540a3afa79701ee08a3d8732db4687d5b.1272621452.git.ext-jani.1.nikula@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
 <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
 <db2b972d4fa08c2f5b3cd06392ef62415890a188.1272621452.git.ext-jani.1.nikula@nokia.com>
 <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <b57a3f4ccf68e8c8faf332a25b699b92a5604509.1272621452.git.ext-jani.1.nikula@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

After the addition of proper hardware reset, taal_hw_reset(), there's no
need for an additional platform enable/disable. Remove them.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 2a48ade..3729ec2 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -670,12 +670,6 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 	u8 id1, id2, id3;
 	int r;
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			return r;
-	}
-
 	/* it seems we have to wait a bit until taal is ready */
 	msleep(5);
 
@@ -746,8 +740,6 @@ err:
 	omapdss_dsi_display_disable(dssdev);
 err0:
 	dsi_bus_unlock();
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
 
 	return r;
 }
@@ -776,9 +768,6 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 
 	omapdss_dsi_display_disable(dssdev);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
 	td->enabled = 0;
 
 	dsi_bus_unlock();
-- 
1.6.5.2

