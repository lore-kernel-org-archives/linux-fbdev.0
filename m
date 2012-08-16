From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:42 +0000
Subject: [PATCH 07/19] fbdev: sh_mipi_dsi: Use the sh_mipi_dsi_info channel field
Message-Id: <1345122054-16013-8-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Get the LCDC channel selector from the sh_mipi_dsi_info channel field
directly instead of accessing the LCDC platform data through the
lcd_chan field.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mipi_dsi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 3951fda..7f6ce65 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -369,7 +369,7 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 	/* setup LCD panel */
 
 	/* cf. drivers/video/omap/lcd_mipid.c */
-	sh_mipi_dcs(ch->chan, MIPI_DCS_EXIT_SLEEP_MODE);
+	sh_mipi_dcs(pdata->channel, MIPI_DCS_EXIT_SLEEP_MODE);
 	msleep(120);
 	/*
 	 * [7] - Page Address Mode
@@ -381,11 +381,11 @@ static int sh_mipi_setup(struct sh_mipi *mipi, struct sh_mipi_dsi_info *pdata)
 	 * [1] - Flip Horizontal
 	 * [0] - Flip Vertical
 	 */
-	sh_mipi_dcs_param(ch->chan, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
+	sh_mipi_dcs_param(pdata->channel, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
 	/* cf. set_data_lines() */
-	sh_mipi_dcs_param(ch->chan, MIPI_DCS_SET_PIXEL_FORMAT,
+	sh_mipi_dcs_param(pdata->channel, MIPI_DCS_SET_PIXEL_FORMAT,
 			  pixfmt << 4);
-	sh_mipi_dcs(ch->chan, MIPI_DCS_SET_DISPLAY_ON);
+	sh_mipi_dcs(pdata->channel, MIPI_DCS_SET_DISPLAY_ON);
 
 	/* Enable timeout counters */
 	iowrite32(0x00000f00, base + DSICTRL);
-- 
1.7.8.6

