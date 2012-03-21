From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Mar 2012 18:37:20 +0000
Subject: Re: [PATCH 1/7] drivers/video/pvr2fb.c: ensure arguments to request_irq and free_irq are compatible
Message-Id: <4F6A1FE0.8040808@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331494587-12196-1-git-send-email-Julia.Lawall@lip6.fr> <1331494587-12196-2-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1331494587-12196-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/11/2012 07:36 PM, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Convert calls to free_irq so that the second argument is the same as the
> last argument of the corresponding call to request_irq.  Without this
> property, free_irq does nothing.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
> Not tested.
> 
>  drivers/video/pvr2fb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
> index 3a3fdc6..bcd44c3 100644
> --- a/drivers/video/pvr2fb.c
> +++ b/drivers/video/pvr2fb.c
> @@ -895,7 +895,7 @@ static int __init pvr2fb_dc_init(void)
>  
>  #ifdef CONFIG_PVR2_DMA
>  	if (request_dma(pvr2dma, "pvr2") != 0) {
> -		free_irq(HW_EVENT_VSYNC, 0);
> +		free_irq(HW_EVENT_VSYNC, fb_info);
>  		return -EBUSY;
>  	}
>  #endif
> @@ -914,7 +914,7 @@ static void __exit pvr2fb_dc_exit(void)
>  		currentpar->mmio_base = 0;
>  	}
>  
> -	free_irq(HW_EVENT_VSYNC, 0);
> +	free_irq(HW_EVENT_VSYNC, fb_info);
>  #ifdef CONFIG_PVR2_DMA
>  	free_dma(pvr2dma);
>  #endif
> 
> 

