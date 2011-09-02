From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 02 Sep 2011 09:58:52 +0000
Subject: Re: [PATCH 0/2] video: s3c-fb: Add window positioning support
Message-Id: <1314957532.3374.51.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314301917-9938-1-git-send-email-ajaykumar.rs@samsung.com>
	<4E5FB69E.2060907@gmx.de>
In-Reply-To: <4E5FB69E.2060907@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Thu, 2011-09-01 at 16:45 +0000, Florian Tobias Schandinat wrote:
> Hi all,
> 
> On 08/25/2011 07:51 PM, Ajay Kumar wrote:
> > Just as a note, there are many drivers like mx3fb.c, au1200fb.c and OMAP
> > seem to be doing window/plane positioning in their driver code.
> > Is it possible to have this window positioning support at a common place?
> 
> Good point. Congratulations for figuring out that I like to standardize things.
> But I think your suggestion is far from being enough to be useful for userspace
> (which is our goal so that applications can be reused along drivers and don't
> need to know about individual drivers).
> 
> So let me at first summarize how I understand you implemented those things after
> having a brief look at some of the drivers:
> Windows are rectangular screen areas whose pixel data come from other locations.
> The other locations are accessible via other framebuffer devices (e.g. fb1). So
> in this area the data of fb1 is shown and not the data of fb0 that would be
> normally shown.

Here's what we have on OMAP:

We have a bunch of hardware overlays, each of which can go to one
output. When using fbdev, the pixel data for overlays comes from the
framebuffers. One fb can be used as a  pixel source for multiple
overlays.

So, for example, the "connections" can be like these:

           Initial configuration

 .-----.         .------.           .------.
 | fb0 |-------->| ovl0 |-----.---->| LCD  |
 '-----'         '------'     |     '------'
 .-----.         .------.     |
 | fb1 |-------->| ovl1 |-----|
 '-----'         '------'     |
 .-----.         .------.     |     .------.
 | fb2 |-------->| ovl2 |-----'     |  TV  |
 '-----'         '------'           '------'


      Video on fb1, shown on LCD and TV

 .-----.         .------.           .------.
 | fb0 |-------->| ovl0 |-----.---->| LCD  |
 '-----'         '------'     |     '------'
 .-----.         .------.     |
 | fb1 |----.--->| ovl1 |-----'
 '-----'    |    '------'
 .-----.    |    .------.           .------.
 | fb2 |    '--->| ovl2 |---------->|  TV  |
 '-----'         '------'           '------'


And how the actual image is composited on the display, we have first the
fb side (no news there):

 .---------------------fb-vxres---------------------.
 |                                                  |
 |                                                  |
 |   (xoffset,yoffset)                              |
 |           .-------fb-xres------------.           |
 f           |                          |           |
 b           f                          |           |
 |           b                          |           |
 v           |                          |           |
 y           y                          |           |
 r           r                          |           |
 e           e                          |           |
 s           s                          |           |
 |           |                          |           |
 |           '--------------------------'           |
 |                                                  |
 |                                                  |
 '--------------------------------------------------'

The area marked by x/yoffset and x/yres is used as the pixel source for
the overlay.

On the display we have something like this:

 .----------------disp-xres----------------.
 |                                         |
 | (xpos,ypos)                             |
 |      .-----ovl-xres-----.               |
 d      |                  |               |
 i      o                  |               |
 s      v                  |               |
 p      l                  |               |
 |      |                  |               |
 y      y                  |               |
 r      r                  |               |
 e      e                  |               |
 s      s                  |               |
 |      |                  |               |
 |      '------------------'               |
 |                                         |
 '-----------------------------------------'

The x/ypos of the overlay does not have any relation to the x/yoffset of
the framebuffer. The overlay's x/yres is the same as the fb's x/yres in
case the overlay doesn't support scaling (OMAP's case this is true for
overlay0). Otherwise the overlay's x/yres is only limited by the HW's
scaling capabilities.

The overlays have a priority order, and where there's no overlay, a
background color is used. So like this:

 .-----------------------------------------.
 |            background color             |
 | .-----------------------.               |
 | |         ovl0          |               |
 | |                       |               |
 | | .--------------.      |               |
 | | |     ovl1     |      |               |
 | | |              |      |               |
 | | |        .-------------------.        |
 | | |        |       ovl2        |        |
 | | '--------|                   |        |
 | '----------|                   |        |
 |            |                   |        |
 |            |                   |        |
 |            |                   |        |
 |            '-------------------'        |
 '-----------------------------------------'

As you may have noticed, this raises in annoying problem: the
framebuffer does not represent the display, and thus the display related
information in the fb, like video timings, are difficult or impossible
to use. I haven't found any solution to this.

> So in addition to your proposed positioning I think we should also have the
> following to give userspace a useful set of functionality:
> 
> - a way to discover how the screen is composited (how many windows are there,
> how they are stacked and how to access those)
> 
> - a way to enable/disable windows (make them (in)visible)
> 
> - reporting and selecting how the window content can be mixed with the root
> screen (overwrite, source or destination color keying)

Right, and there may not be a root screen at all, like on OMAP. (if the
background color doesn't count as a root screen).

> - things like window size and color format could be handled by the usual fb API
> used on the window. However there might be restrictions which cause them to be
> not 100% API compatible (for example when changing the color format if the
> windows are required to have the same format as the root screen)
> 
> - do we need to worry about hardware (up/down) scaling of the window content?
> 
> 
> So is that what you need for a standardized window implementation?
> Any additional things that were useful/needed in this context?
> Would you consider adding support for this API in your drivers? (as
> standardizing wouldn't be useful if nobody would implement it)

We already have the current implementation in omapfb, so while a
standard API would be nice, we still need to keep the old custom API for
compatibility.

Another thing is that I'm not sure how much features we should try to
add to fbdev. The fbdev model is a bit limited (for example, the timings
problem above, or double/triple buffering), and at least we are
currently looking at using DRM. There will still be a framebuffer, but
that's mostly for fbconsole and such, and doesn't need to support
overlays, scaling, and other more complex features.

 Tomi


