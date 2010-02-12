From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 12 Feb 2010 03:18:28 +0000
Subject: Re: [PATCH 01/02] sh: Add wait for vsync
Message-Id: <20100212031827.GA7229@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE0178367F@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE0178367F@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Feb 11, 2010 at 10:23:50AM -0000, Phil Edworthy wrote:
> Added FBIO_WAITFORVSYNC ioctl for SH-Mobile devices. Tested on MS7724 board
> against 2.6.33-rc7
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> --- a/drivers/video/sh_mobile_lcdcfb.c
> +++ b/drivers/video/sh_mobile_lcdcfb.c
> @@ -19,6 +19,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/vmalloc.h>
> +#include <linux/ioctl.h>
>  #include <video/sh_mobile_lcdc.h>
>  #include <asm/atomic.h>
>  
> @@ -40,6 +41,10 @@
>  #define _LDDWAR 0x900
>  #define _LDDRAR 0x904
>  
> +#ifndef FBIO_WAITFORVSYNC
> +#define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
> +#endif
> +
>  /* shared registers and their order for context save/restore */
>  static int lcdc_shared_regs[] = {
>  	_LDDCKR,

The ioctl definition should be placed in include/video/sh_mobile_lcdc.h,
and the ifndef is superfluous.

If the definition is placed in the header then that can be safely
exported to userspace after the header has been sanitized and thrown in
to include/video/Kbuild, which will make sure that the userspace
applications and kernel keep in sync with regards to the ioctl numbering.

> @@ -795,6 +844,8 @@ static struct fb_ops sh_mobile_lcdc_ops 
>  	.fb_copyarea	= sh_mobile_lcdc_copyarea,
>  	.fb_imageblit	= sh_mobile_lcdc_imageblit,
>  	.fb_pan_display = sh_mobile_fb_pan_display,
> +	.fb_ioctl       = sh_mobile_ioctl,
> +	.fb_compat_ioctl = sh_mobile_ioctl
>  };
>  
You shouldn't be touching fb_compat_ioctl here. While for this particular
ioctl it doesn't really matter, accesses to arg have the potential for
being bogus due to not having passed through compat_ptr(). This would be
a nasty surprise for anyone treating arg as a userspace pointer when
adding new ioctls in the future. In any event, as we don't presently
implement a 64-bit ABI the compat bits are never going to be used
anyways, so it's best just to not hook it up at all.

Beyond that, if these patches haven't broken the deferred I/O case, I'll
queue them up for 2.6.34.
