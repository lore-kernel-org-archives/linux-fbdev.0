From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 11:04:31 +0000
Subject: Re: [PATCH] video: fbdev: pmag-ba-fb: Fix the lower margin size
Message-Id: <56D0313F.2030203@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MrM7uFvaaCcsUoBnKGDkWcq54FEalPDQi"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220109160.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220109160.7431@eddie.linux-mips.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--MrM7uFvaaCcsUoBnKGDkWcq54FEalPDQi
Content-Type: multipart/mixed; boundary="uk2PtUano8Th9u1tbAMK4RA6xBn5iUsVM"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <56D0313F.2030203@ti.com>
Subject: Re: [PATCH] video: fbdev: pmag-ba-fb: Fix the lower margin size
References: <alpine.LFD.2.20.1602220109160.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220109160.7431@eddie.linux-mips.org>

--uk2PtUano8Th9u1tbAMK4RA6xBn5iUsVM
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22/02/16 03:54, Maciej W. Rozycki wrote:
> According to the board specification[1] the width of the vertical sync =

> front porch is 12 pixels or the same as the width of the horizontal syn=
c=20
> front porch.  This in turn means the size of the lower margin is 0,=20
> because the vertical sync starts as soon as the start of the horizontal=
=20
> sync terminates the last line.
>=20
> References:
>=20
> [1] "PMAG-BA TURBOchannel Color Frame Buffer Functional Specification",=

>     Revision 1.2, Workstation Systems Engineering, Digital Equipment
>     Corporation, August 27, 1990, Table 3-5: "Video Timing"
>=20
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> ---
> linux-pmag-ba-lower.patch
> Index: linux-20150524-4maxp64/drivers/video/fbdev/pmag-ba-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-20150524-4maxp64.orig/drivers/video/fbdev/pmag-ba-fb.c
> +++ linux-20150524-4maxp64/drivers/video/fbdev/pmag-ba-fb.c
> @@ -60,7 +60,7 @@ static struct fb_var_screeninfo pmagbafb
>  	.left_margin	=3D 116,
>  	.right_margin	=3D 12,
>  	.upper_margin	=3D 34,
> -	.lower_margin	=3D 12,
> +	.lower_margin	=3D 0,
>  	.hsync_len	=3D 128,
>  	.vsync_len	=3D 3,
>  	.sync		=3D FB_SYNC_ON_GREEN,
>=20

Thanks, queued for 4.6.

 Tomi


--uk2PtUano8Th9u1tbAMK4RA6xBn5iUsVM--

--MrM7uFvaaCcsUoBnKGDkWcq54FEalPDQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0DE/AAoJEPo9qoy8lh71eq8P/0A5+a0uJeXUiXHKNfOYwnPI
uC7JQt7XHlNSJN8zBBnZgA1XEf8GvnjN+wlMdFhdmJh9Me3Vq/ci7bDuph0uUynb
LrXcuz2TiiavrKHyDSrWa3FSl4KlDfNuANs2NXTJeboHp1NXdpQpuO0/zsntAv1S
KOy28Yb9nML9F+l1PUJ05qSE+2DLj2BIc26WVdKRzkTG5IuMjPNgtzz8F0tG6si8
oKTPj2IO5Hxi3f4pIDdc80SDDwQ1SWdzyIXmDbqjIri9Ho0cS0PUkLTe1ZbubWNo
/U6tRsknhGJxttgKI8p0Srs9mYDmIJV3sEXoZHrPUE1UIh1g4mD7ZZ0zxqH3uTWk
JjDKMm2YJYVn89Et8l6VAf0cq5KUSwnZ4ZiHbzsr9pCJOKlucogk3nql9sEV7BFI
FcI1HAk8hkvWWYLBAXHK94AOIl36cofkdYun7LTirHQZS2UWP2WpkJ/dirwIZvbl
bJb/6Yla8NiWiKjjhGHDOXT6Oh7upOMNAGbLo4NJJ03XgYFHkSJXoc095gcDkVRi
jXN+YHffryqPz2HLpft9W+CqLSJvwuawtXQ82EqX2v8nuqxi1H6GALGNHqgP6MLx
2vdnkbOcwv+9GSnghnoXoqJspxjh3h7QI8uoDHHKXZg+JrK1rXwpZI3Yp83kwxQD
0bwq8F/DWy2j0ZNulCI/
=myuo
-----END PGP SIGNATURE-----

--MrM7uFvaaCcsUoBnKGDkWcq54FEalPDQi--
