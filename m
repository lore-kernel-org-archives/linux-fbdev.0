From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Wed, 01 Aug 2012 13:38:14 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120801133814.GA19771@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
 <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
 <20120731153941.GF4468@opensource.wolfsonmicro.com>
 <20120801074113.GF29673@avionic-0098.adnet.avionic-design.de>
 <20120801132651.GU11892@opensource.wolfsonmicro.com>
In-Reply-To: <20120801132651.GU11892-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2012 at 02:26:51PM +0100, Mark Brown wrote:
> On Wed, Aug 01, 2012 at 09:41:13AM +0200, Thierry Reding wrote:
> > On Tue, Jul 31, 2012 at 04:39:41PM +0100, Mark Brown wrote:
>=20
> > > Sure there is - take a copy of the platform data in probe().
>=20
> > Yes, but that will only work for built-in drivers. If you unload the
> > module and that causes the platform data to be discarded, reloading
> > won't work.
>=20
> This is why __devinit data will only be discarded when this is not
> possible.

That's exactly my point. But I seem to have miserably failed to get that
across. =3D)

Thierry

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGTFGAAoJEN0jrNd/PrOhN9QQALb2rZasbdKcdtx5OWeBu9B4
GE2sRXdQ08Rkr4gDbVIQqWd5oxwKw6biWwAOkbO38l0DBlfQ8H82Cg9BrWuxBzLK
oGNDb2f3DhhyvPcMrxKA369wlfpZd6OsHXI81Sg9Mez/H0CuqeU0MD9omEeJjLWg
DQCQ4f2w1CgaTdjxyQzHeU+u0Vnw0jNyi3og5QlEVNIIl2ntvIsrx1Ouif9bj8Di
Bg52fj1RqR4nBASVXKHGWHnK9bAdIUvIpv3nqxFt3a8Eqn7FtlhAdEVQZGAmLZD+
8yXvBhT7TMYUbzgqQyPLmNI9HFgObij3Ad5V88txVv9qY52AKg9QXYOossC4MPYw
1OsYfa4o8YZ5dh1IgzgeoN89rbPKd2XlZtmQc2Ll3Hs7EH8bdJx8rKZpe6GemGY1
NZS3nTrzMp0/adV5C2wbVfG2mOBZSsT6ByjAFCnN7+rYQEH5ynwL5IFJ/KnRQ/+k
QWiCnaO6yNDaXVwyb68SYZ1AcZdBlHDCJ/KNtBofzjaicWtJro6bBYXLcev6h225
8oxk8oodNlud6E7BPIEpI2F3kGxFRiK1gy9mIpMIS7LjST9V+cknRwvRW0W2URzm
OS3tzRZt74nFNW/SAZMikK/O2FWJBR5OYnL/c/RUeYDvSEvMp6SuJn5VJhb0Ij1o
pjz9SXQJuwRWrncgyb8F
=4DSx
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
