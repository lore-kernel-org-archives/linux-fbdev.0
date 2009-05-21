From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] fb: add support of LCD display
	controller on	pxa168/910 (base layer)
Date: Thu, 21 May 2009 10:41:57 +0100
Message-ID: <20090521094157.GA24078@n2100.arm.linux.org.uk>
References: <f17812d70905210203se23d5e7ya60cbb6eb93815aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69) (envelope-from
	<linux+linux-fbdev-devel=lists.sourceforge.net@arm.linux.org.uk>)
	id 1M74nM-000395-PH for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 May 2009 09:42:36 +0000
Received: from caramon.arm.linux.org.uk ([78.32.30.218])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M74mz-00044V-Ad
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 May 2009 09:42:36 +0000
Content-Disposition: inline
In-Reply-To: <f17812d70905210203se23d5e7ya60cbb6eb93815aa@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Green Wan <gwan@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Jun Nie <njun@marvell.com>, Peter Liao <pliao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Lennert Buijtenhek <buytenh@marvell.com>, Kevin Liu <kliu5@marvell.com>

On Thu, May 21, 2009 at 05:03:33PM +0800, Eric Miao wrote:
> +	/* check whether divisor is too small. */
> +	if (divider_int < 2) {
> +		printk(KERN_WARNING "Warning: clock source is too slow."
> +				 "Try smaller resolution\n");

dev_warn() ?

> +static void set_dma_control1(struct pxa168fb_info *fbi, int sync)
> +{
> +	u32 x;
> +
> +	/*
> +	 * Configure default bits: vsync triggers DMA, gated clock
> +	 * enable, power save enable, configure alpha registers to
> +	 * display 100% graphics, and set pixel command.
> +	 */
> +	x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL1);
> +	x |= 0x2032ff81;
> +
> +	/*
> +	 * We trigger DMA on the falling edge of vsync if vsync is
> +	 * active low, or on the rising edge if vsync is active high.
> +	 */
> +	if (!(sync & FB_SYNC_VERT_HIGH_ACT))
> +		x |= 0x08000000;
> +
> +

Unnecessary double-blank line.

> +static int pxa168fb_set_par(struct fb_info *info)
> +{
> +	struct pxa168fb_info *fbi = info->par;
> +	struct fb_var_screeninfo *var = &info->var;
> +	const struct fb_videomode *m = 0;

 = NULL, not = 0, though is 'm' required...

> +	struct fb_videomode mode;
> +	int pix_fmt;
> +	u32 x;
> +	struct pxa168fb_mach_info *mi;
> +
> +	mi = fbi->dev->platform_data;
> +	/*
> +	 * Determine which pixel format we're going to use.
> +	 */
> +	pix_fmt = determine_best_pix_fmt(&info->var);
> +	if (pix_fmt < 0)
> +		return pix_fmt;
> +	fbi->pix_fmt = pix_fmt;
> +
> +	/*
> +	 * Set additional mode info.
> +	 */
> +	if (pix_fmt == PIX_FMT_PSEUDOCOLOR)
> +		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> +	else
> +		info->fix.visual = FB_VISUAL_TRUECOLOR;
> +	info->fix.line_length = var->xres_virtual * var->bits_per_pixel / 8;
> +	info->fix.ypanstep = var->yres;
> +
> +	/*
> +	 * Disable panel output while we setup the display.
> +	 */
> +	x = readl(fbi->reg_base + LCD_SPU_DUMB_CTRL);
> +	writel(x & ~1, fbi->reg_base + LCD_SPU_DUMB_CTRL);
> +
> +	/*
> +	 * Configure global panel parameters.
> +	 */
> +	writel((var->yres << 16) | var->xres,
> +		fbi->reg_base + LCD_SPU_V_H_ACTIVE);
> +
> +	/*
> +	 * convet var to video mode
> +	 */
> +	fb_var_to_videomode(&mode, &info->var);
> +	m = &mode;

since this seems to be its only use.

> +static irqreturn_t pxa168fb_handle_irq(int irq, void *dev_id)
> +{
> +	struct pxa168fb_info *fbi = (struct pxa168fb_info *)dev_id;

Casts from void * to another pointer are never required.

> +	u32     isr;
> +
> +	isr = readl(fbi->reg_base+SPU_IRQ_ISR);
> +
> +	if ((isr & GRA_FRAME_IRQ0_ENA_MASK)) {
> +		/* wake up queue. */
> +		atomic_set(&fbi->w_intr, 1);

w_intr seems to be a write only variable and can therefore be removed.

> +static int pxa168fb_init_mode(struct fb_info *info,
> +			      struct pxa168fb_mach_info *mi)
> +{
> +	struct pxa168fb_info *fbi = info->par;
> +	struct fb_var_screeninfo *var = &info->var;
> +	int ret = 0;
> +	u32 total_w, total_h, refresh;
> +	u64 div_result;
> +	const struct fb_videomode *m;
> +
> +	/*
> +	 * Set default value
> +	 */
> +	refresh = DEFAULT_REFRESH;
> +
> +	/*
> +	 * If has bootargs, apply it first.
> +	 */
> +	if (fbi->dft_vmode.xres && fbi->dft_vmode.yres &&
> +	    fbi->dft_vmode.refresh) {
> +		/* set data according bootargs */
> +		var->xres = fbi->dft_vmode.xres;
> +		var->yres = fbi->dft_vmode.yres;
> +		refresh = fbi->dft_vmode.refresh;
> +	}
> +
> +	/* try to find best video mode. */
> +	m = fb_find_best_mode(&info->var, &info->modelist);
> +	if (m)
> +		fb_videomode_to_var(&info->var, m);
> +
> +	/* Init settings. */
> +	var->xres_virtual = var->xres;
> +	var->yres_virtual = fbi->fb_size /
> +		(var->xres_virtual * (var->bits_per_pixel >> 3));
> +	printk("pxa168fb: find best mode: res = %dx%d\n", var->xres, var->yres);

dev_debug() ?

> +static int __init pxa168fb_probe(struct platform_device *pdev)
> +{
> +	struct pxa168fb_mach_info *mi;
> +	struct fb_info *info = 0;
> +	struct pxa168fb_info *fbi = 0;
> +	struct resource *res;
> +	struct clk *clk;
> +	int irq, ret;
> +
> +	mi = pdev->dev.platform_data;
> +	if (mi == NULL) {
> +		dev_err(&pdev->dev, "no platform data defined\n");
> +		return -EINVAL;
> +	}
> +
> +	clk = clk_get(&pdev->dev, "LCDCLK");
> +	if (IS_ERR(clk)) {
> +		dev_err(&pdev->dev, "unable to get LCDCLK");
> +		return PTR_ERR(clk);
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(&pdev->dev, "no IO memory defined\n");
> +		return -ENOENT;
> +	}
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no IRQ defined\n");
> +		return -ENOENT;
> +	}
> +
> +	info = framebuffer_alloc(sizeof(struct pxa168fb_info), &pdev->dev);
> +	if (info == NULL)
> +		return -ENOMEM;
> +
> +	/* Initialize private data */
> +	fbi = info->par;
> +	platform_set_drvdata(pdev, fbi);
> +	fbi->clk = clk;
> +	fbi->dev = &pdev->dev;

This duplicates info->device.

> +	fbi->panel_rbswap = mi->panel_rbswap;
> +	fbi->is_blanked = 0;
> +	fbi->debug = 0;

Write only variable.

> +	fbi->active = mi->active;
> +	init_waitqueue_head(&fbi->w_intr_wq);
> +
> +	/*
> +	 * Initialise static fb parameters.
> +	 */
> +	info->flags = FBINFO_DEFAULT | FBINFO_PARTIAL_PAN_OK |
> +		      FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
> +	info->node = -1;
> +	strcpy(info->fix.id, mi->id);

strlcpy() ?

> +	info->fix.type = FB_TYPE_PACKED_PIXELS;
> +	info->fix.type_aux = 0;
> +	info->fix.xpanstep = 0;
> +	info->fix.ypanstep = 0;
> +	info->fix.ywrapstep = 0;
> +	info->fix.mmio_start = res->start;
> +	info->fix.mmio_len = res->end - res->start + 1;
> +	info->fix.accel = FB_ACCEL_NONE;
> +	info->fbops = &pxa168fb_ops;
> +	info->pseudo_palette = fbi->pseudo_palette;
> +
> +	/*
> +	 * Map LCD controller registers.
> +	 */
> +	fbi->reg_base = ioremap_nocache(res->start, res->end - res->start);
> +	if (fbi->reg_base == NULL) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	/*
> +	 * Allocate framebuffer memory.
> +	 */
> +	fbi->fb_size = PAGE_ALIGN(DEFAULT_FB_SIZE);
> +
> +	fbi->fb_start = dma_alloc_writecombine(fbi->dev, fbi->fb_size,
> +						&fbi->fb_start_dma,
> +						GFP_KERNEL);
> +	if (fbi->fb_start == NULL) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	memset(fbi->fb_start, 0, fbi->fb_size);

Wasn't there a patch recently removing memset after dma_alloc_* ?  In
any case, the buffer is already zeroed so this additional memset is not
required.

> +	info->fix.smem_start = fbi->fb_start_dma;
> +	info->fix.smem_len = fbi->fb_size;
> +	info->screen_base = fbi->fb_start;
> +	info->screen_size = fbi->fb_size;
> +
> +	/*
> +	 * Set video mode according to platform data.
> +	 */
> +	set_mode(fbi, &info->var, mi->modes, mi->pix_fmt, 1);
> +
> +	fb_videomode_to_modelist(mi->modes, mi->num_modes, &info->modelist);
> +
> +	/*
> +	 * init video mode data.
> +	 */
> +	pxa168fb_init_mode(info, mi);
> +
> +	/*
> +	 * enable controller clock
> +	 */
> +	clk_enable(fbi->clk);
> +
> +	/*
> +	 * Fill in sane defaults.
> +	 */
> +	pxa168fb_set_par(info);
> +
> +	/*
> +	 * Configure default register values.
> +	 */
> +	writel(0x00000000, fbi->reg_base + LCD_SPU_BLANKCOLOR);
> +	writel(mi->io_pin_allocation_mode, fbi->reg_base + SPU_IOPAD_CONTROL);
> +	writel(0x00000000, fbi->reg_base + LCD_CFG_GRA_START_ADDR1);
> +	writel(0x00000000, fbi->reg_base + LCD_SPU_GRA_OVSA_HPXL_VLN);
> +	writel(0x0, fbi->reg_base + LCD_SPU_SRAM_PARA0);

Hmm, why 8 digits for some zeros, and only 1 digit for others?

> +	writel(CFG_CSB_256x32(0x1)|CFG_CSB_256x24(0x1)|CFG_CSB_256x8(0x1),
> +		fbi->reg_base + LCD_SPU_SRAM_PARA1);
> +
> +	/*
> +	 * Allocate color map.
> +	 */
> +	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
> +		ret = -ENOMEM;
> +		goto failed_free_clk;
> +	}
> +
> +	/*
> +	 * Register irq handler.
> +	 */
> +	ret = request_irq(irq, pxa168fb_handle_irq, IRQF_SHARED, mi->id, fbi);

Why not use info->fix.id here?

> diff --git a/drivers/video/pxa168fb.h b/drivers/video/pxa168fb.h
> new file mode 100644
> index 0000000..a43a10b
> --- /dev/null
> +++ b/drivers/video/pxa168fb.h
> @@ -0,0 +1,558 @@
> +#ifndef __PXA168FB_H__
> +#define __PXA168FB_H__
> +
> +/* ------------< LCD register >------------ */
> +/* Video Frame 0&1 start address registers */
> +#define	LCD_SPU_DMA_START_ADDR_Y0	0x00C0
> +#define	LCD_SPU_DMA_START_ADDR_U0	0x00C4
> +#define	LCD_SPU_DMA_START_ADDR_V0	0x00C8
> +#define LCD_CFG_DMA_START_ADDR_0	0x00CC /* Cmd address */
> +#define	LCD_SPU_DMA_START_ADDR_Y1	0x00D0
> +#define	LCD_SPU_DMA_START_ADDR_U1	0x00D4
> +#define	LCD_SPU_DMA_START_ADDR_V1	0x00D8
> +#define LCD_CFG_DMA_START_ADDR_1	0x00DC /* Cmd address */
> +
> +/* YC & UV Pitch */
> +#define LCD_SPU_DMA_PITCH_YC		0x00E0
> +#define     SPU_DMA_PITCH_C(c)		(c<<16)

Ouch.  Think what happens if you do this:

	SPU_DMA_PITCH_C(1 + 2)

It ends up as:

	1 + 2 << 16

which is surely not what you want.  If you do anything with macro arguments
it's always a good idea to put parens around them.

> diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
> new file mode 100644
> index 0000000..59c4a1b
> --- /dev/null
> +++ b/include/video/pxa168fb.h
> @@ -0,0 +1,138 @@
> +/*
> + * linux/arch/arm/mach-mmp/include/mach/pxa168fb.h
> + *
> + *  Copyright (C) 2009 Marvell International Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MACH_PXA168FB_H
> +#define __ASM_MACH_PXA168FB_H
> +
> +#include <linux/fb.h>
> +#include <linux/interrupt.h>
> +
> +/* Dumb interface */
> +#define PIN_MODE_DUMB_24		0
> +#define PIN_MODE_DUMB_18_SPI		1
> +#define PIN_MODE_DUMB_18_GPIO		2
> +#define PIN_MODE_DUMB_16_SPI		3
> +#define PIN_MODE_DUMB_16_GPIO		4
> +#define PIN_MODE_DUMB_12_SPI_GPIO	5
> +#define PIN_MODE_SMART_18_SPI		6
> +#define PIN_MODE_SMART_16_SPI		7
> +#define PIN_MODE_SMART_8_SPI_GPIO	8
> +
> +/* Dumb interface pin allocation */
> +#define DUMB_MODE_RGB565		0
> +#define DUMB_MODE_RGB565_UPPER		1
> +#define DUMB_MODE_RGB666		2
> +#define DUMB_MODE_RGB666_UPPER		3
> +#define DUMB_MODE_RGB444		4
> +#define DUMB_MODE_RGB444_UPPER		5
> +#define DUMB_MODE_RGB888		6
> +
> +/* default fb buffer size WVGA-32bits */
> +#define DEFAULT_FB_SIZE	(800 * 480 * 4)
> +
> +/*
> + * Buffer pixel format
> + * bit0 is for rb swap.
> + * bit12 is for Y UorV swap
> + */
> +#define PIX_FMT_RGB565		0
> +#define PIX_FMT_BGR565		1
> +#define PIX_FMT_RGB1555		2
> +#define PIX_FMT_BGR1555		3
> +#define PIX_FMT_RGB888PACK	4
> +#define PIX_FMT_BGR888PACK	5
> +#define PIX_FMT_RGB888UNPACK	6
> +#define PIX_FMT_BGR888UNPACK	7
> +#define PIX_FMT_RGBA888		8
> +#define PIX_FMT_BGRA888		9
> +#define PIX_FMT_YUV422PACK	10
> +#define PIX_FMT_YVU422PACK	11
> +#define PIX_FMT_YUV422PLANAR	12
> +#define PIX_FMT_YVU422PLANAR	13
> +#define PIX_FMT_YUV420PLANAR	14
> +#define PIX_FMT_YVU420PLANAR	15
> +#define PIX_FMT_PSEUDOCOLOR	20
> +#define PIX_FMT_UYVY422PACK	(0x1000|PIX_FMT_YUV422PACK)
> +
> +/*
> + * PXA LCD controller private state.
> + */
> +struct pxa168fb_info {
> +	struct device		*dev;
> +	struct clk		*clk;
> +
> +	void			*reg_base;

Should be void __iomem *, not void *.

> +	unsigned long		new_addr;

Unused.

> +	dma_addr_t		fb_start_dma;
> +	void			*fb_start;
> +	int			fb_size;
> +	atomic_t		w_intr;

Write only.

> +	wait_queue_head_t	w_intr_wq;

Only initialized/woken up.  Nothing sleeps on this wait queue.  Is it
needed?

> +	struct mutex		access_ok;

Unused.

> +	struct fb_videomode	dft_vmode;

This seems to be read only and never written.

> +	unsigned char		*hwc_buf;

Unused.

> +	unsigned int		pseudo_palette[16];

This is supposed to be a 'u32' type.

> +	struct tasklet_struct	tasklet;

Unused.

> +	char *mode_option;

Unused.

> +
> +	int			pix_fmt;
> +	unsigned		is_blanked:1;
> +	unsigned		panel_rbswap:1;
> +	unsigned		debug:1;

Write only variable.

> +	unsigned		active:1;
> +};
> +
> +/*
> + * PXA fb machine information
> + */
> +struct pxa168fb_mach_info {
> +	char	id[16];
> +	unsigned int	sclk_clock;

Unused.

> +
> +	int		num_modes;
> +	struct fb_videomode *modes;
> +
> +	/*
> +	 * Pix_fmt
> +	 */
> +	unsigned	pix_fmt;
> +
> +	/*
> +	 * I/O pin allocation.
> +	 */
> +	unsigned	io_pin_allocation_mode:4;
> +
> +	/*
> +	 * Dumb panel -- assignment of R/G/B component info to the 24
> +	 * available external data lanes.
> +	 */
> +	unsigned	dumb_mode:4;
> +	unsigned	panel_rgb_reverse_lanes:1;
> +
> +	/*
> +	 * Dumb panel -- GPIO output data.
> +	 */
> +	unsigned	gpio_output_mask:8;
> +	unsigned	gpio_output_data:8;
> +
> +	/*
> +	 * Dumb panel -- configurable output signal polarity.
> +	 */
> +	unsigned	invert_composite_blank:1;
> +	unsigned	invert_pix_val_ena:1;
> +	unsigned	invert_pixclock:1;
> +	unsigned	invert_vsync:1;
> +	unsigned	invert_hsync:1;
> +	unsigned	panel_rbswap:1;
> +	unsigned	active:1;
> +	unsigned	enable_lcd:1;
> +};
> +
> +#endif /* __ASM_MACH_PXA168FB_H */
> -- 
> 1.6.0.4
> 
> 
> -- 
> Cheers
> - eric
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
