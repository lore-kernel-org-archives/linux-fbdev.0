From: Steve Longerbeam <steve_longerbeam@mentor.com>
Date: Thu, 15 Sep 2016 01:45:15 +0000
Subject: Re: [PATCH v4 3/4] gpu: ipu-ic: Add complete image conversion support with tiling
Message-Id: <fa6812fb-e3b4-9a39-e956-42b3253142f3@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
 <1471481419-5917-4-git-send-email-steve_longerbeam@mentor.com>
 <1473153980.2805.89.camel@pengutronix.de>
In-Reply-To: <1473153980.2805.89.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Philipp,


On 09/06/2016 02:26 AM, Philipp Zabel wrote:
> Hi Steve,
>
> Am Mittwoch, den 17.08.2016, 17:50 -0700 schrieb Steve Longerbeam:
>> This patch implements complete image conversion support to ipu-ic,
>> with tiling to support scaling to and from images up to 4096x4096.
>> Image rotation is also supported.
>>
>> The internal API is subsystem agnostic (no V4L2 dependency except
>> for the use of V4L2 fourcc pixel formats).
>>
>> Callers prepare for image conversion by calling
>> ipu_image_convert_prepare(), which initializes the parameters of
>> the conversion.
> ... and possibly allocates intermediate buffers for rotation support.
> This should be documented somewhere, with a node that v4l2 users should
> be doing this during REQBUFS.

I added comment headers for all the image conversion prototypes.
It caused bloat in imx-ipu-v3.h, so I moved it to a new header:
include/video/imx-image-convert.h, but let me know if we should put
this somewhere else and/or under Documentation/ somewhere.


>>   The caller passes in the ipu_ic task to use for
>> the conversion, the input and output image formats, a rotation mode,
>> and a completion callback and completion context pointer:
>>
>> struct image_converter_ctx *
>> ipu_image_convert_prepare(struct ipu_ic *ic,
>>                            struct ipu_image *in, struct ipu_image *out,
>>                            enum ipu_rotate_mode rot_mode,
>>                            image_converter_cb_t complete,
>>                            void *complete_context);
> As I commented on the other patch, I think the image_convert functions
> should use a separate handle for the image conversion queues that sit on
> top of the ipu_ic task handles.

Here is a new prototype I came up with:

struct ipu_image_convert_ctx *
ipu_image_convert_prepare(struct ipu_soc *ipu, enum ipu_ic_task ic_task,
               struct ipu_image *in, struct ipu_image *out,
               enum ipu_rotate_mode rot_mode,
               ipu_image_convert_cb_t complete,
               void *complete_context);

In other words, the ipu_ic handle is replaced by the IPU handle and IC task
that are requested for carrying out the conversion.

The image converter will acquire the ipu_ic handle internally, whenever 
there
are queued contexts to that IC task (which I am calling a 'struct 
ipu_image_convert_chan').
This way the IC handle can be shared by all contexts using that IC task. 
After all
contexts have been freed from the (struct 
ipu_image_convert_chan)->ctx_list queue,
the ipu_ic handle is freed.

The ipu_ic handle is acquired in get_ipu_resources() and freed in 
release_ipu_resources(),
along with all the other IPU resources that *could possibly be needed* 
in that
ipu_image_convert_chan by future contexts (*all* idmac channels, *all* 
irqs).

I should have done this from the start, instead of allowing multiple 
handles the the IC tasks.
Thanks for pointing this out.

>
>> +
>> +#define MIN_W     128
>> +#define MIN_H     128
> Where does this minimum come from?

Nowhere really :) This is just some sane minimums, to pass
to clamp_align() when aligning input/output width/height in
ipu_image_convert_adjust().

