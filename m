From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 23 Sep 2013 16:19:44 +0000
Subject: Re: [PATCH] video: mmp: drop needless devm cleanup
Message-Id: <20130923161944.GU12758@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Sep 23, 2013 at 06:13:10PM +0200, Uwe Kleine-K=F6nig wrote:
> The nice thing about devm_* is that the driver doesn't need to free the
> resources but the driver core takes care about that. This also
> simplifies the error path quite a bit and removes the wrong check for a
> clock pointer being NULL.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_c=
trl.c
> index 75dca19..6ac7552 100644
> --- a/drivers/video/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
> @@ -514,7 +514,7 @@ static int mmphw_probe(struct platform_device *pdev)
>  	if (IS_ERR(ctrl->clk)) {
>  		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
>  		ret =3D -ENOENT;
> -		goto failed_get_clk;
> +		goto failed;
>  	}
>  	clk_prepare_enable(ctrl->clk);
> =20
> @@ -551,21 +551,8 @@ failed_path_init:
>  		path_deinit(path_plat);
>  	}
> =20
> -	if (ctrl->clk) {
> -		devm_clk_put(ctrl->dev, ctrl->clk);
> -		clk_disable_unprepare(ctrl->clk);

And this patch also fixes the above: disabling/unpreparing _after_ putting
the thing - which was quite silly... :)
