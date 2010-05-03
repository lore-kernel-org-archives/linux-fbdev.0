From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Date: Mon, 03 May 2010 06:18:22 +0000
Subject: [PATCH v2 02/21] OMAP: DSS2: Taal: add locks to taal_bl_update_status
Message-Id: <c95257e8042f471c55a38133020d1d63e22161f3.1272621452.git.ext-jani.1.nikula@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1272621452.git.ext-jani.1.nikula@nokia.com>
 <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <1ef57e99d69aaf89b8e61074aa8ce2e5f6632d28.1272621452.git.ext-jani.1.nikula@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Valkeinen Tomi (Nokia-D/Helsinki) <Tomi.Valkeinen@nokia.com>

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>

taal_bl_update_status was missing locks to protect taal_data. This caused
a kernel crash randomly, as the code attempted to set the brightness while
the OMAP's DSI block was actually disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/panel-taal.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 43fce5f..5f5afba 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -290,24 +290,26 @@ static int taal_bl_update_status(struct backlight_device *dev)
 
 	dev_dbg(&dssdev->dev, "update brightness to %d\n", level);
 
+	mutex_lock(&td->lock);
+
 	if (td->use_dsi_bl) {
 		if (td->enabled) {
 			dsi_bus_lock();
 			r = taal_dcs_write_1(DCS_BRIGHTNESS, level);
 			dsi_bus_unlock();
-			if (r)
-				return r;
+		} else {
+			r = 0;
 		}
 	} else {
 		if (!dssdev->set_backlight)
-			return -EINVAL;
-
-		r = dssdev->set_backlight(dssdev, level);
-		if (r)
-			return r;
+			r = -EINVAL;
+		else
+			r = dssdev->set_backlight(dssdev, level);
 	}
 
-	return 0;
+	mutex_unlock(&td->lock);
+
+	return r;
 }
 
 static int taal_bl_get_intensity(struct backlight_device *dev)
-- 
1.6.5.2

