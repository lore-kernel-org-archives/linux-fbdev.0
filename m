From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 05 Oct 2012 16:28:24 +0000
Subject: Re: [PATCH 1/2 v6] of: add helper to parse display timings
Message-Id: <20121005162824.GC2053@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
 <1349373560-11128-2-git-send-email-s.trumtrar@pengutronix.de>
 <Pine.LNX.4.64.1210042307300.3744@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1210042307300.3744-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Oct 04, 2012 at 11:35:35PM +0200, Guennadi Liakhovetski wrote:
> Hi Steffen
> 
> Sorry for chiming in so late in the game, but I've long been wanting to 
> have a look at this and compare with what we do for V4L2, so, this seems a 
> great opportunity to me:-)
> 
> On Thu, 4 Oct 2012, Steffen Trumtrar wrote:
> 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  .../devicetree/bindings/video/display-timings.txt  |  222 ++++++++++++++++++++
> >  drivers/of/Kconfig                                 |    5 +
> >  drivers/of/Makefile                                |    1 +
> >  drivers/of/of_display_timings.c                    |  183 ++++++++++++++++
> >  include/linux/of_display_timings.h                 |   85 ++++++++
> >  5 files changed, 496 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/video/display-timings.txt
> >  create mode 100644 drivers/of/of_display_timings.c
> >  create mode 100644 include/linux/of_display_timings.h
> > 
> > diff --git a/Documentation/devicetree/bindings/video/display-timings.txt b/Documentation/devicetree/bindings/video/display-timings.txt
> > new file mode 100644
> > index 0000000..45e39bd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/video/display-timings.txt
> > @@ -0,0 +1,222 @@
> > +display-timings bindings
> > +=========
> > +
> > +display-timings-node
> > +------------
> > +
> > +required properties:
> > + - none
> > +
> > +optional properties:
> > + - default-timing: the default timing value
> > +
> > +timings-subnode
> > +---------------
> > +
> > +required properties:
> > + - hactive, vactive: Display resolution
> > + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing parameters
> > +   in pixels
> > +   vfront-porch, vback-porch, vsync-len: Vertical display timing parameters in
> > +   lines
> > + - clock: displayclock in Hz
> 
> You're going to hate me for this, but eventually we want to actually 
> reference clock objects in our DT bindings. For now, even if you don't 
> want to actually add clock phandles and stuff here, I think, using the 
> standard "clock-frequency" property would be much better!
> 

Well, that shouldn't be a big deal, the "clock-frequency" property I mean :-)

> > +
> > +optional properties:
> > + - hsync-active-high (bool): Hsync pulse is active high
> > + - vsync-active-high (bool): Vsync pulse is active high
> 
> For the above two we also considered using bool properties but eventually 
> settled down with integer ones:
> 
> - hsync-active = <1>
> 
> for active-high and 0 for active low. This has the added advantage of 
> being able to omit this property in the .dts, which then doesn't mean, 
> that the polarity is active low, but rather, that the hsync line is not 
> used on this hardware. So, maybe it would be good to use the same binding 
> here too?
> 

Never really thought about it that way. But the argument sounds convincing.

> > + - de-active-high (bool): Data-Enable pulse is active high
> > + - pixelclk-inverted (bool): pixelclock is inverted
> 
> We don't (yet) have a de-active property in V4L, don't know whether we'll 
> ever have to distingsuish between what some datasheets call "HREF" and 
> HSYNC in DT, but maybe similarly to the above an integer would be 
> preferred. As for pixclk, we call the property "pclk-sample" and it's also 
> an integer.
> 
> > + - interlaced (bool)
> 
> Is "interlaced" a property of the hardware, i.e. of the board? Can the 
> same display controller on one board require interlaced data and on 
> another board - progressive? BTW, I'm not very familiar with display 
> interfaces, but for interlaced you probably sometimes use a field signal, 
> whose polarity you also want to specify here? We use a "field-even-active" 
> integer property for it.
> 

I don't really know about that; have to collect some info first.

> Thanks
> Guennadi

Thank you.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
