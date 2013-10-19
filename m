From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 19 Oct 2013 10:45:55 +0000
Subject: Re: [PATCH 02/11] video: imxfb: Introduce regulator support.
Message-Id: <20131019104555.GI18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382108672-23269-1-git-send-email-denis@eukrea.com>
 <1382108672-23269-2-git-send-email-denis@eukrea.com>
In-Reply-To: <1382108672-23269-2-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 17:04 Fri 18 Oct     , Denis Carikli wrote:
> This commit is based on the following commit by Fabio Estevam:
>   4344429 video: mxsfb: Introduce regulator support
>=20
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/video/imxfb.c |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 44ee678..4dd7678 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/math64.h>
> @@ -145,6 +146,7 @@ struct imxfb_info {
>  	struct clk		*clk_ipg;
>  	struct clk		*clk_ahb;
>  	struct clk		*clk_per;
> +	struct regulator	*reg_lcd;
>  	enum imxfb_type		devtype;
>  	bool			enabled;
> =20
> @@ -563,12 +565,23 @@ static void imxfb_exit_backlight(struct imxfb_info =
*fbi)
> =20
>  static void imxfb_enable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;
> =20
>  	if (fbi->enabled)
>  		return;
> =20
>  	pr_debug("Enabling LCD controller\n");
> =20
> +	if (fbi->reg_lcd) {
> +		ret =3D regulator_enable(fbi->reg_lcd);
> +		if (ret) {
> +			dev_err(&fbi->pdev->dev,
> +				"lcd regulator enable failed with error: %d\n",
> +				ret);
> +			return;
> +		}
> +	}
> +
>  	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
> =20
>  	/* panning offset 0 (0 pixel offset)        */
> @@ -597,6 +610,8 @@ static void imxfb_enable_controller(struct imxfb_info=
 *fbi)
> =20
>  static void imxfb_disable_controller(struct imxfb_info *fbi)
>  {
> +	int ret;
> +
>  	if (!fbi->enabled)
>  		return;
> =20
> @@ -613,6 +628,14 @@ static void imxfb_disable_controller(struct imxfb_in=
fo *fbi)
>  	fbi->enabled =3D false;
> =20
>  	writel(0, fbi->regs + LCDC_RMCR);
> +
> +	if (fbi->reg_lcd) {
> +		ret =3D regulator_disable(fbi->reg_lcd);
> +		if (ret)
> +			dev_err(&fbi->pdev->dev,
> +				"lcd regulator disable failed with error: %d\n",
> +				ret);
> +	}
>  }
> =20
>  static int imxfb_blank(int blank, struct fb_info *info)
> @@ -1020,6 +1043,10 @@ static int imxfb_probe(struct platform_device *pde=
v)
>  		goto failed_register;
>  	}
> =20
> +	fbi->reg_lcd =3D devm_regulator_get(&pdev->dev, "lcd");
put a warning at list

otherwise looks ok

Best Regards,
J.
> +	if (IS_ERR(fbi->reg_lcd))
> +		fbi->reg_lcd =3D NULL;
> +
>  	imxfb_enable_controller(fbi);
>  	fbi->pdev =3D pdev;
>  #ifdef PWMR_BACKLIGHT_AVAILABLE
> --=20
> 1.7.9.5
>=20
