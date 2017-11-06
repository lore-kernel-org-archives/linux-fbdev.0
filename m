From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 06 Nov 2017 09:12:11 +0000
Subject: Re: [Intel-gfx] [PATCH v5 2/7] drm: Add panel orientation quirks
Message-Id: <20171106091211.ics6gjtimanwkxte@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171104140828.32469-1-hdegoede@redhat.com>
 <20171104140828.32469-3-hdegoede@redhat.com>
In-Reply-To: <20171104140828.32469-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, intel-gfx <intel-gfx@lists.freedesktop.org>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>, Robert McQueen <robert@endlessm.com>, Carlo Caione <carlo@endlessm.com>

On Sat, Nov 04, 2017 at 03:08:23PM +0100, Hans de Goede wrote:
> Some x86 clamshell design devices use portrait tablet screens and a display
> engine which cannot rotate in hardware, so the firmware just leaves things
> as is and we cannot figure out that the display is oriented non upright
> from the hardware.
> 
> So at least on x86, we need a quirk table for this. This commit adds a DMI
> based quirk table which is initially populated with 5 such devices: Asus
> T100HA, GPD Pocket, GPD win, I.T.Works TW891 and the VIOS LTH17.
> 
> This quirk table will be used by the drm code to let userspace know that
> the display is not mounted upright inside the devices case through a new
> panel orientation drm-connector property, as well as to tell fbcon to
> rotate the console so that it shows the right way up.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v5:
> -Add a kernel-doc comment documenting drm_get_panel_orientation_quirk()

The kerneldoc isn't much use without pulling it into the overall
structure. Documentation/gpu/drm-kms-helper.rst seems like a suitable
place. Pls also check it builds correctly and looks pretty using

$ make htmldocs

