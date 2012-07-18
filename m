From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 18 Jul 2012 15:43:56 +0000
Subject: [PATCH RESEND] video: da8xx-fb: fix flicker due to 1 frame delay in updated frame
Message-Id: <1342625516-7185-1-git-send-email-prakash.pm@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Flicker/tearing effect is observed with current FB driver.
Issue is because of 2 active DMA channels ping ponging among them
along with usage of 2 DDR ping pong buffers in driver. Application
unaware of active DMA channel keeps updating frame being displayed,
this leads to tearing effect.
Below steps describes the issue:
1)Initially assume both buffers FB0 and FB1 are programmed for buffer-0.
2)On EOF0: Program FB0 for buffer-1, indicate(wake up) application
 to fill up buffer-0. As FB1 is active and continues to DMA buffer-0
(which is being filled), leading to tearing/flickering issue.
3)On EOF1: Program FB1 for buffer-0, indicate(wake up) application to
 fill up buffer-1. As FB0 is active and continues to DMA buffer-1(which
 is being filled), leading to tearing/flickering issue.
4)On EOF0: Program FB0 for buffer-1, indicate(wake up) application to
fill up buffer-0. As FB1 is active and continues to DMA buffer-0(which is
being filled), leading to tearing/flickering issue.
...
Above steps depict that issue is because of 1 frame delay in frame
panned by application.

Patch fixes the issue by keeping track free DMA channel and configures
it in drivers PAN callback so that panned frame from application gets
displayed in next frame period.

Wiki below describes the issue in detail and it also has link to
application with which issue can be reproduced.
http://processors.wiki.ti.com/index.php/DA8xx_LCDC_Linux_FB_FAQs

Signed-off-by: Nellutla, Aditya <aditya.n@ti.com>
Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Resending as my earlier patch seems like not reached fbdev mailing list.

 drivers/video/da8xx-fb.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index e9d2f6e..183366d 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -30,6 +30,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/console.h>
+#include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <video/da8xx-fb.h>
 #include <asm/div64.h>
@@ -161,6 +162,13 @@ struct da8xx_fb_par {
 	wait_queue_head_t	vsync_wait;
 	int			vsync_flag;
 	int			vsync_timeout;
+	spinlock_t		lock_for_chan_update;
+
+	/*
+	 * LCDC has 2 ping pong DMA channels, channel 0
+	 * and channel 1.
+	 */
+	unsigned int		which_dma_channel_done;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 	unsigned int		lcd_fck_rate;
@@ -741,6 +749,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 		lcdc_write(stat, LCD_MASKED_STAT_REG);
 
 		if (stat & LCD_END_OF_FRAME0) {
+			par->which_dma_channel_done = 0;
 			lcdc_write(par->dma_start,
 				   LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
 			lcdc_write(par->dma_end,
@@ -750,6 +759,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
 		}
 
 		if (stat & LCD_END_OF_FRAME1) {
+			par->which_dma_channel_done = 1;
 			lcdc_write(par->dma_start,
 				   LCD_DMA_FRM_BUF_BASE_ADDR_1_REG);
 			lcdc_write(par->dma_end,
@@ -796,6 +806,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 		lcdc_write(stat, LCD_STAT_REG);
 
 		if (stat & LCD_END_OF_FRAME0) {
+			par->which_dma_channel_done = 0;
 			lcdc_write(par->dma_start,
 				   LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
 			lcdc_write(par->dma_end,
@@ -805,6 +816,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
 		}
 
 		if (stat & LCD_END_OF_FRAME1) {
+			par->which_dma_channel_done = 1;
 			lcdc_write(par->dma_start,
 				   LCD_DMA_FRM_BUF_BASE_ADDR_1_REG);
 			lcdc_write(par->dma_end,
@@ -1050,6 +1062,7 @@ static int da8xx_pan_display(struct fb_var_screeninfo *var,
 	struct fb_fix_screeninfo    *fix = &fbi->fix;
 	unsigned int end;
 	unsigned int start;
+	unsigned long irq_flags;
 
 	if (var->xoffset != fbi->var.xoffset ||
 			var->yoffset != fbi->var.yoffset) {
@@ -1067,6 +1080,21 @@ static int da8xx_pan_display(struct fb_var_screeninfo *var,
 			end	= start + fbi->var.yres * fix->line_length - 1;
 			par->dma_start	= start;
 			par->dma_end	= end;
+			spin_lock_irqsave(&par->lock_for_chan_update,
+					irq_flags);
+			if (par->which_dma_channel_done = 0) {
+				lcdc_write(par->dma_start,
+					   LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
+				lcdc_write(par->dma_end,
+					   LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG);
+			} else if (par->which_dma_channel_done = 1) {
+				lcdc_write(par->dma_start,
+					   LCD_DMA_FRM_BUF_BASE_ADDR_1_REG);
+				lcdc_write(par->dma_end,
+					   LCD_DMA_FRM_BUF_CEILING_ADDR_1_REG);
+			}
+			spin_unlock_irqrestore(&par->lock_for_chan_update,
+					irq_flags);
 		}
 	}
 
@@ -1294,6 +1322,8 @@ static int __devinit fb_probe(struct platform_device *device)
 	/* initialize the vsync wait queue */
 	init_waitqueue_head(&par->vsync_wait);
 	par->vsync_timeout = HZ / 5;
+	par->which_dma_channel_done = -1;
+	spin_lock_init(&par->lock_for_chan_update);
 
 	/* Register the Frame Buffer  */
 	if (register_framebuffer(da8xx_fb_info) < 0) {
-- 
1.7.1

