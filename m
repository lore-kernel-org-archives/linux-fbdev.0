From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 13 Jan 2015 13:19:06 +0000
Subject: Re: [PATCH v2 2/2] video: Drop superfluous "select VT_HW_CONSOLE_BINDING"
Message-Id: <54B51B4A.1080007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="POWMPf7D1hriFuMoMTek3grbd0ltS2h7O"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421093413-26336-1-git-send-email-geert@linux-m68k.org> <1421093413-26336-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1421093413-26336-2-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--POWMPf7D1hriFuMoMTek3grbd0ltS2h7O
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/01/15 22:10, Geert Uytterhoeven wrote:
> commit 765d5b9c2b72f5b99722cdfcf4bf8f88c556cf92 ("fbdev: fbcon: select
> VT_HW_CONSOLE_BINDING") made FRAMEBUFFER_CONSOLE always select
> VT_HW_CONSOLE_BINDING, but forgot to remove
>=20
> 	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>=20
> from the individual drivers' sections that already did this before.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v2:
>   - Split in two (drm and video) patches.
> ---
>  drivers/video/fbdev/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 4916c97216f880fc..f2c3fb7d03992ad1 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2151,7 +2151,6 @@ config FB_PS3
>  	select FB_SYS_COPYAREA
>  	select FB_SYS_IMAGEBLIT
>  	select FB_SYS_FOPS
> -	select VT_HW_CONSOLE_BINDING if FRAMEBUFFER_CONSOLE
>  	---help---
>  	  Include support for the virtual frame buffer in the PS3 platform.
> =20
>=20

Thanks, queued for 3.20.

 Tomi



--POWMPf7D1hriFuMoMTek3grbd0ltS2h7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtRtKAAoJEPo9qoy8lh71IPcP/jf6a3gUtaLlBoPltU2JJtFB
U+9EFtx6kAL37B1C2byrjouk/XBBRL2WvfHWuA3gNQwrS7OajWdYFJar3eEVzSUs
vrCRQUvQXQyl1oSKVPkcMUOcYgFY6vgv0XbxQL5jdO5LgtTq97XU77HOJe/pqj0p
5SwACR0r9zIfWgmpTzju6D/0F6CyRoxqJ8NX4M3nJRJQ8tsyCiuwnDdxSwPbO8h2
xyO3qUmDj09hFAu4aTfOw48RFPWipFhiWdnzI2DHXXBdmlz1BkK3OZ+d7evsJ5Fi
OSM+17RKV8vRINdL1nmsiO8vLO5Fmdodo2g2Ahwp59JEOgq9PkxtX4l/pM6Ey5lt
JMR/+P3xCR2sS2aSt9bBYxl0i7pUJ4Vg3agxiz52sQ+KTwELOC+Cs4BhR9aRTfvS
WfPbWFUHcKxTnq5SPViSkT3eU/Pbc53cP6JEzNEhMsRqU81jNVyQss5rNtQZowj/
SqWDnX4bSj4QFm1GGsv4ZgFXa8+7UqLkeXkPppcXQ220uy90jievvVItOezP1QDl
+nAPkjNQaGSqC8AIrFmjuGwaKZpwXt2SoYxHB/gys+R8tv4yTEisAJovdIv+lZ7P
kxju1yqHlnjVlDUCEw65E62az7wm20my6aWpWKkl1N4gikQYrF7CtPSi99SfSe5j
t+tHeDMmsk1YZVV3nrJg
=lf6e
-----END PGP SIGNATURE-----

--POWMPf7D1hriFuMoMTek3grbd0ltS2h7O--
