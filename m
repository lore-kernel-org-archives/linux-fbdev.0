From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 15 Nov 2011 12:14:23 +0000
Subject: [PATCH] video:da8xx-fb: Disable and reset sequence on version2 of LCDC
Message-Id: <1321358543-23124-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Patch follows the disable and software reset sequence specified
in version2 to LCDC functional specification.
Without this flicker is observed on re-enabling the LCDC.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 drivers/video/da8xx-fb.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index e111971..6b27751 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -118,6 +118,7 @@
 /* Clock registers available only on Version 2 */
 #define  LCD_CLK_ENABLE_REG			0x6c
 #define  LCD_CLK_RESET_REG			0x70
+#define  LCD_CLK_MAIN_RESET			BIT(3)
 
 #define LCD_NUM_BUFFERS	2
 
@@ -246,6 +247,10 @@ static inline void lcd_enable_raster(void)
 {
 	u32 reg;
 
+	/* Bring LCDC out of reset */
+	if (lcd_revision = LCD_VERSION_2)
+		lcdc_write(0, LCD_CLK_RESET_REG);
+
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (!(reg & LCD_RASTER_ENABLE))
 		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
@@ -259,6 +264,10 @@ static inline void lcd_disable_raster(void)
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (reg & LCD_RASTER_ENABLE)
 		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+
+	if (lcd_revision = LCD_VERSION_2)
+		/* Write 1 to reset LCDC */
+		lcdc_write(LCD_CLK_MAIN_RESET, LCD_CLK_RESET_REG);
 }
 
 static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
@@ -618,8 +627,12 @@ static void lcd_reset(struct da8xx_fb_par *par)
 	lcdc_write(0, LCD_DMA_CTRL_REG);
 	lcdc_write(0, LCD_RASTER_CTRL_REG);
 
-	if (lcd_revision = LCD_VERSION_2)
+	if (lcd_revision = LCD_VERSION_2) {
 		lcdc_write(0, LCD_INT_ENABLE_SET_REG);
+		/* Write 1 to reset */
+		lcdc_write(LCD_CLK_MAIN_RESET, LCD_CLK_RESET_REG);
+		lcdc_write(0, LCD_CLK_RESET_REG);
+	}
 }
 
 static void lcd_calc_clk_divider(struct da8xx_fb_par *par)
-- 
1.7.1

