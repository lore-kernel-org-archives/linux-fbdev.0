From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/3] pxafb: allow video memory size to
	be configurable
Date: Wed, 17 Dec 2008 16:58:17 +0800
Message-ID: <f17812d70812170058h4aa8d41fg438967b15e41cc6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LCsEY-0002j9-Ll
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:58:22 +0000
Received: from rv-out-0708.google.com ([209.85.198.248])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCsEV-0005Wn-15 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 08:58:22 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3406711rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 00:58:17 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

The amount of video memory size is decided according to the following
order:

1. <xres> x <yres> x <bits_per_pixel> by default, which is the backward
   compatible way

2. size specified in platform data

3. size specified in module parameter 'options' string or specified in
   kernel boot command line (see updated Documentation/fb/pxafb.txt)

And now since the memory is allocated from system memory, the pxafb_mmap
can be removed and the default fb_mmap() should be working all right.

Also, since we now have introduced the 'struct pxafb_dma_buff' for DMA
descriptors and palettes, the allocation can be separated cleanly.

NOTE: the LCD DMA actually supports chained transfer (i.e. page-based
transfers), to simplify the logic and keep the performance (with less
TLB misses when accessing from memory mapped user space), the memory
is allocated by alloc_pages_*() to ensures it's physical contiguous.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 Documentation/fb/pxafb.txt             |    8 ++-
 arch/arm/mach-pxa/include/mach/pxafb.h |    1 +
 drivers/video/pxafb.c                  |  131 +++++++++++++-------------------
 drivers/video/pxafb.h                  |   17 +---
 4 files changed, 65 insertions(+), 92 deletions(-)

diff --git a/Documentation/fb/pxafb.txt b/Documentation/fb/pxafb.txt
index db9b850..ad94b5c 100644
--- a/Documentation/fb/pxafb.txt
+++ b/Documentation/fb/pxafb.txt
@@ -5,9 +5,13 @@ The driver supports the following options, either via
 options=<OPTIONS> when modular or video=pxafb:<OPTIONS> when built in.

 For example:
-	modprobe pxafb options=mode:640x480-8,passive
+	modprobe pxafb options=vmem:2M,mode:640x480-8,passive
 or on the kernel command line
-	video=pxafb:mode:640x480-8,passive
+	video=pxafb:vmem:2M,mode:640x480-8,passive
+
+vmem: VIDEO_MEM_SIZE
+	Amount of video memory to allocate (can be suffixed with K or M
+	for kilobytes or megabytes)

 mode:XRESxYRES[-BPP]
 	XRES == LCCR1_PPL + 1
diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h
b/arch/arm/mach-pxa/include/mach/pxafb.h
index 4201a88..6932720 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -113,6 +113,7 @@ struct pxafb_mach_info {
 	unsigned int num_modes;

 	unsigned int	lcd_conn;
+	unsigned long	video_mem_size;

 	u_int		fixed_modes:1,
 			cmap_inverse:1,
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index ab68959..25bf4b8 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -72,6 +72,8 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
 static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);

+static unsigned long video_mem_size = 0;
+
 static inline unsigned long
 lcd_readl(struct pxafb_info *fbi, unsigned int off)
 {
@@ -498,20 +500,6 @@ static int pxafb_blank(int blank, struct fb_info *info)
 	return 0;
 }

-static int pxafb_mmap(struct fb_info *info,
-		      struct vm_area_struct *vma)
-{
-	struct pxafb_info *fbi = (struct pxafb_info *)info;
-	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
-
-	if (off < info->fix.smem_len) {
-		vma->vm_pgoff += fbi->video_offset / PAGE_SIZE;
-		return dma_mmap_writecombine(fbi->dev, vma, fbi->map_cpu,
-					     fbi->map_dma, fbi->map_size);
-	}
-	return -EINVAL;
-}
-
 static struct fb_ops pxafb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= pxafb_check_var,
