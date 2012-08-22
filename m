From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 22 Aug 2012 06:10:23 +0000
Subject: [PATCH v4] da8xx-fb: allow frame to complete after disabling LCDC
Message-Id: <1345615103-32009-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Wait for active frame transfer to complete after disabling LCDC.
At the same this wait is not be required when there are sync and
underflow errors.
Patch applies for revision 2 of LCDC present am335x.
More information on disable and reset sequence can be found in
section 13.4.6 of AM335x TRM @www.ti.com/am335x.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Applies on top of fbdev-next of Florian Tobias Schandinat's tree.
Since v3:
Rely on frame done interrupt instead of polling for it.
Since v2:
Optimized the lcd_disable_raster function.
Since v1:
Changed the commit message, also added link to hardware specification.
 drivers/video/da8xx-fb.c |   53 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 7ae9d53..8fb497a 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
+#include <linux/wait.h>
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/console.h>
@@ -48,6 +49,7 @@
 #define LCD_PL_LOAD_DONE		BIT(6)
 #define LCD_FIFO_UNDERFLOW		BIT(5)
 #define LCD_SYNC_LOST			BIT(2)
+#define LCD_FRAME_DONE			BIT(0)
 
 /* LCD DMA Control Register */
 #define LCD_DMA_BURST_SIZE(x)		((x) << 4)
@@ -135,6 +137,8 @@ static resource_size_t da8xx_fb_reg_base;
 static struct resource *lcdc_regs;
 static unsigned int lcd_revision;
 static irq_handler_t lcdc_irq_handler;
+static wait_queue_head_t frame_done_wq;
+static int frame_done_flag;
 
 static inline unsigned int lcdc_read(unsigned int addr)
 {
@@ -288,13 +292,27 @@ static inline void lcd_enable_raster(void)
 }
 
 /* Disable the Raster Engine of the LCD Controller */
-static inline void lcd_disable_raster(void)
+static inline void lcd_disable_raster(bool wait_for_frame_done)
 {
 	u32 reg;
+	int ret;
 
 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
 	if (reg & LCD_RASTER_ENABLE)
 		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+	else
+		/* return if already disabled */
+		return;
+
+	if ((wait_for_frame_done = true) && (lcd_revision = LCD_VERSION_2)) {
+
+		frame_done_flag = 0;
+		ret = wait_event_interruptible_timeout(frame_done_wq,
+				frame_done_flag != 0,
+				msecs_to_jiffies(50));
+		if (ret = 0)
+			pr_err("LCD Controller timed out\n");
+	}
 }
 
 static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
@@ -321,7 +339,8 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
 		} else {
 			reg_int = lcdc_read(LCD_INT_ENABLE_SET_REG) |
 				LCD_V2_END_OF_FRAME0_INT_ENA |
-				LCD_V2_END_OF_FRAME1_INT_ENA;
+				LCD_V2_END_OF_FRAME1_INT_ENA |
+				LCD_FRAME_DONE;
 			lcdc_write(reg_int, LCD_INT_ENABLE_SET_REG);
 		}
 		reg_dma |= LCD_DUAL_FRAME_BUFFER_ENABLE;
@@ -638,7 +657,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 static void lcd_reset(struct da8xx_fb_par *par)
 {
 	/* Disable the Raster if previously Enabled */
-	lcd_disable_raster();
+	lcd_disable_raster(false);
 
 	/* DMA has to be disabled */
 	lcdc_write(0, LCD_DMA_CTRL_REG);
@@ -734,7 +753,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 	u32 stat = lcdc_read(LCD_MASKED_STAT_REG);
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -744,7 +763,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 
@@ -775,6 +794,14 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 			par->vsync_flag = 1;
 			wake_up_interruptible(&par->vsync_wait);
 		}
+
+		/* Set only when controller is disabled and at the end of
+		 * active frame
+		 */
+		if (stat & BIT(0)) {
+			frame_done_flag = 1;
+			wake_up_interruptible(&frame_done_wq);
+		}
 	}
 
 	lcdc_write(0, LCD_END_OF_INT_IND_REG);
@@ -789,7 +816,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 	u32 reg_ras;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 		lcdc_write(stat, LCD_STAT_REG);
 		lcd_enable_raster();
 	} else if (stat & LCD_PL_LOAD_DONE) {
@@ -799,7 +826,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 		 * interrupt via the following write to the status register. If
 		 * this is done after then one gets multiple PL done interrupts.
 		 */
-		lcd_disable_raster();
+		lcd_disable_raster(false);
 
 		lcdc_write(stat, LCD_STAT_REG);
 
@@ -898,7 +925,7 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 	if (val = CPUFREQ_POSTCHANGE) {
 		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
 			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
-			lcd_disable_raster();
+			lcd_disable_raster(true);
 			lcd_calc_clk_divider(par);
 			lcd_enable_raster();
 		}
@@ -935,7 +962,7 @@ static int __devexit fb_remove(struct platform_device *dev)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster();
+		lcd_disable_raster(true);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
 
 		/* disable DMA  */
@@ -1051,7 +1078,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
 
-		lcd_disable_raster();
+		lcd_disable_raster(true);
 		break;
 	default:
 		ret = -EINVAL;
@@ -1356,8 +1383,10 @@ static int __devinit fb_probe(struct platform_device *device)
 
 	if (lcd_revision = LCD_VERSION_1)
 		lcdc_irq_handler = lcdc_irq_handler_rev01;
-	else
+	else {
+		init_waitqueue_head(&frame_done_wq);
 		lcdc_irq_handler = lcdc_irq_handler_rev02;
+	}
 
 	ret = request_irq(par->irq, lcdc_irq_handler, 0,
 			DRIVER_NAME, par);
@@ -1411,7 +1440,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
 		par->panel_power_ctrl(0);
 
 	fb_set_suspend(info, 1);
-	lcd_disable_raster();
+	lcd_disable_raster(true);
 	clk_disable(par->lcdc_clk);
 	console_unlock();
 
-- 
1.7.1

