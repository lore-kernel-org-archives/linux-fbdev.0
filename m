From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 20 Sep 2011 18:57:17 +0000
Subject: Re: [PATCH 1/3] include: fb: Add definiton for window positioning
Message-Id: <1316545037.18781.34.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
	<1316532641-2657-2-git-send-email-ajaykumar.rs@samsung.com>
	<1316517021.1949.13.camel@deskari>
	<CAEC9eQOTNaMcUWeSFN-DCTYrCJsVaDAO7uOZNQM=efjVdqtU2g@mail.gmail.com>
	<1316533193.18781.12.camel@deskari>  <4E78C579.9060305@gmx.de>
In-Reply-To: <4E78C579.9060305@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2011-09-20 at 16:55 +0000, Florian Tobias Schandinat wrote:

> Did you have a look at the (existing) API [1] Laurent proposed for discovering
> the internal connections between the framebuffers (or with any other devices)?

I know the basics of media controller, but I haven't really looked at
the code.

> If you agree that it'd be a good idea to use it I feel that we should make the
> windowing API more compatible with it. So basically what we want to have as a

I can't say if MC should be used for fb or not, but I think something
similar should be used if we want to get overlays etc. supported. But
even with MC (or something else) there, I'm not quite sure how they fit
into the fb model.

I think the core problem here is that in a more complex setup (at least
as I see it for OMAP) the fb should be just a framebuffer in memory,
without any direct relation to hardware. The hardware part (an overlay,
or whichever is the corresponding element) will then use the framebuffer
as the pixel source.

However, the current fb model combines those two things into one. If we
manage to separate them, and add MC or similar, I think it'll work.

> window is one or more sunk pads so the pad-index should be also part of the
> interface. I'm still confused with how OMAP works when it does not have a "root"

Do you mean how the hardware works, or how I've designed omapfb driver?

> window/framebuffer. Normally I feel that the window position should be a
> property of the parent window as this is what the position is relative too. But
> if the parent is no framebuffer, should we also include the entity into the
> interface to allow configuring things that are nor even framebuffers?

Right, I think you're pondering the core problem here =).

On OMAP we have the display (the whole area shown on the panel/tv),
which has video timings and things like that. But no pixel data as such
(a configurable background color is there, though).

And then we have the overlays, which are somewhere on the display, and
the overlays get pixel data from memory (framebuffers).

So in a way we have a contentless root window, but presenting that with
an fb device doesn't feel right. And the fb device would logically be
fb0, and if it couldn't show any content it couldn't be used as default
framebuffer.

> Also I think we need a z-index in case overlays overlap (might happen or?) and
> enforcing that all z-indexes are different for the same entity.

Yes, free z-order is supported in OMAP4. Previous OMAPs had fixed
z-order, although in certain configuration (enable/disable alpha
blending) the fixed z-order does change...

> As I see it xres/yres (together with xoffset/yoffset) is always the visible part
> of the framebuffer. Typically that's also part of the timings as they define
> what is visible. With the introduction of overlays (and maybe even for some
> hardware anyway) it is no longer always true to have any timings at all. So on
> all framebuffer that do not have physical timings the timing interpretation is
> useless anyway (I'm thinking about adding a FB_CAP_NOTIMING) and what remains is
> the interpretation of xres/yres as visible screen region.

For a system where there's always a root window for every output, plus
variable size overlays, FB_CAP_NOTIMING makes sense. But it would still
leave the problem if there's no root window. How to change timings on a
system like OMAP?

 Tomi


