From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 30 Jul 2013 18:26:30 +0000
Subject: [PATCH v2 23/24] video: da8xx-fb: make clock naming consistent
Message-Id: <1375208791-15781-24-git-send-email-detheridge@ti.com>
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
 drivers/video/da8xx-fb.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 471931e..131cf4c 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -179,7 +179,7 @@ struct da8xx_fb_par {
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
-	unsigned int		lcd_fck_rate;
+	unsigned int		lcdc_clk_rate;
 	void (*panel_power_ctrl)(int);
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
@@ -692,14 +692,14 @@ static int da8xx_fb_config_clk_divider(struct da8xx_fb_par *par,
 {
 	int ret;
 
-	if (par->lcd_fck_rate != lcdc_clk_rate) {
+	if (par->lcdc_clk_rate != lcdc_clk_rate) {
 		ret = clk_set_rate(par->lcdc_clk, lcdc_clk_rate);
 		if (IS_ERR_VALUE(ret)) {
 			dev_err(par->dev,
 				"unable to set clock rate at %u\n", lcdc_clk_rate);
 			return ret;
 		}
-		par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
+		par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
 	}
 
 	/* Configure the LCD clock divisor. */
@@ -721,7 +721,7 @@ static unsigned int da8xx_fb_calc_clk_divider(struct da8xx_fb_par *par,
 
 	pixclock = PICOS2KHZ(pixclock) * 1000;
 
-	*lcdc_clk_rate = par->lcd_fck_rate;
+	*lcdc_clk_rate = par->lcdc_clk_rate;
 
 	if (pixclock < (*lcdc_clk_rate / CLK_MAX_DIV)) {
 		*lcdc_clk_rate = clk_round_rate(par->lcdc_clk, pixclock * CLK_MAX_DIV);
@@ -1026,8 +1026,8 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
 
 	par = container_of(nb, struct da8xx_fb_par, freq_transition);
 	if (val = CPUFREQ_POSTCHANGE) {
-		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
-			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
+		if (par->lcdc_clk_rate != clk_get_rate(par->lcdc_clk)) {
+			par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
 			lcd_disable_raster(DA8XX_FRAME_WAIT);
 			da8xx_fb_calc_config_clk_divider(par, &par->mode);
 			if (par->blank = FB_BLANK_UNBLANK)
@@ -1368,8 +1368,8 @@ static int fb_probe(struct platform_device *device)
 	struct lcd_ctrl_config *lcd_cfg;
 	struct fb_videomode *lcdc_info;
 	struct fb_info *da8xx_fb_info;
-	struct clk *fb_clk = NULL;
 	struct da8xx_fb_par *par;
+	struct clk *tmp_lcdc_clk;
 	int ret;
 	unsigned long ulcm;
 
@@ -1389,8 +1389,8 @@ static int fb_probe(struct platform_device *device)
 		return -EADDRNOTAVAIL;
 	}
 
-	fb_clk = devm_clk_get(&device->dev, "fck");
-	if (IS_ERR(fb_clk)) {
+	tmp_lcdc_clk = devm_clk_get(&device->dev, "fck");
+	if (IS_ERR(tmp_lcdc_clk)) {
 		dev_err(&device->dev, "Can not get device clock\n");
 		return -ENODEV;
 	}
@@ -1435,8 +1435,8 @@ static int fb_probe(struct platform_device *device)
 
 	par = da8xx_fb_info->par;
 	par->dev = &device->dev;
-	par->lcdc_clk = fb_clk;
-	par->lcd_fck_rate = clk_get_rate(fb_clk);
+	par->lcdc_clk = tmp_lcdc_clk;
+	par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
 	if (fb_pdata && fb_pdata->panel_power_ctrl) {
 		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
 		par->panel_power_ctrl(1);
-- 
1.7.0.4

