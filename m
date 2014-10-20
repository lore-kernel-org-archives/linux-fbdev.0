From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 20 Oct 2014 12:21:02 +0000
Subject: Re: [PATCH] drivers: video: fbdev: atmel_lcdfb.c: remove unnecessary header
Message-Id: <5444FE2E.6030509@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413548355-499-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1413548355-499-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 17/10/2014 14:19, Alexandre Belloni :
> Remove unnecessary mach/cpu.h header to be able to converge to a multiplatform
> kernel.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks.

Tomi, can you take it?

Bye,

> ---
>  drivers/video/fbdev/atmel_lcdfb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 1d8bdb92939b..ea45a30fd4d2 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -26,7 +26,6 @@
>  #include <video/of_display_timing.h>
>  #include <video/videomode.h>
>  
> -#include <mach/cpu.h>
>  #include <asm/gpio.h>
>  
>  #include <video/atmel_lcdc.h>
> 


-- 
Nicolas Ferre
