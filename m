From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 11 Mar 2016 11:26:23 +0000
Subject: Re: [PATCH 3/3] video: fbdev: imxfb: add some error handling
Message-Id: <56E2AB5F.1020806@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s3BfEwAH47gUKK7Gt7BqDGMDLwvANgjKV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org

--s3BfEwAH47gUKK7Gt7BqDGMDLwvANgjKV
Content-Type: multipart/mixed; boundary="3tMuhPt6eGpIv9lPrFQGfP98mh49HU6pk"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 kernel@pengutronix.de,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <56E2AB5F.1020806@ti.com>
Subject: Re: [PATCH 3/3] video: fbdev: imxfb: add some error handling
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>

--3tMuhPt6eGpIv9lPrFQGfP98mh49HU6pk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 07/03/16 21:53, Uwe Kleine-K=C3=B6nig wrote:
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Always have a description in a patch. In trivial cases it can be more or
less the same as the subject.

> ---
>  drivers/video/fbdev/imxfb.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 3dd2824e6773..671b3719db56 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -473,8 +473,9 @@ static int imxfb_set_par(struct fb_info *info)
>  	return 0;
>  }
> =20
> -static void imxfb_enable_controller(struct imxfb_info *fbi)
> +static int imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;
> =20
>  	if (fbi->enabled)
>  		return;
> @@ -496,10 +497,27 @@ static void imxfb_enable_controller(struct imxfb_=
info *fbi)
>  	 */
>  	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
> =20
> -	clk_prepare_enable(fbi->clk_ipg);
> -	clk_prepare_enable(fbi->clk_ahb);
> -	clk_prepare_enable(fbi->clk_per);
> +	ret =3D clk_prepare_enable(fbi->clk_ipg);
> +	if (ret)
> +		goto err_enable_ipg;
> +
> +	ret =3D clk_prepare_enable(fbi->clk_ahb);
> +	if (ret)
> +		goto err_enable_ahb;
> +
> +	ret =3D clk_prepare_enable(fbi->clk_per);
> +	if (ret) {
> +		clk_disable_unprepare(fbi->clk_ahb);
> +err_enable_ahb:
> +		clk_disable_unprepare(fbi->clk_ipg);
> +err_enable_ipg:
> +		writel(0, fbi->regs + LCDC_RMCR);

Please don't do that =3D). If you use goto, have the labels at the end of=

the function, not in the middle inside a if() block...

> +
> +		return ret;
> +	}
> +
>  	fbi->enabled =3D true;
> +	return 0;
>  }
> =20
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
> @@ -510,8 +528,8 @@ static void imxfb_disable_controller(struct imxfb_i=
nfo *fbi)
>  	pr_debug("Disabling LCD controller\n");
> =20
>  	clk_disable_unprepare(fbi->clk_per);
> -	clk_disable_unprepare(fbi->clk_ipg);
>  	clk_disable_unprepare(fbi->clk_ahb);
> +	clk_disable_unprepare(fbi->clk_ipg);

This is not error handling. I don't mind it being in the same patch, but
this change is something to mention in the description.

>  	fbi->enabled =3D false;
> =20
>  	writel(0, fbi->regs + LCDC_RMCR);
> @@ -520,6 +538,7 @@ static void imxfb_disable_controller(struct imxfb_i=
nfo *fbi)
>  static int imxfb_blank(int blank, struct fb_info *info)
>  {
>  	struct imxfb_info *fbi =3D info->par;
> +	int ret =3D 0;;

Extra ;.

> =20
>  	pr_debug("imxfb_blank: blank=3D%d\n", blank);
> =20
> @@ -532,10 +551,10 @@ static int imxfb_blank(int blank, struct fb_info =
*info)
>  		break;
> =20
>  	case FB_BLANK_UNBLANK:
> -		imxfb_enable_controller(fbi);
> +		ret =3D imxfb_enable_controller(fbi);
>  		break;
>  	}
> -	return 0;
> +	return ret;
>  }
> =20
>  static struct fb_ops imxfb_ops =3D {
>=20


--3tMuhPt6eGpIv9lPrFQGfP98mh49HU6pk--

--s3BfEwAH47gUKK7Gt7BqDGMDLwvANgjKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4qtfAAoJEPo9qoy8lh71c50P/Rw9/FmIQ75eMGOsX7QOMu04
UoqyoXs1tchxJrk4DHYMGUv+E8DNo1RPCBB7Jry9+Fak/Wwk1738HCpaEdY9EucS
gfJWa9yoMUm9uQt19l56f3ttEBaBDGkgPSIXLNOBhInSTur97mILJLoIhlkDPxo7
06MAForrp+sJumKh8h32gQtzrxBmtdsbTnIf4xVac8tYSYqGWV/FAPT8h8m1WudC
YIP/VfVZx+4x4lNHgxAUIIJ+8XVjw56kMc+X84m3O8rBiUioFrpUeOVAdw15+yof
BK46h1bhq1dwZ86P8c4uFcrpLh87R2gM2s7YPVq1ZeGMPDUIbFUkUh4MLYSDMoWB
ZiipHYwwn1Xtj6IEi0CD3xm34qmbTn6QFD/rkB3ywio2SIMZ9HG8/vN82D01VNiq
/GqJXG9k0FHCXQYw04m75d6wRy5rMI9S4rscKKA7kPCaQ/g19npWiUYpvgVSoJUi
bXeN3fpKKItCHW8DsTFejQk3libhoxeVLjcy3hFm8TpfwWRfaeEJbvvBYk9GaEoZ
UwPKBaS0lHnwqOatWV03XQ76ai/48K184hKQk9fsGhQReDsvNcT2QgB21gq0eCtk
/YW+RlcgIDVcRatHtzxz7ASIYuZyqrlOFVYaSxYM4t6QX7ytZi8LCqNx6AWJ+8tn
dvZlJkXtfWAlHdsiBRTS
=CxQv
-----END PGP SIGNATURE-----

--s3BfEwAH47gUKK7Gt7BqDGMDLwvANgjKV--
