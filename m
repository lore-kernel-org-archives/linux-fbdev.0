From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 08/15] viafb: get rid of some
 duplicated fields in private structure
Date: Sat, 23 May 2009 08:34:04 +0200
Message-ID: <20090523083404.5b3d853e.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7ki2-0004VY-Et
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:27:54 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7khs-0000Ja-9o for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:27:54 +0000
In-Reply-To: <1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 May 2009 04:28:46 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> Instead of using private structure members, we use the standard ones:
>  * viapar->fbmem converted to fb_info->fix.smem_start
>  * viapar->memsize is converted to fb_info->fix.smem_len
>  * viapar->fbmem_virt is convereted to fb_info->screen_base
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---
>  drivers/video/via/global.c   |    1 -
>  drivers/video/via/hw.c       |    2 +-
>  drivers/video/via/viafbdev.c |   47 +++++++++++++++++++----------------------
>  drivers/video/via/viafbdev.h |    3 --
>  4 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/video/via/global.c b/drivers/video/via/global.c
> index 468be24..2b7d0d3 100644
> --- a/drivers/video/via/global.c
> +++ b/drivers/video/via/global.c
> @@ -57,4 +57,3 @@ struct fb_info *viafbinfo;
>  struct fb_info *viafbinfo1;
>  struct viafb_par *viaparinfo;
>  struct viafb_par *viaparinfo1;
> -
> diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
> index 40b7c0c..e06d6b7 100644
> --- a/drivers/video/via/hw.c
> +++ b/drivers/video/via/hw.c
> @@ -680,7 +680,7 @@ void viafb_set_start_addr(void)
>  				size = 8 * 1024 * 1024;
>  		} else {
>  
> -			size = viaparinfo1->memsize;
> +			size = viafbinfo1->fix.smem_len;
>  		}
>  		offset = viafb_second_offset;
>  		DEBUG_MSG(KERN_INFO
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 7e8f2f6..c420623 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -119,10 +119,8 @@ static int viafb_update_fix(struct fb_fix_screeninfo *fix, struct fb_info *info)
>  static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
>  	struct viafb_par *viaparinfo)
>  {
> -	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
>  	strcpy(fix->id, viafb_name);
>  
> -	fix->smem_start = viaparinfo->fbmem;
>  	fix->smem_len = viaparinfo->fbmem_free;
>  	fix->mmio_start = viaparinfo->mmio_base;
>  	fix->mmio_len = viaparinfo->mmio_len;
> @@ -196,7 +194,7 @@ static int viafb_check_var(struct fb_var_screeninfo *var,
>  		/*32 pixel alignment */
>  		var->xres_virtual = (var->xres_virtual + 31) & ~31;
>  	if (var->xres_virtual * var->yres_virtual * var->bits_per_pixel / 8 >
> -		ppar->memsize)
> +		info->fix.smem_len)
>  		return -EINVAL;
>  
>  	/* Based on var passed in to calculate the refresh,
> @@ -630,13 +628,13 @@ static int viafb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
>  					    (viaparinfo->fbmem_free >> 1);
>  				}
>  			}
> -			u.viasamm.mem_base = viaparinfo->fbmem;
> +			u.viasamm.mem_base = viafbinfo->fix.smem_start;
>  			u.viasamm.offset_sec = viafb_second_offset;
>  		} else {
>  			u.viasamm.size_prim =
> -			    viaparinfo->memsize - viaparinfo->fbmem_used;
> +			    viafbinfo->fix.smem_len - viaparinfo->fbmem_used;
>  			u.viasamm.size_sec = 0;
> -			u.viasamm.mem_base = viaparinfo->fbmem;
> +			u.viasamm.mem_base = viafbinfo->fix.smem_start;
>  			u.viasamm.offset_sec = 0;
>  		}
>  
> @@ -1245,7 +1243,7 @@ static int viafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
>  			}
>  		}
>  
> -		memcpy(((struct viafb_par *)(info->par))->fbmem_virt +
> +		memcpy(info->screen_base +
>  		       ((struct viafb_par *)(info->par))->cursor_start,
>  		       cr_data->bak, CURSOR_SIZE);
>  out:
> @@ -2164,15 +2162,14 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		goto out_fb_release;
>  
>  	viafb_init_chip_info(pdev, ent);
> -	viaparinfo->fbmem = pci_resource_start(pdev, 0);
> -	viaparinfo->memsize = viafb_get_fb_size_from_pci();
> -	viaparinfo->fbmem_free = viaparinfo->memsize;
> +	viafbinfo->fix.smem_start = pci_resource_start(pdev, 0);
> +	viafbinfo->fix.smem_len = viafb_get_fb_size_from_pci();
> +	viaparinfo->fbmem_free = viafbinfo->fix.smem_len;
>  	viaparinfo->fbmem_used = 0;
> -	viaparinfo->fbmem_virt = ioremap_nocache(viaparinfo->fbmem,
> -		viaparinfo->memsize);
> -	viafbinfo->screen_base = (char *)viaparinfo->fbmem_virt;
> +	viafbinfo->screen_base = ioremap_nocache(viafbinfo->fix.smem_start,
> +						 viafbinfo->fix.smem_len);
>  
> -	if (!viaparinfo->fbmem_virt) {
> +	if (!viafbinfo->screen_base) {
>  		printk(KERN_ERR "ioremap of fbmem failed\n");
>  		rc = -EIO;
>  		goto out_delete_i2c;
> @@ -2208,7 +2205,7 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  			viafb_second_size * 1024 * 1024;
>  	}
>  
> -	viafb_FB_MM = viaparinfo->fbmem_virt;
> +	viafb_FB_MM = viafbinfo->screen_base;
>  	tmpm = viafb_mode;
>  	tmpc = strsep(&tmpm, "x");
>  	strict_strtoul(tmpc, 0, &default_xres);
> @@ -2298,17 +2295,18 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		}
>  		viaparinfo1 = viafbinfo1->par;
>  		memcpy(viaparinfo1, viaparinfo, viafb_par_length);
> -		viaparinfo1->memsize = viaparinfo->memsize -
> -			viafb_second_offset;
> -		viaparinfo->memsize = viafb_second_offset;
> -		viaparinfo1->fbmem_virt = viaparinfo->fbmem_virt +
> +		viafbinfo1->fix.smem_len = viafbinfo->fix.smem_len -
> +							viafb_second_offset;
> +		viafbinfo->fix.smem_len = viafb_second_offset;
> +		viafbinfo1->screen_base = viafbinfo->screen_base +
>  			viafb_second_offset;
> -		viaparinfo1->fbmem = viaparinfo->fbmem + viafb_second_offset;
> +		viafbinfo1->fix.smem_start = viafbinfo->fix.smem_start + 
> +							viafb_second_offset;
>  
>  		viaparinfo1->fbmem_used = viaparinfo->fbmem_used;
> -		viaparinfo1->fbmem_free = viaparinfo1->memsize -
> +		viaparinfo1->fbmem_free = viafbinfo1->fix.smem_len -
>  			viaparinfo1->fbmem_used;
> -		viaparinfo->fbmem_free = viaparinfo->memsize;
> +		viaparinfo->fbmem_free = viafbinfo->fix.smem_len;
>  		viaparinfo->fbmem_used = 0;
>  		if (viafb_accel) {
>  			viaparinfo1->cursor_start =
> @@ -2322,7 +2320,6 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		memcpy(viafbinfo1, viafbinfo, sizeof(struct fb_info));
>  		viafbinfo1->screen_base = viafbinfo->screen_base +
>  			viafb_second_offset;
> -		viafbinfo1->fix.smem_start = viaparinfo1->fbmem;
>  		viafbinfo1->fix.smem_len = viaparinfo1->fbmem_free;
>  
>  		default_var.xres = viafb_second_xres;
> @@ -2398,7 +2395,7 @@ out_fb1_release:
>  out_unmap_mmio:
>  	iounmap(viaparinfo->io_virt);
>  out_unmap_fbmem:
> -	iounmap((void *)viaparinfo->fbmem_virt);
> +	iounmap((void *)viafbinfo->screen_base);

The cast here and below is not needed.

>  out_delete_i2c:
>  	viafb_delete_i2c_buss(viaparinfo);
>  out_fb_release:
> @@ -2413,7 +2410,7 @@ static void __devexit via_pci_remove(struct pci_dev *pdev)
>  	unregister_framebuffer(viafbinfo);
>  	if (viafb_dual_fb)
>  		unregister_framebuffer(viafbinfo1);
> -	iounmap((void *)viaparinfo->fbmem_virt);
> +	iounmap((void *)viafbinfo->screen_base);
>  	iounmap(viaparinfo->io_virt);
>  
>  	viafb_delete_i2c_buss(viaparinfo);
> diff --git a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
> index a4158e8..ed4129e 100644
> --- a/drivers/video/via/viafbdev.h
> +++ b/drivers/video/via/viafbdev.h
> @@ -45,10 +45,7 @@ struct viafb_par {
>  	u32 xoffset;
>  	u32 yoffset;
>  
> -	void __iomem *fbmem_virt;	/*framebuffer virtual memory address */
>  	void __iomem *io_virt;	/*iospace virtual memory address */
> -	unsigned int fbmem;	/*framebuffer physical memory address */
> -	unsigned int memsize;	/*size of fbmem */
>  	unsigned int io;	/*io space address */
>  	unsigned long mmio_base;	/*mmio base address */
>  	unsigned long mmio_len;	/*mmio base length */
> -- 
> 1.6.2.4
> 
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
Fantastyczne nagrody do zgarniecia!
Zagraj >> http://link.interia.pl/f2177 



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
