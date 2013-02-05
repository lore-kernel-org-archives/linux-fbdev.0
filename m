From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 05 Feb 2013 18:29:53 +0000
Subject: Re: [PATCH v17 4/7] fbmon: add videomode helpers
Message-Id: <20130205182953.GC27438@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359104515-8907-1-git-send-email-s.trumtrar@pengutronix.de>
 <1359104515-8907-5-git-send-email-s.trumtrar@pengutronix.de>
 <003401ce005e$af665c50$0e3314f0$%han@samsung.com>
In-Reply-To: <003401ce005e$af665c50$0e3314f0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "'Mohammed, Afzal'" <afzal-l0cyMroinI0@public.gmane.org>, 'Florian Tobias Schandinat' <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, 'Dave Airlie' <airlied-cv59FeDIM0c@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, 'Tomi Valkeinen' <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, 'Guennady Liakhovetski' <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi!

On Fri, Feb 01, 2013 at 06:29:50PM +0900, Jingoo Han wrote:
> On Friday, January 25, 2013 6:02 PM, Steffen Trumtrar wrote
> > 
> > +	fbmode->sync = 0;
> > +	fbmode->vmode = 0;
> > +	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
> > +		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
> > +	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
> 
> Um, it seems to be a type. 'H'SYNC -> 'V'SYNC
> Thus, it would be changed as below:
> 
>     VESA_DMT_HSYNC_HIGH -> VESA_DMT_VSYNC_HIGH

Damn. You are right, that is a typo. But I guess some maintainer (Dave) really,
really wants to take the series now and this can wait for an -rc. No?!  ;-)

Thanks,
Steffen

> 
> > +		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
> > +	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
> > +		fbmode->vmode |= FB_VMODE_INTERLACED;
> > +	if (vm->data_flags & DISPLAY_FLAGS_DOUBLESCAN)
> > +		fbmode->vmode |= FB_VMODE_DOUBLE;
> > +	fbmode->flag = 0;
> > +

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
