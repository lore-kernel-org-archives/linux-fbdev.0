From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Feb 2014 12:14:12 +0000
Subject: Re: [PATCH v2] video: exynos: Fix S6E8AX0 LCD driver build error
Message-Id: <52F8C294.5070200@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LoUXOwGTgN9T2QTCVi0Q4b7kJHXbjP22I"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--LoUXOwGTgN9T2QTCVi0Q4b7kJHXbjP22I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/01/14 13:00, Sachin Kamat wrote:
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
> index 976594d578a9..eb6f2b059821 100644
> --- a/drivers/video/exynos/Kconfig
> +++ b/drivers/video/exynos/Kconfig
> @@ -22,7 +22,8 @@ config EXYNOS_MIPI_DSI
> =20
>  config EXYNOS_LCD_S6E8AX0
>  	bool "S6E8AX0 MIPI AMOLED LCD Driver"
> -	depends on (EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE && LCD_CLASS_DE=
VICE)
> +	depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
> +	depends on (LCD_CLASS_DEVICE =3D y)
>  	default n
>  	help
>  	  If you have an S6E8AX0 MIPI AMOLED LCD Panel, say Y to enable its
>=20

Applied to 3.14-fixes.

 Tomi



--LoUXOwGTgN9T2QTCVi0Q4b7kJHXbjP22I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+MKUAAoJEPo9qoy8lh71mZ0P/RDEEazMaqK6YBQ4Jix9EGHe
C/uYpdqvwceNoHEESH2HA3+nLGTpCa3swNVgP5h4dKqB8zrz1v+qistPR37LumJ5
um/YsSjIAMXv5QcMUA0vLFN0cZS8ezdgmtOdbjQgLCIFqmlb3n+AFnATrH7vk5R2
+SvzMQzHLBL54+rIMkQ88Zdt43fxmiYwGyac28+WoyWLFn986o9t65j5EDexUfqM
yA/yFuZYLgBJX71TWDKtJzK7rbmpLpdZLpQsJVdZJlRykFlb/cTxLLreGd+HYRE1
S3RKrcsW2DNPdEU/8oL/CSJuDE7o3mo6BLKbwbav33IS0qBsrC88nw6PiuFqyVKF
eLA/B74jefEABnJJtyHhsgbCKk33okgHV5+V9dqlSTTqTTWkZot5HtEiUDKlP6Cj
ftDZQ3qVYxxA2Q1p9geNlSxe0of5u1zpa3P8tq1kIYS8h88pO6ZC+1yLl++53+Gx
sttndpIY04+ykdG6C6VgSRqclUoe+REVxLtZ0LLr8RpaI3ZxQ6c5ivF+sVxsIft/
9doHrrd7CDPfndy5usjtSizOjv2hFUkxyAokJu5d9ayOyB37E92TIf4mkNKx9rFX
Q7oYhcMu2yfqRW3aR3TjqDwV52tg42tty8Jg0rrVPo1R/Z2CR2YLZKx2c7rb/ogM
QRXBqB4h321it0dtedzh
=YfJZ
-----END PGP SIGNATURE-----

--LoUXOwGTgN9T2QTCVi0Q4b7kJHXbjP22I--
