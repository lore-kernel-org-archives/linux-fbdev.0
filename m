From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 03 Dec 2014 12:13:54 +0000
Subject: Re: [PATCH v3 1/3] video: omapdss: Add opa362 driver
Message-Id: <547EFE82.7020701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="c7QacRlLOPQTbFmJ1PIJ9571cdMPrfrtJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417352867-7436-1-git-send-email-marek@goldelico.com>
 <1417352867-7436-2-git-send-email-marek@goldelico.com>
In-Reply-To: <1417352867-7436-2-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org

--c7QacRlLOPQTbFmJ1PIJ9571cdMPrfrtJ
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/11/14 15:07, Marek Belisko wrote:

> +#include <video/omap-panel-data.h>

This should not be needed, as the driver is DT only.

> +static int opa362_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct panel_drv_data *ddata;
> +	struct omap_dss_device *dssdev, *in;
> +	struct gpio_desc *gpio;
> +	int r;
> +
> +	dev_dbg(&pdev->dev, "probe\n");
> +
> +	if (node =3D=3D NULL) {
> +		dev_err(&pdev->dev, "Unable to find device tree\n");
> +		return -EINVAL;
> +	}
> +
> +	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	gpio =3D devm_gpiod_get(&pdev->dev, "enable");
> +	if (IS_ERR(gpio)) {
> +		if (PTR_ERR(gpio) !=3D -ENOENT)
> +			return PTR_ERR(gpio);
> +	} else {
> +		gpiod_direction_output(gpio, 0);
> +	}
> +
> +	ddata->enable_gpio =3D gpio;

The 'gpio' may be non-null here, if PTR_ERR(gpio) =3D=3D -ENOENT. You sho=
uld
set 'gpio' to NULL in the IS_ERR(gpio) path, as you later check the gpio
for NULL.

> +static struct platform_driver opa362_driver =3D {
> +	.probe	=3D opa362_probe,
> +	.remove	=3D __exit_p(opa362_remove),
> +	.driver	=3D {
> +		.name	=3D "amplifier-opa362",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table =3D opa362_of_match,
> +	},

Here you should add:

=2Esuppress_bind_attrs =3D true,

so that the device/driver cannot be unbound via sysfs, as that's not
supported at the moment.

 Tomi



--c7QacRlLOPQTbFmJ1PIJ9571cdMPrfrtJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfv6CAAoJEPo9qoy8lh71tN4P/0o30nFCfKVDu4MFzmG3/1tF
iB3IFhlvX99Ig4lDRIJNw4yxn59WeclQOWbSb3Z3A6r4Rx1+1PFP3Frj9ro+JdFG
ixtTYfnDliR8Qtd9qOXsrVdPQT4riiYvhrcVx3Hp7ov0YrVQjaTtdxkSHZjxtOTu
dZ840qj6KW32lJb1Hlq7b1tA6UsQKPczfx23SMRwDXP8E75bIOv5yyktJtaxreJy
/hpFnPmvfRuJVOgO5jJYctj7BGc6u3kRiHQqoPEbn+rHufejxv93dh3q8deGiYXF
kIU/aAFF2rExX+8U/nPfRcwAwaSoXcfodnHMalKp6s/fL0o49ZTSDzOq3pFPXdEY
EdDRX5JWFgINWpDnO8TwAza5UgICW59jBxRxh9yMgH4Tozd52K01Qu12yls4OZDH
h39/fY01ajm9qvaIZcVVg3E3J+zeQCPDSBqdir1kJ6B9KWLSrPlyNS1BtA3IcOug
GDdMN3xqRsTay5V8sxyuVIBFYnJKXoZZTANCqoFVeBUOU7RiHxvQfowPG3EfxK7v
MlcH1jzBG3hOvwYFbi0hIQPSR9/5dK4lNX2S/X5Gt7NKFUAOeN1dLEfJDcjUAFPX
IxLdVEuhtj+fd2pSdtWpdTAAD3Q/RCdMtlzAy9VReYnJUFEJojITkUCRR8JzzhRR
56bgD/4aSyciNOy4dHyU
=SV7u
-----END PGP SIGNATURE-----

--c7QacRlLOPQTbFmJ1PIJ9571cdMPrfrtJ--
