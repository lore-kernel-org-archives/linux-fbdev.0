From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 19 Oct 2013 11:08:33 +0000
Subject: Re: [Patch v2][ 07/37] video: mx3fb: Introduce regulator support.
Message-Id: <20131019110833.GN18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-8-git-send-email-denis@eukrea.com>
In-Reply-To: <1382022155-21954-8-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 17:02 Thu 17 Oct     , Denis Carikli wrote:
> This commit is based on the following commit by Fabio Estevam:
>   4344429 video: mxsfb: Introduce regulator support
>=20
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Eric B=E9nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/video/mx3fb.c |   47 +++++++++++++++++++++++++++++++++++++++++++=
+++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 804f874..37704da 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -27,6 +27,7 @@
>  #include <linux/clk.h>
>  #include <linux/mutex.h>
>  #include <linux/dma/ipu-dma.h>
> +#include <linux/regulator/consumer.h>
> =20
>  #include <linux/platform_data/dma-imx.h>
>  #include <linux/platform_data/video-mx3fb.h>
> @@ -267,6 +268,7 @@ struct mx3fb_info {
>  	struct dma_async_tx_descriptor	*txd;
>  	dma_cookie_t			cookie;
>  	struct scatterlist		sg[2];
> +	struct regulator		*reg_lcd;
> =20
>  	struct fb_var_screeninfo	cur_var; /* current var info */
>  };
> @@ -1001,6 +1003,7 @@ static void __blank(int blank, struct fb_info *fbi)
>  	struct mx3fb_info *mx3_fbi =3D fbi->par;
>  	struct mx3fb_data *mx3fb =3D mx3_fbi->mx3fb;
>  	int was_blank =3D mx3_fbi->blank;
> +	int ret;
> =20
>  	mx3_fbi->blank =3D blank;
> =20
> @@ -1019,6 +1022,15 @@ static void __blank(int blank, struct fb_info *fbi)
>  	case FB_BLANK_HSYNC_SUSPEND:
>  	case FB_BLANK_NORMAL:
>  		sdc_set_brightness(mx3fb, 0);
> +		if (mx3_fbi->reg_lcd) {
> +			if (regulator_is_enabled(mx3_fbi->reg_lcd)) {
do we realy need ot check if enabled?

this should be handled by the regulator API

same as clock I can disable not enabled clock

Best Regards,
J.
> +				ret =3D regulator_disable(mx3_fbi->reg_lcd);
> +				if (ret)
> +					dev_warn(fbi->device,
> +						 "lcd regulator disable failed "
> +						 "with error: %d\n", ret);
> +			}
> +		}
>  		memset((char *)fbi->screen_base, 0, fbi->fix.smem_len);
>  		/* Give LCD time to update - enough for 50 and 60 Hz */
>  		msleep(25);
> @@ -1026,7 +1038,17 @@ static void __blank(int blank, struct fb_info *fbi)
>  		break;
>  	case FB_BLANK_UNBLANK:
>  		sdc_enable_channel(mx3_fbi);
> +		if (mx3_fbi->reg_lcd) {
> +			if (!regulator_is_enabled(mx3_fbi->reg_lcd)) {
> +				ret =3D regulator_enable(mx3_fbi->reg_lcd);
> +				if (ret)
> +					dev_warn(fbi->device,
> +						 "lcd regulator enable failed "
> +						 "with error: %d\n", ret);
> +			}
> +		}
>  		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
> +
>  		break;
>  	}
>  }
> @@ -1202,6 +1224,7 @@ static int mx3fb_suspend(struct platform_device *pd=
ev, pm_message_t state)
>  {
>  	struct mx3fb_data *mx3fb =3D platform_get_drvdata(pdev);
>  	struct mx3fb_info *mx3_fbi =3D mx3fb->fbi->par;
> +	int ret;
> =20
>  	console_lock();
>  	fb_set_suspend(mx3fb->fbi, 1);
> @@ -1210,7 +1233,15 @@ static int mx3fb_suspend(struct platform_device *p=
dev, pm_message_t state)
>  	if (mx3_fbi->blank =3D FB_BLANK_UNBLANK) {
>  		sdc_disable_channel(mx3_fbi);
>  		sdc_set_brightness(mx3fb, 0);
> -
> +		if (mx3_fbi->reg_lcd) {
> +			if (regulator_is_enabled(mx3_fbi->reg_lcd)) {
> +				ret =3D regulator_disable(mx3_fbi->reg_lcd);
> +				if (ret)
> +					dev_warn(&pdev->dev,
> +						 "lcd regulator disable failed "
> +						 "with error: %d\n", ret);
> +			}
> +		}
>  	}
>  	return 0;
>  }
> @@ -1222,10 +1253,20 @@ static int mx3fb_resume(struct platform_device *p=
dev)
>  {
>  	struct mx3fb_data *mx3fb =3D platform_get_drvdata(pdev);
>  	struct mx3fb_info *mx3_fbi =3D mx3fb->fbi->par;
> +	int ret;
> =20
>  	if (mx3_fbi->blank =3D FB_BLANK_UNBLANK) {
>  		sdc_enable_channel(mx3_fbi);
>  		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
> +		if (mx3_fbi->reg_lcd) {
> +			if (!regulator_is_enabled(mx3_fbi->reg_lcd)) {
> +				ret =3D regulator_enable(mx3_fbi->reg_lcd);
> +				if (ret)
> +					dev_warn(&pdev->dev,
> +						 "lcd regulator enable failed "
> +						 "with error: %d\n", ret);
> +			}
> +		}
>  	}
> =20
>  	console_lock();
> @@ -1438,6 +1479,10 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, =
struct idmac_channel *ichan)
>  	if (ret < 0)
>  		goto erfb;
> =20
> +	mx3fbi->reg_lcd =3D devm_regulator_get(dev, "lcd");
> +	if (IS_ERR(mx3fbi->reg_lcd))
> +		mx3fbi->reg_lcd =3D NULL;
> +
>  	return 0;
> =20
>  erfb:
> --=20
> 1.7.9.5
>=20
