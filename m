From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Sun, 04 Nov 2012 17:10:20 +0000
Subject: Re: [PATCH v7 2/8] of: add helper to parse display timings
Message-Id: <20121104171020.GB5894@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351675689-26814-1-git-send-email-s.trumtrar@pengutronix.de>
 <1351675689-26814-3-git-send-email-s.trumtrar@pengutronix.de>
 <20121101201510.GB13137@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121101201510.GB13137-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Nov 01, 2012 at 09:15:10PM +0100, Thierry Reding wrote:
> On Wed, Oct 31, 2012 at 10:28:02AM +0100, Steffen Trumtrar wrote:
> [...]
> > diff --git a/Documentation/devicetree/bindings/video/display-timings.txt b/Documentation/devicetree/bindings/video/display-timings.txt
> [...]
> > @@ -0,0 +1,139 @@
> > +display-timings bindings
> > +=========
> > +
> > +display-timings-node
> > +------------
> 
> Maybe extend the underline to the length of the section and subsection
> titles respectively?
> 
> > +struct display_timing
> > +=========> 
> Same here.
> 
> > +config OF_DISPLAY_TIMINGS
> > +	def_bool y
> > +	depends on DISPLAY_TIMING
> 
> Maybe this should be called OF_DISPLAY_TIMING to match DISPLAY_TIMING,
> or rename DISPLAY_TIMING to DISPLAY_TIMINGS for the sake of consistency?
> 

Yes, to all three above.

> > +/**
> > + * of_get_display_timing_list - parse all display_timing entries from a device_node
> > + * @np: device_node with the subnodes
> > + **/
> > +struct display_timings *of_get_display_timing_list(struct device_node *np)
> 
> Perhaps this would better be named of_get_display_timings() to match the
> return type?
> 

Hm, I'm not really sure about that. I found it to error prone, to have a function
of_get_display_timing and of_get_display_timings. That's why I chose
of_get_display_timing_list. But you are correct, that it doesn't match the return
value. Maybe I should just make the first function static and change the name as you
suggested.

> > +	disp = kzalloc(sizeof(*disp), GFP_KERNEL);
> 
> Shouldn't you be checking this for allocation failures?
> 
> > +	disp->timings = kzalloc(sizeof(struct display_timing *)*disp->num_timings,
> > +				GFP_KERNEL);
> 
> Same here.
> 

Yes, to both.

Regards,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
