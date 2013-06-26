From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 07:58:54 +0000
Subject: Re: [PATCH 10/23] video: da8xx-fb: fb_set_par support
Message-Id: <51CA9F3E.1020100@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2NRTTDIGBXLJIHQHCWJED"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-11-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-11-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2NRTTDIGBXLJIHQHCWJED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> fb_set_par helps in runtime configuration of lcd controller like
> changing resolution, pixel clock etc. (eg. using fbset utility)
>=20
> Reconfigure lcd controller based on information passed by framework.
> Enable raster back if it was already enabled.
>=20
> As fb_set_par would get invoked indirectly from probe via fb_set_var,
> remove existing lcdc initialization in probe and do lcdc reset in
> probe so that reset happens only at the begining.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   60 +++++++++++++++++++++++++++++++++++++-=
-------
>  1 files changed, 49 insertions(+), 11 deletions(-)
>=20

<snip>

> @@ -1201,9 +1201,52 @@ static int da8xx_pan_display(struct fb_var_scree=
ninfo *var,
>  	return ret;
>  }
> =20
> +static int da8xxfb_set_par(struct fb_info *info)
> +{
> +	struct da8xx_fb_par *par =3D info->par;
> +	int ret;
> +	bool raster =3D da8xx_fb_is_raster_enabled();
> +
> +	if (raster)
> +		lcd_disable_raster(true);
> +	else
> +		lcd_disable_raster(false);

Not actually part of this patch, but: that kind of functions are quite
unclear. What does disable(true) mean? You have to read the function to
understand the call.

I think it'd be much better to take the wait-for-frame-done code out
from the lcd_disable_raster function, and call the wait function
explicitly here in the if (raster) block.

 Tomi



------enig2NRTTDIGBXLJIHQHCWJED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyp8+AAoJEPo9qoy8lh71ZAAP/2Cq+hlyADhXGJ4+gsudNS4W
a1N4N4dYSTRzKPMzzZ59tyjOtr7mWJTDR0804kXHlGl1WZSx3YmjtFkpSa2+dXsv
SgrIzBDAl0x7JhSVt8xpx0ZYN/i9kMQk0Oxqp0N2uK31G1SfJPThUqb6WGetfUMk
bboB1ZTZ+Zgu0A4gLtgT2ZJCfkVHjNNpcHkNWBsaQWC903jdMU1stPjG/ZloTr3f
R6Mw/eznDwU/Eqii8Jh6McPJfCddn5V4AHr+KLI9Ke7Koc2+RGZnFKvZ9p+VaYw/
tWWwvPUwphLSUv1VdarYb5HLP7sjTu9DdTtE9W/NaPvcHC/Oc7UnmdXxqwjU03/b
UTuQcDsfTtyhSS+h5GUSQBfQ9Iip+YCJwVtRGogE8YFF5OuriYNylLl+PvaZkb0Q
MKh4dsyDNbitLPRNKX0j3WUL8q5UJ+7cRVrICe97G8VDoc3kuADGDSo/qhvCpf1j
sJDrV/cAzejSSCYxMqFI7m1jI6vPRlNB40/aemrApT2VuL05UWetiuyrXD21Fxy+
tBA6dNA8PTY3bEixa+nQMm+vD/WoDb7WzCCkLkuABBFsdBNBMtciXspp8epYgtsX
dKaHj+oPopbFkkR+XvFiOvLFUmMc6p9aiZ06vRmzG0JKMQOWImwdBhYRbIODCyUd
UD4VZcQgCH6N1hGHdFK2
=E9ze
-----END PGP SIGNATURE-----

------enig2NRTTDIGBXLJIHQHCWJED--
