From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 07 Oct 2014 08:35:49 +0000
Subject: Re: [PATCH] pwm-backlight: Turn off pwm backlight in probe
Message-Id: <20141007083548.GD24254@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="osDK9TLjxFScVI/L"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1412623364-14583-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 09:22:44PM +0200, Markus Pargmann wrote:
> The backlight will be enabled by the panel again if it is used. So we
> can save the default brightness and disable the pwm backlight when
> probing.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 336b83be7e2d..b4f433a6f106 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -317,9 +317,11 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  		data->dft_brightness =3D data->max_brightness;
>  	}
> =20
> -	bl->props.brightness =3D data->dft_brightness;
> +	bl->props.brightness =3D 0;
>  	backlight_update_status(bl);
> =20
> +	bl->props.brightness =3D data->dft_brightness;
> +
>  	platform_set_drvdata(pdev, bl);
>  	return 0;
> =20

It would be nice if it was that easy. But we can't do this, because it
will regress for users of this driver that don't use a panel or DRM. If
the PWM backlight driver is used for example in conjunction with a plain
fbdev driver it isn't necessarily hooked up with anything and won't be
enabled automatically. That's really bad if fbdev is the only output you
have since you'd have to blindly type the commands to enable the
backlight. Furthermore disabling backlight isn't always what you want to
do. For example if the bootloader already turned it on and you hand over
=66rom bootloader to kernel in a seamless way, then you absolutely want to
keep backlight on all the time.

See also[0] for a different proposal to solve the same problem. Back at
the time that received only a very few replies, but it would be nice if
Lee and Bryan could look at it again and see if we can come up with some
way to deal with this situation.

Thierry

[0]: https://lkml.org/lkml/2014/7/31/259

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM6XkAAoJEN0jrNd/PrOhzasP/RWG6pF1mOMyZ0ExtEgVDMD0
c9Ei+s3wIy4Xz5uxHybo+UkQ6ScnW/BQqAhoXCLTsvKFNrOqc+VtopHFFg/OiqkN
IjVUek9WTUXoRzwZOXkUBnP6YOS5YVXMlJH/Sx2ulSwqwrqSwLiMEzZ7yPYge6d9
GRzcGExvVB6s86J4ujF1k2etnbPL3SDOL9ZfKej4lOE0jC0OEEJZQAjx+vKpQPVA
/fytvdrY696eyYHS9M+llefcEqdyk5ZVDVaAmmncd5coz+jLt7jnvccZu0Ru6pMY
b0EUXUvX3qaRo9bua9RmzKksXpDFNlo5fXEJw6CAaw1dCCQaeBMehQ+aTGF16jj4
a05vl0jG4sDSbni+lJxITVOxr/AWQVk06WCQt2GcmNUXIrABRrJWiFP1ukmwgSZy
ScBFdap7LP6hu/Is4cqxASrChDYxAB8H5nhonP3Ff++T+yRJfFrJe4NMEv4B3AKq
fWBFScaHS4VD0ebuq25V4ydIAaNcMSZRPfCSjh/U60+wf1c8M9oVbSAkTAzHOD9F
/bwDZctO5GdLueADCxsSRaCDfCntEWmWtKOQJwsSbsUAYwdXJiCdso1uaSIkWk+s
VvpkaAt9mcU5kbRDzUXdHYdCwZoDRvhxeE7+1liACrqVRxpqZHLMwtS/y82Mli9G
cdxWSoaaC+pIdfLgGhDU
=E/Oy
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
