From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 06 Dec 2012 10:07:18 +0000
Subject: Re: [PATCHv15 2/7] video: add display_timing and videomode
Message-Id: <20121206100718.C5C263E0EA4@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353920848-1705-1-git-send-email-s.trumtrar@pengutronix.de>
 <1353920848-1705-3-git-send-email-s.trumtrar@pengutronix.de>
 <50B36286.7010704@ti.com> <20121126153958.GA30791@pengutronix.de>
In-Reply-To: <20121126153958.GA30791-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 26 Nov 2012 16:39:58 +0100, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
> On Mon, Nov 26, 2012 at 02:37:26PM +0200, Tomi Valkeinen wrote:
> > On 2012-11-26 11:07, Steffen Trumtrar wrote:
> > 
> > > +/*
> > > + * Subsystem independent description of a videomode.
> > > + * Can be generated from struct display_timing.
> > > + */
> > > +struct videomode {
> > > +	u32 pixelclock;		/* pixelclock in Hz */
> > 
> > I don't know if this is of any importance, but the linux clock framework
> > manages clock rates with unsigned long. Would it be better to use the
> > same type here?
> > 
> 
> Hm, I don't know. Anyone? u32 should be large enough for a pixelclock.

4GHz is a pretty large pixel clock. I have no idea how conceivable it is
that hardware will get to that speed. However, if it will ever be
larger, then you'll need to account for that in the DT binding so that
the pixel clock can be specified using 2 cells.

g.
