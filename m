From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 10 Aug 2016 10:55:31 +0000
Subject: Re: [PATCH] fb: adv7393: Use IS_ENABLED() instead of checking for built-in or module
Message-Id: <f2380927-a419-414f-c5ec-2aabed677238@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="a65eXNQ3uwh8e1bBfBAPRlshC2P2T9XMo"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1468269877-9900-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1468269877-9900-1-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--a65eXNQ3uwh8e1bBfBAPRlshC2P2T9XMo
Content-Type: multipart/mixed; boundary="IjGpjAh96WCmmlh6GCooVvcSp159veOuG"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Message-ID: <f2380927-a419-414f-c5ec-2aabed677238@ti.com>
Subject: Re: [PATCH] fb: adv7393: Use IS_ENABLED() instead of checking for
 built-in or module
References: <1468269877-9900-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1468269877-9900-1-git-send-email-javier@osg.samsung.com>

--IjGpjAh96WCmmlh6GCooVvcSp159veOuG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/07/16 23:44, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled eith=
er
> built-in or as a module, use that macro instead of open coding the same=
=2E
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>=20
>  drivers/video/fbdev/bfin_adv7393fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev=
/bfin_adv7393fb.c
> index 8fe41caac38e..9a01cd7ca73c 100644
> --- a/drivers/video/fbdev/bfin_adv7393fb.c
> +++ b/drivers/video/fbdev/bfin_adv7393fb.c
> @@ -795,7 +795,7 @@ static struct i2c_driver bfin_adv7393_fb_driver =3D=
 {
> =20
>  static int __init bfin_adv7393_fb_driver_init(void)
>  {
> -#if  defined(CONFIG_I2C_BLACKFIN_TWI) || defined(CONFIG_I2C_BLACKFIN_T=
WI_MODULE)
> +#if IS_ENABLED(CONFIG_I2C_BLACKFIN_TWI)
>  	request_module("i2c-bfin-twi");
>  #else
>  	request_module("i2c-gpio");
>=20

Thanks, queued for v4.9.

 Tomi


--IjGpjAh96WCmmlh6GCooVvcSp159veOuG--

--a65eXNQ3uwh8e1bBfBAPRlshC2P2T9XMo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwgjAAoJEPo9qoy8lh71rzkP/A2ADvzuWv2s06lMeEDgSuxo
gnxSIME8Dc+2o1CT+9kL/8kjbvKW+be1V4MbKD2edgbAaO9QgnmY+o+OEyoyi978
jxhsoqRtXGRi6yDn6G45uibaLhJhtJeC+UOCfFYKiHoEbnBM0Xv/wi1yXre6+Q1n
BWnpsySn2EbzSmR5JzyW+WOWAucDZLN32vhyLVRXLDLAx4Sx27FdrCau2phZhU+G
bowefaghC+0kxA1J8MuEobgQEtMBp3Iw+DIh0h5umWzf/WIBHEwTh64g/8OYCzqi
kdv6fHXHhmSdscYIKQ4rwktK4snhTzS1CqdvHPij2ZPZlpcrEcz3+xSLRPSsctmZ
Aco2NkszAqUqFUZ19FR1OnA2k88tMTZXtiuVVVwgdJyFQw4R38Zq/F2QysHwGYxu
jL5tXZoGGQa5VSF2zEy9J6iWyEwZ2NVrHuu9I5QMNyZaflJBsDJZdqDdYnML5N4E
YFM09daQtDhBKbXn3lZsHEzSwI6pdQV0eiX8xZMyLHtw0gcBAUgARD04mPBTcmkb
LpNfSvLwzoLKwfoQ6Tln7hnLiT9JDtMX0k4u+1zhLux4UDHmu7oty24uQNvq2Mjl
+xWi7+X9Aa/KL7MgCuea7Aig4VvwkGa3gymdXVfpt88A0atVhHEBNKMK2gyboQ5Y
KoQbVpV8bx3GB9b6IZK1
=IoeC
-----END PGP SIGNATURE-----

--a65eXNQ3uwh8e1bBfBAPRlshC2P2T9XMo--
