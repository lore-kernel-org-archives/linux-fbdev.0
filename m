From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:02 +0000
Subject: Re: [PATCH] video: fbdev: sis: fix null ptr dereference
Message-Id: <2b8139d8-12c9-3685-9160-fc92ae08aac0@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200805145226eucas1p1e0e6d9fa3c05f7e247365f0db17cbe38@eucas1p1.samsung.com>
 <20200805145208.17727-1-trix@redhat.com>
In-Reply-To: <20200805145208.17727-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trix@redhat.com
Cc: akpm@osdl.org, linux-fbdev@vger.kernel.org, thomas@winischhofer.net, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/5/20 4:52 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this representative error
> 
> init.c:2501:18: warning: Array access (from variable 'queuedata') results
>   in a null pointer dereference
>       templ |= ((queuedata[i] & 0xc0) << 3);
> 
> This is the problem block of code
> 
>    if(ModeNo > 0x13) {
>       ...
>       if(SiS_Pr->ChipType = SIS_730) {
> 	 queuedata = &FQBQData730[0];
>       } else {
> 	 queuedata = &FQBQData[0];
>       }
>    } else {
> 
>    }
> 
> queuedata is not set in the else block
> 
> Reviewing the old code, the arrays FQBQData730 and FQBQData were
> used directly.
> 
> So hoist the setting of queuedata out of the if-else block.
> 
> Fixes: 544393fe584d ("[PATCH] sisfb update")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sis/init.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
> index dfe3eb769638..fde27feae5d0 100644
> --- a/drivers/video/fbdev/sis/init.c
> +++ b/drivers/video/fbdev/sis/init.c
> @@ -2428,6 +2428,11 @@ SiS_SetCRT1FIFO_630(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
>  
>     i = 0;
>  
> +	if (SiS_Pr->ChipType = SIS_730)
> +		queuedata = &FQBQData730[0];
> +	else
> +		queuedata = &FQBQData[0];
> +
>     if(ModeNo > 0x13) {
>  
>        /* Get VCLK  */
> @@ -2445,12 +2450,6 @@ SiS_SetCRT1FIFO_630(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
>        /* Get half colordepth */
>        colorth = colortharray[(SiS_Pr->SiS_ModeType - ModeEGA)];
>  
> -      if(SiS_Pr->ChipType = SIS_730) {
> -	 queuedata = &FQBQData730[0];
> -      } else {
> -	 queuedata = &FQBQData[0];
> -      }
> -
>        do {
>  	 templ = SiS_CalcDelay2(SiS_Pr, queuedata[i]) * VCLK * colorth;
>  
> 
