From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 29 Mar 2011 11:19:05 +0000
Subject: Re: [patch] backlight/pcf50633: check for NULL consistently in pcf50633_bl_probe()
Message-Id: <4D91C029.5040507@metafoo.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110329032020.GD9856@bicker>
In-Reply-To: <20110329032020.GD9856@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/29/2011 05:20 AM, Dan Carpenter wrote:
> We checked "pdata" for NULL at the start of the function so we should
> check it here as well.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
> Compile tested only.  Please review.
> 
> diff --git a/drivers/video/backlight/pcf50633-backlight.c b/drivers/video/backlight/pcf50633-backlight.c
> index ef5628d..0fe934f 100644
> --- a/drivers/video/backlight/pcf50633-backlight.c
> +++ b/drivers/video/backlight/pcf50633-backlight.c
> @@ -136,7 +136,9 @@ static int __devinit pcf50633_bl_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcf_bl);
>  
> -	pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);
> +	if (pdata)
> +		pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM,
> +					pdata->ramp_time);
>  
>  	/* Should be different from bl_props.brightness, so we do not exit
>  	 * update_status early the first time it's called */

