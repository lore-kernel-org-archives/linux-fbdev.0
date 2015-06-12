From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 12 Jun 2015 09:34:10 +0000
Subject: Re: [PATCH] video: sm501fb: fixing static checker warning
Message-Id: <557AA792.3010506@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pDDbqRhR9QbthuuJii0BdPd1DGfb6IQOB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434028393-32224-1-git-send-email-hs@denx.de>
In-Reply-To: <1434028393-32224-1-git-send-email-hs@denx.de>
To: Heiko Schocher <hs@denx.de>, linux-fbdev@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Morton <akpm@linux-foundation.org>

--pDDbqRhR9QbthuuJii0BdPd1DGfb6IQOB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 11/06/15 16:13, Heiko Schocher wrote:
> Dan Carpenter reported the static checker warning:
>=20
> drivers/video/fbdev/sm501fb.c:1958 sm501fb_probe()
> warn: strcpy() 'cp' of unknown size might be too large for 'fb_mode'
>=20
> Fix it, as the SM501 datasheet says the SM501 can "200 MHz
> DAC support 1280x1024 resolution", which would result in a
> too long mode string for current fb_mode var.
>=20
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
>=20
>  drivers/video/fbdev/sm501fb.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501f=
b.c
> index 9e74e8f..ea50df3 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -43,7 +43,9 @@
> =20
>  #include "edid.h"
> =20
> -static char *fb_mode =3D "640x480-16@60";
> +static char *fb_default_mode =3D "640x480-16@60";
> +static char fb_mode[20];
> +static char *fb_mode_cmdline;
>  static unsigned long default_bpp =3D 16;
> =20
>  static struct fb_videomode sm501_default_mode =3D {
> @@ -1963,6 +1965,12 @@ static int sm501fb_probe(struct platform_device =
*pdev)
>  				if (info->edid_data)
>  					found =3D 1;
>  			}
> +		} else {
> +			if (fb_mode_cmdline)
> +				strncpy(fb_mode, fb_mode_cmdline,
> +					sizeof(fb_mode) - 1);
> +			else
> +				strcpy(fb_mode, fb_default_mode);
>  		}
>  #endif

I didn't look at this very closely, but it doesn't look correct to me.
The above code will only be ran if !np. Shouldn't the kernel cmdline
parameter override anything from the .dts?

Then again, that's how it works at the moment, so I guess this is ok.

 Tomi


--pDDbqRhR9QbthuuJii0BdPd1DGfb6IQOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVeqeSAAoJEPo9qoy8lh71BJYP/0Fg5FhxRhGeqBQZYxDZS9cj
vdkVdnqXV7GIJbR83LizyOCU+bNWEZIiVGEaBBs9jMcMcU8C/urDqVePRe5O3phj
MIpmTSKwHiXkuk/0EHl0ivyNIDEJpVNt41r6JWrJ7OHi4zXF49UIW8QYcOJxtb+2
0vf8MYm8G8DJlUpcfD447WULf9Ipo4LIWeNuvoJpkeeIb2s4Wn8ILC8Bug+xiJlB
vLOA+mR0VkFKOI0EloSzbBihsLG6fvfy/sKi5clcVwqJE+p9rgMkdDB3Ck6UmnYY
Y06W0qCO3ceZrdIO1pa2XpkoZJqkKMmmwrw86GCR15pozEot8KohF7/PxPidNWWS
ji4ZFdXQ0NdLYCzc+F7EE3xNqxSSDz9yW4RNmLTN8Q0qzc5IlskDOeWjb6NakZSU
3FT2urbySJmSDgzFZLWulOUIl7G0ndYSmF6zXWs6poGTGK/MH43MngwHTxy8rw/C
E/5YH+40KXJAtZHvjYq9g+a8ki601qOyaUNngcdQVCd22n4WhQ4ESXWA6RukW4RC
9NlSU78oiOSMXPcJPaMV2DGSuDdXOnNh8vxJ3hdMGy4HrNzjRhZRanAw6a7ji7ba
azCGnEE2xn5oCIW7H4i6h36CKVpJi31GWOq1yFbunQfCziFJI+SqRV+5RuyPL7fV
qbj504ck/04OwfPFCGEP
=42YP
-----END PGP SIGNATURE-----

--pDDbqRhR9QbthuuJii0BdPd1DGfb6IQOB--
