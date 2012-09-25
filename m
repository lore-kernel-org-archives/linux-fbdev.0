From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Sep 2012 12:59:27 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <2694332.RF2ekIqvgS@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <1347533647.3014.10.camel@deskari> <20120913111954.GH6180@pengutronix.de>
In-Reply-To: <20120913111954.GH6180-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

Hi Sascha,

On Thursday 13 September 2012 13:19:54 Sascha Hauer wrote:
> On Thu, Sep 13, 2012 at 01:54:07PM +0300, Tomi Valkeinen wrote:
> > On Wed, 2012-07-04 at 09:56 +0200, Sascha Hauer wrote:
> > > This patch adds a helper function for parsing videomodes from the
> > > devicetree. The videomode can be either converted to a struct
> > > drm_display_mode or a struct fb_videomode.
> > 
> > I have more or less the same generic comment for this as for the power
> > sequences series discussed: this would add panel specific information
> > into DT data, instead of the driver handling it. But, as also discussed
> > in the thread, there are differing opinions on which way is better.
> 
> With the panel timings I think the approach of moving them into DT is
> the best we can do. There are so many displays out there, patching the
> kernel each time a customer comes with some new display is no fun.

For generic panels, sure, but for panels that require a specific driver (for 
instance because the panel implements vendor-specific comments) the mode(s) 
could be hardcoded in the panel driver.

> > > +int of_get_video_mode(struct device_node *np, struct drm_display_mode
> > > *dmode,
> > > +		struct fb_videomode *fbmode);
> > 
> > From caller's point of view I think it'd make more sense to have
> > separate functions to get drm mode or fb mode. I don't think there's a
> > case where the caller would want both.
> 
> Ok, that makes sense.
> 
> > Then again, even better would be to have a common video mode struct used
> > by both fb and drm... But I think that's been on the todo list of
> > Laurent for a long time already =).
> 
> Yes, indeed. We should go into that direction. We already realized that
> we want to have ranges instead of fixed values for the timings.

-- 
Regards,

Laurent Pinchart

