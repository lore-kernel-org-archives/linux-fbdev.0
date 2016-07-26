From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 26 Jul 2016 10:08:38 +0000
Subject: Re: [PATCH v2 11/13] gpu: ipu-ic: Add complete image conversion support with tiling
Message-Id: <1469527718.3041.85.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
	 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
	 <1468977071-29240-12-git-send-email-steve_longerbeam@mentor.com>
In-Reply-To: <1468977071-29240-12-git-send-email-steve_longerbeam@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Steve Longerbeam <steve_longerbeam@mentor.com>

Am Dienstag, den 19.07.2016, 18:11 -0700 schrieb Steve Longerbeam:
> This patch implements complete image conversion support to ipu-ic,
> with tiling to support scaling to and from images up to 4096x4096.
> Image rotation is also supported.
> 
> The internal API is subsystem agnostic (no V4L2 dependency except
> for the use of V4L2 fourcc pixel formats).
> 
> Callers prepare for image conversion by calling
> ipu_image_convert_prepare(), which initializes the parameters of
> the conversion. The caller passes in the ipu_ic task to use for
> the conversion, the input and output image formats, a rotation mode,
> and a completion callback and completion context pointer:
> 
> struct image_converter_ctx *
> ipu_image_convert_prepare(struct ipu_ic *ic,
>                           struct ipu_image *in, struct ipu_image *out,
>                           enum ipu_rotate_mode rot_mode,
>                           image_converter_cb_t complete,
>                           void *complete_context);
> 
> The caller is given a new conversion context that must be passed to
> the further APIs:
> 
> struct image_converter_run *
> ipu_image_convert_run(struct image_converter_ctx *ctx,
>                       dma_addr_t in_phys, dma_addr_t out_phys);
> 
> This queues a new image conversion request to a run queue, and
> starts the conversion immediately if the run queue is empty. Only
> the physaddr's of the input and output image buffers are needed,
> since the conversion context was created previously with
> ipu_image_convert_prepare(). Returns a new run object pointer. When
> the conversion completes, the run pointer is returned to the
> completion callback.
> 
> void image_convert_abort(struct image_converter_ctx *ctx);
> 
> This will abort any active or pending conversions for this context.
> Any currently active or pending runs belonging to this context are
> returned via the completion callback with an error status.
> 
> void ipu_image_convert_unprepare(struct image_converter_ctx *ctx);
> 
> Unprepares the conversion context. Any active or pending runs will
> be aborted by calling image_convert_abort().
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>  drivers/gpu/ipu-v3/ipu-ic.c | 1691 ++++++++++++++++++++++++++++++++++++++++++-
>  include/video/imx-ipu-v3.h  |   57 +-
>  2 files changed, 1736 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-ic.c b/drivers/gpu/ipu-v3/ipu-ic.c
> index 1a37afc..5471b72 100644
> --- a/drivers/gpu/ipu-v3/ipu-ic.c
> +++ b/drivers/gpu/ipu-v3/ipu-ic.c
> @@ -17,6 +17,8 @@
>  #include <linux/bitrev.h>
>  #include <linux/io.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/dma-mapping.h>
>  #include "ipu-prv.h"
>  
>  /* IC Register Offsets */
> @@ -82,6 +84,40 @@
>  #define IC_IDMAC_3_PP_WIDTH_MASK        (0x3ff << 20)
>  #define IC_IDMAC_3_PP_WIDTH_OFFSET      20
>  
> +/*
> + * The IC Resizer has a restriction that the output frame from the
> + * resizer must be 1024 or less in both width (pixels) and height
> + * (lines).
> + *
> + * The image conversion support attempts to split up a conversion when
> + * the desired output (converted) frame resolution exceeds the IC resizer
> + * limit of 1024 in either dimension.
> + *
> + * If either dimension of the output frame exceeds the limit, the
> + * dimension is split into 1, 2, or 4 equal stripes, 

Imagine converting a 320x200 image up to 1280x800, and consider only the
x coordinate. The IC upscaler is a simple bilinear scaler.

We want target pixel x' = 1279 to sample the source pixel x = 319, so
the scaling factor rsc is calculated to:

x = x' * (320-1)/(1280-1) = x' * 8192/rsc, with rsc = 32846

That means that the target pixels x' = 639 and x' = 640 should be
sampled (bilinearly) from x = 639 * 8192/32846. = 159.37 and x = 640 *
8192/32846. = 159.62, respectively.

Now split the frame in half and suddenly pixel x' = 640 is the start of
a new tile, so it is sampled at x = 160, and pixel x' = 1279 will be
sampled at x = 160 + (1279 - 640) * 8192/32846. = 319.37, reading over
the edge of the source image.
This problem gets worse if you start using arbitrary frame sizes and YUV
planar images and consider that tile start addresses are (currently)
limited to 8 byte boundaries, to the point that there are very visible
seams in the center of the image, depending on scaling factor and image
sizes.

I wonder how much effort it would be to remove the tiling code for now
and add it back in a second step once it is fixed? Otherwise we could
just disallow scaled tiling for now, but I'd like this to be prepared
for tiles with different sizes at least, before merging.

regards
Philipp

