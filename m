From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 20 Sep 2016 09:22:39 +0000
Subject: Re: [PATCH] omapfb: fix return value check in dsi_bind()
Message-Id: <ecdac13c-a697-92dd-25d4-34646c3a3e9e@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>
In-Reply-To: <1474127614-14350-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 09/17/16 18:53, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> Fix the retrn value check which testing the wrong variable
> in dsi_bind().

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/f=
bdev/omap2/omapfb/dss/dsi.c
> index 9e4800a..951dd93 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> @@ -5348,7 +5348,7 @@ static int dsi_bind(struct device *dev, struct devi=
ce *master, void *data)
> =20
>  	dsi->phy_base =3D devm_ioremap(&dsidev->dev, res->start,
>  		resource_size(res));
> -	if (!dsi->proto_base) {
> +	if (!dsi->phy_base) {
>  		DSSERR("can't ioremap DSI PHY\n");
>  		return -ENOMEM;
>  	}
> @@ -5368,7 +5368,7 @@ static int dsi_bind(struct device *dev, struct devi=
ce *master, void *data)
> =20
>  	dsi->pll_base =3D devm_ioremap(&dsidev->dev, res->start,
>  		resource_size(res));
> -	if (!dsi->proto_base) {
> +	if (!dsi->pll_base) {
>  		DSSERR("can't ioremap DSI PLL\n");
>  		return -ENOMEM;
>  	}
>=20


--=20
P=E9ter
