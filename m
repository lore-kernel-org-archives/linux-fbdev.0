From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 09 Nov 2012 16:54:16 +0000
Subject: RE: [PATCH v7 5/8] fbmon: add videomode helpers
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9E614A@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351675689-26814-1-git-send-email-s.trumtrar@pengutronix.de>
 <1351675689-26814-6-git-send-email-s.trumtrar@pengutronix.de>
 <A73F36158E33644199EB82C5EC81C7BC3E9E1B39@DBDE01.ent.ti.com>
 <20121108212545.GA32605@pengutronix.de>
In-Reply-To: <20121108212545.GA32605-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Valkeinen, Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennady Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Steffen,

On Fri, Nov 09, 2012 at 02:55:45, Steffen Trumtrar wrote:
> Hi!
> 
> On Wed, Oct 31, 2012 at 03:30:03PM +0000, Manjunathappa, Prakash wrote:
> > Hi Steffen,
> > 
> > On Wed, Oct 31, 2012 at 14:58:05, Steffen Trumtrar wrote:
> > > +#if IS_ENABLED(CONFIG_VIDEOMODE)
> > > +int videomode_to_fb_videomode(struct videomode *vm, struct fb_videomode *fbmode)
> > > +{
> > > +	fbmode->xres = vm->hactive;
> > > +	fbmode->left_margin = vm->hback_porch;
> > > +	fbmode->right_margin = vm->hfront_porch;
> > > +	fbmode->hsync_len = vm->hsync_len;
> > > +
> > > +	fbmode->yres = vm->vactive;
> > > +	fbmode->upper_margin = vm->vback_porch;
> > > +	fbmode->lower_margin = vm->vfront_porch;
> > > +	fbmode->vsync_len = vm->vsync_len;
> > > +
> > > +	fbmode->pixclock = KHZ2PICOS(vm->pixelclock / 1000);
> > > +
> > > +	fbmode->sync = 0;
> > > +	fbmode->vmode = 0;
> > > +	if (vm->hah)
> > > +		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
> > > +	if (vm->vah)
> > > +		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
> > > +	if (vm->interlaced)
> > > +		fbmode->vmode |= FB_VMODE_INTERLACED;
> > > +	if (vm->doublescan)
> > > +		fbmode->vmode |= FB_VMODE_DOUBLE;
> > > +
> > 
> > "pixelclk-inverted" property of the panel is not percolated fb_videomode.
> > Please let me know if I am missing something.
> > 
> 
> The next version is almost finished. Only thing I'm missing is this.
> And I actually do not know which flag would represent an inverted pixelclock
> in fb_videomode. Does anybody have any idea what I have to do here?
> 
> 	if (vm->pixelclk_pol)
> 		fbmode->sync = ???
> 
> That's as far as I have come and I don't see a flag that seems right.
> Is this even a valid property of fb_videomode?
> 

Thanks for considering it, I see IMX addresses it as proprietary FB_SYNC_ flag.
FB_SYNC_CLK_INVERT: arch/arm/plat-mxc/include/mach/mx3fb.h

Thanks,
Prakash

