From: Joonyoung Shim <jy0922.shim@samsung.com>
Date: Thu, 08 Mar 2012 13:05:50 +0000
Subject: Re: [PATCH] drm: exynos: Fix fb_videomode <-> drm_mode_modeinfo conversion
Message-Id: <4F58AEAE.4080601@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331206495-3853-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1331206495-3853-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Inki Dae <inki.dae@samsung.com>, linux-fbdev@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, dri-devel@lists.freedesktop.org

On 03/08/2012 08:34 PM, Laurent Pinchart wrote:
> The fb_videomode structure stores the front porch and back porch in the
> right_margin and left_margin fields respectively. right_margin should
> thus be computed with hsync_start - hdisplay, and left_margin with
> htotal - hsync_end. The same holds for the vertical direction.
>
>         Active               Front           Sync            Back
>         Region               Porch                           Porch
> <-------------------><----------------><-------------><---------------->
>
>    //////////////////|
>   ////////////////// |
> //////////////////  |..................               ..................
>                                         _______________
>
> <------ xres -------><- right_margin -><- hsync_len -><- left_margin -->
>
> <---- hdisplay ----->
> <------------ hsync_start ------------>
> <--------------------- hsync_end -------------------->
> <--------------------------------- htotal ----------------------------->
>
> Fix the fb_videomode<->  drm_mode_modeinfo conversion functions
> accordingly.
>
> Signed-off-by: Laurent Pinchart<laurent.pinchart@ideasonboard.com>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_connector.c |   16 ++++++++--------
>   1 files changed, 8 insertions(+), 8 deletions(-)
>
> While trying to understand how the fb_videomode and drm_mode_modeinfo fields
> map to each other, I found what might be a bug in the Exynos DRM driver. Could
> you please check and confirm that my understanding is correct ?

Good catch. You can refer Documentation/fb/framebuffer.txt to know in 
detail.

Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_connector.c b/drivers/gpu/drm/exynos/exynos_drm_connector.c
> index d620b07..7bb1dca 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_connector.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_connector.c
> @@ -52,14 +52,14 @@ convert_to_display_mode(struct drm_display_mode *mode,
>   	mode->vrefresh = timing->refresh;
>
>   	mode->hdisplay = timing->xres;
> -	mode->hsync_start = mode->hdisplay + timing->left_margin;
> +	mode->hsync_start = mode->hdisplay + timing->right_margin;
>   	mode->hsync_end = mode->hsync_start + timing->hsync_len;
> -	mode->htotal = mode->hsync_end + timing->right_margin;
> +	mode->htotal = mode->hsync_end + timing->left_margin;
>
>   	mode->vdisplay = timing->yres;
> -	mode->vsync_start = mode->vdisplay + timing->upper_margin;
> +	mode->vsync_start = mode->vdisplay + timing->lower_margin;
>   	mode->vsync_end = mode->vsync_start + timing->vsync_len;
> -	mode->vtotal = mode->vsync_end + timing->lower_margin;
> +	mode->vtotal = mode->vsync_end + timing->upper_margin;
>
>   	if (timing->vmode&  FB_VMODE_INTERLACED)
>   		mode->flags |= DRM_MODE_FLAG_INTERLACE;
> @@ -81,14 +81,14 @@ convert_to_video_timing(struct fb_videomode *timing,
>   	timing->refresh = drm_mode_vrefresh(mode);
>
>   	timing->xres = mode->hdisplay;
> -	timing->left_margin = mode->hsync_start - mode->hdisplay;
> +	timing->right_margin = mode->hsync_start - mode->hdisplay;
>   	timing->hsync_len = mode->hsync_end - mode->hsync_start;
> -	timing->right_margin = mode->htotal - mode->hsync_end;
> +	timing->left_margin = mode->htotal - mode->hsync_end;
>
>   	timing->yres = mode->vdisplay;
> -	timing->upper_margin = mode->vsync_start - mode->vdisplay;
> +	timing->lower_margin = mode->vsync_start - mode->vdisplay;
>   	timing->vsync_len = mode->vsync_end - mode->vsync_start;
> -	timing->lower_margin = mode->vtotal - mode->vsync_end;
> +	timing->upper_margin = mode->vtotal - mode->vsync_end;
>
>   	if (mode->flags&  DRM_MODE_FLAG_INTERLACE)
>   		timing->vmode = FB_VMODE_INTERLACED;

