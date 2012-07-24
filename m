From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 24 Jul 2012 04:21:44 +0000
Subject: [PATCH v2] da8xx-fb: allow frame to complete after disabling LCDC
Message-Id: <1343102984-6056-1-git-send-email-prakash.pm@ti.com>
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
Patch applies on top of below patch under review:
http://marc.info/?l=linux-fbdev&m4280060828708&w=2
"video: da8xx-fb: do clock reset of revision 2 LCDC before enabling"
Since v1:
Changed the commit message, also added link to hardware specification.

 drivers/video/da8xx-fb.c |   48 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index a908dfd..0fb4d7d 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -31,6 +31,7 @@
 #include <linux/cpufreq.h>
 #include <linux/console.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <video/da8xx-fb.h>
 #include <asm/div64.h>
 
@@ -45,6 +46,7 @@
 #define LCD_PL_LOAD_DONE		BIT(6)
 #define LCD_FIFO_UNDERFLOW		BIT(5)
 #define LCD_SYNC_LOST			BIT(2)
+#define LCD_FRAME_DONE			BIT(0)
 
 /* LCD DMA Control Register */
 #define LCD_DMA_BURST_SIZE(x)		((x) << 4)
@@ -279,13 +281,39 @@ static inline void lcd_enable_raster(void)
 }
 
 /* Disable the Raster Engine of the LCD Controller */
-static inline void lcd_disable_raster(void)
+static inline void lcd_disable_raster(bool wait_for_frame_done)
 {
 	u32 reg;
+	u32 loop_cnt = 0;
+	u32 stat;
+	u32 i = 0;
+
+	/* 50 milli seconds should be sufficient for a frame to complete */
+	if (wait_for_frame_done)
+		loop_cnt = 50;
 
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (reg & LCD_RASTER_ENABLE)
 		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+
+	/* Wait for the current frame to complete */
+	do {
+		if (lcd_revision = LCD_VERSION_1)
+			stat = lcdc_read(LCD_STAT_REG);
+		else
+			stat = lcdc_read(LCD_RAW_STAT_REG);
+		mdelay(1);
+	} while (!(stat & LCD_FRAME_DONE) && (i++ < loop_cnt));
+
+	if (lcd_revision = LCD_VERSION_1)
+		lcdc_write(stat, LCD_STAT_REG);
+	else
+		lcdc_write(stat, LCD_MASKED_STAT_REG);
+
+	if ((loop_cnt != 0) && (i >= loop_cnt)) {
+		pr_err("LCD Controller timed out\n");
+		return;
+	}
 }
 
 static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
@@ -626,7 +654,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 static void lcd_reset(struct da8xx_fb_par *par)
 {
 	/* Disable the Raster if previously Enabled */
-	lcd_disable_raster();
+	lcd_disable_raster(false);
 
 	/* DMA has to be disabled */
 	lcdc_write(0, LCD_DMA_CTRL_REG);
@@ -724,7 +752,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
 		pr_err("LCDC sync lost or underflow error occurred\n");
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -734,7 +762,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 
@@ -780,7 +808,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
 		pr_err("LCDC sync lost or underflow error occurred\n");
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 		lcdc_write(stat, LCD_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -790,7 +818,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 
 		lcdc_write(stat, LCD_STAT_REG);
 
@@ -887,7 +915,7 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 	if (val = CPUFREQ_POSTCHANGE) {
 		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
 			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
-			lcd_disable_raster();
+			lcd_disable_raster(true);
 			lcd_calc_clk_divider(par);
 			lcd_enable_raster();
 		}
@@ -924,7 +952,7 @@ static int __devexit fb_remove(struct platform_device *dev)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster();
+		lcd_disable_raster(true);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
 
 		/* disable DMA  */
@@ -1037,7 +1065,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster();
+		lcd_disable_raster(true);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1377,7 +1405,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
 		par->panel_power_ctrl(0);
 
 	fb_set_suspend(info, 1);
-	lcd_disable_raster();
+	lcd_disable_raster(true);
 	clk_disable(par->lcdc_clk);
 	console_unlock();
 
-- 
1.7.1

