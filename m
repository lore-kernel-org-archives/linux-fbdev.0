From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jul 2019 13:44:20 +0000
Subject: [PATCH v2 6/9] fbdev: da8xx: remove panel_power_ctrl() callback from platform data
Message-Id: <20190722134423.26555-7-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722134423.26555-1-brgl@bgdev.pl>
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of panel_power_ctrl(). Remove it from the
driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/da8xx-fb.c | 25 +++++--------------------
 include/video/da8xx-fb.h       |  1 -
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 02dfe9e32eed..19ed9889c8f8 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -165,7 +165,6 @@ struct da8xx_fb_par {
 	struct notifier_block	freq_transition;
 #endif
 	unsigned int		lcdc_clk_rate;
-	void (*panel_power_ctrl)(int);
 	struct regulator	*lcd_supply;
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
@@ -1076,9 +1075,7 @@ static int fb_remove(struct platform_device *dev)
 #ifdef CONFIG_CPU_FREQ
 		lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(0);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_disable(par->lcd_supply);
 			if (ret)
 				return ret;
@@ -1187,9 +1184,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 	case FB_BLANK_UNBLANK:
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(1);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_enable(par->lcd_supply);
 			if (ret)
 				return ret;
@@ -1199,9 +1194,7 @@ static int cfb_blank(int blank, struct fb_info *info)
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(0);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_disable(par->lcd_supply);
 			if (ret)
 				return ret;
@@ -1413,10 +1406,6 @@ static int fb_probe(struct platform_device *device)
 	par->dev = &device->dev;
 	par->lcdc_clk = tmp_lcdc_clk;
 	par->lcdc_clk_rate = clk_get_rate(par->lcdc_clk);
-	if (fb_pdata->panel_power_ctrl) {
-		par->panel_power_ctrl = fb_pdata->panel_power_ctrl;
-		par->panel_power_ctrl(1);
-	}
 
 	par->lcd_supply = devm_regulator_get_optional(&device->dev, "lcd");
 	if (IS_ERR(par->lcd_supply)) {
@@ -1638,9 +1627,7 @@ static int fb_suspend(struct device *dev)
 	int ret;
 
 	console_lock();
-	if (par->panel_power_ctrl) {
-		par->panel_power_ctrl(0);
-	} else if (par->lcd_supply) {
+	if (par->lcd_supply) {
 		ret = regulator_disable(par->lcd_supply);
 		if (ret)
 			return ret;
@@ -1666,9 +1653,7 @@ static int fb_resume(struct device *dev)
 	if (par->blank = FB_BLANK_UNBLANK) {
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl) {
-			par->panel_power_ctrl(1);
-		} else if (par->lcd_supply) {
+		if (par->lcd_supply) {
 			ret = regulator_enable(par->lcd_supply);
 			if (ret)
 				return ret;
diff --git a/include/video/da8xx-fb.h b/include/video/da8xx-fb.h
index efed3c3383d6..1d19ae62b844 100644
--- a/include/video/da8xx-fb.h
+++ b/include/video/da8xx-fb.h
@@ -32,7 +32,6 @@ struct da8xx_lcdc_platform_data {
 	const char manu_name[10];
 	void *controller_data;
 	const char type[25];
-	void (*panel_power_ctrl)(int);
 };
 
 struct lcd_ctrl_config {
-- 
2.21.0
