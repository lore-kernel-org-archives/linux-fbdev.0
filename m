From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 Jun 2016 12:57:52 +0000
Subject: Re: [PATCH 5/5] fbmon: remove unused function argument
Message-Id: <5762A250.6040803@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eseoLGEPkRotott6ImuhEGc6MFUmGVspk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160616113831.4108439-1-arnd@arndb.de>
 <20160616113831.4108439-6-arnd@arndb.de>
In-Reply-To: <20160616113831.4108439-6-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--eseoLGEPkRotott6ImuhEGc6MFUmGVspk
Content-Type: multipart/mixed; boundary="9Ooik3sFsei1QSpna1cIGExSCosBLSeLt"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <5762A250.6040803@ti.com>
Subject: Re: [PATCH 5/5] fbmon: remove unused function argument
References: <20160616113831.4108439-1-arnd@arndb.de>
 <20160616113831.4108439-6-arnd@arndb.de>
In-Reply-To: <20160616113831.4108439-6-arnd@arndb.de>

--9Ooik3sFsei1QSpna1cIGExSCosBLSeLt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/06/16 14:38, Arnd Bergmann wrote:
> When building with "make W=3D1", we get a warning about an
> empty stub function that does nothing but reassign its one
> of its arguments:
>=20
> drivers/video/fbdev/core/fbmon.c: In function 'fb_edid_to_monspecs':
> drivers/video/fbdev/core/fbmon.c:1497:67: error: parameter 'specs' set =
but not used [-Werror=3Dunused-but-set-parameter]
>=20
> We can simply make that function completely empty to avoid
> the warning.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/core/fbmon.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index 55e39e822b79..eaa6bab21839 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1496,7 +1496,6 @@ int fb_parse_edid(unsigned char *edid, struct fb_=
var_screeninfo *var)
>  }
>  void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *spec=
s)
>  {
> -	specs =3D NULL;
>  }
>  void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *spe=
cs)
>  {
>=20

Thanks, queued for 4.8.

 Tomi


--9Ooik3sFsei1QSpna1cIGExSCosBLSeLt--

--eseoLGEPkRotott6ImuhEGc6MFUmGVspk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXYqJQAAoJEPo9qoy8lh71h1IQAI0UI8iVRM+wOk/bonsxf4Qo
gBx2ACAIJo/8/bvgOC6/tCKjJI65qmvhGkg70K4YY2hNg/iqh7p1Eb9FcNyhAQAB
wLZ0KEqxgviGtUm5EcXn+Fh+QvesuAog4LxMsdwKAXAgJWzSt8VhtU1lTZFdtrOq
2guL2rXv4KW1q9GU37w1mZGFNO4GITLa2yXqj62GgkPcikIdeqOsDYmXTDd3oeB/
B3ae0wuNPQHXtgcIfyN+eZmtbA/VZl16lo4Cnwt0gchH9VirbDXJ02w2oQPtc2TH
mg0Qs0j3ZWOx/l+fmZ8g4uiv/feZhNsCen5odRBLzY/h9c2ZBb+vlMyzMwIgdFsd
39xe2ZaDW/Rrp75zr6OC8+Rg+LsnGyid9HdgoYTkAf99oXbFg2IgZh96KXqtfBGS
V/eZzwevd5TVpP7N0NV+hBD82qtqRj1h4wDycUjCpvoC/qQIGvbLyI6vtf2bE2Ju
euxJUJjWOBh5NxBF8bRDFFzdWyyDs7JtUX+KUBMxBAOtOgLoph8Z6mCl+wsgvQXO
qqjd/ZNU2KCRJMn8cYr4Iv1fIWYOlfRGK+rk37XmXf1XUYZodSWafngb14rOC11v
dBC4lqa0mC8Wcci4SlyACcq97fHqBH7Um8DnGFwlO7ZVR8vY8Fv8lTIPa3puN1o8
uv3iaBEZ5zLB1IjLtv4q
=gW4Z
-----END PGP SIGNATURE-----

--eseoLGEPkRotott6ImuhEGc6MFUmGVspk--
