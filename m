From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 07:57:12 +0000
Subject: Re: [PATCH] video: nuc900fb: fix to pass correct device identity to request_irq()
Message-Id: <51F22BD8.8090604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1R53lFxn3r7vvK4IGcdVtAmwxWTrnwjgu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd9CZ=VponJTbTGKTXVTdvMQM6_T+-RWuPMrk0WYZPbW1Q@mail.gmail.com>
In-Reply-To: <CAPgLHd9CZ=VponJTbTGKTXVTdvMQM6_T+-RWuPMrk0WYZPbW1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--1R53lFxn3r7vvK4IGcdVtAmwxWTrnwjgu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/07/13 03:07, Wei Yongjun wrote:
> The IRQ handler nuc900fb_irqhandler() use dev_id as a type of
> struct nuc900fb_info *, so we should pass fbi as the device
> identity to request_irq().
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> Was 'video: nuc900fb: fix to pass correct device identity to free_irq()=
'
> ---
>  drivers/video/nuc900fb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 8c527e5..796e511 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -587,8 +587,7 @@ static int nuc900fb_probe(struct platform_device *p=
dev)
>  	fbinfo->flags			=3D FBINFO_FLAG_DEFAULT;
>  	fbinfo->pseudo_palette		=3D &fbi->pseudo_pal;
> =20
> -	ret =3D request_irq(irq, nuc900fb_irqhandler, 0,
> -			  pdev->name, fbinfo);
> +	ret =3D request_irq(irq, nuc900fb_irqhandler, 0, pdev->name, fbi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "cannot register irq handler %d -err %d\n",
>  			irq, ret);
>=20

Thanks, I've applied this into my 3.11-fixes/fbdev branch.

 Tomi



--1R53lFxn3r7vvK4IGcdVtAmwxWTrnwjgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8ivYAAoJEPo9qoy8lh71V5cP/2zl9qXcDwyRJRkzYMsH2fau
KgJqIUOaYhwAnN13w9OhkzdXApNAQ4XJi2wNZLb4gCbjN7dUPK/r0tqWpDKg1Iyj
IYKNKxW7rd2pAsgQbKT30XkpRIF4PNrLDi7qGpqyeQYQFPnEdgzEXqw6Tvd/ShDI
Ax6nohMdC/t2xNJDJUfOuR/9/x0hiQw3UaeHUfHDmL3wIiRv+vhJ4SBYjz4epEnF
+BDwiCVQG8/veipKRLxlxGr049obZRtCz3o5vdG51Jmi4rPKW7NGZKnHFUS4Z8TS
RtzxaujxJOUVZz2QXsh/FdaxDMk3m+JE/QPLOKpOyBXNYMXPNY5phTQYNmDbURUg
gn+wSI7ay6LI93WowSc5Gm9t2y/yo7RqCao087D55dkK3a6DRavn3tSonEWpzRbE
NQc3O8BWMm7ZISoJffIRbdA5w4L0KMWsuT2EhRYnu8c7PT7aoK2PkssfdWqEO6wT
cU9Ws5cXod8K2lPUZKg1uFGrqWuiV4urpofZTifOFA3vgqev2Y5Oz0EsKeQw880t
RPQdnwZ1yCfNKNEhLwpkpLJUS2/ZCngZHB/8e2Y8dA29DKxTiZgO5Dk8OCegVAH3
9L8Mg+TeBc/cGYzdgQgLuDmSwtrDdXPAamKkG2rOnNpjaqBhRd1Yz25FiH2/Oy6K
wY+H9ENSEKqyOnl0TA/t
=7McZ
-----END PGP SIGNATURE-----

--1R53lFxn3r7vvK4IGcdVtAmwxWTrnwjgu--
