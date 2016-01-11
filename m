From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 11 Jan 2016 06:40:05 +0000
Subject: Re: [PATCH] backlight: gpio-backlight: use default-on on GPIO request
Message-Id: <20160111064005.GU3331@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1445643883-30726-1-git-send-email-stefan@agner.ch>
In-Reply-To: <1445643883-30726-1-git-send-email-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Stefan Agner <stefan@agner.ch>
Cc: jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 23 Oct 2015, Stefan Agner wrote:

> There are situations where the backlight should be on at boot time
> (e.g. if the boot loader already turned the display on). The DT
> bindings specify the "default-on" property for that purpose.
> Currently, the initial state of the GPIO at request time is always
> set to logical off (high or low depending on whether it is an
> active high or low GPIO). Since the GPIO is requested as an output,
> the GPIO will be driven low for a short period of time, which leads
> to a flickering display in the above use-case.
>=20
> Initialize the GPIO depending on the default-on property to be
> logical on or off.
>=20
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/video/backlight/gpio_backlight.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/bac=
klight/gpio_backlight.c
> index 5fbbc2e..1813441 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -89,6 +89,7 @@ static int gpio_backlight_probe(struct platform_device =
*pdev)
>  	struct backlight_device *bl;
>  	struct gpio_backlight *gbl;
>  	struct device_node *np =3D pdev->dev.of_node;
> +	unsigned long flags =3D GPIOF_DIR_OUT;
>  	int ret;
> =20
>  	if (!pdata && !np) {
> @@ -114,9 +115,12 @@ static int gpio_backlight_probe(struct platform_devi=
ce *pdev)
>  		gbl->def_value =3D pdata->def_value;
>  	}
> =20
> -	ret =3D devm_gpio_request_one(gbl->dev, gbl->gpio, GPIOF_DIR_OUT |
> -				    (gbl->active ? GPIOF_INIT_LOW
> -						 : GPIOF_INIT_HIGH),
> +	if (gbl->active)
> +		flags |=3D gbl->def_value ? GPIOF_INIT_HIGH : GPIOF_INIT_LOW;
> +	else
> +		flags |=3D gbl->def_value ? GPIOF_INIT_LOW : GPIOF_INIT_HIGH;
> +
> +	ret =3D devm_gpio_request_one(gbl->dev, gbl->gpio, flags,
>  				    pdata ? pdata->name : "backlight");
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "unable to request GPIO\n");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
