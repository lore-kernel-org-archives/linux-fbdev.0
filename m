From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Jan 2015 07:46:12 +0000
Subject: Re: [PATCH] fb: via: turn gpiolib and i2c selects into dependencies
Message-Id: <54CB36C4.8050501@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Ap73dwuI7Jtr6RJ95TgLmqQd5KxNDEacF"
List-Id: <linux-fbdev.vger.kernel.org>
References: <3127720.VGEDzudcPs@wuerfel>
In-Reply-To: <3127720.VGEDzudcPs@wuerfel>
To: linux-fbdev@vger.kernel.org

--Ap73dwuI7Jtr6RJ95TgLmqQd5KxNDEacF
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28/01/15 22:12, Arnd Bergmann wrote:
> Device driver should not directly select subsystems. In this case
> we get build warnings like
>=20
> warning: (ARCH_REQUIRE_GPIOLIB && PINCTRL_AT91 && PINCTRL_NOMADIK && MF=
D_TC6393XB && FB_VIA) selects GPIOLIB which has unmet direct dependencies=
 (ARCH_WANT_OPTIONAL_GPIOLIB || ARCH_REQUIRE_GPIOLIB)
>=20
> which we can avoid using the normal 'depends on' statement.
>=20
> Also, this patch makes it possible for DRM drivers to have a dependency=

> on GPIOLIB without getting circular Kconfig dependencies.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index f2c3fb7d0399..b3dd417b4719 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1530,13 +1530,11 @@ config FB_SIS_315
> =20
>  config FB_VIA
>         tristate "VIA UniChrome (Pro) and Chrome9 display support"
> -       depends on FB && PCI && X86
> +       depends on FB && PCI && X86 && GPIOLIB && I2C
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
>         select I2C_ALGOBIT
> -       select I2C
> -       select GPIOLIB
>         help
>  	  This is the frame buffer device driver for Graphics chips of VIA
>  	  UniChrome (Pro) Family (CLE266,PM800/CN400,P4M800CE/P4M800Pro/
>=20

Thanks, queued for 3.20.

 Tomi



--Ap73dwuI7Jtr6RJ95TgLmqQd5KxNDEacF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzbEAAoJEPo9qoy8lh71eGUP/1LL74Mnu+vF+JkjdxhF+RZK
/PkPlbYEZP1hOZ4WXt6+gltpgabSIN5DpCagM7xkpX0BEWR5F5Rszc7RgsL+z/sI
5Kfybm68aGIK2m8gow5fjQnZHXlhIqXYsh41q5PzC9CRaa2mpYA1ikwrN5n/I+dZ
JLIOwgzwERWspq3iL56C0jcBicxjZVvEwMYGcFcWvd4AeLA7G3TQHNvE8D9cTjK1
55hl7rnJvvEjIvZLnEdeTFVD793q9/6/QCM0/LnrlG76Kx5S4vCtMvjVRihKRdZ8
SNLQjP4lL8v1ig8zH23fYVIBaH1VS32p57gzfpdUsGBsVeNJKJHQ0zh5+Ox17LQL
zMKj6wYtmD1E1jYybpqw9QC+LUV77t09IpfDarq+DtUreeilJoHzo9AnSBp/zdkF
v2ROmWBiHgZ7FaKqPGoK6B/0LV294dveSART180DA8+dYnh6NEPx20Q8XTAuL1mJ
Kl1GeLiSKJfeRsqIwKoULP2EcjnyWDC9H8KL6FyHeirr3k2OZhAK1fMc5aafg0jR
2dpkchz3cxStFfimNmCx8m5u1RoYL5TfzHUlArrfRdbhdfx/500B85aiEC9z+ejs
45rA71DIxtHbFZiITi6rwN+Cp9933/3+JGMlB3XP2rtnBIFktNYIxMFWkOsaqOHN
Q+7VhPuvpIrOA240APrz
=qtq6
-----END PGP SIGNATURE-----

--Ap73dwuI7Jtr6RJ95TgLmqQd5KxNDEacF--
