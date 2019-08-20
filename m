From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 20 Aug 2019 16:32:28 +0000
Subject: Re: [PATCH] video: backlight: tosa_lcd: drop check because i2c_unregister_device() is NULL safe
Message-Id: <20190820163228.xuz7su6psovp6pkp@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190820153439.7638-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:34:39PM +0200, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Build tested only, buildbot is happy, too.
> 
> Please apply to your tree.
> 
>  drivers/video/backlight/tosa_lcd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/tosa_lcd.c b/drivers/video/backlight/tosa_lcd.c
> index 65cb7578776f..29af8e27b6e5 100644
> --- a/drivers/video/backlight/tosa_lcd.c
> +++ b/drivers/video/backlight/tosa_lcd.c
> @@ -222,8 +222,7 @@ static int tosa_lcd_remove(struct spi_device *spi)
>  {
>  	struct tosa_lcd_data *data = spi_get_drvdata(spi);
>  
> -	if (data->i2c)
> -		i2c_unregister_device(data->i2c);
> +	i2c_unregister_device(data->i2c);
>  
>  	tosa_lcd_tg_off(data);
>  
> -- 
> 2.20.1
> 
