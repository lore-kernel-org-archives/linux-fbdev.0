From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 18 Jul 2012 15:33:11 +0000
Subject: [PATCH RESEND] video: da8xx-fb rev2: fix disabling of palette completion interrupt
Message-Id: <1342624871-5947-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Writing '1' to particular bit of IRQENABLE_CLEAR register disables the
corresponding interrupt on revision 2 LCDC. This register was wrongly
configured to disable all previous enabled interrupts instead of
disabling only palette completion interrupt. Patch fixes it by clearing
only palette completion interrupt bit.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Resending as my earlier patch seems like not reached fbdev mailing list.

 drivers/video/da8xx-fb.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 47118c7..88e98ea 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -715,7 +715,6 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 {
 	struct da8xx_fb_par *par = arg;
 	u32 stat = lcdc_read(LCD_MASKED_STAT_REG);
-	u32 reg_int;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
 		lcd_disable_raster();
@@ -732,10 +731,8 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 
-		/* Disable PL completion inerrupt */
-		reg_int = lcdc_read(LCD_INT_ENABLE_CLR_REG) |
-		       (LCD_V2_PL_INT_ENA);
-		lcdc_write(reg_int, LCD_INT_ENABLE_CLR_REG);
+		/* Disable PL completion interrupt */
+		lcdc_write(LCD_V2_PL_INT_ENA, LCD_INT_ENABLE_CLR_REG);
 
 		/* Setup and start data loading mode */
 		lcd_blit(LOAD_DATA, par);
-- 
1.7.1

