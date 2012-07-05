From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 05 Jul 2012 16:50:29 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <20120705165029.GU30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <3714247.L7zNpJpvuy@avalon>
In-Reply-To: <3714247.L7zNpJpvuy@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

On Thu, Jul 05, 2012 at 04:08:07PM +0200, Laurent Pinchart wrote:
> Hi Sascha,
> 
> Thanks for the patch.
> 
> > +++ b/Documentation/devicetree/bindings/video/displaymode
> > @@ -0,0 +1,40 @@
> > +videomode bindings
> > +=========
> > +
> > +Required properties:
> > + - xres, yres: Display resolution
> > + - left-margin, right-margin, hsync-len: Horizontal Display timing
> > parameters +   in pixels
> > +   upper-margin, lower-margin, vsync-len: Vertical display timing
> > parameters in +   lines
> > + - clock: displayclock in Hz
> > +
> > +Optional properties:
> > + - width-mm, height-mm: Display dimensions in mm
> 
> I've always had mixed feelings about the physical display dimension being part 
> of the display mode. Those are properties of the panel/display instead of the 
> mode. Storing them as part of the mode can be convenient, but we then run into 
> consistency issues (developers have to remember in which display mode 
> instances the values are available, and in which instances they're set to 0 
> for instance). If we want to clean this up, this patch would be a good 
> occasion.

This sounds like a display node with one or more node subnodes, like:

display {
	width_mm = <>;
	height_mm = <>;
	mode {
		xres = <>;
		yres = <>;
		...
	};
};

Is that what you mean or are you thinking of something else?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
