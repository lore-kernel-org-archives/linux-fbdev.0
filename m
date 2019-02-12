From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 12 Feb 2019 11:34:22 +0000
Subject: Re: [PATCH v4 3/4] gpu: ipu-v3: ipu-ic: Add support for BT.709 encoding
Message-Id: <1549971262.4800.5.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190209014748.10427-1-slongerbeam@gmail.com>
         <20190209014748.10427-4-slongerbeam@gmail.com>
         <1549879951.7687.6.camel@pengutronix.de>
         <440e12af-33ea-5eac-e570-8afa74e3133c@gmail.com>
In-Reply-To: <440e12af-33ea-5eac-e570-8afa74e3133c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Longerbeam <slongerbeam@gmail.com>, linux-media@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>

Hi Steve,

On Mon, 2019-02-11 at 17:20 -0800, Steve Longerbeam wrote:
[...]
> > Should we support YUV BT.601 <-> YUV REC.709 conversions? That would
> > require separate encodings for input and output.
> 
> How about if we pass the input and output encodings to the init ic task 
> functions, but for now require they be the same? We can support 
> transcoding in a later series.
[...]
> Again, I think for now, just include input/output quantization but 
> require full range for RGB and limited range for YUV.

Yes, that is fine. I'd just like to avoid unnecessary interface changes
between ipu-v3 and imx-media. So if we have to change it right now, why
not plan ahead.

> But that really balloons the arguments to ipu_ic_task_init_*(). Should 
> we create an ipu_ic_task_init structure?

I wonder if we should just expose struct ic_csc_params and provide a
helper to fill it given colorspace and V4L2 encoding/quantization
parameters. Something like:

	struct ipu_ic_csc_params csc;

	imx_media_init_ic_csc_params(&csc,
			in_cs, in_encoding, in_quantization,
			out_cs, out_encoding, out_quantization);

	ipu_ic_task_init(ic,
			in_width, in_height,
			out_width, out_height, &csc);
	// or
	ipu_ic_task_init_rsc(ic, rsc, &csc);

regards
Philipp
