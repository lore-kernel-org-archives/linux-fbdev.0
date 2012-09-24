From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 24 Sep 2012 14:12:33 +0000
Subject: Re: [PATCH v4] of: Add videomode helper
Message-Id: <20120924141233.GN1322@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
 <50606334.7030902@gmail.com>
In-Reply-To: <50606334.7030902-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Hi Rob,

On Mon, Sep 24, 2012 at 08:42:12AM -0500, Rob Herring wrote:
> On 09/19/2012 03:20 AM, Steffen Trumtrar wrote:
> > This patch adds a helper function for parsing videomodes from the devicetree.
> > The videomode can be either converted to a struct drm_display_mode or a
> > struct fb_videomode.
> > 
> > +
> > +Required properties:
> > + - hactive, vactive: Display resolution
> > + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing parameters
> > +   in pixels
> > +   vfront-porch, vback-porch, vsync-len: Vertical display timing parameters in
> > +   lines
> > + - clock: displayclock in Hz
> 
> A major piece missing is the LCD controller to display interface width
> and component ordering.

Psst. We silently skipped this for now...

I think having such a videomode helper is useful without having the
data order part. We are aware that this should be added later, but
I think currently it makes sense to concentrate on the basics.

> 
> > +
> > +Optional properties:
> > + - width-mm, height-mm: Display dimensions in mm
> > + - hsync-active-high (bool): Hsync pulse is active high
> > + - vsync-active-high (bool): Vsync pulse is active high
> > + - interlaced (bool): This is an interlaced mode
> > + - doublescan (bool): This is a doublescan mode
> > +
> > +There are different ways of describing a display mode. The devicetree representation
> > +corresponds to the one commonly found in datasheets for displays.
> > +The description of the display and its mode is split in two parts: first the display
> > +properties like size in mm and (optionally) multiple subnodes with the supported modes.
> > +
> > +Example:
> > +
> > +	display@0 {
> 
> It would be useful to have a compatible string here. We may not always
> know the panel type or have a fixed panel though. We could define
> "generic-lcd" or something for cases where the panel type is unknown.

We expect the display nodes being subnodes of a driver (which of course
has a compatible), or maybe referred to from a driver using phandles. So
I don't see why the display node itself should have a compatible
property. The display information is only ever useful in the context of
a driver.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
