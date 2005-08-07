From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mach64 atari patch
Date: Sun, 7 Aug 2005 13:39:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508071316230.31010@gorilla.sonytel.be>
References: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1jaU-0006hV-8c
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 04:45:06 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1jaT-0005OI-Nq
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 04:45:06 -0700
In-Reply-To: <Pine.LNX.4.56.0508070315260.12196@pentafluge.infradead.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Sun, 7 Aug 2005, James Simmons wrote:
> This patch makes the mach64 chip a platform device so sysfs can work with 
> it. 
> 
> Signed-off-by: James Simmons <jsimmons@infradead.org>
> 
> --- linus-2.6/drivers/video/aty/atyfb_base.c	2005-07-11 10:07:21.000000000 -0700
> +++ fbdev-2.6/drivers/video/aty/atyfb_base.c	2005-07-27 08:41:24.000000000 -0700
> @@ -321,10 +318,8 @@
>  #endif
>  
>  #ifdef CONFIG_ATARI
> -static unsigned int mach64_count __initdata = 0;
> -static unsigned long phys_vmembase[FB_MAX] __initdata = { 0, };
> -static unsigned long phys_size[FB_MAX] __initdata = { 0, };
> -static unsigned long phys_guiregbase[FB_MAX] __initdata = { 0, };
> +static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num)

Missing semicolumn at end of line.

