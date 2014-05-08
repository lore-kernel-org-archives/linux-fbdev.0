From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 08 May 2014 10:50:46 +0000
Subject: Re: [PATCH] video: Kconfig: Add a dependency to the Goldfish framebuffer driver
Message-Id: <536B6186.3010203@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AFp30nKTiaqrl05JfQqTD99ltCgn3gL4x"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--AFp30nKTiaqrl05JfQqTD99ltCgn3gL4x
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/04/14 13:42, Jean Delvare wrote:
> All other Goldfish drivers depend on GOLDFISH, I see no reason why the
> framebuffer driver would be an exception.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-3.15-rc2.orig/drivers/video/fbdev/Kconfig	2014-04-22 14:20:30=
=2E949107522 +0200
> +++ linux-3.15-rc2/drivers/video/fbdev/Kconfig	2014-04-23 11:51:17.1639=
33232 +0200
> @@ -2169,7 +2169,7 @@ config FB_XILINX
> =20
>  config FB_GOLDFISH
>  	tristate "Goldfish Framebuffer"
> -	depends on FB && HAS_DMA
> +	depends on FB && HAS_DMA && (GOLDFISH || COMPILE_TEST)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
>=20
>=20

Queued for 3.16.

 Tomi



--AFp30nKTiaqrl05JfQqTD99ltCgn3gL4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTa2GGAAoJEPo9qoy8lh71Y5oP/j69h3NBGmPUj4my0FtMICH2
jmLwzJpTiVN3ax1gHebkXYDLQbpJl6D9YiOiiVwvzc52igDglmcYPu+4ashQSOBg
fEYfg+XdjFNpnJk/9GkKehsPMDNowGhSLnvVLNKSu+AtGaZXzpE/2tz7Km4AEu3u
d3hRyQK1wQqxbAxqHFm4TryLu6b7GRnXhBvcbs7KqjLoW6UfqnB5IEOWDH/c08+7
0LI5G7xPR99fDx3+8fUD9wMKLPghClW2IlIs0lAX21Dll9RoNow2rPKN9rBoSXYu
BmVps/6aFcqpYoZf/WB3y0V5kp05q7tVA7fVBdZNAQ0pNcFeeBlNYoIi+foxGjut
UMUHjqmFWGg80DTM/erOkwPbYEWk0X7SXa94rARU3QH1gm+D6k4ZC6gXO02+J0TO
QibCiHrrO9HMvI+A2S5zxkg6CyCaojlz5YKe8wnl2gQTUIIPuUXeFYe70c5/OFKO
sbK4f0MgPYaB1iXMvjQz9/HYSQ4RwUtnkiqJrfHBLWac5roCUn/ceVs7j/F91DV2
kRLShqbS/0pARAvU5lTtemYVyMPQeS3KTp+Qtq3vkBcmSeajYm3fpWjDmdnqMUHO
H/H2VUzuZexaxBZklQ5BOxb6d3xSVJ4B7CFW6NDHlgVSIGCBl8jKOkmaz0vzCoyA
X9u7GKpdDF7EqOywkWPI
=p/Bu
-----END PGP SIGNATURE-----

--AFp30nKTiaqrl05JfQqTD99ltCgn3gL4x--