With that fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> -Remove board_* matches from the dmi-matches for the VIOS LTH17 laptop,
>  keeping only the (identical) sys_vendor and product_name matches.
>  This is necessary because an older version of the bios has
>  board_vendor set to VOIS instead of VIOS
> ---
>  drivers/gpu/drm/Kconfig                        |   3 +
>  drivers/gpu/drm/Makefile                       |   1 +
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 174 +++++++++++++++++++++++++
>  include/drm/drm_utils.h                        |  18 +++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_panel_orientation_quirks.c
>  create mode 100644 include/drm/drm_utils.h
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 4d9f21831741..9d005ac98c2b 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -26,6 +26,9 @@ config DRM_MIPI_DSI
>  	bool
>  	depends on DRM
>  
> +config DRM_PANEL_ORIENTATION_QUIRKS
> +	tristate
> +
>  config DRM_DP_AUX_CHARDEV
>  	bool "DRM DP AUX Interface"
>  	depends on DRM
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index a3fdc5a68dff..ffb621819bbf 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -46,6 +46,7 @@ obj-$(CONFIG_DRM_DEBUG_MM_SELFTEST) += selftests/
>  
>  obj-$(CONFIG_DRM)	+= drm.o
>  obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
> +obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
>  obj-$(CONFIG_DRM_ARM)	+= arm/
>  obj-$(CONFIG_DRM_TTM)	+= ttm/
>  obj-$(CONFIG_DRM_TDFX)	+= tdfx/
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> new file mode 100644
> index 000000000000..b8765e2ed1d6
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -0,0 +1,174 @@
> +/*
> + *  drm_panel_orientation_quirks.c -- Quirks for non-normal panel orientation
> + *
> + *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + *  This file is subject to the terms and conditions of the GNU General Public
> + *  License.  See the file COPYING in the main directory of this archive for
> + *  more details.
> + */
> +
> +#include <linux/dmi.h>
> +#include <drm/drm_connector.h>
> +
> +#ifdef CONFIG_DMI
> +
> +/*
> + * Some x86 clamshell design devices use portrait tablet screens and a display
> + * engine which cannot rotate in hardware, so we need to rotate the fbcon to
> + * compensate. Unfortunately these (cheap) devices also typically have quite
> + * generic DMI data, so we match on a combination of DMI data, screen resolution
> + * and a list of known BIOS dates to avoid false positives.
> + */
> +
> +struct drm_dmi_panel_orientation_data {
> +	int width;
> +	int height;
> +	const char * const *bios_dates;
> +	int orientation;
> +};
> +
> +static const struct drm_dmi_panel_orientation_data asus_t100ha = {
> +	.width = 800,
> +	.height = 1280,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
> +};
> +
> +static const struct drm_dmi_panel_orientation_data gpd_pocket = {
> +	.width = 1200,
> +	.height = 1920,
> +	.bios_dates = (const char * const []){ "05/26/2017", "06/28/2017",
> +		"07/05/2017", "08/07/2017", NULL },
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
> +static const struct drm_dmi_panel_orientation_data gpd_win = {
> +	.width = 720,
> +	.height = 1280,
> +	.bios_dates = (const char * const []){
> +		"10/25/2016", "11/18/2016", "12/23/2016", "12/26/2016",
> +		"02/21/2017", "03/20/2017", "05/25/2017", NULL },
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
> +static const struct drm_dmi_panel_orientation_data itworks_tw891 = {
> +	.width = 800,
> +	.height = 1280,
> +	.bios_dates = (const char * const []){ "10/16/2015", NULL },
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
> +static const struct drm_dmi_panel_orientation_data vios_lth17 = {
> +	.width = 800,
> +	.height = 1280,
> +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> +};
> +
> +static const struct dmi_system_id orientation_data[] = {
> +	{	/* Asus T100HA */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100HAN"),
> +		},
> +		.driver_data = (void *)&asus_t100ha,
> +	}, {	/*
> +		 * GPD Pocket, note that the the DMI data is less generic then
> +		 * it seems, devices with a board-vendor of "AMI Corporation"
> +		 * are quite rare, as are devices which have both board- *and*
> +		 * product-id set to "Default String"
> +		 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		},
> +		.driver_data = (void *)&gpd_pocket,
> +	}, {	/* GPD Win (same note on DMI match as GPD Pocket) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		},
> +		.driver_data = (void *)&gpd_win,
> +	}, {	/* I.T.Works TW891 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "TW891"),
> +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
> +		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "TW891"),
> +		},
> +		.driver_data = (void *)&itworks_tw891,
> +	}, {	/* VIOS LTH17 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "VIOS"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
> +		},
> +		.driver_data = (void *)&vios_lth17,
> +	},
> +	{}
> +};
> +
> +/**
> + * drm_get_panel_orientation_quirk - Check for panel orientation quirks
> + * @width: width in pixels of the panel
> + * @height: height in pixels of the panel
> + *
> + * This function checks for platform specific (e.g. DMI based) quirks
> + * providing info on panel_orientation for systems where this cannot be
> + * probed from the hard-/firm-ware. To avoid false-positive this function
> + * takes the panel resolution as argument and checks that against the
> + * resolution expected by the quirk-table entry.
> + *
> + * Note this function is also used outside of the drm-subsys, by for example
> + * the efifb code. Because of this this function gets compiled into its own
> + * kernel-module when built as a module.
> + *
> + * Returns:
> + * A DRM_MODE_PANEL_ORIENTATION_* value if there is a quirk for this system,
> + * or DRM_MODE_PANEL_ORIENTATION_UNKNOWN if there is no quirk.
> + */
> +int drm_get_panel_orientation_quirk(int width, int height)
> +{
> +	const struct dmi_system_id *match;
> +	const struct drm_dmi_panel_orientation_data *data;
> +	const char *bios_date;
> +	int i;
> +
> +	for (match = dmi_first_match(orientation_data);
> +	     match;
> +	     match = dmi_first_match(match + 1)) {
> +		data = match->driver_data;
> +
> +		if (data->width != width ||
> +		    data->height != height)
> +			continue;
> +
> +		if (!data->bios_dates)
> +			return data->orientation;
> +
> +		bios_date = dmi_get_system_info(DMI_BIOS_DATE);
> +		if (!bios_date)
> +			continue;
> +
> +		for (i = 0; data->bios_dates[i]; i++) {
> +			if (!strcmp(data->bios_dates[i], bios_date))
> +				return data->orientation;
> +		}
> +	}
> +
> +	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +}
> +EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
> +
> +#else
> +
> +/* There are no quirks for non x86 devices yet */
> +int drm_get_panel_orientation_quirk(int width, int height)
> +{
> +	return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +}
> +EXPORT_SYMBOL(drm_get_panel_orientation_quirk);
> +
> +#endif
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> new file mode 100644
> index 000000000000..cea362aeaffe
> --- /dev/null
> +++ b/include/drm/drm_utils.h
> @@ -0,0 +1,18 @@
> +/*
> + * Function prototypes for misc. drm utility functions.
> + * Specifically this file is for function prototypes for functions which
> + * may also be used outside of drm code (e.g. in fbdev drivers).
> + *
> + * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __DRM_UTILS_H__
> +#define __DRM_UTILS_H__
> +
> +int drm_get_panel_orientation_quirk(int width, int height);
> +
> +#endif
> -- 
> 2.14.3
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
