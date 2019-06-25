From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2019 16:34:29 +0000
Subject: [PATCH 07/12] fbdev: da8xx: add support for a regulator
Message-Id: <20190625163434.13620-8-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to remove the hacky platform data callback for power control.
Add a regulator to the driver data and enable/disable it next to
the current panel_power_ctrl() calls. We will use it in subsequent
patch on da850-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/fbdev/da8xx-fb.c | 54 ++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 9ea817ac1d81..4fa99ff79f3b 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/console.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -165,6 +166,7 @@ struct da8xx_fb_par {
 #endif
 	unsigned int		lcdc_clk_rate;
 	void (*panel_power_ctrl)(int);
+	struct regulator	*lcd_supply;
 	u32 pseudo_palette[16];
 	struct fb_videomode	mode;
 	struct lcd_ctrl_config	cfg;
@@ -1066,6 +1068,7 @@ static void lcd_da8xx_cpufreq_deregister(struct da8xx_fb_par *par)
 static int fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(&dev->dev);
+	int ret;
 
 	if (info) {
 		struct da8xx_fb_par *par = info->par;
@@ -1073,8 +1076,13 @@ static int fb_remove(struct platform_device *dev)
 #ifdef CONFIG_CPU_FREQ
 		lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(0);
+		} else if (par->lcd_supply) {
+			ret = regulator_disable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 
 		lcd_disable_raster(DA8XX_FRAME_WAIT);
 		lcdc_write(0, LCD_RASTER_CTRL_REG);
@@ -1179,15 +1187,25 @@ static int cfb_blank(int blank, struct fb_info *info)
 	case FB_BLANK_UNBLANK:
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(1);
+		} else if (par->lcd_supply) {
+			ret = regulator_enable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 		break;
 	case FB_BLANK_NORMAL:
 	case FB_BLANK_VSYNC_SUSPEND:
 	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(0);
+		} else if (par->lcd_supply) {
+			ret = regulator_disable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 
 		lcd_disable_raster(DA8XX_FRAME_WAIT);
 		break;
@@ -1401,6 +1419,20 @@ static int fb_probe(struct platform_device *device)
 		par->panel_power_ctrl(1);
 	}
 
+	par->lcd_supply = devm_regulator_get_optional(&device->dev, "lcd");
+	if (IS_ERR(par->lcd_supply)) {
+		if (PTR_ERR(par->lcd_supply) = -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_pm_runtime_disable;
+		}
+
+		par->lcd_supply = NULL;
+	} else {
+		ret = regulator_enable(par->lcd_supply);
+		if (ret)
+			goto err_pm_runtime_disable;
+	}
+
 	fb_videomode_to_var(&da8xx_fb_var, lcdc_info);
 	par->cfg = *lcd_cfg;
 
@@ -1604,10 +1636,16 @@ static int fb_suspend(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct da8xx_fb_par *par = info->par;
+	int ret;
 
 	console_lock();
-	if (par->panel_power_ctrl)
+	if (par->panel_power_ctrl) {
 		par->panel_power_ctrl(0);
+	} else if (par->lcd_supply) {
+		ret = regulator_disable(par->lcd_supply);
+		if (ret)
+			return ret;
+	}
 
 	fb_set_suspend(info, 1);
 	lcd_disable_raster(DA8XX_FRAME_WAIT);
@@ -1621,6 +1659,7 @@ static int fb_resume(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct da8xx_fb_par *par = info->par;
+	int ret;
 
 	console_lock();
 	pm_runtime_get_sync(dev);
@@ -1628,8 +1667,13 @@ static int fb_resume(struct device *dev)
 	if (par->blank = FB_BLANK_UNBLANK) {
 		lcd_enable_raster();
 
-		if (par->panel_power_ctrl)
+		if (par->panel_power_ctrl) {
 			par->panel_power_ctrl(1);
+		} else if (par->lcd_supply) {
+			ret = regulator_enable(par->lcd_supply);
+			if (ret)
+				return ret;
+		}
 	}
 
 	fb_set_suspend(info, 0);
-- 
2.21.0
