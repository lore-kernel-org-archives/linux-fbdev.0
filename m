From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 06 May 2020 19:07:01 +0000
Subject: Re: [PATCH] video: fbdev: valkyriefb.c: fix warning comparing pointer to 0
Message-Id: <20200506190701.GE8227@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200429140942.8137-1-yanaijie@huawei.com>
In-Reply-To: <20200429140942.8137-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, b.zolnierkie@samsung.com

On Wed, Apr 29, 2020 at 10:09:42PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
> 0, suggest !E
> drivers/video/fbdev/valkyriefb.c:334:12-13: WARNING comparing pointer to
> 0
> drivers/video/fbdev/valkyriefb.c:348:10-11: WARNING comparing pointer to
> 0
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/valkyriefb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
> index 4d20c4603e5a..8425afe37d7c 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -331,7 +331,7 @@ int __init valkyriefb_init(void)
>  		struct resource r;
>  
>  		dp = of_find_node_by_name(NULL, "valkyrie");
> -		if (dp = 0)
> +		if (!dp)
>  			return 0;
>  
>  		if (of_address_to_resource(dp, 0, &r)) {
> @@ -345,7 +345,7 @@ int __init valkyriefb_init(void)
>  #endif /* ppc (!CONFIG_MAC) */
>  
>  	p = kzalloc(sizeof(*p), GFP_ATOMIC);
> -	if (p = 0)
> +	if (!p)
>  		return -ENOMEM;
>  
>  	/* Map in frame buffer and registers */
> -- 
> 2.21.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
