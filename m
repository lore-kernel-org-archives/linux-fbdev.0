From: James Simmons <jsimmons@infradead.org>
Date: Sat, 13 Mar 2010 21:28:16 +0000
Subject: Re: [PATCH] drm modes to fbdev mode patch
Message-Id: <alpine.LFD.2.00.1003132123340.7379@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003131440230.12031@casper.infradead.org>
	<20100313153147.GD4536@sci.fi>
In-Reply-To: <20100313153147.GD4536@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>


> > For the fbdev layer the you have your struct fb_var_screeninfo and also 
> > struct fb_videomode. The struct fb_videomode was developed for the modes
> > database we have. Struct fb_var_screeninfo is more than just resolution 
> > data which is why we create struct fb_videomode. The really nice thing 
> > is that the conversion from fb_var to fb_videomode always fixes the 
> > pixclock to the proper values so you don't need the pixclock = 0 work 
> > around. I tested this patch with the intelfb driver and had no problem.
> > I have used it in the past with a KMS enabled tdfx drver I wrote. In the 
> > future this function can be used for fbdev level mode setting. Please try 
> > it out and i hope it can be merged. Thanks.
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 5054970..467ac68 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -581,6 +581,60 @@ int drm_fb_helper_setcolreg(unsigned regno,
> >  }
> >  EXPORT_SYMBOL(drm_fb_helper_setcolreg);
> >  
> > +void drm_display_mode_to_fbmode(struct drm_display_mode *mode,
> > +                                struct fb_videomode *fbmode)
> > +{
> > +	fbmode->xres = mode->hdisplay;
> > +	fbmode->yres = mode->vdisplay;
> > +	fbmode->right_margin = mode->hsync_start - mode->hdisplay;
> > +	fbmode->lower_margin = mode->vsync_start - mode->vdisplay;
> > +	fbmode->hsync_len = mode->hsync_end - mode->hsync_start;
> > +	fbmode->vsync_len = mode->vsync_end - mode->vsync_start;
> > +	fbmode->left_margin = mode->htotal - mode->hsync_end;
> > +	fbmode->upper_margin = mode->vtotal - mode->vsync_end;
> > +	fbmode->refresh = mode->vrefresh;
> > +	fbmode->name = mode->name;
> 
> Is there some guarantee that mode won't be freed before fbmode? That
> would leave fbmode->name pointing to invalid memory.

Ah. The fbdev layer doesn't alloc memory for this string. Will fix.
 
> > +
> > +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > +		fbmode->vmode |= FB_VMODE_INTERLACED;
> > +
> > +	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> > +		fbmode->vmode |= FB_VMODE_DOUBLE;
> > +
> 
> What about the sync flags?

Haven't got around to it yet. Plus some flags don't map so well.

> > +	mode->vrefresh = fbmode->refresh;
> > +	mode->clock = PICOS2KHZ(fbmode->pixclock);
> > +
> > +	if ((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_INTERLACED)
> > +		mode->flags |= DRM_MODE_FLAG_INTERLACE;
> > +
> > +	if ((fbmode->vmode & FB_VMODE_MASK) = FB_VMODE_DOUBLE)
> > +		mode->flags |= DRM_MODE_FLAG_DBLSCAN;
> 
> Is interlaced+dblscan considered an invalid combination? The conversion
> to the other direction didn't make that assumption.

True they tend to cancel each other out. I can work on that as well.

