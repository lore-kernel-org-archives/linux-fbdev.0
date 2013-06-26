From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 11:43:31 +0000
Subject: Re: [PATCH -next] video: mxsfb: remove redundant dev_err call in mxsfb_probe()
Message-Id: <51CAD3E3.70707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2LOGFFUFCOMKGSJKKTSOQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd80wMDBg8ADjtDvZC1=yUoigS7_btHMz1=r8WQTwpgSvg@mail.gmail.com>
In-Reply-To: <CAPgLHd80wMDBg8ADjtDvZC1=yUoigS7_btHMz1=r8WQTwpgSvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org

------enig2LOGFFUFCOMKGSJKKTSOQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/06/13 04:50, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/mxsfb.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 21223d4..251bbec 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -899,7 +899,6 @@ static int mxsfb_probe(struct platform_device *pdev=
)
> =20
>  	host->base =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(host->base)) {
> -		dev_err(&pdev->dev, "ioremap failed\n");
>  		ret =3D PTR_ERR(host->base);
>  		goto fb_release;
>  	}
>=20

I've added this to my fbdev-3.11 branch.

 Tomi



------enig2LOGFFUFCOMKGSJKKTSOQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRytPjAAoJEPo9qoy8lh71rrYP/1Q4etU0ONBawoDNK2J2aoY/
qqGuMn0uXUJlf3yNR4KOwiALbQeULTuOkacWg+66YAhEca5WuQMHMr+ehMdIINfz
jajXFOzxozrCGeCxy01gYp7CpSELiIsFG0Sk8c77LWbKUp3mV9n1c5RMwkoUc10C
RssLkj5QmcdwxJ/sKOf92nLcWP2bwzDZYd+F0IOrIbFEVVj6E2UMCSGOc2sDB+wa
2YhP5lxUlxzE/hqP26kd9wohu6IQ87n7gtGEtm5Jlxrws5u8nmS5ZsXNcJ7TNaF6
keEu/oIJwDl2gcVzhmXgcg3Wt7vfnr62AX/GqPKZyJnjTiyTsE7kRjsibXc9QoyW
tWpR0RoI2RBZbJfSYGtxfz0uto0YAU/OgdQhgc2RaPsIU7gNRu/bcpasL5sLHjqd
hLZc4OKTHEEk0F0JXXxMrt1okShNG2cfxfrV1xAJfLctN2pQfyMe/DumZkr9JvGo
2m5RnOEl/UbrC/Z/uiJFxTliqwTH2Vvo3Qcyz48mXSDrrWRSAIq5vd2WH9JH4Hhm
WmeOFtTcwyI4F/fqEhDPYe6jR/5NDNZcMGf3csYNWb7BWDeqTDNvn+m33UbhYmLa
zlVRMLp2HN5zUpW6Z3H8ZfKg7BRrZPFqzlvPxTcu6ekDm8C9SlTk9mGP1frud0+9
n810nUErcqFtc1si+BZi
=72HT
-----END PGP SIGNATURE-----

------enig2LOGFFUFCOMKGSJKKTSOQ--
