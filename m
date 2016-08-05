From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 05 Aug 2016 09:09:45 +0000
Subject: Re: [PATCH] video: backlight: lcd: fix race condition during register
Message-Id: <20160805090945.GV5243@dell>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Wed, 06 Jul 2016, Uwe Kleine-König wrote:

> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Once device_register is called for a device its attributes might be
> accessed. As the callbacks of a lcd device's attributes make use of the
> lcd_ops, the respective member must be setup before calling
> device_register.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/backlight/lcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
> index 7de847df224f..4b40c6a4d441 100644
> --- a/drivers/video/backlight/lcd.c
> +++ b/drivers/video/backlight/lcd.c
> @@ -226,6 +226,8 @@ struct lcd_device *lcd_device_register(const char *name, struct device *parent,
>  	dev_set_name(&new_ld->dev, "%s", name);
>  	dev_set_drvdata(&new_ld->dev, devdata);
>  
> +	new_ld->ops = ops;
> +
>  	rc = device_register(&new_ld->dev);
>  	if (rc) {
>  		put_device(&new_ld->dev);
> @@ -238,8 +240,6 @@ struct lcd_device *lcd_device_register(const char *name, struct device *parent,
>  		return ERR_PTR(rc);
>  	}
>  
> -	new_ld->ops = ops;
> -
>  	return new_ld;
>  }
>  EXPORT_SYMBOL(lcd_device_register);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
