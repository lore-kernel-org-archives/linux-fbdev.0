From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 01 Aug 2016 09:29:40 +0000
Subject: Re: [PATCH v2 11/13] gpu: ipu-ic: Add complete image conversion support with tiling
Message-Id: <1470043780.3025.31.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467932621-358-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-1-git-send-email-steve_longerbeam@mentor.com>
 <1468977071-29240-12-git-send-email-steve_longerbeam@mentor.com>
 <1469527718.3041.85.camel@pengutronix.de>
 <8fad20e2-66c4-e2f4-b5d2-25190fdbaa2c@mentor.com>
In-Reply-To: <8fad20e2-66c4-e2f4-b5d2-25190fdbaa2c@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <steve_longerbeam@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, Steve Longerbeam <slongerbeam@gmail.com>, plagnioj@jcrosoft.com

Am Donnerstag, den 28.07.2016, 16:09 -0700 schrieb Steve Longerbeam:
> > Now split the frame in half and suddenly pixel x' = 640 is the start of
> > a new tile, so it is sampled at x = 160, and pixel x' = 1279 will be
> > sampled at x = 160 + (1279 - 640) * 8192/32846. = 319.37, reading over
> > the edge of the source image.
> 
> Here's where we part.
> 
> The 320x200 --> 1280x800 conversion is split into two 160x200 -->
> 640x800 conversions. The DMA controller and ipu_ic_task_init() are given
> those width/height dimensions, not the dimensions of the original images.
> So this is simply two separate 160x200 --> 640x800 conversions. The only
> difference from a true 160x200 --> 640x800 image conversion is that the DMA
> controller must be given the stride lengths of the original 320x200 and 
> 1280x800
> images.
> 
> The rsc for the 160x200 --> 640x800 conversions is
> 
> x = x' * (160-1)/(640-1) = x' * 8192/rsc, so rsc = 32923
> 
> 
> So original horizontal position 640 is really x' = 0 of the second 
> conversion,
> which is sampled at x = 0 of the second conversion. And the pixel at x' 
> = 1279
> is really x' = 639 of the second conversion, which is sampled at x = 639 
> * 8192/32923
> = 158.98, which does not read over the edge of the source tile.

My bad, I somehow thought that the scaling factor is calculated per
image (as it IMHO should be), not just per tile.

Of course in that case you won't ever read over the edge, but on the
other hand the visual problems are worse because you underestimate the
scaling factor and introduce a sharp edge at the center: even if the
source pixel step per target pixel step is a fraction, between pixels
width/2-1 and width/2 there's always a whole source pixel step.

Take the extreme example of scaling 32x32 to 1080x1080 pixels. The ideal
source pixels for x' = 519 and 520 should be x = 14.911 and 14.939,
respectively. Due to tiling they will be x = 15 and 16, introducing a
sharp seam in the otherwise blurry mess.

> > This problem gets worse if you start using arbitrary frame sizes and YUV
> > planar images and consider that tile start addresses are (currently)
> > limited to 8 byte boundaries, to the point that there are very visible
> > seams in the center of the image, depending on scaling factor and image
> > sizes.
> 
> Indeed there could be other parameters that would cause the resizer to
> read past the edge of the source tiles, I will need to try and find such 
> cases. 
> But not in the above case.

Ok.

> That said, I _have_ noticed seams, but I have always attributed them to the
> fact that we have a discontinuity in color-space conversion and/or resize
> interpolation at the boundary between tiles.
>
> I've also found that the seams are quite noticeable when rendered to a
> display overlay, but become significantly less pronounced if the images are
> converted to a back buffer, and then page-flipped to front buffer when the
> conversion (all tiles) completes.

I don't know what to make of this. Maybe it is a timing issue and what
you are actually seeing is tearing between tiles of different frames?

regards
Philipp

