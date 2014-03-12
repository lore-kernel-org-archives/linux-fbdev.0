From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Mar 2014 08:15:47 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <532017B3.708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OEAguIGrXX9Obe3Bm29X5OlauX1ooMdFD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--OEAguIGrXX9Obe3Bm29X5OlauX1ooMdFD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Grant,

On 28/02/14 14:20, Tomi Valkeinen wrote:
> Hi,
>=20
> This series is a re-send of
> http://article.gmane.org/gmane.linux.drivers.devicetree/61739
>=20
> I'm cc'ing more people, and I want to clarify the contents of the serie=
s:
>=20
> While this has been developed for OMAP, only the first patch is about O=
MAP
> bindings. The rest are generic bindings for video components, which can=
 be used
> on any platform.
>=20
> The bindings use the V4L2 style video port/endpoint system, described i=
n
> Documentation/devicetree/bindings/media/video-interfaces.txt, to connec=
t the
> components. The same port/endpoint bindings are used by Philipp Zabel i=
n his
> imx-drm patch series.

This series is a piece of bigger series, which brings DT support for
OMAP display subsystem. This uses the same V4L2 style ports/endpoints as
has been discussed recently regarding the series from Philipp. It
doesn't use the helper code from Philipp, but a custom one as Philipp's
code didn't exist when I made this, and also because I needed extra
functionality not present in Philipp's series (which aimed to just move
the current V4L2 code to a common place).

The main concerns with the ports/endpoints has been the optional 'port'
node for the case where we have a single endpoint, and the
double-linking of the endpoints.

If I remove the optional 'port' usage from my series, are you ok with me
proceeding with this series for 3.15, with the double-linked endpoints?

As far as I see, when we come to a conclusion how the linking should be
made, it's trivial to change the bindings in this series to match it,
even without needing any compatibility code. I just need to remove the
other link, and old dts files having double-linking will still work fine.=


The reason I want to push this forward asap is that omap4 and omap5 are
already DT only, and for omap5 we don't have working display without DT
support for display. For omap4, we have a really hacky way to add
display support for a few boards, but that is causing major headaches
and I want to get rid of it.

 Tomi



--OEAguIGrXX9Obe3Bm29X5OlauX1ooMdFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIBezAAoJEPo9qoy8lh71IwoP/0pXrIE6ddjkDeFNaZ5f9Geg
bBppfIrr3q+N66512wIIJ1dcxGeRa3EdUxE0siD45mvkTu7Z4MeS4xgUOCSi3sN9
vEFi4KpkQipWfphvzVwDboxZ3cg5zmSv1w+W2GCih6dRu8WJgSDCv3AhterqSrmv
RXA5P4cI998J2RmKOPLvW9qEysh6AVkQx751ENB9R64+/o7XdgR89uQ7aa6/+lQh
8e4dtpZBKkbjNkWoL1D3+HNWKeWQ/kWH6rsUieoUuUK0zp9rxRt+LSx8DvSf1gCk
4pZTj9iGz0FAQlHy8DlUwcvYi1uyat00tmp9dV8V+UJYG0jnL3Fu2YQ9p9sZ1kHn
zVyi+eTfzzQJMsSp/ke3RNUN3i/S9P76Gc+YsQ59hXZkw9W+Ytl5gapSHGtnLlh5
GRWrtevZ5pRxp1lr7s8lGWpukQkZnnuM2YNFetJQWfY+5NKRp4vMT9xttn8yVah+
ChqwNudHo7gxZYJ5gThn3crs/XkOKK4PdhoNtGiYyxSo5LOAzpd5IAP76RH7zSBY
UEPYLt4PoMHCtJjAkhLyyjLVWIii6pG0X0BxuFdh0jMh8uEJwONicCUGbZ3Fy5qv
w2opFqZRyoyTq0ONZrU9x6YMsO94oT+1R9pvoFOChIni3iyGyjOSmJDcYqYCT5Vd
vczZ0oUFXewnJlRDOOrg
=R9er
-----END PGP SIGNATURE-----

--OEAguIGrXX9Obe3Bm29X5OlauX1ooMdFD--
