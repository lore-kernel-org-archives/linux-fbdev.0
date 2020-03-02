From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 02 Mar 2020 15:42:34 +0000
Subject: Re: [PATCH] video: remove set but not used variable 'ulScaleRight'
Message-Id: <0b16ece5-a95c-5420-b5d4-7c576171780f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200119122043eucas1p2b450cd177ca0d86d268323a074c82b05@eucas1p2.samsung.com>
 <20200119121945.12517-1-yukuai3@huawei.com>
In-Reply-To: <20200119121945.12517-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: yu kuai <yukuai3@huawei.com>
Cc: zhengbin13@huawei.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, yi.zhang@huawei.com


On 1/19/20 1:19 PM, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/video/fbdev/kyro/STG4000OverlayDevice.c: In function
> ‘SetOverlayViewPort’:
> drivers/video/fbdev/kyro/STG4000OverlayDevice.c:334:19: warning:
> variable ‘ulScaleRight’ set but not used [-Wunused-but-set-variable]
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
>  drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
> index 0aeeaa10708b..9fde0e3b69ec 100644
> --- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
> @@ -331,7 +331,7 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
>  	u32 ulScale;
>  	u32 ulLeft, ulRight;
>  	u32 ulSrcLeft, ulSrcRight;
> -	u32 ulScaleLeft, ulScaleRight;
> +	u32 ulScaleLeft;
>  	u32 ulhDecim;
>  	u32 ulsVal;
>  	u32 ulVertDecFactor;
> @@ -470,7 +470,6 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
>  		 * round down the pixel pos to the nearest 8 pixels.
>  		 */
>  		ulScaleLeft = ulSrcLeft;
> -		ulScaleRight = ulSrcRight;
>  
>  		/* shift fxscale until it is in the range of the scaler */
>  		ulhDecim = 0;
> 
