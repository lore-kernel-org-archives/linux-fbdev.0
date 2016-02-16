From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Feb 2016 13:00:00 +0000
Subject: Re: [PATCH v2 3/3] fbdev: omap2: panel-dpi: implement support for a vcc regulator
Message-Id: <56C31D50.1070501@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xLKcG8hCqMpCoCPxUOhifVL174OnBrgkD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--xLKcG8hCqMpCoCPxUOhifVL174OnBrgkD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/12/15 13:13, Uwe Kleine-K=C3=B6nig wrote:
> To allow supporting displays that need some logic to enable power to th=
e
> display try to get a vcc-supply property from the device tree and drive=

> the resulting regulator accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1, sent with
> Message-Id: 1449753107-11410-5-git-send-email-uwe@kleine-koenig.org:
>=20
>  - split out dt binding changes
>  - reword commit log
> ---
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index 201a1c1a6f42..8c3f31ebff00 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> +#include <linux/regulator/consumer.h>
> =20
>  #include <video/omapdss.h>
>  #include <video/omap-panel-data.h>
> @@ -32,6 +33,7 @@ struct panel_drv_data {
>  	int backlight_gpio;
> =20
>  	struct gpio_desc *enable_gpio;
> +	struct regulator *vcc_supply;
>  };
> =20
>  #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev=
)
> @@ -83,6 +85,12 @@ static int panel_dpi_enable(struct omap_dss_device *=
dssdev)
>  	if (r)
>  		return r;
> =20
> +	r =3D regulator_enable(ddata->vcc_supply);
> +	if (r) {
> +		in->ops.dpi->disable(in);
> +		return r;
> +	}
> +
>  	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
> =20
>  	if (gpio_is_valid(ddata->backlight_gpio))
> @@ -105,6 +113,7 @@ static void panel_dpi_disable(struct omap_dss_devic=
e *dssdev)
>  		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
> =20
>  	gpiod_set_value_cansleep(ddata->enable_gpio, 0);
> +	regulator_disable(ddata->vcc_supply);
> =20
>  	in->ops.dpi->disable(in);
> =20
> @@ -223,6 +232,10 @@ static int panel_dpi_probe_of(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(gpio))
>  		return PTR_ERR(gpio);
> =20
> +	ddata->vcc_supply =3D devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(ddata->vcc_supply))
> +		return PTR_ERR(ddata->vcc_supply);

devm_regulator_get_optional()?

 Tomi


--xLKcG8hCqMpCoCPxUOhifVL174OnBrgkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwx1QAAoJEPo9qoy8lh71P3cP/jfNKLXXSz+4TYOy6BEsH15Z
mdCcyMsRztvlCLRHBT7AL5kxJkd1WJZG/Y73hWwuQQc1l3mVJHTOWQZZKNsOnIEf
dHR16QxKu+YboibAca5OUH9NPDtKucr4Zsc263EnUtSs1DeS8DBhfNaX60PVo0RX
/5y2vEMomraRDspEPZOt4ZndSZUxt2NAnAjQV4WEHWcHFP0P++AekFGAdrb73oIX
xoiObr4g5fCB2L+VSs5gLLcdjm16ASlpQHdCd/E1HEFlRqtXtb/f3K5Al5ykCJBk
NdnZvoXhgjzUTtkn8xIOpLtnqIT+ShFEWZoQzlcPAJOucGNHUSGyJWYiJ5/MULy5
8Bq7JPCniU86ZZbMQvToC/byORh8rXoxOCHCyh4JhrJaKDYonckP19xoR1vcu5HB
xGiKebWsCKK7pQgZb/gllFufk8eHtQVoF7uy8p7cd2JNTu0uyxSOWFVuHfuc+IYW
C1aFobMh1oBPnmzx5gADbdKkkpRDpgahFo/XTPoY0alimynff6DwrvELrYtqCIkn
wTe4/1wIvK6M0Ja0lakRzPvdtLAKyQGiG6L2eZoPkidMj2Rg82H6Z4A/4ZzMLpsF
QFkDlHslczSDhfCVFMIprO3c5DxgmszQIggHkOdYuhx9dpOF7jHFmE17Mo+0Ui1a
yJZL6hUwzNngwB/li1yy
=qIIY
-----END PGP SIGNATURE-----

--xLKcG8hCqMpCoCPxUOhifVL174OnBrgkD--
