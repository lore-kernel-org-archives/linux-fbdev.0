From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 08 Mar 2016 08:00:05 +0000
Subject: Re: [PATCH 3/3] video: fbdev: imxfb: add some error handling
Message-Id: <1457424005.4174.6.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Am Montag, den 07.03.2016, 20:53 +0100 schrieb Uwe Kleine-König:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/imxfb.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 3dd2824e6773..671b3719db56 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -473,8 +473,9 @@ static int imxfb_set_par(struct fb_info *info)
>  	return 0;
>  }
>  
> -static void imxfb_enable_controller(struct imxfb_info *fbi)
> +static int imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;
>  
>  	if (fbi->enabled)
>  		return;
> @@ -496,10 +497,27 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
>  	 */
>  	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
>  
> -	clk_prepare_enable(fbi->clk_ipg);
> -	clk_prepare_enable(fbi->clk_ahb);
> -	clk_prepare_enable(fbi->clk_per);
> +	ret = clk_prepare_enable(fbi->clk_ipg);
> +	if (ret)
> +		goto err_enable_ipg;
> +
> +	ret = clk_prepare_enable(fbi->clk_ahb);
> +	if (ret)
> +		goto err_enable_ahb;
> +
> +	ret = clk_prepare_enable(fbi->clk_per);
> +	if (ret) {
> +		clk_disable_unprepare(fbi->clk_ahb);
> +err_enable_ahb:
> +		clk_disable_unprepare(fbi->clk_ipg);
> +err_enable_ipg:
> +		writel(0, fbi->regs + LCDC_RMCR);
> +
> +		return ret;
> +	}
> +
>  	fbi->enabled = true;
> +	return 0;
>  }
>  
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
> @@ -510,8 +528,8 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  	pr_debug("Disabling LCD controller\n");
>  
>  	clk_disable_unprepare(fbi->clk_per);
> -	clk_disable_unprepare(fbi->clk_ipg);
>  	clk_disable_unprepare(fbi->clk_ahb);
> +	clk_disable_unprepare(fbi->clk_ipg);
>  	fbi->enabled = false;
>  
>  	writel(0, fbi->regs + LCDC_RMCR);
> @@ -520,6 +538,7 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
>  static int imxfb_blank(int blank, struct fb_info *info)
>  {
>  	struct imxfb_info *fbi = info->par;
> +	int ret = 0;;

s/;;/;/

>  
>  	pr_debug("imxfb_blank: blank=%d\n", blank);
>  
> @@ -532,10 +551,10 @@ static int imxfb_blank(int blank, struct fb_info *info)
>  		break;
>  
>  	case FB_BLANK_UNBLANK:
> -		imxfb_enable_controller(fbi);
> +		ret = imxfb_enable_controller(fbi);
>  		break;

or this could be simplified to:
		return imxfb_enable_controller(fbi);

>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  static struct fb_ops imxfb_ops = {

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

