From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 11 Feb 2019 10:12:31 +0000
Subject: Re: [PATCH v4 3/4] gpu: ipu-v3: ipu-ic: Add support for BT.709 encoding
Message-Id: <1549879951.7687.6.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190209014748.10427-1-slongerbeam@gmail.com>
         <20190209014748.10427-4-slongerbeam@gmail.com>
In-Reply-To: <20190209014748.10427-4-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Steve Longerbeam <slongerbeam@gmail.com>, linux-media@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

On Fri, 2019-02-08 at 17:47 -0800, Steve Longerbeam wrote:
> Pass v4l2 encoding enum to the ipu_ic task init functions, and add
> support for the BT.709 encoding and inverse encoding matrices.
> 
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
> Changes in v4:
> - fix compile error.
> Chnges in v3:
> - none.
> Changes in v2:
> - only return "Unsupported YCbCr encoding" error if inf != outf,
>   since if inf = outf, the identity matrix can be used. Reported
>   by Tim Harvey.
> ---
>  drivers/gpu/ipu-v3/ipu-ic.c                 | 71 +++++++++++++++++++--
>  drivers/gpu/ipu-v3/ipu-image-convert.c      |  1 +
>  drivers/staging/media/imx/imx-ic-prpencvf.c |  4 +-
>  include/video/imx-ipu-v3.h                  |  5 +-
>  4 files changed, 71 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
> index e459615a49a1..c5f83d7e357f 100644
> --- a/drivers/gpu/ipu-v3/ipu-ic.c
> +++ b/drivers/gpu/ipu-v3/ipu-ic.c
> @@ -212,6 +212,23 @@ static const struct ic_csc_params ic_csc_identity = {
>  	.scale = 2,
>  };
>  
> +/*
> + * BT.709 encoding from RGB full range to YUV limited range:
> + *
> + * Y = R *  .2126 + G *  .7152 + B *  .0722;
> + * U = R * -.1146 + G * -.3854 + B *  .5000 + 128.;
> + * V = R *  .5000 + G * -.4542 + B * -.0458 + 128.;

This is a conversion to YUV full range. Limited range should be:

Y   R *  .1826 + G *  .6142 + B *  .0620 + 16;
U = R * -.1007 + G * -.3385 + B *  .4392 + 128;
V   R *  .4392 + G * -.3990 + B * -.0402 + 128;

> + */
> +static const struct ic_csc_params ic_csc_rgb2ycbcr_bt709 = {
> +	.coeff = {
> +		{ 54, 183, 18 },
> +		{ 483, 413, 128 },
> +		{ 128, 396, 500 },
> +	},
> +	.offset = { 0, 512, 512 },
> +	.scale = 1,
> +};
> +
>  /*
>   * Inverse BT.601 encoding from YUV limited range to RGB full range:
>   *
> @@ -229,12 +246,31 @@ static const struct ic_csc_params ic_csc_ycbcr2rgb_bt601 = {
>  	.scale = 2,
>  };
>  
> +/*
> + * Inverse BT.709 encoding from YUV limited range to RGB full range:
> + *
> + * R = (1. * (Y - 16)) + (1.5748 * (Cr - 128));
> + * G = (1. * (Y - 16)) - (0.1873 * (Cb - 128)) - (0.4681 * (Cr - 128));
> + * B = (1. * (Y - 16)) + (1.8556 * (Cb - 128);

The coefficients look like full range again, conversion from limited
range YUV should look like:

  R = (1.1644 * (Y - 16)) + (1.7927 * (Cr - 128));
  G = (1.1644 * (Y - 16)) - (0.2132 * (Cb - 128)) - (0.5329 * (Cr - 128));
  B = (1.1644 * (Y - 16)) + (2.1124 * (Cb - 128);

> + */
> +static const struct ic_csc_params ic_csc_ycbcr2rgb_bt709 = {
> +	.coeff = {
> +		{ 128, 0, 202 },
> +		{ 128, 488, 452 },
> +		{ 128, 238, 0 },
> +	},
> +	.offset = { -435, 136, -507 },
> +	.scale = 2,
> +};
> +
>  static int init_csc(struct ipu_ic *ic,
>  		    enum ipu_color_space inf,
>  		    enum ipu_color_space outf,
> +		    enum v4l2_ycbcr_encoding encoding,

Should we support YUV BT.601 <-> YUV REC.709 conversions? That would
require separate encodings for input and output. Also, this might be a
good time to think about adding quantization range parameters as well.

regards
Philipp
