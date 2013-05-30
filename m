From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 30 May 2013 09:36:02 +0000
Subject: [PATCH 09/27] drm/omap: DVI connector fix
Message-Id: <1369906580-27585-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1369906580-27585-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The omapdrm driver currently uses a string comparison to find out if the
display is a DVI display. This is not reliable, and as we now have a
specific display type for DVI, let's use that.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 4c0bc40..8949246 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -65,10 +65,8 @@ static int get_connector_type(struct omap_dss_device *dssdev)
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_HDMI:
 		return DRM_MODE_CONNECTOR_HDMIA;
-	case OMAP_DISPLAY_TYPE_DPI:
-		if (!strcmp(dssdev->name, "dvi"))
-			return DRM_MODE_CONNECTOR_DVID;
-		/* fallthrough */
+	case OMAP_DISPLAY_TYPE_DVI:
+		return DRM_MODE_CONNECTOR_DVID;
 	default:
 		return DRM_MODE_CONNECTOR_Unknown;
 	}
-- 
1.8.1.2

