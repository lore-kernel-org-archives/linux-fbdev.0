From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 20 Jul 2012 16:03:11 +0000
Subject: [PATCH] video: da8xx-fb: do clock reset of revision 2 LCDC before enabling
Message-Id: <1342799471-10729-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As in specification software reset should be applied for several
cycles before bringing it out of reset. Without this patch
particularly during suspend and resume clock reset is not guaranteed
to happen.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 drivers/video/da8xx-fb.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 3d2d0d1..4440292 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -262,10 +262,18 @@ static inline void lcd_enable_raster(void)
 {
 	u32 reg;
 
+	/* Put LCDC in reset for several cycles */
+	if (lcd_revision = LCD_VERSION_2)
+		/* Write 1 to reset LCDC */
+		lcdc_write(LCD_CLK_MAIN_RESET, LCD_CLK_RESET_REG);
+	mdelay(1);
+
 	/* Bring LCDC out of reset */
 	if (lcd_revision = LCD_VERSION_2)
 		lcdc_write(0, LCD_CLK_RESET_REG);
+	mdelay(1);
 
+	/* Above reset sequence doesnot reset register context */
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (!(reg & LCD_RASTER_ENABLE))
 		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
@@ -279,10 +287,6 @@ static inline void lcd_disable_raster(void)
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (reg & LCD_RASTER_ENABLE)
 		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
-
-	if (lcd_revision = LCD_VERSION_2)
-		/* Write 1 to reset LCDC */
-		lcdc_write(LCD_CLK_MAIN_RESET, LCD_CLK_RESET_REG);
 }
 
 static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
-- 
1.7.1

