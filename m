From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 17:16:09 +0000
Subject: Re: [PATCH 1/5] fbdev: omap2: panel-dpi: in .disable first disable backlight then display
Message-Id: <56719C59.8070001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bjvLsd4cxm6Phjc8btKoUOjRviBidwhXI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-1-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-1-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--bjvLsd4cxm6Phjc8btKoUOjRviBidwhXI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/15 15:11, Uwe Kleine-K=C3=B6nig wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> This makes .disable operate in reverse order compared to .enable.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index f7be3489f744..06b6e611e4b2 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -102,12 +102,12 @@ static void panel_dpi_disable(struct omap_dss_dev=
ice *dssdev)
>  	if (!omapdss_device_is_enabled(dssdev))
>  		return;
> =20
> -	if (ddata->enable_gpio)
> -		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
> -
>  	if (gpio_is_valid(ddata->backlight_gpio))
>  		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
> =20
> +	if (ddata->enable_gpio)
> +		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
> +
>  	in->ops.dpi->disable(in);
> =20
>  	dssdev->state =3D OMAP_DSS_DISPLAY_DISABLED;
>=20

Thanks, queued for 4.5.

 Tomi


--bjvLsd4cxm6Phjc8btKoUOjRviBidwhXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcZxZAAoJEPo9qoy8lh713pAP/1nCLwToYeoA7RNvhQjEjDUN
+Zu8javevQV3HCnUxBM8e0so4vYuusxFz/DTBSEjAkvftiAFt9QCqOCZOfYzde64
rUGwFaArwv/uhzgD00Vcko0r8ySQfSS5Hflb0SkCYikrTvIVBWZ3jN6AGO4kIu4u
tI1mnCdDj/N+e03wfZPPscOwhdTdI9xTmtLNlj7C6YhXXsmFlmAz1s59n5A+9nfM
glOSyEwFdpXJhQyNty/CeEhbqjBkxvFK3pn029kR9iWWUOpKUkte6WROaDJnqZ/g
y5va9w7ngNDOvQQBf5LB1kfrUEu430F/ueKwZu7Pk3G3vTCUqUbNu1LXfNGw41N7
v3kl0uwQR3ywNXOox5U3vyaugWLvFK3cqVaSU5CaznDPRvBgbpDfyNfxbM6JhIbC
ilt0AKKKWmNFAerLdb//LDEMHemBYYa3nqDsbYrAgKTfaivCbL9l7xL3qWSESoBc
YF27fmAOmLQkPuJmVueCwNY55TTwSgCsbRyIOtSidwJwV8CKinlT8ogBSDQZLXJF
OYj4zt2EK7lbKfcIGFnwKIu8Br2gRYaMlFL8vQT1146uasC7CRrMqvFQka4Z6ES0
uO4U9XYN78tz+PIXutH3JxYJ6ha0ry7C7tt87fAkaN4D++NuBwoHie26vBJSEBs/
90A1nJNcxd4IPdr4jVJP
=LKFw
-----END PGP SIGNATURE-----

--bjvLsd4cxm6Phjc8btKoUOjRviBidwhXI--