@@ -521,7 +509,6 @@ static struct fb_ops pxafb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= pxafb_blank,
-	.fb_mmap	= pxafb_mmap,
 };

 /*
@@ -614,7 +601,7 @@ static int setup_frame_dma(struct pxafb_info *fbi,
int dma, int pal,
 	dma_desc = &fbi->dma_buff->dma_desc[dma];
 	dma_desc_off = offsetof(struct pxafb_dma_buff, dma_desc[dma]);

-	dma_desc->fsadr = fbi->screen_dma + offset;
+	dma_desc->fsadr = fbi->video_mem_phys + offset;
 	dma_desc->fidr  = 0;
 	dma_desc->ldcmd = size;

@@ -1267,69 +1254,30 @@ static int pxafb_resume(struct platform_device *dev)
 #define pxafb_resume	NULL
 #endif

-/*
- * pxafb_map_video_memory():
- *      Allocates the DRAM memory for the frame buffer.  This buffer is
- *	remapped into a non-cached, non-buffered, memory region to
- *      allow palette and pixel writes to occur without flushing the
- *      cache.  Once this area is remapped, all virtual memory
- *      access to the video memory should occur at the new region.
- */
-static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
+static int __devinit pxafb_init_video_memory(struct pxafb_info *fbi)
 {
-	/*
-	 * We reserve one page for the palette, plus the size
-	 * of the framebuffer.
-	 */
-	fbi->video_offset = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
-	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset);
-	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
-					      &fbi->map_dma, GFP_KERNEL);
-
-	if (fbi->map_cpu) {
-		/* prevent initial garbage on screen */
-		memset(fbi->map_cpu, 0, fbi->map_size);
-		fbi->fb.screen_base = fbi->map_cpu + fbi->video_offset;
-		fbi->screen_dma = fbi->map_dma + fbi->video_offset;
-
-		/*
-		 * FIXME: this is actually the wrong thing to place in
-		 * smem_start.  But fbdev suffers from the problem that
-		 * it needs an API which doesn't exist (in this case,
-		 * dma_writecombine_mmap)
-		 */
-		fbi->fb.fix.smem_start = fbi->screen_dma;
-		fbi->palette_size = fbi->fb.var.bits_per_pixel == 8 ? 256 : 16;
-
-		fbi->dma_buff = (void *) fbi->map_cpu;
-		fbi->dma_buff_phys = fbi->map_dma;
-		fbi->palette_cpu = (u16 *) fbi->dma_buff->palette;
+	int size = PAGE_ALIGN(fbi->video_mem_size);

-	        pr_debug("pxafb: palette_mem_size = 0x%08x\n",
fbi->palette_size*sizeof(u16));
-	}
-
-	return fbi->map_cpu ? 0 : -ENOMEM;
-}
+	fbi->video_mem = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
+	if (fbi->video_mem == NULL)
+		return -ENOMEM;

