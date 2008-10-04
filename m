From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [RESEND][PATCH 1/2] fbdev: add new TMIO
	framebuffer driver
Date: Sat, 4 Oct 2008 17:38:33 +0400
Message-ID: <bc64b4640810040638n550db766x313e40d39d849255@mail.gmail.com>
References: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
	<20081001000415.0b600235.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1Km7LK-0005RC-KH
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 13:38:46 +0000
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Km7L9-0004Ep-GD for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 13:38:46 +0000
Received: by gxk12 with SMTP id 12so3988333gxk.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 04 Oct 2008 06:38:34 -0700 (PDT)
In-Reply-To: <20081001000415.0b600235.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Ian Molton <spyro@f2s.com>, Samuel Ortiz <sameo@openedhand.com>, linux-fbdev-devel@lists.sourceforge.net

Hi,

Thank you for the review,

2008/10/1 Krzysztof Helt <krzysztof.h1@poczta.fm>:
> On Tue, 30 Sep 2008 12:38:29 +0400
> Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>
>> Add driver for TMIO framebuffer cells as found e.g. in Toshiba TC6393XB
>> chips.
>>
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>> Cc: Ian Molton <spyro@f2s.com>
>> Cc: Samuel Ortiz <sameo@openedhand.com>
>> ---
>
> A more detailed review now:
>
>
>>  drivers/video/Kconfig    |   22 +
>>  drivers/video/Makefile   |    1 +
>>  drivers/video/tmiofb.c   | 1036 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/tmio.h |   15 +
>>  4 files changed, 1074 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/video/tmiofb.c
>>
>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>> index 70d135e..cf71db4 100644
>> --- a/drivers/video/Kconfig
>> +++ b/drivers/video/Kconfig
>> @@ -1876,6 +1876,28 @@ config FB_SH_MOBILE_LCDC
>>       ---help---
>>         Frame buffer driver for the on-chip SH-Mobile LCD controller.
>>
>> +config FB_TMIO
>> +     tristate "Toshiba Mobice IO FrameBuffer support"
>> +     depends on FB && MFD_CORE
>> +     select FB_CFB_FILLRECT
>> +     select FB_CFB_COPYAREA
>> +     select FB_CFB_IMAGEBLIT
>> +     ---help---
>> +       Frame buffer driver for the Toshiba Mobile IO integrated as found
>> +       on the Sharp SL-6000 series
>> +
>> +       This driver is also available as a module ( = code which can be
>> +       inserted and removed from the running kernel whenever you want). The
>> +       module will be called tmiofb. If you want to compile it as a module,
>> +       say M here and read <file:Documentation/kbuild/modules.txt>.
>> +
>> +       If unsure, say N.
>> +
>> +config FB_TMIO_ACCELL
>> +     bool "tmiofb acceleration"
>> +     depends on FB_TMIO
>> +     default y
>> +
>>  config FB_S3C2410
>>       tristate "S3C2410 LCD framebuffer support"
>>       depends on FB && ARCH_S3C2410
>> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
>> index a6b5529..32ca1f9 100644
>> --- a/drivers/video/Makefile
>> +++ b/drivers/video/Makefile
>> @@ -98,6 +98,7 @@ obj-$(CONFIG_FB_CIRRUS)               += cirrusfb.o
>>  obj-$(CONFIG_FB_ASILIANT)      += asiliantfb.o
>>  obj-$(CONFIG_FB_PXA)           += pxafb.o
>>  obj-$(CONFIG_FB_W100)                  += w100fb.o
>> +obj-$(CONFIG_FB_TMIO)                  += tmiofb.o
>>  obj-$(CONFIG_FB_AU1100)                += au1100fb.o
>>  obj-$(CONFIG_FB_AU1200)                += au1200fb.o
>>  obj-$(CONFIG_FB_PMAG_AA)       += pmag-aa-fb.o
>> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
>> new file mode 100644
>> index 0000000..6c18f89
>> --- /dev/null
>> +++ b/drivers/video/tmiofb.c
>> @@ -0,0 +1,1036 @@
>> +/*
>> + * Frame Buffer Device for Toshiba Mobile IO(TMIO) controller
>> + *
>> + * Copyright(C) 2005-2006 Chris Humbert
>> + * Copyright(C) 2005 Dirk Opfer
>> + * Copytight(C) 2007,2008 Dmitry Baryshkov
>> + *
>> + * Based on:
>> + *   drivers/video/w100fb.c
>> + *   code written by Sharp/Lineo for 2.4 kernels
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>
> I don't know if the clause "or (at your option) any later version" is widely
> accepted for kernel sources. See Linus post here:
>
> http://lkml.org/lkml/2006/1/25/273
>
> A safer clause is:
>
>  * This file is subject to the terms and conditions of the GNU General Public
>  * License. See the file COPYING in the main directory of this archive for
>  * more details.

I'd instead change it to:
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2
 * as published by the Free Software Foundation;

Is it suitable?

>
> If you can cut one tab before values you can fit the section below within 80-column limit.

done

>> +struct tmiofb_par {
>> +     u32                             pseudo_palette[16];
>> +
>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +     wait_queue_head_t               wait_acc;
>> +     bool                            use_polling;
>> +#endif
>> +
>> +     void __iomem                    *ccr;
>> +     void __iomem                    *lcr;
>> +     void __iomem                    *vram;
>
> The vram field is not needed as it is always equal to fb_info->screen_base.

I'd keep it for simplicity and simmery, as par then contains all
ioremapped regions.

>
>> +};
>> +
>> +/*--------------------------------------------------------------------------*/
>> +
>> +static irqreturn_t tmiofb_irq(int irq, void *__info);
>
> You can move the trmiofb_irq earlier and just drop the forward
> declaration.

