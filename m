From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Jul 2014 06:22:12 +0000
Subject: Re: [PATCH V2] MAINTAINERS: Update Framebuffer file patterns
Message-Id: <53B25394.8060906@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uXqfl60DCE4JNtr6O1Ag22WDGvKfijomV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <000801cf94e0$d5856cb0$80904610$%han@samsung.com>
In-Reply-To: <000801cf94e0$d5856cb0$80904610$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--uXqfl60DCE4JNtr6O1Ag22WDGvKfijomV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/07/14 06:59, Jingoo Han wrote:
> Since the commit f7018c2 "video: move fbdev to drivers/video/fbdev",
> all framebuffer drivers were moved to fbdev directory. Thus, file
> patterns of these framebuffer drivers should be updated correctly.
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Changes since v1:
> - Fix the typo from 'fbdevwmt_ge_rops.*' to 'fbdev/wmt_ge_rop/*', per L=
iu Ying
>=20
>  MAINTAINERS |   76 ++++++++++++++++++++++++++++++---------------------=
--------
>  1 file changed, 39 insertions(+), 37 deletions(-)

Thanks! I was planning to do this but I seem to have forgotten about it..=
=2E

<snip>

> @@ -3707,7 +3707,8 @@ FREESCALE DIU FRAMEBUFFER DRIVER
>  M:	Timur Tabi <timur@tabi.org>
>  L:	linux-fbdev@vger.kernel.org
>  S:	Maintained
> -F:	drivers/video/fsl-diu-fb.*
> +F:	drivers/video/fbdev/fsl-diu-fb.c
> +F:	include/linux/fsl-diu-fb.h

You have a few of extra changes like the above. I'd rather have the
"update file patterns" patch doing only that, and make the new changes
in a separate patch.

 Tomi



--uXqfl60DCE4JNtr6O1Ag22WDGvKfijomV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTslOUAAoJEPo9qoy8lh71uX0QAIw47Zgh7aagIV2jnrzaiLdZ
w+7Azq249w1t6tb9DkM6gybPGISDdLyV9wRPFCQjyM1nTbpMiXrTJJC336WJiZFf
BhXmeGI0O0gmsa8a9xSMY0pniurCOy4dIFDd8rf7pfF6gI8SETSyLVfRFesuJfSc
DSV7Yug2pUpz3rvLb5zds8cIxrLISo2BKYwrKEcaQmYNtQ9gqX5rByTpIcYYWGwn
Elb90U8G6cvqo9O9XmKfjboUFR/AEQegENyOTYwgMRAX2RTngQgimiu6JzD002h8
N8KIq89Owq0Q8riih10FJU1n3WGVHDtSZvGsDXRKsVV0W3Ul4pFCRN/VukVYaZSl
uqTukpnYpH2M7KOlMzqrAhUqgC+Kmqa4z3XOG3v56XZ0cz4dnO7VesXj8NN6O3HR
8CSN3FdhbQgUknKhLw0qrL2GDO/UhISd/Y0fNojQPGvDCWOLoQnN3sGZv04gpzFr
/Au/Ng9UQrNVDgX793MCDlNAT/oT0Jk0HKK+ktV/LIC6Np5FeolAtCdOpTSXeufq
XOU7qq/FxKPs2gejGZWwgEqLB8G1eLTc3VVTxibN9c8xzGr7mgYWMTySmw1c99hu
QTMGI944znra9jnVepUbN+yLRlSBWhrqwGIGRrexoH1AtGKro9DrLbAaufDn9yle
xd6rYbyPwz0GvDDXF7Jr
=OcGq
-----END PGP SIGNATURE-----

--uXqfl60DCE4JNtr6O1Ag22WDGvKfijomV--
