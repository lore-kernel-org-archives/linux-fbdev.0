From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Apr 2014 09:58:32 +0000
Subject: Re: [PATCH] video: imxfb: Select LCD_CLASS_DEVICE unconditionally
Message-Id: <5343C848.5020206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Ax8QXJ2ARKVC41hOXpeXGQwejPWpbD5x5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395298711-14619-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1395298711-14619-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--Ax8QXJ2ARKVC41hOXpeXGQwejPWpbD5x5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/03/14 08:58, Alexander Shiyan wrote:
> FB driver uses lowlevel controls for LCD powering and contrast changing=
=2E
> Since LCD class cannot be used as an optional feature and should be
> compiled for using in the driver, this patch selects LCD_CLASS_DEVICE
> symbol for the driver.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/fbdev/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 67409e0..b7cb0af 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -328,6 +328,8 @@ config FB_SA1100
>  config FB_IMX
>  	tristate "Freescale i.MX1/21/25/27 LCD support"
>  	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> +	select BACKLIGHT_LCD_SUPPORT
> +	select LCD_CLASS_DEVICE
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT

I presume this should go in for 3.15?

 Tomi



--Ax8QXJ2ARKVC41hOXpeXGQwejPWpbD5x5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ8hIAAoJEPo9qoy8lh713zkQAKZtOsFhoV2zBBSiHGK8pmUv
RYUyfov1SrrtnjQnh+b59zZi+WOtrfpyX8VdjXAhx5AzD4E+K8rUXzFcdpD8Mz1f
A5iYI24kBijBIEyccopnBL2L5MN4ZmurFEqUt4p897+jYbM1fgXMLQoWIPtFVTjt
jqrSuuERGUorcUfEcFpo23GOp+i1RLV5BN3hysimZeJik5cp7swmCNr/kO3u3xoc
bsFJg9geYBzfXymK31IsAf0NquiOqna0NGPWbJtPFyDeYsSRZdwChZ0GSNlV+sQf
zFU0zVll0AFVMzGKvtCFiSP+SrjJo870mF/3eEcUTCUyAQkdBgmM8DcMhze2hsoh
sNei2MR6gOpI1WX0oEIJoOVIfqGfl8pQUEAnIKvZ7ZY25c2ZQhRjXNI4N0GaRvPP
u+fHRL43SuSbXyDzuAYhYMGSXO0SvjjA3o33c7NRThZ4Ox1r6CVU+JGY4tMZNI70
sQcLdb4rrCreiQ9ZVnb8sh3vjNgLErXHqGzRcoxgVl5mfTErNiRWL23QE0nFBJK8
ADNFvbFHBuWWTUI5Uzuca6g6E0s0/NmrYAPOb0gKDsP/r7YHnEc9PAMsiQEWy2pH
QxgiEmlXuLkcL2ZOIBvYR+gJCBnnCKK9BOKEK5qgk2sqv/ZLbO4sm0AJx9eGlADd
tiDztaoLyop9C1+Gemnt
=8ILi
-----END PGP SIGNATURE-----

--Ax8QXJ2ARKVC41hOXpeXGQwejPWpbD5x5--
