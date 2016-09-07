From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Sep 2016 08:14:13 +0000
Subject: Re: [PATCH v2 2/2] ARM: exynos_defconfig: Remove old non-working MIPI driver
Message-Id: <2b3688bb-8dcb-24d4-8112-a0cc56573e48@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1qjEoEhmkGsTUdk897kAhAEf8rfx1s1jj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1472730589-18683-1-git-send-email-k.kozlowski@samsung.com>
 <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org

--1qjEoEhmkGsTUdk897kAhAEf8rfx1s1jj
Content-Type: multipart/mixed; boundary="L5a7APrpX4cC10V518VcmxqhbXoAAfEAa";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <2b3688bb-8dcb-24d4-8112-a0cc56573e48@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: exynos_defconfig: Remove old non-working MIPI
 driver
References: <1472730589-18683-1-git-send-email-k.kozlowski@samsung.com>
 <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1472730589-18683-2-git-send-email-k.kozlowski@samsung.com>

--L5a7APrpX4cC10V518VcmxqhbXoAAfEAa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/16 14:49, Krzysztof Kozlowski wrote:
> The Exynos MIPI driver does not work anymore (it is board file only) so=

> it is removed.  Remove also config option.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> ---
>=20
> Changes since v1:
> 1. New patch.
> ---
>  arch/arm/configs/exynos_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exyno=
s_defconfig
> index 4e484f406419..fea8edef1534 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -168,7 +168,6 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=3Dy
>  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=3Dy
>  CONFIG_DRM_NXP_PTN3460=3Dy
>  CONFIG_DRM_PARADE_PS8622=3Dy
> -CONFIG_EXYNOS_VIDEO=3Dy
>  CONFIG_EXYNOS_MIPI_DSI=3Dy

EXYNOS_MIPI_DSI too?

 Tomi


--L5a7APrpX4cC10V518VcmxqhbXoAAfEAa--

--1qjEoEhmkGsTUdk897kAhAEf8rfx1s1jj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz8xVAAoJEPo9qoy8lh71jNoP/2W1oMY4iNR4gZDp+4w7mcoU
7npbg9Aj5HpvNRxVCrgvdQpooJ+FuH+XWeJ2qelgYZBVDy3Z6PenfizEt1Z+8myD
rXbuyTOwECWTNrsm628R/y7JIFRfpB6L5DFUQ+yq94uQ6YBtuStw4AtZdXKYK9LS
4BZunWdrBbTh4YLNU1vDjrsGSz1nTWckDW59mQsjnH4Fuy0vwXELmt+i+1yStbwg
eNVPkChT4lCDD3/ClFd7Cd3VHdkXzvJyX5/yV0VHpabuIKCNsIFS/KWjSEq2+2j5
Kj8PQ5jcmWTxBWF1wUM2zsmn2B3DPGMHgSvyDzoR8vi0h0cLpB99+fwQQlNr80GR
5r3hJawr/nDqGcfr1KeHjyn0m6CFaXZAeAwh9a0TaMglJSDf2uIxgJ5j8lDshtQx
orl/jd1Q3tdhTf4jLVJ/pUw5QbzEdq5sY+cHUT72q3svYWHC9u41PHVtXzW0ZN/8
HwFQiEcDhQD4PS4hr7I1H+zAUzbySmMIl5g+AQ2uUl+Jn/WWopfRSWXDVqVyaSy6
rQn9k31eKazTg2k+UxEN/H3ipELm/6tjZCAJPAYk5WwKHTAkxPgjIngOWDJ39XaI
BW3pupcq1vl0ZYtzN8mDviFAe7Mf5SxRTdwE59ZPWwqxMc0NVPszVu80eu8LfCjf
QoSlAALsrpQGMlPDqOAU
=8WS9
-----END PGP SIGNATURE-----

--1qjEoEhmkGsTUdk897kAhAEf8rfx1s1jj--
