From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Nov 2014 13:57:55 +0000
Subject: Re: [PATCH 1/4] video: omapdss: Add opa362 driver
Message-Id: <54636763.10605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lubUgX1x7F5LjjcrHrV4sKjeTAMTfe989"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-2-git-send-email-marek@goldelico.com>
In-Reply-To: <1415051968-4878-2-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org

--lubUgX1x7F5LjjcrHrV4sKjeTAMTfe989
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,


On 03/11/14 23:59, Marek Belisko wrote:
> opa362 is amplifier for videoand can be connected to the tvout pads
> of the OMAP3. It has one gpio control for enable/disable of the output
> (high impedance).
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>  drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>  .../fbdev/omap2/displays-new/amplifier-opa362.c    | 347 +++++++++++++=
++++++++
>  3 files changed, 354 insertions(+)
>  create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-op=
a362.c

This doesn't even compile:

drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c:207:28: error:
dereferencing pointer to incomplete type
  ddata->enable_gpio =3D pdata->enable_gpio;

And it seems to have fields for bypass and bypass which are handled in
the devconf1 patch.

 Tomi



--lubUgX1x7F5LjjcrHrV4sKjeTAMTfe989
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY2djAAoJEPo9qoy8lh71xbwP/2BBJi+3w+xIY+DHFWmv44f3
fynP4Gev891QE6eZ/JD/I5DBJ07z3KuwLVOHMIyuCT94p4Dwgb93so6la8m2wJ7k
llgPrJaFy8s740rpWGj8S9MD3TgEv5nWCArhTpFLdAC1t1akN1AQmuzRGcxfMNzO
4Djb0GLsEKxVQ/5dzPFBmjL+78WM0E1j46AKEDai+FiSDO7e9ZHpTYxmIKv0BJOI
exvWpRgZrtpObm4/6BdA55F6QoWipSvdNYldS41N2HR4ecZeXEe0uCOgVc3f74dz
42zGyUTmCCvTTLnEMZmgIhsqdR/+sFOG5Fm0kSRTFa7bG5KpCJGq1onp3AdZ4Pw7
jP5MmnQl75iM59iK/2KmPXLhrDcJ06zXnv01o87SVmxFnW94lruggB/N0ySSSAIg
qp7A9nAweSzIZTJ32qJz0ATAP30mQqshC2nAbdeUxCB+4CYamH1ZGc/X+zyaC1AJ
YMQ5Ps0EBcVCMfowkL+tR+YXaAhgq74XwUuVy/hqiwQCySCYSglGE1xkD3Pg7knV
yUM8Zo3z31MeA5aIhac1/X5gfiNQEX5u/ZLuB/U66KeYNxTAW6hlefz2DJ2Muop4
SaLu3UtuHBEm5N5/fU7etL+2Lh2WgQEd2atOrNAA/IgzF1P4DzVz4OBsiF92Z7s0
j3QHdbReqAuk/rzd+4eE
=bxRy
-----END PGP SIGNATURE-----

--lubUgX1x7F5LjjcrHrV4sKjeTAMTfe989--
