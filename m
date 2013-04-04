From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Apr 2013 10:17:33 +0000
Subject: Re: [PATCH 0/9] AUO-K190x: Rotation, truecolor and misc fixes
Message-Id: <515D533D.8000005@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig61066C5B7689DD66A86782EB"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--------------enig61066C5B7689DD66A86782EB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 2013-03-22 16:12, Heiko St=C3=BCbner wrote:
> This series enables rotating the display using the framebuffer function=
s.
> It also introduces a 16bit truecolor mode for applications that don't w=
ork
> well with the only mode (8bit grayscale) that is available currently.
>=20
> Heiko St=C3=BCbner (9):
>   AUO-K190x: Use correct line length
>   AUO-K190x: add runtime-pm calls to controller init functions
>   AUO-K190x: set the correct runtime-pm state in recover
>   AUO-K190x: make memory check in check_var more flexible
>   AUO-K190x: move var resolution-handling into check_var
>   AUO-K190x: make color handling more flexible
>   AUO-K190x: add a 16bit truecolor mode
>   AUO-K190x: add framebuffer rotation support
>   AUO-K190x: Add resolutions for portrait displays
>=20
>  drivers/video/auo_k1900fb.c |   11 ++-
>  drivers/video/auo_k1901fb.c |   11 ++-
>  drivers/video/auo_k190x.c   |  235 +++++++++++++++++++++++++++++++++++=
--------
>  include/video/auo_k190xfb.h |    3 +-
>  4 files changed, 214 insertions(+), 46 deletions(-)

I'll apply this series to fbdev for 3.10. Should be in linux-next
tomorrow or the day after.

 Tomi



--------------enig61066C5B7689DD66A86782EB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXVM9AAoJEPo9qoy8lh71ThkP/12bUt/778kJN81jyN9LrZXO
CcgYJmi4R64E5IFVoBP76k6ke0xgd/OsR0bqQnBR4mlLxWnzosssWCCG6YOkyocD
FzjO4ci8Ocwm3zPsh7HxRrlioCcRXOSfxJSO0LX2U1phdrSCuns5kNfyZUiclZro
E1ma14P9HZzoSxf2bhFVmFM4mUuQFbAj1TJgMP9lJDZ0KTgTVPfgYA+QOZLUay6p
EFjmyXjWNH0MnDcPcybPGP5Y1jBg1aeC4e/Pcugc+CA2DzhLMJwafU2loVsZUyjQ
/wVGIJ3Mm6hdju0noC/qcvDnjgXuus1JwgK/zNyKut1gZIgGEoQUWstHX9dQ30fJ
WneFLY9bOAqGHcf8T30l+l0Y/2YXTjdqa9b3AVoKYbEejOK+NbEoabeKqEWBCrai
vN3FrB+taPDoWxEeD2xIJUY0mMHB5t0kxb69Xk8Ax9O9hitKnV2BVyF77mibIHvs
SXqz8Gwf/QUjeo9JewPRV6I1nVBAvwGa9vpglWlxZfhrV9L552OkZmvwtY9aA8DW
Rj+VONT1Q8RBXMZG+vJTDzHQexQAM802YQg87PF77DaN5J6vqqXCU8MfsGDTib8K
jks5z1VUJIa7FLZQG4a6h6ukuA5jLPr0b7hgVfEDJZBvg6NpWQzlakjAwOH3Geqf
6YsxkyL9tQ65fQxK9NEY
=UQWZ
-----END PGP SIGNATURE-----

--------------enig61066C5B7689DD66A86782EB--
