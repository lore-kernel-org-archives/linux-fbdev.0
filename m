From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Nov 2019 18:22:10 +0000
Subject: Re: [PATCH 04/13] video: udlfb: don't restore fb_mmap after deferred IO cleanup
Message-Id: <20191127182210.GK406127@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <21cc1f07daffeddf4d59f2b444796c0216274c87.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <21cc1f07daffeddf4d59f2b444796c0216274c87.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Bernie Thompson <bernie@plugable.com>

On Wed, Nov 27, 2019 at 06:32:00PM +0200, Jani Nikula wrote:
> Deferred IO now preserves the fb_ops.
> 
> Cc: Bernie Thompson <bernie@plugable.com>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Aside: I wonder whether we should start retiring all the fbdev drivers
which have kms drivers already ... you get fbdev for free with the latter.
-Daniel

> ---
>  drivers/video/fbdev/udlfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index fe373b63ddd6..07905d385949 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1037,7 +1037,6 @@ static int dlfb_ops_release(struct fb_info *info, int user)
>  		fb_deferred_io_cleanup(info);
>  		kfree(info->fbdefio);
>  		info->fbdefio = NULL;
> -		info->fbops->fb_mmap = dlfb_ops_mmap;
>  	}
>  
>  	dev_dbg(info->dev, "release, user=%d count=%d\n", user, dlfb->fb_count);
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
