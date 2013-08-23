From: Darren Etheridge <detheridge@ti.com>
Date: Fri, 23 Aug 2013 21:52:52 +0000
Subject: [PATCH 3/4] video: da8xx-fb: support lcdc v2 timing register expansion
Message-Id: <1377294773-25678-4-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

TI LCD controller version 2 adds some extra bits in a register to
increase the available size to represent horizontal timings. This
patch allows the fbdev driver to utilize those extra bits.
This will become important for driving an HDMI encoder from the lcd
controller where some of the VESA/CEA modes require quite large porches.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index b131a6c..278b7d7 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -412,6 +412,21 @@ static void lcd_cfg_horizontal_sync(int back_porch, int pulse_width,
 	    | (((front_porch-1) & 0xff) << 16)
 	    | (((pulse_width-1) & 0x3f) << 10);
 	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);
+
+	/*
+	 * LCDC Version 2 adds some extra bits that increase the allowable
+	 * size of the horizontal timing registers.
+	 * remember that the registers use 0 to represent 1 so all values
+	 * that get set into register need to be decremented by 1
+	 */
+	if(lcd_revision = LCD_VERSION_2) {
+		/* Mask off the bits we want to change */
+		reg = lcdc_read(LCD_RASTER_TIMING_2_REG) & ~0x780000ff;
+		reg |= ((front_porch-1) & 0x300) >> 8;
+		reg |= ((back_porch-1) & 0x300) >> 4;
+		reg |= ((pulse_width-1) & 0x3c0) << 21;
+		lcdc_write(reg, LCD_RASTER_TIMING_2_REG);
+	}
 }
 
 static void lcd_cfg_vertical_sync(int back_porch, int pulse_width,
-- 
1.7.0.4

