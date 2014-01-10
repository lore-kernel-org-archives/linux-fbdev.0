From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 10 Jan 2014 11:27:59 +0000
Subject: Re: [PATCH] video: amba-clcd: Make CLCD driver available on more platforms
Message-Id: <52CFD93F.7010502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EB2dV6ulTV1hCh9xCrBB27lXDCnB10OCB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386868390-12231-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1386868390-12231-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org

--EB2dV6ulTV1hCh9xCrBB27lXDCnB10OCB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-12 19:13, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>=20
> The CLCD driver is used on ARM reference models for ARMv8 so add ARM64
> to the list of dependencies. The driver also has no build time dependen=
cies
> on ARM (stubs are provided for ARM-specific DMA functions in the code) =
so
> make it available with COMPILE_TEST in order to maximise build coverage=
=2E
>=20
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/video/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 4f2e1b35eb38..e6c7fb1a389b 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -312,7 +312,8 @@ config FB_PM2_FIFO_DISCONNECT
> =20
>  config FB_ARMCLCD
>  	tristate "ARM PrimeCell PL110 support"
> -	depends on FB && ARM && ARM_AMBA
> +	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on FB && ARM_AMBA
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>=20

Queued for 3.14.

 Tomi



--EB2dV6ulTV1hCh9xCrBB27lXDCnB10OCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSz9k/AAoJEPo9qoy8lh71GBEQAK1wbp4hw7Eh7f0/5Jqq/TZw
WfWz2Ha6QVrn9VoIILOaG/yhWlTofHCfqL/wdbmVU9F7XT4dKyfHh2kbEkl+jq6s
2VNbefDUN+1XF4tUtVWXYuzHzhtexcez4uZxMAp918H/KYH8jxoX2zPkPWkEWr8H
QXNu/+yRjmXqFZuqGXM2EsGcN4nyQCBkUX6TIDurdWvtWVPX2c1uupw8tuUH4miS
pMo62V3mhCT71m+eGMRERvgT8WSKI3S2yzpG/i2al6E//IjCx5XTbKnuYYYb1Vog
0DxxEZPAktAL3W6WQbaNbiTu4XyCs+2YDnK1a+8+kmuO/6YEtqP7LMFWylrUdZGm
BS/NVpHlzO0AzuTxvx3BcgBw4bmL4YAvXT3kBGKvrVhOG4XuK4UERTqS4VMUvFEj
VJcpxUkHLWdyMJ3FntShJbGcguQUXA/f9e8uYbbgJPbEBuP8u6YI3Ke6HU+tHO88
UQO5zn6xWxyyjg474CIAH8xQQIevefvV+jX63dcatUuPwbXnbaRsRQKNxlW/1vJb
2WOilrUbyV6yptUzgVJp89KvG6wp7HX+O6BhUHaIET6KXDNDf8zHVsgzJo/npAey
pPd32dCoJJDVsXa1xBOKn8tBo1Ig3WrQc+g38SluEgguaw6TVt2JBc+Bp+3mtJw1
7iMWn4RNetzSscjBQOmP
=7tJ2
-----END PGP SIGNATURE-----

--EB2dV6ulTV1hCh9xCrBB27lXDCnB10OCB--
