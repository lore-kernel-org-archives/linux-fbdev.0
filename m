From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Jan 2016 11:42:40 +0000
Subject: Re: [PATCH] fbdev: da8xx-fb: remove incorrect type cast
Message-Id: <56AB5030.5040203@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qoQGWTxVrrKd8ESPkFqvB958xkF6dXWmD"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453734351-1958373-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1453734351-1958373-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org

--qoQGWTxVrrKd8ESPkFqvB958xkF6dXWmD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/01/16 17:05, Arnd Bergmann wrote:
> The probe function correct passes a dma_addr_t pointer into
> dma_alloc_coherent(), but has a cast to resource_size_t, which
> might be different from dma_addr_t:
>=20
> drivers/video/fbdev/da8xx-fb.c: In function 'fb_probe':
> drivers/video/fbdev/da8xx-fb.c:1431:10: error: passing argument 3 of 'd=
ma_alloc_coherent' from incompatible pointer type [-Werror=3Dincompatible=
-pointer-types]
>=20
> This removes the cast, which avoids the warning.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/da8xx-fb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, queued for 4.5 fixes.

 Tomi


--qoQGWTxVrrKd8ESPkFqvB958xkF6dXWmD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq1AxAAoJEPo9qoy8lh71uZYP/2vk/dSiy/p/QzQKuFkOlM/h
h924d4gDltsbKsNb+V/4HL1xm3a37N+11tmpKcyCnAcpTIXHT1CL/0HtwiyjeMHH
GZ9BYEKSCSTsdLL4+Nc2vE6l8JMhHpCtTin+fW2FM19QxH0gRfVfv0PHIbdzA5lh
5X7C6Pm6a3dOEYBpYuOWyJgBabYKfAs94zwbAL0oDXraHQoqS9Txj+Ga7LcP8wRy
+rlgaCUj1Y70OjFxbrG7TekmmkN8w57ekTJyp9mjOa2OThuaRro3xAt2AJ6L58y2
1nzXvpFSDu5nTtXWRy/li8zSaDY9xNKWL8T7HJ7N0weMkHf8qZcC/asIObXMpbSj
JpKjJjawsau1NHuuWnH19PJxN5UNsGzdILKYscLEkjfPHUx/m2kXoOsVQjdQCmMD
AsyEslFei3lgv9FJf6W4W+uUQRNfoPrJybHKTKovIBMGtVJbwFlUzAWmqijnmpK5
IiNkF4dIr1fEzK3U8/ZItnB/Y8vXgsmYV90uKgqqoUYinMXeMYU6KkWFwRgD9q9a
yrzNDhfHLr0R3zUVIcM40ibRcYl85wVyODJQ6yBAa3ETGG4oUkWUs60DEmqkZoiA
moH34d9+CBC4D2OC5tMIKx6ieetBP1TFNd8fnEeD2cNx05vak+a/WA4mJhv6xEhi
c1hSpV5zQex3MmG63AzP
=8AGI
-----END PGP SIGNATURE-----

--qoQGWTxVrrKd8ESPkFqvB958xkF6dXWmD--
