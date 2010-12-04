From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 04 Dec 2010 00:13:14 +0000
Subject: Re: [PATCH v5+] viafb: I2C/DDC LCD detection for VIA framebuffer
Message-Id: <4CF9879A.3090409@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4CF8DA25.4020204@bspu.unibel.by>
In-Reply-To: <4CF8DA25.4020204@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

thanks a lot for working on the EDID code.
[and sorry for not responding sooner, but I'm busy at the moment]

Dzianis Kahanovich schrieb:
> I2C/DDC LCD detection for VIA framebuffer
> 
> Adding legacy I2C/DDC support for VIA framebuffer, used to fix LCD
> panel size and (if "via_active_dev" is empty default) force LCD
> detection. This solving at least defaults on Chrome9 video
> on HP mini 2133 notebook, but must be good in other cases,
> include double-LCD. Also related bugfixes.
> 
> v3 patch: original viafb_find_i2c_adapt() code is unsafe (nowere used).
> 
> v4 patch: viafbinfo1 is not initilalized if !viafb_dual_fb
> and may cause problems with dual separated LCD. Now dual & SAMM
> code looks safe (will no generate errors).
> 
> v5 patch: handle undefined resolution, overhead, cleanup.
> 
> Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>

The description of changes (from above) in your patch version should go here 
like this (as it should not show up in "git log" later on):
---
v3 patch: original viafb_find_i2c_adapt() code is unsafe (nowere used).

v4 patch: viafbinfo1 is not initilalized if !viafb_dual_fb and may cause 
problems with dual separated LCD. Now dual & SAMM code looks safe (will no 
generate errors).

v5 patch: handle undefined resolution, overhead, cleanup.

> diff -pruN a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
> --- a/drivers/video/via/via-core.c	2010-12-03 13:44:48.000000000 +0200
> +++ b/drivers/video/via/via-core.c	2010-12-03 13:16:14.000000000 +0200

As Jon already mentioned, via-core.c is the wrong file for such things because 
via-core is meant for managing shared resources (between video capture and 
framebuffer at the moment) and EDID is only interesting for the framebuffer. 
Probably viafbdev.c would be the best choice.

> @@ -2,6 +2,7 @@
>   * Copyright 1998-2009 VIA Technologies, Inc. All Rights Reserved.
>   * Copyright 2001-2008 S3 Graphics, Inc. All Rights Reserved.
>   * Copyright 2009 Jonathan Corbet <corbet@lwn.net>
> + * Copyright 2010 Dzianis Kahanovich <mahatma@eu.by>
>   */
> 
>  /*
> @@ -559,6 +560,69 @@ static void via_teardown_subdevs(void)
>  		}
>  }
> 
> +static void via_i2c_detect(int stage)
> +{
> +	u8 *edid;
> +	struct fb_var_screeninfo var;
> +	int i, n = 0;
> +	struct i2c_adapter *adapter;
> +	struct lvds_setting_information *inf;
> +
> +	for (i = 0; i < VIAFB_NUM_PORTS; i++) {

I think you should do it a bit more target oriented. At least on newer IGPs it 
looks like the following ports are fixed
0x26 : CRT
0x31 : DVP1
which allows easier matching of the EDID data to the output device.

> +		adapter = viafb_find_i2c_adapter(i);
> +		if (!adapter || !adapter->algo_data ||
> +		    !(edid = fb_ddc_read(adapter)))
> +			continue;
> +		memset(&var, 0, sizeof(var));
> +		if (fb_parse_edid(edid, &var))
> +			goto free_edid;
> +		if (!stage) {
> +			if (n && !viafb_active_dev)
> +				viafb_dual_fb = STATE_ON;
> +			inf = NULL;
> +		} else if (!n || !viafb_LCD_ON) {
> +			fb_edid_to_monspecs(edid, &viafbinfo->monspecs);
> +			inf = viaparinfo->lvds_setting_info;
> +			if (!viafb_active_dev) {
> +				viafb_DVI_ON > +				    viaparinfo->tmds_setting_info->max_hres ?
> +				    STATE_ON : STATE_OFF;

Doing such thing here looks wrong as this loop does not influence 
viaparinfo->tmds_setting_info

> +				if (viafbinfo->monspecs.input & FB_DISP_DDI) {
> +					viafb_LCD_ON = STATE_ON;

It can happen that we enable LCD and DVI for the same device? Well nearly the 
only difference between LCD and DVI is backlight handling, so it should work, 
but it is ugly.

> +					viafb_DeviceStatus = LCD_Device;
> +					if (!n)
> +						viafb_primary_dev = LCD_Device;
> +				}
> +			}
> +		} else if (viafb_dual_fb) {
> +			fb_edid_to_monspecs(edid, &viafbinfo1->monspecs);
> +			inf = viaparinfo1->lvds_setting_info;
> +			if (!viafb_active_dev &&
> +			    (viafbinfo1->monspecs.input & FB_DISP_DDI))
> +				viafb_LCD2_ON = STATE_ON;
> +		} else {
> +			fb_edid_to_monspecs(edid, &viafbinfo->monspecs);
> +			inf = viaparinfo->lvds_setting_info2;
> +			if (!viafb_active_dev &&
> +			    (viafbinfo->monspecs.input & FB_DISP_DDI))
> +				viafb_LCD2_ON = STATE_ON;
> +		}
> +		if (inf) {
> +			if (var.xres)
> +			    inf->lcd_panel_hres = var.xres;
> +			if (var.yres)
> +			    inf->lcd_panel_vres = var.yres;
> +		}
> +		n++;
> +free_edid:
> +		kfree(edid);
> +		if (n > 1)
> +			break;
> +	}
> +	if (stage && n && !viafb_active_dev)
> +		viafb_set_iga_path();
> +}
> +
> 
>  static int __devinit via_pci_probe(struct pci_dev *pdev,
>  		const struct pci_device_id *ent)
> @@ -585,12 +649,16 @@ static int __devinit via_pci_probe(struc
>  	 */
>  	viafb_int_init();
>  	via_setup_subdevs(&global_dev);
> +	/* dual? */
> +	via_i2c_detect(0);
>  	/*
>  	 * Set up the framebuffer device
>  	 */
>  	ret = via_fb_pci_probe(&global_dev);
>  	if (ret)
>  		goto out_subdevs;
> +	/* LCD size & present */
> +	via_i2c_detect(1);
>  	return 0;
> 
>  out_subdevs:
> diff -pruN a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
> --- a/drivers/video/via/viafbdev.h	2010-12-03 13:44:48.000000000 +0200
> +++ b/drivers/video/via/viafbdev.h	2010-12-03 13:13:50.000000000 +0200
> @@ -88,6 +88,7 @@ extern int viafb_LCD2_ON;
>  extern int viafb_LCD_ON;
>  extern int viafb_DVI_ON;
>  extern int viafb_hotplug;
> +extern char *viafb_active_dev;
> 
>  extern int strict_strtoul(const char *cp, unsigned int base,
>  	unsigned long *res);
> diff -pruN a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
> --- a/drivers/video/via/via_i2c.c	2010-12-03 13:44:48.000000000 +0200
> +++ b/drivers/video/via/via_i2c.c	2010-12-03 13:10:26.000000000 +0200
> @@ -167,7 +167,7 @@ struct i2c_adapter *viafb_find_i2c_adapt
>  {
>  	struct via_i2c_stuff *stuff = &via_i2c_par[which];
> 
> -	return &stuff->adapter;
> +	return stuff->is_active ? &stuff->adapter : NULL;
>  }
>  EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);
> 
> --
> 
> no patch without bug. (c) & PS:
> PS Todo: find where initilized mode (while no) and try to [un]detect CRT too
> (stage 3?). CRT plugging unaffected in module init stage on my chip, but CRT
> must have own DDC.

CRT DDC is at 0x26.

I like your EDID parsing code (the fact that you are using existing functions). 
But as we already have a poor open-coded EDID parser and as it would be very 
ugly to have two different methods of EDID parsing in the same driver you really 
should investigate whether your parser can't fully replace the one in dvi.c

And you should care about where the EDID information comes from:
0x21 => CRT, do not set lvds or tmds information
0x31 => DVP1:
if lcd/dvi_port was not specified : lvds/tmds_chip_information output interface 
should be set to INTERFACE_DVP1 if you set the matching 
lvds/tmds_setting_information
if lcd/dvi_port was specified : set the lvds/tmds_setting_information only if 
the output interface is INTERFACE_DVP1


Thanks,

Florian Tobias Schandinat
