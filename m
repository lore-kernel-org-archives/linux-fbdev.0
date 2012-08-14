From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 14 Aug 2012 13:35:25 +0000
Subject: [PATCH v3] da8xx-fb: allow frame to complete after disabling LCDC
Message-Id: <1344950605-18945-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Wait for active frame transfer to complete after disabling LCDC.
At the same this wait is not be required when there are sync and
underflow errors.
More information on disable and reset sequence can be found in
section 13.4.6 of AM335x TRM @www.ti.com/am335x.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Applies on top of fbdev-next of Florian Tobias Schandinat's tree.
Since v2:
Optimized the lcd_disable_raster function.
Since v1:
Changed the commit message, also added link to hardware specification.

 drivers/video/da8xx-fb.c |   49 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7ae9d53..cb696ff 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -48,6 +48,7 @@
 #define LCD_PL_LOAD_DONE		BIT(6)
 #define LCD_FIFO_UNDERFLOW		BIT(5)
 #define LCD_SYNC_LOST			BIT(2)
+#define LCD_FRAME_DONE			BIT(0)
 
 /* LCD DMA Control Register */
 #define LCD_DMA_BURST_SIZE(x)		((x) << 4)
@@ -288,13 +289,41 @@ static inline void lcd_enable_raster(void)
 }
 
 /* Disable the Raster Engine of the LCD Controller */
-static inline void lcd_disable_raster(void)
+static inline void lcd_disable_raster(bool wait_for_frame_done)
 {
 	u32 reg;
+	u32 stat_reg = LCD_STAT_REG;
+	u32 loop_cnt = 0;
 
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (reg & LCD_RASTER_ENABLE)
 		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+
+	if (lcd_revision = LCD_VERSION_2)
+		stat_reg = LCD_RAW_STAT_REG;
+
+	if (wait_for_frame_done) {
+		/*
+		 * 50 milli seconds should be sufficient for a frame to
+		 * complete
+		 */
+		loop_cnt = 50;
+		while (!(lcdc_read(stat_reg) & LCD_FRAME_DONE)) {
+			/* Handle timeout */
+			if (unlikely(0 = --loop_cnt)) {
+				pr_err("LCD Controller timed out\n");
+				break;
+			}
+			mdelay(1);
+		}
+	}
+
+	/* clear asserted interrupts */
+	reg = lcdc_read(stat_reg);
+	if (lcd_revision = LCD_VERSION_1)
+		lcdc_write(reg, LCD_STAT_REG);
+	else
+		lcdc_write(reg, LCD_MASKED_STAT_REG);
 }
 
 static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
@@ -638,7 +667,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 static void lcd_reset(struct da8xx_fb_par *par)
 {
 	/* Disable the Raster if previously Enabled */
-	lcd_disable_raster();
+	lcd_disable_raster(false);
 
 	/* DMA has to be disabled */
 	lcdc_write(0, LCD_DMA_CTRL_REG);
@@ -734,7 +763,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 	u32 stat = lcdc_read(LCD_MASKED_STAT_REG);
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -744,7 +773,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 
@@ -789,7 +818,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 	u32 reg_ras;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 		lcdc_write(stat, LCD_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -799,7 +828,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 
 		lcdc_write(stat, LCD_STAT_REG);
 
@@ -898,7 +927,7 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 	if (val = CPUFREQ_POSTCHANGE) {
 		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
 			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
-			lcd_disable_raster();
+			lcd_disable_raster(true);
 			lcd_calc_clk_divider(par);
 			lcd_enable_raster();
 		}
@@ -935,7 +964,7 @@ static int __devexit fb_remove(struct platform_device *dev)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster();
+		lcd_disable_raster(true);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
 
 		/* disable DMA  */
@@ -1051,7 +1080,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster();
+		lcd_disable_raster(true);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1411,7 +1440,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
 		par->panel_power_ctrl(0);
 
 	fb_set_suspend(info, 1);
-	lcd_disable_raster();
+	lcd_disable_raster(true);
 	clk_disable(par->lcdc_clk);
 	console_unlock();
 
-- 
1.7.1

