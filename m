From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:40:27 +0000
Subject: Re: [PATCH] omapfb/dss: remove unneeded conversions to bool
Message-Id: <5251890d-e12e-c78c-9790-fe8764501744@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191016180541epcas5p4d85d004250e99c95c876da3c03d4d46e@epcas5p4.samsung.com>
        <20191016180424.23907-1-afd@ti.com>
In-Reply-To: <20191016180424.23907-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Andrew F. Davis" <afd@ti.com>
Cc: Jiri Kosina <trivial@kernel.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On 10/16/19 8:04 PM, Andrew F. Davis wrote:
> Found with scripts/coccinelle/misc/boolconv.cocci.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> index 376ee5bc3ddc..ce37da85cc45 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> @@ -1635,7 +1635,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
>  {
>  	int scale_x = out_width != orig_width;
>  	int scale_y = out_height != orig_height;
> -	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
> +	bool chroma_upscale = plane != OMAP_DSS_WB;
>  
>  	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
>  		return;
> @@ -3100,9 +3100,9 @@ static bool _dispc_mgr_pclk_ok(enum omap_channel channel,
>  		unsigned long pclk)
>  {
>  	if (dss_mgr_is_lcd(channel))
> -		return pclk <= dispc.feat->max_lcd_pclk ? true : false;
> +		return pclk <= dispc.feat->max_lcd_pclk;
>  	else
> -		return pclk <= dispc.feat->max_tv_pclk ? true : false;
> +		return pclk <= dispc.feat->max_tv_pclk;
>  }
>  
>  bool dispc_mgr_timings_ok(enum omap_channel channel,
