From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Oct 2013 11:35:36 +0000
Subject: Re: [Trivial PATCH] video: Remove unnecessary semicolons
Message-Id: <5270EF08.8000003@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="G9SS5v1k8HMRA6LnkX2gfpfOeDS3vSsVn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381274604.23937.15.camel@joe-AO722>
In-Reply-To: <1381274604.23937.15.camel@joe-AO722>
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

--G9SS5v1k8HMRA6LnkX2gfpfOeDS3vSsVn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-10-09 02:23, Joe Perches wrote:
> These aren't necessary after switch, for, and if blocks.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/video/cfbimgblt.c                       | 2 +-
>  drivers/video/cg14.c                            | 4 ++--
>  drivers/video/cg6.c                             | 2 +-
>  drivers/video/exynos/exynos_mipi_dsi_common.c   | 2 +-
>  drivers/video/fsl-diu-fb.c                      | 2 +-
>  drivers/video/leo.c                             | 2 +-
>  drivers/video/matrox/matroxfb_DAC1064.c         | 4 ++--
>  drivers/video/matrox/matroxfb_Ti3026.c          | 2 +-
>  drivers/video/nvidia/nv_hw.c                    | 2 +-
>  drivers/video/omap2/displays-new/panel-dsi-cm.c | 2 +-
>  drivers/video/omap2/dss/dispc.c                 | 2 +-
>  drivers/video/omap2/dss/dsi.c                   | 2 +-
>  drivers/video/sbuslib.c                         | 2 +-
>  drivers/video/sysimgblt.c                       | 2 +-
>  drivers/video/tcx.c                             | 4 ++--
>  drivers/video/vt8500lcdfb.c                     | 2 +-
>  16 files changed, 19 insertions(+), 19 deletions(-)

Thanks, queued for 3.13.

 Tomi



--G9SS5v1k8HMRA6LnkX2gfpfOeDS3vSsVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJScO8IAAoJEPo9qoy8lh71H5cQAJwxG4nCkLqj5XTNJjsbZUsI
NVTNg0QnwYvKOLiBtaCcG4qMOPxBtwQmOqMQ0FpUnctRyNO6sjoWWwMg81MkNSBs
eUdLUAzhZHkn+UavXNaazXFsjcXiZ4hndp0gTi4QH34Ic0aDXbwr5Kt8ZUumYQ96
Gas86K0I90SNjOjuT2+PjcvfGh92Ps0LZrgUHGWgtOC0LQZSGcQY/fGv7KKG1yVT
JabitWHhFMOiRFuHXW8RRDj/PHGkG5cWXXLjcNt6s6EhkkG1MBW5jEn1dGc7Lkxx
4L5F/KCj5pZnktauBxIIQWhDXqRyZnDSGrSl3QSNU8vmmgLij2J2RY4g+x5VVbrP
OgygXg6u5rwA/85WJfoIH6sCwPfvH//OQaxxauFf0ItC+dU6X9ATmWoYL8bZlnxg
NlysTEcPGENLLHFUBT+OTiNvEXALwnY4LxJ4ATNS4XpuskNKfJg6nlc1blPYsWcu
HMwVEhDeu1RyyyuC2JB7GfS3s+5iveLBBb/n6v2fuZKGYSV6/SNZLZBWAIwZyLHr
htI1gEeY2B3o7s4jGnAyu/ZmFi8SmBlwTC+ARcMO7Dpgx4vMZBaIBH1/4Rksgqbt
FpIqNZAFrLhs8pQoWs97iIQ+6m19bv72oXbDWNtyrXK9EltLDZ/m/Klq6jOn4au3
+i0whh0v7/YzZtpitzPu
=hTjm
-----END PGP SIGNATURE-----

--G9SS5v1k8HMRA6LnkX2gfpfOeDS3vSsVn--
