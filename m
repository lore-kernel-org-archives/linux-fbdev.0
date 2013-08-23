From: Darren Etheridge <detheridge@ti.com>
Date: Fri, 23 Aug 2013 21:52:51 +0000
Subject: [PATCH 2/4] video: da8xx-fb: fixing timing off by one errors
Message-Id: <1377294773-25678-3-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The LCD controller represents some of the timing fields with a 0
in the register representing 1.  This was not taken into account
when these registers were being set.  Interestingly enough not
all of the LCDC controller timing registers implement this representation
so carefully went through the technical reference manual to only "fix"
the correct timings.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 0333a0b..b131a6c 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -408,9 +408,9 @@ static void lcd_cfg_horizontal_sync(int back_porch, int pulse_width,
 	u32 reg;
 
 	reg = lcdc_read(LCD_RASTER_TIMING_0_REG) & 0xf;
-	reg |= ((back_porch & 0xff) << 24)
-	    | ((front_porch & 0xff) << 16)
-	    | ((pulse_width & 0x3f) << 10);
+	reg |= (((back_porch-1) & 0xff) << 24)
+	    | (((front_porch-1) & 0xff) << 16)
+	    | (((pulse_width-1) & 0x3f) << 10);
 	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);
 }
 
@@ -422,7 +422,7 @@ static void lcd_cfg_vertical_sync(int back_porch, int pulse_width,
 	reg = lcdc_read(LCD_RASTER_TIMING_1_REG) & 0x3ff;
 	reg |= ((back_porch & 0xff) << 24)
 	    | ((front_porch & 0xff) << 16)
-	    | ((pulse_width & 0x3f) << 10);
+	    | (((pulse_width-1) & 0x3f) << 10);
 	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
 }
 
-- 
1.7.0.4

