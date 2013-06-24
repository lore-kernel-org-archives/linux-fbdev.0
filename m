From: Zhou Zhu <zzhu3@marvell.com>
Date: Mon, 24 Jun 2013 07:27:01 +0000
Subject: Re: MMP display subsystem questions
Message-Id: <51C7F4C5.9040903@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHTmSzzcL-aqk6rMjuD8Ct2zno--p7tUGfVVsocWiyhf8A@mail.gmail.com>
 <51C3BD65.8070206@marvell.com>
 <CAMLZHHQFtXWx0weG3uh14Nm3euqbSqyztBEQHEQFBzjFxWGTZA@mail.gmail.com>
In-Reply-To: <CAMLZHHQFtXWx0weG3uh14Nm3euqbSqyztBEQHEQFBzjFxWGTZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Daniel,

Thank you for reviewing our patches.
Please see my comments.

On 06/22/2013 12:14 AM, Daniel Drake wrote:
>>> 4. Which overlay to use - according to my investigation above, this
>>> doesn't actually have any meaningful effect on the driver.
>>
>> As overlay enabled in patch above now, this config is required to make fb
>> show on some overlay and other interface(v4l2, private interface) to use
>> others.
>
> I don't understand this, but it might be easier to understand once you
> have documented what an overlay is and how it relates to a path. How
> is v4l2 going to interact with this driver? What private interfaces
> are you referring to?
>
> Or can we just auto-instantiate one framebuffer per path with good defaults?
Actually besides fb, v4l2 and an IOCTL based interface to support what 
fb/v4l2 not provided are also added. The v4l2 or private interface could 
also directly use same interface defined in include/video/mmp_disp.h to 
get path/overlay and manipulate the hardware.
Patches for these interfaces would be submitted later and documentation 
would also be added.
>
>> Also there still might be some settings in fb for some further settings like
>> vsync usage or yres_virtual size in coming patches.
>
> Wouldn't such information be represented in the modes supported by the panel?
These settings are software related rather than what hw supports.
Vsync settings include whether fb wait vsync interrupt to sync buffers 
when pan display or whether send uevent in vsync (which is a mechanism 
for Android).
For yres_virtual size which is related with pre-reserved fb buffer size 
and some buffer sync mechanism.
As these settings are pure fb related so we just not place it in panel.
>
> A couple more questions:
>
> 1. What is the invert_pixclock setting in the mmp_mode structure? This
> causes a currently unused bit to be set in fb_videomode->vmode to be
> set (seems dangerous). And then nothing acts upon this bit, as far as
> I can see.
This bit is a legacy settings that for some panels that require inverted 
pixel clock. However, as panels we are using now don't require such 
feature and even we forget it by mistake, we could make a patch to 
remove it and related code soon later.
Thank you for pointing out this:)
>
> 2. What about pix_fmt_out? Why is pixel format dumped into the mode
> specifier? If there is a supported panel that really can support
> different pixel formats, I would expect it to support all the pixel
> formats for all the resolution. This also seems unused within the
> driver.
We added it due to 2 reasons:
1. It impacts output timing settings inside controller for dsi case (we 
have already in-home patches and would be submitted later). So it's 
required to indicate that timing need to be changed.
2. It's still possible that for some panel that could support different 
resolution and pixel formats, but it might not support all pixel formats 
for all resolutions.

Also this variable is not used for dumb panel as it's already covered in 
dumb mode in link config - dumb mode includes not only 16bpp or 24bpp 
but also whether low 16 bits or high 16 bits used in 24 bits' lines. For 
coming DSI panel, it's required and would be used.
>
> Thanks
> Daniel
>


-- 
Thanks, -Zhou
