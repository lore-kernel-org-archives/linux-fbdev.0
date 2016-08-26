From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 26 Aug 2016 14:38:10 +0000
Subject: Re: [PATCH] video: mxsfb: Fix framebuffer corruption on mx6sx
Message-Id: <1472222290.27333.20.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826143045.7386-1-marex@denx.de>
In-Reply-To: <20160826143045.7386-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Am Freitag, den 26.08.2016, 16:30 +0200 schrieb Marek Vasut:
> Allocate the framebuffer memory as coherent, otherwise the framebuffer
> will suffer from artifacts when displaying scrolling text or video.
> This can be replicated on i.MX6SX (armv7), which has more complex memory
> architecture compared to the i.MX23/28 (armv5).
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
>  drivers/video/fbdev/mxsfb.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index 4e6608c..bd1a310 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -800,6 +800,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
>  			struct fb_videomode *vmode)
>  {
>  	int ret;
> +	struct device *dev = &host->pdev->dev;
>  	struct fb_info *fb_info = &host->fb_info;
>  	struct fb_var_screeninfo *var = &fb_info->var;
>  	dma_addr_t fb_phys;
> @@ -825,12 +826,11 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
>  
>  	/* Memory allocation for framebuffer */
>  	fb_size = SZ_2M;
> -	fb_virt = alloc_pages_exact(fb_size, GFP_DMA);
> +	fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fb_size), &fb_phys,
> +				     GFP_KERNEL);

You probably want writecombined memory here instead of coherent. Using
coherent memory for framebuffers sucks performance wise.

>  	if (!fb_virt)
>  		return -ENOMEM;
>  
> -	fb_phys = virt_to_phys(fb_virt);
> -
>  	fb_info->fix.smem_start = fb_phys;
>  	fb_info->screen_base = fb_virt;
>  	fb_info->screen_size = fb_info->fix.smem_len = fb_size;
> @@ -843,9 +843,11 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
>  
>  static void mxsfb_free_videomem(struct mxsfb_info *host)
>  {
> +	struct device *dev = &host->pdev->dev;
>  	struct fb_info *fb_info = &host->fb_info;
>  
> -	free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
> +	dma_free_coherent(dev, fb_info->screen_size, fb_info->screen_base,
> +			  fb_info->fix.smem_start);
>  }
>  
>  static const struct platform_device_id mxsfb_devtype[] = {


