From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 02 May 2019 10:33:57 +0000
Subject: Re: [PATCH] backlight: rave-sp: don't touch initial state and register with correct device
Message-Id: <c23ecabd-c2ee-8c23-9ee3-13290bc4da35@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190429152919.27277-1-l.stach@pengutronix.de>
In-Reply-To: <20190429152919.27277-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lucas Stach <l.stach@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org, kernel@pengutronix.de, dri-devel@lists.freedesktop.org, patchwork-lst@pengutronix.de

On 29/04/2019 16:29, Lucas Stach wrote:
> This way the backlight can be referenced through its device node and
> enabling/disabling can be managed through the panel driver.

Is it possible to implement something similar to 
pwm_backlight_initial_power_state() to handle this?

backlight drivers already suffer from too much diversity so I prefer 
things like this to align behaviour with the (fairly heavilyly used) PWM 
driver if possible.


Daniel.


> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>   drivers/video/backlight/rave-sp-backlight.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/rave-sp-backlight.c b/drivers/video/backlight/rave-sp-backlight.c
> index 462f14a1b19d..d296bfcf4396 100644
> --- a/drivers/video/backlight/rave-sp-backlight.c
> +++ b/drivers/video/backlight/rave-sp-backlight.c
> @@ -48,15 +48,13 @@ static int rave_sp_backlight_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct backlight_device *bd;
>   
> -	bd = devm_backlight_device_register(dev, pdev->name, dev->parent,
> +	bd = devm_backlight_device_register(dev, pdev->name, dev,
>   					    dev_get_drvdata(dev->parent),
>   					    &rave_sp_backlight_ops,
>   					    &rave_sp_backlight_props);
>   	if (IS_ERR(bd))
>   		return PTR_ERR(bd);
>   
> -	backlight_update_status(bd);
> -
>   	return 0;
>   }
>   
> 
