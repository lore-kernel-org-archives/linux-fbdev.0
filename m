From: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 25 Feb 2010 11:07:38 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home> <20100224170049.0d04af3c@neptune.home>
In-Reply-To: <20100224170049.0d04af3c-hY15tx4IgV39zxVx7UNMDg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>

On Wed, 24 Feb 2010, Bruno Prémont wrote:

> +config HID_PICOLCD
> +	tristate "Minibox PicoLCD (graphic version)"
> +	depends on FB
> +	select FB_DEFERRED_IO
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +	select BACKLIGHT_LCD_SUPPORT
> +	select BACKLIGHT_CLASS_DEVICE
> +	select LCD_CLASS_DEVICE

I guess you need dependency on USB_HID as well, right?

> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -0,0 +1,1075 @@
> +/***************************************************************************
> + *   Copyright (C) 2010 by Bruno Prémont <bonbons@linux-vserver.org>       *
> + *                                                                         *
> + *   Based on Logitech G13 driver (v0.4)                                   *
> + *     Copyright (C) 2009 by Rick L. Vinyard, Jr. <rvinyard@cs.nmsu.edu>   *
> + *                                                                         *
> + *   This program is free software: you can redistribute it and/or modify  *
> + *   it under the terms of the GNU General Public License as published by  *
> + *   the Free Software Foundation, either version 2 of the License.        *

I support removing the 'or any later' clause, but I think your version has 
the grammar wrong :)


> +/* Update fb_vbitmap from the screen_base and send changed tiles to device */
> +static void picolcd_fb_update(struct picolcd_data *data)
> +{
> +	int chip, tile;
> +
> +	spin_lock(&data->lock);
> +	if (!(data->status & PICOLCD_READY_FB)) {
> +		spin_unlock(&data->lock);
> +		picolcd_fb_reset(data->hdev, 0);
> +	} else
> +		spin_unlock(&data->lock);

Please put the brackets to the else branch as well.

Also, it'd be great if the framebuffer part would get Ack from someone 
more familiar with framebuffer code than me.

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
