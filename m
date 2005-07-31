From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [patch 6/8] w100fb: Rewrite for platform
 independence
Date: Sun, 31 Jul 2005 13:35:34 +0800
Message-ID: <42EC6326.7020508@gmail.com>
References: <1122630420.7747.96.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dz6Ty-0000g4-4P
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 22:35:30 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dz6Tx-00083Z-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 30 Jul 2005 22:35:30 -0700
Received: by wproxy.gmail.com with SMTP id i20so802571wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 30 Jul 2005 22:35:23 -0700 (PDT)
In-Reply-To: <1122630420.7747.96.camel@localhost.localdomain>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@osdl.org, adaplas@pol.net

Richard Purdie wrote:
> The code w100fb was based on was horribly Sharp SL-C7x0 specific
> and there was little else that could be done as I had no access to
> anything else with a w100 in it. There is no real documentation 
> about this chipset available.
> 
> Ian Molton has access to other platforms with the w100 (Toshiba
> e-series) and so between us, we've improved w100fb and made it 
> platform independent. Ian Molton also added support for the 
> very similar w3220 and w3200 chipsets.
> 
> There are a lot of changes here and it nearly amounts to a rewrite 
> of the driver but it has been extensively tested and is being used 
> in preference to the original driver in the Zaurus community. I'd
> therefore like to update the mainline code to reflect this. 

> > +	flip = simple_strtoul(buf, NULL, 10);
> +
> +	if (flip > 0) par->flip = 1;

	if (flip > 0)
		par->flip = 0;
		
and more follows...


> +static void w100fb_clear_screen(struct w100fb_par *par)
> +{
> +	memset(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), 0, (par->xres * par->yres * BITS_PER_PIXEL/8));

memset_io?

>  }
> -EXPORT_SYMBOL(w100fb_get_xres);
> -EXPORT_SYMBOL(w100fb_get_blanking);
> -EXPORT_SYMBOL(w100fb_get_fastsysclk);
>  
>  
>  /*
> @@ -235,7 +204,7 @@
>  	 */
>  	if (regno < MAX_PALETTES) {
>  
> -		u32 *pal = info->pseudo_palette;
> +		uint32_t *pal = info->pseudo_palette;

I prefer that you use u8, u16, and u32 instead of uint*_t.


> +	memsize=MEM_INT_SIZE;
> +	par->saved_intmem = vmalloc(memsize);
> +	if (par->saved_intmem && par->extmem_active)
> +		memcpy(par->saved_intmem, remapped_fbuf + (W100_FB_BASE-MEM_INT_BASE_VALUE), memsize);

memcpy_fromio?

> +	else if (par->saved_intmem)
> +		memcpy(par->saved_intmem, remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), memsize);
>  }
>  

memcpy_fromio?

