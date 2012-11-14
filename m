From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 14 Nov 2012 10:59:25 +0000
Subject: Re: [PATCH v8 1/6] video: add display_timing and videomode
Message-Id: <20121114105925.GA18579@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352734626-27412-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352734626-27412-2-git-send-email-s.trumtrar@pengutronix.de>
 <20121114105634.GA31801@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121114105634.GA31801-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Nov 14, 2012 at 11:56:34AM +0100, Thierry Reding wrote:
> On Mon, Nov 12, 2012 at 04:37:01PM +0100, Steffen Trumtrar wrote:
> [...]
> > diff --git a/drivers/video/display_timing.c b/drivers/video/display_timing.c
> [...]
> > +void display_timings_release(struct display_timings *disp)
> > +{
> > +	if (disp->timings) {
> > +		unsigned int i;
> > +
> > +		for (i = 0; i < disp->num_timings; i++)
> > +			kfree(disp->timings[i]);
> > +		kfree(disp->timings);
> > +	}
> > +	kfree(disp);
> > +}
> 
> I think this is still missing an EXPORT_SYMBOL_GPL. Otherwise it can't
> be used from modules.
> 
> Thierry

Yes. Just in time. I was just starting to type the send-email command ;-)

Regards,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
