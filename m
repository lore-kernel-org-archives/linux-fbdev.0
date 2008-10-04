From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [RESEND][PATCH 1/2] fbdev: add new TMIO
	framebuffer driver
Date: Sun, 5 Oct 2008 01:41:15 +0400
Message-ID: <bc64b4640810041441t4e434939k4ff9db2a9dedad06@mail.gmail.com>
References: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
	<20081003022323.a523a510.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1KmFFd-0002iA-Rg
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 22:05:25 +0000
Received: from wr-out-0506.google.com ([64.233.184.231])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KmFFZ-0002ZU-30 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Oct 2008 22:05:25 +0000
Received: by wr-out-0506.google.com with SMTP id 60so902435wri.6
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 04 Oct 2008 15:05:20 -0700 (PDT)
In-Reply-To: <20081003022323.a523a510.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Molton <spyro@f2s.com>, Samuel Ortiz <sameo@openedhand.com>, linux-fbdev-devel@lists.sourceforge.net, Andrew W Woodward <akwoodward@juno.com>

Hi,

2008/10/3 Andrew Morton <akpm@linux-foundation.org>:
> On Tue, 30 Sep 2008 12:38:29 +0400 Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>
>> Add driver for TMIO framebuffer cells as found e.g. in Toshiba TC6393XB
>> chips.
>>
>
> Please feed the diff through scripts/checkpatch.pl and consider the
> resulting report.  afacit all the warnings could/should be repaired,
> except for the 80-col ones.  And even some of the latter could be
> addressed just by being a bit more careful with the tab key.

This and few other issues are already handled in the updated version
of the patch just sent.

>
>>
>> ...
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
>
> Why does FB_TMIO_ACCELL exist?  Can we remove it and make that code
> unconditional?

The accel code is a bit experimental. I'd prefer to leave the ability
to disable it
for now.

