From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
Date: Sun, 16 Nov 2014 09:50:55 +0000
Subject: Re: SSD1306 OLED driver
Message-Id: <20141116095055.GC6414@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
List-Id: <linux-fbdev.vger.kernel.org>
References: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
In-Reply-To: <BAY176-W246A4D5C3A23D1928FC5D3D38C0@phx.gbl>
To: linux-fbdev@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 14, 2014 at 05:09:09PM +0530, Ssagarr Patil wrote:
> Hi,
>=20
> I have the SSD1306 oled device connected via spi, will the same
> driver work ? as the current one is based on i2c what all mods would
> be required to have it working with SPI ?

It won't work out of the box, but it should be fairly easy to support.

You need to had support for SPI probing, and then provide some generic
accessors the rest of the code can use to wrap around the i2c and spi
calls.

I'm not sure regmap can be used for this, but this would be something
worth looking into to do that.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUaHN/AAoJEBx+YmzsjxAgt0YQAJw0UFaSPDF9r1ahu89GIol1
wZNkYRpk13Th0yJGSAeG4ctUgkTH/EraEl8dT50b1dCSu9zvoJkLA1aB/i2BoWoU
dZyzaGGbkHOlU8SWptIHkmRUK4ENcFkkO1bMgZeM234ucNRyg6CERRLkgpaNtdXj
qewXP1pCYYfnRR1EHSGsqKBhEfU5Ds0muXZ4sIbe3JuFlOt5Qfp14zy1G8rMSo6o
IbjBnit62ofGjoXppUzuLSobOgKetZ2GMxm/XhVJLSwaDjAOTQVOaSYcc+WWumU/
O4sI2/NGOTf9yQRNPyQVguVIujHXDeH9eG6Uftgkfd2Xe4uiA4nBJZiOUW5pigtV
Yo5FuFqjjRt7w0iVV5uL2m+Pfj/Wg2TlA/f9kTDzUxRckZ4F9bSBeCnXKD8MUEMi
2cUntN/txGja0NIrqh7JfljNGT5ZgtzetMDJ78G4hxmKRJuZDoL+gN9HECAN2DIJ
zYL5CQzsDdzFOJFzEW/ANejvTVdwlBQFvWYFSOH4RUVC3A7FqeIFOIY0D1z/RdNF
mZeyPYhptqrnaxfpzVV80gIiAYVlWFuf6yXq5M1gzuoWNLLOwp48boCFRwJoHfM6
wcZtsE//X5wWsIOdggd8w/5jUkRgh7Kz3MCxCVBI939yrl1dbJ3I8RUICN1FDq43
9Df69svaby156qI3EOON
=29P+
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
