From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 16 Sep 2016 14:16:02 +0000
Subject: Re: [PATCH v4 3/4] gpu: ipu-ic: Add complete image conversion support with tiling
Message-Id: <1474035362.2491.59.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
         <1471481419-5917-4-git-send-email-steve_longerbeam@mentor.com>
         <1473153980.2805.89.camel@pengutronix.de>
         <fa6812fb-e3b4-9a39-e956-42b3253142f3@mentor.com>
In-Reply-To: <fa6812fb-e3b4-9a39-e956-42b3253142f3@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <steve_longerbeam@mentor.com>
Cc: Steve Longerbeam <slongerbeam@gmail.com>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Steve,

thanks for the update.

Am Mittwoch, den 14.09.2016, 18:45 -0700 schrieb Steve Longerbeam:
> Hi Philipp,
> 
> 
> On 09/06/2016 02:26 AM, Philipp Zabel wrote:
> > Hi Steve,
> >
> > Am Mittwoch, den 17.08.2016, 17:50 -0700 schrieb Steve Longerbeam:
> >> This patch implements complete image conversion support to ipu-ic,
> >> with tiling to support scaling to and from images up to 4096x4096.
> >> Image rotation is also supported.
> >>
> >> The internal API is subsystem agnostic (no V4L2 dependency except
> >> for the use of V4L2 fourcc pixel formats).
> >>
> >> Callers prepare for image conversion by calling
> >> ipu_image_convert_prepare(), which initializes the parameters of
> >> the conversion.
> > ... and possibly allocates intermediate buffers for rotation support.
> > This should be documented somewhere, with a node that v4l2 users should
> > be doing this during REQBUFS.
> 
> I added comment headers for all the image conversion prototypes.
> It caused bloat in imx-ipu-v3.h, so I moved it to a new header:
> include/video/imx-image-convert.h, but let me know if we should put
> this somewhere else and/or under Documentation/ somewhere.

I think that is the right place already. imx-image-convert.h could be
renamed to imx-ipu-image-convert.h, to make clear that this is about the
IPU image converter.

> >>   The caller passes in the ipu_ic task to use for
> >> the conversion, the input and output image formats, a rotation mode,
> >> and a completion callback and completion context pointer:
> >>
> >> struct image_converter_ctx *
> >> ipu_image_convert_prepare(struct ipu_ic *ic,
> >>                            struct ipu_image *in, struct ipu_image *out,
> >>                            enum ipu_rotate_mode rot_mode,
> >>                            image_converter_cb_t complete,
> >>                            void *complete_context);
> > As I commented on the other patch, I think the image_convert functions
> > should use a separate handle for the image conversion queues that sit on
> > top of the ipu_ic task handles.
> 
> Here is a new prototype I came up with:
> 
> struct ipu_image_convert_ctx *
> ipu_image_convert_prepare(struct ipu_soc *ipu, enum ipu_ic_task ic_task,
>                struct ipu_image *in, struct ipu_image *out,
>                enum ipu_rotate_mode rot_mode,
>                ipu_image_convert_cb_t complete,
>                void *complete_context);
> 
> In other words, the ipu_ic handle is replaced by the IPU handle and IC task
> that are requested for carrying out the conversion.

Looks good to me for now.

> The image converter will acquire the ipu_ic handle internally, whenever 
> there
> are queued contexts to that IC task (which I am calling a 'struct 
> ipu_image_convert_chan').
> This way the IC handle can be shared by all contexts using that IC task. 
> After all
> contexts have been freed from the (struct 
> ipu_image_convert_chan)->ctx_list queue,
> the ipu_ic handle is freed.
> 
> The ipu_ic handle is acquired in get_ipu_resources() and freed in 
> release_ipu_resources(),
> along with all the other IPU resources that *could possibly be needed* 
> in that
> ipu_image_convert_chan by future contexts (*all* idmac channels, *all* 
> irqs).

Ok.

[...]
> >> +#define MIN_W     128
> >> +#define MIN_H     128
> > Where does this minimum come from?
> 
> Nowhere really :) This is just some sane minimums, to pass
> to clamp_align() when aligning input/output width/height in
> ipu_image_convert_adjust().

Let's use hardware minimum in the low level code. Sane defaults are for
the V4L2 API. Would that be 8x2 pixels per input tile?

