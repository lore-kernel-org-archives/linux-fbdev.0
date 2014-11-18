From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Tue, 18 Nov 2014 15:20:29 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20141118152029.GF6414@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="i6U+WTAJHBcf3BHs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--i6U+WTAJHBcf3BHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 08:29:51PM +0530, Ssagarr Patil wrote:
> Hi Maxime,
>=20
> >
> > On Fri, Nov 14, 2014 at 05:09:09PM +0530, Ssagarr Patil wrote:
> >> Hi,
> >>
> >> I have the SSD1306 oled device connected via spi, will the same
> >> driver work ? as the current one is based on i2c what all mods would
> >> be required to have it working with SPI ?
> >
> > It won't work out of the box, but it should be fairly easy to support.
> >
> > You need to had support for SPI probing, and then provide some generic
> > accessors the rest of the code can use to wrap around the i2c and spi
> > calls.
> >
> > I'm not sure regmap can be used for this, but this would be something
> > worth looking into to do that.
> >
> Thanks for the inputs :)
>=20
> Does the driver work as a standard fbdev driver, is there any library on =
top
> of it to ease the user space ?

It exposes a monochrome fbdev, so the usual framebuffer tools and
libraries are supposed to work quite well, provided they've been
written to handle monochrome displays.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--i6U+WTAJHBcf3BHs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa2O9AAoJEBx+YmzsjxAghbcP/0qEYj+2Bk/MEMrIxE7qtQDm
boYlZdnIso6x7SnCBNffxdrCUnXWlJsKLVBza592wWm4Z0zW/u4oBL2wkHjWuC7A
j18JHZjofMY/ZHYz/VaZt+VFXhKs1PQHX2HGv7+o0lgRHNrQ316VT3/uUYX27oTW
4KxJk2Dz1gHeRCZimQ9RTnkUwKgEItzR+cwtPF1ACVEoiYh5iZjP6b4mXbSoWw0l
8mSwHuf/6GcYPwP+nNiWGrDahS2Nn/GSkP28z0Hbtly3758imcn4N7p1L6CuFXjl
pQakU9i025UrMw+o6uHtg5dPrR8opdNA+iN9+QIRtiQbb2dleSC8SdtAjBtFt7xY
L/bLfVY1WGF0vfWWp53FRYcsvTE1C82gTnbWQauwxBMydN9tQiKFN1Jq252ulUZz
sb4i60pMZd2+FVUKVSyACSWK6aYsW+X3TXIVME1u4n+l9qSTdoyku96NJFLYATeE
sTqa1l+kimBertdZoLaRIfPtgdwjf2LaOI5rc1gIBLosQYg9glDBmfVm1Iz/DEg9
VJqBkqVGLbmFV6l5XlEH1dtAU6rLp9i3TWI06rQkySB4ryxfZfYc46VtRhE+6tZj
o8vH4xHMS2hzolZWBVUBeHmZnVHmlAiM4Xgc0qTIQqJfzUUSNERD9zwRXSz9iFVK
o87oNa33Lbowe9ac6hGg
=XGfm
-----END PGP SIGNATURE-----

--i6U+WTAJHBcf3BHs--
