From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 15 Feb 2014 05:56:23 +0000
Subject: [PATCH 2/5] video: imxfb: Remove unused fields from platform data structure
Message-Id: <1392443786-30527-2-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some fields in platform data structure is never used by boards.
This patch removes these fields and as a result optimizes private
driver structure a bit. Additionally patch removes backligh_power()
callback, so if it will be needed in the future, this feature should
be added as pwm{gpio,etc.}-regulator to the board code or in the DTS.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/video/imxfb.c                     | 64 ++++++++-----------------------
 include/linux/platform_data/video-imxfb.h | 10 -----
 2 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index e50b67f..5b07053 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -156,11 +156,8 @@ struct imxfb_info {
 	 * the framebuffer memory region to.
 	 */
 	dma_addr_t		map_dma;
-	u_char			*map_cpu;
 	u_int			map_size;
 
-	u_char			*screen_cpu;
-	dma_addr_t		screen_dma;
 	u_int			palette_size;
 
 	dma_addr_t		dbar1;
@@ -170,9 +167,8 @@ struct imxfb_info {
 	u_int			pwmr;
 	u_int			lscr1;
 	u_int			dmacr;
-	u_int			cmap_inverse:1,
-				cmap_static:1,
-				unused:30;
+	bool			cmap_inverse;
+	bool			cmap_static;
 
 	struct imx_fb_videomode *mode;
 	int			num_modes;
@@ -180,8 +176,6 @@ struct imxfb_info {
 	struct backlight_device *bl;
 #endif
 
-	void (*backlight_power)(int);
-
 	struct regulator	*lcd_pwr;
 };
 
@@ -573,7 +567,7 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 
 	pr_debug("Enabling LCD controller\n");
 
-	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
+	writel(fbi->map_dma, fbi->regs + LCDC_SSA);
 
 	/* panning offset 0 (0 pixel offset)        */
 	writel(0x00000000, fbi->regs + LCDC_POS);
@@ -592,9 +586,6 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 	clk_prepare_enable(fbi->clk_ahb);
 	clk_prepare_enable(fbi->clk_per);
 	fbi->enabled = true;
-
-	if (fbi->backlight_power)
-		fbi->backlight_power(1);
 }
 
 static void imxfb_disable_controller(struct imxfb_info *fbi)
@@ -604,9 +595,6 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
 
 	pr_debug("Disabling LCD controller\n");
 
-	if (fbi->backlight_power)
-		fbi->backlight_power(0);
-
 	clk_disable_unprepare(fbi->clk_per);
 	clk_disable_unprepare(fbi->clk_ipg);
 	clk_disable_unprepare(fbi->clk_ahb);
@@ -790,13 +778,9 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 	info->flags			= FBINFO_FLAG_DEFAULT |
 					  FBINFO_READS_FAST;
 	if (pdata) {
-		info->var.grayscale		= pdata->cmap_greyscale;
-		fbi->cmap_inverse		= pdata->cmap_inverse;
-		fbi->cmap_static		= pdata->cmap_static;
 		fbi->lscr1			= pdata->lscr1;
 		fbi->dmacr			= pdata->dmacr;
 		fbi->pwmr			= pdata->pwmr;
-		fbi->backlight_power		= pdata->backlight_power;
 	} else {
 		np = pdev->dev.of_node;
 		info->var.grayscale = of_property_read_bool(np,
@@ -808,8 +792,6 @@ static int imxfb_init_fbinfo(struct platform_device *pdev)
 		of_property_read_u32(np, "fsl,lscr1", &fbi->lscr1);
 
 		of_property_read_u32(np, "fsl,dmacr", &fbi->dmacr);
-
-		fbi->backlight_power = NULL;
 	}
 
 	return 0;
@@ -1003,32 +985,18 @@ static int imxfb_probe(struct platform_device *pdev)
 		goto failed_ioremap;
 	}
 
-	/* Seems not being used by anyone, so no support for oftree */
-	if (!pdata || !pdata->fixed_screen_cpu) {
-		fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
-		fbi->map_cpu = dma_alloc_writecombine(&pdev->dev,
-				fbi->map_size, &fbi->map_dma, GFP_KERNEL);
+	fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
+	info->screen_base = dma_alloc_writecombine(&pdev->dev, fbi->map_size,
+						   &fbi->map_dma, GFP_KERNEL);
 
-		if (!fbi->map_cpu) {
-			dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
-			ret = -ENOMEM;
-			goto failed_map;
-		}
-
-		info->screen_base = fbi->map_cpu;
-		fbi->screen_cpu = fbi->map_cpu;
-		fbi->screen_dma = fbi->map_dma;
-		info->fix.smem_start = fbi->screen_dma;
-	} else {
-		/* Fixed framebuffer mapping enables location of the screen in eSRAM */
-		fbi->map_cpu = pdata->fixed_screen_cpu;
-		fbi->map_dma = pdata->fixed_screen_dma;
-		info->screen_base = fbi->map_cpu;
-		fbi->screen_cpu = fbi->map_cpu;
-		fbi->screen_dma = fbi->map_dma;
-		info->fix.smem_start = fbi->screen_dma;
+	if (!info->screen_base) {
+		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
+		ret = -ENOMEM;
+		goto failed_map;
 	}
 
+	info->fix.smem_start = fbi->map_dma;
+
 	if (pdata && pdata->init) {
 		ret = pdata->init(fbi->pdev);
 		if (ret)
@@ -1087,9 +1055,8 @@ failed_cmap:
 	if (pdata && pdata->exit)
 		pdata->exit(fbi->pdev);
 failed_platform_init:
-	if (pdata && !pdata->fixed_screen_cpu)
-		dma_free_writecombine(&pdev->dev,fbi->map_size,fbi->map_cpu,
-			fbi->map_dma);
+	dma_free_writecombine(&pdev->dev, fbi->map_size, info->screen_base,
+			      fbi->map_dma);
 failed_map:
 	iounmap(fbi->regs);
 failed_ioremap:
@@ -1127,6 +1094,9 @@ static int imxfb_remove(struct platform_device *pdev)
 	kfree(info->pseudo_palette);
 	framebuffer_release(info);
 
+	dma_free_writecombine(&pdev->dev, fbi->map_size, info->screen_base,
+			      fbi->map_dma);
+
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
 
diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index dd1bed9..18e9083 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -61,22 +61,12 @@ struct imx_fb_platform_data {
 	struct imx_fb_videomode *mode;
 	int		num_modes;
 
-	u_int		cmap_greyscale:1,
-			cmap_inverse:1,
-			cmap_static:1,
-			unused:29;
-
 	u_int		pwmr;
 	u_int		lscr1;
 	u_int		dmacr;
 
-	u_char * fixed_screen_cpu;
-	dma_addr_t fixed_screen_dma;
-
 	int (*init)(struct platform_device *);
 	void (*exit)(struct platform_device *);
-
-	void (*backlight_power)(int);
 };
 
 #endif /* ifndef __MACH_IMXFB_H__ */
-- 
1.8.3.2

