From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 04 Aug 2014 06:38:01 +0000
Subject: Re: [PATCH] video: ARM CLCD: Fix DT-related build problems
Message-Id: <53DF2A49.9080609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="99vEjlAkcLLhOh9CVWJtwvuvQvi9F6PPv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406904214-7360-1-git-send-email-pawel.moll@arm.com>
In-Reply-To: <1406904214-7360-1-git-send-email-pawel.moll@arm.com>
To: linux-fbdev@vger.kernel.org

--99vEjlAkcLLhOh9CVWJtwvuvQvi9F6PPv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/14 17:43, Pawel Moll wrote:
> This patch fixes the following error when !CONFIG_OF:
>=20
> drivers/video/fbdev/amba-clcd.c:800:54: warning: =E2=80=98struct amba_d=
ev=E2=80=99 declared inside parameter list [enabled by default]
>  static struct clcd_board *clcdfb_of_get_board(struct amba_dev *dev)
>                                                       ^
> and adds a missing Kconfig select causing this
> when CONFIG_OF && !CONFIG_FB_MODE_HELPERS:
>=20
> drivers/video/fbdev/amba-clcd.c:567: undefined reference to `fb_videomo=
de_from_videomode'
>=20
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>=20
> Hi Tomi,
>=20
> This fixes two small problems detected in next by the kbuild test robot=

> (thanks, Fengguang!) Hope you can apply it before the merge window.

Thanks, applied.

 Tomi



--99vEjlAkcLLhOh9CVWJtwvuvQvi9F6PPv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT3ypJAAoJEPo9qoy8lh71CSEQAJXO7/gtcn4K9S9x0EBdh2pn
4CMU8UJiXsXXsfC2lHwb56CDGZSHIQSGV+bDCV6AlR43Ek1q2gJIhJkE+QRPByG8
vzQ9mMEXC5tL0y94OvSz34vYal/ltquZAkRaqvF47/3Jtp1J3AWptJkFPg06x4hs
HNcKHhEH2iMKjSD1X6Xr2aIY6Ow0KiOrB9s84rZlnVVefqalNzSxpUBn68EcVUQv
wgVPSyFEt9UGSR7MycpY7L6QYbLnRdmRj4ilZT+mAsvKRLJqMNa0XiBOnWL4Nuhh
XCaW6cPi5GF0pWdBOmUO18O7i3EgQE/HDRBwtoxHIyE1ilBR2D+iifqSvvpT6/tW
XhY/xBduZHYk/8ZbZTGcxbUj2BuLZjZh/13MoGR2F6ibtxP2/7KdzH3Ns2w4d8vH
0UM0GnQcMP7ug2SbzpcVDV4sUvLUvR37Onatkfijc/2UwvAEEh7QbYjU+XGY+I7q
DSpTkJCVuIFdsVjb2nk9rCHsubaPOy4xRTWqJYSaHKI5y/qxkwi78tYoPQSUC1DK
gMZIR6HWFlaqCezPu/BcqhugjJUlDlJSQ36Hpspti0md7rA5dPxnh3aBnnVyx+Ol
QbqR1J46vNUus0mkjgowsh+M2HnGGtSL2QlV9u2JfhcijFN2/u+PKgCwLxtj/Q56
u5B3mv2X7GQQB/pZ7c/b
=uJpQ
-----END PGP SIGNATURE-----

--99vEjlAkcLLhOh9CVWJtwvuvQvi9F6PPv--
