From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 24 Mar 2015 15:24:58 +0000
Subject: Re: [PATCHv4 04/10] fbdev: ssd1307fb: Unify init code and obtain hw specific bits from DT
Message-Id: <20150324152458.GD4951@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ylS2wUBXLOxYXZFQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-5-git-send-email-niederp@physik.uni-kl.de>
 <20150318192719.GV4638@lukather>
 <20150320221254.2cc5f502@maestro.intranet>
In-Reply-To: <20150320221254.2cc5f502@maestro.intranet>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 10:12:54PM +0100, Thomas Niederpr=FCm wrote:
> > >  static const struct of_device_id ssd1307fb_of_match[] =3D {
> > >  	{
> > >  		.compatible =3D "solomon,ssd1306fb-i2c",
> > > -		.data =3D (void *)&ssd1307fb_ssd1306_ops,
> > > +		.data =3D (void *)&ssd1307fb_ssd1306_deviceinfo,
> > >  	},
> > >  	{
> > >  		.compatible =3D "solomon,ssd1307fb-i2c",
> > > -		.data =3D (void *)&ssd1307fb_ssd1307_ops,
> > > +		.data =3D (void *)&ssd1307fb_ssd1307_deviceinfo,
> >=20
> > Do we need this ID? Wouldn't it make more sense to pass the pointer to
> > the struct we need to use?
>=20
> Are you talking about the device_id inside the struct
> ssd1307_deviceinfo?

Yes.

> I need the device_id to serve special needs of the individual
> controllers during initialization. For example the ssd1307 needs to
> set up the pwm in the init code.

Then you can add a bool in the structure to say whether it needs a PWM
or not.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEYHKAAoJEBx+YmzsjxAgFgkQALYiBZGdXfL7g1q3sMgfey9S
oqSF+rXWtDgszVChIQjIOk5yL74uf8I9D4w4v3DA9T4KYgocPLbmJZd9AQzNp5Bu
vekmBTKk/HPKDZ3K0ezezZDdIEGPpaPlRywkp6y/wft34t1ckrFhuxao2yy73Pzp
NVRVurgO3wjlWzVIhcmIra4VBmGqQQexhDCTx976938dQDYMBVRzVQwd/HGaZI7V
0PCXeea72uOKkjiIvynE2C30BCCYpPZFOcoR+QDJNUHLWM8vxRLa3f4GtiXfgYY7
r1UOayEQMCn/1C2HpDPGFaaUgXJzvJ4cu3ND5XTKfOUyGkXINUiJcce2XTpBRQmc
xDUR1um0QwbzWC/A1oauVTb3OWHp1cX/gk9dOTTngzRSMu8ZvDfQAcdw1HLgHUwt
FEBfv3UfXXRREJc6QdCzunn205IGQJaVOLgixhQVPkbd9+FOkfMeL3i4ECDpkew7
2IJTIFkavy2qOzLc/mlj5F0mRjdgX56+H8XkcC0wTFINajnq/3R4yPXCpIkCZ+PV
UNKAzhSghzPbh/5F3eUBuxb3AkZeXAeVBCl0JzcadrCi+4VVXKO5ldNmF90yZWmb
Vimg5Nx6sCtQQrj3wVUCWH1wJoybYkFb2W6cmZV+jCTqR87CXdgryK4GcF0tcQZr
raeIX5D4TAHprPYGfNg2
=Hc0r
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
