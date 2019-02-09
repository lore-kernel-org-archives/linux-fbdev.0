From: Tim Harvey <tharvey@gateworks.com>
Date: Sat, 09 Feb 2019 00:20:23 +0000
Subject: Re: [PATCH v3 3/4] gpu: ipu-v3: ipu-ic: Add support for BT.709 encoding
Message-Id: <CAJ+vNU1O9E1Y=tvLvcL=0nrg6STwLxQFqOgfQpqvbTgPi4yo5w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190208192844.13930-1-slongerbeam@gmail.com> <20190208192844.13930-4-slongerbeam@gmail.com>
In-Reply-To: <20190208192844.13930-4-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: linux-media <linux-media@vger.kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

On Fri, Feb 8, 2019 at 11:28 AM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Pass v4l2 encoding enum to the ipu_ic task init functions, and add
> support for the BT.709 encoding and inverse encoding matrices.
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
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
> index e459615a49a1..0d57ca7ba18e 100644
> --- a/drivers/gpu/ipu-v3/ipu-ic.c
> +++ b/drivers/gpu/ipu-v3/ipu-ic.c
> @@ -212,6 +212,23 @@ static const struct ic_csc_params ic_csc_identity = {
>         .scale = 2,
>  };
>
> +/*
> + * BT.709 encoding from RGB full range to YUV limited range:
> + *
> + * Y = R *  .2126 + G *  .7152 + B *  .0722;
> + * U = R * -.1146 + G * -.3854 + B *  .5000 + 128.;
> + * V = R *  .5000 + G * -.4542 + B * -.0458 + 128.;
> + */
> +static const struct ic_csc_params ic_csc_rgb2ycbcr_bt709 = {
> +       .coeff = {
> +               { 54, 183, 18 },
> +               { 483, 413, 128 },
> +               { 128, 396, 500 },
> +       },
> +       .offset = { 0, 512, 512 },
> +       .scale = 1,
> +};
> +
>  /*
>   * Inverse BT.601 encoding from YUV limited range to RGB full range:
>   *
> @@ -229,12 +246,31 @@ static const struct ic_csc_params ic_csc_ycbcr2rgb_bt601 = {
>         .scale = 2,
>  };
>
> +/*
> + * Inverse BT.709 encoding from YUV limited range to RGB full range:
> + *
> + * R = (1. * (Y - 16)) + (1.5748 * (Cr - 128));
> + * G = (1. * (Y - 16)) - (0.1873 * (Cb - 128)) - (0.4681 * (Cr - 128));
> + * B = (1. * (Y - 16)) + (1.8556 * (Cb - 128);
> + */
> +static const struct ic_csc_params ic_csc_ycbcr2rgb_bt709 = {
> +       .coeff = {
> +               { 128, 0, 202 },
> +               { 128, 488, 452 },
> +               { 128, 238, 0 },
> +       },
> +       .offset = { -435, 136, -507 },
> +       .scale = 2,
> +};
> +
>  static int init_csc(struct ipu_ic *ic,
>                     enum ipu_color_space inf,
>                     enum ipu_color_space outf,
> +                   enum v4l2_ycbcr_encoding encoding,
>                     int csc_index)
>  {
>         struct ipu_ic_priv *priv = ic->priv;
> +       const struct ic_csc_params *params_rgb2yuv, *params_yuv2rgb;
>         const struct ic_csc_params *params;
>         u32 __iomem *base;
>         const u16 (*c)[3];
> @@ -244,12 +280,30 @@ static int init_csc(struct ipu_ic *ic,
>         base = (u32 __iomem *)
>                 (priv->tpmem_base + ic->reg->tpmem_csc[csc_index]);
>
> +       switch (encoding) {
> +       case V4L2_YCBCR_ENC_601:
> +               params_rgb2yuv =  &ic_csc_rgb2ycbcr_bt601;
> +               params_yuv2rgb = &ic_csc_ycbcr2rgb_bt601;
> +               break;
> +       case V4L2_YCBCR_ENC_709:
> +               params_rgb2yuv =  &ic_csc_rgb2ycbcr_bt709;
> +               params_yuv2rgb = &ic_csc_ycbcr2rgb_bt709;
> +               break;
> +       default:
> +               if (inf != outf) {
> +                       dev_err(priv->ipu->dev,
> +                               "Unsupported YCbCr encoding\n");
> +                       return -EINVAL;
> +               }
> +               break;
> +       }
> +
>         if (inf = outf)
>                 params = &ic_csc_identity;
>         else if (inf = IPUV3_COLORSPACE_YUV)
> -               params = &ic_csc_ycbcr2rgb_bt601;
> +               params = &ic_csc_ycbcr2rgb;


Steve,

compile issue...

params = params_yuv2rgb;

>         else
> -               params = &ic_csc_rgb2ycbcr_bt601;
> +               params = &ic_csc_rgb2ycbcr;

params = params_rgb2yuv;

But, I'm still failing when using the mem2mem element (gst-launch-1.0
v4l2src device=/dev/video4 ! v4l2video8convert
output-io-mode=dmabuf-import ! fbdevsink) with 'Unsupported YCbCr
encoding' because of inf=IPU_COLORSPACE_YCBCR outf=IPU_COLORSPACE_RGB
and a seemingly unset encoding being passed in.

It looks like maybe something in the mem2mem driver isn't defaulting
encoding. The call path is (v4l2_m2m_streamon -> device_run ->
ipu_image_convert_queue -> convert_start -> ipu_ic_task_init_rsc ->
init_csc).

Tim