> @@ -2587,10 +2578,13 @@
>  }
>  
>  #ifdef CONFIG_ATARI
> -static int __init store_video_par(char *video_str, unsigned char m64_num)
> +static struct mach64_device* __init store_video_par(char *video_str, unsigned char m64_num)
>  {
> -	char *p;
>  	unsigned long vmembase, size, guiregbase;
> +	struct platform_device *atyfb_device;
> +	struct mach64_device *device;
> +	struct resource io[2];
> +	char *p;
>  
>  	PRINTKI("store_video_par() '%s' \n", video_str);
>  
> @@ -2604,16 +2598,18 @@
>  		goto mach64_invalid;
>  	guiregbase = simple_strtoul(p, NULL, 0);
>  
> -	phys_vmembase[m64_num] = vmembase;
> -	phys_size[m64_num] = size;
> -	phys_guiregbase[m64_num] = guiregbase;
> -	PRINTKI("stored them all: $%08lX $%08lX $%08lX \n", vmembase, size,
> -	       guiregbase);
> -	return 0;
> +	io[0] = request_mem_region(vmembase, size, "atyfb");
> +	io[1] = request_mem_region(guiregbase, 0x10000, "atyfb");

1. request_mem_region(0 returns a pointer to a struct resource, not a struct
   resource.
2. What if request_mem_region() fails and returns NULL?

> -      mach64_invalid:
> -	phys_vmembase[m64_num] = 0;
> -	return -1;
> +	atyfb_device = platform_device_register_simple("atyfb", m64_num, io, 2);
> +	if (IS_ERR(atyfb_device))
> +		return PTR_ERR(atyfb_device);
                       ^^^^^^^
PTR_ERR() returns a long, but we should return a struct mach64_device *.

> @@ -2679,17 +2675,10 @@
>  static void aty_st_pal(u_int regno, u_int red, u_int green, u_int blue,
>  		       const struct atyfb_par *par)
>  {
> -#ifdef CONFIG_ATARI
> -	out_8(&par->aty_cmap_regs->windex, regno);
> -	out_8(&par->aty_cmap_regs->lut, red);
> -	out_8(&par->aty_cmap_regs->lut, green);
> -	out_8(&par->aty_cmap_regs->lut, blue);
> -#else
>  	writeb(regno, &par->aty_cmap_regs->windex);
>  	writeb(red, &par->aty_cmap_regs->lut);
>  	writeb(green, &par->aty_cmap_regs->lut);
>  	writeb(blue, &par->aty_cmap_regs->lut);
> -#endif

Why? writeb() does not exist, because there's no PCI bus.

>  }
>  
>      /*
> @@ -3456,47 +3445,43 @@
>  
>  #ifdef CONFIG_ATARI
>  
> -static int __devinit atyfb_atari_probe(void)
> +static int __devinit atyfb_atari_probe(struct device *device)
>  {
> -	struct aty_par *par;
> +	struct platform_device *dev = to_platform_device(device);
>  	struct fb_info *info;
> -	int m64_num;
> +	struct aty_par *par;
> +	int size = 0;
>  	u32 clock_r;
>  
> -	for (m64_num = 0; m64_num < mach64_count; m64_num++) {
> -		if (!phys_vmembase[m64_num] || !phys_size[m64_num] ||
> -		    !phys_guiregbase[m64_num]) {

The for-loop was removed....

> -		    PRINTKI("phys_*[%d] parameters not set => returning early. \n", m64_num);
> -			continue;
> -		}
> -
> -		info = framebuffer_alloc(sizeof(struct atyfb_par), NULL);
> -		if (!info) {
> -			PRINTKE("atyfb_atari_probe() can't alloc fb_info\n");
> -			return -ENOMEM;
> -		}
> -		par = info->par;
> +	info = framebuffer_alloc(sizeof(struct atyfb_par), &dev->dev);
> +	if (!info) {
> +		PRINTKE("atyfb_atari_probe() can't alloc fb_info\n");
> +		return -ENOMEM;
> +	}
> +	par = info->par;
>  
> -		info->fix = atyfb_fix;
> +	info->fix = atyfb_fix;
>  
> -		par->irq = (unsigned int) -1; /* something invalid */
> +	par->irq = (unsigned int) -1; /* something invalid */
>  
> -		/*
> -		 *  Map the video memory (physical address given) to somewhere in the
> -		 *  kernel address space.
> -		 */
> -		info->screen_base = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
> -		info->fix.smem_start = (unsigned long)info->screen_base; /* Fake! */
> -		par->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000) +
> -						0xFC00ul;
> -		info->fix.mmio_start = (unsigned long)par->ati_regbase; /* Fake! */
> -
> -		aty_st_le32(CLOCK_CNTL, 0x12345678, par);
> -		clock_r = aty_ld_le32(CLOCK_CNTL, par);
> -
> -		switch (clock_r & 0x003F) {
> -		case 0x12:
> -			par->clk_wr_offset = 3; /*  */
> +	/*
> +	 *  Map the video memory (physical address given) to somewhere in the
> +	 *  kernel address space.
> +	 */
> +	size = dev->resource[0].start - dev->resource[0].end;
	       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	       dev->resource[0].start - dev->resource[0].end + 1;

> +	info->fix.smem_start = dev->resource[0].start;
> +	info->screen_base = ioremap(dev->resource[0], size);
                                    ^^^^^^^^^^^^^^^^
				    dev->resource[0].start

> +
> +	size = 0x10000;
> +	info->fix.mmio_start = dev->resource[1].start + 0xFC00ul;
> +	par->ati_regbase = ioremap(dev->resource[1], size) + 0xFC00ul;
                                   ^^^^^^^^^^^^^^^^
				   dev->resource[1].start

> +
> +	aty_st_le32(CLOCK_CNTL, 0x12345678, par);
> +	clock_r = aty_ld_le32(CLOCK_CNTL, par);
> +
> +	switch (clock_r & 0x003F) {
> +	case 0x12:
> +		par->clk_wr_offset = 3; /*  */
>  			break;
>  		case 0x34:
>  			par->clk_wr_offset = 2; /* Medusa ST-IO ISA Adapter etc. */

... but the closing brace for the for-loop is still there.

> @@ -3595,6 +3580,23 @@
>  
>  #endif /* CONFIG_PCI */
>  
> +#ifdef	CONFIG_ATARI
> +
> +static struct device_driver atyfb_driver = {
> +	.name		= "atyfb",
> +	.probe		= atyfb_atari_probe,
> +	.remove		= __devexit_p(atyfb_atari_remove),

Initialization from incompatible pointer type,
and atyfb_atari_remove is used before its definition, ...

> +}

Missing semicolumn

> +
> +static void __devexit atyfb_atari_remove(struct device *dev)
> +{
> +	struct fb_info *info = dev_get_drvdata(dev);
> +
> +	atyfb_remove(info);
> +}

... so you better move this one up.

> @@ -3650,15 +3652,15 @@
>  		 * Why do we need this silly Mach64 argument?
>  		 * We are already here because of mach64= so its redundant.
>  		 */
> -		else if (MACH_IS_ATARI
> -			 && (!strncmp(this_opt, "Mach64:", 7))) {
> -			static unsigned char m64_num;
> -			static char mach64_str[80];
> +		else if (MACH_IS_ATARI && (!strncmp(this_opt, "Mach64:", 7))) {
> +			struct mach64_device *dev;
> +			unsigned char m64_num = 0;
> +			char mach64_str[80];
> +
>  			strlcpy(mach64_str, this_opt + 7, sizeof(mach64_str));
> -			if (!store_video_par(mach64_str, m64_num)) {
> -				m64_num++;
> -				mach64_count = m64_num;
> -			}
> +			dev = store_video_par(mach64_str, m64_num++); 
> +			if (dev != null)
                                   ^^^^
				   NULL

> +				list_add_tail(dev->node, &mach64_list);

incompatible type for argument 1 of `list_add_tail'

> @@ -3679,16 +3683,34 @@
>  #endif
>  
>  #ifdef CONFIG_PCI
> -    pci_register_driver(&atyfb_driver);
> +    retval = pci_register_driver(&atyfb_driver);
>  #endif
>  #ifdef CONFIG_ATARI
> -    atyfb_atari_probe();
> +    retval = driver_register(&atyfb_driver);
> +    if (retval < 0) {
> +	struct platform_device *device;
> +
> +	list_for_each_safe(device, &mach64_list, node) {

`node' undeclared

> +		platform_device_unregister(&device->dev);
                                           ^^^^^^^^^^^^
					   device ??

> +		kfree(device);
> +	}
> +    }
>  #endif
> -    return 0;
> +    return retval;
>  }
>  
>  static void __exit atyfb_exit(void)
>  {
> +#ifdef CONFIG_ATARI
> +	struct platform_device *device;
> +
> +	list_for_each_safe(device, &mach64_list, node) {

`node' undeclared

> +		platform_device_unregister(&device->dev);
> +		kfree(device);
> +	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
