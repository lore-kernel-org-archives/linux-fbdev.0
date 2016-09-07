From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 07 Sep 2016 07:32:44 +0000
Subject: Re: [RESEND PATCH 2/3] fbdev: vfb: add option for video mode
Message-Id: <37ff4b02-22d3-5d16-7684-6c91e9a19327@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UHwkUw1dSMiEmQ8mG9AHKsKAm9ewd9cfV"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--UHwkUw1dSMiEmQ8mG9AHKsKAm9ewd9cfV
Content-Type: multipart/mixed; boundary="2WveTdX2dMO9wkfTSwWbAauKN9l0hhXWf";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Vladimir Murzin <vladimir.murzin@arm.com>, linux-fbdev@vger.kernel.org
Cc: plagnioj@jcrosoft.com
Message-ID: <37ff4b02-22d3-5d16-7684-6c91e9a19327@ti.com>
Subject: Re: [RESEND PATCH 2/3] fbdev: vfb: add option for video mode
References: <1471255832-44793-1-git-send-email-vladimir.murzin@arm.com>
 <1471255832-44793-3-git-send-email-vladimir.murzin@arm.com>
In-Reply-To: <1471255832-44793-3-git-send-email-vladimir.murzin@arm.com>

--2WveTdX2dMO9wkfTSwWbAauKN9l0hhXWf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15/08/16 13:10, Vladimir Murzin wrote:
> Make vfb a bit more flexible in sense what it can represent and allow
> the end user to specify video mode parameters via newly introduced modu=
le
> option "mode". Since it is test module it is still up to the end user
> to make sure there is enough memory to satisfy video mode settings.
>=20
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  drivers/video/fbdev/vfb.c |   43 +++++++++++++++++++++----------------=
------
>  1 file changed, 21 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> index e9ecae2..2645875 100644
> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -37,6 +37,10 @@ static u_long videomemorysize =3D VIDEOMEMSIZE;
>  module_param(videomemorysize, ulong, 0);
>  MODULE_PARM_DESC(videomemorysize, "RAM available to frame buffer (in b=
ytes)");
> =20
> +static char *mode_option =3D NULL;
> +module_param(mode_option, charp, 0);
> +MODULE_PARM_DESC(mode_option, "Preferred video mode (e.g. 640x480-8@60=
)");
> +
>  /*********************************************************************=
*
>   *
>   * Memory management
> @@ -86,26 +90,17 @@ static void rvfree(void *mem, unsigned long size)
>  	vfree(mem);
>  }
> =20
> -static struct fb_var_screeninfo vfb_default =3D {
> +static struct fb_videomode vfb_default =3D {

I think this can be const.

 Tomi


--2WveTdX2dMO9wkfTSwWbAauKN9l0hhXWf--

--UHwkUw1dSMiEmQ8mG9AHKsKAm9ewd9cfV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXz8KcAAoJEPo9qoy8lh71xBMP/166l3+TR2fZ3aesmAnCjbpC
byadJ9L5hhwpNsWWZdUMjcjV8UfHkBvCLkBkY/R4pzQvn+advZCCk/VBQAK9SnKR
k6TKZtmGy3l++i8t9KajX9nM+LY9WQqNeG5RKxIgb6mJTLgdUfIrnFa6L6BfcFoD
eey+6Jhf+wbnsrpvJEMHramKDLR80LC3nWs9p0gmpc7BYnd2oiwBtbMeQnEBDwJw
oCJDODbWR75wTVlhClycCPxwxEZHSZ8tJkRN1QyaOLmSNtCkxyf+zGLFLyTHaVjD
GCK9P1ZomHvAd9LG340lLRFqRUHBckfjK23sxdP/NLlL34mlxz1cZ0Vd1/Hallm9
KSex+XwBNruPYzmd6Ab3iCuOWWJIUcZ9eOlDf6rwh8a3suaGeR9ZtCT0YFDs6qLu
d5JTl+3361SY0JMfDbzT5XvW4dnN703LDsl8uskqY7b3lwWxxXQOOgksH2RvaXoP
rv4i5LPz+qjxDtBkmJSi34YuQTD2tBJY/zK5N3bqC1DrX4FGF6hMwPKfyncdd9Va
3I4d/1Vc0FSOOSGXduC5ZDFuCBB0ZwzVsj6BgQl4zkKaMQc412R+6Zb+P2DK6Q4X
Ntj2BaWwp8t9XNfCewE8a3Uku3yjnHVFAlttouuu8okbXUyBXDCLjAytwnZ1IgvD
5wB2gaD4+ITEBenPq0lP
=zCEF
-----END PGP SIGNATURE-----

--UHwkUw1dSMiEmQ8mG9AHKsKAm9ewd9cfV--
