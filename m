From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 07 Dec 2015 15:36:09 +0000
Subject: Re: [PATCH] fbdev: Remove unused SH-Mobile HDMI driver
Message-Id: <5665A769.7050007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FtsbrtV89FnH5r8TskE7ExicU0K3fh9Ha"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449244903-23336-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449244903-23336-1-git-send-email-geert+renesas@glider.be>
To: linux-fbdev@vger.kernel.org

--FtsbrtV89FnH5r8TskE7ExicU0K3fh9Ha
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 04/12/15 18:01, Geert Uytterhoeven wrote:
> As of commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
> for R-Mobile A1"), the SH-Mobile HDMI driver is no longer used.
> In theory it could still be used on R-Mobile A1 SoCs, but that requires=

> adding DT support to the driver, which is not planned.
>=20
> Remove the driver, it can be resurrected from git history when needed.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/video/fbdev/Kconfig          |   10 -
>  drivers/video/fbdev/Makefile         |    1 -
>  drivers/video/fbdev/sh_mobile_hdmi.c | 1489 --------------------------=
--------
>  include/video/sh_mobile_hdmi.h       |   49 --
>  4 files changed, 1549 deletions(-)
>  delete mode 100644 drivers/video/fbdev/sh_mobile_hdmi.c
>  delete mode 100644 include/video/sh_mobile_hdmi.h

Thanks, queued for 4.5.

 Tomi


--FtsbrtV89FnH5r8TskE7ExicU0K3fh9Ha
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZadpAAoJEPo9qoy8lh71auYP/3PT46KnA0gs3x1KHOlxEOr0
Y0MbI07+e6U7e6/ep1GY3vH65ovzusz1Dy6G3DvCn0zr60YAt9WMK2s+1gGdkDfJ
RcU9btHJX02TsTMiXEw3TcHy0b5NVf524ph6QCLhghXlmIWdnTnoLgkNpYcSXkyB
/OyrpJ4+JLU/SAbrvz6Guc9Ff3NFABfoaE4sjrf1ToJRsV5wpZhO6ZJrFvWKi/9g
V2lwfDkuZyROR+lBdi80ox3LAVHYX2ECQeOVGmWGf9/aHOqEIy5A83D9C3aE+OXX
VyLXn47tWVNe7zunGuEZb8/2sDmgHgm3u3jgs/5fCR0mW9ISWcnSGUOrXICFs2xM
k8ZyP3lZMSuunUVylvCLTuQXyI54DUihxck2dOwGsdSpQeqeG9GIAbeiGGBCUxsv
oGbgpoOQTSU1CnJLusRETipZrAvdxe37ipvSMchFrTNiEy8PVqDYJZ52BoeDHIPi
PI3rnICeXdCREjXY2DIR0ha3M+jfdxQ00HXskEP84IlCTfPcRoUC5sOAKVR2T2t0
JDq+TNNqMKEdR6MlrPfhnlftF/dDvgfJfT8Nn5H4+Lzc2KVzlXWyY4zvJlpGfRVX
3WfnZi06fdNFW4Bx25pta2hT0gXUcUTSuLbvnho4yph63o7DDdUkb/D6PQ2kMl36
UIw4KvIlClyCcZnpC9Uc
=VpAK
-----END PGP SIGNATURE-----

--FtsbrtV89FnH5r8TskE7ExicU0K3fh9Ha--
