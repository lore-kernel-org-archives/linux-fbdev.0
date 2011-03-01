From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Mar 2011 08:25:44 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <AANLkTikpL3m_8YVMiRRRULmB_Px9asdK-Fto07WeyJgG@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Geert,

On Thu, Feb 24, 2011 at 3:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Feb 24, 2011 at 00:28, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Please ditch the SH_FB_YUV constant all together. No need to build
>> some abstraction on top of a hackish interface. Just check if nonstd
>> is non-zero in the driver and assume that means YUV for now. That's
>> good enough.
>
> For YUV (do you mean YCbCr?), I'm inclined to suggest adding a new FB_VISUAL_*
> type instead, which indicates the fb_var_screeninfo.{red,green,blue} fields are
> YCbCr instead of RGB.
> Depending on the frame buffer organization, you also need new FB_TYPE_*/FB_AUX_*
> types.

I'm all for extending the common code instead of hiding code in
drivers. But I wonder how much overlap there is with V4L2 for
instance. I remember adding support for some NVxx formats for V4L2
some years ago. It's mainly used for Video input on Renesas SoCs
though:

http://kerneltrap.org/mailarchive/git-commits-head/2008/12/31/4560474

So I was hoping that something like the above could be added to fbdev
too, but it looks like more code is needed.

Do you have any idea on how to tie in the valid range of each color
channel? The LCDC hardware block can select between 0->255 range or
16->235/240 for the YUV channels. In V4L2 this is handled by
v4l2_colorspace, the 0->255 maps directly to V4L2_COLORSPACE_JPEG.

And how does all this relate to KMS? I'd prefer to keep this code in
one place if possible.

Thanks,

/ magnus
