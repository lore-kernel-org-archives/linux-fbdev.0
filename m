From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 26 Jul 2019 11:36:25 +0000
Subject: Re: [PATCH] video: Demote panel timing not found error message
Message-Id: <20190726113625.GC20065@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190726101849.27322-1-thierry.reding@gmail.com>
In-Reply-To: <20190726101849.27322-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Thierry.

On Fri, Jul 26, 2019 at 12:18:49PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Failing to find a panel-timing node is not an error in all cases, so do
> not output an error message in that case. Instead turn it into a debug
> message and make the drivers that care about it output an error message
> of their own.

This is more or less the same as already implmented by Douglas here:
https://patchwork.kernel.org/cover/11053243/

Doug's has an extra bug-fix that we shall not miss.

I am waiting for feedback from Bartlomiej before proceeding.
I guess he is on holiday somewhere and will return soon.

	Sam

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpu/drm/panel/panel-lvds.c | 4 +++-
>  drivers/video/fbdev/amba-clcd.c    | 4 +++-
>  drivers/video/of_display_timing.c  | 2 +-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
> index 1ec57d0806a8..7fcb3527c788 100644
> --- a/drivers/gpu/drm/panel/panel-lvds.c
> +++ b/drivers/gpu/drm/panel/panel-lvds.c
> @@ -147,8 +147,10 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
>  	int ret;
>  
>  	ret = of_get_display_timing(np, "panel-timing", &timing);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(lvds->dev, "%pOF: could not find panel timing\n", np);
>  		return ret;
> +	}
>  
>  	videomode_from_timing(&timing, &lvds->video_mode);
>  
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
> index 89324e42a033..13df898a3481 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -561,8 +561,10 @@ static int clcdfb_of_get_dpi_panel_mode(struct device_node *node,
>  	struct videomode video;
>  
>  	err = of_get_display_timing(node, "panel-timing", &timing);
> -	if (err)
> +	if (err) {
> +		pr_err("%pOF: could not find panel timing\n", node);
>  		return err;
> +	}
>  
>  	videomode_from_timing(&timing, &video);
>  
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
> index f5c1c469c0af..9385b518349f 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -125,7 +125,7 @@ int of_get_display_timing(const struct device_node *np, const char *name,
>  
>  	timing_np = of_get_child_by_name(np, name);
>  	if (!timing_np) {
> -		pr_err("%pOF: could not find node '%s'\n", np, name);
> +		pr_debug("%pOF: could not find node '%s'\n", np, name);
>  		return -ENOENT;
>  	}
>  
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
