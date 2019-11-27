From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Nov 2019 18:23:24 +0000
Subject: Re: [PATCH 05/13] video: fbdev: vesafb: modify the static fb_ops directly
Message-Id: <20191127182324.GL406127@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <07acc8c8ef93f36103c7a13dc98e12790c2847df.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <07acc8c8ef93f36103c7a13dc98e12790c2847df.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Wed, Nov 27, 2019 at 06:32:01PM +0200, Jani Nikula wrote:
> Avoid modifying the fb_ops via info->fbops to let us make the pointer
> const in the future.
> 
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/video/fbdev/vesafb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
> index d9c08f6c2155..a1fe24ea869b 100644
> --- a/drivers/video/fbdev/vesafb.c
> +++ b/drivers/video/fbdev/vesafb.c
> @@ -447,15 +447,15 @@ static int vesafb_probe(struct platform_device *dev)
>  	       vesafb_fix.smem_start, info->screen_base,
>  	       size_remap/1024, size_total/1024);
>  
> +	if (!ypan)
> +		vesafb_ops.fb_pan_display = NULL;

vesafb at least has a guarantee that there's only ever one ...

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> +
>  	info->fbops = &vesafb_ops;
>  	info->var = vesafb_defined;
>  	info->fix = vesafb_fix;
>  	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE |
>  		(ypan ? FBINFO_HWACCEL_YPAN : 0);
>  
> -	if (!ypan)
> -		info->fbops->fb_pan_display = NULL;
> -
>  	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
>  		err = -ENOMEM;
>  		goto err;
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
