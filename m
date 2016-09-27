From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 27 Sep 2016 08:04:48 +0000
Subject: Re: [PATCH] omapfb: fix return value check in dsi_bind()
Message-Id: <30594f4d-898e-d75a-1835-ec2077480b91@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ofbmFR7BEW0fH2kVAM7pX8IFeAhmdxj6K"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>
To: linux-fbdev@vger.kernel.org

--ofbmFR7BEW0fH2kVAM7pX8IFeAhmdxj6K
Content-Type: multipart/mixed; boundary="CKubCflphmFXSXdJ56jkvpMQcboc00n5u";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Wei Yongjun <weiyj.lk@gmail.com>, Dan Carpenter
 <dan.carpenter@oracle.com>, Dave Airlie <airlied@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Message-ID: <30594f4d-898e-d75a-1835-ec2077480b91@ti.com>
Subject: Re: [PATCH] omapfb: fix return value check in dsi_bind()
References: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>

--CKubCflphmFXSXdJ56jkvpMQcboc00n5u
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17/09/16 18:53, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Fix the retrn value check which testing the wrong variable
> in dsi_bind().
>=20
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video=
/fbdev/omap2/omapfb/dss/dsi.c
> index 9e4800a..951dd93 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> @@ -5348,7 +5348,7 @@ static int dsi_bind(struct device *dev, struct de=
vice *master, void *data)
> =20
>  	dsi->phy_base =3D devm_ioremap(&dsidev->dev, res->start,
>  		resource_size(res));
> -	if (!dsi->proto_base) {
> +	if (!dsi->phy_base) {
>  		DSSERR("can't ioremap DSI PHY\n");
>  		return -ENOMEM;
>  	}
> @@ -5368,7 +5368,7 @@ static int dsi_bind(struct device *dev, struct de=
vice *master, void *data)
> =20
>  	dsi->pll_base =3D devm_ioremap(&dsidev->dev, res->start,
>  		resource_size(res));
> -	if (!dsi->proto_base) {
> +	if (!dsi->pll_base) {
>  		DSSERR("can't ioremap DSI PLL\n");
>  		return -ENOMEM;
>  	}
>=20

Thanks, queued for 4.9.

 Tomi


--CKubCflphmFXSXdJ56jkvpMQcboc00n5u--

--ofbmFR7BEW0fH2kVAM7pX8IFeAhmdxj6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX6iggAAoJEPo9qoy8lh71YM0P/RQKSNx91y/j60AzSJ2+c3MJ
YMdytF4Sh5Be1865NuGsitRU7pz2Nzncu5RKtVCbtqISSL6aTTu0KBJgTWJTzX+v
iOQ5QDqu2s0rU03kNYlZsnUvqgan7fhzdTricRdolFj8Rv2HrKNz9nASPuHVSGH5
fNMfhX8m/45rNQ0tmWDN7Ta0wryNq66PCVkf+i8Kifu2z9H8M96lQlzZvgUiaubL
bmnyn1f8OSrt6B91kuqACawS1aoXk9YOuvottnjoHrIZrnFc2pv+sE1bReEM1ICM
uC0RpC0b6Pj36z4Riv1XXZjXqCxdHLnt6TibrAZWICXoH84PlOuSp2A2L+QEo/72
BwFb1hARb85qy32eenDhpNfjBIVSMPc67ppTd4qVtWcjTZP/9irlYnp5w6Sgs905
JJsRMOZMBl4I3aonBrjb7cJhbMFvqzG2JszkpOwLfELN6qMLX/XxtO0/lTNZ9+ta
8yY8Ngywg7db206iigCY0F1iexNpVF4mFWmkWuu6kZOxRPMJbAP9fgDMXnQyf68y
weS/TGkzjQcLSEdmGQNFYpnKhIOKOidrPlKUEifSVAQvEDw6p7E4i0olVMekp6PQ
8tYjie8JQyOD8FD383opJOEUoelEiqmOUbL3D6WcsxX0k/ernJ1OmXw982rofZtX
KA7GOtP8v4HMqhieDCkR
=GmuV
-----END PGP SIGNATURE-----

--ofbmFR7BEW0fH2kVAM7pX8IFeAhmdxj6K--
