From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Jul 2012 20:40:55 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <Pine.LNX.4.64.1207112106510.18999@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <Pine.LNX.4.64.1207111031200.18999@axis700.grange>
 <20120711190414.GQ30009@pengutronix.de>
In-Reply-To: <20120711190414.GQ30009-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

On Wed, 11 Jul 2012, Sascha Hauer wrote:

> Hi Guennadi,
> 
> On Wed, Jul 11, 2012 at 10:34:54AM +0200, Guennadi Liakhovetski wrote:
> > Hi Sascha
> > 
> > > +
> > > +Optional properties:
> > > + - width-mm, height-mm: Display dimensions in mm
> > > + - hsync-active-high (bool): Hsync pulse is active high
> > > + - vsync-active-high (bool): Vsync pulse is active high
> > 
> > How about
> > 
> > + - hsync-active: Hsync pulse polarity: 1 for high, 0 for low
> 
> I am unsure if it's good to mix this with the other bool flags like:
> 
> > 
> > > + - interlaced (bool): This is an interlaced mode
> > > + - doublescan (bool): This is a doublescan mode
> 
> Which behave differently. 'interlaced' will be evaluated as true if
> the property is present, no matter which value it has. This might
> lead to confusion.

I don't feel strongly either way either. I don't think it'd be confusing - 
you have integer properties there too, and the logic in this case is not 
"active high - yes or now," but rather "active level - logical 1 (high) or 
0 (low)." But as I said - that was just an idea, unless someone has strong 
arguments either way - you're the original author, it's your call:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
