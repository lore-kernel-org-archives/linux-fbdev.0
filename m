From: Ben Hutchings <ben@decadent.org.uk>
Date: Tue, 13 Jul 2010 23:48:15 +0000
Subject: Re: [PATCH] viafb: Add transitive dependencies via gpiolib
Message-Id: <1279064895.12074.2.camel@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-DXA1BzP4a80kuM6ZFZTN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279063845.6139.129.camel@localhost>
In-Reply-To: <1279063845.6139.129.camel@localhost>
To: linux-fbdev@vger.kernel.org


--=-DXA1BzP4a80kuM6ZFZTN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-14 at 09:35 +1000, Dave Airlie wrote:
> On Wed, Jul 14, 2010 at 9:30 AM, Ben Hutchings <ben@decadent.org.uk> wrot=
e:
> > FB_VIA now selects GPIOLIB, but that is not available on all
> > architectures.  Change FB_VIA dependencies to include GPIOLIB
> > dependencies.
>=20
> If you can find a via chipset on anything not x86 I'd be impressed.

If it's really restricted to x86 then that should be added to its
dependencies instead.

Ben.

--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-DXA1BzP4a80kuM6ZFZTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUATDz7Oue/yOyVhhEJAQIxDxAAnCpTo860UqbrJZudHRUi1Q+2ePhzSlBS
Xa1eZp+p/rKQkITxqLrAj0tKclHmrpJg86HTe/nmlUi4uvY4uKydCJpRJqm3BeMG
nMq4tLVxje2DdzBIvMXcuVqyqe5RNDGtYAMb3tXJMtA+wczJX7kE28UR+kQzdAAr
f7teabYLab769PjYJzHgLcpFUz9bMAUgiCZg9T9pj/gvdNbq6NrThWiCXPFvZLDA
z4HA1EumWK78rqjwb2eaS4jR1NraaCfK/BwzYRo8UsiEihVFaJPxvRzvzAVsEw17
NOQcvgFc5E+MsMG2ARS6mYAwltowFB8U/R0Axi0riFbTDB3VVdqpaoDpO0ZUVu3N
cquZiSL82Pthp2UnLESsjonmE/joYF1hzasPbqTzHMXqphI2cE/GFYcZ+PjEDspz
kIh+5EmaQWypnwiv9aYS0saexstqedCGTRghtQib3FoJzK5+iIEV/7+M82R5w9xN
ys7CVOGrROqKV7K6oYsoQjRz8p65k8ynBNR58QZDGM3lVkn9EAzoOECXpNJTF71g
hgfPIj+LzQKr+gnrgdn1Mw6BP2HeK8KDJpNWwscij+IZlARDzZiwPBtxTpCtR+3N
8oU3HMC0msF38xPSQl69XFdknjFb6VoNcqyrZlrn0iXEqgQH8Ku1G5OtIP64RG4+
GNAGfRA9dmY=
=BWdu
-----END PGP SIGNATURE-----

--=-DXA1BzP4a80kuM6ZFZTN--
