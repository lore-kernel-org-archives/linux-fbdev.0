From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 01 Jul 2014 10:33:28 +0000
Subject: Re: [PATCH] fb: adv7393: add missing semicolon
Message-Id: <53B28E78.7040903@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EvrGHCSGUvN2ocshFW485HJDhepAwmKL6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404284022-24866-1-git-send-email-scott.jiang.linux@gmail.com>
In-Reply-To: <1404284022-24866-1-git-send-email-scott.jiang.linux@gmail.com>
To: linux-fbdev@vger.kernel.org

--EvrGHCSGUvN2ocshFW485HJDhepAwmKL6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/07/14 09:53, Scott Jiang wrote:
> Commit f8bd493456c3da372ae81ed8f6b903f6207b9d98 by Jingoo Han
> introduced this problem. This makes bfin_adv7393fb.c failed to compile.=

>=20
> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
> ---
>  drivers/video/fbdev/bfin_adv7393fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/bfin_adv7393fb.c b/drivers/video/fbdev=
/bfin_adv7393fb.c
> index a54f7f7..8fe41ca 100644
> --- a/drivers/video/fbdev/bfin_adv7393fb.c
> +++ b/drivers/video/fbdev/bfin_adv7393fb.c
> @@ -408,7 +408,7 @@ static int bfin_adv7393_fb_probe(struct i2c_client =
*client,
>  	/* Workaround "PPI Does Not Start Properly In Specific Mode" */
>  	if (ANOMALY_05000400) {
>  		ret =3D gpio_request_one(P_IDENT(P_PPI0_FS3), GPIOF_OUT_INIT_LOW,
> -					"PPI0_FS3")
> +					"PPI0_FS3");
>  		if (ret) {
>  			dev_err(&client->dev, "PPI0_FS3 GPIO request failed\n");
>  			ret =3D -EBUSY;
>=20

Thanks, queued for 3.16 fixes.

 Tomi



--EvrGHCSGUvN2ocshFW485HJDhepAwmKL6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTso54AAoJEPo9qoy8lh71oisP/RpJt5gvW6JB+v2kmHPlIx0X
Lt1sWrle8PnLqdwfZVLLpD+PRZUn2V/+GqiucfwYIs1iVwIvM9Iiq8gHMk5zpQZP
9+DbZ+Uhr+zW/N2Bbo58wX2ZHek2feF86mSZhIu1c7WKBlR/hyPTSj8kF/gxWJrn
jUaU6TpCU6RaG9v4MMGxNCJz1OKEIw6fujLt39nsQKjhUSpquf4rxoI+KG7ufmfe
g1dfyEdKgLzm0PFKFTgyuEZh8I0AxwrQWnmrktcYrJheHXPQZFyFjouQTPrU3qHv
+8YxS7tWhp3MvF4hzn6tSLzmFjhvp0lS2DQr+R5jTmszA+J8da33C7PvLj+vqu1l
jGVZt/MtLP0d0FG38U7V33GBbOUQuSJYBWjub1aYZ75KCmijyKAyXy1wDF5/fqTM
B9mDftawTO5PykaEjJnyG6J1MjCYqtYtypBdWf60fsObk+q3iFQwMWXYN4s/1zs7
yxaKDrd1kVz6QkL2EKK0Krc7CctW3DPUYi2VUR+UDzkNOSLeHNmsy3WHhXe/uyfl
cNEcCAWELGe4VFA96qFvfuqv1muTzbAY+LxNR4+nx99jTk3Lz9dWvI3oUXA6LA/4
GURycjETkAzk/05uUC+7nue7BQlo6SrDGfQ7ZD0X4kQNdYN+eNTm8x8WhWlxmnfQ
fxg2831Q2QBTADBCnhiL
=jF/V
-----END PGP SIGNATURE-----

--EvrGHCSGUvN2ocshFW485HJDhepAwmKL6--
