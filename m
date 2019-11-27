From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 27 Nov 2019 18:20:28 +0000
Subject: Re: [Intel-gfx] [PATCH 03/13] video: smscufx: don't restore fb_mmap after deferred IO cleanup
Message-Id: <20191127182028.GI406127@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <5c25b31242a3ae2326ccf163e5be5ae401b04b49.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <5c25b31242a3ae2326ccf163e5be5ae401b04b49.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>, linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org

On Wed, Nov 27, 2019 at 06:31:59PM +0200, Jani Nikula wrote:
> Deferred IO now preserves the fb_ops.
> 
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  drivers/video/fbdev/smscufx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
> index 0e0f5bbfc5ef..e362d7da87fc 100644
> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -1170,7 +1170,6 @@ static int ufx_ops_release(struct fb_info *info, int user)
>  		fb_deferred_io_cleanup(info);
>  		kfree(info->fbdefio);
>  		info->fbdefio = NULL;
> -		info->fbops->fb_mmap = ufx_ops_mmap;

Also totally pointless to restore this here, since if you have indeed
loaded the driver twice shit has hit the fan already. I guess that was for
the module option .... wtf.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  	}
>  
>  	pr_debug("released /dev/fb%d user=%d count=%d",
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
