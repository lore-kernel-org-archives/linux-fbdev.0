From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 11 Dec 2010 20:39:19 +0000
Subject: Re: [PATCH v3] (new way) I2C/DDC defaults & I2C/DDC detection for
Message-Id: <4D03E177.6060305@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D00D508.1060106@bspu.unibel.by>
In-Reply-To: <4D00D508.1060106@bspu.unibel.by>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,

Dzianis Kahanovich schrieb:
> I2C/DDC defaults & I2C/DDC detection for VIA framebuffer.
> 
> Adding defaults & legacy I2C/DDC support for VIA framebuffer.
> Detecting legacy I2C/DDC outputs (if undetected else) and
> set autodetected defaults on empty "viafb_active_dev".
> 
> v2: fixed configurable way LCD order
> v3: fixed CRT

Again, the v2/v3 stuff is good but it would be even better if you wrote it below 
your Signed-off-by, separating it by a line with "---" as such things should not 
be shown in "git log".

> 
> Signed-off-by: Dzianis Kahanovich <mahatma@eu.by>
> ---
> diff -pruN a/viafbdev.c c/viafbdev.c
> --- a/drivers/video/via/viafbdev.c	2010-12-07 18:35:22.000000000 +0200
> +++ c/drivers/video/via/viafbdev.c	2010-12-09 04:04:49.000000000 +0200

I'm wondering which tree are you using as a base?
Your patch does not apply and not compile. Please use at least latest mainline 
as a base or even better current linux-next.

> @@ -1485,6 +1485,135 @@ static int parse_mode(const char *str, u
>  	return 0;
>  }
> 
> +/* stage=0: count devices to set dual and/or SAMM;
> +   stage=1: add devices, detected only via i2c legacy;
> +   set LCD/DVI/CRT if viafb_active_dev unset */
> +static void viafb_detect_dev(int stage, struct viafb_dev *vdev)
> +{
> +	u8 *edid;
> +	struct fb_var_screeninfo var;
> +	int i, t, ndev = 0, nlcd = 0, unknown = 0;
> +	struct i2c_adapter *adapter;
> +	struct lvds_setting_information *inf;
> +
> +	/* FIXME: viaparinfo1->chip_info looks equal to viaparinfo */
> +	i = !viafb_active_dev && stage;
> +	if (viaparinfo->chip_info->tmds_chip_info.tmds_chip_name) {
> +		ndev++;
> +		if (i)
> +			viafb_DVI_ON = STATE_ON;
> +	}
> +	if (viaparinfo->chip_info->lvds_chip_info.lvds_chip_name) {
> +		ndev++;
> +		nlcd = 1;
> +		if (i)
> +			viafb_LCD_ON = STATE_ON;
> +	}
> +	if (viaparinfo->chip_info->lvds_chip_info2.lvds_chip_name) {
> +		ndev++;
> +		nlcd = 2;
> +		if (i)
> +			viafb_LCD2_ON = STATE_ON;
> +	}
> +	/* enabling CRT in textmode is at least no bad */
> +	if (viafb_CRT_ON) {
> +		ndev++;
> +		viafb_crt_enable();
> +	}
> +	for (i = 0; i < VIAFB_NUM_PORTS; i++) {
> +		t = vdev->port_cfg[i].type;
> +		/* detect only i2c ports, undetected in other places */
> +		if ((viaparinfo && viaparinfo->chip_info && (
> +		    (viaparinfo->chip_info->tmds_chip_info.tmds_chip_name &&
> +		    viaparinfo->chip_info->tmds_chip_info.i2c_port = t) ||
> +		    (viaparinfo->chip_info->lvds_chip_info.lvds_chip_name &&
> +		    viaparinfo->chip_info->lvds_chip_info.i2c_port = t) ||
> +		    (viaparinfo->chip_info->lvds_chip_info2.lvds_chip_name &&
> +		    viaparinfo->chip_info->lvds_chip_info2.i2c_port = t)
> +		    )) || (viaparinfo1 && viaparinfo1->chip_info && (
> +		    (viaparinfo1->chip_info->tmds_chip_info.tmds_chip_name &&
> +		    viaparinfo1->chip_info->tmds_chip_info.i2c_port = t) ||
> +		    (viaparinfo1->chip_info->lvds_chip_info.lvds_chip_name &&
> +		    viaparinfo1->chip_info->lvds_chip_info.i2c_port = t) ||
> +		    (viaparinfo1->chip_info->lvds_chip_info2.lvds_chip_name &&
> +		    viaparinfo1->chip_info->lvds_chip_info2.i2c_port = t)
> +		    )) || !(adapter = viafb_find_i2c_adapter(i)) ||
> +		    !(edid = fb_ddc_read(adapter)))
> +			continue;
> +		memset(&var, 0, sizeof(var));
> +		if (fb_parse_edid(edid, &var))
> +			goto free_edid;
> +		printk(KERN_INFO "viafb: %48s\n", adapter->name);
> +		inf = NULL;
> +		if (!stage) {
> +		} else if (!nlcd) {
> +			fb_edid_to_monspecs(edid, &viafbinfo->monspecs);
> +			if (viafbinfo->monspecs.input & FB_DISP_DDI)
> +				inf = viaparinfo->lvds_setting_info;
> +			else
> +				unknown++;
> +		} else if (nlcd > 1) {
> +			printk(KERN_ERR "viafb: too many LCD\n");
> +			unknown++;
> +		} else if (viafb_dual_fb) {
> +			fb_edid_to_monspecs(edid, &viafbinfo1->monspecs);
> +			if (viafbinfo1->monspecs.input & FB_DISP_DDI)
> +				inf = viaparinfo1->lvds_setting_info;
> +			else
> +				unknown++;
> +		} else {
> +			fb_edid_to_monspecs(edid, &viafbinfo->monspecs);
> +			if (viafbinfo->monspecs.input & FB_DISP_DDI)
> +				inf = viaparinfo->lvds_setting_info2;
> +			else
> +				unknown++;
> +		}
> +		if (inf) {
> +			if (!viafb_active_dev) {
> +				if (nlcd)
> +					viafb_LCD2_ON = STATE_ON;
> +				else
> +					viafb_LCD_ON = STATE_ON;
> +			}
> +			nlcd++;
> +			if (var.xres)
> +				inf->lcd_panel_hres = var.xres;
> +			if (var.yres)
> +				inf->lcd_panel_vres = var.yres;
> +		}
> +		ndev++;
> +free_edid:
> +		kfree(edid);
> +	}
> +	if (!viafb_active_dev) {
> +		/* prefer CRT OFF if other devices */
> +#if 1
> +		if (unknown) {
> +			if (!viafb_CRT_ON) {
> +				viafb_CRT_ON = STATE_ON;
> +				ndev++;
> +			}
> +		} else if (ndev > 1 && viafb_CRT_ON) {
> +			viafb_CRT_ON = STATE_OFF;
> +			ndev--;
> +		}
> +#endif
> +		/* SAMM may be detected on stage 1,
> +		   but troubles coming together & dual not wrong */
> +		if (ndev > 1 && !stage)
> +			viafb_SAMM_ON = viafb_dual_fb = STATE_ON;
> +		viafb_DeviceStatus = viafb_primary_dev > +		    viafb_CRT_ON ? CRT_Device :
> +		    viafb_DVI_ON ? DVI_Device :
> +		    viafb_LCD_ON ? LCD_Device : None_Device;
> +		if (stage) {
> +			if (!viafb_CRT_ON)
> +				viafb_crt_disable();
> +			viafb_set_iga_path();
> +		}
> +	}
> +}
> +

