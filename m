From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 1/7] pxafb: module
	unloading support
Date: Tue, 10 Jun 2008 14:25:02 +0800
Message-ID: <484E1E3E.40204@gmail.com>
References: <1212814166-10313-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5xIG-0007pM-GE for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jun 2008 23:25:20 -0700
Received: from rv-out-0708.google.com ([209.85.198.244])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K5xIE-0005K2-WA
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Jun 2008 23:25:20 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2205737rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 09 Jun 2008 23:25:18 -0700 (PDT)
In-Reply-To: <1212814166-10313-2-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Jaya Kumar wrote:
> This patch to pxafb adds:
>  - exit and remove handlers
>  - changes to use __devinit/exit for probe functions and __init/exit for
>    init/exit functions
>  - reorders failure handling in probe
> 

Overall looks OK to me. However, I suggest to have three separate
patches for this:

1 for reorder failure
1 for sanitized usage of __devinit
1 for exit and remove handlers

with some comments below.

> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  drivers/video/pxafb.c |   66 ++++++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 54 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 274bc93..209a03d 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -1246,7 +1246,7 @@ static int pxafb_resume(struct platform_device *dev)
>   *      cache.  Once this area is remapped, all virtual memory
>   *      access to the video memory should occur at the new region.
>   */
> -static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
> +static int __devinit pxafb_map_video_memory(struct pxafb_info *fbi)
>  {
>  	/*
>  	 * We reserve one page for the palette, plus the size
> @@ -1346,7 +1346,7 @@ decode_mode:
>  	pxafb_decode_mode_info(fbi, inf->modes, inf->num_modes);
>  }
>  
> -static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
> +static struct pxafb_info * __devinit pxafb_init_fbinfo(struct device *dev)
>  {
>  	struct pxafb_info *fbi;
>  	void *addr;
> @@ -1408,7 +1408,7 @@ static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
>  }
>  
>  #ifdef CONFIG_FB_PXA_PARAMETERS
> -static int __init parse_opt_mode(struct device *dev, const char *this_opt)
> +static int __devinit parse_opt_mode(struct device *dev, const char *this_opt)
>  {
>  	struct pxafb_mach_info *inf = dev->platform_data;
>  
> @@ -1467,7 +1467,7 @@ done:
>  	return 0;
>  }
>  
> -static int __init parse_opt(struct device *dev, char *this_opt)
> +static int __devinit parse_opt(struct device *dev, char *this_opt)
>  {
>  	struct pxafb_mach_info *inf = dev->platform_data;
>  	struct pxafb_mode_info *mode = &inf->modes[0];
> @@ -1565,7 +1565,7 @@ static int __init parse_opt(struct device *dev, char *this_opt)
>  	return 0;
>  }
>  
> -static int __init pxafb_parse_options(struct device *dev, char *options)
> +static int __devinit pxafb_parse_options(struct device *dev, char *options)
>  {
>  	char *this_opt;
>  	int ret;
> @@ -1587,7 +1587,7 @@ static int __init pxafb_parse_options(struct device *dev, char *options)
>  static char g_options[256] __devinitdata = "";
>  
>  #ifndef CONFIG_MODULES
> -static int __devinit pxafb_setup_options(void)
> +static int __init pxafb_setup_options(void)
>  {
>  	char *options = NULL;
>  
> @@ -1611,7 +1611,7 @@ MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
>  #define pxafb_setup_options()		(0)
>  #endif
>  
> -static int __init pxafb_probe(struct platform_device *dev)
> +static int __devinit pxafb_probe(struct platform_device *dev)
>  {
>  	struct pxafb_info *fbi;
>  	struct pxafb_mach_info *inf;
> @@ -1763,29 +1763,65 @@ static int __init pxafb_probe(struct platform_device *dev)
>  
>  failed_free_irq:
>  	free_irq(irq, fbi);
> -failed_free_res:
> -	release_mem_region(r->start, r->end - r->start + 1);
> -failed_free_io:
> -	iounmap(fbi->mmio_base);
> +	if (fbi->fb.cmap.len)
> +		fb_dealloc_cmap(&fbi->fb.cmap);
>  failed_free_mem:
>  	dma_free_writecombine(&dev->dev, fbi->map_size,
>  			fbi->map_cpu, fbi->map_dma);
> +failed_free_io:
> +	iounmap(fbi->mmio_base);
> +failed_free_res:
> +	release_mem_region(r->start, r->end - r->start + 1);

I'd prefer a separate patch to fix the exit sequence. There is another
issue of the below code labeled by "failed:", which incorrect kfree()
the fbi, which might not be initialized yet. So I'd suggest another
failed_fbi as below:

>  failed:
>  	platform_set_drvdata(dev, NULL);
>  	kfree(fbi);

failed_fbi:
	kfree(fbi);
failed:
	return ret;

and platform_set_drvdata() can be moved to failed_free_irq, since that
is the place after which platform_set_drvdata(dev, fbi) is called.

>  	return ret;
>  }
>  
> +static int __devexit pxafb_remove(struct platform_device *dev)
> +{
> +	struct pxafb_info *fbi = platform_get_drvdata(dev);
> +	struct resource *r;
> +	int irq;
> +
> +	if (fbi) {

I'd write this as

	if (fbi == NULL)
		return 0;

so we save one indent tab here, but that's personal style and
it's up to you.

> +		struct fb_info *info = &fbi->fb;
> +
> +		unregister_framebuffer(info);
> +		if (fbi->fb.cmap.len)
> +			fb_dealloc_cmap(&info->cmap);
> +
> +		pxafb_disable_controller(fbi);
> +		clk_put(fbi->clk);
> +
> +		dma_free_writecombine(&dev->dev, fbi->map_size,
> +					fbi->map_cpu, fbi->map_dma);
> +
> +		irq = platform_get_irq(dev, 0);
> +		free_irq(irq, fbi);
> +
> +		iounmap(fbi->mmio_base);
> +
> +		r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +		release_mem_region(r->start, r->end - r->start + 1);
> +
> +		kfree(fbi);
> +	}
> +	return 0;
> +}
> +
>  static struct platform_driver pxafb_driver = {
>  	.probe		= pxafb_probe,
> +	.remove 	= pxafb_remove,
>  	.suspend	= pxafb_suspend,
>  	.resume		= pxafb_resume,
>  	.driver		= {
> +		.owner	= THIS_MODULE,
>  		.name	= "pxa2xx-fb",
>  	},
>  };
>  
> -static int __devinit pxafb_init(void)
> +static int __init pxafb_init(void)
>  {
>  	if (pxafb_setup_options())
>  		return -EINVAL;
> @@ -1793,7 +1829,13 @@ static int __devinit pxafb_init(void)
>  	return platform_driver_register(&pxafb_driver);
>  }
>  
> +static void __exit pxafb_exit(void)
> +{
> +	platform_driver_unregister(&pxafb_driver);
> +}
> +
>  module_init(pxafb_init);
> +module_exit(pxafb_exit);
>  
>  MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
>  MODULE_LICENSE("GPL");


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
