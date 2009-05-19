From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/3] viafb: Fix various resource
 leaks during module_init()
Date: Tue, 19 May 2009 10:00:43 +0200
Message-ID: <20090519100043.4785c0c0.krzysztof.h1@poczta.fm>
References: <20090519035105.GX19746@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6K9r-0003Nu-5z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 07:54:43 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6K9m-0002TB-DE for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 07:54:43 +0000
In-Reply-To: <20090519035105.GX19746@prithivi.gnumonks.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: JosephChan@via.com.tw, ScottFang@viatech.com.cn, linux-fbdev-devel@lists.sourceforge.net

Hi Harald,

On Tue, 19 May 2009 11:51:05 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> The current code executed from module_init() in viafb does not have
> proper error checking and [partial] resoure release paths in case
> an error happens half way through driver initialization.
> 
> This patch adresses the most obvious of those issues, such as a
> leftover i2c bus if module_init (and thus module load) fails.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---
>  drivers/video/via/viafbdev.c |   51 +++++++++++++++++++++++++++++++----------
>  1 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index a0fec29..61dcb13 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright 1998-2008 VIA Technologies, Inc. All Rights Reserved.
> + * Copyright 1998-2009 VIA Technologies, Inc. All Rights Reserved.
>   * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
>  
>   * This program is free software; you can redistribute it and/or
> @@ -2106,7 +2106,7 @@ static int __devinit via_pci_probe(void)
>  	unsigned long default_xres, default_yres;
>  	char *tmpc, *tmpm;
>  	char *tmpc_sec, *tmpm_sec;
> -	int vmode_index;
> +	int rc, vmode_index;
>  	u32 tmds_length, lvds_length, crt_length, chip_length, viafb_par_length;
>  
>  	DEBUG_MSG(KERN_INFO "VIAFB PCI Probe!!\n");
> @@ -2127,7 +2127,7 @@ static int __devinit via_pci_probe(void)
>  	tmds_length + crt_length + chip_length, NULL);
>  	if (!viafbinfo) {
>  		printk(KERN_ERR"Could not allocate memory for viafb_info.\n");
> -		return -ENODEV;
> +		return -ENOMEM;
>  	}
>  
>  	viaparinfo = (struct viafb_par *)viafbinfo->par;
> @@ -2154,7 +2154,9 @@ static int __devinit via_pci_probe(void)
>  		viafb_dual_fb = 0;
>  
>  	/* Set up I2C bus stuff */
> -	viafb_create_i2c_bus(viaparinfo);
> +	rc = viafb_create_i2c_bus(viaparinfo);
> +	if (rc)
> +		goto out_fb_release;
>  
>  	viafb_init_chip_info();
>  	viafb_get_fb_info(&viaparinfo->fbmem, &viaparinfo->memsize);
> @@ -2166,7 +2168,8 @@ static int __devinit via_pci_probe(void)
>  
>  	if (!viaparinfo->fbmem_virt) {

I strongly recommend not to duplicate standard fields: fb_info.fix.smem_base and 
fb_info.fix.smem_len  (and fb_info.screen_base and fb_info.screen_size).

I would like to see conversion:
viainfo->fbmem => viaifbnfo->screen_base (physical address)
? => viafbinfo->screen_size (physical size)
viaparinfo->fbmem_virt => viafbinfo->fix.smem_start (virtual address)
viaparinfo->memsize => viafbinfo->fix.smem_len (virtual size)

You may try dropping the global viaparinfo pointer as well (and just get it
as viafbinfo->par if needed).

These changes should be sent as a separate patch.

>  		printk(KERN_INFO "ioremap failed\n");
> -		return -1;
> +		rc = -EIO;
> +		goto out_delete_i2c;
>  	}
>  
>  	viafb_get_mmio_info(&viaparinfo->mmio_base, &viaparinfo->mmio_len);
> @@ -2279,7 +2282,7 @@ static int __devinit via_pci_probe(void)
>  			printk(KERN_ERR
>  			"allocate the second framebuffer struct error\n");
>  			framebuffer_release(viafbinfo);
> -			return -ENOMEM;
> +			goto out_delete_i2c;
>  		}

The framebuffer_release(viafbinfo) will be called twice now.

>  		viaparinfo1 = viafbinfo1->par;
>  		memcpy(viaparinfo1, viaparinfo, viafb_par_length);
> @@ -2340,21 +2343,26 @@ static int __devinit via_pci_probe(void)
>  	viafb_update_viafb_par(viafbinfo);
>  	viafb_update_fix(&viafbinfo->fix, viafbinfo);
>  	default_var.activate = FB_ACTIVATE_NOW;
> -	fb_alloc_cmap(&viafbinfo->cmap, 256, 0);
> +	rc = fb_alloc_cmap(&viafbinfo->cmap, 256, 0);
> +	if (rc)
> +		goto out_fb1_release;
>  
>  	if (viafb_dual_fb && (viafb_primary_dev == LCD_Device)
>  	    && (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266)) {
> -		if (register_framebuffer(viafbinfo1) < 0)
> -			return -EINVAL;
> +		rc = register_framebuffer(viafbinfo1);
> +		if (rc)
> +			goto out_dealloc_cmap;
>  	}
> -	if (register_framebuffer(viafbinfo) < 0)
> -		return -EINVAL;
> +	rc = register_framebuffer(viafbinfo);
> +	if (rc)
> +		goto out_fb1_unreg_lcd_cle266;
>  
>  	if (viafb_dual_fb && ((viafb_primary_dev != LCD_Device)
>  			|| (viaparinfo->chip_info->gfx_chip_name !=
>  			UNICHROME_CLE266))) {
> -		if (register_framebuffer(viafbinfo1) < 0)
> -			return -EINVAL;
> +		rc = register_framebuffer(viafbinfo1);
> +		if (rc)
> +			goto out_fb_unreg;
>  	}
>  	DEBUG_MSG(KERN_INFO "fb%d: %s frame buffer device %dx%d-%dbpp\n",
>  		  viafbinfo->node, viafbinfo->fix.id, default_var.xres,
> @@ -2363,6 +2371,23 @@ static int __devinit via_pci_probe(void)
>  	viafb_init_proc(&viaparinfo->proc_entry);
>  	viafb_init_dac(IGA2);
>  	return 0;
> +
> +out_fb_unreg:
> +	unregister_framebuffer(viafbinfo);
> +out_fb1_unreg_lcd_cle266:
> +	if (viafbinfo1 && (viafb_primary_dev == LCD_Device)
> +            && (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266))
> +		unregister_framebuffer(viafbinfo1);

The condition here differs from the condition used during viafbinfo1 register
(viafb_dual_fb vs. viafbinfo1).

> +out_dealloc_cmap:
> +	fb_dealloc_cmap(&viafbinfo->cmap);
> +out_fb1_release:
> +	if (viafbinfo1)
> +		framebuffer_release(viafbinfo1);
> +out_delete_i2c:
> +	viafb_delete_i2c_buss(viaparinfo);
> +out_fb_release:
> +	framebuffer_release(viafbinfo);
> +	return rc;
>  }
>  
>  static void __devexit via_pci_remove(void)
> -- 
> 1.6.2.4
> 

Kind regards,
Krzysztof

----------------------------------------------------------------------
Fantastyczne nagrody do zgarniecia!
Zagraj >> http://link.interia.pl/f2177 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
