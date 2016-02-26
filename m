From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 11:00:18 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Use ARCH_RENESAS
Message-Id: <56D03042.7030004@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0RwcHTGU0aUjxnRwWjhJtMq84HbkPkVKp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
To: linux-fbdev@vger.kernel.org

--0RwcHTGU0aUjxnRwWjhJtMq84HbkPkVKp
Content-Type: multipart/mixed; boundary="HQqNgq7oXRIa55qqbsKK7TriHt5PwexdO"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, linux-fbdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Message-ID: <56D03042.7030004@ti.com>
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Use ARCH_RENESAS
References: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456106391-10353-1-git-send-email-horms+renesas@verge.net.au>

--HQqNgq7oXRIa55qqbsKK7TriHt5PwexdO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22/02/16 03:59, Simon Horman wrote:
> Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
>=20
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a =
more
> appropriate name than SHMOBILE for the majority of Renesas ARM based So=
Cs.
>=20
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/video/fbdev/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>  Based on v4.5-rc1
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 8ea45a5cd806..936ebd4bcf73 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1985,7 +1985,7 @@ config FB_W100
> =20
>  config FB_SH_MOBILE_LCDC
>  	tristate "SuperH Mobile LCDC framebuffer support"
> -	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> +	depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK
>  	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
>=20

Thanks, queued for 4.6.

 Tomi


--HQqNgq7oXRIa55qqbsKK7TriHt5PwexdO--

--0RwcHTGU0aUjxnRwWjhJtMq84HbkPkVKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0DBCAAoJEPo9qoy8lh71WmsP/iX+scAhZqjhbL9Np6PxHrFP
0EeENRM4E35ltYzbkqgeb8oA5z15pgzzyq81Qxcyzg44zzPlYnDvm676EJ3l0faa
obYz88ViB25853ZgoE+7fJL/IqXHAH171J1qh3Wjd5rdBR9t/zYETgUke6OHi6tz
zhXVDdTE55QETyIwHuZAgicAhyv5HfilFg+IvRnFV7UcUbdUyD0ktXHmMyPYVaWe
sED9p/22DJUrcAnlSzVEmPqMQ0domc+CWOAcbz3NIZy+VE7f5ndzO7xtr71ZZ5pY
SOwOGpgs9nUJq3FD4bXkhXBYkhmGfGEct6h99XjH5s5Lh3s93vHOYCQ3lCB09jL/
6BWS9wR9qJpdoCizT0VIPe5dNTI/BgVzyrdX6tMUdQyhiW6POsuLs1RIDJmxdJVz
PH8upcpbeHbaEwxvb06wgNBOlUyHfB+t87HfMXO1vjhHXtj/QM356Le1fkzuI1AP
slcFRalZIHa8xkz/5kDaOokw4tIwoVagIquoOSJsO+c59Hfc6+J+Us95vrqUQwvf
jCIR5bgwEx/PI1bRJelzEB/8q3zREDy3KR+DykY8Q6v07ZPXiz9pIXkISoeVD3GN
2zusliLXad8V2XVfDEMXRJO0zIoZq4090T31DlnjxaUcpuUcovW5AAMiae0dF7cO
SUBe5z95JVvJwKq5vW2M
=SWvV
-----END PGP SIGNATURE-----

--0RwcHTGU0aUjxnRwWjhJtMq84HbkPkVKp--
