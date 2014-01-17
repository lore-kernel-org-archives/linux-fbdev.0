From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 17 Jan 2014 10:22:48 +0000
Subject: Re: [PATCH 2/2] video: exynos: Fix S6E8AX0 LCD driver build error
Message-Id: <52D90478.3040504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="v0HbXGw0RsPWSl2lBDOEWCe0tdPSAs2Nd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-2-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--v0HbXGw0RsPWSl2lBDOEWCe0tdPSAs2Nd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-17 06:32, Sachin Kamat wrote:
> Enable S6E8AX0 LCD driver only if LCD_CLASS_DEVICE is a built-in driver=
=2E
> Else we get the following errors due to missing symbols:
> drivers/built-in.o: In function `s6e8ax0_probe':
> :(.text+0x51aec): undefined reference to `lcd_device_register'
> :(.text+0x51c44): undefined reference to `lcd_device_unregister'
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfi=
g
> index 976594d578a9..7e19b467b8f7 100644
> --- a/drivers/video/exynos/Kconfig
> +++ b/drivers/video/exynos/Kconfig
> @@ -22,7 +22,8 @@ config EXYNOS_MIPI_DSI
> =20
>  config EXYNOS_LCD_S6E8AX0
>  	bool "S6E8AX0 MIPI AMOLED LCD Driver"
> -	depends on (EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE && LCD_CLASS_DE=
VICE)
> +	depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
> +	depends on (LCD_CLASS_DEVICE !=3D m)

Hmm, doesn't that say that LCD_CLASS_DEVICE can be y or n (i.e. !=3D m),
so it could be disabled also?

 Tomi



--v0HbXGw0RsPWSl2lBDOEWCe0tdPSAs2Nd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS2QR4AAoJEPo9qoy8lh71bBwQAIQe7mZ5CXdxgdWPAhyZmirg
fgnwG8qs2FJMRdUD4q/uCkX8DoD6MWjX1QSldmnL79sVMZKRr2EcUoma/2c+vCwU
JZuXto/9uMAN7MAIlZHKkVRDYI0QRIewj2jgJ6YnN32We6p/8gENcVNKOdsOQ7oS
XUuJlzIHXulqFcMmEJRXv5/pzVzk+PhGDJR3uokRaneVuqhBx1dSrlcWLK7dw9lj
bv1aklYCbEm0SCOJ2cAccpS0iBRAZPg1m7sBfoWrYS0oBM3mQQSDslirkLrtBGun
cwEfKlNiuUSXYIYWBkmQ+reoZ2A/qkrfjencnWUk/9DCDyCgV5tqsXaS7ZbHblSb
TdUVKRjb5vfKeRRi7ddprgpYJ7JyltxkkkNWeREX+KgumbSh7ENA0w65woxQzcJ3
GiiJXJmtf/vyRj4mKvXgSoV3duXSWT1Sco9Db/IpDOqWDce5Fpe1G45RogsRUonF
z7WShWC155mZjcZHsVsXDI+mFT7c4n+nUDTg/xFu2G+7iw91VMpDKGHvvQzy9yYx
mkzDPTBRHcs5/u7SOWLAL9Cm7LvAl3zx8xJaMaOvb6PP4Kw6SapxazpGo1irR/o/
RKiGeh9v42FOjn70iWuMzPRyhb/jqGpIpsLiemgc1pHSABryk+/IDslu4QGJHazt
2ajLj/Qcqpdc4GiRkbex
=gbzp
-----END PGP SIGNATURE-----

--v0HbXGw0RsPWSl2lBDOEWCe0tdPSAs2Nd--
