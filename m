From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 10 Jul 2020 17:35:33 +0000
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: BACKLIGHT CLASS/SUBSYSTEM
Message-Id: <20200710173533.GD17565@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200708163847.15250-1-grandmaster@al2klimov.de>
In-Reply-To: <20200708163847.15250-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: daniel.thompson@linaro.org, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org

Hi Alexander.

On Wed, Jul 08, 2020 at 06:38:47PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  drivers/video/backlight/led_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> index 3f66549997c8..2c48957e9b60 100644
> --- a/drivers/video/backlight/led_bl.c
> +++ b/drivers/video/backlight/led_bl.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
> + * Copyright (C) 2015-2019 Texas Instruments Incorporated -  https://www.ti.com/
>   * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
>   *
>   * Based on pwm_bl.c

$grep http drivers/video/backlight/*
drivers/video/backlight/cr_bllcd.c: * Intel funded Tungsten Graphics (http://www.tungstengraphics.com) to
drivers/video/backlight/ili9320.c: *	http://armlinux.simtec.co.uk/
drivers/video/backlight/ili9320.h: * http://armlinux.simtec.co.uk/
drivers/video/backlight/led_bl.c: * Copyright (C) 2015-2019 Texas Instruments Incorporated -  http://www.ti.com/
drivers/video/backlight/vgg2432a4.c: *	http://armlinux.simtec.co.uk/

Why are they not covered?

	Sam


> -- 
> 2.27.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
