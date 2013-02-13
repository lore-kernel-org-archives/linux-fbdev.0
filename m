From: Archit Taneja <archit@ti.com>
Date: Wed, 13 Feb 2013 14:19:13 +0000
Subject: [PATCH 10/11] OMAPDSS: panel acx565akm: remove omap_dss_device maximum backlight level usage
Message-Id: <1360764434-18788-11-git-send-email-archit@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The omap_dss_device structs's max_backlight_level is used to pass maximum
backlight level for the platform. However, no board file using this panel
populates this field. Therefore, we remove it's usage from the panel driver.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index a980a11..a8fb26b 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -555,10 +555,7 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 		md->cabc_mode = get_hw_cabc_mode(md);
 	}
 
-	if (md->has_bc)
-		max_brightness = 255;
-	else
-		max_brightness = dssdev->max_backlight_level;
+	max_brightness = 255;
 
 	if (md->has_bc)
 		brightness = acx565akm_get_actual_brightness(md);
-- 
1.7.9.5

