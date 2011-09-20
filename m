From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 20 Sep 2011 15:39:53 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning
Message-Id: <1316533193.18781.12.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<1316517021.1949.13.camel@deskari>
	<CAEC9eQOTNaMcUWeSFN-DCTYrCJsVaDAO7uOZNQM=efjVdqtU2g@mail.gmail.com>
In-Reply-To: <CAEC9eQOTNaMcUWeSFN-DCTYrCJsVaDAO7uOZNQM=efjVdqtU2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2011-09-20 at 20:16 +0530, Ajay kumar wrote:
> Hi Tomi,
> 
> On Tue, Sep 20, 2011 at 4:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Tue, 2011-09-20 at 11:30 -0400, Ajay Kumar wrote:
> >> This patch adds a data structure definiton to hold framebuffer windows/planes.
> >> An ioctl number is also added to provide user access
> >> to change window position dynamically.
> >>
> >> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> >> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> >> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>  include/linux/fb.h |    7 +++++++
> >>  1 files changed, 7 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/linux/fb.h b/include/linux/fb.h
> >> index 1d6836c..2141941 100644
> >> --- a/include/linux/fb.h
> >> +++ b/include/linux/fb.h
> >> @@ -39,6 +39,7 @@
> >>  #define FBIOPUT_MODEINFO        0x4617
> >>  #define FBIOGET_DISPINFO        0x4618
> >>  #define FBIO_WAITFORVSYNC    _IOW('F', 0x20, __u32)
> >> +#define FBIOPOS_OVERLAY_WIN  _IOW('F', 0x21, struct fb_overlay_win_pos)
> >>
> >>  #define FB_TYPE_PACKED_PIXELS                0       /* Packed Pixels        */
> >>  #define FB_TYPE_PLANES                       1       /* Non interleaved planes */
> >> @@ -366,6 +367,12 @@ struct fb_image {
> >>       struct fb_cmap cmap;    /* color map info */
> >>  };
> >>
> >> +/* Window overlaying */
> >> +struct fb_overlay_win_pos {
> >> +     __u32 win_pos_x;        /* x-offset from LCD(0,0) where window starts */
> >> +     __u32 win_pos_y;        /* y-offset from LCD(0,0) where window starts */
> >> +};
> >
> > Shouldn't this also include the window size (in case scaling is
> > supported)?
> 
> The "xres" and "yres" fields in fb_var_screeninfo are being used to
> represent the size of the window (visible resolution). So we have,
> 
> win_pos_x: x-offset from LCD(0,0) where window starts.
> win_pos_y: y-offset from LCD(0,0) where window starts.
> (win_pos_x + xres) : x-offset from LCD(0,0) where window ends.
> (win_pos_y + yres) : y-offset from LCD(0,0) where window ends.

Sure, but the xres and yres tell the _input_ resolution, i.e. how many
pixels are read from the memory. What is missing is the _output_
resolution, which is the size of the window. These are not necessarily
the same, if the system supports scaling.

> > This also won't work for setups where the same framebuffer is used by
> > multiple overlays. For example, this is the case on OMAP when the same
> > content is cloned to, say, LCD and TV, each of which is showing an
> > overlay.
> 
> These x and y position are used to configure the display controller
> (for LCD only) and not to alter the data in physical buffer
> (framebuffer). Could you elaborate the above use case you have
> mentioned and how adding the x and y offsets would not meet that
> requirement.

Nothing wrong with adding x/y offsets, but the problem is in configuring
the two overlays. If the framebuffer data is used by two overlays, each
overlay should be configured separately. And your ioctl does not have
any way to define which overlay is being affected.

Of course, if we specify that a single framebuffer will ever go only to
one output, the problem disappears.

However, even if we specify so, this will make the fbdev a bit weird:
what is x/yres after this patch? In the current fbdev x/yres is the size
of the output, and x/yres are part of video timings. After this patch
this is no longer the case: x/yres will be the size of the overlay. But
the old code will still use x/yres as part of video timings, making
things confusing.

And generally I can't really make my mind about adding these more
complex features. On one hand it would be very nice to have fbdev
supporting overlays and whatnot, but on the other hand, I can't figure
out how to add them properly.

 Tomi


