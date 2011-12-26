From: Ilya Yanok <yanok@emcraft.com>
Date: Mon, 26 Dec 2011 22:56:41 +0000
Subject: [PATCH] OMAPDSS: add OrtusTech COM43H4M10XTC display support
Message-Id: <1324940201-16079-1-git-send-email-yanok@emcraft.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

dd data for the OrtusTech COM43H4M10XTC display to the
generic_dpi_panel driver.

CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 593f831..99669ae 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -317,6 +317,26 @@ static struct panel_config generic_dpi_panels[] = {
 					  OMAP_DSS_LCD_IHS,
 		.name			= "focaltech_etm070003dh6",
 	},
+	/* OrtusTech COM43H4M10XTC */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 8000,
+
+			.hsw		= 41,
+			.hfp		= 8,
+			.hbp		= 4,
+
+			.vsw		= 10,
+			.vfp		= 4,
+			.vbp		= 2,
+		},
+		.config			= OMAP_DSS_LCD_TFT,
+
+		.name			= "ortustech_com43h4m10xtc",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.6.4

