From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 13 Aug 2014 13:12:32 +0000
Subject: Re: [PATCH] backlight: remove .owner field for drivers using module_platform_driver
Message-Id: <20140813131232.GA8258@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407933518-7214-1-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1407933518-7214-1-git-send-email-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 13 Aug 2014, Peter Griffin wrote:

> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver or platform_driver_register api,
> as this is overriden in __platform_driver_register.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/video/backlight/88pm860x_bl.c    | 1 -
>  drivers/video/backlight/aat2870_bl.c     | 1 -
>  drivers/video/backlight/adp5520_bl.c     | 1 -
>  drivers/video/backlight/as3711_bl.c      | 1 -
>  drivers/video/backlight/da903x_bl.c      | 1 -
>  drivers/video/backlight/da9052_bl.c      | 1 -
>  drivers/video/backlight/ep93xx_bl.c      | 1 -
>  drivers/video/backlight/gpio_backlight.c | 1 -
>  drivers/video/backlight/lm3533_bl.c      | 1 -
>  drivers/video/backlight/lp8788_bl.c      | 1 -
>  drivers/video/backlight/max8925_bl.c     | 1 -
>  drivers/video/backlight/ot200_bl.c       | 1 -
>  drivers/video/backlight/pandora_bl.c     | 1 -
>  drivers/video/backlight/platform_lcd.c   | 1 -
>  drivers/video/backlight/pwm_bl.c         | 1 -
>  drivers/video/backlight/tps65217_bl.c    | 1 -
>  drivers/video/backlight/wm831x_bl.c      | 1 -
>  17 files changed, 17 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
