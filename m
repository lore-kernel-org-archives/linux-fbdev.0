From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 16 Apr 2013 12:35:24 +0000
Subject: Re: [PATCH 2/8] video: atmel_lcdfb: introduce atmel_lcdfb_power_control
Message-Id: <516D458C.8050205@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-2-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1365692422-9565-2-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/11/2013 05:00 PM, Jean-Christophe PLAGNIOL-VILLARD :
> to simplify the check on the presence of the callback
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Simple and nice

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/video/atmel_lcdfb.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 98733cd4..9574c47 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -283,6 +283,13 @@ static void init_contrast(struct atmel_lcdfb_info *sinfo)
>  		init_backlight(sinfo);
>  }
>  
> +static inline void atmel_lcdfb_power_control(struct atmel_lcdfb_info *sinfo, int on)
> +{
> +	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
> +
> +	if (pdata->atmel_lcdfb_power_control)
> +		pdata->atmel_lcdfb_power_control(on);
> +}
>  
>  static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
>  	.type		= FB_TYPE_PACKED_PIXELS,
> @@ -1114,8 +1121,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  	fb_add_videomode(&fbmode, &info->modelist);
>  
>  	/* Power up the LCDC screen */
> -	if (pdata->atmel_lcdfb_power_control)
> -		pdata->atmel_lcdfb_power_control(1);
> +	atmel_lcdfb_power_control(sinfo, 1);
>  
>  	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %d\n",
>  		       info->node, info->fix.mmio_start, sinfo->mmio, sinfo->irq_base);
> @@ -1169,8 +1175,7 @@ static int __exit atmel_lcdfb_remove(struct platform_device *pdev)
>  
>  	cancel_work_sync(&sinfo->task);
>  	exit_backlight(sinfo);
> -	if (pdata->atmel_lcdfb_power_control)
> -		pdata->atmel_lcdfb_power_control(0);
> +	atmel_lcdfb_power_control(sinfo, 0);
>  	unregister_framebuffer(info);
>  	atmel_lcdfb_stop_clock(sinfo);
>  	clk_put(sinfo->lcdc_clk);
> @@ -1198,7 +1203,6 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  	struct atmel_lcdfb_info *sinfo = info->par;
> -	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
>  
>  	/*
>  	 * We don't want to handle interrupts while the clock is
> @@ -1208,9 +1212,7 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
>  
>  	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
>  	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
> -	if (pdata->atmel_lcdfb_power_control)
> -		pdata->atmel_lcdfb_power_control(0);
> -
> +	atmel_lcdfb_power_control(sinfo, 0);
>  	atmel_lcdfb_stop(sinfo);
>  	atmel_lcdfb_stop_clock(sinfo);
>  
> @@ -1221,12 +1223,10 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
>  {
>  	struct fb_info *info = platform_get_drvdata(pdev);
>  	struct atmel_lcdfb_info *sinfo = info->par;
> -	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
>  
>  	atmel_lcdfb_start_clock(sinfo);
>  	atmel_lcdfb_start(sinfo);
> -	if (pdata->atmel_lcdfb_power_control)
> -		pdata->atmel_lcdfb_power_control(1);
> +	atmel_lcdfb_power_control(sinfo, 1);
>  	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, sinfo->saved_lcdcon);
>  
>  	/* Enable FIFO & DMA errors */
> 


-- 
Nicolas Ferre
