From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 05 Mar 2013 09:24:53 +0000
Subject: Re: [PATCH v17 2/7] video: add display_timing and videomode
Message-Id: <20130305092453.GB7042@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359104515-8907-1-git-send-email-s.trumtrar@pengutronix.de>
 <1359104515-8907-3-git-send-email-s.trumtrar@pengutronix.de>
 <51223615.4090709@iki.fi> <512E2A1B.6040704@ti.com>
 <20130227160540.GA10491@pengutronix.de> <512E30BD.7010603@ti.com>
In-Reply-To: <512E30BD.7010603-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi!

On Wed, Feb 27, 2013 at 06:13:49PM +0200, Tomi Valkeinen wrote:
> On 2013-02-27 18:05, Steffen Trumtrar wrote:
> > Ah, sorry. Forgot to answer this.
> > 
> > On Wed, Feb 27, 2013 at 05:45:31PM +0200, Tomi Valkeinen wrote:
> >> Ping.
> >>
> >> On 2013-02-18 16:09, Tomi Valkeinen wrote:
> >>> Hi Steffen,
> >>>
> >>> On 2013-01-25 11:01, Steffen Trumtrar wrote:
> >>>
> >>>> +/* VESA display monitor timing parameters */
> >>>> +#define VESA_DMT_HSYNC_LOW		BIT(0)
> >>>> +#define VESA_DMT_HSYNC_HIGH		BIT(1)
> >>>> +#define VESA_DMT_VSYNC_LOW		BIT(2)
> >>>> +#define VESA_DMT_VSYNC_HIGH		BIT(3)
> >>>> +
> >>>> +/* display specific flags */
> >>>> +#define DISPLAY_FLAGS_DE_LOW		BIT(0)	/* data enable flag */
> >>>> +#define DISPLAY_FLAGS_DE_HIGH		BIT(1)
> >>>> +#define DISPLAY_FLAGS_PIXDATA_POSEDGE	BIT(2)	/* drive data on pos. edge */
> >>>> +#define DISPLAY_FLAGS_PIXDATA_NEGEDGE	BIT(3)	/* drive data on neg. edge */
> >>>> +#define DISPLAY_FLAGS_INTERLACED	BIT(4)
> >>>> +#define DISPLAY_FLAGS_DOUBLESCAN	BIT(5)
> >>>
> >>> <snip>
> >>>
> >>>> +	unsigned int dmt_flags;	/* VESA DMT flags */
> >>>> +	unsigned int data_flags; /* video data flags */
> >>>
> >>> Why did you go for this approach? To be able to represent
> >>> true/false/not-specified?
> >>>
> > 
> > We decided somewhere between v3 and v8 (I think), that those flags can be
> > high/low/ignored.
> 
> Okay. Why aren't they enums, though? That always makes more clear which
> defines are to be used with which fields.
> 

Hm...

> >>> Would it be simpler to just have "flags" field? What does it give us to
> >>> have those two separately?
> >>>
> > 
> > I decided to split them, so it is clear that some flags are VESA defined and
> > the others are "invented" for the display-timings framework and may be
> > extended.
> 
> Hmm... Okay. Is it relevant that they are VESA defined? It just feels to
> complicate handling the flags =).
> 
> >>> Should the above say raising edge/falling edge instead of positive
> >>> edge/negative edge?
> >>>
> > 
> > Hm, I used posedge/negedge because it is shorter (and because of my Verilog past
> > pretty natural to me :-) ). I don't know what others are thinking though.
> 
> I guess it's quite clear, but it's still different terms than used
> elsewhere, e.g. documentation for videomodes.
> 
> Another thing I noticed while using the new videomode, display_timings.h
> has a few names that are quite short and generic. Like "TE_MIN", which
> is now a global define. And "timing_entry". Either name could be well
> used internally in some .c file, and could easily clash.
> 

Yes. You are correct.
Everyone using this is welcome to send patches now :-)

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
