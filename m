From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 17:35:30 +0000
Subject: Re: [PATCH 4/5] fbdev: omap2: panel-dpi: allow specification of a reset gpio
Message-Id: <5671A0E2.7000909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wNEQMtbBJum5mcjmRVQT4k8XQEfVDQ4LS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-4-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-4-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--wNEQMtbBJum5mcjmRVQT4k8XQEfVDQ4LS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 10/12/15 15:11, Uwe Kleine-K=C3=B6nig wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Some displays have a reset input. To assert that the display is
> functional the reset gpio must be deasserted.
>=20
> Teach the driver to get and drive such a gpio accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/video/panel-dpi.txt | 1 +
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c    | 7 +++++++
>  2 files changed, 8 insertions(+)

DT changes should be posted to devicetree@vger.kernel.org. And, I think,
the binding document changes are usually as a separate patch.

> diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Do=
cumentation/devicetree/bindings/video/panel-dpi.txt
> index a40180b05bab..1a1d8f6f884f 100644
> --- a/Documentation/devicetree/bindings/video/panel-dpi.txt
> +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
> @@ -7,6 +7,7 @@ Required properties:
>  Optional properties:
>  - label: a symbolic name for the panel
>  - enable-gpios: panel enable gpio
> +- reset-gpios: GPIO to control the RESET pin
> =20
>  Required nodes:
>  - "panel-timing" containing video timings
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index 1216341a0d19..7e2f9e0813dc 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -32,6 +32,7 @@ struct panel_drv_data {
>  	int backlight_gpio;
> =20
>  	struct gpio_desc *enable_gpio;
> +	struct gpio_desc *reset_gpio;
>  };
> =20
>  #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev=
)
> @@ -83,6 +84,7 @@ static int panel_dpi_enable(struct omap_dss_device *d=
ssdev)
>  	if (r)
>  		return r;
> =20
> +	gpiod_set_value_cansleep(ddata->reset_gpio, 0);
>  	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
> =20
>  	if (gpio_is_valid(ddata->backlight_gpio))
> @@ -211,6 +213,11 @@ static int panel_dpi_probe_of(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(ddata->enable_gpio))
>  		return PTR_ERR(ddata->enable_gpio);
> =20
> +	ddata->reset_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +						    "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(ddata->reset_gpio))
> +		return PTR_ERR(ddata->reset_gpio);
> +
>  	ddata->backlight_gpio =3D -ENOENT;
> =20
>  	r =3D of_get_display_timing(node, "panel-timing", &timing);
>=20

This looks a bit odd to me. This only ever sets the reset gpio to 0, on
panel enable. If we never toggle the reset, it could be set to 0 at
probe time, right?

Reset is a bit tricky. I've seen panels where you have to have only a
short reset pulse (reset high, wait a short time, reset low). If you
leave the reset high, the panel draws extra power.

So I think the best we can do in a generic way is just to ensure the
reset is not asserted.

 Tomi


--wNEQMtbBJum5mcjmRVQT4k8XQEfVDQ4LS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcaDiAAoJEPo9qoy8lh71tXgQAKyfVj/f5oKsvJSOymvr5EjI
OsjPm+/oyNOa62VoaP+6sa8CCE+vLlIIT2Hwkud9ZECkyoHs+/FxCDtMVl62GB35
ITQDlW0UhWG3za3+EdIEjwdT1UsxSwOms/LvPZVTj7cRifnNwz5h0PVflD0Q052R
HF4b1qhn+hGVcF2X2kxXlg2t8nyiQio63EGoj/wP/XHQuezG8yvedeR22AbPIzCM
MTK+5Qw1AkrJIzVX3spdAZ3qFoSnlLG5Rss8gcHqwV17Wo65fkh5jrqGoC3a/UE3
P5WA9C36lad1PcQcW72ZEvrQ1Wp23bUc4ah6PWmLuG+hH311iC26HvbvUFHvnwYB
QgcPboPU6OHCRVkQz/LOdAobDWCBG96f9j/hoTpx53NC8bd8vm9jtbwJPjwgvEYo
LeRYsDbiXbzbHP4h8yFsvK4gFah7RCnWjen0QLpwyMMSbYCKAtsbkBLSkFs33jcr
J4uHeAq56bMTn8ZMzqKf/ZQmSC/SvPBNx7I5rJN4wgoR1qK3z4WY0KYAjzrOEb8J
LEnRgC6Ioy6sXomnN0nqFVKUwEBdSMkHz2NohX84CokfIsCbX8eaq7MWYjoWGJrS
2YIbry54JGeMfGlwQv5l2Xx3bdc1bVWAySHRTqdepBqw/Cwbtl5hpXtzLz0Yx4Oz
aPaevZR6/+x4lRmnVSlR
=NgIK
-----END PGP SIGNATURE-----

--wNEQMtbBJum5mcjmRVQT4k8XQEfVDQ4LS--
