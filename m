From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Feb 2011 10:40:03 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_lcdc: Add YUV input support
Message-Id: <Pine.LNX.4.64.1102231132030.10099@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1298456210-26519-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 23 Feb 2011, Damian Hobson-Garcia wrote:

> Supports YCbCr420sp, YCbCr422sp, and YCbCr44sp, formats (bpp = 12, 16, and 24)
> respectively.
> Set .nonstd = SH_FB_YUV to enable YUV mode, and use bpp to distiguish between
> the 3 modes.
> Due to the encoding of YUV data, the framebuffer will clear to green instead of black.
> 
> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> ---
>  drivers/video/sh_mobile_lcdcfb.c |  142 ++++++++++++++++++++++++++++++--------
>  drivers/video/sh_mobile_lcdcfb.h |    2 +-
>  include/linux/sh_mobile_fb.h     |   14 ++++
>  include/video/sh_mobile_lcdc.h   |    1 +
>  4 files changed, 130 insertions(+), 29 deletions(-)
>  create mode 100644 include/linux/sh_mobile_fb.h
> 

[snip]

> diff --git a/include/linux/sh_mobile_fb.h b/include/linux/sh_mobile_fb.h
> new file mode 100644
> index 0000000..ec448bc
> --- /dev/null
> +++ b/include/linux/sh_mobile_fb.h
> @@ -0,0 +1,14 @@
> +/*
> + * SH-Mobile High-Definition Multimedia Interface (HDMI)
> + *
> + * Copyright (C) 2011, Damian Hobson-Garciax <dhobsong@igel.co.jp>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef SH_MOBILE_FB_H
> +#define SH_MOBILE_FB_H
> +
> +#define SH_FB_YUV	0x1
> +#endif /* SH_MOBILE_FB_H */
> diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
> index daabae5..650ff17 100644
> --- a/include/video/sh_mobile_lcdc.h
> +++ b/include/video/sh_mobile_lcdc.h
> @@ -77,6 +77,7 @@ struct sh_mobile_lcdc_chan_cfg {
>  	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
>  	struct sh_mobile_lcdc_board_cfg board_cfg;
>  	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
> +	int nonstd;
>  };
>  
>  struct sh_mobile_lcdc_info {
> -- 
> 1.7.1

Can't the SH_FB_YUV macro definition go into 
include/video/sh_mobile_lcdc.h too?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
