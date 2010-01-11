From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 11 Jan 2010 17:59:40 +0000
Subject: Re: [PATCH] imxfb: correct location of callbacks in suspend and
Message-Id: <20100111175940.GZ6923@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1263226881-28008-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1263226881-28008-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 11, 2010 at 05:21:21PM +0100, Uwe Kleine-K=F6nig wrote:
> The probe function passes a pointer to a struct fb_info to
> platform_set_drvdata, so don't interpret the return value of
> platform_get_drvdata as a pointer to struct imxfb_info.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/video/imxfb.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 66358fa..b4b6dec 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -593,7 +593,8 @@ static int imxfb_activate_var(struct fb_var_screeninf=
o *var, struct fb_info *inf
>   */
>  static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
>  {
> -	struct imxfb_info *fbi =3D platform_get_drvdata(dev);
> +	struct fb_info *info =3D platform_get_drvdata(dev);
> +	struct imxfb_info *fbi =3D info->par;
> =20
>  	pr_debug("%s\n", __func__);
> =20
> @@ -603,7 +604,8 @@ static int imxfb_suspend(struct platform_device *dev,=
 pm_message_t state)
> =20
>  static int imxfb_resume(struct platform_device *dev)
>  {
> -	struct imxfb_info *fbi =3D platform_get_drvdata(dev);
> +	struct fb_info *info =3D platform_get_drvdata(dev);
> +	struct imxfb_info *fbi =3D info->par;
> =20
>  	pr_debug("%s\n", __func__);
> =20
> --=20
> 1.6.5.2
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