>> +struct ic_task_channels {
>> +	int in;
>> +	int out;
>> +	int rot_in;
>> +	int rot_out;
>> +	int vdi_in_p;
>> +	int vdi_in;
>> +	int vdi_in_n;
> The vdi channels are unused.

Well, I'd prefer to keep the VDI channels. It's quite possible we
can add motion compensated deinterlacing support using the
PRP_VF task to the image converter in the future.

>> +struct image_converter_ctx {
>> +	struct image_converter *cvt;
>> +
>> +	image_converter_cb_t complete;
>> +	void *complete_context;
>> +
>> +	/* Source/destination image data and rotation mode */
>> +	struct ipu_ic_image in;
>> +	struct ipu_ic_image out;
>> +	enum ipu_rotate_mode rot_mode;
>> +
>> +	/* intermediate buffer for rotation */
>> +	struct ipu_ic_dma_buf rot_intermediate[2];
> No need to change it now, but I assume these could be per IC task
> instead of per context.

Actually no. The rotation intermediate buffers have the dimension
of a single tile, so they must remain in the context struct.

>> +static const struct ipu_ic_pixfmt ipu_ic_formats[] = {
>> +	{
>> +		.name	= "RGB565",
> Please drop the names, keeping a list of user readable format names is
> the v4l2 core's business, not ours.

done.

>> +		.fourcc	= V4L2_PIX_FMT_RGB565,
>> +		.bpp    = 16,
> bpp is only ever used in bytes, not bits (always divided by 8).
> Why not make this bytes_per_pixel or pixel_stride = 2.

Actually bpp is used to calculate *total* tile sizes and *total* bytes
per line. For the planar 4:2:0 formats that means it must be specified
in bits.


>> +	}, {
>> +		.name	= "4:2:0 planar, YUV",
>> +		.fourcc	= V4L2_PIX_FMT_YUV420,
>> +		.bpp    = 12,
>> +		.y_depth = 8,
> y_depth is only ever used in bytes, not bits (always divided by 8).
> Why not make this bool planar instead.

sure why not, although I think y_depth makes the calculations more
explanatory, but not important. Done.

>>
>> +static int ipu_ic_alloc_dma_buf(struct ipu_ic_priv *priv,
>> +				struct ipu_ic_dma_buf *buf,
>> +				int size)
>> +{
>> +	unsigned long newlen = PAGE_ALIGN(size);
>> +
>> +	if (buf->virt) {
>> +		if (buf->len = newlen)
>> +			return 0;
>> +		ipu_ic_free_dma_buf(priv, buf);
>> +	}
> Is it necessary to support reallocation? This is currently only used by
> the prepare function, which creates a new context.

Yep, thanks for catching, removed.

>> +static void ipu_ic_calc_tile_dimensions(struct image_converter_ctx *ctx,
>> +					struct ipu_ic_image *image)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ctx->num_tiles; i++) {
>> +		struct ipu_ic_tile *tile = &image->tile[i];
>> +
>> +		tile->height = image->base.pix.height / image->num_rows;
>> +		tile->width = image->base.pix.width / image->num_cols;
> We already have talked about this, this simplified tiling will cause
> image artifacts (horizontal and vertical seams at the tile borders) when
> the bilinear upscaler source pixel step is significantly smaller than a
> whole pixel.
> This can be fixed in the future by using overlapping tiles of different
> sizes and possibly by slightly changing the scaling factors of
> individual tiles.

Right, for now I've added a FIXME note near the top.

> This looks nice, but I'd just move the rot_mode conditional below
> assignment of src_row/col and do away with the sin/cos temporary
> variables:
>
> 	/*
> 	 * before doing the transform, first we have to translate
> 	 * source row,col for an origin in the center of s_image
> 	 */
> 	src_row = src_row * 2 - (s_image->num_rows - 1);
> 	src_col = src_col * 2 - (s_image->num_cols - 1);
>
> 	/* do the rotation transform */
> 	if (ctx->rot_mode & IPU_ROT_BIT_90) {
> 		dst_col = -src_row;
> 		dst_row = src_col;
> 	} else {
> 		dst_col = src_col;
> 		dst_row = src_row;
> 	}

Done.

>> +		for (col = 0; col < image->num_cols; col++) {
>> +			y_col_off = (col * w * y_depth) >> 3;
> We know that for planar formats, y_depth can only ever be 8. No need to
> calculate this here.

Done.

> Most of the following code seems to be running under one big spinlock.
> Is this really necessary?

You're right, convert_stop(), convert_start(), and init_idmac_channel() are
only calling the ipu_ic lower level primitives. So they don't require 
the irqlock.
I did remove the "hold irqlock when calling" comment for those. However
they are called embedded in the irq handling, so it would be cumbersome
to drop the lock there only because they don't need it. We can revisit the
lock handling later if you see some room for optimization there.


>> +static int ipu_ic_get_run_count(struct image_converter_ctx *ctx,
>> +				struct list_head *q)
>> +{
>> +	struct image_converter_run *run;
>> +	int count = 0;
> Add
> 	lockdep_assert_held(&ctx->irqlock);
> for the functions that expect their caller to be holding the lock.

Done.

>> +	list_for_each_entry(run, q, list) {
>> +		if (run->ctx = ctx)
>> +			count++;
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +/* hold irqlock when calling */
>> +static void ipu_ic_convert_stop(struct image_converter_run *run)
>> +{
>> +	struct image_converter_ctx *ctx = run->ctx;
>> +	struct image_converter *cvt = ctx->cvt;
>> +	struct ipu_ic_priv *priv = cvt->ic->priv;
>> +
>> +	dev_dbg(priv->ipu->dev, "%s: stopping ctx %p run %p\n",
>> +		__func__, ctx, run);
> Maybe add some indication which IC task this context belongs to?

Done.

>> +
>> +	if (channel = cvt->rotation_in_chan ||
>> +	    channel = cvt->rotation_out_chan) {
>> +		burst_size = 8;
>> +		ipu_cpmem_set_block_mode(channel);
>> +	} else
>> +		burst_size = (width % 16) ? 8 : 16;
> This is for later, but it might turn out to be better to accept a little
> overdraw if stride allows for it and use the larger burst size,
> especially for wide images.

Right, as long as the stride is a multiple of the burst size.


>>
>>
>>
>> +
>> +static irqreturn_t ipu_ic_norotate_irq(int irq, void *data)
>> +{
>> +	struct image_converter *cvt = data;
>> +	struct image_converter_ctx *ctx;
>> +	struct image_converter_run *run;
>> +	unsigned long flags;
>> +	irqreturn_t ret;
>> +
>> +	spin_lock_irqsave(&cvt->irqlock, flags);
>> +
>> +	/* get current run and its context */
>> +	run = cvt->current_run;
>> +	if (!run) {
>> +		ret = IRQ_NONE;
>> +		goto out;
>> +	}
>> +
>> +	ctx = run->ctx;
>> +
>> +	if (ipu_rot_mode_is_irt(ctx->rot_mode)) {
>> +		/* this is a rotation operation, just ignore */
>> +		spin_unlock_irqrestore(&cvt->irqlock, flags);
>> +		return IRQ_HANDLED;
>> +	}
> Why enable the out_chan EOF irq at all when using the IRT mode?

Because (see above), all the IPU resources that might be needed
for any conversion context that is queued to a image conversion
channel (IC task) are acquired when the first context is queued,
including rotation resources. So by acquiring the non-rotation EOF
irq, it will get fielded even for rotation conversions, so we have to
handle it.

>>
>>
>> +/* Adjusts input/output images to IPU restrictions */
>> +int ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
>> +			     enum ipu_rotate_mode rot_mode)
>> +{
>> +	const struct ipu_ic_pixfmt *infmt, *outfmt;
>> +	unsigned int num_in_rows, num_in_cols;
>> +	unsigned int num_out_rows, num_out_cols;
>> +	u32 w_align, h_align;
>> +
>> +	infmt = ipu_ic_get_format(in->pix.pixelformat);
>> +	outfmt = ipu_ic_get_format(out->pix.pixelformat);
>> +
>> +	/* set some defaults if needed */
> Is this our task at all?

ipu_image_convert_adjust() is meant to be called by v4l2 try_format(),
which should never return EINVAL but should return a supported format
when the passed format is not supported. So I added this here to return
some default pixel formats and width/heights if needed.

>> +	if (!infmt) {
>> +		in->pix.pixelformat = V4L2_PIX_FMT_RGB24;
>> +		infmt = ipu_ic_get_format(V4L2_PIX_FMT_RGB24);
>> +	}
>> +	if (!outfmt) {
>> +		out->pix.pixelformat = V4L2_PIX_FMT_RGB24;
>> +		outfmt = ipu_ic_get_format(V4L2_PIX_FMT_RGB24);
>> +	}
>> +
>> +	if (!in->pix.width || !in->pix.height) {
>> +		in->pix.width = 640;
>> +		in->pix.height = 480;
>> +	}
>> +	if (!out->pix.width || !out->pix.height) {
>> +		out->pix.width = 640;
>> +		out->pix.height = 480;
>> +	}
>> +
>> +	/* image converter does not handle fields */
>> +	in->pix.field = out->pix.field = V4L2_FIELD_NONE;
> Why not? The scaler can scale alternate top/bottom fields no problem.
>
> For SEQ_TB/BT and the interleaved interlacing we'd have to adjust
> scaling factors per field and use two vertical tiles for the fields
> before this can be supported.

Right, we could do that. It would then be up to a later pipeline element
to do the deinterlacing, but at least this would scale and/or color convert
the fields.

>> +/*
>> + * Carry out a single image conversion. Only the physaddr's of the input
>> + * and output image buffers are needed. The conversion context must have
>> + * been created previously with ipu_image_convert_prepare(). Returns the
>> + * new run object.
>> + */
>> +struct image_converter_run *
>> +ipu_image_convert_run(struct image_converter_ctx *ctx,
>> +		      dma_addr_t in_phys, dma_addr_t out_phys)
>> +{
>> +	struct image_converter *cvt = ctx->cvt;
>> +	struct ipu_ic_priv *priv = cvt->ic->priv;
>> +	struct image_converter_run *run;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	run = kzalloc(sizeof(*run), GFP_KERNEL);
>> +	if (!run)
>> +		return ERR_PTR(-ENOMEM);
> What is the reasoning behind making the image_converter_run opaque to
> the user? If you let the user provide it to ipu_image_convert_run, it
> wouldn't have to be allocated/freed with each frame.

Good idea, done!

> Most of this calculation of tile geometry and conversion queue handling
> code is not really low level IC hardware access. I'd like the code that
> doesn't have to access ipu_ic internals directly to be moved into a
> separate source file. I'd suggest ipu-ic-queue.c, or
> ipu-image-convert.c.

Done, I created ipu-image-convert.c.

>> +
>> +struct image_converter_ctx;
>> +struct image_converter_run;
>> +
> Add an ipu_ prefix to those.

Done.

I will be pushing a new patch-set shortly with these changes.

Steve


