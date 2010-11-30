From: caglarakyuz@gmail.com
Date: Tue, 30 Nov 2010 20:04:14 +0000
Subject: [PATCH] video: da8xx: Register IRQ as last thing in driver probing.
Message-Id: <1291147454-3393-1-git-send-email-caglarakyuz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Caglar Akyuz <caglar@bilkon-kontrol.com.tr>

Following commit exposed a bug in driver:

	"fbdev: da8xx/omap-l1xx: implement double buffering"

Bug is, if interrupt handler is called before initialization is
finished, raster controller is enabled and following register
modifications causes hardware to stay in a broken state.

By looking at this one may say that proper locking is missing in
this driver, and a more proper fix should be prepared. However,
aformentioned commit causes a regression in the driver and some
fix to current one should be applied first.

Signed-off-by: Caglar Akyuz <caglar@bilkon-kontrol.com.tr>
---
 drivers/video/da8xx-fb.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index cad7d45..c265aed 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1029,10 +1029,6 @@ static int __init fb_probe(struct platform_device *device)
 		goto err_release_pl_mem;
 	}
 
-	ret = request_irq(par->irq, lcdc_irq_handler, 0, DRIVER_NAME, par);
-	if (ret)
-		goto err_release_pl_mem;
-
 	/* Initialize par */
 	da8xx_fb_info->var.bits_per_pixel = lcd_cfg->bpp;
 
@@ -1060,7 +1056,7 @@ static int __init fb_probe(struct platform_device *device)
 
 	ret = fb_alloc_cmap(&da8xx_fb_info->cmap, PALETTE_SIZE, 0);
 	if (ret)
-		goto err_free_irq;
+		goto err_release_pl_mem;
 	da8xx_fb_info->cmap.len = par->palette_sz;
 
 	/* initialize var_screeninfo */
@@ -1088,8 +1084,13 @@ static int __init fb_probe(struct platform_device *device)
 		goto err_cpu_freq;
 	}
 #endif
+
+	ret = request_irq(par->irq, lcdc_irq_handler, 0, DRIVER_NAME, par);
+	if (ret)
+		goto irq_freq;
 	return 0;
 
+irq_freq:
 #ifdef CONFIG_CPU_FREQ
 err_cpu_freq:
 	unregister_framebuffer(da8xx_fb_info);
@@ -1098,9 +1099,6 @@ err_cpu_freq:
 err_dealloc_cmap:
 	fb_dealloc_cmap(&da8xx_fb_info->cmap);
 
-err_free_irq:
-	free_irq(par->irq, par);
-
 err_release_pl_mem:
 	dma_free_coherent(NULL, PALETTE_SIZE, par->v_palette_base,
 			  par->p_palette_base);
-- 
1.6.4.2

