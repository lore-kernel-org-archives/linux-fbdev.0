From: Tony Lindgren <tony@atomide.com>
Date: Mon, 04 Oct 2010 17:54:29 +0000
Subject: Re: [PATCH] video/omap: remove duplicated include
Message-Id: <20101004175429.GW3117@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101004174344.21577085@absol.kitzblitz>
In-Reply-To: <20101004174344.21577085@absol.kitzblitz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Kaiser <nikai@nikai.net>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

* Nicolas Kaiser <nikai@nikai.net> [101004 08:35]:
> Remove duplicated include.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---
>  drivers/video/omap/lcd_omap3beagle.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
> index ca75cc2..ac715f9 100644
> --- a/drivers/video/omap/lcd_omap3beagle.c
> +++ b/drivers/video/omap/lcd_omap3beagle.c
> @@ -26,7 +26,6 @@
>  #include <linux/i2c/twl.h>
>  
>  #include <plat/mux.h>
> -#include <plat/mux.h>
>  #include <asm/mach-types.h>
>  
>  #include "omapfb.h"

Can you please updated this to remove both mux.h entries?

Including mux.h should no longer be needed for omap2/3/4 SoCs
outside arch/arm/mach-omap2 files. For omap1 machines those are still
needed in some drivers..

Regards,

Tony
