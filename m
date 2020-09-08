From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:46 +0000
Subject: Re: [PATCH] video: fbdev: remove set but not used 'ulBestVCO'
Message-Id: <8b15618f-eaf5-e646-2655-939d8b456b27@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200827130039eucas1p124a0c2d9912f55281386c9318013a17a@eucas1p1.samsung.com>
 <20200827130008.428706-1-yanaijie@huawei.com>
In-Reply-To: <20200827130008.428706-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jason Yan <yanaijie@huawei.com>
Cc: Hulk Robot <hulkci@huawei.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/27/20 3:00 PM, Jason Yan wrote:
> This addresses the following gcc warning with "make W=1":
> 
> drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
> ‘ProgramClock’:
> drivers/video/fbdev/kyro/STG4000InitDevice.c:123:6: warning: variable
> ‘ulBestVCO’ set but not used [-Wunused-but-set-variable]
>   123 |  u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
>       |      ^~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/kyro/STG4000InitDevice.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> index edaeec2d9590..21875d3c2dc2 100644
> --- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> @@ -120,7 +120,7 @@ u32 ProgramClock(u32 refClock,
>  {
>  	u32 R = 0, F = 0, OD = 0, ODIndex = 0;
>  	u32 ulBestR = 0, ulBestF = 0, ulBestOD = 0;
> -	u32 ulBestVCO = 0, ulBestClk = 0, ulBestScore = 0;
> +	u32 ulBestClk = 0, ulBestScore = 0;
>  	u32 ulScore, ulPhaseScore, ulVcoScore;
>  	u32 ulTmp = 0, ulVCO;
>  	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
> @@ -189,7 +189,6 @@ u32 ProgramClock(u32 refClock,
>  						ulScore = ulPhaseScore + ulVcoScore;
>  
>  						if (!ulBestScore) {
> -							ulBestVCO = ulVCO;
>  							ulBestOD = OD;
>  							ulBestF = F;
>  							ulBestR = R;
> @@ -206,7 +205,6 @@ u32 ProgramClock(u32 refClock,
>                            but we shall keep this code in case new restrictions come into play
>                            --------------------------------------------------------------------------*/
>  						if ((ulScore >= ulBestScore) && (OD > 0)) {
> -							ulBestVCO = ulVCO;
>  							ulBestOD = OD;
>  							ulBestF = F;
>  							ulBestR = R;
> 
