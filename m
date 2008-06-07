From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 2/7] pxafb: add shared
	framebuffer interface
Date: Sat,  7 Jun 2008 00:49:21 -0400
Message-ID: <1212814166-10313-3-git-send-email-jayakumar.lkml@gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4rGF-0006J7-95 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 22:46:43 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4rGE-0006CT-Tf
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 22:46:43 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1257559wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 06 Jun 2008 22:46:42 -0700 (PDT)
In-Reply-To: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
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
 drivers/video/pxafb.c            |   45 ++++++++++++++++++++++++++++++++-----
 include/asm-arm/arch-pxa/pxafb.h |    9 +++++++
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d6c05b6..b72b73a 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -130,6 +130,8 @@ struct platform_device pxa_device_fb = {
 
 void __init set_pxa_fb_info(struct pxafb_mach_info *info)
 {
+	if (!info->clkdev)
+		info->clkdev = &pxa_device_fb.dev;
 	pxa_register_device(&pxa_device_fb, info);
 }
 
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 209a03d..9c53985 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -57,6 +57,8 @@
  */
 #define DEBUG_VAR 1
 
+static struct platform_driver pxafb_driver;
+
 #include "pxafb.h"
 
 /* Bits which should not be set in machine configuration structures */
@@ -775,10 +777,15 @@ int pxafb_smart_flush(struct fb_info *info)
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
@@ -819,6 +826,7 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 {
 	u_long flags;
 	size_t nbytes;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 #if DEBUG_VAR
 	if (!(fbi->lccr0 & LCCR0_LCDT)) {
@@ -878,6 +886,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	fbi->reg_lccr3 |= pxafb_bpp_to_lccr3(var);
 
 	nbytes = var->yres * fbi->fb.fix.line_length;
+	if (inf->custom_xfer_div)
+		nbytes /= inf->custom_xfer_div;
 
 	if ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual) {
 		nbytes = nbytes / 2;
@@ -1246,14 +1256,17 @@ static int pxafb_resume(struct platform_device *dev)
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
 
@@ -1280,6 +1293,13 @@ static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
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
@@ -1290,6 +1310,7 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
 				   unsigned int num_modes)
 {
 	unsigned int i, smemlen;
+	struct pxafb_mach_info *inf = fbi->dev->platform_data;
 
 	pxafb_setmode(&fbi->fb.var, &modes[0]);
 
@@ -1297,6 +1318,8 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
 		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
 		if (smemlen > fbi->fb.fix.smem_len)
 			fbi->fb.fix.smem_len = smemlen;
+		if (inf->custom_xfer_div)
+			fbi->fb.fix.smem_len /= inf->custom_xfer_div;
 	}
 }
 
@@ -1360,7 +1383,7 @@ static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
 	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 
-	fbi->clk = clk_get(dev, "LCDCLK");
+	fbi->clk = clk_get(inf->clkdev, "LCDCLK");
 	if (IS_ERR(fbi->clk)) {
 		kfree(fbi);
 		return NULL;
@@ -1701,8 +1724,12 @@ static int __devinit pxafb_probe(struct platform_device *dev)
 	}
 
 	/* Initialize video memory */
-	ret = pxafb_map_video_memory(fbi);
-	if (ret) {
+	ret = pxafb_map_video_memory(fbi, inf);
+	if (ret == -ENODEV) {
+		dev_err(&dev->dev, "Failed device binding: %d\n", ret);
+		ret = -ENODEV;
+		goto failed_free_mem;
+	} else if (ret) {
 		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
 		goto failed_free_io;
@@ -1766,6 +1793,8 @@ failed_free_irq:
 	if (fbi->fb.cmap.len)
 		fb_dealloc_cmap(&fbi->fb.cmap);
 failed_free_mem:
+	if (inf->unshare_video_mem)
+		inf->unshare_video_mem(inf->extra_data);
 	dma_free_writecombine(&dev->dev, fbi->map_size,
 			fbi->map_cpu, fbi->map_dma);
 failed_free_io:
@@ -1785,6 +1814,7 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 	int irq;
 
 	if (fbi) {
+		struct pxafb_mach_info *inf;
 		struct fb_info *info = &fbi->fb;
 
 		unregister_framebuffer(info);
@@ -1794,6 +1824,9 @@ static int __devexit pxafb_remove(struct platform_device *dev)
 		pxafb_disable_controller(fbi);
 		clk_put(fbi->clk);
 
+		inf = dev->dev.platform_data;
+		if (inf->unshare_video_mem)
+			inf->unshare_video_mem(inf->extra_data);
 		dma_free_writecombine(&dev->dev, fbi->map_size,
 					fbi->map_cpu, fbi->map_dma);
 
diff --git a/include/asm-arm/arch-pxa/pxafb.h b/include/asm-arm/arch-pxa/pxafb.h
index bbd2239..c703633 100644
--- a/include/asm-arm/arch-pxa/pxafb.h
+++ b/include/asm-arm/arch-pxa/pxafb.h
@@ -138,9 +138,18 @@ struct pxafb_mach_info {
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
+	int (*share_video_mem)(unsigned char *, dma_addr_t, struct module *,
+				void *);
+	void (*unshare_video_mem)(void *);
+	struct device *clkdev;
 };
 void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
 void set_pxa_fb_parent(struct device *parent_dev);
-- 
1.5.3.6


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
