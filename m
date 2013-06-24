From: Daniel Drake <dsd@laptop.org>
Date: Mon, 24 Jun 2013 14:48:14 +0000
Subject: Re: MMP display subsystem questions
Message-Id: <CAMLZHHTERYrkeb-m7Q7UDNF2kd-MoQ+2T3K1XyukjzG7RjKPxg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMLZHHTmSzzcL-aqk6rMjuD8Ct2zno--p7tUGfVVsocWiyhf8A@mail.gmail.com>
 <51C3BD65.8070206@marvell.com>
 <CAMLZHHQFtXWx0weG3uh14Nm3euqbSqyztBEQHEQFBzjFxWGTZA@mail.gmail.com>
 <51C7F4C5.9040903@marvell.com>
In-Reply-To: <51C7F4C5.9040903@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 24, 2013 at 1:27 AM, Zhou Zhu <zzhu3@marvell.com> wrote:
> Actually besides fb, v4l2 and an IOCTL based interface to support what
> fb/v4l2 not provided are also added. The v4l2 or private interface could
> also directly use same interface defined in include/video/mmp_disp.h to get
> path/overlay and manipulate the hardware.
> Patches for these interfaces would be submitted later and documentation
> would also be added.

This kind of reasoning normally does not act as justification for
adding private interfaces to the kernel. I doubt such patches would be
accepted. Instead, you would be encouraged to help improve the
standard interfaces that are missing the functionality you require.

> These settings are software related rather than what hw supports.
> Vsync settings include whether fb wait vsync interrupt to sync buffers when
> pan display or whether send uevent in vsync (which is a mechanism for
> Android).
> For yres_virtual size which is related with pre-reserved fb buffer size and
> some buffer sync mechanism.
> As these settings are pure fb related so we just not place it in panel.

Thanks, that is clear now.

>> 2. What about pix_fmt_out? Why is pixel format dumped into the mode
>> specifier? If there is a supported panel that really can support
>> different pixel formats, I would expect it to support all the pixel
>> formats for all the resolution. This also seems unused within the
>> driver.
>
> We added it due to 2 reasons:
> 1. It impacts output timing settings inside controller for dsi case (we have
> already in-home patches and would be submitted later). So it's required to
> indicate that timing need to be changed.
> 2. It's still possible that for some panel that could support different
> resolution and pixel formats, but it might not support all pixel formats for
> all resolutions.
>
> Also this variable is not used for dumb panel as it's already covered in
> dumb mode in link config - dumb mode includes not only 16bpp or 24bpp but
> also whether low 16 bits or high 16 bits used in 24 bits' lines. For coming
> DSI panel, it's required and would be used.

It is a little irritating trying to work with this driver when a
number of undocumented strange details are dependent on unsubmitted
work.

I would suggest keeping this simple and making the pixel format
specific to the panel, not specific to the resolution. While maybe it
is possible we will see a panel that supports certain pixel formats at
only certain resolutions, that seems unlikely, and doesn't seem to be
anything we are working with at the moment?
Moving pixel format out of the mode definition will help with
compatibility with standard devicetree display-timings bindings, which
is the reason that I asked this question.

Daniel
