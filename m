From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 17:38:57 +0000
Subject: Re: [PATCH 5/5] fbdev: omap2: panel-dpi: allow specification of a vcc regulator
Message-Id: <5671A1B1.3070504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9B58dOx6SO5pwLe17T6D3RAinVPTkDVsn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-5-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-5-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--9B58dOx6SO5pwLe17T6D3RAinVPTkDVsn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/15 15:11, Uwe Kleine-K=C3=B6nig wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> To allow supporting displays that need some logic to enable power to th=
e
> display add support for a vcc-supply property to drive a regulator.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/video/panel-dpi.txt |  1 +
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c    | 13 +++++++++++=
++
>  2 files changed, 14 insertions(+)

Same comments here about the bindings.

> diff --git a/Documentation/devicetree/bindings/video/panel-dpi.txt b/Do=
cumentation/devicetree/bindings/video/panel-dpi.txt
> index 1a1d8f6f884f..eaa39d1b1279 100644
> --- a/Documentation/devicetree/bindings/video/panel-dpi.txt
> +++ b/Documentation/devicetree/bindings/video/panel-dpi.txt
> @@ -8,6 +8,7 @@ Optional properties:
>  - label: a symbolic name for the panel
>  - enable-gpios: panel enable gpio
>  - reset-gpios: GPIO to control the RESET pin
> +- vcc-supply: phandle of regulator that will be used to enable power t=
o the display
> =20
>  Required nodes:
>  - "panel-timing" containing video timings
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index 7e2f9e0813dc..65c6d9e6862b 100644
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
> @@ -33,6 +34,7 @@ struct panel_drv_data {
> =20
>  	struct gpio_desc *enable_gpio;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator *vcc_supply;
>  };
> =20
>  #define to_panel_data(p) container_of(p, struct panel_drv_data, dssdev=
)
> @@ -84,6 +86,12 @@ static int panel_dpi_enable(struct omap_dss_device *=
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
>  	gpiod_set_value_cansleep(ddata->reset_gpio, 0);
>  	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
> =20
> @@ -107,6 +115,7 @@ static void panel_dpi_disable(struct omap_dss_devic=
e *dssdev)
>  		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
> =20
>  	gpiod_set_value_cansleep(ddata->enable_gpio, 0);
> +	regulator_disable(ddata->vcc_supply);
> =20
>  	in->ops.dpi->disable(in);
> =20
> @@ -218,6 +227,10 @@ static int panel_dpi_probe_of(struct platform_devi=
ce *pdev)
>  	if (IS_ERR(ddata->reset_gpio))
>  		return PTR_ERR(ddata->reset_gpio);
> =20
> +	ddata->vcc_supply =3D devm_regulator_get(&pdev->dev, "vcc");
> +	if (IS_ERR(ddata->vcc_supply))
> +		return PTR_ERR(ddata->vcc_supply);
> +
>  	ddata->backlight_gpio =3D -ENOENT;
> =20
>  	r =3D of_get_display_timing(node, "panel-timing", &timing);

Some panels might need to sleep before/after the regulator, but the same
goes for enable gpio. And we don't have a sane way to handle that at the
moment, so I think this is fine.

 Tomi


--9B58dOx6SO5pwLe17T6D3RAinVPTkDVsn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcaGxAAoJEPo9qoy8lh71/NwP/i5pbSeUZvi3vn3DOPhsNzb8
VDKpcESSSxotM7ABd9oJSHoxQioT++41o8EBdV/jhRnFVFlAFfwgOfRks+D0/lFv
kFtTx18eEP3YxemulkX6k9k1UIQbiBoAOWA6pVH5nWs+M/Cz5xsfYmYNx7GT+2i3
iWVhrTd0VJYlXWDM0mByXTj2VtCQtqbMyhZYLL9ObXTECha/iGuECrWly4jlUt0h
9XP66Hicdd76SzfqrT4gwtX3BMhp4Q8t4Dwcic80btiC5n3IcMzZajBXsQqt/4vq
HCIEyTdw64UTz2RUuOAXnhYEYb2+qn+V+mXk0cTEOiVc8aE9Z5XOin12AcjcTu8/
qdbvXbMPbLb0bSpp/Z/7+GE4CJpLrL4YO17di1iaLOySl/MVTIQ6z13ZT3bLVz9g
su9W7VHNPbXkAEIMDdyBsGz66HPwZpCUcviWL8N8bd7C1kc4giX2+1VpsOnrdHzK
iKLsfRh5p3DSoDDNrRr9jh7tCWQ33ZDbKH4hSIAMR8UpjmzZ7kVjVqlFXJjpMEEW
rtwzxMo8arNh3VEWUA2lYSJWTRs6coPg13Wz8tWKFHptZ3VlbhBXHve15zHmLe9N
Mk+uPN6SoZxpfdZqqKZz8FbDlc3Y6ZUQQQD/SVkM9IxOjlhwnoxsZmSr/+OIudEc
sQf7scqQI9BJbtU6ichS
=0l58
-----END PGP SIGNATURE-----

--9B58dOx6SO5pwLe17T6D3RAinVPTkDVsn--
