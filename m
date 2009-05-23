From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 09/15] viafb: Remove MMIO from
 private structure
Date: Sat, 23 May 2009 08:32:36 +0200
Message-ID: <20090523083236.1d9d9ce8.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7kgY-0002NQ-AL
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:26:22 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7kgS-0006l9-Vw for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:26:22 +0000
In-Reply-To: <1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
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

On Thu, 21 May 2009 04:28:47 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> Rather than using our own private structure members for MMIO base
> and length, we use the fb_info->fix ones.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/via/viafbdev.c |   11 ++++-------
>  drivers/video/via/viafbdev.h |    2 --
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index c420623..00f58c8 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -122,9 +122,6 @@ static void viafb_setup_fixinfo(struct fb_fix_screeninfo *fix,
>  	strcpy(fix->id, viafb_name);
>  
>  	fix->smem_len = viaparinfo->fbmem_free;
> -	fix->mmio_start = viaparinfo->mmio_base;
> -	fix->mmio_len = viaparinfo->mmio_len;
> -
>  	fix->type = FB_TYPE_PACKED_PIXELS;
>  	fix->type_aux = 0;
>  
> @@ -2175,10 +2172,10 @@ static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		goto out_delete_i2c;
>  	}
>  
> -	viaparinfo->mmio_base = pci_resource_start(pdev, 1);
> -	viaparinfo->mmio_len = pci_resource_len(pdev, 1);
> -	viaparinfo->io_virt = ioremap_nocache(viaparinfo->mmio_base,
> -		viaparinfo->mmio_len);
> +	viafbinfo->fix.mmio_start = pci_resource_start(pdev, 1);
> +	viafbinfo->fix.mmio_len = pci_resource_len(pdev, 1);
> +	viaparinfo->io_virt = ioremap_nocache(viafbinfo->fix.mmio_start,
> +					      viafbinfo->fix.mmio_len);
>  	if (!viaparinfo->io_virt) {
>  		printk(KERN_ERR "ioremap of MMIO failed\n");
>  		rc = -EIO;
> diff --git a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
> index ed4129e..0c1d734 100644
> --- a/drivers/video/via/viafbdev.h
> +++ b/drivers/video/via/viafbdev.h
> @@ -47,8 +47,6 @@ struct viafb_par {
>  
>  	void __iomem *io_virt;	/*iospace virtual memory address */
>  	unsigned int io;	/*io space address */
> -	unsigned long mmio_base;	/*mmio base address */
> -	unsigned long mmio_len;	/*mmio base length */
>  	u32 fbmem_free;		/* Free FB memory */
>  	u32 fbmem_used;		/* Use FB memory size */
>  	u32 cursor_start;	/* Cursor Start Address */
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
Chcesz miec nawigacje GPS ?
Zamow lub przedluz umowe na neostrade, a nawigacja bedzie Twoja.
Kliknij na link po szczegoly! http://link.interia.pl/f219a



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
