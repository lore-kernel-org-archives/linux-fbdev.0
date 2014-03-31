From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 31 Mar 2014 07:40:42 +0000
Subject: Re: [PATCH 1/2] backlight: platform_lcd: Remove DT compatibility string
Message-Id: <20140331074042.GK17779@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396087220-1564-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1396087220-1564-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

> Driver is written for using platform callback functions and it cannot
> be used without these functions, so having "platform-lcd" in the device
> tree do nothing. This patch removes DT compatibility string.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/backlight/platform_lcd.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backl=
ight/platform_lcd.c
> index c3d2e20..4afc21f 100644
> --- a/drivers/video/backlight/platform_lcd.c
> +++ b/drivers/video/backlight/platform_lcd.c
> @@ -16,8 +16,6 @@
>  #include <linux/fb.h>
>  #include <linux/backlight.h>
>  #include <linux/lcd.h>
> -#include <linux/of.h>
> -#include <linux/slab.h>
> =20
>  #include <video/platform_lcd.h>
> =20
> @@ -137,20 +135,11 @@ static int platform_lcd_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(platform_lcd_pm_ops, platform_lcd_suspend,
>  			platform_lcd_resume);
> =20
> -#ifdef CONFIG_OF
> -static const struct of_device_id platform_lcd_of_match[] =3D {
> -	{ .compatible =3D "platform-lcd" },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, platform_lcd_of_match);
> -#endif
> -

Rather than remove DT support, we should look into what these
call-back functions to and work to rid those instead. What exactly do
these routines provide?

>  static struct platform_driver platform_lcd_driver =3D {
>  	.driver		=3D {
>  		.name	=3D "platform-lcd",
>  		.owner	=3D THIS_MODULE,
>  		.pm	=3D &platform_lcd_pm_ops,
> -		.of_match_table =3D of_match_ptr(platform_lcd_of_match),
>  	},
>  	.probe		=3D platform_lcd_probe,
>  };

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
