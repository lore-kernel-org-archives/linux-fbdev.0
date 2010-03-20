From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 20 Mar 2010 16:00:14 +0000
Subject: [PATCH v2 0/6] hid: new driver for PicoLCD device
Message-Id: <20100320170014.440959a8@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Nicu Pavel <npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This series adds support for PicoLCD USB HID device adding support for
the various features in different patches so each patch concentrates
on a device class.

I implemented the patches so input support is required (this should
make it easy to later on add support for other PicoLCD device that
don't have the same feature set but share compatible HID reports.

This causes presence of a few #ifdef blocks to include support for the
different feature sets when their matching device class has been
selected.
Though to minimize the amount of such #ifs I put all code for a single
class together and defined a few stubs in the #else part so global
device initialization is not filled with #ifs.

I'm not sure which of the following approaches is better (I took the
first one):
- Check for built-in or build-as-module class support
  with #if defined():
  #if defined(CONFIG_..CLASS) || defined(CONFIG_..CLASS_MODULE)
- Add extra CONFIG_PICOLCD_$CLASS to Kconfig and let Kconfig get
  things correctly set having just simple
  #ifdef CONFIG_PICOLCD_$CLASS in the code.


The series depends on my previous patch adding HID suspend support
(I've not yet looked at improving it). The patch adding support
for backlight class depends on backlight state as of 2.6.34-rc2.

All the rest should apply against 2.6.33 (unless I did oversee some
detail).

Bruno
