From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 08 Sep 2016 09:57:46 +0000
Subject: Re: [PATCH 5/6] ARM: dts: Add NextThing GR8 dtsi
Message-Id: <20160908095746.GN8913@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rPgHZmYkQ+bUEpVC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-6-maxime.ripard@free-electrons.com>
 <CABxcv=kJCuP==QVRqyuoORSoWKAEqXmt5iRjdvDcCcr4MSm0gQ@mail.gmail.com>
In-Reply-To: <CABxcv=kJCuP==QVRqyuoORSoWKAEqXmt5iRjdvDcCcr4MSm0gQ@mail.gmail.com>
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-fbdev@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Linux GPIO List <linux-gpio@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, Alexander Kaplan <alex@nextthing.co>, Mylene Josserand <mylene.josserand@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--rPgHZmYkQ+bUEpVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Wed, Sep 07, 2016 at 04:51:55PM +0200, Javier Martinez Canillas wrote:
> Hello Maxime,
>=20
> On Wed, Aug 31, 2016 at 10:18 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>=20
> [snip]
>=20
> > +
> > +#include "skeleton.dtsi"
> > +
>=20
> The skeleton.dtsi has been deprecated and shouldn't be used in new DTS fi=
les:
>=20
> http://www.spinics.net/lists/arm-kernel/msg528080.html

Ok, thanks, I'll change it in the v3.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--rPgHZmYkQ+bUEpVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0TYaAAoJEBx+YmzsjxAgMfwP/iJmcNOhfbP+IClHg60l97Zt
LXejNjamLaWFZXClcCrlrvBM4xFpyJGGfk1ydDwB+8Wfos6s6l0Mu4TwFxH9+muK
3RbyU5wmrDON6Ax/rQr9Oo1rkrIAaKmj1rQ+crNaeAJuK2uAcM7bsm+M51t9pkUo
oh7o9pbfn1J2Hl82ldA1oV6jn29HAf9sxki0Q/RhQI198pHoZXZk5G4kCjlGrF73
eXRFgn2u/9SSvVtsVVMj53fE7smifTNOo16afWK/dtRW8Jiost4P0Vdn6vfCnXGF
0Is/374PZIu/2xtktNCfgBTmp2sZLnS5KLs3oprePaJ4P7Ft4moih27KN9OCDzU2
O6qXI6NogmgHY9CR0dUgAtMeJ4ELoc8Dj2WJpr9qmij+6VkT12j+piOBF9xhKfPJ
9KCAnoF2hqJIaGtYr8uX8DUwf4CI8COFt3sk7ziAeLYA029TtfSpoBpFmVwR2V3L
ArwwO04ot9MuYFytv6OxPyOwtJzb6AneEzstgYz8KriaDsA4yO4Rff+/+Blv1iCk
wpWnpjGN0qjOxskuZJJvgbvxupb2vTvSsT68Se5ddvxuwgai1mhm1EWWxN4xGBrd
Upxw8zYbFZkGr4BEtOQrSLnTpJWZcKnIbF0rjV9wi4a6Sh7WjeagdMXx5eEi9jaX
czY/3y9OG9ha5VsnUhRG
=2Uu2
-----END PGP SIGNATURE-----

--rPgHZmYkQ+bUEpVC--
