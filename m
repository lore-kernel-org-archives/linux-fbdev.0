From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Sat, 13 Mar 2010 15:31:48 +0000
Subject: Re: [PATCH] drm modes to fbdev mode patch
Message-Id: <20100313153147.GD4536@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1003131440230.12031@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1003131440230.12031@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI development list <dri-devel@lists.sourceforge.net>

On Sat, Mar 13, 2010 at 02:47:52PM +0000, James Simmons wrote:
>=20
> For the fbdev layer the you have your struct fb_var_screeninfo and also=20
> struct fb_videomode. The struct fb_videomode was developed for the modes
> database we have. Struct fb_var_screeninfo is more than just resolution=20
> data which is why we create struct fb_videomode. The really nice thing=20
> is that the conversion from fb_var to fb_videomode always fixes the=20
> pixclock to the proper values so you don't need the pixclock =3D 0 work=20
> around. I tested this patch with the intelfb driver and had no problem.
> I have used it in the past with a KMS enabled tdfx drver I wrote. In the =

> future this function can be used for fbdev level mode setting. Please try=
=20
> it out and i hope it can be merged. Thanks.
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 5054970..467ac68 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -581,6 +581,60 @@ int drm_fb_helper_setcolreg(unsigned regno,
>  }
>  EXPORT_SYMBOL(drm_fb_helper_setcolreg);
> =20
> +void drm_display_mode_to_fbmode(struct drm_display_mode *mode,
> +                                struct fb_videomode *fbmode)
> +{
> +	fbmode->xres =3D mode->hdisplay;
> +	fbmode->yres =3D mode->vdisplay;
> +	fbmode->right_margin =3D mode->hsync_start - mode->hdisplay;
> +	fbmode->lower_margin =3D mode->vsync_start - mode->vdisplay;
> +	fbmode->hsync_len =3D mode->hsync_end - mode->hsync_start;
> +	fbmode->vsync_len =3D mode->vsync_end - mode->vsync_start;
> +	fbmode->left_margin =3D mode->htotal - mode->hsync_end;
> +	fbmode->upper_margin =3D mode->vtotal - mode->vsync_end;
> +	fbmode->refresh =3D mode->vrefresh;
> +	fbmode->name =3D mode->name;

Is there some guarantee that mode won't be freed before fbmode? That
would leave fbmode->name pointing to invalid memory.

> +
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		fbmode->vmode |=3D FB_VMODE_INTERLACED;
> +
> +	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
> +		fbmode->vmode |=3D FB_VMODE_DOUBLE;
> +

What about the sync flags?

> +	/* Doing a var to fb_videomode always create a proper pixclock
> +	 * we can trust, but the reverse is not true. So we create
> +	 * a proper pixclock from the refresh rate wanted. */
> +	fbmode->pixclock =3D mode->vrefresh * mode->vtotal;
> +	fbmode->pixclock *=3D mode->htotal;
> +	fbmode->pixclock /=3D 1000;
> +	fbmode->pixclock =3D KHZ2PICOS(fbmode->pixclock);
> +}
> +EXPORT_SYMBOL(drm_display_mode_to_fbmode);
> +
> +void fbmode_to_drm_display_mode(struct fb_videomode *fbmode,
> +                                struct drm_display_mode *mode)
> +{
> +	mode->hdisplay =3D fbmode->xres;
> +	mode->vdisplay =3D fbmode->yres;
> +	mode->hsync_start =3D mode->hdisplay + fbmode->right_margin;
> +	mode->vsync_start =3D mode->vdisplay + fbmode->lower_margin;
> +	mode->hsync_end =3D mode->hsync_start + fbmode->hsync_len;
> +	mode->vsync_end =3D mode->vsync_start + fbmode->vsync_len;
> +	mode->htotal =3D mode->hsync_end + fbmode->left_margin;
> +	mode->vtotal =3D mode->vsync_end + fbmode->upper_margin;
> +	mode->vrefresh =3D fbmode->refresh;
> +	mode->clock =3D PICOS2KHZ(fbmode->pixclock);
> +
> +	if ((fbmode->vmode & FB_VMODE_MASK) =3D FB_VMODE_INTERLACED)
> +		mode->flags |=3D DRM_MODE_FLAG_INTERLACE;
> +
> +	if ((fbmode->vmode & FB_VMODE_MASK) =3D FB_VMODE_DOUBLE)
> +		mode->flags |=3D DRM_MODE_FLAG_DBLSCAN;

Is interlaced+dblscan considered an invalid combination? The conversion
to the other direction didn't make that assumption.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
