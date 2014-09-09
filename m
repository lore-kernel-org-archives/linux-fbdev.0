From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 09 Sep 2014 10:58:53 +0000
Subject: Re: [PATCH] video: mx3fb: always enable BACKLIGHT_LCD_SUPPORT
Message-Id: <540EDD6D.6070704@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gkjDwDUWTw26ppvSlcQj8f8tXMbDj7QG8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4032283.arT8F9Ogcl@wuerfel>
In-Reply-To: <4032283.arT8F9Ogcl@wuerfel>
To: linux-arm-kernel@lists.infradead.org

--gkjDwDUWTw26ppvSlcQj8f8tXMbDj7QG8
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/09/14 18:17, Arnd Bergmann wrote:
> Commit 7edaa761ee81b ("video: mx3fb: Add backlight control support")
> changed the mx3fb driver so it always selects the BACKLIGHT_CLASS_DEVIC=
E
> symbol, but that is hidden behind BACKLIGHT_LCD_SUPPORT in Kconfig, so
> we get a Kconfig warning for multi_v5_defconfig, which doesn't have tha=
t:
>=20
> Warning: (DRM_RADEON && DRM_NOUVEAU && DRM_I915 && DRM_GMA500 &&
> DRM_SHMOBILE && DRM_TILCDC && FB_BACKLIGHT && FB_MX3 && USB_APPLEDISPLA=
Y
> && FB_OLPC_DCON && ASUS_LAPTOP && SONY_LAPTOP && THINKPAD_ACPI &&
> EEEPC_LAPTOP && ACPI_CMPC && SAMSUNG_Q10) selects BACKLIGHT_CLASS_DEVIC=
E
> which has unmet direct dependencies (HAS_IOMEM && BACKLIGHT_LCD_SUPPORT=
)
>=20
> This makes sure we always enable both symbols together for mx3fb, like
> we do for the other drivers that can't be built without backlight
> support. Note that a better solution would be to ensure the driver can
> work with or without backlight support.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Alexander Stein <alexander.stein@systec-electronic.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index ccbe2ae22ac5..c7bf606a8706 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2356,10 +2356,11 @@ config FB_MSM
>  config FB_MX3
>  	tristate "MX3 Framebuffer support"
>  	depends on FB && MX3_IPU
> +	select BACKLIGHT_CLASS_DEVICE
> +	select BACKLIGHT_LCD_SUPPORT
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -	select BACKLIGHT_CLASS_DEVICE
>  	default y
>  	help
>  	  This is a framebuffer device for the i.MX31 LCD Controller. So
>=20

Thanks, queued for 3.18.

 Tomi



--gkjDwDUWTw26ppvSlcQj8f8tXMbDj7QG8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUDt1tAAoJEPo9qoy8lh71gBMP/RPpbcmV0TuFPD7SFyJuhWmd
rr3l3fOgV4aymCW8hmfR3pVeju9QG5ttH1KtoYP2Ue9fJCPb2Co6byckojdcXyiT
Ml7ZZYMBLYw8i4oZvmQNL5mhJhpQVn0HpZf1C8BHhsinpOrOlzoAaaxvWz3wHpK0
vKoJtoBJihTlARCa6wrnZOIgnl1bldc806HAPi+b5EYZQx9vD2oM6VbIK30rX3Xx
7MwlzDULIljG6Eam72B9VnSAvDXSslzth4n/XnGcaSkk7JQ6E1yU771q9a5HOlir
dtuVDSX+DpEsa+QSpjygss6tz83tnaZ6OGQL0TG6RqV1whKZv9Uzq76ULjlbnXeW
v9I8jNKQGGAacxOfFOnz2pq6PQqpB0bqK+rZGtpOJ05Jf5htBPGd6sOIaHunJgou
qc362KMdKFcWHjtj45Re5bNy7ZxjRJLUo4L6bVPJk/OQzunfDhoIF9KAvS1P+l01
xuqA920KVQIjkH8Jy4l5Hj54OCPrQtsnGhOf20xIEoAWJ551FZNVheiTsloUDiYI
M897sCKiGB+zlOmTH1OrdN4aUXNUtXSRazHdNHTI/yPmjgrtG7erAZWy8I4F8NA5
50dIfXbh7j44BAUenXdyc0OQ4zna7Vn26MTtST8a7SqupUCl6Tx3oE8zaTHqXRf6
hK+eKZR0YCPnJgkTrX4F
=KZZo
-----END PGP SIGNATURE-----

--gkjDwDUWTw26ppvSlcQj8f8tXMbDj7QG8--
