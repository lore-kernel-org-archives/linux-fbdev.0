From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 03 Aug 2020 19:44:51 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: initialize variables
Message-Id: <20200803194451.GB525506@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200720191845.20115-1-trix@redhat.com>
In-Reply-To: <20200720191845.20115-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trix@redhat.com
Cc: linux-fbdev@vger.kernel.org, arnd@arndb.de, gustavo@embeddedor.com, jani.nikula@intel.com, daniel.vetter@ffwll.ch, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, jhubbard@nvidia.com

Hi Tom,

On Mon, Jul 20, 2020 at 12:18:45PM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this repesentative error
> 
> pvr2fb.c:1049:2: warning: 1st function call argument
>   is an uninitialized value [core.CallAndMessage]
>         if (*cable_arg)
>         ^~~~~~~~~~~~~~~
> 
> Problem is that cable_arg depends on the input loop to
> set the cable_arg[0].  If it does not, then some random
> value from the stack is used.
> 
> A similar problem exists for output_arg.
> 
> So initialize cable_arg and output_arg.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/pvr2fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 2d9f69b93392..f4add36cb5f4 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -1028,6 +1028,8 @@ static int __init pvr2fb_setup(char *options)
>  	if (!options || !*options)
>  		return 0;
>  
> +	cable_arg[0] = output_arg[0] = 0;
> +
>  	while ((this_opt = strsep(&options, ","))) {
>  		if (!*this_opt)
>  			continue;
> -- 
> 2.18.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
