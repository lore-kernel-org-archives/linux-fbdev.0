From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 22 Nov 2012 08:53:42 +0000
Subject: Re: [PATCH v12 3/6] fbmon: add videomode helpers
Message-Id: <20121122085342.GB10369@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353426896-6045-1-git-send-email-s.trumtrar@pengutronix.de>
 <96696218.4l3uYOulV3@avalon>
 <20121122062000.GW10369@pengutronix.de> <1554720.pFHYnMF1G4@avalon>
In-Reply-To: <1554720.pFHYnMF1G4@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Nov 22, 2012 at 09:50:10AM +0100, Laurent Pinchart wrote:
> Hi Sascha,
> 
> On Thursday 22 November 2012 07:20:00 Sascha Hauer wrote:
> > On Wed, Nov 21, 2012 at 11:02:44PM +0100, Laurent Pinchart wrote:
> > > Hi Steffen,
> > > 
> > > > +
> > > > +	htotal = vm->hactive + vm->hfront_porch + vm->hback_porch +
> > > > +		 vm->hsync_len;
> > > > +	vtotal = vm->vactive + vm->vfront_porch + vm->vback_porch +
> > > > +		 vm->vsync_len;
> > > > +	fbmode->refresh = (vm->pixelclock * 1000) / (htotal * vtotal);
> > > 
> > > This will fail if vm->pixelclock >= ((1 << 32) / 1000). The easiest
> > > solution is probably to use 64-bit computation.
> > 
> > You have displays with a pixelclock > 4GHz?
> 
> vm->pixelclock is expressed in Hz. vm->pixelclock * 1000 will thus overflow if 
> the clock frequency is >= ~4.3 MHz. I have displays with a clock frequency 
> higher than that :-)

If vm->pixelclock is in Hz, then the * 1000 above is wrong.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
