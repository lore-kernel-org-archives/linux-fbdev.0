From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 08 May 2015 13:31:38 +0000
Subject: Re: [PATCHv6 05/10] ARM: mxs: fix in tree users of ssd1306
Message-Id: <20150508133138.GS11057@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6zn93sY2JrH9m7VZ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-6-git-send-email-niederp@physik.uni-kl.de>
 <554B44A7.1090007@ti.com>
 <20150507112759.GC3162@dragon>
In-Reply-To: <20150507112759.GC3162@dragon>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, Sascha Hauer <kernel@pengutronix.de>, plagnioj@jcrosoft.com, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--6zn93sY2JrH9m7VZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Thu, May 07, 2015 at 07:28:01PM +0800, Shawn Guo wrote:
> On Thu, May 07, 2015 at 01:55:35PM +0300, Tomi Valkeinen wrote:
> > Hi,
> >=20
> > On 31/03/15 21:27, Thomas Niederpr=FCm wrote:
> > > This patch updates the in tree-users of the SSD1306 controller for us=
ing
> > > the newly introduced DT properties.
> > >=20
> > > Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> > > ---
> > >  arch/arm/boot/dts/imx28-cfa10036.dts | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts=
/imx28-cfa10036.dts
> > > index b04b6b8..570aa33 100644
> > > --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> > > +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> > > @@ -99,6 +99,9 @@
> > >  					solomon,height =3D <32>;
> > >  					solomon,width =3D <128>;
> > >  					solomon,page-offset =3D <0>;
> > > +					solomon,com-lrremap;
> > > +					solomon,com-invdir;
> > > +					solomon,com-offset =3D <32>;
> > >  				};
> > >  			};
> >=20
> > Should this patch be merged separately via proper tree? I can take the
> > rest of the patches via fbdev tree. I can, of course, take this via
> > fbdev also, if I get an ack.
>=20
> @Maxime
>=20
> I assume you're the person, right?

I don't have this board right now to actually test, but the changes
look good.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--6zn93sY2JrH9m7VZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTLq6AAoJEBx+YmzsjxAguJIQAKmht+1RcFTi8apLjieGXNxt
wCGL3DCT+IxR6U9pIbtY/XJtFkK8qa/BnQvIILBz6VbHtzXqsZQIBIWrDEkL/66P
RWhXfzwwoxOHYPdPFRxLveC8edJjuNZujLJ3W2qBOnB7Gx9KYfJX0/K88bDQHa7C
czIYnOFs5UtBhV8ehiu6u3FjB+4pT0tuB/wqUIvYnspjkDw/Gf6inHfQEEc+YsSz
sFmVWb5aZKX5dQkEaLTXTWJAv23linDiC3SC1zs/8WyRAokFJSbyiobuU7GVOcvq
OUf0kdruOmonJL+tEosfGd5O5WJcfT5VaZGZ6i7YJs7Rny+Ng0Dd1NpbriMNlspa
mbTlwgBpHcAATNszqyT1SnSBnkiELHHoPo/+aNHZt34qnMbVqVnMueZ9nldL9qnO
7J7JlSXUjvUIteCDVB/5I1K10h14SrN2sdX/HAh2Znpo70ws4zBbeaEAuMyotK76
UBJVlX5BqtjC/bCFr80ZyKkKw5egkiIZpFo0UHdvI3TU+7eEVApFmqTEQ0uBLxcz
nwN00duX85frHgewXEBkPTXSyRySJF4g9MymUM+/lyYTqHF3yocyfwhkZEd+con4
/mN6DvgbTGq6vm89+wE+/55ZHv30zCRyFPxAh3hDCcRCK75D1HMzJTRWoUWeXDXP
gBPEYngH88q/mp+jGe4D
=2yqA
-----END PGP SIGNATURE-----

--6zn93sY2JrH9m7VZ--
