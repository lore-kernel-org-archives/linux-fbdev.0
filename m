From: Stefan Agner <stefan@agner.ch>
Date: Sun, 07 Jan 2018 10:10:08 +0000
Subject: Re: [RFC PATCH V2] fbdev: mxsfb: use framebuffer_alloc in the correct way
Message-Id: <b5d9b9c2001cb5a96bf0de44462b1a54@agner.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180105103713.GA4196@panicking>
In-Reply-To: <20180105103713.GA4196@panicking>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 2018-01-05 11:37, Michael Trimarchi wrote:
> framebuffer_alloc allocated the fb_info struct plus the extra
> par and set fb_info->par pointer equal to this extra par. We
> can refer the mxcfb_info from fb_info->par
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Looks good to me.

Reviewed-by: Stefan Agner <stefan@agner.ch>

And seems to work fine using i.MX 7.

Tested-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
> Changes V1->V2:
> 	- drop to_imxfb_host. Use instead fb_info->par
> ---
>  drivers/video/fbdev/mxsfb.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index 79b1dc7..246bea3 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -169,7 +169,6 @@ struct mxsfb_devdata {
>  };
>  
>  struct mxsfb_info {
> -	struct fb_info fb_info;
>  	struct platform_device *pdev;
>  	struct clk *clk;
>  	struct clk *clk_axi;
> @@ -208,8 +207,6 @@ static const struct mxsfb_devdata mxsfb_devdata[] = {
>  	},
>  };
>  
> -#define to_imxfb_host(x) (container_of(x, struct mxsfb_info, fb_info))
> -
>  /* mask and shift depends on architecture */
>  static inline u32 set_hsync_pulse_width(struct mxsfb_info *host, unsigned val)
>  {
> @@ -269,7 +266,7 @@ static inline unsigned chan_to_field(unsigned
> chan, struct fb_bitfield *bf)
>  static int mxsfb_check_var(struct fb_var_screeninfo *var,
>  		struct fb_info *fb_info)
>  {
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  	const struct fb_bitfield *rgb = NULL;
>  
>  	if (var->xres < MIN_XRES)
> @@ -330,7 +327,7 @@ static inline void mxsfb_disable_axi_clk(struct
> mxsfb_info *host)
>  
>  static void mxsfb_enable_controller(struct fb_info *fb_info)
>  {
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  	u32 reg;
>  	int ret;
>  
> @@ -367,7 +364,7 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
>  
>  static void mxsfb_disable_controller(struct fb_info *fb_info)
>  {
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  	unsigned loop;
>  	u32 reg;
>  	int ret;
> @@ -409,7 +406,7 @@ static void mxsfb_disable_controller(struct
> fb_info *fb_info)
>  
>  static int mxsfb_set_par(struct fb_info *fb_info)
>  {
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  	u32 ctrl, vdctrl0, vdctrl4;
>  	int line_size, fb_size;
>  	int reenable = 0;
> @@ -569,7 +566,7 @@ static int mxsfb_setcolreg(u_int regno, u_int red,
> u_int green, u_int blue,
>  
>  static int mxsfb_blank(int blank, struct fb_info *fb_info)
>  {
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  
>  	switch (blank) {
>  	case FB_BLANK_POWERDOWN:
> @@ -591,7 +588,7 @@ static int mxsfb_blank(int blank, struct fb_info *fb_info)
>  static int mxsfb_pan_display(struct fb_var_screeninfo *var,
>  		struct fb_info *fb_info)
>  {
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  	unsigned offset;
>  
>  	if (var->xoffset != 0)
> @@ -622,10 +619,10 @@ static struct fb_ops mxsfb_ops = {
>  	.fb_imageblit = cfb_imageblit,
>  };
>  
> -static int mxsfb_restore_mode(struct mxsfb_info *host,
> +static int mxsfb_restore_mode(struct fb_info *fb_info,
>  			struct fb_videomode *vmode)
>  {
> -	struct fb_info *fb_info = &host->fb_info;
> +	struct mxsfb_info *host = fb_info->par;
>  	unsigned line_count;
>  	unsigned period;
>  	unsigned long pa, fbsize;
> @@ -726,10 +723,10 @@ static int mxsfb_restore_mode(struct mxsfb_info *host,
>  	return ret;
>  }
>  
> -static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
> +static int mxsfb_init_fbinfo_dt(struct fb_info *fb_info,
>  				struct fb_videomode *vmode)
>  {
> -	struct fb_info *fb_info = &host->fb_info;
> +	struct mxsfb_info *host = fb_info->par;
>  	struct fb_var_screeninfo *var = &fb_info->var;
>  	struct device *dev = &host->pdev->dev;
>  	struct device_node *np = host->pdev->dev.of_node;
> @@ -805,12 +802,12 @@ static int mxsfb_init_fbinfo_dt(struct mxsfb_info *host,
>  	return ret;
>  }
>  
> -static int mxsfb_init_fbinfo(struct mxsfb_info *host,
> +static int mxsfb_init_fbinfo(struct fb_info *fb_info,
>  			struct fb_videomode *vmode)
>  {
>  	int ret;
> +	struct mxsfb_info *host = fb_info->par;
>  	struct device *dev = &host->pdev->dev;
> -	struct fb_info *fb_info = &host->fb_info;
>  	struct fb_var_screeninfo *var = &fb_info->var;
>  	dma_addr_t fb_phys;
>  	void *fb_virt;
> @@ -824,7 +821,7 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
>  	fb_info->fix.visual = FB_VISUAL_TRUECOLOR,
>  	fb_info->fix.accel = FB_ACCEL_NONE;
>  
> -	ret = mxsfb_init_fbinfo_dt(host, vmode);
> +	ret = mxsfb_init_fbinfo_dt(fb_info, vmode);
>  	if (ret)
>  		return ret;
>  
> @@ -843,16 +840,16 @@ static int mxsfb_init_fbinfo(struct mxsfb_info *host,
>  	fb_info->screen_base = fb_virt;
>  	fb_info->screen_size = fb_info->fix.smem_len = fb_size;
>  
> -	if (mxsfb_restore_mode(host, vmode))
> +	if (mxsfb_restore_mode(fb_info, vmode))
>  		memset(fb_virt, 0, fb_size);
>  
>  	return 0;
>  }
>  
> -static void mxsfb_free_videomem(struct mxsfb_info *host)
> +static void mxsfb_free_videomem(struct fb_info *fb_info)
>  {
> +	struct mxsfb_info *host = fb_info->par;
>  	struct device *dev = &host->pdev->dev;
> -	struct fb_info *fb_info = &host->fb_info;
>  
>  	dma_free_wc(dev, fb_info->screen_size, fb_info->screen_base,
>  		    fb_info->fix.smem_start);
> @@ -902,7 +899,7 @@ static int mxsfb_probe(struct platform_device *pdev)
>  	if (mode = NULL)
>  		return -ENOMEM;
>  
> -	host = to_imxfb_host(fb_info);
> +	host = fb_info->par;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->base = devm_ioremap_resource(&pdev->dev, res);
> @@ -941,7 +938,7 @@ static int mxsfb_probe(struct platform_device *pdev)
>  		goto fb_release;
>  	}
>  
> -	ret = mxsfb_init_fbinfo(host, mode);
> +	ret = mxsfb_init_fbinfo(fb_info, mode);
>  	if (ret != 0)
>  		goto fb_release;
>  
> @@ -982,13 +979,13 @@ static int mxsfb_probe(struct platform_device *pdev)
>  static int mxsfb_remove(struct platform_device *pdev)
>  {
>  	struct fb_info *fb_info = platform_get_drvdata(pdev);
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  
>  	if (host->enabled)
>  		mxsfb_disable_controller(fb_info);
>  
>  	unregister_framebuffer(fb_info);
> -	mxsfb_free_videomem(host);
> +	mxsfb_free_videomem(fb_info);
>  
>  	framebuffer_release(fb_info);
>  
> @@ -998,7 +995,7 @@ static int mxsfb_remove(struct platform_device *pdev)
>  static void mxsfb_shutdown(struct platform_device *pdev)
>  {
>  	struct fb_info *fb_info = platform_get_drvdata(pdev);
> -	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +	struct mxsfb_info *host = fb_info->par;
>  
>  	mxsfb_enable_axi_clk(host);
