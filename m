From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 08 Jul 2017 13:33:09 +0000
Subject: Re: [PATCH v2] video/console: Add dmi quirk table for x86 systems which need fbcon rotation
Message-Id: <40ae97bd-aa78-a3b8-57d3-984c46f310c9@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706142839.14659-1-hdegoede@redhat.com>
In-Reply-To: <20170706142839.14659-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 07-07-17 21:02, Jean Delvare wrote:
> Hi Hans,

Thank you for the review / comments.

> On Thu,  6 Jul 2017 16:28:39 +0200, Hans de Goede wrote:
>> Some x86 clamshell design devices use portrait tablet screens and a
>> display engine which cannot rotate in hardware, so we need to rotate
>> the fbcon to compensate.
>>
>> This commit adds a DMI based quirk table which is initially populated with
>> 3 such devices: The GPD Win, the GPD Pocket and the I.T.Works TW891, so
>> that the console comes up in the right orientation on this devices OOTB.
>>
>> Unfortunately these (cheap) devices also typically have quite generic DMI
>> data, so we match on a combination of DMI data, screen resolution and a
>> list of known BIOS dates to avoid false positives.
>>
>> Since we are now not just checking dmi-strings but also other variables
>> we cannot use dmi_check_system. So this commit exports dmi_matches and
>> we use our own loop over the table entries using dmi_matches to match
>> the dmi strings.
> 
> If this is going to happen, please make this a separate commit. A
> separate commit will be a lot easier for distribution kernel
> maintainers (or stable/longterm kernel maintainers) to cherrypick if
> they need it (possibly for something else than this first use case.)
> 
> It can still get merged through the same tree as the rest of the
> changes, to make it easier and faster.
> 
> However I need to be convinced that you actually can't use
> dmi_check_system(). Struct dmi_system_id includes a void *driver_data
> pointer, which is passed to the callback function if DMI strings match.
 > If you pass your struct fbcon_dmi_rotate_data through this pointer, you
 > should be able to perform all your checks in the callback function and
 > set initial_rotation as needed. Am I missing something?

The dmi_system_id typically is const. The code checks the expected
screen resolution (which is const) against the actual screen resolution,
which is not const. So outside of using globals (ugly, racy as there might
be more then one video output) or not making the dmi_system_id array
const I see no other option then doing the dmi-matching inside
the fbcon_platform_get_rotate function itself.

Note that the resolution check serves 2 purposes:

1) Avoid false positives, most devices needing this have a portrait
resolution where as your average device has a landscape resolution,
so this check is quite useful for avoiding false positives.

2) Avoid rotating external monitors, if one of these devices gets
an external monitor plugged into its (mini) hdmi port and we are
showing the fbcon there we do not want to rotate it.

> See below for my comments on the other implementation details (if you
> are not going to export dmi_matches after all, you can ignore some of
> them.)
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Extend the commit message explaining why dmi_check_system does not work
>>   and this commit exports and uses dmi_matches instead
>> ---
>>   drivers/firmware/dmi_scan.c              |   3 +-
>>   drivers/video/console/Makefile           |   3 +
>>   drivers/video/console/fbcon.c            |  12 +++-
>>   drivers/video/console/fbcon.h            |   7 ++-
>>   drivers/video/console/fbcon_dmi_quirks.c | 103 +++++++++++++++++++++++++++++++
>>   include/linux/dmi.h                      |   1 +
>>   6 files changed, 124 insertions(+), 5 deletions(-)
>>   create mode 100644 drivers/video/console/fbcon_dmi_quirks.c
>>
>> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
>> index 783041964439..bb1ad8b6939d 100644
>> --- a/drivers/firmware/dmi_scan.c
>> +++ b/drivers/firmware/dmi_scan.c
>> @@ -780,7 +780,7 @@ void __init dmi_set_dump_stack_arch_desc(void)
>>    *	dmi_matches - check if dmi_system_id structure matches system DMI data
>>    *	@dmi: pointer to the dmi_system_id structure to check
>>    */
>> -static bool dmi_matches(const struct dmi_system_id *dmi)
>> +bool dmi_matches(const struct dmi_system_id *dmi)
>>   {
>>   	int i;
>>   
>> @@ -804,6 +804,7 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>>   	}
>>   	return true;
>>   }
>> +EXPORT_SYMBOL(dmi_matches);
> 
> We already have an exported function named "dmi_match". I'm afraid
> there will be confusion between the two, so I would suggest renaming
> this one before exporting it. What about "dmi_system_id_match"?

Ok, that works for me. When I've some time to respin this I will submit
a 2 patch series, one doing the rename + export, and as 2nd patch this patch
minus the export.