-static void pxafb_decode_mode_info(struct pxafb_info *fbi,
-				   struct pxafb_mode_info *modes,
-				   unsigned int num_modes)
-{
-	unsigned int i, smemlen;
+	fbi->video_mem_phys = virt_to_phys(fbi->video_mem);
+	fbi->video_mem_size = size;

-	pxafb_setmode(&fbi->fb.var, &modes[0]);
+	fbi->fb.fix.smem_start	= fbi->video_mem_phys;
+	fbi->fb.fix.smem_len	= fbi->video_mem_size;
+	fbi->fb.screen_base	= fbi->video_mem;

-	for (i = 0; i < num_modes; i++) {
-		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
-		if (smemlen > fbi->fb.fix.smem_len)
-			fbi->fb.fix.smem_len = smemlen;
-	}
+	return fbi->video_mem ? 0 : -ENOMEM;
 }

 static void pxafb_decode_mach_info(struct pxafb_info *fbi,
 				   struct pxafb_mach_info *inf)
 {
 	unsigned int lcd_conn = inf->lcd_conn;
+	struct pxafb_mode_info *m;
+	int i;

 	fbi->cmap_inverse	= inf->cmap_inverse;
 	fbi->cmap_static	= inf->cmap_static;
@@ -1371,7 +1319,22 @@ static void pxafb_decode_mach_info(struct
pxafb_info *fbi,
 	fbi->lccr3 |= (lcd_conn & LCD_PCLK_EDGE_FALL)  ? LCCR3_PCP : 0;

 decode_mode:
-	pxafb_decode_mode_info(fbi, inf->modes, inf->num_modes);
+	pxafb_setmode(&fbi->fb.var, &inf->modes[0]);
+
+	/* decide video memory size as follows:
+	 * 1. default to mode of maximum resolution
+	 * 2. allow platform to override
+	 * 3. allow module parameter to override
+	 */
+	for (i = 0, m = &inf->modes[0]; i < inf->num_modes; i++, m++)
+		fbi->video_mem_size = max_t(size_t, fbi->video_mem_size,
+				m->xres * m->yres * m->bpp / 8);
+
+	if (inf->video_mem_size > fbi->video_mem_size)
+		fbi->video_mem_size = inf->video_mem_size;
+
+	if (video_mem_size > fbi->video_mem_size)
+		fbi->video_mem_size = video_mem_size;
 }

 static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
@@ -1499,7 +1462,9 @@ static int __devinit parse_opt(struct device
*dev, char *this_opt)

 	s[0] = '\0';

-	if (!strncmp(this_opt, "mode:", 5)) {
+	if (!strncmp(this_opt, "vmem:", 5)) {
+		video_mem_size = memparse(this_opt + 5, NULL);
+	} else if (!strncmp(this_opt, "mode:", 5)) {
 		return parse_opt_mode(dev, this_opt);
 	} else if (!strncmp(this_opt, "pixclock:", 9)) {
 		mode->pixclock = simple_strtoul(this_opt+9, NULL, 0);
@@ -1736,12 +1701,20 @@ static int __devinit pxafb_probe(struct
platform_device *dev)
 		goto failed_free_res;
 	}

-	/* Initialize video memory */
-	ret = pxafb_map_video_memory(fbi);
+	fbi->dma_buff_size = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
+	fbi->dma_buff = dma_alloc_coherent(fbi->dev, fbi->dma_buff_size,
+				&fbi->dma_buff_phys, GFP_KERNEL);
+	if (fbi->dma_buff == NULL) {
+		dev_err(&dev->dev, "failed to allocate memory for DMA\n");
+		ret = -ENOMEM;
+		goto failed_free_io;
+	}
+
+	ret = pxafb_init_video_memory(fbi);
 	if (ret) {
 		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
-		goto failed_free_io;
+		goto failed_free_dma;
 	}

 	irq = platform_get_irq(dev, 0);
@@ -1811,8 +1784,10 @@ failed_free_cmap:
 failed_free_irq:
 	free_irq(irq, fbi);
 failed_free_mem:
-	dma_free_writecombine(&dev->dev, fbi->map_size,
-			fbi->map_cpu, fbi->map_dma);
+	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
+failed_free_dma:
+	dma_free_coherent(&dev->dev, fbi->dma_buff_size,
+			fbi->dma_buff, fbi->dma_buff_phys);
 failed_free_io:
 	iounmap(fbi->mmio_base);
 failed_free_res:
@@ -1847,8 +1822,10 @@ static int __devexit pxafb_remove(struct
platform_device *dev)
 	irq = platform_get_irq(dev, 0);
 	free_irq(irq, fbi);

-	dma_free_writecombine(&dev->dev, fbi->map_size,
-					fbi->map_cpu, fbi->map_dma);
+	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
+
+	dma_free_writecombine(&dev->dev, fbi->dma_buff_size,
+			fbi->dma_buff, fbi->dma_buff_phys);

 	iounmap(fbi->mmio_base);

diff --git a/drivers/video/pxafb.h b/drivers/video/pxafb.h
index d8eb93f..0981938 100644
--- a/drivers/video/pxafb.h
+++ b/drivers/video/pxafb.h
@@ -69,24 +69,15 @@ struct pxafb_info {
 	void __iomem		*mmio_base;

 	struct pxafb_dma_buff	*dma_buff;
+	size_t			dma_buff_size;
 	dma_addr_t		dma_buff_phys;
 	dma_addr_t		fdadr[DMA_MAX];

-	/*
-	 * These are the addresses we mapped
-	 * the framebuffer memory region to.
-	 */
-	/* raw memory addresses */
-	dma_addr_t		map_dma;	/* physical */
-	u_char *		map_cpu;	/* virtual */
-	u_int			map_size;
-
-	/* addresses of pieces placed in raw buffer */
-	u_char *		screen_cpu;	/* virtual address of frame buffer */
-	dma_addr_t		screen_dma;	/* physical address of frame buffer */
+	void __iomem		*video_mem;	/* virtual address of frame buffer */
+	unsigned long		video_mem_phys;	/* physical address of frame buffer */
+	size_t			video_mem_size;	/* size of the frame buffer */
 	u16 *			palette_cpu;	/* virtual address of palette memory */
 	u_int			palette_size;
-	ssize_t			video_offset;

 	u_int			lccr0;
 	u_int			lccr3;
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
