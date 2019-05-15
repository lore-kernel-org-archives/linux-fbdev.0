From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 May 2019 08:56:51 +0000
Subject: Re: [PATCH v2 1/2] video: lcd: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol
Message-Id: <CAMuHMdXrAaZoqsnY_adE=jn-hmTrgmsvJ2tDo+5ByxZ4sz_S7Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190117133336.19737-1-shc_work@mail.ru>
In-Reply-To: <20190117133336.19737-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Daniel Thompson <daniel.thompson@linaro.org>, DRI Development <dri-devel@lists.freedesktop.org>, Lee Jones <lee.jones@linaro.org>

Hi Alexander,

On Thu, Jan 17, 2019 at 2:39 PM Alexander Shiyan <shc_work@mail.ru> wrote:
> We have two *_CLASS_DEVICE kernel config options (LCD_CLASS_DEVICE
> and BACKLIGHT_LCD_DEVICE) that do the same job.
> The patch removes useless BACKLIGHT_LCD_SUPPORT option
> and converts LCD_CLASS_DEVICE into a menu.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

This is now commit 8c5dc8d9f19c7992 ("video: backlight: Remove useless
BACKLIGHT_LCD_SUPPORT kernel symbol").

> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -2,13 +2,7 @@
>  # Backlight & LCD drivers configuration
>  #
>
> -menuconfig BACKLIGHT_LCD_SUPPORT
> -       bool "Backlight & LCD device support"
> -       help
> -         Enable this to be able to choose the drivers for controlling the
> -         backlight and the LCD panel on some platforms, for example on PDAs.
> -
> -if BACKLIGHT_LCD_SUPPORT
> +menu "Backlight & LCD device support"
>
>  #
>  # LCD

Below, we have:

    config LCD_CLASS_DEVICE
            tristate "Lowlevel LCD controls"
            default m
            help
              This framework adds support for low-level control of LCD.
              Some framebuffer devices connect to platform-specific LCD modules
              in order to have a platform-specific way to control the flat panel
              (contrast and applying power to the LCD (not to the backlight!)).

and:

    config BACKLIGHT_CLASS_DEVICE
            tristate "Lowlevel Backlight controls"
            default m
            help
              This framework adds support for low-level control of the LCD
              backlight. This includes support for brightness and power.

Hence running "make oldconfig" on a .config where
CONFIG_BACKLIGHT_LCD_SUPPORT was not set leads two to new
questions, where the answers default to "m".

Perhaps the "default m" statements should be removed?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
