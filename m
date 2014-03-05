From: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Date: Wed, 05 Mar 2014 10:01:51 +0000
Subject: Re: [PATCH] fbdev: FB_OPENCORES should depend on HAS_DMA
Message-Id: <20140305100150.GA17085@chokladfabriken.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393012569-22560-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1393012569-22560-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 21, 2014 at 08:56:09PM +0100, Geert Uytterhoeven wrote:
> If NO_DMA=y:
> 
>     drivers/built-in.o: In function `ocfb_remove':
>     ocfb.c:(.text+0x27fee): undefined reference to `dma_free_coherent'
>     drivers/built-in.o: In function `ocfb_probe':
>     ocfb.c:(.text+0x28418): undefined reference to `dma_alloc_coherent'
>     ocfb.c:(.text+0x284d2): undefined reference to `dma_free_coherent'
> 

I obviously had neglected compiling against that configuration,
thanks for the catch.

Acked-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/video/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0192900dd183..fb8d31e717bc 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -982,7 +982,7 @@ config FB_PVR2
>  
>  config FB_OPENCORES
>  	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> -	depends on FB
> +	depends on FB && HAS_DMA
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 1.7.9.5
> 
