From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 09 May 2011 21:58:31 +0000
Subject: Re: [PATCH] viafb: Automatic OLPC XO-1.5 configuration
Message-Id: <4DC86387.2000009@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110509211439.AF70A9D401C@zog.reactivated.net>
In-Reply-To: <20110509211439.AF70A9D401C@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Daniel,

On 05/09/2011 09:14 PM, Daniel Drake wrote:
> Detect presence of the OLPC laptop and configure default settings
> accordingly. This means the kernel can now boot on XO-1.5 without
> needing long, hardcoded boot options.

The purpose of this patch is to allow people use their own kernel configuration 
and just require them to enable viafb but not to copy the built-in command line, 
right?
Well I usually dislike platform specific code but given that we probably won't 
be able to detect everything OLPC specific even with a working autodetection and 
having already a lot of OLPC code in here I think adding a little more would be 
acceptable.

>
> Signed-off-by: Daniel Drake<dsd@laptop.org>
> ---
>   drivers/video/via/global.c   |    2 +-
>   drivers/video/via/viafbdev.c |   55 ++++++++++++++++++++++++++++++++----------
>   2 files changed, 43 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/video/via/global.c b/drivers/video/via/global.c
> index e10d824..b994e3b 100644
> --- a/drivers/video/via/global.c
> +++ b/drivers/video/via/global.c
> @@ -29,7 +29,7 @@ int viafb_refresh = 60;
>   int viafb_refresh1 = 60;
>   int viafb_lcd_dsp_method = LCD_EXPANDSION;
>   int viafb_lcd_mode = LCD_OPENLDI;
> -int viafb_CRT_ON = 1;
> +int viafb_CRT_ON = STATE_ON;

Unnecessary but okay

>   int viafb_DVI_ON;
>   int viafb_LCD_ON ;
>   int viafb_LCD2_ON;
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index 7b4390e..75b5fc7 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -24,6 +24,7 @@
>   #include<linux/slab.h>
>   #include<linux/stat.h>
>   #include<linux/via-core.h>
> +#include<asm/olpc.h>
>
>   #define _MASTER_FILE
>   #include "global.h"
> @@ -36,6 +37,8 @@ static char *viafb_mode;
>   static char *viafb_mode1;
>   static int viafb_bpp = 32;
>   static int viafb_bpp1 = 32;
> +static int viafb_default_mode_xres = 640;
> +static int viafb_default_mode_yres = 480;

Nack. As OLPC will probably be ever the only platform where the default is 
different and as we only use it once, we shouldn't add an extra var for it.

