From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jul 2019 13:44:22 +0000
Subject: [PATCH v2 8/9] fbdev: da8xx-fb: drop a redundant if
Message-Id: <20190722134423.26555-9-brgl@bgdev.pl>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722134423.26555-1-brgl@bgdev.pl>
In-Reply-To: <20190722134423.26555-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Lechner <david@lechnology.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver data is always set in probe. The remove() callback won't be
called if probe failed which is the only way for it to be NULL. Remove
the redundant if.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/da8xx-fb.c | 43 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
index f2f66605e8fb..d14ea6f91371 100644
--- a/drivers/video/fbdev/da8xx-fb.c
+++ b/drivers/video/fbdev/da8xx-fb.c
@@ -1067,37 +1067,34 @@ static void lcd_da8xx_cpufreq_deregister(struct da8xx_fb_par *par)
 static int fb_remove(struct platform_device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(&dev->dev);
+	struct da8xx_fb_par *par = info->par;
 	int ret;
 
-	if (info) {
-		struct da8xx_fb_par *par = info->par;
-
 #ifdef CONFIG_CPU_FREQ
-		lcd_da8xx_cpufreq_deregister(par);
+	lcd_da8xx_cpufreq_deregister(par);
 #endif
-		if (par->lcd_supply) {
-			ret = regulator_disable(par->lcd_supply);
-			if (ret)
-				return ret;
-		}
+	if (par->lcd_supply) {
+		ret = regulator_disable(par->lcd_supply);
+		if (ret)
+			return ret;
+	}
 
-		lcd_disable_raster(DA8XX_FRAME_WAIT);
-		lcdc_write(0, LCD_RASTER_CTRL_REG);
+	lcd_disable_raster(DA8XX_FRAME_WAIT);
+	lcdc_write(0, LCD_RASTER_CTRL_REG);
 
-		/* disable DMA  */
-		lcdc_write(0, LCD_DMA_CTRL_REG);
+	/* disable DMA  */
+	lcdc_write(0, LCD_DMA_CTRL_REG);
 
-		unregister_framebuffer(info);
-		fb_dealloc_cmap(&info->cmap);
-		dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
-				  par->p_palette_base);
-		dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
-				  par->vram_phys);
-		pm_runtime_put_sync(&dev->dev);
-		pm_runtime_disable(&dev->dev);
-		framebuffer_release(info);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
+	dma_free_coherent(par->dev, PALETTE_SIZE, par->v_palette_base,
+			  par->p_palette_base);
+	dma_free_coherent(par->dev, par->vram_size, par->vram_virt,
+			  par->vram_phys);
+	pm_runtime_put_sync(&dev->dev);
+	pm_runtime_disable(&dev->dev);
+	framebuffer_release(info);
 
-	}
 	return 0;
 }
 
-- 
2.21.0
