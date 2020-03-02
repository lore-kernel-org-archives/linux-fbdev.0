From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:42:30 +0000
Subject: Re: [PATCH 4/4] video: fbdev: remove set but not used variable 'bytpp'
Message-Id: <e060e0a0-1861-20f0-d1ef-6a8137949659@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200119121730.10701-1-yukuai3@huawei.com>
 <CGME20200119121831eucas1p19d7d048f980db055edf2eb15d5e82253@eucas1p1.samsung.com>
 <20200119121730.10701-5-yukuai3@huawei.com>
In-Reply-To: <20200119121730.10701-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: yu kuai <yukuai3@huawei.com>
Cc: linux-fbdev@vger.kernel.org, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zhengbin13@huawei.com


On 1/19/20 1:17 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/aty/radeon_base.c: In function
> ‘radeonfb_set_par’:
> drivers/video/fbdev/aty/radeon_base.c:1660:32: warning:
> variable ‘bytpp’ set but not used [-Wunused-but-set-variable]
> 
> It is never used, and so can be removed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>

Patch queued for v5.7, thanks.
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/aty/radeon_base.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
> index 7d2ee889ffcd..22b3ee4f2ffa 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -1657,7 +1657,7 @@ static int radeonfb_set_par(struct fb_info *info)
>  	int i, freq;
>  	int format = 0;
>  	int nopllcalc = 0;
> -	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
> +	int hsync_start, hsync_fudge, hsync_wid, vsync_wid;
>  	int primary_mon = PRIMARY_MONITOR(rinfo);
>  	int depth = var_to_depth(mode);
>  	int use_rmx = 0;
> @@ -1731,7 +1731,6 @@ static int radeonfb_set_par(struct fb_info *info)
>  		vsync_wid = 0x1f;
>  
>  	format = radeon_get_dstbpp(depth);
> -	bytpp = mode->bits_per_pixel >> 3;
>  
>  	if ((primary_mon = MT_DFP) || (primary_mon = MT_LCD))
>  		hsync_fudge = hsync_fudge_fp[format-1];
> 
