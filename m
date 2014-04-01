From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Apr 2014 09:14:42 +0000
Subject: Re: [PATCH] video: da8xx-fb: Add support for Densitron 84-0023-001T
Message-Id: <533A8382.7070603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5WcMEqgm29hEBKNQEq3u5xcd7xKmwcESq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394042711-7907-1-git-send-email-jon@ringle.org>
In-Reply-To: <1394042711-7907-1-git-send-email-jon@ringle.org>
To: jon@ringle.org
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>

--5WcMEqgm29hEBKNQEq3u5xcd7xKmwcESq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/03/14 20:05, jon@ringle.org wrote:
> From: Jon Ringle <jringle@gridpoint.com>
>=20
> Signed-off-by: Jon Ringle <jringle@gridpoint.com>
> ---
>  drivers/video/da8xx-fb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index e7f5937..83c43b2 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -243,6 +243,20 @@ static struct fb_videomode known_lcd_panels[] =3D =
{
>  		.sync           =3D FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>  		.flag           =3D 0,
>  	},
> +	[3] =3D {
> +		/* Densitron 84-0023-001T */
> +		.name           =3D "Densitron_LCD",

I think the name should be a bit better. Why it is not something like
"Densitron_84-0023-001T", which is the style the other panels use?

 Tomi



--5WcMEqgm29hEBKNQEq3u5xcd7xKmwcESq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTOoOCAAoJEPo9qoy8lh71D9sP/3QXO/iKaz2KCNEF3+TW60Z9
2U26Q83LAxbjuDySvd/+q0XxOik+nmNwhzxy2EIOc1fY+/6AvA5O7Tt5whUHeo8m
Vh9UGjyVwNmFlKucoLfBuWXZZhyYU1q1Bw75C+cishkDteSiOjIk/f+hN2RS+WG/
qEffASyz8JpJi6EuFSFbzzssp0NLdqMbxOLScaH5Hth5On7q+yZAYxh43qc5w5tD
EoS3ysq6PShN9xuotOY8l8/2a+rX5FU7gsWEl+799OHF1TEw2hL1ugGkp0/6D8do
3219i2q4P5r5S+oARi/n9bGkcCtjDAEtUuQM3/6TjyB1jxNikkYPzjf57FXkU5qt
GStu9nYNU30Q3XV9sxxRF+VT7QUvgp+sIgWrJwJ4MnV9MHo8PJvx/Vz2V5vVd6U7
zZ6xbJMW725W61JiuWc86hw469y8/PMIQST/bffBH3zvSK6MA+CTh7qebDyfavu6
So23BbUluIPvlF39x1spCihomhl32uBLjAchIiuNVgW3JMZRrgHYKHreUERTBNU9
tyCSKTRXH5tHN5wjJlUcsqd2S0YDS+jUzZcSCaDtrSq11d8XC4k7u3Y+lGj0iMo3
7Q8sDoowOUNs3E/iTSQ2WsgcsVGUC7ptCriaXHkOE4MACR+9fLx2npdvs29EViLx
BfAkzlWAKnkuBwxV0J0d
=0E9e
-----END PGP SIGNATURE-----

--5WcMEqgm29hEBKNQEq3u5xcd7xKmwcESq--
