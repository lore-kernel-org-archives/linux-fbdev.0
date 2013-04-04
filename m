From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Apr 2013 11:14:41 +0000
Subject: Re: [PATCHv2 0/5] videomode patches
Message-Id: <515D60A1.7060904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig86F440CB01C9CBAA24E6EC7B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1364367505-4366-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

--------------enig86F440CB01C9CBAA24E6EC7B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-27 08:58, Tomi Valkeinen wrote:
> Hi,
>=20
> Here's a v2 of the videomode series. The changes compared to v1:
>=20
> * Dropped "videomode: rename fields", as it received only negative comm=
ents
> * New patch: "videomode: videomode_from_timing work"
>=20
> Patches 1-4 are unchanged.
>=20
>  Tomi
>=20
> Tomi Valkeinen (5):
>   videomode: simplify videomode Kconfig and Makefile
>   videomode: combine videomode dmt_flags and data_flags
>   videomode: create enum for videomode's display flags
>   videomode: remove timing_entry_index
>   videomode: videomode_from_timing work
>=20
>  drivers/gpu/drm/drm_modes.c           |   20 ++++++------
>  drivers/gpu/drm/tilcdc/Kconfig        |    3 +-
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c |    2 +-
>  drivers/video/Kconfig                 |   22 ++-----------
>  drivers/video/Makefile                |    8 ++---
>  drivers/video/fbmon.c                 |   16 ++++-----
>  drivers/video/of_display_timing.c     |   19 ++++++-----
>  drivers/video/of_videomode.c          |    2 +-
>  drivers/video/videomode.c             |   36 ++++++++++++---------
>  include/video/display_timing.h        |   57 ++++++++++---------------=
--------
>  include/video/videomode.h             |   18 ++++++++---
>  11 files changed, 88 insertions(+), 115 deletions(-)
>=20

If there are no objections, I can merge this through fbdev tree.

 Tomi



--------------enig86F440CB01C9CBAA24E6EC7B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXWChAAoJEPo9qoy8lh716R4QAJR5Mu0QXM5MQkBhX3YkdWW8
JtPhxWViJkAWBa+OIn9i9kvSApKeDFc7FTip+5fZ8CM80mXOPO+xA6i1Cg8CLPPI
medc0ItGl1pNT11JYVP2kuvs+gV7OFjCwZ/sEqjUHBsT7YVdqc1/fSYv5EA2VGeP
WTpeQnfn1cjXlWilfma2UnDxQoOMSSia6CLsHoscvbg6mNH8BKdWELSALX//GfAs
FZMPhqCD1JbxXeE1waBm5arIfc89Kp0Udmp7w1dY++fWB6RxLlRjAMBS6biDBl01
N9P5mjGIaPRmSx+R91DbEGYf/a3gN4ERtXn3dRLgVesdeZUVSXMy61Ihe+e66OTb
RfYhJKdURSvpj2HYRZ5vR2km7sTpN3O9M+3KWSZkHy+wFQ4mC8kGno8dF+FBNt85
PLX2QQps5h2S9hffCLmPIF8wxTgcrywSR3BKCUlTO/hasHNnV4zs8rp3dhHwPuuD
2YGSbSh+a6L8cBEJ3lFxY1gBn/65jrhBfIOWBRKjMFm1J16rfYWLuv0ewz51hTxn
qrzBKBL4oBxngVpHD3Ku2HgfS87aNYmOMd1tfrgLuUSe/bijDXh55K4f2VPxYsJ3
wbj/Khikw175sTDGO3dHx4b3S4yL1f6RrqAyV9KAmifo24wJX5eQwlJ/eko0vCF9
zGM3VOflDzOfA2APJc3j
=q2dj
-----END PGP SIGNATURE-----

--------------enig86F440CB01C9CBAA24E6EC7B--
