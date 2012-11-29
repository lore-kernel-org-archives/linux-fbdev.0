From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 29 Nov 2012 05:30:54 +0000
Subject: Re: [PATCH] backlight: corgi_lcd: Fix WARN_ON() when calling corgi_bl_set_intensity.
Message-Id: <001501cdcdf2$b3f8f730$1beae590$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1354139201-12834-1-git-send-email-dromede@gmail.com>
In-Reply-To: <1354139201-12834-1-git-send-email-dromede@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, November 29, 2012 6:47 AM, Marko Katic wrote
> Subject: [PATCH] backlight: corgi_lcd: Fix WARN_ON() when calling corgi_bl_set_intensity.

CC'ed Andrew Morton.


Hi Marko Katic,
The commit subject and commit message are not clear.

How about using subject as below?
backlight: corgi_lcd: use gpio_set_value_cansleep()

In addition, 'Fix WARN_ON() when calling corgi_bl_set_intensity'
would be the reason why you submit this patch.
Please make the commit message more detail.

Also, I have a question on gpio driver.
In order to trigger WARN_ON(chip->can_sleep), 'can_sleep' should be
set as 1. However, I cannot find 'can_sleep = 1' in the PXA gpio driver.
What gpio driver do you use to test corgi_lcd driver?


Best regards,
Jingoo Han

> 
> From: Marko Katic <dromede.gmail.com>
> 
> 
> Signed-off-by: Marko Katic <dromede@gmail.com>
> ---
>  drivers/video/backlight/corgi_lcd.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
> index c781768..8b002d7 100644
> --- a/drivers/video/backlight/corgi_lcd.c
> +++ b/drivers/video/backlight/corgi_lcd.c
> @@ -409,10 +409,10 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
>  	cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
> 
>  	if (gpio_is_valid(lcd->gpio_backlight_cont))
> -		gpio_set_value(lcd->gpio_backlight_cont, cont);
> +		gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
> 
>  	if (gpio_is_valid(lcd->gpio_backlight_on))
> -		gpio_set_value(lcd->gpio_backlight_on, intensity);
> +		gpio_set_value_cansleep(lcd->gpio_backlight_on, intensity);
> 
>  	if (lcd->kick_battery)
>  		lcd->kick_battery();
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

