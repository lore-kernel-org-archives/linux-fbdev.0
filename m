From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 09 Feb 2015 09:03:38 +0000
Subject: Re: [PATCH 6/8]  fbdev: ssd1307fb: Add module parameter to set update delay of the  deffered io.
Message-Id: <20150209090338.GY2079@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8a48p4KKsB+A/3VY"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1423261694-5939-7-git-send-email-niederp@physik.uni-kl.de>
 <20150207112627.GP2079@lukather>
 <20150207171211.773dc996@maestro.intranet>
In-Reply-To: <20150207171211.773dc996@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


--8a48p4KKsB+A/3VY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 07, 2015 at 05:12:11PM +0100, Thomas Niederpr=FCm wrote:
> Am Sat, 7 Feb 2015 12:26:27 +0100
> schrieb Maxime Ripard <maxime.ripard@free-electrons.com>:
>=20
> > On Fri, Feb 06, 2015 at 11:28:12PM +0100, niederp@physik.uni-kl.de
> > wrote:
> > > From: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > >=20
> > > This patch adds the module parameter "delaydivider" to set delay
> > > for the deferred io. Effectively this is setting the refresh rate
> > > for mmap access to the framebuffer. The delay for the deferred io
> > > is HZ/delaydivider.
> >=20
> > So this is actually a refresh rate?
> >=20
> > Maybe you could expose it as such, and pass a frequency in Hz as an
> > argument.
>=20
> Good idea! I'll try to do it that way.
>=20
> >=20
> > Exposing the divider directly has some issues, since the bootloader
> > that set the parameter won't know the HZ value, you'll end up with
> > different rates for different configurations, without any way to do
> > something about it.
> >=20
> > >=20
> > > Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > > ---
> > >  drivers/video/fbdev/ssd1307fb.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/video/fbdev/ssd1307fb.c
> > > b/drivers/video/fbdev/ssd1307fb.c index 1d81877..b38315d 100644
> > > --- a/drivers/video/fbdev/ssd1307fb.c
> > > +++ b/drivers/video/fbdev/ssd1307fb.c
> > > @@ -44,10 +44,14 @@
> > >  #define	SSD1307FB_SET_VCOMH		0xdb
> > > =20
> > >  #define BITSPERPIXEL 1
> > > +#define DELAYDIVIDER 20
> > > =20
> > >  static u_int bitsperpixel =3D BITSPERPIXEL;
> > >  module_param(bitsperpixel, uint, 0);
> > > =20
> > > +static u_int delaydivider =3D DELAYDIVIDER;
> > > +module_param(delaydivider, uint, 0);
> > > +
> >=20
> > You're breaking the existing behaviour.
>=20
> True! I'll try to keep the existing behaviour when rewriting this to
> use the refresh rate.
>=20
> >=20
> > >  struct ssd1307fb_par;
> > > =20
> > >  struct ssd1307fb_deviceinfo {
> > > @@ -312,7 +316,7 @@ static void ssd1307fb_deferred_io(struct
> > > fb_info *info, }
> > > =20
> > >  static struct fb_deferred_io ssd1307fb_defio =3D {
> > > -	.delay		=3D HZ,
> > > +	.delay		=3D HZ/DELAYDIVIDER,
> > >  	.deferred_io	=3D ssd1307fb_deferred_io,
> > >  };
> > > =20
> > > @@ -601,6 +605,7 @@ static int ssd1307fb_probe(struct i2c_client
> > > *client, info->fix =3D ssd1307fb_fix;
> > >  	info->fix.line_length =3D par->width * bitsperpixel / 8;
> > >  	info->fbdefio =3D &ssd1307fb_defio;
> > > +	info->fbdefio->delay =3D HZ/delaydivider;
> >=20
> > That won't work with multiple instances of the same driver
> > unfortunately.
>=20
> Could you please elaborate why? I'm not seeing it...

On a general basis, because the structure is shared by all the
instances of the driver, so it's usually not such a good idea to mix
the static declaration of the structure and the dynamic one.

=46rom a more fundamental point of view, because this parameter will
most likely be different from one instance to another?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--8a48p4KKsB+A/3VY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU2HfqAAoJEBx+YmzsjxAglIQP/jxmGs/rvwLaqTwr9D7gqxpJ
LRgWPyFz2bOiRcWWYwgtMjQQWiSgwQcpAX5xW0GpsWrRSoChXJWOm512OL08ODv8
Q7mvhl02wZatXUm3eKOaRgD95ZlC3RTABIOnJ4hYv7Ip1DtD4q0APRpSXa7uyxJX
mD/suUTCREuadUpHc42oxUT5EaHaAMTAvzg28o6+/v64FMA1nfDF54DS9YakOpce
DJnt5E7FGkklNord46CV0RlsPjKj/AqOU0QSZkzia8nzfDFB5UN87Igr4UTi4nsP
lVk9fK9s5yo9Uc7vlzJWbA9X/SnmwsG4dc/sw7geBsU3QxU7FGvLuBOrjCPhkSMC
at+8+MeefwlYOmJ8OrFwn+mQ7DolgWX0gYkBCl+1Ts1DLd08AU97yGdOiuL3Y3zs
vgXGrZcLgysdAuYgAa1b/tOGuQAM6/ho5OdVPufU9WW3PDZAbCdfLNjbMewvvaDm
TRTf+0spWVV/ejs293obIQZZs1tNWtCHcOfIH3Z+vI5w+IGJpUzzjFA5oT7rpOeM
5GbB3ANS1ajL3JhxZYzIW0tzEC9dWoq9zMuVsvCHvtxYMCvcSHRPTPc8Zz0VSnbo
Bgn3Dl3M/8x7xpYb9pIM60/d8a+vDf1PWZFMDbOryeSkSRNorWkviJeIDwFkWZ6S
y/DN6YT5PSgubMryilsf
=RBDe
-----END PGP SIGNATURE-----

--8a48p4KKsB+A/3VY--
