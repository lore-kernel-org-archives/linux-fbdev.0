From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Sun, 13 Jul 2008 09:26:23 -0400
Message-ID: <1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KI2Tb-00059b-Qd for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 07:23:03 -0700
Received: from wf-out-1314.google.com ([209.85.200.170])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KI2Tb-00076b-7E
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 13 Jul 2008 07:22:59 -0700
Received: by wf-out-1314.google.com with SMTP id 27so4474071wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 13 Jul 2008 07:22:59 -0700 (PDT)
In-Reply-To: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

These changes are to make it possible for a secondary driver to share the
pxafb framebuffer. The changes include:
- adding clkdev entry in pxafb_mach_info so that a driver can pass in the
  correct struct device owner for the LCDCLK.
- adding custom_xfer_div entry so that a driver can have custom sized
  transfers. For example, the metronome controller uses 16 bit AMLCD
  transfers but actually has 3 bit pixels in 8 bit containers.
- adding extra_video_mem entry so that a driver can tell pxafb of its
  additional needs.
- adding share_video_mem/unshare_video_mem callbacks to notify the secondary
  driver of the framebuffer address, to allow refcounting, and to cleanup on
  completion.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 arch/arm/mach-pxa/devices.c      |    2 +
 drivers/video/pxafb.c            |   48 +++++++++++++++++++++++++++++++------
 include/asm-arm/arch-pxa/pxafb.h |    9 +++++++
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 84489dc..47af7f6 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -146,6 +146,8 @@ struct platform_device pxa_device_fb = {
 
 void __init set_pxa_fb_info(struct pxafb_mach_info *info)
 {
+	if (!info->clkdev)
+		info->clkdev = &pxa_device_fb.dev;
 	pxa_register_device(&pxa_device_fb, info);
 }
 
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index bb25143..d2bd488 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -57,6 +57,8 @@
  */
 #define DEBUG_VAR 1
 
+static struct platform_driver pxafb_driver;
+
 #include "pxafb.h"
 
 /* Bits which should not be set in machine configuration structures */
@@ -826,10 +828,15 @@ int pxafb_smart_flush(struct fb_info *info)
 static void setup_parallel_timing(struct pxafb_info *fbi,
 				  struct fb_var_screeninfo *var)
 {
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 	unsigned int lines_per_panel, pcd = get_pcd(fbi, var->pixclock);
+	unsigned int pix_per_line = var->xres;
+
+	if (inf->custom_xfer_div)
+		pix_per_line /= inf->custom_xfer_div;
 
 	fbi->reg_lccr1 =
-		LCCR1_DisWdth(var->xres) +
+		LCCR1_DisWdth(pix_per_line) +
 		LCCR1_HorSnchWdth(var->hsync_len) +
 		LCCR1_BegLnDel(var->left_margin) +
 		LCCR1_EndLnDel(var->right_margin);
@@ -870,6 +877,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 {
 	u_long flags;
 	size_t nbytes;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 #if DEBUG_VAR
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
@@ -931,6 +939,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	fbi->reg_lccr3 |= pxafb_bpp_to_lccr3(var);
 
 	nbytes = var->yres * fbi->fb.fix.line_length;
+	if (inf->custom_xfer_div)
+		nbytes /= inf->custom_xfer_div;
 
 	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual) {
 		nbytes = nbytes / 2;
@@ -1304,21 +1314,25 @@ static int pxafb_resume(struct platform_device *dev)
  *      cache.  Once this area is remapped, all virtual memory
  *      access to the video memory should occur at the new region.
  */
-static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
+static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi,
+					 struct pxafb_mach_info *inf)
 {
+	int ret;
 	/*
 	 * We reserve one page for the palette, plus the size
 	 * of the framebuffer.
 	 */
 	fbi->video_offset = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
-	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset);
+	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset +
+					inf->extra_video_mem);
 	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
 					      &fbi->map_dma, GFP_KERNEL);
 
 	if (fbi->map_cpu) {
 		/* prevent initial garbage on screen */
 		memset(fbi->map_cpu, 0, fbi->map_size);
-		fbi->fb.screen_base = fbi->map_cpu + fbi->video_offset;
+		fbi->fb.screen_base = (char __force __iomem *) fbi->map_cpu
+					+ fbi->video_offset;
 		fbi->screen_dma = fbi->map_dma + fbi->video_offset;
 
 		/*
@@ -1340,6 +1354,13 @@ static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
 		fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 		fbi->n_smart_cmds = 0;
 #endif
+		if (inf->share_video_mem) {
+			ret = inf->share_video_mem(fbi->fb.screen_base,
+				fbi->screen_dma, pxafb_driver.driver.owner,
+				inf->extra_data);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return fbi->map_cpu ? 0 : -ENOMEM;
@@ -1350,6 +1371,7 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
 				   unsigned int num_modes)
 {
 	unsigned int i, smemlen;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 	pxafb_setmode(&fbi->fb.var, &modes[0]);
 
@@ -1357,6 +1379,8 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
 		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
 		if (smemlen > fbi->fb.fix.smem_len)
 			fbi->fb.fix.smem_len = smemlen;
+		if (inf->custom_xfer_div)
+			fbi->fb.fix.smem_len /= inf->custom_xfer_div;
 	}
 }
 
@@ -1420,7 +1444,7 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 
-	fbi->clk = clk_get(dev, "LCDCLK");
+	fbi->clk = clk_get(inf->clkdev, "LCDCLK");
 	if (IS_ERR(fbi->clk)) {
 		kfree(fbi);
 		return NULL;
@@ -1761,10 +1785,12 @@ static int __devinit pxafb_probe(struct platform_device *dev)
 	}
 
 	/* Initialize video memory */
-	ret = pxafb_map_video_memory(fbi);
-	if (ret) {
+	ret = pxafb_map_video_memory(fbi, inf);
+	if (ret == -ENODEV) {
+		dev_err(&dev->dev, "Failed device binding: %d\n", ret);
+		goto failed_free_mem;
+	} else if (ret) {
 		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
-		ret = -ENOMEM;
 		goto failed_free_io;
 	}
 
@@ -1836,6 +1862,8 @@ failed_free_cmap:
 failed_free_irq:
 	free_irq(irq, fbi);
 failed_free_mem:
+	if (inf->unshare_video_mem)
+		inf->unshare_video_mem(inf->extra_data);
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 			fbi->map_cpu, fbi->map_dma);
 failed_free_io:
@@ -1856,6 +1884,7 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 	struct resource *r;
 	int irq;
 	struct fb_info *info;
+	struct pxafb_mach_info *inf;
 
 	if (!fbi)
 		return 0;
@@ -1872,6 +1901,9 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 	irq = platform_get_irq(dev, 0);
 	free_irq(irq, fbi);
 
+	inf = dev->dev.platform_data;
+	if (inf->unshare_video_mem)
+		inf->unshare_video_mem(inf->extra_data);
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 					fbi->map_cpu, fbi->map_dma);
 
diff --git a/include/asm-arm/arch-pxa/pxafb.h b/include/asm-arm/arch-pxa/pxafb.h
index daf018d..8528895 100644
--- a/include/asm-arm/arch-pxa/pxafb.h
+++ b/include/asm-arm/arch-pxa/pxafb.h
@@ -139,9 +139,18 @@ struct pxafb_mach_info {
 	 * All other bits in LCCR4 should be left alone.
 	 */
 	u_int		lccr4;
+	unsigned int	custom_xfer_div; /* divides the pixel transfer */
+	/* size of extra mem needed for secondary driver */
+	unsigned int	extra_video_mem;
+	void		*extra_data; /* extra data for secondary */
 	void (*pxafb_backlight_power)(int);
 	void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
 	void (*smart_update)(struct fb_info *);
+	/* share_video_mem allows client drivers to get our framebuffer */
+	int (*share_video_mem)(char __iomem *, dma_addr_t, struct module *,
+				void *);
+	void (*unshare_video_mem)(void *);
+	struct device *clkdev;
 };
 void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
 void set_pxa_fb_parent(struct device *parent_dev);
-- 
1.5.3.6


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
