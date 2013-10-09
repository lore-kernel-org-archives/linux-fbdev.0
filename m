From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Oct 2013 08:32:51 +0000
Subject: Re: [PATCH V5 4/5] video: exynos_mipi_dsim: Use the generic PHY driver
Message-Id: <525514B3.5020101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="a8T2haWrXK6ruBtq3o4xKIJi7hRpSSLdC"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380396467-29278-1-git-send-email-s.nawrocki@samsung.com>
 <1380396467-29278-5-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1380396467-29278-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org

--a8T2haWrXK6ruBtq3o4xKIJi7hRpSSLdC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/09/13 22:27, Sylwester Nawrocki wrote:
> Use the generic PHY API instead of the platform callback
> for the MIPI DSIM DPHY enable/reset control.
>=20
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Donghwa Lee <dh09.lee@samsung.com>
> ---
> Changes since v4:
>  - PHY label removed from the platform data structure.
> ---
>  drivers/video/exynos/Kconfig           |    1 +
>  drivers/video/exynos/exynos_mipi_dsi.c |   19 ++++++++++---------
>  include/video/exynos_mipi_dsim.h       |    5 ++---
>  3 files changed, 13 insertions(+), 12 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--a8T2haWrXK6ruBtq3o4xKIJi7hRpSSLdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSVRSzAAoJEPo9qoy8lh71aIUP/ip7AKSl0M3FzPosW3jPK1P/
+B9hdF8oHurGip1xB/yoqed/HCcFf7oZpv7JQ86h3mfVBEqjFym0SyMGGhBsAaDz
PmCiw4HfvNZLH4qqvAQKBcrFYgDwBU1LH56OIqpAjP4xMZztkFOOpdLLOPsRvuO0
zrKlvpe+gk6D66b2aebfFFdofobNeacaqmFTgvadNFkJpIR8YiXb3Bl+B7ST7tvR
0X/UJw+5Cv2uX8vf03LKxoSrgOTFO82WhXF9qKfNleve5wQnL7awbIf/M9u9oq3K
qbTsQNFUUX1Ny14hjhjPJSaKTG/USyCOZpZsCCyY9ssdumqF1hmZZ52O9od+fVYV
v1+vOPNxSD2MGgt/Dr1fiqszq33q2l/Eeos18y/vRvXmidI3toURPygy6A2ARoPv
x8ytxT9C2T3X4u7undt6lcFhDorveRlahaxZIMXpATnbwMkz+C+t+qG8iI8aeEvo
50M+EfTZEtEs8wJZ8PYcTXq7qJ0qrB8GpoxPP5LNOjPRmPx8fjcC8QaTCZSrK9TC
U0YcnlqT+BvN9uc9ZGeyk+ed+noWRmgKfAeLPZWlWQZtp8ihImlWzHQ88zSSz+rM
BAVcuiDy7GosFpKsSzgUn9DGwfbp+8jn/R84MMgnyzlpDTeoZFUc45aUNyuYCTVK
5dsAg6qGrZGfqZqO/Vx3
=NCZf
-----END PGP SIGNATURE-----

--a8T2haWrXK6ruBtq3o4xKIJi7hRpSSLdC--
