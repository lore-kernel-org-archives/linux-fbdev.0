From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 17:29:17 +0000
Subject: Re: [PATCH 3/5] fbdev: omap2: panel-dpi: drop assignment to local variable
Message-Id: <56719F6D.3060800@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1XloPwP1Fj4RDHsoRLoqsCPWkJMuuQmh7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--1XloPwP1Fj4RDHsoRLoqsCPWkJMuuQmh7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/15 15:11, Uwe Kleine-K=C3=B6nig wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> The variable gpio is only used to store the return value of
> devm_gpiod_get_optional just to assign it to a member of the driver
> data.
>=20
> Get rid of this local variable and assign to driver data directly.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index e780fd4f8b46..1216341a0d19 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -205,13 +205,11 @@ static int panel_dpi_probe_of(struct platform_dev=
ice *pdev)
>  	int r;
>  	struct display_timing timing;
>  	struct videomode vm;
> -	struct gpio_desc *gpio;
> =20
> -	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW)=
;
> -	if (IS_ERR(gpio))
> -		return PTR_ERR(gpio);
> -
> -	ddata->enable_gpio =3D gpio;
> +	ddata->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> +						     "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(ddata->enable_gpio))
> +		return PTR_ERR(ddata->enable_gpio);
> =20
>  	ddata->backlight_gpio =3D -ENOENT;

I usually try to avoid writing bad values to fields. Here
ddata->enable_gpio may get an error ptr. It probably doesn't matter as
we bail out right away, but still. If devm_gpiod_get_optional's return
value would be NULL or valid gpio_desc*, then it'd be fine.

And the code is shorter (more readable) when using just "gpio" instead
of "ddata->enable_gpio".

So I'll leave this one out.

 Tomi


--1XloPwP1Fj4RDHsoRLoqsCPWkJMuuQmh7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcZ9tAAoJEPo9qoy8lh71MIwP/2nUZOT4qiq4wgvy7c9hBK1h
ifnDGTLVwgFYi7gCMWP+fMJfpDbXR5/uzNlJg0wx8u9Pk3fJ8MUrGLW4UySans7I
vYNSiyzcyrMcSqSSowTSO+ylmBnd20tO6JaBpKHPfP0Gb27SGEkhHdaWBiSLSIU9
W+HixYfIWPbtMhOtVY6YwII9GKYOqYfS0NsWNkBlJR6MHbSHd4JIvg4Ij4uUwHPh
BVSOV1iqq4BKuHbcpyYtr0KHZO063QZ9xQHekNdTrMxqXnSQKyqpIkV2NCrpPtLk
IqCBVDqW6Jrl+oOeNPVy0vjHHQoCRQAcZZX/LzohSfsSABzaS8OZT2EPZcVXLRgK
RJYzNSYTcY0xcJ3jnWCyUenNnLXwP0G8mr9SVyZo9f7By/7pACEVSaT6kzWbcspA
OBA6vy/FcJ6zjHOHf173PrXoaEmiTJ1XYl5rIc0Yw/NsCaOkVlIcD4tX+8ma+2yK
nlaJ9ice7PEfx5qR50vxrjdVK3lmsZT1uuLFvm/kCgc6o/vfkYGXL0zMBL9tHLWb
RCR49FK3h9jBAHg9gfnryXBwOYDdKNQrYmKSepsgrfEoO+ypFiehMr/1k1MhJU9r
GTe0XCPv6fOBiqRbnazmYwDFRIA+5jyCEbtJBJOmXhdjVMLin1gj1QmGZvkjKghV
FWTPbnGzQSGqc7szGa3l
=oXQQ
-----END PGP SIGNATURE-----

--1XloPwP1Fj4RDHsoRLoqsCPWkJMuuQmh7--
