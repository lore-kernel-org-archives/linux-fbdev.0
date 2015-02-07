From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Sat, 07 Feb 2015 11:26:27 +0000
Subject: Re: [PATCH 6/8]  fbdev: ssd1307fb: Add module parameter to set update delay of the  deffered io.
Message-Id: <20150207112627.GP2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wqJr86X7F8PBspU2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-7-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-7-git-send-email-niederp@physik.uni-kl.de>
To: niederp@physik.uni-kl.de
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--wqJr86X7F8PBspU2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 06, 2015 at 11:28:12PM +0100, niederp@physik.uni-kl.de wrote:
> From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
>=20
> This patch adds the module parameter "delaydivider" to set delay for the
> deferred io. Effectively this is setting the refresh rate for mmap access
> to the framebuffer. The delay for the deferred io is HZ/delaydivider.

So this is actually a refresh rate?

Maybe you could expose it as such, and pass a frequency in Hz as an
argument.

Exposing the divider directly has some issues, since the bootloader
that set the parameter won't know the HZ value, you'll end up with
different rates for different configurations, without any way to do
something about it.

>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 1d81877..b38315d 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -44,10 +44,14 @@
>  #define	SSD1307FB_SET_VCOMH		0xdb
> =20
>  #define BITSPERPIXEL 1
> +#define DELAYDIVIDER 20
> =20
>  static u_int bitsperpixel =3D BITSPERPIXEL;
>  module_param(bitsperpixel, uint, 0);
> =20
> +static u_int delaydivider =3D DELAYDIVIDER;
> +module_param(delaydivider, uint, 0);
> +

You're breaking the existing behaviour.

>  struct ssd1307fb_par;
> =20
>  struct ssd1307fb_deviceinfo {
> @@ -312,7 +316,7 @@ static void ssd1307fb_deferred_io(struct fb_info *inf=
o,
>  }
> =20
>  static struct fb_deferred_io ssd1307fb_defio =3D {
> -	.delay		=3D HZ,
> +	.delay		=3D HZ/DELAYDIVIDER,
>  	.deferred_io	=3D ssd1307fb_deferred_io,
>  };
> =20
> @@ -601,6 +605,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  	info->fix =3D ssd1307fb_fix;
>  	info->fix.line_length =3D par->width * bitsperpixel / 8;
>  	info->fbdefio =3D &ssd1307fb_defio;
> +	info->fbdefio->delay =3D HZ/delaydivider;

That won't work with multiple instances of the same driver
unfortunately.

> =20
>  	info->var =3D ssd1307fb_var;
>  	info->var.bits_per_pixel =3D bitsperpixel;
> --=20
> 2.1.1
>=20

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--wqJr86X7F8PBspU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1fZiAAoJEBx+YmzsjxAgb9AP/0hmMuqG/CFuKkY4Gg1DIWPg
4StCQnllK41ShDpVoP2KJeNkC3wtvp0aTyYAG04M0IowYwjVtC+mtqATn3mp3y0S
g25T4KqFAerZwwo80OBxpMqKZzOto1AD65lQXUEgq2znHnfvK7qXMpkoQ5/sBBF7
Cw4be6kpqae/x1KnTnSSDo3SFaN8M6ocXU/1a6DmX4xsAt+9RZpJbTSe+FAlrVAz
cvoJlMWy11Nsw1Fy/86KgKuvkOgAG5jT6PatqoyIx3gcHo0HGnbn69J8b+BfTjdv
wPM+7MsC+ABugGNC+oRvKH9Lm7QtC1Bx4YwOqPb/x3cKsT4BrGf/IMD1bwFIXd0W
F5+0IavZSTs6jtI0dXDWRnz7mefT6ZNsThucPXWQ1PuM5DCJuzE1DOytzQVkZoAZ
NBFJppWqmfmwGblUvz4Hlb58EEgOkkRDPBuyush99XjkUan4fEx1KCwvcO+/3YfJ
jCpmnJtGCmlYGZz5Lk39pYCs87JhZ/K9yNUWVgHknI5AQesQSVKCzns+GZO2jzRt
M0VdEsxBDlrE7E7XE9KVrNqW2+eumOAhP3yUUEgmHACNsaITMtzSEczcUn8w3tuo
3G9N5y7dglajaiGxB1jqmheFRaiO9yhMfuxgVKMuQZ33PQWsVKA3u9QhqfdX0xu3
DB/FaHF/oDXMjx/cT2PE
=8b9x
-----END PGP SIGNATURE-----

--wqJr86X7F8PBspU2--
