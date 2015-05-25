From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 25 May 2015 05:43:38 +0000
Subject: Re: [PATCH] video: omap/h3: fix tps65010 dependency
Message-Id: <5562B68A.6030608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NwOFECEr9NMCrtWTs1u7xkh5vPs5XnQMA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4416278.oVFvT3Eyqf@wuerfel>
In-Reply-To: <4416278.oVFvT3Eyqf@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--NwOFECEr9NMCrtWTs1u7xkh5vPs5XnQMA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 22/05/15 17:22, Arnd Bergmann wrote:
> The h3 LCD driver fails to link when tps65010 is configured
> as a loadable module:
>=20
> drivers/built-in.o: In function `h3_panel_disable':
> debugfs.c:(.text+0x206ac): undefined reference to `tps65010_set_gpio_ou=
t_value'
> debugfs.c:(.text+0x206cc): undefined reference to `tps65010_set_gpio_ou=
t_value'
> drivers/built-in.o: In function `h3_panel_enable':
> debugfs.c:(.text+0x206e0): undefined reference to `tps65010_set_gpio_ou=
t_value'
> debugfs.c:(.text+0x20704): undefined reference to `tps65010_set_gpio_ou=
t_value'
>=20
> This clarifies the dependency so we can only select it if
> the dependnecy is built-in.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> diff --git a/drivers/video/fbdev/omap/Kconfig b/drivers/video/fbdev/oma=
p/Kconfig
> index 18c4cb0d5690..29d250da8a3e 100644
> --- a/drivers/video/fbdev/omap/Kconfig
> +++ b/drivers/video/fbdev/omap/Kconfig
> @@ -42,7 +42,7 @@ config FB_OMAP_LCD_MIPID
>  config FB_OMAP_LCD_H3
>  	bool "TPS65010 LCD controller on OMAP-H3"
>  	depends on MACH_OMAP_H3
> -	depends on TPS65010
> +	depends on TPS65010=3Dy
>  	default y
>  	help
>  	  Say Y here if you want to have support for the LCD on the
>=20

Thanks, queued for 4.2.

 Tomi


--NwOFECEr9NMCrtWTs1u7xkh5vPs5XnQMA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVYraKAAoJEPo9qoy8lh71sTIQALGpHFezDm0ldTpuhy1fIMe1
AcrtAWJqX/fGSkS8wwdBiMsKoR8T8DgGVRJFEDjAu+qK3nx9hfACCCoOnPn5AG5V
Zf1On+Lxf/T7gzBk4S9X5YI25sPUbVQuWwbensmgLRGFG4xlCYTc3XTD0dJq2Gz9
am1xBWY/gCioo6ATXz8mZddoKLveuSu3R7dEnpvH4TGp5EFBD8Cpm7t2AeXhoMyd
TD6SdGlaj07J6qbnMNmqS/G6+GbSOhQBnE/yAd7FcMMqXFjxTD3+lAAQ7HRFQi0u
YR9tMgC9auIi6nZULcXiOxlIxMPZEjGGT9fe2fMDA/ypSj7q2xE7n6+mca6aR0xN
r07QLJp/k3nqLndOnprWLyBX/olNYHQz5L0yiqvEk1EZ7K2EQ5QBC73GWrZMEQUQ
SXCKlop0CPypnp4wG+R3/dBQB5F8ckGvSU5VPVyKI+qqfdBYbBMZUvaiO+Z0oHkf
+Jtl9upLT/jqZmWCGQsjXJY7qKCsdLrTHFWkdQQfrXHRuaWJJJDHNN/wSMRaAQ0J
nEjtW5bFK651dUegD1Y3vqgh1apiwMvK1JyDbe0Ky0GymA//Wx5+TZEv9p1Mbfgl
iZAkZkQhCaoUILl3oXdMq3t6H0F8zt4+Z0Hvr+VDlhav7xpZOop+gLI6bcf81iRE
ZE0kYaxHDN1Hpic3rAuQ
=plML
-----END PGP SIGNATURE-----

--NwOFECEr9NMCrtWTs1u7xkh5vPs5XnQMA--
