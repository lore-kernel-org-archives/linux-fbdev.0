From: Steve Longerbeam <slongerbeam@gmail.com>
Date: Sat, 09 Feb 2019 01:31:10 +0000
Subject: Re: [PATCH v3 3/4] gpu: ipu-v3: ipu-ic: Add support for BT.709 encoding
Message-Id: <f02aa3a8-1767-d92d-a80e-0b618f9119a3@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190208192844.13930-1-slongerbeam@gmail.com>
 <20190208192844.13930-4-slongerbeam@gmail.com>
 <CAJ+vNU1O9E1Y=tvLvcL=0nrg6STwLxQFqOgfQpqvbTgPi4yo5w@mail.gmail.com>
In-Reply-To: <CAJ+vNU1O9E1Y=tvLvcL=0nrg6STwLxQFqOgfQpqvbTgPi4yo5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tim Harvey <tharvey@gateworks.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVERS FOR FREESCALE IMX" <dri-devel@lists.freedesktop.org>, Philipp Zabel <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media <linux-media@vger.kernel.org>



On 2/8/19 4:20 PM, Tim Harvey wrote:
> On Fri, Feb 8, 2019 at 11:28 AM Steve Longerbeam <slongerbeam@gmail.com> wrote:
>>          if (inf = outf)
>>                  params = &ic_csc_identity;
>>          else if (inf = IPUV3_COLORSPACE_YUV)
>> -               params = &ic_csc_ycbcr2rgb_bt601;
>> +               params = &ic_csc_ycbcr2rgb;
>
> Steve,
>
> compile issue...
>
> params = params_yuv2rgb;
>
>>          else
>> -               params = &ic_csc_rgb2ycbcr_bt601;
>> +               params = &ic_csc_rgb2ycbcr;
> params = params_rgb2yuv;

Wow, did I not even compile test that? Must be my head cold :-/
Sending v4.

>
> But, I'm still failing when using the mem2mem element (gst-launch-1.0
> v4l2src device=/dev/video4 ! v4l2video8convert
> output-io-mode=dmabuf-import ! fbdevsink) with 'Unsupported YCbCr
> encoding' because of inf=IPU_COLORSPACE_YCBCR outf=IPU_COLORSPACE_RGB
> and a seemingly unset encoding being passed in.
>
> It looks like maybe something in the mem2mem driver isn't defaulting
> encoding. The call path is (v4l2_m2m_streamon -> device_run ->
> ipu_image_convert_queue -> convert_start -> ipu_ic_task_init_rsc ->
> init_csc).

Looking at v7 of the mem2mem driver, it will set ycbcr_enc at the output 
side to V4L2_YCBCR_ENC_DEFAULT if colorspace is default. So colorspace 
will need to be set to something non-default in addition to setting 
ycbcr_enc, at the output side. I don't know whether gstreamer 
v4l2videoNconvertelement will do this, but you could hack the driver for 
now to get around it, and let Philipp know this may need a workaround in 
mem2mem for v8.

Steve
