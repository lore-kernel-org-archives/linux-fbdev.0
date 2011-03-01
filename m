From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Mar 2011 08:07:39 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <AANLkTi=Un_wG7M1RVFTLE61cDUm2BnsjxGPuM3Lwz9tR@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Tue, Mar 1, 2011 at 04:13, Damian <dhobsong@igel.co.jp> wrote:
> On 2011/02/24 15:05, Geert Uytterhoeven wrote:
>>>> My thinking behind separating this out was that I wanted this
>>>> define to be accessible from user space.  The reason is so that
>>>> an application can test the value of .nonstd against the flag to
>>>> know for sure if it is dealing with a YUV framebuffer or not.
>>>
>>> Hm, but ideally we want something standard. How do you know the nonstd
>>> flag is working as you expect from user space? All of a sudden you
>>> have code that depends on what type of fbdev driver you are using.
>>> This is ugly, but abstracting the nonstd interface does not make it
>>> better IMO.
>>>
>>> The nonstd thing is a hack, but for now it is close enough. V4L2 has
>>> standard NV12/NV16 support already, but I don't think there is any
>>> such thing for fbdev. So i see your patches as a stop-gap, but I
>>> really don't want to make it more complicated than it has to be. So
>>> exporting nonstd values in a header file to user space seems too
>>> complicated IMO.
>>>
>>> Please just live with the fact that nonstd is special for now. We need
>>> to rework the entire LCDC/HDMI/DSI area to support multiple planes and
>>> better PM anyway. Perhaps KMS is the way forward, or perhaps Media
>>> Controller? Maybe both?
>>>
>>>> I was under the impression that only headers under include/linux/ should
>>>> be
>>>> accessed from user space, but to be honest, I'm not sure about that.
>>>> If that is in fact not the case, then I totally agree that it can go
>>>> into include/video/sh_mobile_lcdc.h.
>>>
>>> Please ditch the SH_FB_YUV constant all together. No need to build
>>> some abstraction on top of a hackish interface. Just check if nonstd
>>> is non-zero in the driver and assume that means YUV for now. That's
>>> good enough.
>>
>> For YUV (do you mean YCbCr?), I'm inclined to suggest adding a new
>> FB_VISUAL_*
>> type instead, which indicates the fb_var_screeninfo.{red,green,blue}
>> fields are
>> YCbCr instead of RGB.
>> Depending on the frame buffer organization, you also need new
>> FB_TYPE_*/FB_AUX_*
>> types.
>
> I just wanted to clarify here.  Is your comment about these new flags in
> specific reference to this patch or to Magnus' "going forward" comment?  It

About new flags.

> seems like the beginnings of a method to standardize YCbCr support in fbdev
> across all platforms.
> Also, do I understand correctly that FB_VISUAL_ would specify the colorspace

FB_VISUAL_* specifies how pixel values (which may be tuples) are mapped to
colors on the screen, so to me it looks like the sensible way to set up YCbCr.

> (RGB, YCbCr), FB_TYPE_* would be a format specifier (i.e. planar,
> semiplanar, interleaved, etc)?  I'm not really sure what you are referring
> to with the FB_AUX_* however.

Yep, FB_TYPE_* specifies how pixel values/tuples are laid out in frame buffer
memory.

FB_AUX_* is only used if a specific value of FB_TYPE_* needs an additional
parameter (e.g. the interleave value for interleaved bitplanes).
Another possible use is the offset between the even and odd fields of
the screen,
for hardware that supports interlacing by storing the even and odd
fields separately.
I think I even posted patches for that several years ago... Indeed
http://lkml.indiana.edu/hypermail/linux/kernel/0304.0/0816.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
