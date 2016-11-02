From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 02 Nov 2016 08:24:40 +0000
Subject: Re: [PATCH] video: ARM CLCD: fix Vexpress regression
Message-Id: <6e29bcec-e8c5-d00f-4257-4ec14e90fae1@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cRL9XIkihiUdQjKHHESWQITkGT8ggjeaO"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org

--cRL9XIkihiUdQjKHHESWQITkGT8ggjeaO
Content-Type: multipart/mixed; boundary="Dw014VG9OP9GFBXc2nI08L1KEUsSbpVEa";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Amit Pundir <amit.pundir@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Message-ID: <6e29bcec-e8c5-d00f-4257-4ec14e90fae1@ti.com>
Subject: Re: [PATCH] video: ARM CLCD: fix Vexpress regression
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>

--Dw014VG9OP9GFBXc2nI08L1KEUsSbpVEa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/10/16 09:46, Linus Walleij wrote:
> The CLCD does not come up on Versatile Express as it does not
> (currently) have a syscon node for controlling the block apart
> from the CLCD itself. Make sure the .init() function can bail
> out without an error making it probe again.
>=20
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/=
fbdev/amba-clcd-versatile.c
> index 19ad8645d93c..d909b7dda14d 100644
> --- a/drivers/video/fbdev/amba-clcd-versatile.c
> +++ b/drivers/video/fbdev/amba-clcd-versatile.c
> @@ -527,7 +527,8 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
>  					     &clcd_id);
>  	if (!np) {
>  		dev_err(dev, "no Versatile syscon node\n");
> -		return -ENODEV;
> +		/* Vexpress does not have this */
> +		return 0;
>  	}
>  	versatile_clcd_type =3D (enum versatile_clcd)clcd_id->data;
> =20
>=20

Thanks, queued for 4.9 fixes.

 Tomi


--Dw014VG9OP9GFBXc2nI08L1KEUsSbpVEa--

--cRL9XIkihiUdQjKHHESWQITkGT8ggjeaO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYGaLIAAoJEPo9qoy8lh718DkQAJa7I7/ZfC/EnemOtWgJ7W9U
u09dxdQa2TT0V/8mNoBcMdBN2tg6TSGsPltMIO2/FhtAX7WyIeGRwfRSryR2vZdw
bC1R4fqzJ1/mOyV8vowxUFOFwwa4BZlzhlQcasMm5BJcFkGJBWEkWUmPoWUiR8Jn
aJhzDOFgV1z+cBrwiLLX6PWeH3BU7OjPni9RhWCKh0/rP3oU7lkPt1jOIeXmBgo8
3GLIoMFROjvYYgnWll8x81lKLAUWSvInRcJmFd/VkP/CMWSelfbs2BScJD/GsFSe
GjNulxABZhY6/TMcikN5G3WORqwrGRtcIg9L0Fjj3MOFFGpAjJqQTYIwiUre8ALQ
jeOXwud8te/B1zOpxIuoQyggauYyYf4UWCOSuT9Di4rz4ZyFd90DbXHHfiQQ21rF
4h63ZZz+IV/CBBMu74kQOIWpQDp7DR2BsiOHxhcBdF7F6ypOAi717x8yAPKubzlg
zeSnvCTBidrwZZT7xwdo7YeSBTwrmXjtWblTsytk2s31GV/DSw3GG9xOreYS0dG9
HhBkXUnzCBimVIViBTn6a4QU2DWNMM8ahhDt2W2Cg7rMSN1xZFxNuYnUCht5L3GG
HRdJ6XYsud68n5V3ylAnx4BYCdFJFofuneOxMvXz6mJyEllCrAdz2B9ihCysGR8g
WirlzUwqID3QpWgmBDCD
=NRJ+
-----END PGP SIGNATURE-----

--cRL9XIkihiUdQjKHHESWQITkGT8ggjeaO--
