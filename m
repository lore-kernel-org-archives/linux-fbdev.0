From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Apr 2014 11:05:21 +0000
Subject: Re: [PATCH v2] fbdev: Fix tmiofb driver dependencies
Message-Id: <5360D8F1.6020607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="960FIae1gDf5bJsvAl3pd5Sd5u2tugJ8j"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140424103258.4083cb69@endymion.delvare>
In-Reply-To: <20140424103258.4083cb69@endymion.delvare>
To: linux-fbdev@vger.kernel.org

--960FIae1gDf5bJsvAl3pd5Sd5u2tugJ8j
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/04/14 11:32, Jean Delvare wrote:
> The tmiofb driver should not depend on MFD_CORE but on MFD_TMIO.
> Without the tmio_core driver, tmiofb has no platform device to bind
> to and is thus useless.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> I suspect that MFD_TMIO was originally intended and MFD_CORE was a
> typo.
>=20
> Changes since v1:
>  * Added COMPILE_TEST as suggested by Geert Uytterhoeven.
>=20
>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-3.15-rc2.orig/drivers/video/fbdev/Kconfig	2014-04-23 11:51:17=
=2E163933232 +0200
> +++ linux-3.15-rc2/drivers/video/fbdev/Kconfig	2014-04-24 09:49:07.4330=
62918 +0200
> @@ -1993,7 +1993,7 @@ config FB_SH_MOBILE_HDMI
> =20
>  config FB_TMIO
>  	tristate "Toshiba Mobile IO FrameBuffer support"
> -	depends on FB && MFD_CORE
> +	depends on FB && (MFD_TMIO || COMPILE_TEST)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT

Thanks, queued for 3.16.

 Tomi




--960FIae1gDf5bJsvAl3pd5Sd5u2tugJ8j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTYNjxAAoJEPo9qoy8lh71yRUP/0RcE8PKMOhyNtnD7L/XvCh/
NPeSWtLKn4CJSyhh1dTOUXR9YgP1XBTAVsIzWtgIoqy48EPB7fkNyC5cnBbjVeUH
/WefhHwwVEB1CB1gSYOfGsp4Rb7r0uNE1bIxjzRSdCX2vE3pnzBcDosYILOImdn3
DYA4gnHk/HWg/NlVvI3xXdcI3UzwzGBQzbnDwcJBp1MlQeuvuWtn4V8iNoSshIe5
kU5cFJCwlVECaNcsMFR4g5U1/ZTLJ2cMyYPo+9gjGCTgkDK0URPpkLeKaMDX5iN9
UszUGIkkfpG2YJ1e29Nj6EIJS941IO+W8PJPJiIqGsVjYKR9TkKodfshuPyPhk7Y
z8zLsOW/RBo55Q9V/bgXjfoWUyr0PpUiyYpto14zMPsnoY2KekiNf8CLLrtg9Ck+
BP4wuvwb8tZ7GBHqMFlzaUORQhHcCejsiJGu5FuwZNZDZdjPnPfMfjpOH6sGeV2z
kV7QJPkUFxTcunjgEoDuCB1sJL29FDkIPRE/50H2lsUybenCTNte+ztW2thFFk06
Vw6epCEyyef2MxdYm0FDJMAYX17O5Pm5JIHp21Eb6CEmpF5Gcz/dhLNqfeLuyVwT
fFgOGzfOsxILV9zCmRV14aZ8vilFON08QP7syXSj2U2/7XwFft3o/x6OP6Tf4QdN
tk0a4F6cdfAofimdR9hf
=kjUz
-----END PGP SIGNATURE-----

--960FIae1gDf5bJsvAl3pd5Sd5u2tugJ8j--
