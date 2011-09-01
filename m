From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 01 Sep 2011 16:45:18 +0000
Subject: Re: [PATCH 0/2] video: s3c-fb: Add window positioning support
Message-Id: <4E5FB69E.2060907@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
In-Reply-To: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all,

On 08/25/2011 07:51 PM, Ajay Kumar wrote:
> Just as a note, there are many drivers like mx3fb.c, au1200fb.c and OMAP
> seem to be doing window/plane positioning in their driver code.
> Is it possible to have this window positioning support at a common place?

Good point. Congratulations for figuring out that I like to standardize things.
But I think your suggestion is far from being enough to be useful for userspace
(which is our goal so that applications can be reused along drivers and don't
need to know about individual drivers).

So let me at first summarize how I understand you implemented those things after
having a brief look at some of the drivers:
Windows are rectangular screen areas whose pixel data come from other locations.
The other locations are accessible via other framebuffer devices (e.g. fb1). So
in this area the data of fb1 is shown and not the data of fb0 that would be
normally shown.

So in addition to your proposed positioning I think we should also have the
following to give userspace a useful set of functionality:

- a way to discover how the screen is composited (how many windows are there,
how they are stacked and how to access those)

- a way to enable/disable windows (make them (in)visible)

- reporting and selecting how the window content can be mixed with the root
screen (overwrite, source or destination color keying)

- things like window size and color format could be handled by the usual fb API
used on the window. However there might be restrictions which cause them to be
not 100% API compatible (for example when changing the color format if the
windows are required to have the same format as the root screen)

- do we need to worry about hardware (up/down) scaling of the window content?


So is that what you need for a standardized window implementation?
Any additional things that were useful/needed in this context?
Would you consider adding support for this API in your drivers? (as
standardizing wouldn't be useful if nobody would implement it)


Best regards,

Florian Tobias Schandinat


> 
> For instance, we can have a common struture and ioctl number in 
> include/linux/fb.h as below:
> 
> 	#define FBIOPOS_OVERLAY_WIN    _IOW('F', 0x21, struct fb_overlay_win_pos)
> 
> 	struct fb_overlay_win_pos {
> 		__u32 win_pos_x;  /* x-offset of window from LCD(0,0) */
> 		__u32 win_pos_y;  /* y-offset of window from LCD(0,0) */
> 	};
> 
> where LCD(0,0) means the first pixel of the LCD screen.
> Individual drivers can have implementation for this ioctl.
> 
> To Kukjin Kim,
>   [PATCH 1/2] ARM: SAMSUNG: Add Window Positioning Support for s3c-fb driver
> 
> To Paul Mundt, Florian Tobias Schandinat
>   [PATCH 2/2] video: s3c-fb: Modify s3c-fb driver to support window positioning
> 
>  arch/arm/plat-samsung/include/plat/fb.h |   14 +++++++++++
>  drivers/video/s3c-fb.c                  |   37 ++++++++++++++++++++++++++----
>  2 files changed, 46 insertions(+), 5 deletions(-)
> 
> 

