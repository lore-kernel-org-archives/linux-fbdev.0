From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 23 Jan 2019 10:58:30 +0000
Subject: Re: [PATCH] video/fbdev: refactor video= cmdline parsing
Message-Id: <20190123105830.GF3271@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190123093817.13964-1-jani.nikula@intel.com>
In-Reply-To: <20190123093817.13964-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Jan 23, 2019 at 11:38:17AM +0200, Jani Nikula wrote:
> Make the video_setup() function slightly easier to read by removing the
> repeated checks for !global. Remove the misleading return value comment
> while at it.
> 
> I'm slightly hesitant to change any of this, but here goes anyway, with
> hopes that the next person to have to look at this has it a wee bit
> easier.
> 
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/video/fbdev/core/fb_cmdline.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_cmdline.c b/drivers/video/fbdev/core/fb_cmdline.c
> index 39509ccd92f1..3b5bd666b952 100644
> --- a/drivers/video/fbdev/core/fb_cmdline.c
> +++ b/drivers/video/fbdev/core/fb_cmdline.c
> @@ -75,36 +75,33 @@ EXPORT_SYMBOL(fb_get_options);
>   *	NOTE: This function is a __setup and __init function.
>   *            It only stores the options.  Drivers have to call
>   *            fb_get_options() as necessary.
> - *
> - *	Returns zero.
> - *
>   */
>  static int __init video_setup(char *options)
>  {
> -	int i, global = 0;
> -
>  	if (!options || !*options)
> -		global = 1;
> +		goto out;
>  
> -	if (!global && !strncmp(options, "ofonly", 6)) {
> +	if (!strncmp(options, "ofonly", 6)) {
>  		ofonly = 1;
> -		global = 1;
> +		goto out;
>  	}
>  
> -	if (!global && !strchr(options, ':')) {
> -		fb_mode_option = options;
> -		global = 1;
> -	}
> +	if (strchr(options, ':')) {
> +		/* named */
> +		int i;
>  
> -	if (!global) {
>  		for (i = 0; i < FB_MAX; i++) {
>  			if (video_options[i] = NULL) {
>  				video_options[i] = options;
>  				break;
>  			}
>  		}
> +	} else {
> +		/* global */
> +		fb_mode_option = options;
>  	}
>  
> +out:
>  	return 1;
>  }
>  __setup("video=", video_setup);
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
