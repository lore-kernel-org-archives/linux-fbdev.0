From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 08 Feb 2019 16:24:34 +0000
Subject: Re: [PATCH 2/3] gpu: ipu-v3: ipu-ic: Add support for BT.709 encoding
Message-Id: <CAJ+vNU0dP+muS7h=8SaHBk1uTEiQT4JpeHKEDG_+VJXAc20Bew@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190203194744.11546-1-slongerbeam@gmail.com>
 <20190203194744.11546-3-slongerbeam@gmail.com>
In-Reply-To: <20190203194744.11546-3-slongerbeam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media <linux-media@vger.kernel.org>

On Sun, Feb 3, 2019 at 11:48 AM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>
> Pass v4l2 encoding enum to the ipu_ic task init functions, and add
> support for the BT.709 encoding and inverse encoding matrices.
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
> ---
>  drivers/gpu/ipu-v3/ipu-ic.c                 | 67 ++++++++++++++++++---
>  drivers/gpu/ipu-v3/ipu-image-convert.c      |  1 +
>  drivers/staging/media/imx/imx-ic-prpencvf.c |  4 +-
>  include/video/imx-ipu-v3.h                  |  5 +-
>  4 files changed, 67 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
> index 35ae86ff0585..63362b4fff81 100644
> --- a/drivers/gpu/ipu-v3/ipu-ic.c
> +++ b/drivers/gpu/ipu-v3/ipu-ic.c
> @@ -199,6 +199,23 @@ static const struct ic_csc_params ic_csc_rgb2ycbcr_bt601 = {
>         .scale = 1,
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
>  /* transparent RGB->RGB matrix for graphics combining */
>  static const struct ic_csc_params ic_csc_rgb2rgb = {
>         .coeff = {
> @@ -226,12 +243,31 @@ static const struct ic_csc_params ic_csc_ycbcr2rgb_bt601 = {
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
> @@ -241,10 +277,24 @@ static int init_csc(struct ipu_ic *ic,
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
> +               dev_err(priv->ipu->dev, "Unsupported YCbCr encoding\n");
> +               return -EINVAL;
> +       }
> +

Steve,

This will fail for RGB to RGB with 'Unsupported YCbCr encoding. We
need to account for the RGB->RGB case.

How about something like:

 static int init_csc(struct ipu_ic *ic,
                    enum ipu_color_space inf,
                    enum ipu_color_space outf,
+                   enum v4l2_ycbcr_encoding encoding,
                    int csc_index)
 {
        struct ipu_ic_priv *priv = ic->priv;
-       const struct ic_csc_params *params;
+       const struct ic_csc_params *params = NULL;
        u32 __iomem *base;
        const u16 (*c)[3];
        const u16 *a;
@@ -241,13 +276,18 @@ static int init_csc(struct ipu_ic *ic,
        base = (u32 __iomem *)
                (priv->tpmem_base + ic->reg->tpmem_csc[csc_index]);

-       if (inf = IPUV3_COLORSPACE_YUV && outf = IPUV3_COLORSPACE_RGB)
-               params = &ic_csc_ycbcr2rgb_bt601;
-       else if (inf = IPUV3_COLORSPACE_RGB && outf = IPUV3_COLORSPACE_YUV)
-               params = &ic_csc_rgb2ycbcr_bt601;
+       if (inf = IPUV3_COLORSPACE_YUV && outf = IPUV3_COLORSPACE_RGB) {
+               params = (encoding = V4L2_YCBCR_ENC_601) ?
+                       &ic_csc_ycbcr2rgb_bt601 : &ic_csc_ycbcr2rgb_bt709;
+       }
+       else if (inf = IPUV3_COLORSPACE_RGB && outf = IPUV3_COLORSPACE_YUV) {
+               params = (encoding = V4L2_YCBCR_ENC_601) ?
+                       &ic_csc_rgb2ycbcr_bt601 : &ic_csc_rgb2ycbcr_bt709;
+       }
        else if (inf = IPUV3_COLORSPACE_RGB && outf = IPUV3_COLORSPACE_RGB)
                params = &ic_csc_rgb2rgb;
-       else {
+
+       if (!params) {
                dev_err(priv->ipu->dev, "Unsupported color space conversion\n");
                return -EINVAL;
        }

Tim
