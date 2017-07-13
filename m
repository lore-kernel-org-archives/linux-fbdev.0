From: Sean Paul <seanpaul@chromium.org>
Date: Thu, 13 Jul 2017 14:50:47 +0000
Subject: Re: [PATCH] fbdev: Nuke FBINFO_MODULE
Message-Id: <20170713145047.aepfaa2onckesu3d@art_vandelay>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-3-daniel.vetter@ffwll.ch>
 <20170711145219.22410-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20170711145219.22410-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, Jul 11, 2017 at 04:52:19PM +0200, Daniel Vetter wrote:
> Instead check info->ops->owner, which amounts to the same.
> 
> Spotted because I want to remove the pile of broken and cargo-culted
> fb_info->flags assignments in drm drivers.
> 
> v2: Fixup matrox (reported by kbuild). Also nuke FBINFO_FLAG_* defines
> that I've failed to spot.
> 
> v3: Don't nuke FBINFO_FLAG_DEFAULT, that's used all over the place.
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/video/fbdev/core/fbcon.c           |  2 +-
>  drivers/video/fbdev/core/fbmem.c           |  4 ++--
>  drivers/video/fbdev/matrox/matroxfb_base.c |  4 +---
>  include/linux/fb.h                         | 10 +---------
>  4 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 86b3bcbd01a8..431a1533a2fe 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -564,7 +564,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
>  	unsigned short *save = NULL, *r, *q;
>  	int logo_height;
>  
> -	if (info->flags & FBINFO_MODULE) {
> +	if (info->fbops->owner) {
>  		logo_shown = FBCON_LOGO_DONTSHOW;
>  		return;
>  	}
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 283d57cf8526..2636f192e8c9 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -463,7 +463,7 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
>  
>  	/* Return if the frame buffer is not mapped or suspended */
>  	if (logo = NULL || info->state != FBINFO_STATE_RUNNING ||
> -	    info->flags & FBINFO_MODULE)
> +	    info->fbops->owner)
>  		return 0;
>  
>  	image.depth = 8;
> @@ -601,7 +601,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
>  	memset(&fb_logo, 0, sizeof(struct logo_data));
>  
>  	if (info->flags & FBINFO_MISC_TILEBLITTING ||
> -	    info->flags & FBINFO_MODULE)
> +	    info->fbops->owner)
>  		return 0;
>  
>  	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
> index 11eb094396ae..15b412b4b783 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -1794,9 +1794,7 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
>  	minfo->fbops = matroxfb_ops;
>  	minfo->fbcon.fbops = &minfo->fbops;
>  	minfo->fbcon.pseudo_palette = minfo->cmap;
> -	/* after __init time we are like module... no logo */
> -	minfo->fbcon.flags = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
> -	minfo->fbcon.flags |= FBINFO_PARTIAL_PAN_OK | 	 /* Prefer panning for scroll under MC viewer/edit */
> +	minfo->fbcon.flags = FBINFO_PARTIAL_PAN_OK | 	 /* Prefer panning for scroll under MC viewer/edit */
>  				      FBINFO_HWACCEL_COPYAREA |  /* We have hw-assisted bmove */
>  				      FBINFO_HWACCEL_FILLRECT |  /* And fillrect */
>  				      FBINFO_HWACCEL_IMAGEBLIT | /* And imageblit */
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index a964d076b4dc..f4386b0ccf40 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -400,7 +400,7 @@ struct fb_tile_ops {
>  #endif /* CONFIG_FB_TILEBLITTING */
>  
>  /* FBINFO_* = fb_info.flags bit flags */
> -#define FBINFO_MODULE		0x0001	/* Low-level driver is a module */
> +#define FBINFO_DEFAULT		0
>  #define FBINFO_HWACCEL_DISABLED	0x0002
>  	/* When FBINFO_HWACCEL_DISABLED is set:
>  	 *  Hardware acceleration is turned off.  Software implementations
> @@ -533,14 +533,6 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
>  	return a;
>  }
>  
> -#ifdef MODULE
> -#define FBINFO_DEFAULT	FBINFO_MODULE
> -#else
> -#define FBINFO_DEFAULT	0
> -#endif
> -
> -// This will go away
> -#define FBINFO_FLAG_MODULE	FBINFO_MODULE
>  #define FBINFO_FLAG_DEFAULT	FBINFO_DEFAULT
>  
>  /* This will go away
> -- 
> 2.13.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sean Paul, Software Engineer, Google / Chromium OS
