From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Thu, 25 Feb 2010 11:32:14 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <20100225123214.0523a310@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home>
	<20100224170049.0d04af3c@neptune.home>
	<alpine.LNX.2.00.1002251201430.30967@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1002251201430.30967-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>

On Thu, 25 February 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 24 Feb 2010, Bruno Prémont wrote:
> 
> > +config HID_PICOLCD
> > +	tristate "Minibox PicoLCD (graphic version)"
> > +	depends on FB
> > +	select FB_DEFERRED_IO
> > +	select FB_SYS_FILLRECT
> > +	select FB_SYS_COPYAREA
> > +	select FB_SYS_IMAGEBLIT
> > +	select FB_SYS_FOPS
> > +	select BACKLIGHT_LCD_SUPPORT
> > +	select BACKLIGHT_CLASS_DEVICE
> > +	select LCD_CLASS_DEVICE
> 
> I guess you need dependency on USB_HID as well, right?

Yep, will add

> > --- a/drivers/hid/hid-picolcd.c
> > +++ b/drivers/hid/hid-picolcd.c
> > @@ -0,0 +1,1075 @@
> > +/***************************************************************************
> > + *   Copyright (C) 2010 by Bruno Prémont <bonbons@linux-vserver.org>       *
> > + *                                                                         *
> > + *   Based on Logitech G13 driver (v0.4)                                   *
> > + *     Copyright (C) 2009 by Rick L. Vinyard, Jr. <rvinyard@cs.nmsu.edu>   *
> > + *                                                                         *
> > + *   This program is free software: you can redistribute it and/or modify  *
> > + *   it under the terms of the GNU General Public License as published by  *
> > + *   the Free Software Foundation, either version 2 of the License.        *
> 
> I support removing the 'or any later' clause, but I think your
> version has the grammar wrong :)

Oops, will fix

> > +/* Update fb_vbitmap from the screen_base and send changed tiles to device */
> > +static void picolcd_fb_update(struct picolcd_data *data)
> > +{
> > +	int chip, tile;
> > +
> > +	spin_lock(&data->lock);
> > +	if (!(data->status & PICOLCD_READY_FB)) {
> > +		spin_unlock(&data->lock);
> > +		picolcd_fb_reset(data->hdev, 0);
> > +	} else
> > +		spin_unlock(&data->lock);
> 
> Please put the brackets to the else branch as well.

Ok, will add the brackets while switching from spin_(un)lock to
spin_(un)lock_irq{save|restore}.

> Also, it'd be great if the framebuffer part would get Ack from
> someone more familiar with framebuffer code than me.

I would appreciate such one as well, especially regarding the
deferredio part and the more advanced fb use. For now I only tested
read/write from /dev/fbx.


For the two sysfs attributes I currently use, the 'reset' one shall
probably be moved to debugfs (I would like to place it under
/sys/kernel/debug/hid/$device/ next to rdesc and event).

By the way, I'm wondering why event does not list any of the reports
coming from my device though as I understand the code it should be
doing that before my raw_event function gets called...

The one for deferredio refresh rate should ideally go below fb device
(and I guess that might also be of use for other users of deferredio)

Thanks for the review,
Bruno
