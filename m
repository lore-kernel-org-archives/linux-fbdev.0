From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 01/11] video: Add support for the
 Avionic Design Xanthos framebuffer.
Date: Sat, 16 May 2009 11:22:43 +0200
Message-ID: <20090516112243.44194c20.krzysztof.h1@poczta.fm>
References: <1242294422-10478-1-git-send-email-thierry.reding@avionic-design.de>
	<4A0C334B.9040008@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M5G0q-0002Br-C6
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 16 May 2009 09:17:00 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M5G0m-0000Qj-0k for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 16 May 2009 09:17:00 +0000
In-Reply-To: <4A0C334B.9040008@compulab.co.il>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Mike Rapoport <mike@compulab.co.il>, Thierry Reding <thierry.reding@avionic-design.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, "Antonino A. Daplas" <adaplas@gmail.com>

Hi Thierry


> (cc'ed fbdev list and maintainer)
> 
> Thierry Reding wrote:
> > This patch adds support for the Avionic Design Xanthos framebuffer.
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  drivers/video/Kconfig         |   12 +
> >  drivers/video/Makefile        |    1 +
> >  drivers/video/adxfb/Makefile  |    1 +
> >  drivers/video/adxfb/adxfb.h   |  120 +++++++++++
> >  drivers/video/adxfb/fb.c      |  456 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/video/adxfb/overlay.c |  190 +++++++++++++++++
> >  drivers/video/adxfb/scaler.c  |  231 +++++++++++++++++++++
> >  include/video/Kbuild          |    1 +
> >  include/video/adxfb.h         |  128 ++++++++++++
> >  9 files changed, 1140 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/adxfb/Makefile
> >  create mode 100644 drivers/video/adxfb/adxfb.h
> >  create mode 100644 drivers/video/adxfb/fb.c
> >  create mode 100644 drivers/video/adxfb/overlay.c
> >  create mode 100644 drivers/video/adxfb/scaler.c
> >  create mode 100644 include/video/adxfb.h
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 7826bdc..976238f 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -1678,6 +1678,18 @@ config CARMINE_DRAM_CUSTOM
> >  	  Use custom board timings.
> >  endchoice
> >  
> > +config FB_ADX
> > +	tristate "Avionic Design Xanthos framebuffer support"
> > +	depends on FB
> > +	select FB_CFB_FILLRECT
> > +	select FB_CFB_COPYAREA
> > +	select FB_CFB_IMAGEBLIT
> > +	help
> > +	  Framebuffer driver for the LCD controller in Avionic Design
> > +	  Xanthos boards.
> > +
> > +	  If in doubt, say N.
> > +
> >  config FB_AU1100
> >  	bool "Au1100 LCD Driver"
> >  	depends on (FB = y) && MIPS && SOC_AU1100
> > diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> > index d8d0be5..4de52a5 100644
> > --- a/drivers/video/Makefile
> > +++ b/drivers/video/Makefile
> > @@ -125,6 +125,7 @@ obj-$(CONFIG_FB_OMAP)             += omap/
> >  obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
> >  obj-$(CONFIG_FB_CARMINE)          += carminefb.o
> >  obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
> > +obj-$(CONFIG_FB_ADX)              += adxfb/
> >  
> >  # Platform or fallback drivers go here
> >  obj-$(CONFIG_FB_UVESA)            += uvesafb.o
> > diff --git a/drivers/video/adxfb/Makefile b/drivers/video/adxfb/Makefile
> > new file mode 100644
> > index 0000000..389d65c
> > --- /dev/null
> > +++ b/drivers/video/adxfb/Makefile
> > @@ -0,0 +1 @@
> > +obj-y	+= fb.o overlay.o scaler.o
> > diff --git a/drivers/video/adxfb/adxfb.h b/drivers/video/adxfb/adxfb.h
> > new file mode 100644
> > index 0000000..d6535c2
> > --- /dev/null
> > +++ b/drivers/video/adxfb/adxfb.h
> > @@ -0,0 +1,120 @@
> > +/*
> > + * linux/drivers/video/adxfb/adxfb.h
> > + *
> > + * Copyright (C) 2007-2008 Avionic Design Development GmbH
> > + * Copyright (C) 2008-2009 Avionic Design GmbH
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Written by Thierry Reding <thierry.reding@avionic-design.de>
> > + */
> > +
> > +#ifndef _DRIVERS_VIDEO_ADXFB_ADXFB_H
> > +#define _DRIVERS_VIDEO_ADXFB_ADXFB_H 1
> > +
> > +#include <linux/spinlock.h>
> > +#include <video/adxfb.h>
> > +
> > +/**
> > + * struct adxfb_info - Avionic Design Xanthos framebuffer info structure
> > + * @palette:		VGA palette storage
> > + * @io_base:		memory-mapped base address for graphics controller
> > + * @scaler_base:	memory-mapped base address for scaler
> > + * @ioctl:		machine-specific I/O control handler
> > + */
> > +struct adxfb_info {
> > +	u32 palette[16];
> > +
> > +	void __iomem *io_base;
> > +	void __iomem *scaler_base;
> > +	spinlock_t lock;
> > +
> > +	int (*ioctl)(struct fb_info *info, unsigned int command,
> > +			unsigned long arg);
> > +};
> > +
> > +#define to_adxfb_info(info) ((struct adxfb_info *)(info)->par)

This macro is not needed. The info->par is void* type so
it can be casted to any pointer without warning.

> > +
> > +/* register definitions */
> > +#define ADXFB_CONTROL			0x000
> > +#define ADXFB_CONTROL_ENABLE		(1 <<  0)
> > +#define ADXFB_CONTROL_SYNC		(1 <<  1)
> > +#define ADXFB_CONTROL_DOUBLE_Y		(1 <<  2)
> > +#define ADXFB_CONTROL_HALVE_X		(1 <<  3)
> > +#define ADXFB_CONTROL_TRIPLE_Y		(1 <<  4)
> > +#define ADXFB_CONTROL_LOCK		(1 << 31)
> > +#define ADXFB_OVERLAY_CONTROL		0x008
> > +#define ADXFB_OVERLAY_CONTROL_OVERLAY	(1 << 0)
> > +#define ADXFB_OVERLAY_CONTROL_ALPHA	(1 << 1)
> > +#define ADXFB_OVERLAY_START		0x010
> > +#define ADXFB_OVERLAY_END		0x018
> > +#define ADXFB_OVERLAY_PAGE0_START	0x020
> > +#define ADXFB_OVERLAY_PAGE0_END		0x028
> > +#define ADXFB_OVERLAY_PAGE0_SIZE	0x030
> > +#define ADXFB_OVERLAY_PAGE1_START	0x038
> > +#define ADXFB_OVERLAY_PAGE1_END		0x040
> > +#define ADXFB_OVERLAY_PAGE1_SIZE	0x048
> > +#define ADXFB_OVERLAY_LEVEL		0x050
> > +#define ADXFB_ALPHA_START		0x058
> > +#define ADXFB_ALPHA_END			0x060
> > +#define ADXFB_ALPHA_PAGE1_START		0x068
> > +#define ADXFB_ALPHA_PAGE1_END		0x070
> > +#define ADXFB_ALPHA_PAGE1_SIZE		0x078
> > +#define ADXFB_PAGE0_BASE		0x080
> > +#define ADXFB_PAGE0_FORMAT		0x088
> > +#define ADXFB_PAGE0_RESOLUTION		0x090
> > +#define ADXFB_PAGE0_RESOLUTION_BYTE	0x098
> > +#define ADXFB_PAGE0_SIZE		0x0a0
> > +#define ADXFB_PAGE1_BASE		0x0b0
> > +#define ADXFB_PAGE1_FORMAT		0x0b8
> > +#define ADXFB_PAGE1_RESOLUTION		0x0c0
> > +#define ADXFB_PAGE1_RESOLUTION_PHYSICAL	0x0c8
> > +#define ADXFB_PAGE1_RESOLUTION_VIRTUAL	0x0d0
> > +#define ADXFB_PAGE1_SIZE_PHYSICAL	0x0d8
> > +#define ADXFB_PAGE1_SIZE_VIRTUAL	0x0e0
> > +#define ADXFB_PAGE1_OFFSET		0x0e8
> > +#define ADXFB_PAGE1_SECONDARY_BASE	0x0f0
> > +#define ADXFB_COLOR_OFFSET		0x100
> > +#define ADXFB_COLOR_MUL			0x108
> > +
> > +/* page format (ADXFB_PAGE0_FORMAT, ADXFB_PAGE1_FORMAT) */
> > +#define ADXFB_FMT_NONE		0
> > +#define ADXFB_FMT_GRAYSCALE_8	1
> > +#define ADXFB_FMT_RGB_565	2
> > +#define ADXFB_FMT_RGB_888	3
> > +#define ADXFB_FMT_RGBA_8888	4
> > +
> > +/**
> > + * adxfb_r32() - read 32-bit register
> > + * @fb:		framebuffer context
> > + * @offset:	relative register offset
> > + */
> > +static inline u32 adxfb_r32(struct adxfb_info *fb, unsigned long offset)
> > +{
> > +	return ioread32(fb->io_base + offset);
> > +}
> > +
> > +/**
> > + * adxfb_w32() - write 32-bit register
> > + * @fb:		framebuffer context
> > + * @offset:	relative register offset
> > + * @value:	value to write to register
> > + */
> > +static inline void adxfb_w32(struct adxfb_info *fb, unsigned long offset,
> > +		u32 value)
> > +{
> > +	iowrite32(value, fb->io_base + offset);
> > +}
> > +
> > +extern int adxfb_scaler_set_mode(struct fb_info *info,
> > +		struct adxfb_scaler_mode *mode);
> > +extern int adxfb_scaler_get_mode(struct fb_info *info,
> > +		struct adxfb_scaler_mode *mode);
> > +
> > +extern int adxfb_overlay_enable(struct fb_info *info, unsigned long flags);
> > +extern int adxfb_overlay_set_viewport(struct fb_info *info,
> > +		struct adxfb_viewport *viewport);
> > +
> > +#endif /* !_DRIVERS_VIDEO_ADXFB_ADXFB_H */
> > diff --git a/drivers/video/adxfb/fb.c b/drivers/video/adxfb/fb.c
> > new file mode 100644
> > index 0000000..755cdce
> > --- /dev/null
> > +++ b/drivers/video/adxfb/fb.c
> > @@ -0,0 +1,456 @@
> > +/*
> > + * linux/drivers/video/adxfb/fb.c
> > + *
> > + * Copyright (C) 2007-2008 Avionic Design Development GmbH
> > + * Copyright (C) 2008-2009 Avionic Design GmbH
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * Written by Thierry Reding <thierry.reding@avionic-design.de>
> > + */
> > +
> > +#include <linux/fb.h>
> > +#include <linux/io.h>
> > +#include <linux/mm.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include "adxfb.h"
> > +
> > +/**
> > + * adxfb_setcolreg() - set color register
> > + * @regno:	register number to set
> > + * @red:	red color component
> > + * @green:	green color component
> > + * @blue:	blue color component
> > + * @transp:	transparency component
> > + * @info:	framebuffer context
> > + */
> > +static int adxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
> > +		unsigned blue, unsigned transp, struct fb_info *info)
> > +{
> > +	if ((regno >= info->cmap.len) || (regno > 255))
> > +		return 1;
> > +
> > +#define CNVT_TOHW(val, width) ((((val) << (width)) + 0x7FFF - (val)) >> 16)
> > +	switch (info->fix.visual) {
> > +	case FB_VISUAL_TRUECOLOR:
> > +		if (regno < 16) {
> > +			((struct adxfb_info *)info->par)->palette[regno] =
> > +				(CNVT_TOHW(red, info->var.red.length)
> > +					<< info->var.red.offset) |
> > +				(CNVT_TOHW(green, info->var.green.length)
> > +					<< info->var.green.offset) |
> > +				(CNVT_TOHW(blue, info->var.blue.length)
> > +					<< info->var.blue.offset) |
> > +				(CNVT_TOHW(transp, info->var.transp.length)
> > +					<< info->var.transp.offset);
> > +		}
> > +		break;
> > +
> > +	default:
> > +		dev_err(info->dev, "bad depth: %u\n", info->var.bits_per_pixel);
> > +		break;
> > +	}
> > +#undef CNVT_TOHW
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * adxfb_ioctl() - handle I/O controls
> > + * @info:	framebuffer context
> > + * @command:	I/O control code
> > + * @arg:	I/O control argument
> > + */
> > +static int adxfb_ioctl(struct fb_info *info, unsigned int command,
> > +		unsigned long arg)
> > +{
> > +	struct adxfb_info *fb = to_adxfb_info(info);
> > +	void __user *argp = (void __user *)arg;
> > +	struct adxfb_scaler_mode mode;
> > +	struct adxfb_viewport viewport;
> > +	int err = 0;
> > +
> > +	switch (command) {
> > +	case ADXFB_IOCTL_SCALER_SET_MODE:
> > +		if (copy_from_user(&mode, argp, sizeof(mode)))
> > +			return -EFAULT;
> > +
> > +		err = adxfb_scaler_set_mode(info, &mode);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		break;
> > +
> > +	case ADXFB_IOCTL_SCALER_GET_MODE:
> > +		err = adxfb_scaler_get_mode(info, &mode);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		if (copy_to_user(argp, &mode, sizeof(mode)))
> > +			return -EFAULT;
> > +
> > +		break;
> > +
> > +	case ADXFB_IOCTL_OVERLAY_ENABLE:
> > +		err = adxfb_overlay_enable(info, arg);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		break;
> > +
> > +	case ADXFB_IOCTL_OVERLAY_SET_VIEWPORT:
> > +		if (copy_from_user(&viewport, argp, sizeof(viewport)))
> > +			return -EFAULT;
> > +
> > +		err = adxfb_overlay_set_viewport(info, &viewport);
> > +		if (err < 0)
> > +			return err;
> > +
> > +		break;
> > +
> > +	default:
> > +		if (fb && fb->ioctl)
> > +			return fb->ioctl(info, command, arg);
> > +
> > +		break;

The fb->ioctl() is the adxfb_ioctl() here. It will cause infinite
recursion if called with unknown ioctl command.
Do not define the clause at all or return the -ENOTTY here.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * adxfb_mmap() - map framebuffer memory
> > + * @info:	framebuffer context
> > + * @vma:	list of memory pages to map
> > + */
> > +static int adxfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> > +{

Your mmap function works exactly the same as the generic fb_mmap() function.
The generic one is not architecture specific. The  pgprot_writecombine() does
not exist on some architectures (e.g. MIPS) and your framebuffer was not
defined only for ARMs. Please use the generic mmap (does not define driver's one).

> > +	unsigned long off, start, len;
> > +	int retval = 0;
> > +
> > +	off = vma->vm_pgoff << PAGE_SHIFT;
> > +	start = info->fix.smem_start;
> > +	len = PAGE_ALIGN(start & ~PAGE_MASK) + info->fix.smem_len;
> > +	start &= PAGE_MASK;
> > +
> > +	if ((vma->vm_end - vma->vm_start + off) > len)
> > +		return -EINVAL;
> > +
> > +	off += start;
> > +	vma->vm_pgoff = off >> PAGE_SHIFT;
> > +
> > +	vma->vm_flags |= VM_IO;
> > +	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> > +
> > +	retval = io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
> > +			vma->vm_end - vma->vm_start, vma->vm_page_prot);
> > +	if (retval)
> > +		return retval;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * adxfb_check_var() - check variables
> > + * @var:	variable screen information
> > + * @info:	framebuffer context
> > + */
> > +static int adxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
> > +{
> > +	/* TODO: implement something useful */

The obvious check here is if requested color format is allowed.

> > +	return 0;
> > +}
> > +
> > +/* framebuffer operations */
> > +static struct fb_ops adxfb_ops = {
> > +	.owner = THIS_MODULE,
> > +	.fb_setcolreg = adxfb_setcolreg,
> > +	.fb_ioctl = adxfb_ioctl,
> > +	.fb_fillrect = cfb_fillrect,
> > +	.fb_copyarea = cfb_copyarea,
> > +	.fb_imageblit = cfb_imageblit,
> > +	.fb_mmap = adxfb_mmap,
> > +	.fb_check_var = adxfb_check_var,
> > +};
> > +
> > +/**
> > + * adxfb_set_bitfield() - initialize a bitfield structure
> > + * @bf:		bitfield structure to fill
> > + * @offset:	value for offset field
> > + * @length:	value for length field
> > + * @msb_right:	value for msb_right field
> > + */
> > +static void adxfb_set_bitfield(struct fb_bitfield *bf, u32 offset, u32 length,
> > +		u32 msb_right)
> > +{
> > +	bf->offset = offset;
> > +	bf->length = length;
> > +	bf->msb_right = msb_right;
> > +}
> > +
> > +/**
> > + * adxfb_fmt_to_mode() - convert format type to video mode parameters
> > + * @fmt:	ADXFB format type
> > + * @mode:	video mode
> > + */
> > +static int adxfb_fmt_to_mode(u8 fmt, struct adxfb_mode_info *mode)
> > +{
> > +	switch (fmt) {
> > +	case ADXFB_FMT_GRAYSCALE_8:
> > +		/* FIXME: use correct values here */
> > +		adxfb_set_bitfield(&mode->red,   5, 3, 0);
> > +		adxfb_set_bitfield(&mode->green, 3, 2, 0);
> > +		adxfb_set_bitfield(&mode->blue,  0, 3, 0);
> > +		mode->bpp = 8;
> > +		break;
> > +
> > +	case ADXFB_FMT_RGB_565:
> > +		adxfb_set_bitfield(&mode->red,   11, 5, 0);
> > +		adxfb_set_bitfield(&mode->green,  5, 6, 0);
> > +		adxfb_set_bitfield(&mode->blue,   0, 5, 0);
> > +		mode->bpp = 16;
> > +		break;
> > +
> > +	case ADXFB_FMT_RGB_888:
> > +		/* FIXME: verify that these are correct values */
> > +		adxfb_set_bitfield(&mode->red,   16, 8, 0);
> > +		adxfb_set_bitfield(&mode->green,  8, 8, 0);
> > +		adxfb_set_bitfield(&mode->blue,   0, 8, 0);
> > +		mode->bpp = 24;
> > +		break;
> > +
> > +	case ADXFB_FMT_RGBA_8888:
> > +		/* FIXME: verify that these are correct values */
> > +		adxfb_set_bitfield(&mode->red,   16, 8, 0);
> > +		adxfb_set_bitfield(&mode->green,  8, 8, 0);
> > +		adxfb_set_bitfield(&mode->blue,   0, 8, 0);

If this is the RGBA mode you should define transparency mask (A).
If the mode has the A component the pixels may not be displayed correctly
(there is no obligation to zero the padding byte).

> > +		mode->bpp = 32;
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * adxfb_get_mach_mode() - obtain the current video mode
> > + * @fb:		framebuffer context
> > + * @mode:	structure to return the video mode in
> > + */
> > +static int adxfb_get_mach_mode(struct adxfb_info *fb,
> > +		struct adxfb_mode_info *mode)
> > +{
> > +	u32 size;
> > +	u16 resx;
> > +	u16 resy;
> > +	u8 fmt;
> > +
> > +	size = adxfb_r32(fb, ADXFB_PAGE0_RESOLUTION);
> > +	resx = (size >> 16) & 0x7ff;
> > +	resy = (size >>  0) & 0x7ff;
> > +
> > +	fmt = adxfb_r32(fb, ADXFB_PAGE0_FORMAT) & 0xff;
> > +
> > +	mode->xres = resx;
> > +	mode->yres = resy;
> > +
> > +	return adxfb_fmt_to_mode(fmt, mode);
> > +}
> > +
> > +/**
> > + * adxfb_probe() - initialize the framebuffer device
> > + * @pdev:	platform device
> > + */
> > +static int __init adxfb_probe(struct platform_device *pdev)
> > +{
> > +	struct adxfb_mach_info *mach_info = pdev->dev.platform_data;
> > +	struct adxfb_mode_info mode;
> > +	struct adxfb_info *fb;
> > +	struct fb_info *info;
> > +	struct resource *res;
> > +	int err = 0;
> > +
> > +	info = framebuffer_alloc(sizeof(struct adxfb_info), &pdev->dev);
> > +	if (!info) {
> > +		dev_err(&pdev->dev, "failed to allocate framebuffer device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	fb = to_adxfb_info(info);
> > +	spin_lock_init(&fb->lock);
> > +
> > +	if (mach_info)
> > +		fb->ioctl = mach_info->ioctl;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to get graphics controller I/O "
> > +				"memory resource\n");
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	res = devm_request_mem_region(&pdev->dev, res->start,
> > +			res->end - res->start + 1, res->name);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to request graphics controller "
> > +				"I/O memory region\n");
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	fb->io_base = devm_ioremap_nocache(&pdev->dev, res->start,
> > +			res->end - res->start + 1);
> > +	if (!fb->io_base) {
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to get scaler I/O memory "
> > +				"resource\n");
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	res = devm_request_mem_region(&pdev->dev, res->start,
> > +			res->end - res->start + 1, res->name);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to request scaler I/O memory "
> > +				"region\n");
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	fb->scaler_base = devm_ioremap_nocache(&pdev->dev, res->start,
> > +			res->end - res->start + 1);
> > +	if (!fb->scaler_base) {
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to get framebuffer I/O memory "
> > +				"resource\n");
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	res = devm_request_mem_region(&pdev->dev, res->start,
> > +			res->end - res->start + 1, res->name);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "failed to request framebuffer I/O "
> > +				"memory region\n");
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	info->screen_base = devm_ioremap_nocache(&pdev->dev, res->start,
> > +			res->end - res->start + 1);
> > +	if (!info->screen_base) {
> > +		err = -ENXIO;
> > +		goto free;
> > +	}
> > +
> > +	/* TODO: add some checking for these parameters */
> > +	memset(&mode, 0, sizeof(mode));
> > +	adxfb_get_mach_mode(fb, &mode);
> > +
> > +	snprintf(info->fix.id, sizeof(info->fix.id), "adxfb");
> > +	info->fix.type = FB_TYPE_PACKED_PIXELS;
> > +	info->fix.visual = FB_VISUAL_TRUECOLOR;
> > +	info->fix.accel = FB_ACCEL_NONE;
> > +	info->fix.line_length = mode.xres * (mode.bpp / 8);
> > +	info->fix.smem_start = res->start;
> > +	info->fix.smem_len = res->end - res->start + 1;
> > +
> > +	info->var.activate = FB_ACTIVATE_NOW;
> > +	info->var.vmode = FB_VMODE_NONINTERLACED;
> > +	info->var.xres = mode.xres;
> > +	info->var.yres = mode.yres;
> > +	info->var.xres_virtual = mode.xres;
> > +	info->var.yres_virtual = mode.yres;
> > +	info->var.bits_per_pixel = mode.bpp;
> > +	info->var.red = mode.red;
> > +	info->var.green = mode.green;
> > +	info->var.blue = mode.blue;
> > +	info->var.width = mode.xres;
> > +	info->var.height = mode.yres;
> > +
> > +	info->fbops = &adxfb_ops;
> > +	info->flags = FBINFO_DEFAULT;
> > +	info->pseudo_palette = fb->palette;
> > +
> > +	err = fb_alloc_cmap(&info->cmap, 256, 0);
> > +	if (err < 0) {
> > +		err = -ENOMEM;
> > +		goto free;
> > +	}
> > +
> > +	err = register_framebuffer(info);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "failed to register framebuffer\n");
> > +		goto cmap;
> > +	}
> > +
> > +	dev_info(info->dev, "ADX framebuffer initialized\n");
> > +	platform_set_drvdata(pdev, info);
> > +	return 0;
> > +
> > +cmap:
> > +	fb_dealloc_cmap(&info->cmap);
> > +free:
> > +	framebuffer_release(info);
> > +	return err;
> > +}
> > +
> > +/**
> > + * adxfb_remove() - shutdown the framebuffer device
> > + * @pdev:	platform device
> > + */
> > +static int adxfb_remove(struct platform_device *pdev)
> > +{
> > +	struct fb_info *info = platform_get_drvdata(pdev);
> > +	unregister_framebuffer(info);
> > +	return 0;
> > +}
> > +
> > +/* ADXFB platform driver */
> > +static struct platform_driver adxfb_driver = {
> > +	.probe = adxfb_probe,
> > +	.remove = adxfb_remove,
> > +	.driver = {
> > +		.name = "adxfb",
> > +	},
> > +};
> > +
> > +/**
> > + * adxfb_init() - module initialization
> > + */
> > +int __init adxfb_init(void)
> > +{
> > +	return platform_driver_register(&adxfb_driver);
> > +}
> > +
> > +/**
> > + * adxfb_exit() - module cleanup
> > + */
> > +void __exit adxfb_exit(void)
> > +{
> > +	platform_driver_unregister(&adxfb_driver);
> > +}
> > +
> > +module_init(adxfb_init);
> > +module_exit(adxfb_exit);
> > +
> > +MODULE_AUTHOR("Thierry Reding <thierry.reding@avionic-design.de>");
> > +MODULE_DESCRIPTION("Avionic Design Xanthos framebuffer driver");
> > +MODULE_LICENSE("GPL v2");

I have no comments to rest of the patch so I removed it.

I have a general comment that you should make your driver
conform to the fbdev API (check_var/set_par) for mode setting.
I know you have the scaler, so leave the adfxfb_ioctl to handle it.
If you define the set_par/check_var functions to handle size of
the overlay's input (without scaling) and color format one can
use standard FBIOPUT_VSCREENINFO and 
FBIOGET_VSCREENINFO ioctls to set and read your overlay.
If the overlay should be scaled use the custom ioctls to set the 
scaling factors only.
Currently, your driver looks like it wants to work around the
fbdev API. See the skeletonfb.c for guidance.

Regards,
Krzysztof

----------------------------------------------------------------------
Audi kilka tysiecy zlotych taniej? Przebieraj wsrod tysiecy ogloszen!
Sprawdz: http://link.interia.pl/f216f


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