> >> +struct ic_task_channels {
> >> +	int in;
> >> +	int out;
> >> +	int rot_in;
> >> +	int rot_out;
> >> +	int vdi_in_p;
> >> +	int vdi_in;
> >> +	int vdi_in_n;
> > The vdi channels are unused.
> 
> Well, I'd prefer to keep the VDI channels. It's quite possible we
> can add motion compensated deinterlacing support using the
> PRP_VF task to the image converter in the future.

Indeed.

> >> +struct image_converter_ctx {
> >> +	struct image_converter *cvt;
> >> +
> >> +	image_converter_cb_t complete;
> >> +	void *complete_context;
> >> +
> >> +	/* Source/destination image data and rotation mode */
> >> +	struct ipu_ic_image in;
> >> +	struct ipu_ic_image out;
> >> +	enum ipu_rotate_mode rot_mode;
> >> +
> >> +	/* intermediate buffer for rotation */
> >> +	struct ipu_ic_dma_buf rot_intermediate[2];
> > No need to change it now, but I assume these could be per IC task
> > instead of per context.
> 
> Actually no. The rotation intermediate buffers have the dimension
> of a single tile, so they must remain in the context struct.

I see. The per task intermediate buffer would have to be the maximum
size, so this would only ever make sense when rotating multiple large
RGB streams simultaneously. I think we can reasonably ignore this use
case.

[...]
> >> +		.fourcc	= V4L2_PIX_FMT_RGB565,
> >> +		.bpp    = 16,
> > bpp is only ever used in bytes, not bits (always divided by 8).
> > Why not make this bytes_per_pixel or pixel_stride = 2.
> 
> Actually bpp is used to calculate *total* tile sizes and *total* bytes
> per line. For the planar 4:2:0 formats that means it must be specified
> in bits.

Ok for total size of chroma subsampled planar formats.

[...]
> > Most of the following code seems to be running under one big spinlock.
> > Is this really necessary?
> 
> You're right, convert_stop(), convert_start(), and init_idmac_channel() are
> only calling the ipu_ic lower level primitives. So they don't require 
> the irqlock.
> I did remove the "hold irqlock when calling" comment for those. However
> they are called embedded in the irq handling, so it would be cumbersome
> to drop the lock there only because they don't need it. We can revisit the
> lock handling later if you see some room for optimization there.

Alright, let's call it future performance optimization potential.

> >> +static irqreturn_t ipu_ic_norotate_irq(int irq, void *data)
> >> +{
[...]
> >> +	if (ipu_rot_mode_is_irt(ctx->rot_mode)) {
> >> +		/* this is a rotation operation, just ignore */
> >> +		spin_unlock_irqrestore(&cvt->irqlock, flags);
> >> +		return IRQ_HANDLED;
> >> +	}
> > Why enable the out_chan EOF irq at all when using the IRT mode?
> 
> Because (see above), all the IPU resources that might be needed
> for any conversion context that is queued to a image conversion
> channel (IC task) are acquired when the first context is queued,
> including rotation resources. So by acquiring the non-rotation EOF
> irq, it will get fielded even for rotation conversions, so we have to
> handle it.

There is nothing wrong with acquiring the irq. It could still be
disabled while it is not needed.

> >> +/* Adjusts input/output images to IPU restrictions */
> >> +int ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
> >> +			     enum ipu_rotate_mode rot_mode)
> >> +{
> >> +	const struct ipu_ic_pixfmt *infmt, *outfmt;
> >> +	unsigned int num_in_rows, num_in_cols;
> >> +	unsigned int num_out_rows, num_out_cols;
> >> +	u32 w_align, h_align;
> >> +
> >> +	infmt = ipu_ic_get_format(in->pix.pixelformat);
> >> +	outfmt = ipu_ic_get_format(out->pix.pixelformat);
> >> +
> >> +	/* set some defaults if needed */
> > Is this our task at all?
> 
> ipu_image_convert_adjust() is meant to be called by v4l2 try_format(),
> which should never return EINVAL but should return a supported format
> when the passed format is not supported. So I added this here to return
> some default pixel formats and width/heights if needed.

I'd prefer to move this into the mem2mem driver try_format, then.

The remaining issues are minor and can be fixed later.
I'll apply this as is.

regards
Philipp

