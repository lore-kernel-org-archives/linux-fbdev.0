From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:49 +0000
Subject: Re: [PATCH] video: fbdev: remove set but not used 'ulCoreClock'
Message-Id: <7d8571f5-7f26-2507-291c-8a66ac3744bd@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200827130059eucas1p21c6e4789266a0db0890e20ebdca8c530@eucas1p2.samsung.com>
 <20200827130028.428893-1-yanaijie@huawei.com>
In-Reply-To: <20200827130028.428893-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jason Yan <yanaijie@huawei.com>
Cc: Hulk Robot <hulkci@huawei.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/27/20 3:00 PM, Jason Yan wrote:
> This addresses the following gcc warning with "make W=1":
> 
> drivers/video/fbdev/kyro/STG4000InitDevice.c: In function
> ‘SetCoreClockPLL’:
> drivers/video/fbdev/kyro/STG4000InitDevice.c:247:6: warning: variable
> ‘ulCoreClock’ set but not used [-Wunused-but-set-variable] // yanaijie
> fixed
>   247 |  u32 ulCoreClock;
>       |      ^~~~~~~~~~~
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
>  drivers/video/fbdev/kyro/STG4000InitDevice.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> index 1d3f2080aa6f..edaeec2d9590 100644
> --- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> @@ -244,7 +244,6 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
>  {
>  	u32 F, R, P;
>  	u16 core_pll = 0, sub;
> -	u32 ulCoreClock;
>  	u32 tmp;
>  	u32 ulChipSpeed;
>  
> @@ -282,7 +281,7 @@ int SetCoreClockPLL(volatile STG4000REG __iomem *pSTGReg, struct pci_dev *pDev)
>  	if (ulChipSpeed = 0)
>  		return -EINVAL;
>  
> -	ulCoreClock = ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
> +	ProgramClock(REF_FREQ, CORE_PLL_FREQ, &F, &R, &P);
>  
>  	core_pll |= ((P) | ((F - 2) << 2) | ((R - 2) << 11));
>  
