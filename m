From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Mon, 06 Nov 2017 08:40:19 +0000
Subject: Re: [PATCH] video: atmel_lcdfb: Use common error handling code in atmel_lcdfb_of_init()
Message-Id: <5477205e-2067-de4f-8736-71a2c9dc1653@microchip.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
In-Reply-To: <2db677d2-ad4e-1f79-344b-dfa38ce948c9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 05/11/2017 at 14:10, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 5 Nov 2017 14:00:52 +0100
> 
> Add a jump target so that a specific error message is stored only once
> at the end of this function implementation.
> Replace two calls of the function "dev_err" by goto statements.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sorry but NACK: the message was malformed and resulted in the
duplication of the error log that you spotted.

The proper way to fix this is to modify the second occurrence of this
message.
If you want to lower the size of strings in this driver, you can do it,
but not like this.

Regards,
  Nicolas


> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index e06358da4b99..3672c2e52ebd 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1047,10 +1047,8 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  	}
>  
>  	ret = of_property_read_u32(display_np, "bits-per-pixel", &var->bits_per_pixel);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get property bits-per-pixel\n");
> -		goto put_display_node;
> -	}
> +	if (ret < 0)
> +		goto report_bits_failure;
>  
>  	ret = of_property_read_u32(display_np, "atmel,guard-time", &pdata->guard_time);
>  	if (ret < 0) {
> @@ -1065,10 +1063,8 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  	}
>  
>  	ret = of_property_read_u32(display_np, "atmel,dmacon", &pdata->default_dmacon);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get property bits-per-pixel\n");
> -		goto put_display_node;
> -	}
> +	if (ret < 0)
> +		goto report_bits_failure;
>  
>  	INIT_LIST_HEAD(&pdata->pwr_gpios);
>  	ret = -ENOMEM;
> @@ -1147,6 +1143,10 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
>  put_display_node:
>  	of_node_put(display_np);
>  	return ret;
> +
> +report_bits_failure:
> +	dev_err(dev, "failed to get property bits-per-pixel\n");
> +	goto put_display_node;
>  }
>  #else
>  static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
> 


-- 
Nicolas Ferre
