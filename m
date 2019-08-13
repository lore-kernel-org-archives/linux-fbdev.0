From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 13 Aug 2019 13:19:58 +0000
Subject: Re: [PATCH resend] video: backlight: Drop default m for {LCD,BACKLIGHT_CLASS_DEVICE}
Message-Id: <20190813131958.y3fgzeeuzhsfddbh@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190813115853.30329-1-geert@linux-m68k.org>
In-Reply-To: <20190813115853.30329-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 01:58:53PM +0200, Geert Uytterhoeven wrote:
> When running "make oldconfig" on a .config where
> CONFIG_BACKLIGHT_LCD_SUPPORT is not set, two new config options
> ("Lowlevel LCD controls" and "Lowlevel Backlight controls") appear, both
> defaulting to "m".
> 
> Drop the "default m", as options should default to disabled, and because
> several driver config options already select LCD_CLASS_DEVICE or
> BACKLIGHT_CLASS_DEVICE when needed.
> 
> Fixes: 8c5dc8d9f19c7992 ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8b081d61773e21eb..40676be2e46aae61 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -10,7 +10,6 @@ menu "Backlight & LCD device support"
>  #
>  config LCD_CLASS_DEVICE
>          tristate "Lowlevel LCD controls"
> -	default m
>  	help
>  	  This framework adds support for low-level control of LCD.
>  	  Some framebuffer devices connect to platform-specific LCD modules
> @@ -143,7 +142,6 @@ endif # LCD_CLASS_DEVICE
>  #
>  config BACKLIGHT_CLASS_DEVICE
>          tristate "Lowlevel Backlight controls"
> -	default m
>  	help
>  	  This framework adds support for low-level control of the LCD
>            backlight. This includes support for brightness and power.
> -- 
> 2.17.1
> 
