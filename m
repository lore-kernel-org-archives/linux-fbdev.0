From: Tony Lindgren <tony@atomide.com>
Date: Mon, 16 Dec 2013 18:46:23 +0000
Subject: Re: [PATCHv2 03/27] ARM: OMAP2+: add omapdss_init_of()
Message-Id: <20131216184623.GC26293@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1387205794-32246-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 07:02]:
> omapdss driver uses a omapdss platform device to pass platform specific
> function pointers and DSS hardware version from the arch code to the
> driver. This device is needed also when booting with DT.
> 
> This patch adds omapdss_init_of() function, called from board-generic at
> init time, which creates the omapdss device.
...

> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -23,6 +23,8 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
>  
>  #include <video/omapdss.h>
>  #include "omap_hwmod.h"
> @@ -514,3 +516,63 @@ int omap_dss_reset(struct omap_hwmod *oh)
>  
>  	return r;
>  }
> +
> +int __init omapdss_init_of(void)
> +{
> +	int r;
> +	enum omapdss_version ver;
> +
> +	static struct omap_dss_board_info board_data = {
> +		.dsi_enable_pads = omap_dsi_enable_pads,
> +		.dsi_disable_pads = omap_dsi_disable_pads,
> +		.get_context_loss_count = omap_pm_get_dev_context_loss_count,
> +		.set_min_bus_tput = omap_dss_set_min_bus_tput,
> +	};
> +
> +	ver = omap_display_get_version();
> +
> +	if (ver = OMAPDSS_VER_UNKNOWN) {
> +		pr_err("DSS not supported on this SoC\n");
> +		return -ENODEV;
> +	}
> +
> +	board_data.version = ver;
> +
> +	omap_display_device.dev.platform_data = &board_data;
> +
> +	r = platform_device_register(&omap_display_device);
> +	if (r < 0) {
> +		pr_err("Unable to register omapdss device\n");
> +		return r;
> +	}

You can populate the callback functions in the pdata using
OF_DEV_AUXDATA entries in the pdata-quirks.c. That way you could
instantiate the dev entry for omap_display_device using DT
and deal with it in drivers/video/omap except for the pdata
callbacks.

Of course that can be done later too.

Regards,

Tony
