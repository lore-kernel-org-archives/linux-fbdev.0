From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 11 Jul 2012 19:04:14 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <20120711190414.GQ30009@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <Pine.LNX.4.64.1207111031200.18999@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207111031200.18999-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

Hi Guennadi,

On Wed, Jul 11, 2012 at 10:34:54AM +0200, Guennadi Liakhovetski wrote:
> Hi Sascha
> 
> > +
> > +Optional properties:
> > + - width-mm, height-mm: Display dimensions in mm
> > + - hsync-active-high (bool): Hsync pulse is active high
> > + - vsync-active-high (bool): Vsync pulse is active high
> 
> How about
> 
> + - hsync-active: Hsync pulse polarity: 1 for high, 0 for low

I am unsure if it's good to mix this with the other bool flags like:

> 
> > + - interlaced (bool): This is an interlaced mode
> > + - doublescan (bool): This is a doublescan mode

Which behave differently. 'interlaced' will be evaluated as true if
the property is present, no matter which value it has. This might
lead to confusion.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
