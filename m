From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 15 Jan 2018 14:28:35 +0000
Subject: Re: [PATCH v2 0/5] video: udlfb: (not only) Logging cleanup
Message-Id: <4862648.kpHruC8ML0@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180104193623.GA22612@lenoch>
In-Reply-To: <20180104193623.GA22612@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Monday, January 08, 2018 05:55:27 PM Ladislav Michl wrote:
> On Thu, Jan 04, 2018 at 08:36:23PM +0100, Ladislav Michl wrote:
> > This patchset is a side product of debugging on unreliable USB host
> > where devices saw a lot of disconnects. It turned out that udlfb
> > logging is just too noisy to be usefull as produced syslog is hard
> > to read.
> > 
> > Hence this attempt to clean things up.
> > 
> > Comments and suggestions welcome and appreciated, as always.
> > 
> > Changes in v2:
> > - Dropped patch "Delete error messages for failed allocations"
> > - Dropped patch "Remove unnecessary 'return'"
> > - Added patch "Remove noisy warnings"
> > - Reordered patches
> > - Rebased against next-20180104
> >   Please note as kernel compilation fails with:
> >     kernel/exit.o: In function `__crc_abort':
> >     exit.c:(*ABS*+0xc0e2ec8b): multiple definition of `__crc_abort'
> >     Makefile:1029: recipe for target 'vmlinux' failed
> >   this patchset is not runtime tested.
> 
> FYI, now runtime tested with next-20180108:
> 
> usb 2-1.4.1: new high-speed USB device number 6 using ehci-omap
> usb 2-1.4.1: New USB device found, idVendor=058f, idProduct=6254
> usb 2-1.4.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> hub 2-1.4.1:1.0: USB hub found
> hub 2-1.4.1:1.0: 4 ports detected
> usb 2-1.4.1.2: new high-speed USB device number 7 using ehci-omap
> usb 2-1.4.1.2: New USB device found, idVendor=17e9, idProduct=401a
> usb 2-1.4.1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 2-1.4.1.2: Product: mimo
> usb 2-1.4.1.2: Manufacturer: DisplayLink
> usb 2-1.4.1.2: SerialNumber: 7090902
> udlfb 2-1.4.1.2:1.0: vendor descriptor length:23 data:23 5f 01 00 21 00 04 04 07 00 01
> udlfb 2-1.4.1.2:1.0: DL chip limited to 1500000 pixel modes
> usb 2-1.4.1.2: fb1 is DisplayLink USB device (800x480, 1504K framebuffer memory)
> 
> > Ladislav Michl (5):
> >   video: udlfb: Remove unnecessary local variable
> >   video: udlfb: Remove redundant gdev variable
> >   video: udlfb: Remove noisy warnings
> >   video: udlfb: Do not name private data 'dev'

I queued patches #1-4 for v4.16, thanks.

> >   video: udlfb: Switch from the pr_*() to the dev_*() logging functions

This one introduces new compile time warning:

drivers/video/fbdev/udlfb.c: In function ‘dlfb_init_framebuffer_work’:
drivers/video/fbdev/udlfb.c:1694:24: warning: ignoring return value of ‘device_create_bin_file’, declared with attribute warn_unused_result [-Wunused-result]
  device_create_bin_file(info->dev, &edid_attr);
                        ^

Checking of device_create_bin_file()'s return value should not be removed,

[ ditto for device_create_file() ]

Also please fix the new comment introduced by the patch:

+               /* parent device is used otherwise*/

[  ...e*/ -> ...e */ ]

> >  drivers/video/fbdev/udlfb.c | 635 +++++++++++++++++++++-----------------------
> >  include/video/udlfb.h       |   3 +-
> >  2 files changed, 302 insertions(+), 336 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

