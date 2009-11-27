From: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/4] davinci: fb: Updates the driver in preparation for
	addition of power management features
Date: Fri, 27 Nov 2009 12:13:13 +0530
Message-ID: <1259304193-19344-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org

Add a helper function to enable raster. Also add one member in the
private data structure to track the current blank status, another
function pointer which takes in the platform specific callback function
to control panel power.

These updates will help in adding suspend/resume and frame buffer blank
operation features.

Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   43 +++++++++++++++++++++++++++----------------
 include/video/da8xx-fb.h |    1 +
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 67550e6..b3c22e1 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -115,9 +115,11 @@ struct da8xx_fb_par {
 	unsigned int databuf_sz;
 	unsigned int palette_sz;
 	unsigned int pxl_clk;
+	int blank;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
+	void (*panel_power_ctrl)(int);
 };
 
 /* Variable Screen Information */
@@ -195,8 +197,18 @@ static struct da8xx_panel known_lcd_panels[] = {
 	},
 };
 
+/* Enable the Raster Engine of the LCD Controller */
+static inline void lcd_enable_raster(void)
+{
+	u32 reg;
+
+	reg = lcdc_read(LCD_RASTER_CTRL_REG);
+	if (!(reg & LCD_RASTER_ENABLE))
+		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+}
+
 /* Disable the Raster Engine of the LCD Controller */
-static void lcd_disable_raster(struct da8xx_fb_par *par)
+static inline void lcd_disable_raster(void)
 {
 	u32 reg;
 
@@ -448,8 +460,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
 static void lcd_reset(struct da8xx_fb_par *par)
 {
 	/* Disable the Raster if previously Enabled */
-	if (lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE)
-		lcd_disable_raster(par);
+	lcd_disable_raster();
 
 	/* DMA has to be disabled */
 	lcdc_write(0, LCD_DMA_CTRL_REG);
@@ -529,13 +540,11 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
 static irqreturn_t lcdc_irq_handler(int irq, void *arg)
 {
 	u32 stat = lcdc_read(LCD_STAT_REG);
-	u32 reg;
 
 	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
-		reg = lcdc_read(LCD_RASTER_CTRL_REG);
-		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+		lcd_disable_raster();
 		lcdc_write(stat, LCD_STAT_REG);
-		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+		lcd_enable_raster();
 	} else
 		lcdc_write(stat, LCD_STAT_REG);
 
@@ -595,16 +604,13 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 				     unsigned long val, void *data)
 {
 	struct da8xx_fb_par *par;
-	unsigned int reg;
 
 	par = container_of(nb, struct da8xx_fb_par, freq_transition);
 	if (val == CPUFREQ_PRECHANGE) {
-		reg = lcdc_read(LCD_RASTER_CTRL_REG);
-		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+		lcd_disable_raster();
 	} else if (val == CPUFREQ_POSTCHANGE) {
 		lcd_calc_clk_divider(par);
-		reg = lcdc_read(LCD_RASTER_CTRL_REG);
-		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+		lcd_enable_raster();
 	}
 
 	return 0;
@@ -635,8 +641,10 @@ static int __devexit fb_remove(struct platform_device *dev)
 #ifdef CONFIG_CPU_FREQ
 		lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE)
-			lcd_disable_raster(par);
+		if (par->panel_power_ctrl)
+			par->panel_power_ctrl(0);
+
+		lcd_disable_raster();
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
 
 		/* disable DMA  */
@@ -777,6 +785,10 @@ static int __init fb_probe(struct platform_device *device)
 	par = da8xx_fb_info->par;
 	par->lcdc_clk = fb_clk;
 	par->pxl_clk = lcdc_info->pxl_clk;
+	if (fb_pdata->panel_power_ctrl) {
+		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
+		par->panel_power_ctrl(1);
+	}
 
 	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
 		dev_err(&device->dev, "lcd_init failed\n");
@@ -877,8 +889,7 @@ static int __init fb_probe(struct platform_device *device)
 #endif
 
 	/* enable raster engine */
-	lcdc_write(lcdc_read(LCD_RASTER_CTRL_REG) |
-			LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
+	lcd_enable_raster();
 
 	return 0;
 
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index c051a50..89d43b3 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -38,6 +38,7 @@ struct da8xx_lcdc_platform_data {
 	const char manu_name[10];
 	void *controller_data;
 	const char type[25];
+	void (*panel_power_ctrl)(int);
 };
 
 struct lcd_ctrl_config {
-- 
1.5.6