You are trying to do 2 sorts of things in this function:

- You are trying to detect the lcd_panel_hres/vres. This is usually a good thing 
but you shouldn't blindly call them after the existing detection is done but 
rather sanely integrate it in (extend) the already "detection" in lcd.c (I am 
not happy that this would move the EDID code in the LCD area but as long as we 
modify the lvds structure the only sane way is to call it from lcd.c)

- You are trying to change the global default configuration. This is a lot 
trickier as it is easy to make it work for you but break it for others. If you 
do this you have to prove (code does the obvious correct thing) that it is 
closer to what everybody needs

> 
>  int __devinit via_fb_pci_probe(struct viafb_dev *vdev)
>  {
> @@ -1526,6 +1655,10 @@ int __devinit via_fb_pci_probe(struct vi
>  	parse_dvi_port();
> 
>  	viafb_init_chip_info(vdev->chip_type);
> +	/* detect dual_fb & SAMM_ON, but let's keep it to options */
> +#if 0
> +	viafb_detect_dev(0, vdev);

As this is never true, please remove it. Adding dead code is strictly forbidden 
and I've spent lots of days kicking such code out of the driver. Removing it of 
course includes removing your whole stage stuff.

> +#endif
>  	/*
>  	 * The framebuffer will have been successfully mapped by
>  	 * the core (or we'd not be here), but we still need to
> @@ -1675,6 +1808,8 @@ int __devinit via_fb_pci_probe(struct vi
>  	viafb_init_proc(&viaparinfo->shared->proc_entry);
>  #endif
>  	viafb_init_dac(IGA2);
> +	/* update from legacy i2c DDC info */
> +	viafb_detect_dev(1, vdev);
>  	return 0;
> 
>  out_fb_unreg:
> diff -pruN a/via_i2c.c c/via_i2c.c
> --- a/drivers/video/via/via_i2c.c	2010-12-08 15:12:05.000000000 +0200
> +++ c/drivers/video/via/via_i2c.c	2010-11-29 18:04:24.000000000 +0200
> @@ -167,7 +167,7 @@ struct i2c_adapter *viafb_find_i2c_adapt
>  {
>  	struct via_i2c_stuff *stuff = &via_i2c_par[which];
> 
> -	return &stuff->adapter;
> +	return stuff->is_active ? &stuff->adapter : NULL;

Perhaps you should send this one as a separate patch. It is unrelated to your 
other stuff and looks good to me.

>  }
>  EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);
> 
> --


Thanks,

Florian Tobias Schandinat