> -
> -static void w100fb_restore_buffer(void)
> +static void w100fb_restore_vidmem(struct w100fb_par *par)
>  {
> -	int i, j, bufsize;
> +	int memsize;
>  
> -	bufsize=(current_par->xres * current_par->yres * BITS_PER_PIXEL / 8) / W100_BUF_NUM;
> -	for (i = 0; i < W100_BUF_NUM; i++) {
> -		if (gSaveImagePtr[i] == NULL) {
> -			printk(KERN_WARNING "can't find pre-off image buffer %d\n", i);
> -			w100fb_clear_buffer();
> -			break;
> -		}
> -		for (j = 0; j < (bufsize/4); j++)
> -			writel(*(gSaveImagePtr[i] + j),remapped_fbuf + (bufsize*i) + (j*4));
> -		kfree(gSaveImagePtr[i]);
> -		gSaveImagePtr[i] = NULL;
> +	if (par->extmem_active && par->saved_extmem) {
> +		memsize=par->mach->mem->size;
> +		memcpy(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);

memcpy_toio?

> +		vfree(par->saved_extmem);
>  	}
> -}
> -
> -
> -static void w100fb_clear_buffer(void)
> -{
> -	int i;
> -	for (i = 0; i < W100_BUF_NUM; i++) {
> -		kfree(gSaveImagePtr[i]);
> -		gSaveImagePtr[i] = NULL;
> +	if (par->saved_intmem) {
> +		memsize=MEM_INT_SIZE;
> +		if (par->extmem_active)
> +			memcpy(remapped_fbuf + (W100_FB_BASE-MEM_INT_BASE_VALUE), par->saved_intmem, memsize);
> +		else
> +			memcpy(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);

memcpy_toio?

>  
>  int __init w100fb_probe(struct device *dev)
>  {
> +	int err = -EIO;
>  	struct w100fb_mach_info *inf;
> -	struct fb_info *info;
> +	struct fb_info *info = NULL;
>  	struct w100fb_par *par;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	unsigned int chip_id;
>  
>  	if (!mem)
>  		return -EINVAL;
>  
> -	/* remap the areas we're going to use */
> +	/* Remap the chip base address */
>  	remapped_base = ioremap_nocache(mem->start+W100_CFG_BASE, W100_CFG_LEN);
>  	if (remapped_base == NULL)
> -		return -EIO;
> +		goto out;
>  
> +	/* Map the register space */
>  	remapped_regs = ioremap_nocache(mem->start+W100_REG_BASE, W100_REG_LEN);
> -	if (remapped_regs == NULL) {
> -		iounmap(remapped_base);
> -		return -EIO;
> -	}
> +	if (remapped_regs == NULL)
> +		goto out;
>  
> -	remapped_fbuf = ioremap_nocache(mem->start+MEM_EXT_BASE_VALUE, REMAPPED_FB_LEN);
> -	if (remapped_fbuf == NULL) {
> -		iounmap(remapped_base);
> -		iounmap(remapped_regs);
> -		return -EIO;
> -	}
> +	/* Identify the chip */
> +	printk("Found ");
> +	chip_id = readl(remapped_regs + mmCHIP_ID);
> +	switch(chip_id) {
> +		case CHIP_ID_W100:  printk("w100");  break;
> +		case CHIP_ID_W3200: printk("w3200"); break;
> +		case CHIP_ID_W3220: printk("w3220"); break;
> +		default:
> +			printk("Unknown imageon chip ID\n");
> +			err = -ENODEV;
> +			goto out;
> +	}
> +	printk(" at 0x%08lx.\n", mem->start+W100_CFG_BASE);
> +
> +	/* Remap the framebuffer */
> +	remapped_fbuf = ioremap_nocache(mem->start+MEM_WINDOW_BASE, MEM_WINDOW_SIZE);
> +	if (remapped_fbuf == NULL)
> +		goto out;
>  
>  	info=framebuffer_alloc(sizeof(struct w100fb_par), dev);
>  	if (!info) {
> -		iounmap(remapped_base);
> -		iounmap(remapped_regs);
> -		iounmap(remapped_fbuf);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto out;
>  	}
>  
>  	info->device=dev;

No need to set info->device, this was done already by framebuffer_alloc.


>  	info->var.xres_virtual = info->var.xres;
> -	info->var.yres = 480;
>  	info->var.yres_virtual = info->var.yres;
> -	info->var.pixclock = 0x04;	/* 171521; */
> +	info->var.pixclock = 0x04;  /* 171521; */
>  	info->var.sync = 0;
>  	info->var.grayscale = 0;
>  	info->var.xoffset = info->var.yoffset = 0;
>  	info->var.accel_flags = 0;
>  	info->var.activate = FB_ACTIVATE_NOW;
>  
> -	strcpy(info->fix.id, "w100fb");
> -	info->fix.type = FB_TYPE_PACKED_PIXELS;
> -	info->fix.type_aux = 0;
> -	info->fix.accel = FB_ACCEL_NONE;
> -	info->fix.smem_start = mem->start+MEM_EXT_BASE_VALUE;
> -	info->fix.mmio_start = mem->start+W100_REG_BASE;
> -	info->fix.mmio_len = W100_REG_LEN;

I'm surprised that info->cmap was not initialized, and
your driver keeps on working.  It was required before to
call fb_alloc_cmap() before register framebuffer.

Tony


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
