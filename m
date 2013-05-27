From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Mon, 27 May 2013 14:44:24 +0000
Subject: Re: [PATCH] video: mxsfb: Let device core handle pinctrl
Message-Id: <20130527144424.GD23825@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369619294-10362-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1369619294-10362-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 22:48 Sun 26 May     , Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core)
> we can rely on device core for handling pinctrl, so remove 
> devm_pinctrl_get_select_default() from the driver.
Linus we should do a pass on the kernel to clean this

Best Regards,
J.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/video/mxsfb.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 21223d4..9d6a286 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -46,7 +46,6 @@
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
> -#include <linux/pinctrl/consumer.h>
>  #include <linux/fb.h>
>  #include <linux/regulator/consumer.h>
>  #include <video/of_display_timing.h>
> @@ -877,7 +876,6 @@ static int mxsfb_probe(struct platform_device *pdev)
>  	struct mxsfb_info *host;
>  	struct fb_info *fb_info;
>  	struct fb_modelist *modelist;
> -	struct pinctrl *pinctrl;
>  	int ret;
>  
>  	if (of_id)
> @@ -909,12 +907,6 @@ static int mxsfb_probe(struct platform_device *pdev)
>  
>  	host->devdata = &mxsfb_devdata[pdev->id_entry->driver_data];
>  
> -	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> -	if (IS_ERR(pinctrl)) {
> -		ret = PTR_ERR(pinctrl);
> -		goto fb_release;
> -	}
> -
>  	host->clk = devm_clk_get(&host->pdev->dev, NULL);
>  	if (IS_ERR(host->clk)) {
>  		ret = PTR_ERR(host->clk);
> -- 
> 1.8.1.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
