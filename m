From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Jan 2012 15:52:59 +0000
Subject: Re: [PATCH v7 2/2] video: backlight: support s6e8ax0 panel driver based on MIPI DSI
Message-Id: <1327593179.2843.5.camel@lappy>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-DewPNMW4W84aG9WQYWKX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F17AA14.8030100@samsung.com>
In-Reply-To: <4F17AA14.8030100@samsung.com>
To: linux-arm-kernel@lists.infradead.org


--=-DewPNMW4W84aG9WQYWKX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2012-01-19 at 14:28 +0900, Donghwa Lee wrote:
> This patch is amoled panel driver based MIPI DSI interface.
> S6E8AX0 means it may includes many other ldi controllers, for example,
> S6E8AA0, S6E8AB0, and so on.
>=20
> This patch can be modified depending on each panel properites. For exampl=
e,
> second parameter of panel condition register can be changed depending on
> ldi controller or amoled type.
>=20
> Changes since v6:
> 	- change data type from const to static const
>=20
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/video/backlight/Kconfig   |    7 +
>  drivers/video/backlight/Makefile  |    1 +
>  drivers/video/backlight/s6e8ax0.c |  898 +++++++++++++++++++++++++++++++=
++++++
>  drivers/video/backlight/s6e8ax0.h |   21 +
>  4 files changed, 927 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/backlight/s6e8ax0.c
>  create mode 100644 drivers/video/backlight/s6e8ax0.h

Why is this in backlight directory? It's a panel driver, not a backlight
driver.

And the driver is s5p specific, wouldn't a directory like
drivers/video/s5p/, where both the s5p DSI driver from the previous
patch and this panel driver could be?

 Tomi


--=-DewPNMW4W84aG9WQYWKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPIXbbAAoJEPo9qoy8lh71uNUQAIVWzIzMauC4AD0dgb2JmtGb
q36cNosPJK8U6qZ4YVzCquTTSE9OBqSRffe7mkJRHhgNhdxTX9VfogvLUEdUVKSB
u0stNLu2yM7mVwnz3wz4/dWAl1jXL5Zr8mc0aZ+su/x/SD6LBGrW5ljh6Q3a1XVI
lkfodR5i1txhHj1h7WOjuO6B1onbWyMomaHaeAbRbA787p9/YlzeEM+Mrtv9auww
BzDn00TrAtEAEfdxNoS6Rhf4oBhGP/kDg35On7LtaZ3z8h/QVYUGqMHJnRPcLYNq
32EqXPHiPy/0E68JyzuuwxYm9H5do2elp/gqh85p9yobcbBzDgsBoC3NQYjtTK5W
zEGu1jvwUZIuC3eQNyYE5X9DKWDpkgxToGIf3yNC8u91M7CZRMtdexwyUOJpph+p
jl0xmjqHtxsz+fF+lixRtRhwIm/Sb4x40olkaEB/zrR1ZjKKClvhcjBN7ClulaTl
M9+wYKoXUF+ndWa6QSMjmRqmGnWIukzkXGQSIXfeKFtPhLVhStFVGiFaDAeTceLh
zBgV19FamhDTSfWNRhAogkfc9nu+uacCBXXq6OA7qhQpAkehQ/6/4IkIHHUVQF37
6iVSWy1/ajkpDLu07n68vRJCspudRDn1xUA3/wVz+OxM/GbycH9ZIRgG/HYd6g0s
xZa7WbNTqSF4zbYR+T3F
=hV0J
-----END PGP SIGNATURE-----

--=-DewPNMW4W84aG9WQYWKX--

