From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Nov 2012 08:46:57 +0000
Subject: Re: [PATCH 11/24] MAINTAINERS: fix .../plat-mxc/include/mach/imxfb.h
Message-Id: <20121126084657.GY10369@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
 <1353716808-16375-12-git-send-email-cesarb@cesarb.net>
In-Reply-To: <1353716808-16375-12-git-send-email-cesarb@cesarb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Nov 23, 2012 at 10:26:35PM -0200, Cesar Eduardo Barros wrote:
> This file was moved to include/linux/platform_data/video-imxfb.h by
> commit 82906b1 (ARM: imx: move platform_data definitions).
> 
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a67a67a..887d717 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3137,7 +3137,7 @@ M:	Sascha Hauer <kernel@pengutronix.de>
>  L:	linux-fbdev@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -F:	arch/arm/plat-mxc/include/mach/imxfb.h
> +F:	include/linux/platform_data/video-imxfb.h
>  F:	drivers/video/imxfb.c
>  
>  FREESCALE SOC FS_ENET DRIVER
> -- 
> 1.7.11.7
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