done

>> +
>> +     data->lcd_set_power(dev, 1);
>> +     mdelay(2);
>
> msleep() is preferred over mdelay() here and below.

changed.

>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +static int __must_check
>> +tmiofb_acc_wait(struct fb_info *info, unsigned int ccs)
>> +{
>> +     struct tmiofb_par               *par    = info->par;
>
> Such a wide formatting does not look good here and in few functions below.

Oops... I thought I've already removed it.

>> +static void tmiofb_clearscreen(struct fb_info *info)
>> +{
>> +     const struct fb_fillrect rect = {
>> +             .dx     = 0,
>> +             .dy     = 0,
>> +             .width  = info->mode->xres,
>> +             .height = info->mode->yres,
>> +             .color  = 0,
>> +     };
>> +
>> +     info->fbops->fb_fillrect(info, &rect);
>> +}
>> +
>
> This function is probably redundant as it is used only inside
> the set_par() function. My experience shows that the screen is
> blanked every time set_par() changes parameters so clearing
> it again does nothing. Please test if this function is needed.

I'll check it next week (don't have the hw at hand now). Next patch generation
will still contain it.

>
>> +static int tmiofb_vblank(struct fb_info *fbi, struct fb_vblank *vblank)
>> +{
>> +     struct tmiofb_par       *par    = fbi->par;
>> +     struct fb_videomode     *mode   = fbi->mode;
>> +     unsigned int            vcount  = tmio_ioread16(par->lcr + LCR_CDLN);
>> +     unsigned int            vds     = mode->vsync_len + mode->upper_margin;
>> +
>> +     vblank->vcount  = vcount;
>> +     vblank->flags   = FB_VBLANK_HAVE_VBLANK | FB_VBLANK_HAVE_VCOUNT
>> +                                             | FB_VBLANK_HAVE_VSYNC;
>> +
>> +     if (vcount < mode->vsync_len)
>> +             vblank->flags |= FB_VBLANK_VSYNCING;
>> +
>> +     if (vcount < vds || vcount > vds + mode->yres)
>> +             vblank->flags |= FB_VBLANK_VBLANKING;
>> +
>> +     return 0;
>> +}
>> +
>> +
>> +static int tmiofb_ioctl(struct fb_info *fbi,
>> +             unsigned int cmd, unsigned long arg)
>> +{
>> +     switch (cmd) {
>> +     case FBIOGET_VBLANK: {
>> +             struct fb_vblank        vblank  = {0};
>> +             void __user             *argp   = (void __user *) arg;
>> +
>> +             tmiofb_vblank(fbi, &vblank);
>> +             if (copy_to_user(argp, &vblank, sizeof vblank))
>> +                             return -EFAULT;
>> +             return 0;
>> +     }
>> +
>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +     case FBIO_TMIO_ACC_SYNC:
>> +             tmiofb_sync(fbi);
>> +             return 0;
>> +
>> +     case FBIO_TMIO_ACC_WRITE: {
>> +             u32 __user      *argp   = (void __user *) arg;
>> +             u32             len;
>> +             u32             acc [16];
>> +
>> +             if (copy_from_user(&len, argp, sizeof(u32)))
>> +                     return -EFAULT;
>> +             if (len > ARRAY_SIZE(acc))
>> +                     return -EINVAL;
>> +             if (copy_from_user(acc, argp + 1, sizeof(u32) * len))
>> +                     return -EFAULT;
>> +
>> +             return tmiofb_acc_write(fbi, acc, len);
>> +     }
>> +#endif
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +/*--------------------------------------------------------------------------*/
>> +
>> +/* Select the smallest mode that allows the desired resolution to be
>> + * displayed.  If desired, the x and y parameters can be rounded up to
>> + * match the selected mode.
>> + */
>> +static struct fb_videomode*
>> +tmiofb_find_mode(struct fb_info *info, struct fb_var_screeninfo *var)
>> +{
>> +     struct mfd_cell                 *cell   = to_platform_device(info->device)->dev.platform_data;
>> +     struct tmio_fb_data             *data   = cell->driver_data;
>> +     struct fb_videomode             *best   = NULL;
>> +     int                             i;
>> +
>> +     for (i = 0; i < data->num_modes; i++) {
>> +             struct fb_videomode *mode = data->modes + i;
>> +
>> +             if (mode->xres >= var->xres && mode->yres >= var->yres
>> +                             && (!best || (mode->xres < best->xres
>> +                                        && mode->yres < best->yres)))
>> +                     best = mode;
>> +     }
>> +
>> +     return best;
>> +}
>> +
>> +static int tmiofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
>> +{
>> +
>> +     struct fb_videomode     *mode;
>> +
>> +     mode = tmiofb_find_mode(info, var);
>> +     if (!mode || var->bits_per_pixel > 16)
>> +             return -EINVAL;
>> +
>> +     fb_videomode_to_var(var, mode);
>> +
>> +     var->xres_virtual       = mode->xres;
>> +     var->yres_virtual       = info->screen_size / (mode->xres * 2);
>
> This could be a mistake as the yres_virtual is half size of the possible
> memory. There is no check if the yres > yres_virtual nor that
> (screen_size >= 2 * xres).

screen_size = xres * yres_virtual * bytes_per_pixel, so /2 is correct.


>> +     var->xoffset            = 0;
>> +     var->yoffset            = 0;
>> +     var->bits_per_pixel     = 16;
>> +     var->grayscale          = 0;
>> +     var->red.offset         = 11;   var->red.length         = 5;
>> +     var->green.offset       = 5;    var->green.length       = 6;
>> +     var->blue.offset        = 0;    var->blue.length        = 5;
>> +     var->transp.offset      = 0;    var->transp.length      = 0;
>> +     var->nonstd             = 0;
>> +     var->height             = 82;   /* mm */
>> +     var->width              = 60;   /* mm */
>
> Shouldn't the height and width be in the platform_data
> as the resolution?

good idea!

>
>> +     var->rotate             = 0;
>> +     return 0;
>> +}
>> +
>> +static int tmiofb_set_par(struct fb_info *info)
>> +{
>> +     struct fb_var_screeninfo        *var    = &info->var;
>> +     struct fb_videomode             *mode;
>> +
>> +     mode = tmiofb_find_mode(info, var);
>> +     if (!mode)
>> +             return -EINVAL;
>> +
>> +/*   if (info->mode == mode)
>> +             return 0;*/
>> +
>> +     info->mode              = mode;
>> +     info->fix.line_length   = info->mode->xres * 2;
>
> I would go for (var->bpp / 8) instead of 2 here (or a comment).

fine with me.

>
>> +
>> +     tmiofb_hw_mode(to_platform_device(info->device));
>> +     tmiofb_clearscreen(info);
>> +     return 0;
>> +}
>> +
>> +static int tmiofb_setcolreg(unsigned regno, unsigned red, unsigned green,
>> +                        unsigned blue, unsigned transp,
>> +                        struct fb_info *info)
>> +{
>> +     struct tmiofb_par       *par    = info->par;
>> +
>> +     if (regno < ARRAY_SIZE(par->pseudo_palette)) {
>> +             par->pseudo_palette [regno] =
>> +                     ((red   & 0xf800))              |
>> +                     ((green & 0xfc00) >>  5)        |
>> +                     ((blue  & 0xf800) >> 11);
>> +             return 0;
>> +     }
>> +
>> +     return 1;
>> +}
>> +
>> +static int tmiofb_blank(int blank, struct fb_info *info)
>> +{
>> +     /*
>> +      * everything is done in lcd/bl drivers.
>> +      * this is purely to make sysfs happy and work.
>> +      */
>> +     return 0;
>> +}
>> +
>> +static struct fb_ops tmiofb_ops = {
>> +     .owner          = THIS_MODULE,
>> +
>> +     .fb_ioctl       = tmiofb_ioctl,
>> +     .fb_check_var   = tmiofb_check_var,
>> +     .fb_set_par     = tmiofb_set_par,
>> +     .fb_setcolreg   = tmiofb_setcolreg,
>> +     .fb_blank       = tmiofb_blank,
>> +     .fb_imageblit   = cfb_imageblit,
>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +     .fb_sync        = tmiofb_sync,
>> +     .fb_fillrect    = tmiofb_fillrect,
>> +     .fb_copyarea    = tmiofb_copyarea,
>> +#else
>> +     .fb_fillrect    = cfb_fillrect,
>> +     .fb_copyarea    = cfb_copyarea,
>> +#endif
>> +};
>> +
>> +/*--------------------------------------------------------------------------*/
>> +
>> +/*
>> + * reasons for an interrupt:
>> + *   uis     bbisc   lcdis
>> + *   0100    0001            accelerator command completed
>> + *   2000            0001    vsync start
>> + *   2000            0002    display start
>> + *   2000            0004    line number match(0x1ff mask???)
>> + */
>> +static irqreturn_t tmiofb_irq(int irq, void *__info)
>> +{
>> +     struct fb_info                  *info   = __info;
>> +     struct tmiofb_par               *par    = info->par;
>> +     unsigned int                    bbisc   = tmio_ioread16(par->lcr + LCR_BBISC);
>> +
>> +
>> +     if (unlikely(par->use_polling && irq != -1)) {
>> +             printk(KERN_INFO "tmiofb: switching to waitq\n");
>> +             par->use_polling = false;
>> +     }
>> +
>> +     tmio_iowrite16(bbisc, par->lcr + LCR_BBISC);
>> +
>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +     if (bbisc & 1)
>> +             wake_up(&par->wait_acc);
>> +#endif
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int __devinit tmiofb_probe(struct platform_device *dev)
>> +{
>> +     struct mfd_cell                 *cell   = dev->dev.platform_data;
>> +     struct tmio_fb_data             *data   = cell->driver_data;
>> +     struct resource                 *ccr    = platform_get_resource(dev, IORESOURCE_MEM, 1);
>> +     struct resource                 *lcr    = platform_get_resource(dev, IORESOURCE_MEM, 0);
>> +     struct resource                 *vram   = platform_get_resource(dev, IORESOURCE_MEM, 2);
>> +     int                             irq     = platform_get_irq(dev, 0);
>> +     struct fb_info                  *info;
>> +     struct tmiofb_par               *par;
>> +     int                             retval;
>> +
>> +     if (data == NULL) {
>> +             dev_err(&dev->dev, "NULL platform data!\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     info = framebuffer_alloc(sizeof(struct tmiofb_par), &dev->dev);
>> +
>> +     if (!info) {
>> +             retval = -ENOMEM;
>> +             goto err_framebuffer_alloc;
>
> You can do just return -ENOMEM here (as in the condition above).

done

>
>> +     }
>> +
>> +     par = info->par;
>> +     platform_set_drvdata(dev, info);
>> +
>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +     init_waitqueue_head(&par->wait_acc);
>> +
>> +     par->use_polling        = true;
>> +
>> +     info->flags             = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA
>> +                                              | FBINFO_HWACCEL_FILLRECT;
>> +#else
>> +     info->flags             = FBINFO_DEFAULT;
>> +#endif
>> +
>> +     info->fbops             = &tmiofb_ops;
>> +
>> +     strcpy(info->fix.id, "tmio-fb");
>> +     info->fix.smem_start    = vram->start;
>> +     info->fix.smem_len      = vram->end - vram->start + 1;
>
> resource_size() function is handy here.

done

>
>> +     info->fix.type          = FB_TYPE_PACKED_PIXELS;
>> +     info->fix.visual        = FB_VISUAL_TRUECOLOR;
>> +     info->fix.mmio_start    = lcr->start;
>> +     info->fix.mmio_len      = lcr->end - lcr->start + 1;
>
> resource_size() function is handy here and below in this function.

done

>
>> +     info->fix.accel         = FB_ACCEL_NONE;
>> +     info->screen_size       = info->fix.smem_len - (4 * TMIOFB_FIFO_SIZE);
>> +     info->pseudo_palette    = par->pseudo_palette;
>> +
>> +     par->ccr = ioremap(ccr->start, ccr->end - ccr->start + 1);
>> +     if (!par->ccr) {
>> +             retval = -ENOMEM;
>> +             goto err_ioremap_ccr;
>> +     }
>> +
>> +     par->lcr = ioremap(info->fix.mmio_start, info->fix.mmio_len);
>> +     if (!par->lcr) {
>> +             retval = -ENOMEM;
>> +             goto err_ioremap_lcr;
>> +     }
>> +
>> +     par->vram = ioremap(info->fix.smem_start, info->fix.smem_len);
>> +     if (!par->vram) {
>> +             retval = -ENOMEM;
>> +             goto err_ioremap_vram;
>> +     }
>> +     info->screen_base = par->vram;
>> +
>> +     retval = request_irq(irq, &tmiofb_irq, IRQF_DISABLED,
>> +                                     dev->dev.bus_id, info);
>> +
>> +     if (retval)
>> +             goto err_request_irq;
>> +
>> +     retval = fb_find_mode(&info->var, info, mode_option,
>> +                     data->modes, data->num_modes,
>> +                     data->modes, 16);
>> +     if (!retval) {
>> +             retval = -EINVAL;
>> +             goto err_find_mode;
>> +     }
>> +
>> +     if (cell->enable) {
>> +             retval = cell->enable(dev);
>> +             if (retval)
>> +                     goto err_enable;
>> +     }
>> +
>> +     retval = tmiofb_hw_init(dev);
>> +     if (retval)
>> +             goto err_hw_init;
>> +
>> +/*   retval = tmiofb_set_par(info);
>> +     if (retval)
>> +             goto err_set_par;*/
>> +
>
> Please kill or enable the code above.

killed the code as it was a leftover from earlier driver.

>
>> +     fb_videomode_to_modelist(data->modes, data->num_modes,
>> +                              &info->modelist);
>> +
>> +     retval = register_framebuffer(info);
>> +     if (retval < 0)
>> +             goto err_register_framebuffer;
>> +
>> +     printk(KERN_INFO "fb%d: %s frame buffer device\n",
>> +                             info->node, info->fix.id);
>> +
>> +     return 0;
>> +
>> +err_register_framebuffer:
>> +/*err_set_par:*/
>> +     tmiofb_hw_stop(dev);
>> +err_hw_init:
>> +     if (cell->disable)
>> +             cell->disable(dev);
>> +err_enable:
>> +err_find_mode:
>> +     free_irq(irq, info);
>> +err_request_irq:
>> +     iounmap(par->vram);
>> +err_ioremap_vram:
>> +     iounmap(par->lcr);
>> +err_ioremap_lcr:
>> +     iounmap(par->ccr);
>> +err_ioremap_ccr:
>> +     platform_set_drvdata(dev, NULL);
>> +     framebuffer_release(info);
>> +err_framebuffer_alloc:
>> +     return retval;
>> +}
>> +
>> +static int __devexit tmiofb_remove(struct platform_device *dev)
>> +{
>> +     struct mfd_cell                 *cell   = dev->dev.platform_data;
>> +     struct fb_info                  *info   = platform_get_drvdata(dev);
>> +     int                             irq     = platform_get_irq(dev, 0);
>> +     struct tmiofb_par               *par;
>> +
>> +     if (info) {
>> +             par = info->par;
>> +             unregister_framebuffer(info);
>> +
>> +             tmiofb_hw_stop(dev);
>> +
>> +             if (cell->disable)
>> +                     cell->disable(dev);
>> +
>> +             free_irq(irq, info);
>> +
>> +             iounmap(par->vram);
>> +             iounmap(par->lcr);
>> +             iounmap(par->ccr);
>> +
>> +             framebuffer_release(info);
>> +             platform_set_drvdata(dev, NULL);
>
> Exchange these two lines above.

done.

>
> The rest of the driver is fine.
>
> Please run checkpatch.pl script and try to keep the code in 80-column format (many of longer lines can be easily converted to something shorter).

I've left only one line > 80 column for comments format consistency.

Final patch following in the next mail.

-- 
With best wishes
Dmitry

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
