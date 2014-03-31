From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 31 Mar 2014 07:43:40 +0000
Subject: Re: [PATCH 2/2] backlight: platform_lcd: Remove #ifdef CONFIG_PM_SLEEP
Message-Id: <20140331074340.GL17779@lee--X1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396087220-1564-2-git-send-email-shc_work@mail.ru>
In-Reply-To: <1396087220-1564-2-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

> This patch removes #ifdef CONFIG_PM_SLEEP to improve compile coverage.

Compile coverage would improve if we removed all in-file CONFIG
stipulations, but that's not helpful. What's the reason for removing
them in this case?

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/backlight/platform_lcd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/backlight/platform_lcd.c b/drivers/video/backl=
ight/platform_lcd.c
> index 4afc21f..986f46a 100644
> --- a/drivers/video/backlight/platform_lcd.c
> +++ b/drivers/video/backlight/platform_lcd.c
> @@ -110,8 +110,7 @@ static int platform_lcd_probe(struct platform_device =
*pdev)
>  	return 0;
>  }
> =20
> -#ifdef CONFIG_PM_SLEEP
> -static int platform_lcd_suspend(struct device *dev)
> +static int __maybe_unused platform_lcd_suspend(struct device *dev)
>  {
>  	struct platform_lcd *plcd =3D dev_get_drvdata(dev);
> =20
> @@ -121,7 +120,7 @@ static int platform_lcd_suspend(struct device *dev)
>  	return 0;
>  }
> =20
> -static int platform_lcd_resume(struct device *dev)
> +static int __maybe_unused platform_lcd_resume(struct device *dev)
>  {
>  	struct platform_lcd *plcd =3D dev_get_drvdata(dev);
> =20
> @@ -130,7 +129,6 @@ static int platform_lcd_resume(struct device *dev)
> =20
>  	return 0;
>  }
> -#endif
> =20
>  static SIMPLE_DEV_PM_OPS(platform_lcd_pm_ops, platform_lcd_suspend,
>  			platform_lcd_resume);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
