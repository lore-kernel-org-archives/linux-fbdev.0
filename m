From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] viafb: make viafb a first-class
 citizen using pci_driver
Date: Tue, 19 May 2009 23:16:28 +0200
Message-ID: <20090519231628.e4e149be.krzysztof.h1@poczta.fm>
References: <20090519083418.GH19746@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M6Wa5-0001G1-28
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 21:10:37 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M6WZv-0003N6-LA for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 May 2009 21:10:32 +0000
In-Reply-To: <20090519083418.GH19746@prithivi.gnumonks.org>
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

On Tue, 19 May 2009 16:34:18 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> This patch modifies the viafb driver to use the normal 'struct pci_driver'
> method for registering a PCI driver with the Linux kernel.
> 
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

One comment below.

>  drivers/video/via/hw.c       |  116 +++--------------------------------------
>  drivers/video/via/hw.h       |    7 +--
>  drivers/video/via/viafbdev.c |   65 ++++++++++++++++++++---
>  3 files changed, 68 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index b111b6c..6306c88 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -21,22 +21,6 @@
>  
>  #include "global.h"
>  
> -static const struct pci_device_id_info pciidlist[] = {
> -	{PCI_VIA_VENDOR_ID, UNICHROME_CLE266_DID, UNICHROME_CLE266},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_PM800_DID, UNICHROME_PM800},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_K400_DID, UNICHROME_K400},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_K800_DID, UNICHROME_K800},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_CN700_DID, UNICHROME_CN700},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_P4M890_DID, UNICHROME_P4M890},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_K8M890_DID, UNICHROME_K8M890},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_CX700_DID, UNICHROME_CX700},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_P4M900_DID, UNICHROME_P4M900},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_CN750_DID, UNICHROME_CN750},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_VX800_DID, UNICHROME_VX800},
> -	{PCI_VIA_VENDOR_ID, UNICHROME_VX855_DID, UNICHROME_VX855},
> -	{0, 0, 0}
> -};
> -
>  struct offset offset_reg = {
>  	/* IGA1 Offset Register */
>  	{IGA1_OFFSET_REG_NUM, {{CR13, 0, 7}, {CR35, 5, 7} } },
> @@ -549,7 +533,8 @@ static void set_dvi_output_path(int set_iga, int output_interface);
>  static void set_lcd_output_path(int set_iga, int output_interface);
>  static int search_mode_setting(int ModeInfoIndex);
>  static void load_fix_bit_crtc_reg(void);
> -static void init_gfx_chip_info(void);
> +static void init_gfx_chip_info(struct pci_dev *pdev,
> +				const struct pci_device_id *pdi);
>  static void init_tmds_chip_info(void);
>  static void init_lvds_chip_info(void);
>  static void device_screen_off(void);
> @@ -559,7 +544,6 @@ static void device_off(void);
>  static void device_on(void);
>  static void enable_second_display_channel(void);
>  static void disable_second_display_channel(void);
> -static int get_fb_size_from_pci(void);
>  
>  void viafb_write_reg(u8 index, u16 io_port, u8 data)
>  {
> @@ -1996,9 +1980,10 @@ void viafb_fill_crtc_timing(struct crt_mode_table *crt_table,
>  
>  }
>  
> -void viafb_init_chip_info(void)
> +void viafb_init_chip_info(struct pci_dev *pdev,
> +			  const struct pci_device_id *pdi)
>  {
> -	init_gfx_chip_info();
> +	init_gfx_chip_info(pdev, pdi);
>  	init_tmds_chip_info();
>  	init_lvds_chip_info();
>  
> @@ -2071,24 +2056,12 @@ void viafb_update_device_setting(int hres, int vres,
>  	}
>  }
>  
> -static void init_gfx_chip_info(void)
> +static void init_gfx_chip_info(struct pci_dev *pdev,
> +			       const struct pci_device_id *pdi)
>  {
> -	struct pci_dev *pdev = NULL;
> -	u32 i;
>  	u8 tmp;
>  
> -	/* Indentify GFX Chip Name */
> -	for (i = 0; pciidlist[i].vendor != 0; i++) {
> -		pdev = pci_get_device(pciidlist[i].vendor,
> -			pciidlist[i].device, 0);
> -		if (pdev)
> -			break;
> -	}
> -
> -	if (!pciidlist[i].vendor)
> -		return ;
> -
> -	viaparinfo->chip_info->gfx_chip_name = pciidlist[i].chip_index;
> +	viaparinfo->chip_info->gfx_chip_name = pdi->driver_data;
>  
>  	/* Check revision of CLE266 Chip */
>  	if (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266) {
> @@ -2119,8 +2092,6 @@ static void init_gfx_chip_info(void)
>  				CX700_REVISION_700;
>  		}
>  	}
> -
> -	pci_dev_put(pdev);
>  }
>  
>  static void init_tmds_chip_info(void)
> @@ -2612,38 +2583,6 @@ void viafb_crt_enable(void)
>  	viafb_write_reg_mask(CR36, VIACR, 0x0, BIT5 + BIT4);
>  }
>  
> -void viafb_get_mmio_info(unsigned long *mmio_base,
> -	unsigned long *mmio_len)
> -{
> -	struct pci_dev *pdev = NULL;
> -	u32 vendor, device;
> -	u32 i;
> -
> -	for (i = 0; pciidlist[i].vendor != 0; i++)
> -		if (viaparinfo->chip_info->gfx_chip_name ==
> -			pciidlist[i].chip_index)
> -			break;
> -
> -	if (!pciidlist[i].vendor)
> -		return ;
> -
> -	vendor = pciidlist[i].vendor;
> -	device = pciidlist[i].device;
> -
> -	pdev = pci_get_device(vendor, device, NULL);
> -
> -	if (!pdev) {
> -		*mmio_base = 0;
> -		*mmio_len = 0;
> -		return ;
> -	}
> -
> -	*mmio_base = pci_resource_start(pdev, 1);
> -	*mmio_len = pci_resource_len(pdev, 1);
> -
> -	pci_dev_put(pdev);
> -}
> -
>  static void enable_second_display_channel(void)
>  {
>  	/* to enable second display channel. */
> @@ -2660,44 +2599,7 @@ static void disable_second_display_channel(void)
>  	viafb_write_reg_mask(CR6A, VIACR, BIT6, BIT6);
>  }
>  
> -void viafb_get_fb_info(unsigned int *fb_base, unsigned int *fb_len)
> -{
> -	struct pci_dev *pdev = NULL;
> -	u32 vendor, device;
> -	u32 i;
> -
> -	for (i = 0; pciidlist[i].vendor != 0; i++)
> -		if (viaparinfo->chip_info->gfx_chip_name ==
> -			pciidlist[i].chip_index)
> -			break;
> -
> -	if (!pciidlist[i].vendor)
> -		return ;
> -
> -	vendor = pciidlist[i].vendor;
> -	device = pciidlist[i].device;
> -
> -	pdev = pci_get_device(vendor, device, NULL);
> -
> -	if (!pdev) {
> -		*fb_base = viafb_read_reg(VIASR, SR30) << 24;
> -		*fb_len = viafb_get_memsize();
> -		DEBUG_MSG(KERN_INFO "Get FB info from SR30!\n");
> -		DEBUG_MSG(KERN_INFO "fb_base = %08x\n", *fb_base);
> -		DEBUG_MSG(KERN_INFO "fb_len = %08x\n", *fb_len);
> -		return ;
> -	}
> -
> -	*fb_base = (unsigned int)pci_resource_start(pdev, 0);
> -	*fb_len = get_fb_size_from_pci();
> -	DEBUG_MSG(KERN_INFO "Get FB info from PCI system!\n");
> -	DEBUG_MSG(KERN_INFO "fb_base = %08x\n", *fb_base);
> -	DEBUG_MSG(KERN_INFO "fb_len = %08x\n", *fb_len);
> -
> -	pci_dev_put(pdev);
> -}
> -
> -static int get_fb_size_from_pci(void)
> +int viafb_get_fb_size_from_pci(void)
>  {
>  	unsigned long configid, deviceid, FBSize = 0;
>  	int VideoMemSize;
> diff --git a/drivers/video/via/hw.h b/drivers/video/via/hw.h
> index 22786a5..1cd0648 100644
> --- a/drivers/video/via/hw.h
> +++ b/drivers/video/via/hw.h
> @@ -931,17 +931,16 @@ void viafb_set_dpa_gfx(int output_interface, struct GFX_DPA_SETTING\
>  int viafb_setmode(int vmode_index, int hor_res, int ver_res,
>  	    int video_bpp, int vmode_index1, int hor_res1,
>  	    int ver_res1, int video_bpp1);
> -void viafb_init_chip_info(void);
> +void viafb_init_chip_info(struct pci_dev *pdev,
> +			  const struct pci_device_id *pdi);
>  void viafb_init_dac(int set_iga);
>  int viafb_get_pixclock(int hres, int vres, int vmode_refresh);
>  int viafb_get_refresh(int hres, int vres, u32 float_refresh);
>  void viafb_update_device_setting(int hres, int vres, int bpp,
>  			   int vmode_refresh, int flag);
> -void viafb_get_mmio_info(unsigned long *mmio_base,
> -	unsigned long *mmio_len);
>  
> +int viafb_get_fb_size_from_pci(void);
>  void viafb_set_iga_path(void);
>  void viafb_set_start_addr(void);
> -void viafb_get_fb_info(unsigned int *fb_base, unsigned int *fb_len);
>  
>  #endif /* __HW_H__ */
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 055d67d..32c26cc 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -2104,7 +2104,8 @@ static void viafb_remove_proc(struct proc_dir_entry *viafb_entry)
>  	remove_proc_entry("viafb", NULL);
>  }
>  
> -static int __devinit via_pci_probe(void)
> +static int __devinit via_pci_probe(struct pci_dev *pdev,
> +				   const struct pci_device_id *ent)
>  {
>  	unsigned long default_xres, default_yres;
>  	char *tmpc, *tmpm;
> @@ -2128,7 +2128,8 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  	 * variables
>  	*/
>  	viafbinfo = framebuffer_alloc(viafb_par_length + 2 * lvds_length +
> -	tmds_length + crt_length + chip_length, NULL);
> +				      tmds_length + crt_length + chip_length,
> +				      &pdev->dev);
>  	if (!viafbinfo) {
>  		printk(KERN_ERR"Could not allocate memory for viafb_info.\n");
>  		return -ENOMEM;
> @@ -2161,8 +2162,9 @@ static int __devinit via_pci_probe(void)
>  	if (rc)
>  		goto out_fb_release;
>  
> -	viafb_init_chip_info();
> -	viafb_get_fb_info(&viaparinfo->fbmem, &viaparinfo->memsize);
> +	viafb_init_chip_info(pdev, ent);
> +	viaparinfo->fbmem = pci_resource_start(pdev, 0);
> +	viaparinfo->memsize = viafb_get_fb_size_from_pci();
>  	viaparinfo->fbmem_free = viaparinfo->memsize;
>  	viaparinfo->fbmem_used = 0;
>  	viaparinfo->fbmem_virt = ioremap_nocache(viaparinfo->fbmem,
> @@ -2170,14 +2172,20 @@ static int __devinit via_pci_probe(void)
>  	viafbinfo->screen_base = (char *)viaparinfo->fbmem_virt;
>  
>  	if (!viaparinfo->fbmem_virt) {
> -		printk(KERN_INFO "ioremap failed\n");
> +		printk(KERN_ERR "ioremap of fbmem failed\n");
>  		rc = -EIO;
>  		goto out_delete_i2c;
>  	}
>  
> -	viafb_get_mmio_info(&viaparinfo->mmio_base, &viaparinfo->mmio_len);
> +	viaparinfo->mmio_base = pci_resource_start(pdev, 1);
> +	viaparinfo->mmio_len = pci_resource_len(pdev, 1);

Again, there are standard fields which have the same meaning:
viafbinfo->mmio_start and viafbinfo->mmio_len.

>  	viaparinfo->io_virt = ioremap_nocache(viaparinfo->mmio_base,
>  		viaparinfo->mmio_len);
> +	if (!viaparinfo->io_virt) {
> +		printk(KERN_ERR "ioremap of MMIO failed\n");
> +		rc = -EIO;
> +		goto out_unmap_fbmem;
> +	}
>  
>  	viafbinfo->node = 0;
>  	viafbinfo->fbops = &viafb_ops;
> @@ -2285,7 +2293,8 @@ static int __devinit via_pci_probe(void)
>  			printk(KERN_ERR
>  			"allocate the second framebuffer struct error\n");
>  			framebuffer_release(viafbinfo);
> -			goto out_delete_i2c;
> +			rc = -ENOMEM;
> +			goto out_unmap_mmio;
>  		}
>  		viaparinfo1 = viafbinfo1->par;
>  		memcpy(viaparinfo1, viaparinfo, viafb_par_length);
> @@ -2386,6 +2395,10 @@ out_dealloc_cmap:
>  out_fb1_release:
>  	if (viafbinfo1)
>  		framebuffer_release(viafbinfo1);
> +out_unmap_mmio:
> +	iounmap(viaparinfo->io_virt);
> +out_unmap_fbmem:
> +	iounmap((void *)viaparinfo->fbmem_virt);
>  out_delete_i2c:
>  	viafb_delete_i2c_buss(viaparinfo);
>  out_fb_release:
> @@ -2393,7 +2406,7 @@ out_fb_release:
>  	return rc;
>  }
>  
> -static void __devexit via_pci_remove(void)
> +static void __devexit via_pci_remove(struct pci_dev *pdev)
>  {
>  	DEBUG_MSG(KERN_INFO "via_pci_remove!\n");
>  	fb_dealloc_cmap(&viafbinfo->cmap);
> @@ -2487,6 +2500,40 @@ static int __init viafb_setup(char *options)
>  }
>  #endif
>  
> +static struct pci_device_id viafb_pci_table[] __devinitdata = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CLE266_DID),
> +	  .driver_data = UNICHROME_CLE266 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_PM800_DID),
> +	  .driver_data = UNICHROME_PM800 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K400_DID),
> +	  .driver_data = UNICHROME_K400 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K800_DID),
> +	  .driver_data = UNICHROME_K800 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_P4M890_DID),
> +	  .driver_data = UNICHROME_CN700 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_K8M890_DID),
> +	  .driver_data = UNICHROME_K8M890 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CX700_DID),
> +	  .driver_data = UNICHROME_CX700 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_P4M900_DID),
> +	  .driver_data = UNICHROME_P4M900 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_CN750_DID),
> +	  .driver_data = UNICHROME_CN750 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_VX800_DID),
> +	  .driver_data = UNICHROME_VX800 },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, UNICHROME_VX855_DID),
> +	  .driver_data = UNICHROME_VX855 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, viafb_pci_table);
> +
> +static struct pci_driver viafb_driver = {
> +	.name		= "viafb",
> +	.id_table	= viafb_pci_table,
> +	.probe		= via_pci_probe,
> +	.remove		= __devexit_p(via_pci_remove),
> +};
> +
>  static int __init viafb_init(void)
>  {
>  #ifndef MODULE
> @@ -2498,13 +2545,13 @@ static int __init viafb_init(void)
>  	printk(KERN_INFO
>         "VIA Graphics Intergration Chipset framebuffer %d.%d initializing\n",
>  	       VERSION_MAJOR, VERSION_MINOR);
> -	return via_pci_probe();
> +	return pci_register_driver(&viafb_driver);
>  }
>  
>  static void __exit viafb_exit(void)
>  {
>  	DEBUG_MSG(KERN_INFO "viafb_exit!\n");
> -	via_pci_remove();
> +	pci_unregister_driver(&viafb_driver);
>  }
>  
>  static struct fb_ops viafb_ops = {
> 
> -- 
> 1.6.2.4
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

----------------------------------------------------------------------
Zrob sobie prezent. Wygraj nagrode!
Sprawdz >>  http://link.interia.pl/f2176 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
