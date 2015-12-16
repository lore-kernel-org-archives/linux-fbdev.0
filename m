From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 16 Dec 2015 17:16:21 +0000
Subject: Re: [PATCH 2/5] fbdev: omap2: panel-dpi: simplify gpio setting
Message-Id: <56719C65.6080802@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="29hHOrnLHhKXSBTrDReIKHmqiqTkTknpf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-2-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-2-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--29hHOrnLHhKXSBTrDReIKHmqiqTkTknpf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/15 15:11, Uwe Kleine-K=C3=B6nig wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> gpiod_set_value_cansleep is a noop when the passed descriptor is NULL.
> So there is no need to duplicate the check for NULL; just call the
> function unconditionally instead.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index 06b6e611e4b2..e780fd4f8b46 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -83,8 +83,7 @@ static int panel_dpi_enable(struct omap_dss_device *d=
ssdev)
>  	if (r)
>  		return r;
> =20
> -	if (ddata->enable_gpio)
> -		gpiod_set_value_cansleep(ddata->enable_gpio, 1);
> +	gpiod_set_value_cansleep(ddata->enable_gpio, 1);
> =20
>  	if (gpio_is_valid(ddata->backlight_gpio))
>  		gpio_set_value_cansleep(ddata->backlight_gpio, 1);
> @@ -105,8 +104,7 @@ static void panel_dpi_disable(struct omap_dss_devic=
e *dssdev)
>  	if (gpio_is_valid(ddata->backlight_gpio))
>  		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
> =20
> -	if (ddata->enable_gpio)
> -		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
> +	gpiod_set_value_cansleep(ddata->enable_gpio, 0);
> =20
>  	in->ops.dpi->disable(in);
> =20
>=20

Thanks, queued for 4.5.

Tomi


--29hHOrnLHhKXSBTrDReIKHmqiqTkTknpf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcZxlAAoJEPo9qoy8lh713EkP/AmhbD++kb51NmFjqZ3gEhP1
5ZmH+Hh9L995AKokugnhAbTlAthwQoOt/pUfsqg4IwRBF3ktniN3njSFEiEa8NDD
p6KNMTjSt9vLEZsSR2Vd0bRcw3TBVB/cPYkFfGm9d4rMM0wvMMyFBs16mSVQqE9m
Y8a+HPMFZvYnmIxyz8qDgjK8OqRG6T71IZ0631+ks0/JfJSv/RvXuhna/BoUcEGl
qMFNi0dipKf+/djScoUi4XnU4YlSRqbniIPnH011y8SXzQmMb2+yTI8ubmWT69Q+
bea8p1ClFuGsvHPXvXDV/IHNlDegmrtcTCZCVBNF5ma1O08qeXqq+GR8WS8az8+c
2TfKJfY5Huac2NMl94OlA51tk2V8e/jYQu9XktrbbDfNVXzlhukhREYntMVaU/lF
iOYG2PJGteSL/686oFURDf835FO3HS/EHlrE4PY0I3BgbnsUiSmQ8/oZzUtyMf80
dYZVasAhw1YgGeDESFgtyfX7AMY0clESGzOB6hRYH16l09lI1J8Pv3048fE/gPq/
2HZih4+8XJvhHGkbMLRWHNuk2AmvDO49I3P8Hwpu5z3PnaEHXmTJTfT2ki8MVO0Y
WHueux5ZMdt4N9llXEnjkvakJ2YLjRhU/HCeF0d6frk5SDBOwHO5xSgoYZ+Zq6cv
HHFNKlUJlcA7pbuI7u3S
=nH3H
-----END PGP SIGNATURE-----

--29hHOrnLHhKXSBTrDReIKHmqiqTkTknpf--
