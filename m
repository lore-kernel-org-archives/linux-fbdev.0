From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 29 Nov 2019 15:25:11 +0000
Subject: Re: [Intel-gfx] [PATCH v2 06/14] video: fbmem: use const pointer for fb_ops
Message-Id: <20191129152511.GH624164@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
 <3a27f95b424a67b3542b5906c660741daf1d4ea6.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <3a27f95b424a67b3542b5906c660741daf1d4ea6.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Fri, Nov 29, 2019 at 12:29:36PM +0200, Jani Nikula wrote:
> Use const for fb_ops to let us make the info->fbops pointer const in the
> future.
> 
> v2: rebase
> 
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

I guess my r-b got lost on this, not sure, anyway.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 990550930a8e..7ddeb90337bc 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1079,7 +1079,7 @@ EXPORT_SYMBOL(fb_blank);
>  static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
>  			unsigned long arg)
>  {
> -	struct fb_ops *fb;
> +	const struct fb_ops *fb;
>  	struct fb_var_screeninfo var;
>  	struct fb_fix_screeninfo fix;
>  	struct fb_cmap cmap_from;
> @@ -1292,7 +1292,7 @@ static long fb_compat_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {
>  	struct fb_info *info = file_fb_info(file);
> -	struct fb_ops *fb;
> +	const struct fb_ops *fb;
>  	long ret = -ENOIOCTLCMD;
>  
>  	if (!info)
> -- 
> 2.20.1
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
