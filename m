From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 15 Aug 2011 17:31:27 +0000
Subject: Re: [PATCH] video/atmel_lcdfb: Fix build failure/typo for avr32 defconfig
Message-Id: <201108151931.27607.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313429190-29275-1-git-send-email-peterhuewe@gmx.de>
In-Reply-To: <1313429190-29275-1-git-send-email-peterhuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <peterhuewe@gmx.de>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Peter,

On Monday 15 August 2011 19:26:30 Peter Huewe wrote:
> This patch fixes a typo which causes this build failure for the
> avr32 defconfig:
> 
> drivers/video/atmel_lcdfb.c:63: error: request for member 'xres_virtual'
> in something not a structure or union
> make[3]: *** [drivers/video/atmel_lcdfb.o] Error 1
> 
> The typo was introduced by 895607ec
> "atmel_lcdfb: use display information in info not in var for panning"
> 
> KernelVersion: Linux-next 20110812
> The typo was introduced through the fbdev tree.

Thanks for the patch. I've already submitted the same patch 
(https://patchwork.kernel.org/patch/990792/) nearly a month ago to the linux-
fbdev mailing list. Paul, can you please pick it up ?

> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> ---
> So much for compile testing... ;)
> 
>  drivers/video/atmel_lcdfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 77153c6..63409c1 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -60,7 +60,7 @@ static void atmel_lcdfb_update_dma2d(struct
> atmel_lcdfb_info *sinfo,
> 
>  	pixeloff = (var->xoffset * info->var.bits_per_pixel) & 0x1f;
> 
> -	dma2dcfg = (info-var.xres_virtual - info->var.xres)
> +	dma2dcfg = (info->var.xres_virtual - info->var.xres)
>  		 * info->var.bits_per_pixel / 8;
>  	dma2dcfg |= pixeloff << ATMEL_LCDC_PIXELOFF_OFFSET;
>  	lcdc_writel(sinfo, ATMEL_LCDC_DMA2DCFG, dma2dcfg);

-- 
Regards,

Laurent Pinchart
