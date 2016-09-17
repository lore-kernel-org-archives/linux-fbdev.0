From: Steve Longerbeam <steve_longerbeam@mentor.com>
Date: Sat, 17 Sep 2016 18:46:23 +0000
Subject: Re: [PATCH v4 3/4] gpu: ipu-ic: Add complete image conversion support with tiling
Message-Id: <be09a9dc-96f0-07f6-a527-1c144105af79@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471481419-5917-1-git-send-email-steve_longerbeam@mentor.com>
 <1471481419-5917-4-git-send-email-steve_longerbeam@mentor.com>
 <1473153980.2805.89.camel@pengutronix.de>
 <fa6812fb-e3b4-9a39-e956-42b3253142f3@mentor.com>
 <1474035362.2491.59.camel@pengutronix.de>
In-Reply-To: <1474035362.2491.59.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org



On 09/16/2016 07:16 AM, Philipp Zabel wrote:
> Hi Steve,
>
> thanks for the update.
>
> Am Mittwoch, den 14.09.2016, 18:45 -0700 schrieb Steve Longerbeam:
>> I added comment headers for all the image conversion prototypes.
>> It caused bloat in imx-ipu-v3.h, so I moved it to a new header:
>> include/video/imx-image-convert.h, but let me know if we should put
>> this somewhere else and/or under Documentation/ somewhere.
> I think that is the right place already. imx-image-convert.h could be
> renamed to imx-ipu-image-convert.h, to make clear that this is about the
> IPU image converter.

Ok, I'll send another update with the name change in the next
version (v7).
>
>>>> +#define MIN_W     128
>>>> +#define MIN_H     128
>>> Where does this minimum come from?
>> Nowhere really :) This is just some sane minimums, to pass
>> to clamp_align() when aligning input/output width/height in
>> ipu_image_convert_adjust().
> Let's use hardware minimum in the low level code. Sane defaults are for
> the V4L2 API. Would that be 8x2 pixels per input tile?

I searched the imx6 reference manual, I can't find any mention
of width/height minimums for the IC. So I suppose 8x2 would be fine,
or maybe 16x8, to account for planar and IRT conversions.

>
>>>> +	if (ipu_rot_mode_is_irt(ctx->rot_mode)) {
>>>> +		/* this is a rotation operation, just ignore */
>>>> +		spin_unlock_irqrestore(&cvt->irqlock, flags);
>>>> +		return IRQ_HANDLED;
>>>> +	}
>>> Why enable the out_chan EOF irq at all when using the IRT mode?
>> Because (see above), all the IPU resources that might be needed
>> for any conversion context that is queued to a image conversion
>> channel (IC task) are acquired when the first context is queued,
>> including rotation resources. So by acquiring the non-rotation EOF
>> irq, it will get fielded even for rotation conversions, so we have to
>> handle it.
> There is nothing wrong with acquiring the irq. It could still be
> disabled while it is not needed.

It would be difficult to disable the irq. Remember the irq handlers must
field all EOF interrupts in an ipu_image_convert_chan (IC task). If one
context in that channel disables the irq, it will break other runnings
contexts in that channel that are using it.

>
>>>> +/* Adjusts input/output images to IPU restrictions */
>>>> +int ipu_image_convert_adjust(struct ipu_image *in, struct ipu_image *out,
>>>> +			     enum ipu_rotate_mode rot_mode)
>>>> +{
>>>> +	const struct ipu_ic_pixfmt *infmt, *outfmt;
>>>> +	unsigned int num_in_rows, num_in_cols;
>>>> +	unsigned int num_out_rows, num_out_cols;
>>>> +	u32 w_align, h_align;
>>>> +
>>>> +	infmt = ipu_ic_get_format(in->pix.pixelformat);
>>>> +	outfmt = ipu_ic_get_format(out->pix.pixelformat);
>>>> +
>>>> +	/* set some defaults if needed */
>>> Is this our task at all?
>> ipu_image_convert_adjust() is meant to be called by v4l2 try_format(),
>> which should never return EINVAL but should return a supported format
>> when the passed format is not supported. So I added this here to return
>> some default pixel formats and width/heights if needed.
> I'd prefer to move this into the mem2mem driver try_format, then.

We could move the 0 width/height checks to v4l2, but the pixel
format defaults should probably remain in ipu-image-convert, since
it knows what formats it supports converting to/from.

Steve

