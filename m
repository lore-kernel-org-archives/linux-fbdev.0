From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 25 Jun 2019 16:34:32 +0000
Subject: [PATCH 10/12] fbdev: da8xx-fb: use devm_platform_ioremap_resource()
Message-Id: <20190625163434.13620-11-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190625163434.13620-1-brgl@bgdev.pl>
In-Reply-To: <20190625163434.13620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink the code a bit by using the new helper wrapping the calls to
platform_get_resource() and devm_ioremap_resource() together.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/video/fbdev/da8xx-fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index 328de29c4933..4dda194d6b8f 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1339,7 +1339,6 @@ static int fb_probe(struct platform_device *device)
 {
 	struct da8xx_lcdc_platform_data *fb_pdata  						dev_get_platdata(&device->dev);
-	struct resource *lcdc_regs;
 	struct lcd_ctrl_config *lcd_cfg;
 	struct fb_videomode *lcdc_info;
 	struct fb_info *da8xx_fb_info;
@@ -1357,8 +1356,7 @@ static int fb_probe(struct platform_device *device)
 	if (lcdc_info = NULL)
 		return -ENODEV;
 
-	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
-	da8xx_fb_reg_base = devm_ioremap_resource(&device->dev, lcdc_regs);
+	da8xx_fb_reg_base = devm_platform_ioremap_resource(device, 0);
 	if (IS_ERR(da8xx_fb_reg_base))
 		return PTR_ERR(da8xx_fb_reg_base);
 
-- 
2.21.0
