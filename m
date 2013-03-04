From: Tony Lindgren <tony@atomide.com>
Date: Mon, 04 Mar 2013 22:39:13 +0000
Subject: Re: [PATCH 2/2] omapfb: fix broken build on Amstrad E3/Delta
Message-Id: <20130304223911.GZ11806@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1362431000-15141-1-git-send-email-aaro.koskinen@iki.fi>
 <1362431000-15141-2-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1362431000-15141-2-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

* Aaro Koskinen <aaro.koskinen@iki.fi> [130304 13:08]:
> Fix the following build regression in 3.9-rc1 by including
> <machine/hardware.h>:
> 
> drivers/video/omap/lcd_ams_delta.c: In function 'ams_delta_lcd_set_power':
> drivers/video/omap/lcd_ams_delta.c:48:4: error: implicit declaration of function 'omap_writeb' [-Werror=implicit-function-declaration]
> drivers/video/omap/lcd_ams_delta.c:49:6: error: 'OMAP_PWL_ENABLE' undeclared (first use in this function)
> drivers/video/omap/lcd_ams_delta.c:49:6: note: each undeclared identifier is reported only once for each function it appears in
> drivers/video/omap/lcd_ams_delta.c:50:19: error: 'OMAP_PWL_CLK_ENABLE' undeclared (first use in this function)
> drivers/video/omap/lcd_ams_delta.c: In function 'ams_delta_lcd_set_contrast':
> drivers/video/omap/lcd_ams_delta.c:66:22: error: 'OMAP_PWL_ENABLE' undeclared (first use in this function)

I have this already queued up in omap-for-v3.9-rc1/fixes as 0adcbaf78
(ARM: OMAP1: Fix build related to kgdb.h no longer including serial_8250.h)
and for lcd_osk.c as omap1_defconfig was broken.

I don't anything for the first patch you posted, so I suggest
Tomi applies that one.

Regards,

Tony


 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/video/omap/lcd_ams_delta.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
> index ed4cad8..4a5f2cd 100644
> --- a/drivers/video/omap/lcd_ams_delta.c
> +++ b/drivers/video/omap/lcd_ams_delta.c
> @@ -27,6 +27,7 @@
>  #include <linux/lcd.h>
>  #include <linux/gpio.h>
>  
> +#include <mach/hardware.h>
>  #include <mach/board-ams-delta.h>
>  
>  #include "omapfb.h"
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
