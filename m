From: Steve Longerbeam <steve_longerbeam@mentor.com>
Date: Thu, 28 Jul 2016 23:09:52 +0000
Subject: Re: [PATCH v2 11/13] gpu: ipu-ic: Add complete image conversion support with tiling
Message-Id: <8fad20e2-66c4-e2f4-b5d2-25190fdbaa2c@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-12-git-send-email-steve_longerbeam@mentor.com>
 <1469527718.3041.85.camel@pengutronix.de>
In-Reply-To: <1469527718.3041.85.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philipp Zabel <p.zabel@pengutronix.de>, Steve Longerbeam <slongerbeam@gmail.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Philipp,

On 07/26/2016 03:08 AM, Philipp Zabel wrote:
>
>>   
>> +/*
>> + * The IC Resizer has a restriction that the output frame from the
>> + * resizer must be 1024 or less in both width (pixels) and height
>> + * (lines).
>> + *
>> + * The image conversion support attempts to split up a conversion when
>> + * the desired output (converted) frame resolution exceeds the IC resizer
>> + * limit of 1024 in either dimension.
>> + *
>> + * If either dimension of the output frame exceeds the limit, the
>> + * dimension is split into 1, 2, or 4 equal stripes,
> Imagine converting a 320x200 image up to 1280x800, and consider only the
> x coordinate. The IC upscaler is a simple bilinear scaler.

Right, the upscaling is a simple linear interpolation between two
adjacent input pixels, just paraphrasing you.

> We want target pixel x' = 1279 to sample the source pixel x = 319, so
> the scaling factor rsc is calculated to:
>
> x = x' * (320-1)/(1280-1) = x' * 8192/rsc, with rsc = 32846
>
> That means that the target pixels x' = 639 and x' = 640 should be
> sampled (bilinearly) from x = 639 * 8192/32846. = 159.37 and x = 640 *
> 8192/32846. = 159.62, respectively.

I'm with you so far.

>
> Now split the frame in half and suddenly pixel x' = 640 is the start of
> a new tile, so it is sampled at x = 160, and pixel x' = 1279 will be
> sampled at x = 160 + (1279 - 640) * 8192/32846. = 319.37, reading over
> the edge of the source image.

Here's where we part.

The 320x200 --> 1280x800 conversion is split into two 160x200 -->
640x800 conversions. The DMA controller and ipu_ic_task_init() are given
those width/height dimensions, not the dimensions of the original images.
So this is simply two separate 160x200 --> 640x800 conversions. The only
difference from a true 160x200 --> 640x800 image conversion is that the DMA
controller must be given the stride lengths of the original 320x200 and 
1280x800
images.

The rsc for the 160x200 --> 640x800 conversions is

x = x' * (160-1)/(640-1) = x' * 8192/rsc, so rsc = 32923


So original horizontal position 640 is really x' = 0 of the second 
conversion,
which is sampled at x = 0 of the second conversion. And the pixel at x' 
= 1279
is really x' = 639 of the second conversion, which is sampled at x = 639 
* 8192/32923
= 158.98, which does not read over the edge of the source tile.


> This problem gets worse if you start using arbitrary frame sizes and YUV
> planar images and consider that tile start addresses are (currently)
> limited to 8 byte boundaries, to the point that there are very visible
> seams in the center of the image, depending on scaling factor and image
> sizes.

Indeed there could be other parameters that would cause the resizer to
read past the edge of the source tiles, I will need to try and find such 
cases.
But not in the above case.

That said, I _have_ noticed seams, but I have always attributed them to the
fact that we have a discontinuity in color-space conversion and/or resize
interpolation at the boundary between tiles.

I've also found that the seams are quite noticeable when rendered to a
display overlay, but become significantly less pronounced if the images are
converted to a back buffer, and then page-flipped to front buffer when the
conversion (all tiles) completes.

Steve

> I wonder how much effort it would be to remove the tiling code for now
> and add it back in a second step once it is fixed? Otherwise we could
> just disallow scaled tiling for now, but I'd like this to be prepared
> for tiles with different sizes at least, before merging.
>
> regards
> Philipp
>

