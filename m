From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Jan 2012 15:45:57 +0000
Subject: Re: [PATCH v7 1/2] video: support MIPI-DSI controller driver
Message-Id: <1327592757.2843.1.camel@lappy>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-stFPncMc9hd2pXXg2Z1l"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4F17AA10.7080604@samsung.com> <4F182ACF.8010302@ti.com>
 <20120120155121.18880dff.akpm@linux-foundation.org>
 <4F1F4982.5050000@samsung.com>
In-Reply-To: <4F1F4982.5050000@samsung.com>
To: linux-arm-kernel@lists.infradead.org


--=-stFPncMc9hd2pXXg2Z1l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2012-01-25 at 09:14 +0900, Donghwa Lee wrote:
> On Sat, 21 Jan 2012 08:51, Andrew Morton wrote:
>=20
> > On Thu, 19 Jan 2012 20:08:07 +0530
> > Archit <a0393947@ti.com> wrote:
> >=20
> >> On Thursday 19 January 2012 10:58 AM, Donghwa Lee wrote:
> >>> Samsung S5PC210 and EXYNOS SoC platform has MIPI-DSI controller and M=
IPI-DSI
> >>> based LCD Panel could be used with it. This patch supports MIPI-DSI d=
river
> >>> based Samsung SoC chip.
> >>>
> >>> LCD panel driver based MIPI-DSI should be registered to MIPI-DSI driv=
er at
> >>> machine code and LCD panel driver specific function registered to mip=
i_dsim_ddi
> >>> structure at lcd panel init function called system init.
> >>> In the MIPI-DSI driver, find lcd panel driver by using registered
> >>> lcd panel name, and then initialize lcd panel driver.
> >>>
> >>> Changes since v6:
> >>> 	- remove obscure compile problems.
> >>> 	- remove useless codes.
> >>> 	- modify return errno codes properly
> >>
> >> One more comment about 'mipi_dsim.h', it would be better to put it in
> >> include/video and not 'include/linux'.
> >=20
> > Yes, that is desirable.
> >=20
> >>> ---
> >>>   drivers/video/Kconfig                 |    6 +
> >>>   drivers/video/Makefile                |    2 +
> >>>   drivers/video/s5p_mipi_dsi.c          |  599 ++++++++++++++++++++++
> >>>   drivers/video/s5p_mipi_dsi_common.c   |  896 ++++++++++++++++++++++=
+++++++++++
> >>>   drivers/video/s5p_mipi_dsi_common.h   |   46 ++
> >>>   drivers/video/s5p_mipi_dsi_lowlevel.c |  617 ++++++++++++++++++++++=
+
> >>>   drivers/video/s5p_mipi_dsi_lowlevel.h |  112 ++++
> >>>   drivers/video/s5p_mipi_dsi_regs.h     |  149 ++++++
> >>>   include/linux/mipi_dsim.h             |  359 +++++++++++++
> >>>   9 files changed, 2786 insertions(+), 0 deletions(-)
> >=20
> > or we could put it in drivers/video/.  It all depends on which other
> > drivers we expect will need access to this header.
> >=20
>=20
> No, mipi_dsim.h file includes global interface data, callback function ca=
lled by machine=20
> file, platform data for mipi-dsi driver and so on. So I think it would be=
 better to put
> in 'include/video' or 'include/linux'.=20
> Of course it is much better to change name to 's5p_mipi_dsim.h'

The header file looks like a platform specific header, so I agree that
it should start with s5p.

I think we should finally start working on a common DSI framework =3D).

 Tomi


--=-stFPncMc9hd2pXXg2Z1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPIXU1AAoJEPo9qoy8lh71KX0P/i/es81W/DW1gvn5Y+KZX/f8
5S+a95Cwd5ZBNHP95t8ECmJeBWRLO1LwmxkN8Hw1yiTDQnUaqhGstnJEMRIw+0jp
4SadWmgr/dNpkQRfduy8RadI7+ubEj60q7wT2zQOAqyHLMOjZmKGMO9wycHUC2dn
UGbek16LJsq/VUOlwFy1RbH/K6K1/WpUmYzTYeZ/nfhn0vR68VowZzzIJmshKfES
IaJlPWNiurKgxzPQ1QXP2veR2Axenmvbi7CKUxOwAmKvYnNfHuHpSh8HrRCWx98n
IKbG7pvxlQUHKh98roPyHI+fJTDX5f2deKaWsyWvcUQjFGNpGWWsqeYybwe6Gt6J
V6+DyJe7D0APGtU3/N3Pyc8k+eJrbXcGQlI4ndlNKaDKnEZcK6qgXLCMFskszsV2
dSxKCaqWg5G3eTfYeWyrcE8uWTPrmVZpk7QqgevuYKibT1Q2L/TCzoqNn3q9D4T7
M6AFaSdVhvDjH9tZQjZvRFtBTqVdm5+VsZLERjuJQPt+yQjnNqw1/Y9UeJX91rLY
fGr8l/YPhjlAmQxoNXufgVd2siYINcnJzItOhdrtFZRc3whZnlkW32PARu0QErHW
7Jo7asHrS4Wmn4Kk4QN5mlmXyK37JOIpJyOWZFGc1jP7JyKfBBlcMXVXJ6OYKAOr
M+ZEGOKIUAj+AMdC09L7
=kkY0
-----END PGP SIGNATURE-----

--=-stFPncMc9hd2pXXg2Z1l--