>
>   static unsigned int viafb_second_xres = 640;
>   static unsigned int viafb_second_yres = 480;
> @@ -1001,19 +1004,18 @@ static void retrieve_device_setting(struct viafb_ioctl_setting
>
>   static int __init parse_active_dev(void)
>   {
> -	viafb_CRT_ON = STATE_OFF;
>   	viafb_DVI_ON = STATE_OFF;
> -	viafb_LCD_ON = STATE_OFF;
>   	viafb_LCD2_ON = STATE_OFF;
> +
> +	if (!viafb_active_dev)
> +		return 0;
> +
>   	/* 1. Modify the active status of devices. */
>   	/* 2. Keep the order of devices, so we can set corresponding
>   	   IGA path to devices in SAMM case. */
>   	/*    Note: The previous of active_dev is primary device,
>   	   and the following is secondary device. */
> -	if (!viafb_active_dev) {

Just add here an
if (machine_is_olpc())
and handle it correct. Changing so much generic code for one platform is not a 
good thing. And it certainly is a better design to start with everything off and 
enable things needed and not mix it up.

> -		viafb_CRT_ON = STATE_ON;
> -		viafb_SAMM_ON = STATE_OFF;
> -	} else if (!strcmp(viafb_active_dev, "CRT+DVI")) {
> +	if (!strcmp(viafb_active_dev, "CRT+DVI")) {
>   		/* CRT+DVI */
>   		viafb_CRT_ON = STATE_ON;
>   		viafb_DVI_ON = STATE_ON;
> @@ -1035,19 +1037,23 @@ static int __init parse_active_dev(void)
>   		viafb_primary_dev = LCD_Device;
>   	} else if (!strcmp(viafb_active_dev, "DVI+LCD")) {
>   		/* DVI+LCD */
> +		viafb_CRT_ON = STATE_OFF;
>   		viafb_DVI_ON = STATE_ON;
>   		viafb_LCD_ON = STATE_ON;
>   		viafb_primary_dev = DVI_Device;
>   	} else if (!strcmp(viafb_active_dev, "LCD+DVI")) {
>   		/* LCD+DVI */
> +		viafb_CRT_ON = STATE_OFF;
>   		viafb_DVI_ON = STATE_ON;
>   		viafb_LCD_ON = STATE_ON;
>   		viafb_primary_dev = LCD_Device;
>   	} else if (!strcmp(viafb_active_dev, "LCD+LCD2")) {
> +		viafb_CRT_ON = STATE_OFF;
>   		viafb_LCD_ON = STATE_ON;
>   		viafb_LCD2_ON = STATE_ON;
>   		viafb_primary_dev = LCD_Device;
>   	} else if (!strcmp(viafb_active_dev, "LCD2+LCD")) {
> +		viafb_CRT_ON = STATE_OFF;
>   		viafb_LCD_ON = STATE_ON;
>   		viafb_LCD2_ON = STATE_ON;
>   		viafb_primary_dev = LCD2_Device;
> @@ -1057,10 +1063,12 @@ static int __init parse_active_dev(void)
>   		viafb_SAMM_ON = STATE_OFF;
>   	} else if (!strcmp(viafb_active_dev, "DVI")) {
>   		/* DVI only */
> +		viafb_CRT_ON = STATE_OFF;
>   		viafb_DVI_ON = STATE_ON;
>   		viafb_SAMM_ON = STATE_OFF;
>   	} else if (!strcmp(viafb_active_dev, "LCD")) {
>   		/* LCD only */
> +		viafb_CRT_ON = STATE_OFF;
>   		viafb_LCD_ON = STATE_ON;
>   		viafb_SAMM_ON = STATE_OFF;
>   	} else
> @@ -1665,8 +1673,8 @@ static int parse_mode(const char *str, u32 *xres, u32 *yres)
>   	char *ptr;
>
>   	if (!str) {

Add the OLPC mode here as in
if (machine_is_olpc()) {
	*xres = 1200;
	*yres = 900;
} else {
	*xres = 640;
	*yres = 480;
... perhaps this might change to autodetect someday as far as possible
}

> -		*xres = 640;
> -		*yres = 480;
> +		*xres = viafb_default_mode_xres;
> +		*yres = viafb_default_mode_yres;
>   		return 0;
>   	}
>
> @@ -1922,11 +1930,16 @@ void __devexit via_fb_pci_remove(struct pci_dev *pdev)
>   }
>
>   #ifndef MODULE
> -static int __init viafb_setup(char *options)
> +static int __init viafb_setup(void)
>   {
>   	char *this_opt;
> +	char *options;
> +
>   	DEBUG_MSG(KERN_INFO "viafb_setup!\n");
>
> +	if (fb_get_options("viafb",&options))
> +		return -ENODEV;

You move the return value here....

> +
>   	if (!options || !*options)
>   		return 0;
>
> @@ -1994,17 +2007,33 @@ static int __init viafb_setup(char *options)
>   }
>   #endif
>
> +static void __init viafb_platform_setup(void)

Probably after my comments it does no longer make any sense to do it in an extra 
function as the only thing left is
viafb_lcd_panel_id = 23;

> +{
> +	if (machine_is_olpc()) {
> +		/* Apply XO-1.5-specific configuration. */
> +		viafb_lcd_panel_id = 23;
> +		viafb_bpp = 24;
> +		viafb_default_mode_xres = 1200;
> +		viafb_default_mode_yres = 900;
> +
> +		/* LCD only */
> +		viafb_CRT_ON = STATE_OFF;
> +		viafb_LCD_ON = STATE_ON;
> +		viafb_SAMM_ON = STATE_OFF;
> +	}
> +}
> +
>   /*
>    * These are called out of via-core for now.
>    */
>   int __init viafb_init(void)
>   {
>   	u32 dummy_x, dummy_y;
> +
> +	viafb_platform_setup();
> +
>   #ifndef MODULE
> -	char *option = NULL;
> -	if (fb_get_options("viafb",&option))
> -		return -ENODEV;
> -	viafb_setup(option);
> +	viafb_setup();

...and you don't handle the return value here.

>   #endif
>   	if (parse_mode(viafb_mode,&dummy_x,&dummy_y)
>   		|| !viafb_get_mode(dummy_x, dummy_y)

Regards,

Florian Tobias Schandinat
