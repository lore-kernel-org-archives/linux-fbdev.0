From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 30 Jul 2013 18:26:18 +0000
Subject: [PATCH v2 11/24] video: da8xx-fb: improve readability of code
Message-Id: <1375208791-15781-12-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Change the lcd_disable_raster funtion from using a bool to an enum
as the function is very confusing with the current api.  This helps
make it clearer what the parameter is really doing.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |   24 ++++++++++++------------
 include/video/da8xx-fb.h |    5 +++++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index b25b810..3c12861 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -271,7 +271,7 @@ static inline void lcd_enable_raster(void)
 }
 
 /* Disable the Raster Engine of the LCD Controller */
-static inline void lcd_disable_raster(bool wait_for_frame_done)
+static inline void lcd_disable_raster(enum da8xx_frame_complete wait_for_frame_done)
 {
 	u32 reg;
 	int ret;
@@ -283,7 +283,7 @@ static inline void lcd_disable_raster(bool wait_for_frame_done)
 		/* return if already disabled */
 		return;
 
-	if ((wait_for_frame_done = true) && (lcd_revision = LCD_VERSION_2)) {
+	if ((wait_for_frame_done = DA8XX_FRAME_WAIT) && (lcd_revision = LCD_VERSION_2)) {
 		frame_done_flag = 0;
 		ret = wait_event_interruptible_timeout(frame_done_wq,
 				frame_done_flag != 0,
@@ -771,7 +771,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 	u32 stat = lcdc_read(LCD_MASKED_STAT_REG);
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		lcd_disable_raster(false);
+		lcd_disable_raster(DA8XX_FRAME_NOWAIT);
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -781,7 +781,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster(false);
+		lcd_disable_raster(DA8XX_FRAME_NOWAIT);
 
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 
@@ -834,7 +834,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 	u32 reg_ras;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		lcd_disable_raster(false);
+		lcd_disable_raster(DA8XX_FRAME_NOWAIT);
 		lcdc_write(stat, LCD_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -844,7 +844,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster(false);
+		lcd_disable_raster(DA8XX_FRAME_NOWAIT);
 
 		lcdc_write(stat, LCD_STAT_REG);
 
@@ -986,7 +986,7 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 	if (val = CPUFREQ_POSTCHANGE) {
 		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
 			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
-			lcd_disable_raster(true);
+			lcd_disable_raster(DA8XX_FRAME_WAIT);
 			da8xx_fb_calc_config_clk_divider(par, &par->mode);
 			if (par->blank = FB_BLANK_UNBLANK)
 				lcd_enable_raster();
@@ -1024,7 +1024,7 @@ static int fb_remove(struct platform_device *dev)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster(true);
+		lcd_disable_raster(DA8XX_FRAME_WAIT);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
 
 		/* disable DMA  */
@@ -1140,7 +1140,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster(true);
+		lcd_disable_raster(DA8XX_FRAME_WAIT);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1208,9 +1208,9 @@ static int da8xxfb_set_par(struct fb_info *info)
 	bool raster = da8xx_fb_is_raster_enabled();
 
 	if (raster)
-		lcd_disable_raster(true);
+		lcd_disable_raster(DA8XX_FRAME_WAIT);
 	else
-		lcd_disable_raster(false);
+		lcd_disable_raster(DA8XX_FRAME_NOWAIT);
 
 	fb_var_to_videomode(&par->mode, &info->var);
 
@@ -1571,7 +1571,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
 		par->panel_power_ctrl(0);
 
 	fb_set_suspend(info, 1);
-	lcd_disable_raster(true);
+	lcd_disable_raster(DA8XX_FRAME_WAIT);
 	lcd_context_save();
 	pm_runtime_put_sync(&dev->dev);
 	console_unlock();
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index f888259..efed3c3 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -23,6 +23,11 @@ enum raster_load_mode {
 	LOAD_PALETTE,
 };
 
+enum da8xx_frame_complete {
+	DA8XX_FRAME_WAIT,
+	DA8XX_FRAME_NOWAIT,
+};
+
 struct da8xx_lcdc_platform_data {
 	const char manu_name[10];
 	void *controller_data;
-- 
1.7.0.4

