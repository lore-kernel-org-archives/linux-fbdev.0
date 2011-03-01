From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Mar 2011 20:22:28 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <AANLkTi=Kc6wueQPJrw1ZtAe4qkOrmn1O7eXgF5oze-FP@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-1-git-send-email-dhobsong@igel.co.jp>
	<1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
	<Pine.LNX.4.64.1102231132030.10099@axis700.grange>
	<4D64EDFC.6070203@igel.co.jp>
	<AANLkTi=rKDRbQYzPLHmRj+fEvAgpHzG2HXBwaBZi0vn_@mail.gmail.com>
	<AANLkTikCo9CruLWE5=XjaspnM6CdKhbyPs3rajPLMV0G@mail.gmail.com>
	<AANLkTikpL3m_8YVMiRRRULmB_Px9asdK-Fto07WeyJgG@mail.gmail.com>
In-Reply-To: <AANLkTikpL3m_8YVMiRRRULmB_Px9asdK-Fto07WeyJgG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Damian <dhobsong@igel.co.jp>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-fbdev@vger.kernel.org, taki@igel.co.jp, matsu@igel.co.jp, dri-devel@lists.freedesktop.org

On Tue, Mar 1, 2011 at 09:25, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Feb 24, 2011 at 3:05 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Feb 24, 2011 at 00:28, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> Please ditch the SH_FB_YUV constant all together. No need to build
>>> some abstraction on top of a hackish interface. Just check if nonstd
>>> is non-zero in the driver and assume that means YUV for now. That's
>>> good enough.
>>
>> For YUV (do you mean YCbCr?), I'm inclined to suggest adding a new FB_VISUAL_*
>> type instead, which indicates the fb_var_screeninfo.{red,green,blue} fields are
>> YCbCr instead of RGB.
>> Depending on the frame buffer organization, you also need new FB_TYPE_*/FB_AUX_*
>> types.
>
> I'm all for extending the common code instead of hiding code in
> drivers. But I wonder how much overlap there is with V4L2 for
> instance. I remember adding support for some NVxx formats for V4L2
> some years ago. It's mainly used for Video input on Renesas SoCs
> though:
>
> http://kerneltrap.org/mailarchive/git-commits-head/2008/12/31/4560474
>
> So I was hoping that something like the above could be added to fbdev
> too, but it looks like more code is needed.
>
> Do you have any idea on how to tie in the valid range of each color
> channel? The LCDC hardware block can select between 0->255 range or
> 16->235/240 for the YUV channels. In V4L2 this is handled by
> v4l2_colorspace, the 0->255 maps directly to V4L2_COLORSPACE_JPEG.

Unfortunately not. Unlike for the YCbCr visual, I don't see a field we
can easily
(ab)use for that. Except if it's limited to standard 16-235/240 Y vs.
full 0-255 Y,
for which we could just have 2 different visual types.

> And how does all this relate to KMS? I'd prefer to keep this code in
> one place if possible.

Good question!

I'm still puzzled about this KMS thing. If the name "Kernel Mode Setting"
covers it, then how does it compare to plain fbdev? Just additional frame buffer
memory management?

Furthermore, everybody states that "future X/desktop" will require KMS drivers.
How do/will we handle this on dumb frame buffers? It's not like we can't do
"advanced" things like compositing using the CPU. Transparency may stretch
it a bit on lower end CPUs, but you don't always need that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
