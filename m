From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Silicon motion 501 driver
Date: Wed, 24 May 2006 08:05:23 +0800
Message-ID: <4473A343.8080205@gmail.com>
References: <20060514223741.GB20765@kyllikki.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Figsj-0004Iz-RF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 17:05:45 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Figsg-0004YL-93
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 May 2006 17:05:45 -0700
Received: by py-out-1112.google.com with SMTP id z59so2026089pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 May 2006 17:05:41 -0700 (PDT)
In-Reply-To: <20060514223741.GB20765@kyllikki.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: vince@simtec.co.uk

Vincent Sanders wrote:
> Attached you will find a first cut of a driver for the silicon motion
> SM501 mobile multimedia companion chip.
> 
> The driver actually breaks down into a "base" driver for all the
> available functions and a framebuffer driver for the video elements.
> 
> Although there is still several TODO in the framebuffer driver it does
> work as is, in dual headed configuration, for both PCI and localbus
> configurations.
> 
> Comments and patches gratefully received, I don't know how much more
> complete a driver has to be for consideration for mainline merge but
> that is the ultimate aim.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> diff -urN linux-2.6.16-orig/drivers/base/Makefile linux-2.6.16-sm501/drivers/base/Makefile
> --- linux-2.6.16-orig/drivers/base/Makefile	2006-03-20 05:53:29.000000000 +0000
> +++ linux-2.6.16-sm501/drivers/base/Makefile	2006-04-11 12:51:08.000000000 +0100
> @@ -10,6 +10,8 @@
>  obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o
>  obj-$(CONFIG_SMP)	+= topology.o
>  
> +obj-m			+= sm501.o
> +
>  ifeq ($(CONFIG_DEBUG_DRIVER),y)
>  EXTRA_CFLAGS += -DDEBUG
>  endif
> diff -urN linux-2.6.16-orig/drivers/base/sm501.c linux-2.6.16-sm501/drivers/base/sm501.c
> --- linux-2.6.16-orig/drivers/base/sm501.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-sm501/drivers/base/sm501.c	2006-05-14 19:09:03.000000000 +0100
> @@ -0,0 +1,843 @@
> +/* linux/drivers/base/sm501.c

Better if the patch is broken so this file is separate from the fb driver...
I won't comment on this part.

<snip>

>
> diff -urN linux-2.6.16-orig/drivers/video/Kconfig linux-2.6.16-sm501/drivers/video/Kconfig
> --- linux-2.6.16-orig/drivers/video/Kconfig	2006-03-20 05:53:29.000000000 +0000
> +++ linux-2.6.16-sm501/drivers/video/Kconfig	2006-04-20 15:43:27.000000000 +0100
> @@ -1426,6 +1426,13 @@
>  	  Turn on debugging messages. Note that you can set/unset at run time
>  	  through sysfs
>  
> +config FB_SM501
> +	tristate "Silicon Motion SM501"
> +	depends on FB
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT	
> +
>  config FB_VIRTUAL
>  	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
>  	depends on FB
> diff -urN linux-2.6.16-orig/drivers/video/Makefile linux-2.6.16-sm501/drivers/video/Makefile
> --- linux-2.6.16-orig/drivers/video/Makefile	2006-03-20 05:53:29.000000000 +0000
> +++ linux-2.6.16-sm501/drivers/video/Makefile	2006-04-20 15:28:55.000000000 +0100
> @@ -94,6 +94,7 @@
>  obj-$(CONFIG_FB_S1D13XXX)	  += s1d13xxxfb.o
>  obj-$(CONFIG_FB_IMX)              += imxfb.o
>  obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
> +obj-$(CONFIG_FB_SM501)		  += sm501-fb.o
>  
>  # Platform or fallback drivers go here
>  obj-$(CONFIG_FB_VESA)             += vesafb.o
> diff -urN linux-2.6.16-orig/drivers/video/sm501-fb.c linux-2.6.16-sm501/drivers/video/sm501-fb.c
> --- linux-2.6.16-orig/drivers/video/sm501-fb.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-sm501/drivers/video/sm501-fb.c	2006-05-14 23:06:23.000000000 +0100
> @@ -0,0 +1,1505 @@
> +/* linux/drivers/video/sm501-fb.c
> + *
> + * Copyright (c) 2006 Simtec Electronics
> + *	Vincent Sanders <vince@simtec.co.uk>
> + *	Ben Dooks <ben@simtec.co.uk>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Frambuffer driver for the Silicon Motion 501
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/tty.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/workqueue.h>
> +#include <linux/wait.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +
> +#include <asm/io.h>
> +#include <asm/uaccess.h>
> +#include <asm/div64.h>
> +
> +#ifdef CONFIG_PM
> +#include <linux/pm.h>
> +#endif
> +
> +#include <linux/sm501.h>
> +#include <linux/sm501-regs.h>
> +
> +#define NR_PALETTE 256
> +
> +#define HEAD_CRT	(0)
> +#define HEAD_PANNEL	(1)
> +
> +static unsigned int debug;
> +#define dprintk(msg...)	if (debug) { printk(KERN_DEBUG "sm501-fb: " msg); }
> +
> +/* SM501 memory adress */
> +struct sm501_mem {
> +	unsigned long	 sm_addr;
> +	void __iomem	*k_addr;
> +};
> +
> +/* private data that is shared between all frambuffers* */
> +struct sm501fb_info {
> +	struct device		*dev;
> +	struct fb_info		*fb[2];		/* fb info for both heads */
> +	struct resource		*fbmem_res;	/* framebuffer resource */
> +	struct resource		*regs_res;	/* registers resource */
> +
> +	int			 irq;
> +	void __iomem		*regs;		/* remapped registers */
> +	void __iomem		*fbmem;		/* remapped framebuffer */
> +	size_t			 fbmem_len;	/* length of remapped region */
> +};
> +
> +/* per-framebuffer private data */
> +struct sm501fb_par {
> +	u32			 pseudo_palette[16];
> +
> +	struct sm501_mem	 cursor;
> +	struct sm501_mem	 screen;
> +
> +	void __iomem		*cursor_regs;
> +	struct sm501fb_info	*info;
> +};
> +
> +/* sm501_alloc_mem
> + *
> + * This is an attempt to lay out memory for the two framebuffers and
> + * everything else
> + *
> + * |fbmem_res->start	                                       fbmem_res->end|
> + * |                                                                         |
> + * |fb[0].fix.smem_start    |         |fb[1].fix.smem_start    |     2K      |
> + * |-> fb[0].fix.smem_len <-| spare   |-> fb[1].fix.smem_len <-|-> cursors <-|
> + *
> + * The "spare" space is for the 2d engine data
> + * the fixed is space for the cursors (2x1Kbyte)
> + *
> + * we need to allocate memory for the 2D acceleration engine
> + * command list and the data for the engine to deal with.
> + *
> + * - all allocations must be 128bit aligned
> + * - cursors are 64x64x2 bits (1Kbyte)
> + *
> + */
> +
> +#define SM501_MEMF_CURSOR		(1)
> +#define SM501_MEMF_PANNEL		(2)
> +#define SM501_MEMF_CRT			(4)
> +#define SM501_MEMF_ACCEL		(8)
> +
> +int sm501_alloc_mem(struct sm501fb_info *inf, struct sm501_mem *mem,
> +		    unsigned int why, size_t size)
> +{
> +	unsigned int ptr = 0;
> +
> +	switch (why) {
> +	case SM501_MEMF_CURSOR:
> +		ptr = inf->fbmem_len - size;
> +		inf->fbmem_len = ptr;
> +		break;
> +
> +	case SM501_MEMF_PANNEL:
> +		ptr = inf->fbmem_len - size;
> +		if (ptr < inf->fb[0]->fix.smem_len)
> +			return -ENOMEM;
> +
> +		break;
> +
> +	case SM501_MEMF_CRT:
> +		ptr = 0;
> +		break;
> +
> +	case SM501_MEMF_ACCEL:
> +		ptr = inf->fb[0]->fix.smem_len;
> +
> +		if ((ptr + size) >
> +		    (inf->fb[1]->fix.smem_start - inf->fbmem_res->start))
> +			return -ENOMEM;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mem->sm_addr = ptr;
> +	mem->k_addr  = inf->fbmem + ptr;
> +
> +	printk("%s: result %08lx, %p - %u, %zd\n", __FUNCTION__,
> +	       mem->sm_addr, mem->k_addr, why, size);
> +
> +	return 0;
> +}
> +
> +/* sm501fb_ps_to_hz
> + *
> + * Converts a period in picoseconds to Hz
> + */
> +static unsigned long sm501fb_ps_to_hz(unsigned long psvalue)
> +{
> +	unsigned long long numerator=1000000000000ULL;
> +
> +	/* 10^12 / picosecond period gives frequency in Hz */
> +	do_div(numerator, psvalue);
> +	return (unsigned long)numerator;
> +}

You can use the macro PICOS2KHZ() macro in include/linux/fb.h, assuming
the driver can tolerate a granularity of 1000.

> +
> +/* sm501fb_setup_gamma
> + *
> + * Programs a linear 1.0 gamma ramp
> + */
> +static void sm501fb_setup_gamma(struct sm501fb_info *fbi,
> +				unsigned long palette)
> +{
> +	unsigned long value=0;
> +	int offset;
> +
> +	/* set gamma values */
> +	for(offset=0;offset < 256 * 4; offset += 4) {
> +		writel(value, fbi->regs + palette + offset);
> +		/* Advance RGB by 1,1,1.*/
> +		value += 0x010101;
> +	}
> +}
> +
> +/*
> + * sm501fb_check_var_crt():
> + *
> + * Checks the parameters in var can be achived on the CRT, If a
> + *   value doesn't fit, round it up, if it's too big, return -EINVAL.
> + */
> +static int sm501fb_check_var_crt(struct fb_var_screeninfo *var,
> +				 struct fb_info *info)
> +{
> +
> +	dprintk("check_var(var=%p, info=%p)\n", var, info);
> +
> +	/* TODO - limit CRT DAC bandwidth to 200MHz
> +	 *	- limit memory usage across both screens
> +	 * 	- limit memory bandwidth between both screens
> +	 */
> +
> +	var->xres_virtual=var->xres;
> +	var->yres_virtual=var->yres;
> +
> +	/* can cope with 8,16 or 32bpp */
> +	if (var->bits_per_pixel <= 8)
> +		var->bits_per_pixel = 8;
> +	else if (var->bits_per_pixel <= 16)
> +		var->bits_per_pixel = 16;
> +	else
> +		var->bits_per_pixel = 32;
> +
> +	/* set r/g/b positions and validate bpp */
> +	switch(var->bits_per_pixel) {
> +	case 8:
> +		var->red.length		= var->bits_per_pixel;
> +		var->red.offset		= 0;
> +		var->green.length	= var->bits_per_pixel;
> +		var->green.offset	= 0;
> +		var->blue.length	= var->bits_per_pixel;
> +		var->blue.offset	= 0;
> +		var->transp.length	= 0;
> +
> +		break;
> +
> +	case 16:
> +		var->red.offset		= 11;
> +		var->green.offset	= 5;
> +		var->blue.offset	= 0;
> +		var->red.length		= 5;
> +		var->green.length	= 6;
> +		var->blue.length	= 5;
> +		var->transp.length	= 0;
> +
> +		break;
> +
> +	case 32:
> +		var->transp.offset	= 0;
> +		var->transp.length	= 0;
> +		var->red.offset		= 16;
> +		var->red.length		= 8;
> +		var->green.offset	= 8;
> +		var->green.length	= 8;
> +		var->blue.offset	= 0;
> +		var->blue.length	= 8;
> +
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* hard limits of device */
> +	if((var->xres + var->left_margin + var->right_margin + var->hsync_len) > 4096)
> +		return -EINVAL;
> +
> +	if((var->yres + var->upper_margin + var->lower_margin + var->vsync_len) > 2048)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * sm501fb_check_var_pnl():
> + *
> + * Checks the parameters in var can be achived on the panel, If a
> + *   value doesn't fit, round it up, if it's too big, return -EINVAL.
> + */
> +static int sm501fb_check_var_pnl(struct fb_var_screeninfo *var,
> +				 struct fb_info *info)
> +{
> +	dprintk("check_var(var=%p, info=%p)\n", var, info);
> +
> +	/* TODO - limit to DAC bandwidth
> +	 *	- limit memory usage across both screens
> +	 * 	- limit memory bandwidth between both screens
> +	 *	- limit panel to platform data specified parameters
> +	 */
> +
> +	var->xres_virtual=var->xres;
> +	var->yres_virtual=var->yres;
> +
> +	/* can cope with 8,16 or 32bpp */
> +	if (var->bits_per_pixel <= 8)
> +		var->bits_per_pixel = 8;
> +	else if (var->bits_per_pixel <= 16)
> +		var->bits_per_pixel = 16;
> +	else
> +		var->bits_per_pixel = 32;
> +
> +	/* set r/g/b positions and validate bpp */
> +	switch(var->bits_per_pixel) {
> +	case 8:
> +		var->red.length		= var->bits_per_pixel;
> +		var->red.offset		= 0;
> +		var->green.length	= var->bits_per_pixel;
> +		var->green.offset	= 0;
> +		var->blue.length	= var->bits_per_pixel;
> +		var->blue.offset	= 0;
> +		var->transp.length	= 0;
> +		break;
> +
> +	case 16:
> +		var->red.offset		= 11;
> +		var->green.offset	= 5;
> +		var->blue.offset	= 0;
> +		var->red.length		= 5;
> +		var->green.length	= 6;
> +		var->blue.length	= 5;
> +		var->transp.length	= 0;
> +		break;
> +
> +	case 32:
> +		var->transp.offset   = 0;
> +		var->transp.length   = 0;
> +		var->red.offset      = 16;
> +		var->red.length      = 8;
> +		var->green.offset    = 8;
> +		var->green.length    = 8;
> +		var->blue.offset     = 0;
> +		var->blue.length     = 8;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* hard limits of device */
> +	if((var->xres + var->left_margin + var->right_margin + var->hsync_len) > 4096)
> +		return -EINVAL;
> +
> +	if((var->yres + var->upper_margin + var->lower_margin + var->vsync_len) > 2048)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * sm501fb_set_par_crt
> + * @info: frame buffer structure that represents the CRT framebuffer
> + *
> + * Sets the CRT video mode as per the data in the fb_info structure
> + */
> +static int sm501fb_set_par_crt(struct fb_info *info)
> +{
> +	struct sm501fb_par  *par = info->par;
> +	struct sm501fb_info *fbi = par->info;
> +	struct fb_var_screeninfo *var = &info->var;
> +	unsigned long pixclock;      /* pixelclock in Hz */
> +	unsigned long sm501pixclock; /* pixelclock the 501 can achive in Hz */
> +	unsigned long control;       /* control register */
> +
> +	/* activate new configuration */
> +
> +	dprintk("%s: var->xres  = %d\n", __FUNCTION__, var->xres);
> +	dprintk("%s: var->yres  = %d\n", __FUNCTION__, var->yres);
> +	dprintk("%s: var->bpp   = %d\n", __FUNCTION__, var->bits_per_pixel);
> +
> +	switch(var->bits_per_pixel) {
> +	case 8:
> +		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +
> +	case 16:
> +		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
> +		break;
> +
> +	case 32:
> +		info->fix.visual = FB_VISUAL_TRUECOLOR;
> +		break;
> +	}
> +
> +	dprintk("%s: virtual %d,%d\n",
> +		__FUNCTION__,
> +		var->xres_virtual,
> +		var->yres_virtual);
> +
> +	/* allocate fb memory within 501 */
> +	info->fix.line_length     = (var->xres * var->bits_per_pixel)/8;
> +	info->fix.smem_len	  = info->fix.line_length * var->yres;
> +
> +	dprintk("%s: line length  = %lu\n", __FUNCTION__,
> +		(unsigned long)info->fix.line_length);
> +
> +	if (sm501_alloc_mem(fbi, &par->screen, SM501_MEMF_CRT,
> +			    info->fix.smem_len)) {
> +		dev_err(fbi->dev, "no memory for crt\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->fix.smem_start = fbi->fbmem_res->start + par->screen.sm_addr;
> +
> +	/* ensure virtual adressess are set */
> +	info->screen_base = fbi->fbmem + par->screen.sm_addr;
> +	info->screen_size = info->fix.smem_len;
> +
> +	/* calculate pixel clock in Hz from the ps value*/
> +	pixclock = sm501fb_ps_to_hz(var->pixclock);
> +
> +	/* program CRT clcok  */
> +	sm501pixclock = sm501_set_clock(fbi->dev->parent,
> +					SM501_CLOCK_V2XCLK,
> +					pixclock);
> +
> +	/* update fb layer with actual clock used */
> +	var->pixclock = sm501fb_ps_to_hz(sm501pixclock);
> +
> +	dprintk("%s: pixclock(ps) = %u, pixclock(Hz)  = %lu, "
> +	       "sm501pixclock = %lu,  error = %ld%%\n",
> +	       __FUNCTION__, var->pixclock, pixclock, sm501pixclock,
> +	       ((pixclock - sm501pixclock)*100)/pixclock);
> +
> +	/* enable CRT DAC - note 0 is on!*/
> +	sm501_misc_control(fbi->dev->parent, SM501_MISC_DAC_POWER, 0);
> +
> +	/* set frame buffer base */
> +	dprintk("%s: framebuffer base  = 0x%lx\n", __FUNCTION__,
> +	       (1<<31) | par->screen.sm_addr);
> +
> +	writel(1<<31 | par->screen.sm_addr , fbi->regs + SM501_DC_CRT_FB_ADDR);
> +
> +	/* program framebuffer width and offset */
> +	dprintk("%s: framebuffer width & offset  = 0x%08lx\n", __FUNCTION__,
> +	       (unsigned long)(info->fix.line_length & 0x3FF0) | ((info->fix.line_length & 0x3FF0) << 16));
> +
> +	writel((info->fix.line_length & 0x3FF0) | ((info->fix.line_length & 0x3FF0) << 16),
> +	       fbi->regs + SM501_DC_CRT_FB_OFFSET);
> +
> +	/* program horizontal total */
> +	dprintk("%s: framebuffer htotal = 0x%x, xres = %d, left = %d, "
> +	       "right = %d, hsync = %d\n", __FUNCTION__,
> +	       (((var->xres + var->left_margin + var->right_margin + var->hsync_len - 1) & 0xFFF) << 16) | ((var->xres - 1) & 0xFFF),

Better if you stick to 80 columns.

> +	       var->xres,  var->left_margin, var->right_margin, var->hsync_len);
> +
> +	writel((((var->xres + var->left_margin + var->right_margin + var->hsync_len - 1) & 0xFFF) << 16) |
> +	       ((var->xres - 1) & 0xFFF),
> +	       fbi->regs + SM501_DC_CRT_H_TOT);
> +
> +	/* program horizontal sync */
> +	dprintk("%s: framebuffer hsync  = 0x%x\n",
> +		__FUNCTION__,
> +		((var->hsync_len & 0xFF) << 16 ) | ((var->xres + var->right_margin - 1) & 0x7FF));
> +
> +	writel(((var->hsync_len & 0xFF) << 16 ) |
> +	       ((var->xres + var->right_margin - 1) & 0x7FF),
> +	       fbi->regs + SM501_DC_CRT_H_SYNC);
> +
> +	/* program vertical total */
> +	dprintk("%s: framebuffer vtotal = 0x%x, yres = %d,"
> +		" upper = %d, lower = %d, vsync = %d\n",
> +		__FUNCTION__,
> +		(((var->upper_margin + var->yres + var->lower_margin + var->vsync_len - 1) & 0x7FF) << 16) | ((var->yres - 1) & 0x7FF),
> +		var->yres,
> +		var->upper_margin,
> +		var->lower_margin,
> +		var->vsync_len);
> +
> +	writel((((var->upper_margin + var->yres + var->lower_margin + var->vsync_len - 1) & 0x7FF) << 16) |
> +	       ((var->yres - 1) & 0x7FF),
> +	       fbi->regs + SM501_DC_CRT_V_TOT);
> +
> +	/* program vertical sync */
> +	dprintk("%s: framebuffer vsync  = 0x%x\n",
> +		__FUNCTION__,
> +		((var->vsync_len & 0x3F) << 16) | (((var->yres + var->lower_margin - 1) & 0x7FF)));
> +
> +	writel(((var->vsync_len & 0x3F) << 16) |
> +	       (((var->yres + var->lower_margin - 1) & 0x7FF)),
> +	       fbi->regs + SM501_DC_CRT_V_SYNC);
> +
> +	/* program control register */
> +	control=readl(fbi->regs + SM501_DC_CRT_CONTROL) & 0xCCF8;
> +
> +	switch(var->bits_per_pixel) {
> +	case 8:
> +		control |= 0;
> +		break;
> +
> +	case 16:
> +		control |= 1;
> +		break;
> +
> +	case 32:
> +		control |= 2;
> +
> +		sm501fb_setup_gamma(fbi,SM501_DC_CRT_PALETTE);

If you can set up a linear gamma ramp at bpp 32, why not just make
the visual at this bpp DIRECTCOLOR? If you're trying to avoid
broken user apps that cannot handle DIRECTCOLR, then this is acceptable.

> +		break;
> +
> +	default:
> +		break; /* uh oh */
> +	}
> +
> +	control |= 1<<9;	/* CRT displays CRT data */
> +	control |= 1<<8;	/* enable CRT timing */
> +	control |= 1<<2;	/* enable CRT graphics plane */
> +
> +	/* H sync polarity */
> +	if((var->sync & FB_SYNC_HOR_HIGH_ACT) == 0)
> +		control |= 1<<12;
> +
> +	/* V sync polarity */
> +	if((var->sync & FB_SYNC_VERT_HIGH_ACT) == 0)
> +		control |= 1<<13;
> +
> +	writel(control, fbi->regs + SM501_DC_CRT_CONTROL);
> +
> +	/* TODO - set DPMS */
> +
> +	return 0;
> +}
> +
> +/*
> + * sm501fb_set_par_pnl
> + * @info: frame buffer structure that represents the panel framebuffer
> + *
> + * Sets the panel video mode with the data in the fb_info structure
> + */
> +static int sm501fb_set_par_pnl(struct fb_info *info)
> +{
> +	struct sm501fb_par  *par = info->par;
> +	struct sm501fb_info *fbi = par->info;
> +	struct fb_var_screeninfo *var = &info->var;
> +	unsigned long pixclock;
> +	unsigned long sm501pixclock;
> +	unsigned long control;
> +
> +	/* activate this new configuration */
> +	dprintk("%s: var->xres  = %u\n", __FUNCTION__, var->xres);
> +	dprintk("%s: var->yres  = %u\n", __FUNCTION__, var->yres);
> +	dprintk("%s: var->bpp   = %u\n", __FUNCTION__, var->bits_per_pixel);
> +
> +	switch(var->bits_per_pixel) {
> +	case 8:
> +		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +
> +	case 16:
> +		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
> +		break;
> +
> +	case 32:
> +		info->fix.visual = FB_VISUAL_TRUECOLOR;
> +		break;
> +	}
> +
> +	dprintk("%s: virtual %d,%d\n",
> +	       __FUNCTION__,
> +	       var->xres_virtual,
> +	       var->yres_virtual);
> +
> +	info->fix.line_length = (var->xres * var->bits_per_pixel)/8;
> +	info->fix.smem_len    = info->fix.line_length * var->yres;
> +
> +	dprintk("%s: line length  = %lu\n", __FUNCTION__,
> +		(unsigned long)info->fix.line_length);
> +
> +	if (sm501_alloc_mem(fbi, &par->screen, SM501_MEMF_PANNEL,
> +			    info->fix.smem_len)) {
> +		dev_err(fbi->dev, "no memory for panel\n");
> +		return -ENOMEM;
> +	}
> +
> +	info->fix.smem_start = fbi->fbmem_res->start + par->screen.sm_addr;
> +
> +	/* ensure virtual adressess are set */
> +	info->screen_base = fbi->fbmem + par->screen.sm_addr;
> +	info->screen_size = info->fix.smem_len;
> +
> +	/* calculate pixel clock in Hz from the ps value*/
> +	pixclock = sm501fb_ps_to_hz(var->pixclock);
> +
> +	/* program clock  */
> +	sm501pixclock = sm501_set_clock(fbi->dev->parent,
> +					SM501_CLOCK_P2XCLK,
> +					pixclock);
> +
> +	dprintk("%s: pixclock(ps) = %u, pixclock(Hz)  = %lu, "
> +	       "sm501pixclock = %lu,  error = %ld%%\n",
> +	       __FUNCTION__, var->pixclock, pixclock, sm501pixclock,
> +	       (((pixclock - sm501pixclock)*100)/pixclock));
> +
> +	/* update fb layer with actual clock used */
> +	var->pixclock = sm501fb_ps_to_hz(sm501pixclock);
> +
> +	/* set frame buffer base */
> +	dprintk("%s: framebuffer base  = 0x%lx\n",
> +	       __FUNCTION__, (1<<31) | par->screen.sm_addr);
> +
> +	writel((1<<31) | par->screen.sm_addr,
> +	       fbi->regs + SM501_DC_PANEL_FB_ADDR);
> +
> +	/* program framebuffer width and offset */
> +	dprintk("%s: framebuffer window width & offset  = 0x%08lx\n",
> +		__FUNCTION__,
> +		(unsigned long)(info->fix.line_length & 0x3FF0) | ((info->fix.line_length & 0x3FF0) << 16));
> +
> +	writel((info->fix.line_length & 0x3FF0) | ((info->fix.line_length & 0x3FF0) << 16),
> +	       fbi->regs + SM501_DC_PANEL_FB_OFFSET);
> +
> +	/* panel fb width */
> +	dprintk("%s: framebuffer width = 0x%08x\n",
> +	       __FUNCTION__, ((var->xres & 0xFFF) << 16));
> +
> +	writel((0 & 0xFFF) | ((var->xres & 0x0FFF) << 16),
> +	       fbi->regs + SM501_DC_PANEL_FB_WIDTH);
> +
> +	/* panel fb height */
> +	dprintk("%s: framebuffer height = 0x%08x\n",
> +	       __FUNCTION__, ((var->yres & 0xFFF) << 16));
> +
> +	writel((0 & 0xFFF) | ((var->yres & 0xFFF) << 16),
> +	       fbi->regs + SM501_DC_PANEL_FB_HEIGHT);
> +
> +	/* panel plane top left location */
> +	dprintk("%s: framebuffer top left = 0x%08x\n",
> +	       __FUNCTION__, ((0 & 0x7FF) | ((0 & 0x7FF) << 16)));
> +
> +	writel((0 & 0x7FF) | ((0 & 0x7FF) << 16),
> +	       fbi->regs + SM501_DC_PANEL_TL_LOC);
> +
> +	/* panel plane bottom right  location */
> +	dprintk("%s: framebuffer bottom right = 0x%08x\n", __FUNCTION__,
> +	       (((var->xres - 1) & 0x7FF) | (((var->yres - 1) & 0x7FF) << 16)));
> +	writel(((var->xres - 1) & 0x7FF) | (((var->yres - 1) & 0x7FF) << 16),
> +	       fbi->regs + SM501_DC_PANEL_BR_LOC);
> +
> +	/* program horizontal total */
> +	dprintk("%s: framebuffer htotal = 0x%x, xres = %d, "
> +		"left = %d, right = %d, hsync = %d\n",
> +		__FUNCTION__,
> +		(((var->xres + var->left_margin + var->right_margin + var->hsync_len - 1) & 0xFFF) << 16) | ((var->xres - 1) & 0xFFF),
> +		var->xres,
> +		var->left_margin,
> +		var->right_margin,
> +		var->hsync_len);
> +
> +	writel((((var->xres + var->left_margin + var->right_margin + var->hsync_len - 1) & 0xFFF) << 16) |
> +	       ((var->xres - 1) & 0xFFF),
> +	       fbi->regs + SM501_DC_PANEL_H_TOT);
> +
> +	/* program horizontal sync */
> +	printk("%s: framebuffer hsync  = 0x%x\n", __FUNCTION__, ((var->hsync_len & 0xFF) << 16 ) | ((var->xres + var->right_margin - 1) & 0x7FF));
> +
> +	writel(((var->hsync_len & 0xFF) << 16 ) |
> +	       ((var->xres + var->right_margin - 1) & 0x7FF),
> +	       fbi->regs + SM501_DC_PANEL_H_SYNC);
> +
> +	/* program vertical total */
> +	dprintk("%s: framebuffer vtotal = 0x%x, yres = %d,"
> +		" upper = %d, lower = %d, vsync = %d\n",
> +		__FUNCTION__,
> +		(((var->upper_margin + var->yres + var->lower_margin + var->vsync_len - 1) & 0x7FF) << 16) | ((var->yres - 1) & 0x7FF),
> +		var->yres,
> +		var->upper_margin,
> +		var->lower_margin,
> +		var->vsync_len);
> +
> +	writel((((var->upper_margin + var->yres + var->lower_margin + var->vsync_len - 1) & 0x7FF) << 16) |
> +	       ((var->yres - 1) & 0x7FF),
> +	       fbi->regs + SM501_DC_PANEL_V_TOT);
> +
> +	/* program vertical sync */
> +	dprintk("%s: framebuffer vsync  = 0x%x\n",
> +		__FUNCTION__,
> +		((var->vsync_len & 0x3F) << 16) | (((var->yres + var->lower_margin - 1) & 0x7FF)));
> +
> +	writel(((var->vsync_len & 0x3F) << 16) |
> +	       (((var->yres + var->lower_margin - 1) & 0x7FF)),
> +	       fbi->regs + SM501_DC_PANEL_V_SYNC);
> +
> +	/* program control register */
> +	control=readl(fbi->regs + SM501_DC_PANEL_CONTROL) & 0xCCF8;
> +
> +	switch(var->bits_per_pixel) {
> +	case 8:
> +		control |= 0;
> +		break;
> +
> +	case 16:
> +		control |= 1;
> +		break;
> +
> +	case 32:
> +		control |= 2;
> +
> +		sm501fb_setup_gamma(fbi,SM501_DC_PANEL_PALETTE);

Same here.

> +		break;
> +
> +	default:
> +		break; /* uh oh */
> +	}
> +
> +	control |= 1<<8;	/* enable PANEL timing */
> +	control |= 1<<2;	/* enable PANEL graphics plane */
> +
> +	if((var->sync & FB_SYNC_HOR_HIGH_ACT) == 0)
> +		control |= 1<<12;
> +
> +	if((var->sync & FB_SYNC_VERT_HIGH_ACT) == 0)
> +		control |= 1<<13;
> +
> +	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
> +
> +	/* enable panel power */
> +
> +	control |=1<<24;//FPVDDEN
> +	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
> +	udelay(10000);	/* todo - better delay! */
> +
> +	control |=1<<25;//DATA
> +	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
> +	udelay(10000);
> +
> +	control |=1<<26;//VBIASEN
> +	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
> +	udelay(10000);
> +
> +	control |=1<<27;//FPEN
> +	writel(control, fbi->regs + SM501_DC_PANEL_CONTROL);
> +
> +	return 0;
> +}
> +
> +/* from pxafb.c */
> +static inline unsigned int chan_to_field(unsigned int chan,
> +					 struct fb_bitfield *bf)
> +{
> +	chan &= 0xffff;
> +	chan >>= 16 - bf->length;
> +	return chan << bf->offset;
> +}
> +
> +static int sm501fb_setcolreg_crt(unsigned regno,
> +				 unsigned red, unsigned green, unsigned blue,
> +				 unsigned transp, struct fb_info *info)
> +{
> +	struct sm501fb_par  *par = info->par;
> +	unsigned int val;
> +
> +	switch (info->fix.visual) {
> +	case FB_VISUAL_TRUECOLOR:
> +		/* true-colour, use pseuo-palette */
> +
> +		if (regno < 16) {
> +			u32 *pal = par->pseudo_palette;
> +
> +			val  = chan_to_field(red,   &info->var.red);
> +			val |= chan_to_field(green, &info->var.green);
> +			val |= chan_to_field(blue,  &info->var.blue);
> +
> +			pal[regno] = val;
> +		}
> +		break;
> +
> +	case FB_VISUAL_PSEUDOCOLOR:
> +		if (regno < 256) {
> +			/* currently assume RGB 5-6-5 mode */
> +
> +			val  = ((red   >>  0) & 0xf800);
> +			val |= ((green >>  5) & 0x07e0);
> +			val |= ((blue  >> 11) & 0x001f);
> +		}

What does this part do? Looks like dead code. And for pseudocolor, you
need to alter the hardware palette at least.

> +
> +		break;
> +
> +	default:
> +		return 1;   /* unknown type */

What happened to FB_VISUAL_DIRECTCOLOR?

> +	}
> +
> +	return 0;
> +}
> +
> +static int sm501fb_setcolreg_pnl(unsigned regno,
> +				 unsigned red, unsigned green, unsigned blue,
> +				 unsigned transp, struct fb_info *info)
> +{
> +	struct sm501fb_par  *par = info->par;
> +	struct sm501fb_info *fbi = par->info;
> +	unsigned int val;
> +
> +	/* dprintk("setcol: regno=%d, rgb=%d,%d,%d\n", regno, red, green, blue); */
> +
> +	switch (info->fix.visual) {
> +	case FB_VISUAL_TRUECOLOR:
> +		/* true-colour, use pseuo-palette */
> +
> +		if (regno < 16) {
> +			u32 *pal = par->pseudo_palette;
> +
> +			val  = chan_to_field(red,   &fbi->fb[0]->var.red);
> +			val |= chan_to_field(green, &fbi->fb[0]->var.green);
> +			val |= chan_to_field(blue,  &fbi->fb[0]->var.blue);
> +
> +			pal[regno] = val;
> +		}
> +		break;
> +
> +	case FB_VISUAL_PSEUDOCOLOR:
> +		if (regno < 256) {
> +			/* currently assume RGB 5-6-5 mode */
> +
> +			val  = ((red   >>  0) & 0xf800);
> +			val |= ((green >>  5) & 0x07e0);
> +			val |= ((blue  >> 11) & 0x001f);
> +		}
> +
> +		break;
> +
> +	default:
> +		return 1;   /* unknown type */

Same here.

> +	}
> +
> +	return 0;
> +}
> +
> +
> +/**
> + *      sm501fb_blank_crt
> + *	@blank_mode: the blank mode we want.
> + *	@info: frame buffer structure that represents a single frame buffer
> + *
> + *	Blank the screen if blank_mode != 0, else unblank. Return 0 if
> + *	blanking succeeded, != 0 if un-/blanking failed due to e.g. a
> + *	video mode which doesn't support it. Implements VESA suspend
> + *	and powerdown modes on hardware that supports disabling hsync/vsync:
> + *	blank_mode == 2: suspend vsync
> + *	blank_mode == 3: suspend hsync
> + *	blank_mode == 4: powerdown
> + *
> + *	Returns negative errno on error, or zero on success.
> + *
> + */
> +static int sm501fb_blank_crt(int blank_mode, struct fb_info *info)
> +{
> +	dprintk("blank(mode=%d, info=%p)\n", blank_mode, info);
> +
> +	if (blank_mode == FB_BLANK_UNBLANK) {
> +		dprintk("unblaking display\n");
> +	} else {
> +		dprintk("blanking display\n");
> +	}
> +
> +	return 0;

If you're blanking code does nothing, return a nonzero value at least.

> +}
> +
> +/**
> + *      sm501fb_blank_pnl
> + *	@blank_mode: the blank mode we want.
> + *	@info: frame buffer structure that represents a single frame buffer
> + *
> + *	Blank the screen if blank_mode != 0, else unblank. Return 0 if
> + *	blanking succeeded, != 0 if un-/blanking failed due to e.g. a
> + *	video mode which doesn't support it. Implements VESA suspend
> + *	and powerdown modes on hardware that supports disabling hsync/vsync:
> + *	blank_mode == 2: suspend vsync
> + *	blank_mode == 3: suspend hsync
> + *	blank_mode == 4: powerdown
> + *
> + *	Returns negative errno on error, or zero on success.
> + *
> + */
> +static int sm501fb_blank_pnl(int blank_mode, struct fb_info *info)
> +{
> +	dprintk("blank(mode=%d, info=%p)\n", blank_mode, info);
> +
> +	if (blank_mode == FB_BLANK_UNBLANK) {
> +		dprintk("unblaking display\n");
> +	} else {
> +		dprintk("blanking display\n");
> +	}
> +
> +	return 0;

Same here.

> +}
> +
> +/**
> + *	xxxfb_cursor
> + *      @info: frame buffer structure that represents a single frame buffer
> + *	@cursor: structure defining the cursor to draw.
> + *
> + *      This operation is used to set or alter the properities of the
> + *	cursor.
> + *
> + *	Returns negative errno on error, or zero on success.
> + */
> +
> +int sm501fb_cursor_crt(struct fb_info *info, struct fb_cursor *cursor)

Is this function used at all? Enclose it with #if 0/#endif at least.

> +{
> +	struct sm501fb_par  *par = info->par;
> +	struct sm501fb_info *fbi = par->info;
> +	unsigned long hwc_addr;
> +	unsigned long fg, bg;
> +
> +	/* check not being asked to exceed capabilities */
> +	if(cursor->image.width > 64)
> +		return -ENXIO;
> +
> +	if(cursor->image.height > 64)
> +		return -ENXIO;
> +
> +	if(cursor->image.depth > 1)
> +		return -ENXIO;
> +
> +	hwc_addr=readl(fbi->regs + SM501_DC_CRT_HWC_ADDR);
> +
> +	if(cursor->enable)
> +		writel(hwc_addr | 1<<31, fbi->regs + SM501_DC_CRT_HWC_ADDR);
> +	else
> +		writel(hwc_addr & ~(1<<31), fbi->regs + SM501_DC_CRT_HWC_ADDR);
> +
> +	/* set data */
> +	if(cursor->set & FB_CUR_SETPOS) {
> +		writel(((cursor->image.dx & 0x7FF) |
> +			(cursor->image.dy & 0x7FF) <<16),
> +		       fbi->regs + SM501_DC_CRT_HWC_LOC);
> +	}
> +
> +	if(cursor->set & FB_CUR_SETHOT) {
> +	}
> +
> +	if(cursor->set & FB_CUR_SETCMAP) {
> +		bg = ((info->cmap.red[cursor->image.bg_color] & 0xF8) << 8) |
> +			((info->cmap.green[cursor->image.bg_color] & 0xFC) << 3) |
> +			((info->cmap.blue[cursor->image.bg_color] & 0xF8) >> 3);
> +
> +		fg = ((info->cmap.red[cursor->image.fg_color] & 0xF8) << 8) |
> +			((info->cmap.green[cursor->image.fg_color] & 0xFC) << 3) |
> +			((info->cmap.blue[cursor->image.fg_color] & 0xF8) >> 3);
> +
> +		writel(bg, fbi->regs + SM501_DC_CRT_HWC_COLOR_1_2);
> +		writel(fg, fbi->regs + SM501_DC_CRT_HWC_COLOR_3);
> +
> +	}
> +
> +	if(cursor->set & FB_CUR_SETSIZE) {
> +	}
> +
> +	if(cursor->set & (FB_CUR_SETIMAGE | FB_CUR_SETSHAPE)) {
> +	}
> +
> +/*
> + *      @set: 	Which fields we are altering in struct fb_cursor
> + *	@enable: Disable or enable the cursor
> + *      @rop: 	The bit operation we want to do.
> + *      @mask:  This is the cursor mask bitmap.
> + *      @dest:  A image of the area we are going to display the cursor.
> + *		Used internally by the driver.
> + *      @hot:	The hot spot.
> + *	@image:	The actual data for the cursor image.
> + *
> + *      NOTES ON FLAGS (cursor->set):
> + *
> + *      FB_CUR_SETIMAGE - the cursor image has changed (cursor->image.data)
> + *      FB_CUR_SETPOS   - the cursor position has changed (cursor->image.dx|dy)
> + *      FB_CUR_SETHOT   - the cursor hot spot has changed (cursor->hot.dx|dy)
> + *      FB_CUR_SETCMAP  - the cursor colors has changed (cursor->fg_color|bg_color)
> + *      FB_CUR_SETSHAPE - the cursor bitmask has changed (cursor->mask)
> + *      FB_CUR_SETSIZE  - the cursor size has changed (cursor->width|height)
> + *      FB_CUR_SETALL   - everything has changed
> + *
> + *      NOTES ON ROPs (cursor->rop, Raster Operation)
> + *
> + *      ROP_XOR         - cursor->image.data XOR cursor->mask
> + *      ROP_COPY        - curosr->image.data AND cursor->mask
> + *
> + *      OTHER NOTES:
> + *
> + *      - fbcon only supports a 2-color cursor (cursor->image.depth = 1)
> + *      - The fb_cursor structure, @cursor, _will_ always contain valid
> + *        fields, whether any particular bitfields in cursor->set is set
> + *        or not.
> + */
> +
> +	return 0;
> +}

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
