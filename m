From: Shawn Guo <shawn.guo@freescale.com>
Date: Fri, 18 Feb 2011 12:29:47 +0000
Subject: Re: [PATCH 1/2] video: Add i.MX23/28 framebuffer driver
Message-Id: <20110218122946.GF18085@S2100-06.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297850199-1688-1-git-send-email-s.hauer@pengutronix.de>
	<1297850199-1688-2-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1297850199-1688-2-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 16, 2011 at 10:56:38AM +0100, Sascha Hauer wrote:
> changes since v1:
> - Add a LCDC_ prefix to the register names.
> - use set/clear registers where appropriate
> - protect call to mxsfb_disable_controller() in mxsfb_remove()
>   with a (host->enabled) as suggested by Lothar Wassmann
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/fb.h |   48 ++
>  drivers/video/Kconfig               |    9 +
>  drivers/video/Makefile              |    1 +
>  drivers/video/mxsfb.c               |  910 +++++++++++++++++++++++++++++++++++
>  4 files changed, 968 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/include/mach/fb.h
>  create mode 100644 drivers/video/mxsfb.c
> 
> diff --git a/arch/arm/mach-mxs/include/mach/fb.h b/arch/arm/mach-mxs/include/mach/fb.h
> new file mode 100644
> index 0000000..923f397
> --- /dev/null
> +++ b/arch/arm/mach-mxs/include/mach/fb.h
> @@ -0,0 +1,48 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> + * MA 02110-1301, USA.
> + */
> +
> +#ifndef __MACH_FB_H
> +#define __MACH_FB_H
> +
> +#include <linux/fb.h>
> +
> +#define STMLCDIF_8BIT 1	/** pixel data bus to the display is of 8 bit width */
> +#define STMLCDIF_16BIT 0 /** pixel data bus to the display is of 16 bit width */
> +#define STMLCDIF_18BIT 2 /** pixel data bus to the display is of 18 bit width */
> +#define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
> +
> +#define FB_SYNC_DATA_ENABLE_HIGH_ACT	64
> +
> +struct mxsfb_platform_data {
> +	struct fb_videomode *mode_list;
> +	unsigned mode_count;
> +
> +	unsigned default_bpp;
> +
> +	unsigned dotclk_delay;	/* refer manual HW_LCDIF_VDCTRL4 register */
> +	unsigned ld_intf_width;	/* refer STMLCDIF_* macros */
> +
> +	unsigned fb_size;	/* Size of the video memory. If zero a
> +				 * default will be used
> +				 */
> +	unsigned long fb_phys;	/* physical address for the video memory. If
> +				 * zero the framebuffer memory will be dynamically
> +				 * allocated. If specified,fb_size must also be specified.
> +				 * fb_phys must be unused by Linux.
> +				 */
> +};
> +
> +#endif /* __MACH_FB_H */
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 6bafb51b..e0ea23f 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2365,6 +2365,15 @@ config FB_JZ4740
>  	help
>  	  Framebuffer support for the JZ4740 SoC.
>  
> +config FB_MXS
> +	tristate "MXS LCD framebuffer support"
> +	depends on FB && ARCH_MXS
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	help
> +	  Framebuffer support for the MXS SoC.
> +
>  source "drivers/video/omap/Kconfig"
>  source "drivers/video/omap2/Kconfig"
>  
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 8c8fabd..9a096ae 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -153,6 +153,7 @@ obj-$(CONFIG_FB_BFIN_T350MCQB)	  += bfin-t350mcqb-fb.o
>  obj-$(CONFIG_FB_BFIN_7393)        += bfin_adv7393fb.o
>  obj-$(CONFIG_FB_MX3)		  += mx3fb.o
>  obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
> +obj-$(CONFIG_FB_MXS)		  += mxsfb.o
>  
>  # the test framebuffer is last
>  obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> new file mode 100644
> index 0000000..ac9939b
> --- /dev/null
> +++ b/drivers/video/mxsfb.c
> @@ -0,0 +1,910 @@
> +/*
> + * Copyright (C) 2010 Juergen Beisert, Pengutronix
> + *
> + * This code is based on:
> + * Author: Vitaly Wool <vital@embeddedalley.com>
> + *
> + * Copyright 2008-2009 Freescale Semiconductor, Inc. All Rights Reserved.
> + * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#define DRIVER_NAME "mxsfb"
> +
> +/**
> + * @file
> + * @brief LCDIF driver for i.MX23 and i.MX28
> + *
> + * The LCDIF support four modes of operation
> + * - MPU interface (to drive smart displays) -> not supported yet
> + * - VSYNC interface (like MPU interface plus Vsync) -> not supported yet
> + * - Dotclock interface (to drive LC displays with RGB data and sync signals)
> + * - DVI (to drive ITU-R BT656)  -> not supported yet
> + *
> + * This driver depends on a correct setup of the pins used for this purpose
> + * (platform specific).
> + *
> + * For the developer: Don't forget to set the data bus width to the display
> + * in the imx_fb_videomode structure. You will else end up with ugly colours.
> + * If you fight against jitter you can vary the clock delay. This is a feature
> + * of the i.MX28 and you can vary it between 2 ns ... 8 ns in 2 ns steps. Give
> + * the required value in the imx_fb_videomode structure.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <mach/fb.h>
> +#include <mach/hardware.h>
> +#include <mach/mxs.h>
> +
> +#define REG_SET	4
> +#define REG_CLR	8
> +
We already have these defined in mxs.h
 
-- 
Regards,
Shawn

