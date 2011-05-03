From: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Date: Tue, 03 May 2011 07:07:37 +0000
Subject: [PATCHv2 2/2] OMAP: DSS2: Support for Powertip PH480272T
Message-Id: <1304406457-5109-3-git-send-email-eballetbo@iseebcn.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
In-Reply-To: <1304406457-5109-1-git-send-email-eballetbo@iseebcn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add support for Powertip PH480242T, a LCD 4.3inch (480x242) display
type with 24-bit RGB interface, to panel-generic-dpi.

Tested with IGEP v2 board.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 644d370..416e645 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -206,6 +206,31 @@ static struct panel_config generic_dpi_panels[] = {
 		.power_off_delay	= 0,
 		.name			= "seiko_70wvw1tz3",
 	},
+
+	/* Powertip PH480272T */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 9000,
+
+			.hsw		= 40,
+			.hfp		= 2,
+			.hbp		= 2,
+
+			.vsw		= 10,
+			.vfp		= 2,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					  OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "powertip_ph480272t",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.0.4

