From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:42:15 +0000
Subject: Re: [PATCH 1/4] video: fbdev: remove set but not used variable 'hSyncPol'
Message-Id: <f05e964b-2a4c-1fc4-b0f4-16c3e6d1ec34@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200119121730.10701-1-yukuai3@huawei.com>
 <CGME20200119121831eucas1p2da620aa87a0fdcc73e6a9db46a3e8243@eucas1p2.samsung.com>
 <20200119121730.10701-2-yukuai3@huawei.com>
In-Reply-To: <20200119121730.10701-2-yukuai3@huawei.com>
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
> drivers/video/fbdev/aty/radeon_base.c:1653:6: warning: variable
> ‘hSyncPol’ set but not used [-Wunused-but-set-variable]
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
> index 3af00e3b965e..d2e68ec580c2 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -1650,7 +1650,7 @@ static int radeonfb_set_par(struct fb_info *info)
>  	struct fb_var_screeninfo *mode = &info->var;
>  	struct radeon_regs *newmode;
>  	int hTotal, vTotal, hSyncStart, hSyncEnd,
> -	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
> +	    vSyncStart, vSyncEnd, vSyncPol, cSync;
>  	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
>  	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
>  	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
> @@ -1730,7 +1730,6 @@ static int radeonfb_set_par(struct fb_info *info)
>  	else if (vsync_wid > 0x1f)	/* max */
>  		vsync_wid = 0x1f;
>  
> -	hSyncPol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
>  	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
>  
>  	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
> 
