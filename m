From: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] davinci: fb: Fix frame buffer driver issues
Date: Wed, 18 Nov 2009 15:44:50 +0530
Message-ID: <1258539290-3913-1-git-send-email-sudhakar.raj@ti.com>
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
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

Following issues have been addressed on DA8XX/OMAP-L1XX:

a. Screen misalignment during booting when frame buffer
   console is enabled.
b. Driver was configured always in PSEUDOCOLOR mode.
   This patch dynamically configures the driver either
   in PSEUDOCOLOUR or TRUECOLOR mode depending on bpp.
c. The RED and BLUE offsets were interchanged resulting
   in wrong bootup logo colour.

This patch has been tested on DA830/OMAP-L137 and
DA850/OMAP-L138 EVMs.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
---
 drivers/video/da8xx-fb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index d065894..95f4e73 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -554,11 +554,11 @@ static int fb_check_var(struct fb_var_screeninfo *var,
 		var->transp.length = 0;
 		break;
 	case 16:		/* RGB 565 */
-		var->red.offset = 0;
+		var->red.offset = 11;
 		var->red.length = 5;
 		var->green.offset = 5;
 		var->green.length = 6;
-		var->blue.offset = 11;
+		var->blue.offset = 0;
 		var->blue.length = 5;
 		var->transp.offset = 0;
 		var->transp.length = 0;
@@ -591,7 +591,7 @@ static int __devexit fb_remove(struct platform_device *dev)
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 		dma_free_coherent(NULL, par->databuf_sz + PAGE_SIZE,
-					info->screen_base,
+					info->screen_base - PAGE_SIZE,
 					info->fix.smem_start);
 		free_irq(par->irq, par);
 		clk_disable(par->lcdc_clk);
@@ -749,6 +749,7 @@ static int __init fb_probe(struct platform_device *device)
 				(PAGE_SIZE - par->palette_sz);
 
 	/* the rest of the frame buffer is pixel data */
+	da8xx_fb_info->screen_base = par->v_palette_base + par->palette_sz;
 	da8xx_fb_fix.smem_start = par->p_palette_base + par->palette_sz;
 	da8xx_fb_fix.smem_len = par->databuf_sz - par->palette_sz;
 	da8xx_fb_fix.line_length = (lcdc_info->width * lcd_cfg->bpp) / 8;
@@ -787,6 +788,8 @@ static int __init fb_probe(struct platform_device *device)
 	da8xx_fb_info->var = da8xx_fb_var;
 	da8xx_fb_info->fbops = &da8xx_fb_ops;
 	da8xx_fb_info->pseudo_palette = par->pseudo_palette;
+	da8xx_fb_info->fix.visual = (da8xx_fb_info->var.bits_per_pixel <= 8) ?
+				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
 	ret = fb_alloc_cmap(&da8xx_fb_info->cmap, PALETTE_SIZE, 0);
 	if (ret)
@@ -825,7 +828,7 @@ err_free_irq:
 
 err_release_fb_mem:
 	dma_free_coherent(NULL, par->databuf_sz + PAGE_SIZE,
-				da8xx_fb_info->screen_base,
+				da8xx_fb_info->screen_base - PAGE_SIZE,
 				da8xx_fb_info->fix.smem_start);
 
 err_release_fb:
-- 
1.5.6
