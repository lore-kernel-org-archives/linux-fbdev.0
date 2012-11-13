From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 13 Nov 2012 13:30:14 +0000
Subject: Re: [PATCH v8 6/6] drm_modes: add of_videomode helpers
Message-Id: <20121113133014.GG27797@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352734626-27412-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352734626-27412-7-git-send-email-s.trumtrar@pengutronix.de>
 <20121113113518.GE30049@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121113113518.GE30049@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennady Liakhovetski <g.liakhovetski@gmx.de>, linux-media@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de

On Tue, Nov 13, 2012 at 12:35:18PM +0100, Thierry Reding wrote:
> On Mon, Nov 12, 2012 at 04:37:06PM +0100, Steffen Trumtrar wrote:
> [...]
> > +#if IS_ENABLED(CONFIG_OF_VIDEOMODE)
> > +static void dump_drm_displaymode(struct drm_display_mode *m)
> > +{
> > +	pr_debug("drm_displaymode = %d %d %d %d %d %d %d %d %d\n",
> > +		 m->hdisplay, m->hsync_start, m->hsync_end, m->htotal,
> > +		 m->vdisplay, m->vsync_start, m->vsync_end, m->vtotal,
> > +		 m->clock);
> 
> I seem to remember a comment to an earlier version of this patch
> requesting better formatting of this string. Alternatively you might
> want to consider replacing it using drm_mode_debug_printmodeline().
> 

Ah, yes. I only did that for fb_videomode and forgot about this one.
But the existing function is even better.

> > diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> [...]
> > @@ -1457,6 +1458,10 @@ drm_mode_create_from_cmdline_mode(struct drm_device *dev,
> >  
> >  extern int videomode_to_display_mode(struct videomode *vm,
> >  				     struct drm_display_mode *dmode);
> > +extern int of_get_drm_display_mode(struct device_node *np,
> > +				   struct drm_display_mode *dmode,
> > +				   int index);
> 
> Also requires either a dummy or protection.
> 
> Thierry



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