>> +     tmio_iowrite16(0, par->ccr + CCR_UGCC);
>> +     tmio_iowrite16(0, par->lcr + LCR_GM);
>> +     data->lcd_set_power(dev, 0);
>> +     tmio_iowrite16(0x0010, par->lcr + LCR_LCDCCRC);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * Initializes the LCD host controller.
>> + */
>> +static int tmiofb_hw_init(struct platform_device *dev)
>> +{
>> +     struct mfd_cell                 *cell   = dev->dev.platform_data;
>> +     struct tmio_fb_data             *data   = cell->driver_data;
>> +     struct fb_info                  *info   = platform_get_drvdata(dev);
>> +     struct tmiofb_par               *par    = info->par;
>> +     const struct resource           *nlcr   = &cell->resources[0];
>> +     const struct resource           *vram   = &cell->resources[2];
>> +     unsigned long                   base;
>> +
>> +     if (nlcr == NULL || vram == NULL)
>> +             return -EINVAL;
>> +
>> +     base = nlcr->start;
>> +
>> +     if (info->mode == NULL) {
>> +             printk(KERN_ERR "tmio-fb: null info->mode\n");
>
> Can this happen?

It does happen during initial probing AFAIR. I'll recheck later.

>
>> +             info->mode = data->modes;
>> +     }
>> +
>> +
>> +     tmio_iowrite16(0x0010, par->lcr + LCR_LCDCCRC);
>> +     mdelay(5);
>> +     tmio_iowrite16(0x0014, par->lcr + LCR_LCDCCRC); /* STOP_CKP */
>> +     mdelay(5);
>> +     tmio_iowrite16(0x0015, par->lcr + LCR_LCDCCRC); /* STOP_CKP | SOFT_RESET */
>> +     tmio_iowrite16(0xfffa, par->lcr + LCR_VCS);
>
> I trust that someone who is reasonably familiar with the hardware will
> know why all these magical mdelay()s are here.  But even if they are,
> some comments explaining them would enhance maintainability.

that's just for clocks/reset to happen.

>> +}
>> +
>> +/*--------------------------------------------------------------------------*/
>> +
>> +#ifdef CONFIG_FB_TMIO_ACCELL
>> +static int __must_check
>> +tmiofb_acc_wait(struct fb_info *info, unsigned int ccs)
>> +{
>> +     struct tmiofb_par               *par    = info->par;
>> +     if (in_atomic() || par->use_polling) {
>
> No, use of in_atomic() is almost always wrong.  It returns "false"
> inside a spinlocked section when CONFIG_PREEMPT=n.
>
> I cannot advise you further because (tada) there is no comment
> explaining this code to me.  But it will need to be rethought, please.

The problem is that code may call fb functions with interrupts disabled.
One of examples is suspend/resume path, when console seems to be
resumed before interrupts are enabled (this is governed
by par->use_polling). I'm not sure that there are no other uses of fb
functions in atomic context.

>> +             int i = 0;
>> +             while (tmio_ioread16(par->lcr + LCR_CCS) > ccs) {
>> +                     udelay(1);
>> +                     i++;
>> +                     if (i > 10000) {
>> +                             printk(KERN_ERR "tmiofb: timeout waiting for %d\n", ccs);
>> +                             return -ETIMEDOUT;
>> +                     }
>> +                     tmiofb_irq(-1, info);
>> +             }
>> +     } else {
>> +             if (!wait_event_interruptible_timeout(par->wait_acc,
>> +                             tmio_ioread16(par->lcr + LCR_CCS) <= ccs, 1000)) {
>> +                     printk(KERN_ERR "tmiofb: timeout waiting for %d\n", ccs);
>> +                     return -ETIMEDOUT;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>
>> ...
>>
>> +static void
>> +tmiofb_fillrect(struct fb_info *fbi, const struct fb_fillrect *rect)
>> +{
>> +     const u32 cmd [] = {
>> +             TMIOFB_ACC_DSADR((rect->dy * fbi->mode->xres + rect->dx) * 2),
>> +             TMIOFB_ACC_DHPIX(rect->width    - 1),
>> +             TMIOFB_ACC_DVPIX(rect->height   - 1),
>
> you really like those tabs ;)
>
>> +             TMIOFB_ACC_FILL(rect->color),
>> +             TMIOFB_ACC_FLGO,
>> +     };
>> +
>> +     if (fbi->state != FBINFO_STATE_RUNNING ||
>> +         fbi->flags & FBINFO_HWACCEL_DISABLED) {
>> +             cfb_fillrect(fbi, rect);
>> +             return;
>> +     }
>> +
>> +     tmiofb_acc_write(fbi, cmd, ARRAY_SIZE(cmd));
>> +}
>> +
>>
>> ...
>>
>> +static void tmiofb_clearscreen(struct fb_info *info)
>> +{
>> +     const struct fb_fillrect rect = {
>> +             .dx     = 0,
>> +             .dy     = 0,
>> +             .width  = info->mode->xres,
>> +             .height = info->mode->yres,
>> +             .color  = 0,
>> +     };
>
> fyi, the members which are to be initialised to zero don't need to be
> listed with this construct.  Although one might choose to fill them in
> for readbility/documentation reasons (in which case: where's
> fb_fillrect.rop?)

I'll think about this.  If you insist, I'll drop those =0 from next generation
of the patch.

>
>> +     info->fbops->fb_fillrect(info, &rect);
>> +}
>> +
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
>
> An extra indent there.

removed

>
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
>
> get_user() would be simpler and quicker.

in the next generation of the patch

>
>> +             if (len > ARRAY_SIZE(acc))
>> +                     return -EINVAL;
>> +             if (copy_from_user(acc, argp + 1, sizeof(u32) * len))
>> +                     return -EFAULT;
>> +
>> +             return tmiofb_acc_write(fbi, acc, len);
>> +     }
>
> So there's no way for userspace to read back the current setting of
> `acc' (whatever that is)?

acc is a serie of accelerator commands dircetly written to command
FIFO of the card
This hook is used e.g. by proprietary original accelerated libqte.
There is nothing to read back.

>> +#endif
>> +     }
>> +
>> +     return -EINVAL;
>
> Unimplemented ioctl numbers usually return -ENOTTY, although your
> -EINVAL might get converted to -ENOTTY at some higher level (which
> would be a bad thing).  Please check.

That is strange, since fb_ioctl() (see drivers/video/fbmem.c) does
return -EINVAL
in case of unsupported ioctl value. From the man page:

EINVAL Request or argp is not valid.
ENOTTY The specified request does not apply to the kind of object that
the descriptor d references.

So, it a bit unclear from that page what each value means. Changed
anyway per your request.

>> +}
>> +
>> +/*--------------------------------------------------------------------------*/
>> +
>> +/* Select the smallest mode that allows the desired resolution to be
>> + * displayed.  If desired, the x and y parameters can be rounded up to
>> + * match the selected mode.
>> + */
>> +static struct fb_videomode*
>
> A single space before the "*", please.  checkpatch missed this.

changed

>
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
>> +     var->xoffset            = 0;
>> +     var->yoffset            = 0;
>> +     var->bits_per_pixel     = 16;
>> +     var->grayscale          = 0;
>> +     var->red.offset         = 11;   var->red.length         = 5;
>> +     var->green.offset       = 5;    var->green.length       = 6;
>> +     var->blue.offset        = 0;    var->blue.length        = 5;
>> +     var->transp.offset      = 0;    var->transp.length      = 0;
>
> One statement per line is preferred, please.

changed

>
>> +     var->nonstd             = 0;
>> +     var->height             = 82;   /* mm */
>> +     var->width              = 60;   /* mm */
>> +     var->rotate             = 0;
>> +     return 0;
>> +}
>> +
>>
>> ...
>>
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
>
> Does .fb_setcolreg really return positive non-zero on error?  That
> would be a bit sad - it should expect a -ve errno and should propagate
> that back.  Oh well.  Please check it?

You were right. Corrected.

>
>> +static int tmiofb_blank(int blank, struct fb_info *info)
>> +{
>> +     /*
>> +      * everything is done in lcd/bl drivers.
>> +      * this is purely to make sysfs happy and work.
>> +      */
>> +     return 0;
>> +}
>> +
>>
>> ...
>>
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
>
> It'd be nice if there was a comment somewhere explaining to the reader
> what's actually happening here.  Some overall design/perspective thing.

see the patch (version 3).

>
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
>
> Can this happen?

Of course, if you pass incorrect data to your TMIO controller chip.
This is better than kernel Oops.

>
>> +             return -EINVAL;
>> +     }
>> +
>> +     info = framebuffer_alloc(sizeof(struct tmiofb_par), &dev->dev);
>> +
>> +     if (!info) {
>> +             retval = -ENOMEM;
>> +             goto err_framebuffer_alloc;
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
>> +     info->fix.type          = FB_TYPE_PACKED_PIXELS;
>> +     info->fix.visual        = FB_VISUAL_TRUECOLOR;
>> +     info->fix.mmio_start    = lcr->start;
>> +     info->fix.mmio_len      = lcr->end - lcr->start + 1;
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
>>
>> ...
>>
>> +#ifdef CONFIG_PM
>> +static int tmiofb_suspend(struct platform_device *dev, pm_message_t state)
>> +{
>> +     struct fb_info                  *info   = platform_get_drvdata(dev);
>> +     struct tmiofb_par               *par    = info->par;
>> +     struct mfd_cell                 *cell   = dev->dev.platform_data;
>> +     int                             retval  = 0;
>> +
>> +     acquire_console_sem();
>> +
>> +     fb_set_suspend(info, 1);
>> +
>> +     if (info->fbops->fb_sync)
>> +             info->fbops->fb_sync(info);
>> +
>> +
>> +     printk(KERN_INFO "tmiofb: switching to polling\n");
>
> why...
>
>> +     par->use_polling = true;
>> +     tmiofb_hw_stop(dev);
>> +
>> +     if (cell->suspend)
>> +             retval = cell->suspend(dev);
>> +
>> +     release_console_sem();
>> +
>> +     return retval;
>> +}
>> +
>>
>> ...
>>
>> --- a/include/linux/mfd/tmio.h
>> +++ b/include/linux/mfd/tmio.h
>> @@ -1,6 +1,8 @@
>>  #ifndef MFD_TMIO_H
>>  #define MFD_TMIO_H
>>
>> +#include <linux/fb.h>
>> +
>>  #define tmio_ioread8(addr) readb(addr)
>>  #define tmio_ioread16(addr) readw(addr)
>>  #define tmio_ioread16_rep(r, b, l) readsw(r, b, l)
>
> I realise it isn't your code, but these:
>
> #define tmio_ioread32(addr) \
>        (((u32) readw((addr))) | (((u32) readw((addr) + 2)) << 16))
>
> #define tmio_iowrite32(val, addr) \
>        do { \
>        writew((val),       (addr)); \
>        writew((val) >> 16, (addr) + 2); \
>        } while (0)
>
> aren't good.  They reference their arguments multiple times and hence
> will misbehave if passed an expression with side-effects.
>
> As is so often the case, these never needed to be implemented as macros
> and hence should not have been.  C is better.
>
>>
>> ...
>>
>
> The code looks reasonable overall but the in_atomic() thing is a
> show-stopper.

Thanks for the review. Most of the issues you have raised will be adressed
in v3 of this patch being posted now. in_atomic() remains unfixed as I'm waiting
for the advide from your (and fbdev) side.

-- 
With best wishes
Dmitry

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
