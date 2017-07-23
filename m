From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 23 Jul 2017 10:32:22 +0000
Subject: Re: [PATCH v2] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <ba62cb76-6ed9-0d6a-fbc1-13c4053f4263@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706142839.14659-1-hdegoede@redhat.com>
In-Reply-To: <20170706142839.14659-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 21-07-17 10:59, Jean Delvare wrote:
> On Thu, 20 Jul 2017 10:11:17 +0200, Jean Delvare wrote:
>> On Sat, 8 Jul 2017 15:33:09 +0200, Hans de Goede wrote:
>>> On 07-07-17 21:02, Jean Delvare wrote:
>>>> (...)
>>>> "dmi_match" should probably have been named "dmi_field_match" instead,
>>>> maybe it should be renamed to that now for consistency and clarity?
>>>
>>> Yes I think that would be good, but outside of the scope of this patch-set.
>>
>> Of course, I meant it that way. I'll take care of it separately.
> 
> As I was looking into this, I noticed function dmi_first_match(), which
> seems to do what you need. Here's an untested proof-of-concept, what do
> you think?

I already considered using dmi_first_match() but that will not work
because the 2 different GPD devices have identical DMI strings other then
their bios-dates (GRRR). But now that you mention it again on second thought
it will work if one sees it as an iterator function, replacing your:

	match = dmi_first_match(rotate_data);
	if (match) {

With:

         for (match = dmi_first_match(rotate_data);
              match;
              match = dmi_first_match(match + 1)) {

Does work combined with some other minor tweaks, which means we no longer
need to rename + export dmi_matches.

I will send a v4 (current subject wrongly says v2, really was v3) with
this patch.

I've added a:

Suggested-by: Jean Delvare <jdelvare@suse.de>

To the commit message to acknowledge your work on reworking this to
use dmi_first_match.

Regards,

Hans


> 
>   drivers/video/console/Makefile           |    3
>   drivers/video/console/fbcon.c            |   12 ++-
>   drivers/video/console/fbcon.h            |    7 +
>   drivers/video/console/fbcon_dmi_quirks.c |  118 +++++++++++++++++++++++++++++++
>   4 files changed, 136 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/video/console/fbcon_dmi_quirks.c
> 
> --- linux-4.12.orig/drivers/video/console/Makefile	2017-07-20 10:12:31.134464987 +0200
> +++ linux-4.12/drivers/video/console/Makefile	2017-07-20 15:42:56.162341545 +0200
> @@ -15,5 +15,8 @@ ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTAT
>   obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
>                                            fbcon_ccw.o
>   endif
> +ifeq ($(CONFIG_DMI),y)
> +obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_dmi_quirks.o
> +endif
>   
>   obj-$(CONFIG_FB_STI)              += sticore.o
> --- linux-4.12.orig/drivers/video/console/fbcon.c	2017-07-20 10:12:31.134464987 +0200
> +++ linux-4.12/drivers/video/console/fbcon.c	2017-07-20 15:42:56.163341560 +0200
> @@ -135,7 +135,7 @@ static char fontname[40];
>   static int info_idx = -1;
>   
>   /* console rotation */
> -static int initial_rotation;
> +static int initial_rotation = -1;
>   static int fbcon_has_sysfs;
>   
>   static const struct consw fb_con;
> @@ -954,7 +954,10 @@ static const char *fbcon_startup(void)
>   	ops->cur_rotate = -1;
>   	ops->cur_blink_jiffies = HZ / 5;
>   	info->fbcon_par = ops;
> -	p->con_rotate = initial_rotation;
> +	if (initial_rotation != -1)
> +		p->con_rotate = initial_rotation;
> +	else
> +		p->con_rotate = fbcon_platform_get_rotate(info);
>   	set_blitting_type(vc, info);
>   
>   	if (info->fix.type != FB_TYPE_TEXT) {
> @@ -1091,7 +1094,10 @@ static void fbcon_init(struct vc_data *v
>   
>   	ops = info->fbcon_par;
>   	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
> -	p->con_rotate = initial_rotation;
> +	if (initial_rotation != -1)
> +		p->con_rotate = initial_rotation;
> +	else
> +		p->con_rotate = fbcon_platform_get_rotate(info);
>   	set_blitting_type(vc, info);
>   
>   	cols = vc->vc_cols;
> --- linux-4.12.orig/drivers/video/console/fbcon.h	2017-07-20 10:12:31.134464987 +0200
> +++ linux-4.12/drivers/video/console/fbcon.h	2017-07-20 15:42:56.163341560 +0200
> @@ -261,5 +261,10 @@ extern void fbcon_set_rotate(struct fbco
>   #define fbcon_set_rotate(x) do {} while(0)
>   #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
>   
> -#endif /* _VIDEO_FBCON_H */
> +#ifdef CONFIG_DMI
> +int fbcon_platform_get_rotate(struct fb_info *info);
> +#else
> +#define fbcon_platform_get_rotate(i) FB_ROTATE_UR
> +#endif /* CONFIG_DMI */
>   
> +#endif /* _VIDEO_FBCON_H */
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-4.12/drivers/video/console/fbcon_dmi_quirks.c	2017-07-21 10:16:26.095303752 +0200
> @@ -0,0 +1,118 @@
> +/*
> + *  fbcon_dmi_quirks.c -- DMI based quirk detection for fbcon
> + *
> + *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
> + *
> + *  This file is subject to the terms and conditions of the GNU General Public
> + *  License.  See the file COPYING in the main directory of this archive for
> + *  more details.
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/fb.h>
> +#include <linux/kernel.h>
> +#include "fbcon.h"
> +
> +/*
> + * Some x86 clamshell design devices use portrait tablet screens and a display
> + * engine which cannot rotate in hardware, so we need to rotate the fbcon to
> + * compensate. Unfortunately these (cheap) devices also typically have quite
> + * generic DMI data, so we match on a combination of DMI data, screen resolution
> + * and a list of known BIOS dates to avoid false positives.
> + */
> +
> +struct fbcon_dmi_rotate_data {
> +	int width;
> +	int height;
> +	const char * const *bios_dates;
> +	int rotate;
> +};
> +
> +static struct fbcon_dmi_rotate_data rotate_data_gpdwin = {
> +	.width = 720,
> +	.height = 1280,
> +	.bios_dates = (const char * const []){
> +		"10/25/2016", "11/18/2016", "02/21/2017",
> +		"03/20/2017", NULL },
> +	.rotate = FB_ROTATE_CW,
> +};
> +
> +static struct fbcon_dmi_rotate_data rotate_data_gpdpocket = {
> +	.width = 1200,
> +	.height = 1920,
> +	.bios_dates = (const char * const []){ "05/26/2017", NULL },
> +	.rotate = FB_ROTATE_CW,
> +};
> +
> +static struct fbcon_dmi_rotate_data rotate_data_itwtw891 = {
> +	.width = 800,
> +	.height = 1280,
> +	.bios_dates = (const char * const []){ "10/16/2015", NULL },
> +	.rotate = FB_ROTATE_CW,
> +};
> +
> +//static const struct fbcon_dmi_rotate_data rotate_data[] = {
> +static const struct dmi_system_id rotate_data[] = {
> +	{	/*
> +		 * GPD Win, note that the the DMI data is less generic then it
> +		 * seems, devices with a board_vendor of "AMI Corporation" are
> +		 * quite rare, as are devices which have both board- *and*
> +		 * product-id set to "Default String"
> +		 */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		},
> +		.driver_data = &rotate_data_gpdwin,
> +	}, {	/* GPD Pocket (same note on DMI match as GPD Win) */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
> +		},
> +		.driver_data = &rotate_data_gpdpocket,
> +	}, {	/* I.T.Works TW891 */
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW891"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
> +			DMI_MATCH(DMI_BOARD_NAME, "TW891"),
> +		},
> +		.driver_data = &rotate_data_itwtw891,
> +	},
> +	{}
> +};
> +
> +int fbcon_platform_get_rotate(struct fb_info *info)
> +{
> +	const struct dmi_system_id *match;
> +	const struct fbcon_dmi_rotate_data *data;
> +	const char *bios_date;
> +	int i;
> +
> +	match = dmi_first_match(rotate_data);
> +	if (match) {
> +		data = match->driver_data;
> +
> +		if (data->width != info->var.xres ||
> +		    data->height != info->var.yres)
> +			return FB_ROTATE_UR;
> +
> +		if (!data->bios_dates)
> +			return data->rotate;
> +
> +		bios_date = dmi_get_system_info(DMI_BIOS_DATE);
> +		if (!bios_date)
> +			return FB_ROTATE_UR;
> +
> +		for (i = 0; data->bios_dates[i]; i++) {
> +			if (!strcmp(data->bios_dates[i], bios_date))
> +				return data->rotate;
> +		}
> +	}
> +
> +	return FB_ROTATE_UR;
> +}
> 
> As a side note, you may want to consider using DMI_EXACT_MATCH instead
> of DMI_MATCH. This should be faster and possibly more reliable too.
> 
