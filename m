From: Timur Tabi <timur@tabi.org>
Date: Fri, 31 May 2013 13:26:05 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <51A8A4ED.6070104@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <ea3d6fcbb9f7a00a9cdbd3d0a7a4d3401265ebf0.1370004925.git.michal.simek@xilinx.com>
In-Reply-To: <ea3d6fcbb9f7a00a9cdbd3d0a7a4d3401265ebf0.1370004925.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On 05/31/2013 07:55 AM, Michal Simek wrote:

> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
> index f3d4a69..e27a4f6 100644
> --- a/drivers/video/xilinxfb.c
> +++ b/drivers/video/xilinxfb.c
> @@ -131,7 +131,7 @@ struct xilinxfb_drvdata {
>  	dcr_host_t      dcr_host;
>  	unsigned int    dcr_len;
>  #endif
> -	void		*fb_virt;	/* virt. address of the frame buffer */
> +	void __iomem	*fb_virt;	/* virt. address of the frame buffer */
>  	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
>  	int		fb_alloced;	/* Flag, was the fb memory alloced? */
> 
> @@ -273,8 +273,10 @@ static int xilinxfb_assign(struct platform_device *pdev,
>  		drvdata->fb_virt = ioremap(pdata->fb_phys, fbsize);
>  	} else {
>  		drvdata->fb_alloced = 1;
> -		drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
> -					&drvdata->fb_phys, GFP_KERNEL);
> +		drvdata->fb_virt = (__force void __iomem *)
> +				   dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
> +						      &drvdata->fb_phys,
> +						      GFP_KERNEL);

I think this is wrong.  At least, it would be on PowerPC.
dma_alloc_coherent() allocates regular RAM, not I/O memory.  So it
should not be __iomem.



-- 
Timur Tabi