> "dmi_match" should probably have been named "dmi_field_match" instead,
> maybe it should be renamed to that now for consistency and clarity?

Yes I think that would be good, but outside of the scope of this patch-set.

>>   /**
>>    *	dmi_is_end_of_table - check for end-of-table marker
>> diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
>> index 43bfa485db96..32ee2ad37369 100644
>> --- a/drivers/video/console/Makefile
>> +++ b/drivers/video/console/Makefile
>> @@ -15,5 +15,8 @@ ifeq ($(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION),y)
>>   obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_rotate.o fbcon_cw.o fbcon_ud.o \
>>                                            fbcon_ccw.o
>>   endif
>> +ifeq ($(CONFIG_DMI),y)
>> +obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += fbcon_dmi_quirks.o
>> +endif
>>   
>>   obj-$(CONFIG_FB_STI)              += sticore.o
>> diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
>> index 12ded23f1aaf..3db5ac2bfbb7 100644
>> --- a/drivers/video/console/fbcon.c
>> +++ b/drivers/video/console/fbcon.c
>> @@ -135,7 +135,7 @@ static char fontname[40];
>>   static int info_idx = -1;
>>   
>>   /* console rotation */
>> -static int initial_rotation;
>> +static int initial_rotation = -1;
>>   static int fbcon_has_sysfs;
>>   
>>   static const struct consw fb_con;
>> @@ -954,7 +954,10 @@ static const char *fbcon_startup(void)
>>   	ops->cur_rotate = -1;
>>   	ops->cur_blink_jiffies = HZ / 5;
>>   	info->fbcon_par = ops;
>> -	p->con_rotate = initial_rotation;
>> +	if (initial_rotation != -1)
>> +		p->con_rotate = initial_rotation;
>> +	else
>> +		p->con_rotate = fbcon_platform_get_rotate(info);
>>   	set_blitting_type(vc, info);
>>   
>>   	if (info->fix.type != FB_TYPE_TEXT) {
>> @@ -1091,7 +1094,10 @@ static void fbcon_init(struct vc_data *vc, int init)
>>   
>>   	ops = info->fbcon_par;
>>   	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
>> -	p->con_rotate = initial_rotation;
>> +	if (initial_rotation != -1)
>> +		p->con_rotate = initial_rotation;
>> +	else
>> +		p->con_rotate = fbcon_platform_get_rotate(info);
>>   	set_blitting_type(vc, info);
>>   
>>   	cols = vc->vc_cols;
> 
> As I'm not familiar with the console framework, I don't know when
> fbcon_startup is called and when fbcon_init is called (would be nice to
> have this documented in struct consw...) Is it an either/or thing, or
> are they called sequentially?

 From what I can judge startup is called just once to get an initial
console and _init is called once each time a new VC is brought up,
so they are not really called that often.

> If they are called sequentially, then given that
> fbcon_platform_get_rotate() isn't cheap and it is going to be called
> for all framebuffer devices as I understand it, I think we want to
> avoid calling it twice or more for the same device. Can't the result of
> the first call be cached (in global variable initial_rotation maybe) to
> avoid the second call?

fbcon binds to fbdev devices which may come and go (mostly on
driver load / unload) think switching from efifb to a native kernel mode
setting driver. So we cannot cache the results. Hopefully they would be
the same, but there is no guarantee.

Anyways I don't think something done once on boot and then once per
VC added is something to worry about performance wise.

> 
>> diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
>> index 7aaa4eabbba0..60e25e173fdb 100644
>> --- a/drivers/video/console/fbcon.h
>> +++ b/drivers/video/console/fbcon.h
>> @@ -261,5 +261,10 @@ extern void fbcon_set_rotate(struct fbcon_ops *ops);
>>   #define fbcon_set_rotate(x) do {} while(0)
>>   #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
>>   
>> -#endif /* _VIDEO_FBCON_H */
>> +#ifdef CONFIG_DMI
>> +int fbcon_platform_get_rotate(struct fb_info *info);
>> +#else
>> +#define fbcon_platform_get_rotate(i) FB_ROTATE_UR
>> +#endif /* CONFIG_DMI */
>>   
>> +#endif /* _VIDEO_FBCON_H */
>> diff --git a/drivers/video/console/fbcon_dmi_quirks.c b/drivers/video/console/fbcon_dmi_quirks.c
>> new file mode 100644
>> index 000000000000..3267cab38717
>> --- /dev/null
>> +++ b/drivers/video/console/fbcon_dmi_quirks.c
>> @@ -0,0 +1,103 @@
>> +/*
>> + *  fbcon_dmi_quirks.c -- DMI based quirk detection for fbcon
>> + *
>> + *	Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + *  This file is subject to the terms and conditions of the GNU General Public
>> + *  License.  See the file COPYING in the main directory of this archive for
>> + *  more details.
>> + */
>> +
>> +#include <linux/dmi.h>
>> +#include <linux/fb.h>
>> +#include <linux/kernel.h>
>> +#include "fbcon.h"
>> +
>> +/*
>> + * Some x86 clamshell design devices use portrait tablet screens and a display
>> + * engine which cannot rotate in hardware, so we need to rotate the fbcon to
>> + * compensate. Unfortunately these (cheap) devices also typically have quite
>> + * generic DMI data, so we match on a combination of DMI data, screen resolution
>> + * and a list of known BIOS dates to avoid false positives.
>> + */
>> +
>> +struct fbcon_dmi_rotate_data {
>> +	struct dmi_system_id dmi_id;
>> +	int width;
>> +	int height;
> 
> These should be unsigned?

Ack, u32 even to match fb_var_screeninfo.xres / .yres
> 
>> +	const char * const *bios_dates;
>> +	int rotate;
>> +};
>> +
>> +static const struct fbcon_dmi_rotate_data rotate_data[] = {
>> +	{	/*
>> +		 * GPD Win, note that the the DMI data is less generic then it
>> +		 * seems, devices with a board_vendor of "AMI Corporation" are
>> +		 * quite rare, as are devices which have both board- *and*
>> +		 * product-id set to "Default String"
>> +		 */
>> +		.dmi_id = { .matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>> +		} },
>> +		.width = 720,
>> +		.height = 1280,
>> +		.bios_dates = (const char * const []){
>> +			"10/25/2016", "11/18/2016", "02/21/2017",
>> +			"03/20/2017", NULL },
>> +		.rotate = FB_ROTATE_CW
>> +	}, {	/* GPD Pocket (same note on DMI match as GPD Win) */
>> +		.dmi_id = { .matches = {
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
>> +			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
>> +		} },
>> +		.width = 1200,
>> +		.height = 1920,
>> +		.bios_dates = (const char * const []){ "05/26/2017", NULL },
>> +		.rotate = FB_ROTATE_CW,
>> +	}, {	/* I.T.Works TW891 */
>> +		.dmi_id = { .matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "TW891"),
>> +			DMI_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
>> +			DMI_MATCH(DMI_BOARD_NAME, "TW891"),
>> +		} },
>> +		.width = 800,
>> +		.height = 1280,
>> +		.bios_dates = (const char * const []){ "10/16/2015", NULL },
>> +		.rotate = FB_ROTATE_CW,
>> +	}
>> +};
>> +
>> +int fbcon_platform_get_rotate(struct fb_info *info)
>> +{
>> +	const char *bios_date;
>> +	int i, j;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(rotate_data); i++) {
>> +		if (!dmi_matches(&rotate_data[i].dmi_id))
> 
> Maybe use unlikely() to minimize the impact on other systems?

This is not a hot-path and unlikely() really should only be
used in hot paths.

> 
>> +			continue;
>> +
>> +		if (rotate_data[i].width != info->var.xres ||
>> +		    rotate_data[i].height != info->var.yres)
>> +			continue;
>> +
>> +		if (!rotate_data[i].bios_dates)
>> +			return rotate_data->rotate;
>> +
>> +		bios_date = dmi_get_system_info(DMI_BIOS_DATE);
>> +		if (!bios_date)
>> +			continue;
>> +
>> +		for (j = 0; rotate_data[i].bios_dates[j]; j++) {
>> +			if (!strcmp(rotate_data[i].bios_dates[j], bios_date))
>> +				return rotate_data->rotate;
>> +		}
>> +	}
>> +
>> +	return FB_ROTATE_UR;
>> +}
>> diff --git a/include/linux/dmi.h b/include/linux/dmi.h
>> index 9bbf21a516e4..f1d28af7ed53 100644
>> --- a/include/linux/dmi.h
>> +++ b/include/linux/dmi.h
>> @@ -98,6 +98,7 @@ struct dmi_dev_onboard {
>>   extern struct kobject *dmi_kobj;
>>   extern int dmi_check_system(const struct dmi_system_id *list);
>>   const struct dmi_system_id *dmi_first_match(const struct dmi_system_id *list);
>> +bool dmi_matches(const struct dmi_system_id *dmi);
> 
> Please move this to right before dmi_check_system, so order is the same
> as in dmi_scan.c.

Ok, will do.

>>   extern const char * dmi_get_system_info(int field);
>>   extern const struct dmi_device * dmi_find_device(int type, const char *name,
>>   	const struct dmi_device *from);
> 
> For consistency, please also add a stub for the CONFIG_DMI=n case. I
> know you don't need it, but maybe others will.

Ok, will do for v2.

Regards,

Hans
