From: Darren Etheridge <detheridge@ti.com>
Date: Mon, 05 Aug 2013 22:02:37 +0000
Subject: [PATCH v3 18/20] video: da8xx-fb: make clock naming consistent
Message-Id: <1375740159-1045-19-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Clean up the code, so that the names of the various clock variables
are consistent to it is clear what variable is associated with what
clock.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index dfe7572..8c0ca11 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -177,7 +177,7 @@ struct da8xx_fb_par {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	unsigned int		lcd_fck_rate;
+	unsigned int		lcdc_clk_rate;
 	void (*panel_power_ctrl)(int);
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
@@ -693,7 +693,7 @@ static int da8xx_fb_config_clk_divider(struct da8xx_fb_par *par,
 {
 	int ret;
 
-	if (par->lcd_fck_rate != lcdc_clk_rate) {
+	if (par->lcdc_clk_rate != lcdc_clk_rate) {
 		ret = clk_set_rate(par->lcdc_clk, lcdc_clk_rate);
 		if (IS_ERR_VALUE(ret)) {
 			dev_err(par->dev,
@@ -701,7 +701,7 @@ static int da8xx_fb_config_clk_divider(struct da8xx_fb_par *par,
 				lcdc_clk_rate);
 			return ret;
 		}
-		par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
+		par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
 	}
 
 	/* Configure the LCD clock divisor. */
@@ -723,7 +723,7 @@ static unsigned int da8xx_fb_calc_clk_divider(struct da8xx_fb_par *par,
 
 	pixclock = PICOS2KHZ(pixclock) * 1000;
 
-	*lcdc_clk_rate = par->lcd_fck_rate;
+	*lcdc_clk_rate = par->lcdc_clk_rate;
 
 	if (pixclock < (*lcdc_clk_rate / CLK_MAX_DIV)) {
 		*lcdc_clk_rate = clk_round_rate(par->lcdc_clk,
@@ -1031,8 +1031,8 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 
 	par = container_of(nb, struct da8xx_fb_par, freq_transition);
 	if (val = CPUFREQ_POSTCHANGE) {
-		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
-			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
+		if (par->lcdc_clk_rate != clk_get_rate(par->lcdc_clk)) {
+			par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
 			lcd_disable_raster(DA8XX_FRAME_WAIT);
 			da8xx_fb_calc_config_clk_divider(par, &par->mode);
 			if (par->blank = FB_BLANK_UNBLANK)
@@ -1327,8 +1327,8 @@ static int fb_probe(struct platform_device *device)
 	struct lcd_ctrl_config *lcd_cfg;
 	struct fb_videomode *lcdc_info;
 	struct fb_info *da8xx_fb_info;
-	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
+	struct clk *tmp_lcdc_clk;
 	int ret;
 	unsigned long ulcm;
 
@@ -1346,10 +1346,10 @@ static int fb_probe(struct platform_device *device)
 	if (IS_ERR(da8xx_fb_reg_base))
 		return PTR_ERR(da8xx_fb_reg_base);
 
-	fb_clk = devm_clk_get(&device->dev, "fck");
-	if (IS_ERR(fb_clk)) {
+	tmp_lcdc_clk = devm_clk_get(&device->dev, "fck");
+	if (IS_ERR(tmp_lcdc_clk)) {
 		dev_err(&device->dev, "Can not get device clock\n");
-		return PTR_ERR(fb_clk);
+		return PTR_ERR(tmp_lcdc_clk);
 	}
 
 	pm_runtime_enable(&device->dev);
@@ -1389,8 +1389,8 @@ static int fb_probe(struct platform_device *device)
 
 	par = da8xx_fb_info->par;
 	par->dev = &device->dev;
-	par->lcdc_clk = fb_clk;
-	par->lcd_fck_rate = clk_get_rate(fb_clk);
+	par->lcdc_clk = tmp_lcdc_clk;
+	par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
 	if (fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
 		par->panel_power_ctrl(1);
-- 
1.7.0.4

