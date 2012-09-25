From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 25 Sep 2012 07:51:57 +0000
Subject: Re: [PATCH v4] of: Add videomode helper
Message-Id: <20120925075157.GA24753@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
 <50606334.7030902@gmail.com> <20120924141233.GN1322@pengutronix.de>
 <506079CF.40902@gmail.com> <20120924191628.GR1322@pengutronix.de>
In-Reply-To: <20120924191628.GR1322-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

On Mon, Sep 24, 2012 at 09:16:28PM +0200, Sascha Hauer wrote:
> On Mon, Sep 24, 2012 at 10:18:39AM -0500, Rob Herring wrote:
> > On 09/24/2012 09:12 AM, Sascha Hauer wrote:
> > >>
> > >> A major piece missing is the LCD controller to display interface width
> > >> and component ordering.
> > > 
> > > Psst. We silently skipped this for now...
> > > 
> > > I think having such a videomode helper is useful without having the
> > > data order part. We are aware that this should be added later, but
> > > I think currently it makes sense to concentrate on the basics.
> > 
> > Evolving bindings is not a good thing. We know this is needed, so we
> > should address it now. If Linux had a standard way to describe the
> > interface (it didn't a few years ago and I haven't kept up), then I
> > would bet it would already be part of this binding. Defining the
> > bindings in terms of what an OS uses or not is the wrong way around.
> 
> I see your point. I'm just afraid that if we start a discussion about
> this now, it will take a long time we get something merged. In the
> meantime we will get a lot of ad-hoc bindings like this one
> suggested for the exynos:
> 
> > +       lcd_fimd0: lcd_panel0 {
> > +                       lcd-htiming = <4 4 4 480>;
> > +                       lcd-vtiming = <4 4 4 320>;
> > +                       supports-mipi-panel;
> > +       };
> 
> Or this one for the AMBA LCD controller;
> 
> > +       panel.mode.refresh      = get_val(node, "refresh");
> > +       panel.mode.xres         = get_val(node, "xres");
> > +       panel.mode.yres         = get_val(node, "yres");
> > +       panel.mode.pixclock     = get_val(node, "pixclock");
> > +       panel.mode.left_margin  = get_val(node, "left_margin");
> > +       panel.mode.right_margin = get_val(node, "right_margin");
> > +       panel.mode.upper_margin = get_val(node, "upper_margin");
> > +       panel.mode.lower_margin = get_val(node, "lower_margin");
> > +       panel.mode.hsync_len    = get_val(node, "hsync_len");
> > +       panel.mode.vsync_len    = get_val(node, "vsync_len");
> > +       panel.mode.sync         = get_val(node, "sync");
> > +       panel.bpp               = get_val(node, "bpp");
> > +       panel.width             = (signed short) get_val(node, "width");
> > +       panel.height            = (signed short) get_val(node, "height");
> 
> (get_val() is a wrapper around of_property_read_u32)
> 
> BTW the SoC-camera guys will need a wire format description for their
> cameras aswell.
> 
> > > 
> > > We expect the display nodes being subnodes of a driver (which of course
> > > has a compatible), or maybe referred to from a driver using phandles. So
> > > I don't see why the display node itself should have a compatible
> > > property. The display information is only ever useful in the context of
> > > a driver.
> > 
> > A subnode or phandle will describe the h/w connection, but you need a
> > name to describe what is at each end of the connection.
> > 
> > Where would the model number of an lcd panel be captured then? The
> > timing parameters are a property of a specific panel, so both should be
> > described together. You may not have any use for the compatible string
> > now, but more information is better than less and adding it would not
> > hurt anything. For pretty much any other device sitting on a board, we
> > describe the manufacturer and type of device. LCD panels should be no
> > different.
> 
> You convinced me. Lets add a compatible property, it won't hurt.

Okay. That doesn't seem to be a big problem. I can add that.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
