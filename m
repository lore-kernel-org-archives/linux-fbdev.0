From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 13 Dec 2017 21:35:06 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <20171213213506.GD26573@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
In-Reply-To: <20171213194755.3409-4-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: linux-fbdev@vger.kernel.org, michal@markovi.net, b.zolnierkie@samsung.com, sndirsch@suse.com, oneukum@suse.com, tiwai@suse.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, philm@manjaro.org, bernhard.rosenkranzer@linaro.org

On Wed, Dec 13, 2017 at 08:47:45PM +0100, Max Staudt wrote:
> Framebuffers with deferred I/O need to be flushed to the screen
> explicitly, since we use neither the mmap nor the file I/O abstractions
> that handle this for userspace FB clients.
> 
> Example: xenfb
> 
> Some framebuffer drivers implement lazy access to the screen without
> actually exposing a fbdefio interface - we also match some known ones,
> currently:
>  - ast
>  - cirrus
>  - mgag200
> 
> Signed-off-by: Max Staudt <mstaudt@suse.de>
> Reviewed-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/video/fbdev/core/bootsplash.c          |  2 ++
>  drivers/video/fbdev/core/bootsplash_internal.h |  1 +
>  drivers/video/fbdev/core/bootsplash_render.c   | 33 ++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/bootsplash.c b/drivers/video/fbdev/core/bootsplash.c
> index 843c5400fefc..815b007f81ca 100644
> --- a/drivers/video/fbdev/core/bootsplash.c
> +++ b/drivers/video/fbdev/core/bootsplash.c
> @@ -112,6 +112,8 @@ void bootsplash_render_full(struct fb_info *info)
>  
>  	bootsplash_do_render_pictures(info, splash_state.file);
>  
> +	bootsplash_do_render_flush(info);
> +
>  out:
>  	mutex_unlock(&splash_state.data_lock);
>  }
> diff --git a/drivers/video/fbdev/core/bootsplash_internal.h b/drivers/video/fbdev/core/bootsplash_internal.h
> index 71e2a27ac0b8..0acb383aa4e3 100644
> --- a/drivers/video/fbdev/core/bootsplash_internal.h
> +++ b/drivers/video/fbdev/core/bootsplash_internal.h
> @@ -89,6 +89,7 @@ void bootsplash_do_render_background(struct fb_info *info,
>  				     const struct splash_file_priv *fp);
>  void bootsplash_do_render_pictures(struct fb_info *info,
>  				   const struct splash_file_priv *fp);
> +void bootsplash_do_render_flush(struct fb_info *info);
>  
>  
>  void bootsplash_free_file(struct splash_file_priv *fp);
> diff --git a/drivers/video/fbdev/core/bootsplash_render.c b/drivers/video/fbdev/core/bootsplash_render.c
> index 2ae36949d0e3..8c09c306ff67 100644
> --- a/drivers/video/fbdev/core/bootsplash_render.c
> +++ b/drivers/video/fbdev/core/bootsplash_render.c
> @@ -186,3 +186,36 @@ void bootsplash_do_render_pictures(struct fb_info *info,
>  				pp->pic_header->width, pp->pic_header->height);
>  	}
>  }
> +
> +
> +void bootsplash_do_render_flush(struct fb_info *info)
> +{
> +	/*
> +	 * FB drivers using deferred_io (such as Xen) need to sync the
> +	 * screen after modifying its contents. When the FB is mmap()ed
> +	 * from userspace, this happens via a dirty pages callback, but
> +	 * when modifying the FB from the kernel, there is no such thing.
> +	 *
> +	 * So let's issue a fake fb_copyarea (copying the FB onto itself)
> +	 * to trick the FB driver into syncing the screen.

Using drm directly would allow you to flush the contents without the fake
(and tbh, really expensive on most drivers) copy op. If you insist on
using fbdev for this stuff, then at least add a new hook to flush cpu
rendering.

> +	 *
> +	 * A few DRM drivers' FB implementations are broken by not using
> +	 * deferred_io when they really should - we match on the known
> +	 * bad ones manually for now.
> +	 */
> +	if (info->fbdefio
> +	    || !strcmp(info->fix.id, "astdrmfb")
> +	    || !strcmp(info->fix.id, "cirrusdrmfb")
> +	    || !strcmp(info->fix.id, "mgadrmfb")) {

We have a shared defio implementation now in drm_fb_helper.c, there's not
really many excuses to not fix up these drivers to just use those ...
-Daniel

> +		struct fb_copyarea area;
> +
> +		area.dx = 0;
> +		area.dy = 0;
> +		area.width = info->var.xres;
> +		area.height = info->var.yres;
> +		area.sx = 0;
> +		area.sy = 0;
> +
> +		info->fbops->fb_copyarea(info, &area);
> +	}
> +}
> -- 
> 2.12.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
