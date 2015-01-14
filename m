From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 14 Jan 2015 11:07:11 +0000
Subject: Re: [PATCH] fbdev: ssd1307fb: return proper error code if write command fails
Message-Id: <20150114110711.GP4891@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0EgURHJLyMzpnI9B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421223889-9448-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1421223889-9448-1-git-send-email-prabhakar.csengg@gmail.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, LKML <linux-kernel@vger.kernel.org>


--0EgURHJLyMzpnI9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for doing this,

On Wed, Jan 14, 2015 at 08:24:49AM +0000, Lad, Prabhakar wrote:
> this patch fixes ssd1307fb_ssd1306_init() function to return
> proper error codes in case of failures.
>=20
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 54 ++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 40 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index f4daa59..528ea16 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -320,7 +320,9 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_pa=
r *par)
> =20
>  	/* Set initial contrast */
>  	ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
> -	ret =3D ret & ssd1307fb_write_cmd(par->client, 0x7f);
> +	if (ret < 0)
> +		return ret;

A newline here (and to all the subsequent changes) would be great.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--0EgURHJLyMzpnI9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtk3fAAoJEBx+YmzsjxAgO+oP/2ajS6vjScxanSvvRrzrJm/o
RoKUlgcnGck3wORAsvs2dT5qCZm63ngECDtKitsDZwGsWR0HNSIaZhH+BrycGved
Ie06Ya5JhAdVtNbNBpgM+387kvKouLpU3DmU2vgdbbkNYbTC4JdaBrFM6kmDGfnC
3iJPGurA3tJeEtFKToYEfQNPHDzm8oNElsxvshWCLBCnrsWspsOVxBj+M03N39Tj
Liz9JKJ85Bci5XCsuirMvF2lIJZozQtE758ChJSjOX2mqdLnGTfAFj3HU6IB+tjK
4qTUw7XevbfGBJbLaCBDnSNPEnkw9Df9yl8weOIWQ79eQfqdkBxwd9thbzb63u0A
MYRCs0TQcMd45p/hoiUkzVNLhSoo3M5yFqFrN8781LHvioDGydKkb46qodOKvx4E
PiE19xqt01YrISJlqCEWNrVlboRrKqOWTat7tEym8K9NJ/7vmyK6kmAaHOW+pZMz
jEw3DLAJwz6fywSU4Nz6N9Cvt+qeb1flZvjb7nxfofOKMOWvkcSYXA7XuuRk4Tne
icDR0F5ZQYXNgXzBq16xPbx2f12PKmYqOQB1v6QRyY3xM+1xzqNpxPJwwULHSL3Y
nwUT6yKnYlUqa3mjEkHUbrN/xG9UI651KDqmdBxCmvYi5ZzvavYJGBN3Mil6/fIg
7PFZQWAD4651pi2Sty6J
=CJ2z
-----END PGP SIGNATURE-----

--0EgURHJLyMzpnI9B--
