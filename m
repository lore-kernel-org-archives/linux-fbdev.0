From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 05 Oct 2018 09:44:39 +0000
Subject: Re: [PATCH v4 02/11] gpu: ipu-csi: Swap fields according to input/output field types
Message-Id: <1538732679.3545.5.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181004185401.15751-1-slongerbeam@gmail.com>
         <20181004185401.15751-3-slongerbeam@gmail.com>
In-Reply-To: <20181004185401.15751-3-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Steve Longerbeam <slongerbeam@gmail.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

Hi Steve,

On Thu, 2018-10-04 at 11:53 -0700, Steve Longerbeam wrote:
[...]
>  int ipu_csi_init_interface(struct ipu_csi *csi,
>  			   struct v4l2_mbus_config *mbus_cfg,
> -			   struct v4l2_mbus_framefmt *mbus_fmt)
> +			   struct v4l2_mbus_framefmt *infmt,
> +			   struct v4l2_mbus_framefmt *outfmt)
>  {
[...]=20
> +		std =3D V4L2_STD_UNKNOWN;
> +		if (width =3D 720) {
> +			switch (height) {
> +			case 480:
> +				std =3D V4L2_STD_NTSC;
> +				break;
> +			case 576:
> +				std =3D V4L2_STD_PAL;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
> +		if (std =3D V4L2_STD_UNKNOWN) {
>  			dev_err(csi->ipu->dev,
[...]
> +				"Unsupported interlaced video mode\n");
> +			ret =3D -EINVAL;
> +			goto out_unlock;
>  		}
[...]
> +
> +		/* framelines for NTSC / PAL */
> +		height =3D (std & V4L2_STD_525_60) ? 525 : 625;

I think this is a bit convoluted. Instead of initializing std, then
possibly changing it, and then comparing to the inital value,=C2=A0and then
checking it again to determine the new height, why not just:

		if (width =3D 720 && height =3D 480) {
			std =3D V4L2_STD_NTSC;
			height =3D 525;
		} else if (width =3D 720 && height =3D 576) {
			std =3D V4L2_STD_PAL;
			height =3D 625;
		} else {
			dev_err(csi->ipu->dev,
				"Unsupported interlaced video mode\n");
			ret =3D -EINVAL;
			goto out_unlock;
		}

?

>  		break;
>  	case IPU_CSI_CLK_MODE_CCIR1120_PROGRESSIVE_DDR:
>  	case IPU_CSI_CLK_MODE_CCIR1120_PROGRESSIVE_SDR:
> @@ -476,9 +529,10 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
>  	dev_dbg(csi->ipu->dev, "CSI_ACT_FRM_SIZE =3D 0x%08X\n",
>  		ipu_csi_read(csi, CSI_ACT_FRM_SIZE));
> =20
> +out_unlock:
>  	spin_unlock_irqrestore(&csi->lock, flags);
> =20
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ipu_csi_init_interface);
> =20
> diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/=
media/imx/imx-media-csi.c
> index 4acdd7ae612b..ad66f007d395 100644
> --- a/drivers/staging/media/imx/imx-media-csi.c
> +++ b/drivers/staging/media/imx/imx-media-csi.c
> @@ -666,7 +666,6 @@ static int csi_setup(struct csi_priv *priv)
>  	struct v4l2_mbus_framefmt *infmt, *outfmt;
>  	const struct imx_media_pixfmt *incc;
>  	struct v4l2_mbus_config mbus_cfg;
> -	struct v4l2_mbus_framefmt if_fmt;
>  	struct v4l2_rect crop;
> =20
>  	infmt =3D &priv->format_mbus[CSI_SINK_PAD];
> @@ -679,22 +678,14 @@ static int csi_setup(struct csi_priv *priv)
>  		priv->upstream_ep.bus.parallel.flags :
>  		priv->upstream_ep.bus.mipi_csi2.flags;
> =20
> -	/*
> -	 * we need to pass input frame to CSI interface, but
> -	 * with translated field type from output format
> -	 */
> -	if_fmt =3D *infmt;
> -	if_fmt.field =3D outfmt->field;
>  	crop =3D priv->crop;
> =20
>  	/*
>  	 * if cycles is set, we need to handle this over multiple cycles as
>  	 * generic/bayer data
>  	 */
> -	if (is_parallel_bus(&priv->upstream_ep) && incc->cycles) {
> -		if_fmt.width *=3D incc->cycles;

If the input format width passed to ipu_csi_init_interface is not
multiplied by the number of cycles per pixel anymore, width in the
CSI_SENS_FRM_SIZE register will be set to the unmultiplied value from
infmt.
This breaks 779680e2e793 ("media: imx: add support for RGB565_2X8 on
parallel bus").

> +	if (is_parallel_bus(&priv->upstream_ep) && incc->cycles)
>  		crop.width *=3D incc->cycles;
> -	}
> =20
>  	ipu_csi_set_window(priv->csi, &crop);
> =20
> @@ -702,7 +693,7 @@ static int csi_setup(struct csi_priv *priv)
>  			     priv->crop.width =3D 2 * priv->compose.width,
>  			     priv->crop.height =3D 2 * priv->compose.height);
> =20
> -	ipu_csi_init_interface(priv->csi, &mbus_cfg, &if_fmt);
> +	ipu_csi_init_interface(priv->csi, &mbus_cfg, infmt, outfmt);

regards
Philipp
