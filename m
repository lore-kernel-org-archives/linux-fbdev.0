From: James Simmons <jsimmons@infradead.org>
Date: Wed, 10 Mar 2010 16:42:14 +0000
Subject: Re: [PATCH] fbdev: bfin-lq035q1-fb: remove duplicated #include
Message-Id: <alpine.LFD.2.00.1003101641490.4419@casper.infradead.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268150659-27335-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1268150659-27335-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Huang Weiyi <weiyi.huang@gmail.com>



> From: Huang Weiyi <weiyi.huang@gmail.com>
> 
> Remove duplicated #include('s) in
>   drivers/video/bfin-lq035q1-fb.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  drivers/video/bfin-lq035q1-fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Acked-by: James Simmons <jsimmons@infradead.org>

> diff --git a/drivers/video/bfin-lq035q1-fb.c b/drivers/video/bfin-lq035q1-fb.c
> index b690c26..0387236 100644
> --- a/drivers/video/bfin-lq035q1-fb.c
> +++ b/drivers/video/bfin-lq035q1-fb.c
> @@ -22,7 +22,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
>  #include <linux/spi/spi.h>
> -#include <linux/dma-mapping.h>
>  
>  #include <asm/blackfin.h>
>  #include <asm/irq.h>
> -- 
> 1.7.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
