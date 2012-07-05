From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 05 Jul 2012 18:39:45 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <20120705183945.GV30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <4FF5A9FB.7010004@gmail.com>
In-Reply-To: <4FF5A9FB.7010004-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

On Thu, Jul 05, 2012 at 09:51:39AM -0500, Rob Herring wrote:
> On 07/04/2012 02:56 AM, Sascha Hauer wrote:
> > +
> > +There are different ways of describing a display mode. The devicetree representation
> > +corresponds to the one used by the Linux Framebuffer framework described here in
> > +Documentation/fb/framebuffer.txt. This representation has been chosen because it's
> > +the only format which does not allow for inconsistent parameters.Unlike the Framebuffer
> > +framework the devicetree has the clock in Hz instead of ps.
> 
> This implies you are putting linux settings into DT rather than
> describing the h/w. I'm not saying the binding is wrong, but documenting
> it this way makes it seem so.

The major reason to use these values was that they do not allow for
inconsistent values (as opposed to for example with hsync_start which you
would have to check for hsync_start >= xres).
I could rephrase this if it looks too much like modelled-after-Linux
instead of modelled-after-hardware.

> 
> One important piece missing (and IIRC linux doesn't really support) is
> defining the pixel format of the interface.

I could use this aswell. I think this can be specified as additional
properties later, right? I'm afraid this needs a lot of discussion so
we should delay this to the next round.

> 
> > +Example:
> > +
> > +	display@0 {
> > +		/* 1920x1080p24 */
> > +		clock = <52000000>;
> 
> Should this use the clock binding? You probably need both constraints
> and clock binding though.

Is the clock binding suitable for this? Here we are not interested where
the clock comes from, but instead which range is allowed.

> 
> Often you don't know the frequency up front and/or have limited control
> of the frequency (i.e. integer dividers). Then you have to adjust the
> margins to get the desired refresh rate. To do that, you need to know
> the ranges of values a panel can support. Perhaps you just assume you
> can increase the right-margin and lower-margins as I think you will hit
> pixel clock frequency max before any limit on margins.

Most datasheets specify min,typ,max triplets. We could do this instead
of using single fixed values for the margins:

	left_margin = <0 10 40>;

Right now we have nothing in the kernel that could handle this, but
getting the interface to the devicetree right seems indeed important.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
