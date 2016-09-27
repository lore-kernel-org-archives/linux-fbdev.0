From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:06:45 +0000
Subject: Re: [PATCH v3 2/2] ARM: exynos_defconfig: Remove old non-working MIPI driver
Message-Id: <0e4921a8-ac07-8760-bd64-ec0528bbcd9a@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SGug7GK0mCndfr9D7PdrQMTAAJ7E9RrFx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474014760-23173-1-git-send-email-k.kozlowski@samsung.com>
 <CGME20160916083252eucas1p12f57a9bc08176e10b8e07c3b421bb0ad@eucas1p1.samsung.com>
 <1474014760-23173-2-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1474014760-23173-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org

--SGug7GK0mCndfr9D7PdrQMTAAJ7E9RrFx
Content-Type: multipart/mixed; boundary="cUXB1nO098FCewnVrWFUxdcUOWKmINq3U";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Inki Dae <inki.dae@samsung.com>, Donghwa Lee <dh09.lee@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Message-ID: <0e4921a8-ac07-8760-bd64-ec0528bbcd9a@ti.com>
Subject: Re: [PATCH v3 2/2] ARM: exynos_defconfig: Remove old non-working MIPI
 driver
References: <1474014760-23173-1-git-send-email-k.kozlowski@samsung.com>
 <CGME20160916083252eucas1p12f57a9bc08176e10b8e07c3b421bb0ad@eucas1p1.samsung.com>
 <1474014760-23173-2-git-send-email-k.kozlowski@samsung.com>
In-Reply-To: <1474014760-23173-2-git-send-email-k.kozlowski@samsung.com>

--cUXB1nO098FCewnVrWFUxdcUOWKmINq3U
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16/09/16 11:32, Krzysztof Kozlowski wrote:
> The Exynos MIPI driver does not work anymore (it is board file only) so=

> it is removed.  Remove also config options.
>=20
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Donghwa Lee <dh09.lee@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> ---
>=20
> This does not really depend on patch #1. The driver is dysfunctional an=
d
> it does not work so defconfig change can be applied separately.
>=20
> Changes since v2:
> 1. Remove also EXYNOS_MIPI_DSI, pointed out by Tomi Valkeinen.
>=20
> Changes since v1:
> 1. New patch.
> ---
>  arch/arm/configs/exynos_defconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exyno=
s_defconfig
> index 4e484f406419..c58f6841f8aa 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -168,8 +168,6 @@ CONFIG_DRM_PANEL_SAMSUNG_LD9040=3Dy
>  CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=3Dy
>  CONFIG_DRM_NXP_PTN3460=3Dy
>  CONFIG_DRM_PARADE_PS8622=3Dy
> -CONFIG_EXYNOS_VIDEO=3Dy
> -CONFIG_EXYNOS_MIPI_DSI=3Dy
>  CONFIG_LCD_CLASS_DEVICE=3Dy
>  CONFIG_LCD_PLATFORM=3Dy
>  CONFIG_BACKLIGHT_PWM=3Dy
>=20

Thanks, queued these for 4.9.

 Tomi


--cUXB1nO098FCewnVrWFUxdcUOWKmINq3U--

--SGug7GK0mCndfr9D7PdrQMTAAJ7E9RrFx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6iiWAAoJEPo9qoy8lh71TrIP/2IX3oE84NZK1SDCFCvLQu3L
0HUvLwq7XfIphEs9Zor4PV1pmYSXgOL9k5pkjMZEzPoNZbUaiRCq71Kbpp+55Q8t
t8cjX+1oWXNGxImdwLBHiQego3opr7SsWA8DsGR3/EsOadi9v2UIH00v0e+F7o09
n8XMRSVV/5VMGf9ARPYGzR4Cg3Zvr1FZ/suQzc6Gig3eB+7D06iA42V5tIfZC+Lc
0zYW8TQIlm+YPLjPnx//kQxvV2i1AmuGGYKHThhkyvLklo83u/noyqxXXFQ5RXzS
PJPHRUG6lbjTclefcBueLucBj/toubSatgyN2g+Nqu1ytUSLqzFhv9k9NeILGm+l
7qzlwr4f9MYtGygZUzCPDALSzgt3W9wLxGca1XsVY1bKziUmPOAarFt6K3i6R3jj
UW+3RDi7EqmF/j5uvnsZnXyzQ7MT/vNOjy5QkH1BtSElfmTpaq2ZBzQITtWnK+sg
oa4TWt8Zo7NPvr4ZABnUyW+gRUDWlFpYDe6XIi6RIX8z4CQX9kAN8rueKkNnLRSO
NRh4fM+Dap9g8g8OwCDUEuNDSmoH9Lh0zq8gvogHTQXJrrABkfE08SG0mnS26rFt
IcS6P2go+Ip4LTtpMG40StTlpTIu7xecdLb3qfqgeVFD3MmR9xoNlkcEOz8iOnO2
ciRQtDUKjqQZKT0CVrl2
=qaUe
-----END PGP SIGNATURE-----

--SGug7GK0mCndfr9D7PdrQMTAAJ7E9RrFx--
