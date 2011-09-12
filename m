From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 12 Sep 2011 09:13:36 +0000
Subject: [PATCHv2 13/15] OMAP: DSS2: panel-generic-dpi: remove "generic" panel
Message-Id: <1315818818-18733-14-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove the "generic" panel config entry, which is not used.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   24 ----------------------
 1 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index b401304..e0399c3 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -58,30 +58,6 @@ struct panel_config {
 
 /* Panel configurations */
 static struct panel_config generic_dpi_panels[] = {
-	/* Generic Panel */
-	{
-		{
-			.x_res		= 640,
-			.y_res		= 480,
-
-			.pixel_clock	= 23500,
-
-			.hfp		= 48,
-			.hsw		= 32,
-			.hbp		= 80,
-
-			.vfp		= 3,
-			.vsw		= 4,
-			.vbp		= 7,
-		},
-		.acbi			= 0x0,
-		.acb			= 0x0,
-		.config			= OMAP_DSS_LCD_TFT,
-		.power_on_delay		= 0,
-		.power_off_delay	= 0,
-		.name			= "generic",
-	},
-
 	/* Sharp LQ043T1DG01 */
 	{
 		{
-- 
1.7.4.1

