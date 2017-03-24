From: Pushkar Jambhlekar <pushkar.iit@gmail.com>
Date: Fri, 24 Mar 2017 05:40:08 +0000
Subject: [PATCH] drivers/video/fbdev: Fixing coding guidelines in acornfb.c
Message-Id: <1490333288-7532-1-git-send-email-pushkar.iit@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Pushkar Jambhlekar <pushkar.iit@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Fixing coding guidelines error reported by 'checkpatch.pl'

Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
---
 drivers/video/fbdev/acornfb.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index fb75b7e..0c325b4 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -101,7 +101,7 @@ extern unsigned int vram_size;	/* set by setup.c */
 #ifdef HAS_VIDC20
 #include <mach/acornfb.h>
 
-#define MAX_SIZE	2*1024*1024
+#define MAX_SIZE	(2*1024*1024)
 
 /* VIDC20 has a different set of rules from the VIDC:
  *  hcr  : must be multiple of 4
@@ -162,7 +162,7 @@ static void acornfb_set_timing(struct fb_info *info)
 	if (memcmp(&current_vidc, &vidc, sizeof(vidc))) {
 		current_vidc = vidc;
 
-		vidc_writel(VIDC20_CTRL| vidc.control);
+		vidc_writel(VIDC20_CTRL | vidc.control);
 		vidc_writel(0xd0000000 | vidc.pll_ctl);
 		vidc_writel(0x80000000 | vidc.h_cycle);
 		vidc_writel(0x81000000 | vidc.h_sync_width);
@@ -297,7 +297,7 @@ acornfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		pal.p = 0;
 		vidc_writel(0x10000000);
 		for (i = 0; i < 256; i += 1) {
-			pal.vidc20.red   = current_par.palette[ i       & 31].vidc20.red;
+			pal.vidc20.red   = current_par.palette[i       & 31].vidc20.red;
 			pal.vidc20.green = current_par.palette[(i >> 1) & 31].vidc20.green;
 			pal.vidc20.blue  = current_par.palette[(i >> 2) & 31].vidc20.blue;
 			vidc_writel(pal.p);
@@ -1043,8 +1043,7 @@ static int acornfb_probe(struct platform_device *dev)
 		base = dma_alloc_wc(current_par.dev, size, &handle,
 				    GFP_KERNEL);
 		if (base = NULL) {
-			printk(KERN_ERR "acornfb: unable to allocate screen "
-			       "memory\n");
+			printk(KERN_ERR "acornfb: unable to allocate screen memory\n");
 			return -ENOMEM;
 		}
 
@@ -1103,8 +1102,7 @@ static int acornfb_probe(struct platform_device *dev)
 	v_sync = h_sync / (fb_info.var.yres + fb_info.var.upper_margin +
 		 fb_info.var.lower_margin + fb_info.var.vsync_len);
 
-	printk(KERN_INFO "Acornfb: %dkB %cRAM, %s, using %dx%d, "
-		"%d.%03dkHz, %dHz\n",
+	printk(KERN_INFO "Acornfb: %dkB %cRAM, %s, using %dx%d, %d.%03dkHz, %dHz\n",
 		fb_info.fix.smem_len / 1024,
 		current_par.using_vram ? 'V' : 'D',
 		VIDC_NAME, fb_info.var.xres, fb_info.var.yres,
-- 
2.7.4

