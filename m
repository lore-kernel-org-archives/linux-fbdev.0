From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 29 Oct 2013 10:21:10 +0000
Subject: Re: [PATCH] fbdev: fix error return code in metronomefb_probe()
Message-Id: <526F8C16.9010300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0MEI08Qptftk2dP7EBlg5h8cmfPcoGAWf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd-FgU-512ivq_eRPqefqb8-7qGY8aoOATiFNZYn-P_4rg@mail.gmail.com>
In-Reply-To: <CAPgLHd-FgU-512ivq_eRPqefqb8-7qGY8aoOATiFNZYn-P_4rg@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--0MEI08Qptftk2dP7EBlg5h8cmfPcoGAWf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/10/13 09:25, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/metronomefb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index f30150d..0b36160 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -690,7 +690,8 @@ static int metronomefb_probe(struct platform_device=
 *dev)
>  		goto err_csum_table;
>  	}
> =20
> -	if (board->setup_irq(info))
> +	retval =3D board->setup_irq(info);
> +	if (retval)
>  		goto err_csum_table;
> =20
>  	retval =3D metronome_init_regs(par);
>=20

Thanks, queued for 3.13.

 Tomi



--0MEI08Qptftk2dP7EBlg5h8cmfPcoGAWf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSb4wWAAoJEPo9qoy8lh716RUQAKBqS/eJXs+qTPpFlvBqSeFR
mXBzrujUVQjGW11eKZWE7nSTyeJvuQKeJFfvdZtBEOaTBRIU3dqQE6LAr7IOOpQr
GjDrXOMuN38A6WHo30J+fh/bZYvlnLtJUNHYtMQTNODF0AMXtTmlx0m0cuaZKKg9
sr4LqitOEUpk4JgGBp04rf74Dc1GB3sqHOKAvoSchnZcVgT1MnFHfxuyHtGt4l40
MQhq64h8vhfilFxJjdTUgwUqNKxMwu1aIPshXZDqn9m65hA4BQW5e9sMgkYWCmnF
Je4x70E3X/+5sOw+fNntmYTrjVal7qMxqoSH0BKu0L3BmiiFowuDNi9//cSBzxoT
m/6pSTF1D94s3jmmj17VjqZEaukeBspyai4awX5b5SJzb9F1izYZmZ9J5rUuAWif
qdeMyTaxTq/bG90zNv18dyZDwCTB7CdBCcCXMpQO7u9+/YU5d1WBWE/gQR/jt+AG
KF3qQVaF0BNCDVffQeGzEhjTrA+RC0nKPOrm6015fQcklzNlabinoFCHfRHdGmcN
d8QoEpS+sEh/NY/vWgnoGoWrbBRGgRe22FATr6Efw6gi8/gftnuKi3j+jIHiKGHm
0sFBEOZQQiqEfiEqxhOPd15zZ0fa5OtVIB6uBMnJqmIh9oImLV4x4yAPpu8CQeyE
bSF7/hzTtL3gPK8Dd8kT
=6LRR
-----END PGP SIGNATURE-----

--0MEI08Qptftk2dP7EBlg5h8cmfPcoGAWf--
