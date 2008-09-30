From: krzysztof.h1@poczta.fm
Subject: Re: [RESEND][PATCH 1/2] fbdev: add new TMIO
	framebuffer driver
Date: 30 Sep 2008 11:11:11 +0200
Message-ID: <20080930091111.DC32B9F3470@f34.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1KkbGf-0005mg-QT
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Sep 2008 09:11:41 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KkbGK-0003ln-Qx for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Sep 2008 09:11:39 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, Ian Molton <spyro@f2s.com>, Samuel Ortiz <sameo@openedhand.com>

> Add driver for TMIO framebuffer cells as found e.g. in Toshiba TC6393XB
> chips.
> 
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Samuel Ortiz <sameo@openedhand.com>
> ---

This is not detailed review but only two issues:

> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
> new file mode 100644
> index 0000000..6c18f89
> --- /dev/null
> +++ b/drivers/video/tmiofb.c
> @@ -0,0 +1,1036 @@

(...)
> +static int __devinit tmiofb_probe(struct platform_device *dev)
> +{
> +	struct mfd_cell			*cell	= dev->dev.platform_data;
> +	struct tmio_fb_data		*data	= cell->driver_data;
> +	struct resource			*ccr	= platform_get_resource(dev, IORESOURCE_MEM, 1);
> +	struct resource			*lcr	= platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	struct resource			*vram	= platform_get_resource(dev, IORESOURCE_MEM,
> 2);
> +	int				irq	= platform_get_irq(dev, 0);
> +	struct fb_info			*info;
> +	struct tmiofb_par		*par;
> +	int				retval;
> +
> +	if (data == NULL) {
> +		dev_err(&dev->dev, "NULL platform data!n");
> +		return -EINVAL;
> +	}
> +
> +	info = framebuffer_alloc(sizeof(struct tmiofb_par), &dev->dev);
> +
> +	if (!info) {
> +		retval = -ENOMEM;
> +		goto err_framebuffer_alloc;
> +	}
> +
> +	par = info->par;
> +	platform_set_drvdata(dev, info);
> +
> +#ifdef CONFIG_FB_TMIO_ACCELL
> +	init_waitqueue_head(&par->wait_acc);
> +
> +	par->use_polling	= true;
> +
> +	info->flags		= FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA
> +						 | FBINFO_HWACCEL_FILLRECT;
> +#else
> +	info->flags		= FBINFO_DEFAULT;
> +#endif
> +
> +	info->fbops		= &tmiofb_ops;
> +
> +	strcpy(info->fix.id, "tmio-fb");
> +	info->fix.smem_start	= vram->start;
> +	info->fix.smem_len	= vram->end - vram->start + 1;
> +	info->fix.type		= FB_TYPE_PACKED_PIXELS;
> +	info->fix.visual	= FB_VISUAL_TRUECOLOR;
> +	info->fix.mmio_start	= lcr->start;
> +	info->fix.mmio_len	= lcr->end - lcr->start + 1;
> +	info->fix.accel		= FB_ACCEL_NONE;
> +	info->screen_size	= info->fix.smem_len - (4 * TMIOFB_FIFO_SIZE);
> +	info->pseudo_palette	= par->pseudo_palette;
> +
> +	par->ccr = ioremap(ccr->start, ccr->end - ccr->start + 1);
> +	if (!par->ccr) {
> +		retval = -ENOMEM;
> +		goto err_ioremap_ccr;
> +	}
> +
> +	par->lcr = ioremap(info->fix.mmio_start, info->fix.mmio_len);
> +	if (!par->lcr) {
> +		retval = -ENOMEM;
> +		goto err_ioremap_lcr;
> +	}
> +
> +	par->vram = ioremap(info->fix.smem_start, info->fix.smem_len);
> +	if (!par->vram) {
> +		retval = -ENOMEM;
> +		goto err_ioremap_vram;
> +	}
> +	info->screen_base = par->vram;
> +

if info->screen_base == par->vram you can drop vram field from the par structure.

> +	retval = request_irq(irq, &tmiofb_irq, IRQF_DISABLED,
> +					dev->dev.bus_id, info);
> +
> +	if (retval)
> +		goto err_request_irq;
> +
> +	retval = fb_find_mode(&info->var, info, mode_option,
> +			data->modes, data->num_modes,
> +			data->modes, 16);
> +	if (!retval) {
> +		retval = -EINVAL;
> +		goto err_find_mode;
> +	}
> +
> +	if (cell->enable) {
> +		retval = cell->enable(dev);
> +		if (retval)
> +			goto err_enable;
> +	}
> +
> +	retval = tmiofb_hw_init(dev);
> +	if (retval)
> +		goto err_hw_init;
> +
> +/*	retval = tmiofb_set_par(info);
> +	if (retval)
> +		goto err_set_par;*/
> +
> +	fb_videomode_to_modelist(data->modes, data->num_modes,
> +				 &info->modelist);
> +
> +	retval = register_framebuffer(info);
> +	if (retval < 0)
> +		goto err_register_framebuffer;
> +
> +	printk(KERN_INFO "fb%d: %s frame buffer devicen",
> +				info->node, info->fix.id);
> +
> +	return 0;
> +
> +err_register_framebuffer:
> +/*err_set_par:*/
> +	tmiofb_hw_stop(dev);
> +err_hw_init:
> +	if (cell->disable)
> +		cell->disable(dev);
> +err_enable:
> +err_find_mode:
> +	free_irq(irq, info);
> +err_request_irq:
> +	iounmap(par->vram);
> +err_ioremap_vram:
> +	iounmap(par->lcr);
> +err_ioremap_lcr:
> +	iounmap(par->ccr);
> +err_ioremap_ccr:
> +	platform_set_drvdata(dev, NULL);
> +	framebuffer_release(info);
> +err_framebuffer_alloc:
> +	return retval;
> +}
> +
> +static int __devexit tmiofb_remove(struct platform_device *dev)
> +{
> +	struct mfd_cell			*cell	= dev->dev.platform_data;
> +	struct fb_info			*info	= platform_get_drvdata(dev);
> +	int				irq	= platform_get_irq(dev, 0);
> +	struct tmiofb_par		*par;
> +
> +	if (info) {
> +		par = info->par;
> +		unregister_framebuffer(info);
> +
> +		tmiofb_hw_stop(dev);
> +
> +		if (cell->disable)
> +			cell->disable(dev);
> +
> +		free_irq(irq, info);
> +
> +		iounmap(par->vram);
> +		iounmap(par->lcr);
> +		iounmap(par->ccr);
> +
> +		framebuffer_release(info);
> +		platform_set_drvdata(dev, NULL);

Please set NULL to drvdata before releasing the fb_info structure.

Regards,
Krzysztof

----------------------------------------------------------------------
Dzwon taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1f26 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
