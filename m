From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 01 Jul 2014 03:53:31 +0000
Subject: Re: [PATCH] MAINTAINERS: Update Framebuffer file patterns
Message-Id: <000701cf94e0$06750070$135f0150$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <00a101cf94ce$9489daf0$bd9d90d0$%han@samsung.com>
In-Reply-To: <00a101cf94ce$9489daf0$bd9d90d0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tuesday, July 01, 2014 12:37 PM, Liu Ying wrote:
> On 07/01/2014 09:48 AM, Jingoo Han wrote:
> > Since the commit f7018c2 "video: move fbdev to drivers/video/fbdev",
> > all framebuffer drivers were moved to fbdev directory. Thus, file
> > patterns of these framebuffer drivers should be updated correctly.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >   MAINTAINERS |   76 ++++++++++++++++++++++++++++++-----------------------------
> >   1 file changed, 39 insertions(+), 37 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3f2e171..7daae48 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -587,7 +587,7 @@ W:	http://www.amd.com/us-
> en/ConnectivitySolutions/TechnicalResources/0,,50_2334_
> >   S:	Supported
> >   F:	drivers/char/hw_random/geode-rng.c
> >   F:	drivers/crypto/geode*
> > -F:	drivers/video/geode/
> > +F:	drivers/video/fbdev/geode/
> >   F:	arch/x86/include/asm/geode.h
> >
> >   AMD IOMMU (AMD-VI)
> > @@ -716,8 +716,8 @@ F:	drivers/ata/pata_arasan_cf.c
> >   ARC FRAMEBUFFER DRIVER
> >   M:	Jaya Kumar <jayalk@intworks.biz>
> >   S:	Maintained
> > -F:	drivers/video/arcfb.c
> > -F:	drivers/video/fb_defio.c
> > +F:	drivers/video/fbdev/arcfb.c
> > +F:	drivers/video/fbdev/core/fb_defio.c
> >
> >   ARM MFM AND FLOPPY DRIVERS
> >   M:	Ian Molton <spyro@f2s.com>
> > @@ -756,7 +756,7 @@ F:	sound/arm/aaci.*
> >   ARM PRIMECELL CLCD PL110 DRIVER
> >   M:	Russell King <linux@arm.linux.org.uk>
> >   S:	Maintained
> > -F:	drivers/video/amba-clcd.*
> > +F:	drivers/video/fbdev/amba-clcd.*
> >
> >   ARM PRIMECELL KMI PL050 DRIVER
> >   M:	Russell King <linux@arm.linux.org.uk>
> > @@ -1135,7 +1135,7 @@ M:	Daniel Walker <dwalker@fifo99.com>
> >   M:	Bryan Huntsman <bryanh@codeaurora.org>
> >   L:	linux-arm-msm@vger.kernel.org
> >   F:	arch/arm/mach-msm/
> > -F:	drivers/video/msm/
> > +F:	drivers/video/fbdev/msm/
> >   F:	drivers/mmc/host/msm_sdcc.c
> >   F:	drivers/mmc/host/msm_sdcc.h
> >   F:	drivers/tty/serial/msm_serial.h
> > @@ -1355,7 +1355,7 @@ F:	drivers/mtd/nand/nuc900_nand.c
> >   F:	drivers/rtc/rtc-nuc900.c
> >   F:	drivers/spi/spi-nuc900.c
> >   F:	drivers/usb/host/ehci-w90x900.c
> > -F:	drivers/video/nuc900fb.c
> > +F:	drivers/video/fbdev/nuc900fb.c
> >
> >   ARM/U300 MACHINE SUPPORT
> >   M:	Linus Walleij <linus.walleij@linaro.org>
> > @@ -1424,9 +1424,9 @@ F:	drivers/rtc/rtc-vt8500.c
> >   F:	drivers/tty/serial/vt8500_serial.c
> >   F:	drivers/usb/host/ehci-platform.c
> >   F:	drivers/usb/host/uhci-platform.c
> > -F:	drivers/video/vt8500lcdfb.*
> > -F:	drivers/video/wm8505fb*
> > -F:	drivers/video/wmt_ge_rops.*
> > +F:	drivers/video/fbdev/vt8500lcdfb.*
> > +F:	drivers/video/fbdev/wm8505fb*
> > +F:	drivers/video/fbdevwmt_ge_rops.*
> 
> A typo here.  This should be
> +F:	drivers/video/fbdev/wmt_ge_rops.*

Oh, it is my mistake!
I really appreciate your comment. :-)
I will fix it and send v2 patch, soon.
Thank you.

Best regards,
Jingoo Han

> 
> Regards,
> Liu Ying
> 
> >
> >   ARM/ZIPIT Z2 SUPPORT
> >   M:	Marek Vasut <marek.vasut@gmail.com>
> > @@ -1616,7 +1616,7 @@ ATMEL LCDFB DRIVER
> >   M:	Nicolas Ferre <nicolas.ferre@atmel.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/atmel_lcdfb.c
> > +F:	drivers/video/fbdev/atmel_lcdfb.c
> >   F:	include/video/atmel_lcdc.h
> >
> >   ATMEL MACB ETHERNET DRIVER
> > @@ -2626,7 +2626,7 @@ M:	Russell King <linux@arm.linux.org.uk>
> >   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >   W:	http://www.arm.linux.org.uk/
> >   S:	Maintained
> > -F:	drivers/video/cyber2000fb.*
> > +F:	drivers/video/fbdev/cyber2000fb.*
> >
> >   CYCLADES ASYNC MUX DRIVER
> >   W:	http://www.cyclades.com/
> > @@ -2863,7 +2863,7 @@ M:	Bernie Thompson <bernie@plugable.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> >   W:	http://plugable.com/category/projects/udlfb/
> > -F:	drivers/video/udlfb.c
> > +F:	drivers/video/fbdev/udlfb.c
> >   F:	include/video/udlfb.h
> >   F:	Documentation/fb/udlfb.txt
> >
> > @@ -3385,7 +3385,7 @@ EFIFB FRAMEBUFFER DRIVER
> >   L:	linux-fbdev@vger.kernel.org
> >   M:	Peter Jones <pjones@redhat.com>
> >   S:	Maintained
> > -F:	drivers/video/efifb.c
> > +F:	drivers/video/fbdev/efifb.c
> >
> >   EFS FILESYSTEM
> >   W:	http://aeschi.ch.eu.org/efs/
> > @@ -3450,7 +3450,7 @@ EPSON S1D13XXX FRAMEBUFFER DRIVER
> >   M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
> >   S:	Maintained
> >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
> > -F:	drivers/video/s1d13xxxfb.c
> > +F:	drivers/video/fbdev/s1d13xxxfb.c
> >   F:	include/video/s1d13xxxfb.h
> >
> >   ETHERNET BRIDGE
> > @@ -3528,7 +3528,7 @@ M:	Donghwa Lee <dh09.lee@samsung.com>
> >   M:	Kyungmin Park <kyungmin.park@samsung.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/exynos/exynos_mipi*
> > +F:	drivers/video/fbdev/exynos/exynos_mipi*
> >   F:	include/video/exynos_mipi*
> >
> >   F71805F HARDWARE MONITORING DRIVER
> > @@ -3707,7 +3707,8 @@ FREESCALE DIU FRAMEBUFFER DRIVER
> >   M:	Timur Tabi <timur@tabi.org>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/fsl-diu-fb.*
> > +F:	drivers/video/fbdev/fsl-diu-fb.c
> > +F:	include/linux/fsl-diu-fb.h
> >
> >   FREESCALE DMA DRIVER
> >   M:	Li Yang <leoli@freescale.com>
> > @@ -3729,7 +3730,7 @@ L:	linux-fbdev@vger.kernel.org
> >   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >   S:	Maintained
> >   F:	include/linux/platform_data/video-imxfb.h
> > -F:	drivers/video/imxfb.c
> > +F:	drivers/video/fbdev/imxfb.c
> >
> >   FREESCALE SOC FS_ENET DRIVER
> >   M:	Pantelis Antoniou <pantelis.antoniou@gmail.com>
> > @@ -4148,7 +4149,7 @@ M:	Ferenc Bakonyi <fero@drama.obuda.kando.hu>
> >   L:	linux-nvidia@lists.surfsouth.com
> >   W:	http://drama.obuda.kando.hu/~fero/cgi-bin/hgafb.shtml
> >   S:	Maintained
> > -F:	drivers/video/hgafb.c
> > +F:	drivers/video/fbdev/hgafb.c
> >
> >   HIBERNATION (aka Software Suspend, aka swsusp)
> >   M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> > @@ -4290,7 +4291,7 @@ F:	drivers/hv/
> >   F:	drivers/input/serio/hyperv-keyboard.c
> >   F:	drivers/net/hyperv/
> >   F:	drivers/scsi/storvsc_drv.c
> > -F:	drivers/video/hyperv_fb.c
> > +F:	drivers/video/fbdev/hyperv_fb.c
> >   F:	include/linux/hyperv.h
> >   F:	tools/hv/
> >
> > @@ -4550,7 +4551,7 @@ F:	security/integrity/ima/
> >   IMS TWINTURBO FRAMEBUFFER DRIVER
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Orphan
> > -F:	drivers/video/imsttfb.c
> > +F:	drivers/video/fbdev/imsttfb.c
> >
> >   INFINIBAND SUBSYSTEM
> >   M:	Roland Dreier <roland@kernel.org>
> > @@ -4617,13 +4618,13 @@ M:	Maik Broemme <mbroemme@plusserver.de>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> >   F:	Documentation/fb/intelfb.txt
> > -F:	drivers/video/intelfb/
> > +F:	drivers/video/fbdev/intelfb/
> >
> >   INTEL 810/815 FRAMEBUFFER DRIVER
> >   M:	Antonino Daplas <adaplas@gmail.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/i810/
> > +F:	drivers/video/fbdev/i810/
> >
> >   INTEL MENLOW THERMAL DRIVER
> >   M:	Sujith Thomas <sujith.thomas@intel.com>
> > @@ -5702,7 +5703,7 @@ F:	drivers/mmc/host/mvsdio.*
> >   MATROX FRAMEBUFFER DRIVER
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Orphan
> > -F:	drivers/video/matrox/matroxfb_*
> > +F:	drivers/video/fbdev/matrox/matroxfb_*
> >   F:	include/uapi/linux/matroxfb.h
> >
> >   MAX16065 HARDWARE MONITOR DRIVER
> > @@ -6345,8 +6346,8 @@ NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
> >   M:	Antonino Daplas <adaplas@gmail.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/riva/
> > -F:	drivers/video/nvidia/
> > +F:	drivers/video/fbdev/riva/
> > +F:	drivers/video/fbdev/nvidia/
> >
> >   NVM EXPRESS DRIVER
> >   M:	Matthew Wilcox <willy@linux.intel.com>
> > @@ -6416,14 +6417,14 @@ M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   L:	linux-omap@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/omap/
> > +F:	drivers/video/fbdev/omap/
> >
> >   OMAP DISPLAY SUBSYSTEM and FRAMEBUFFER SUPPORT (DSS2)
> >   M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> >   L:	linux-omap@vger.kernel.org
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/omap2/
> > +F:	drivers/video/fbdev/omap2/
> >   F:	Documentation/arm/OMAP/DSS
> >
> >   OMAP HARDWARE SPINLOCK SUPPORT
> > @@ -6714,7 +6715,7 @@ F:	drivers/char/agp/parisc-agp.c
> >   F:	drivers/input/serio/gscps2.c
> >   F:	drivers/parport/parport_gsc.*
> >   F:	drivers/tty/serial/8250/8250_gsc.c
> > -F:	drivers/video/sti*
> > +F:	drivers/video/fbdev/sti*
> >   F:	drivers/video/console/sti*
> >   F:	drivers/video/logo/logo_parisc*
> >
> > @@ -6963,7 +6964,7 @@ S:	Maintained
> >   T:	git git://github.com/gxt/linux.git
> >   F:	drivers/input/serio/i8042-unicore32io.h
> >   F:	drivers/i2c/busses/i2c-puv3.c
> > -F:	drivers/video/fb-puv3.c
> > +F:	drivers/video/fbdev/fb-puv3.c
> >   F:	drivers/rtc/rtc-puv3.c
> >
> >   PMBUS HARDWARE MONITORING DRIVERS
> > @@ -7335,7 +7336,7 @@ RADEON FRAMEBUFFER DISPLAY DRIVER
> >   M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/aty/radeon*
> > +F:	drivers/video/fbdev/aty/radeon*
> >   F:	include/uapi/linux/radeonfb.h
> >
> >   RADIOSHARK RADIO DRIVER
> > @@ -7357,7 +7358,7 @@ RAGE128 FRAMEBUFFER DISPLAY DRIVER
> >   M:	Paul Mackerras <paulus@samba.org>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/aty/aty128fb.c
> > +F:	drivers/video/fbdev/aty/aty128fb.c
> >
> >   RALINK RT2X00 WIRELESS LAN DRIVER
> >   P:	rt2x00 project
> > @@ -7591,7 +7592,7 @@ S3 SAVAGE FRAMEBUFFER DRIVER
> >   M:	Antonino Daplas <adaplas@gmail.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/savage/
> > +F:	drivers/video/fbdev/savage/
> >
> >   S390
> >   M:	Martin Schwidefsky <schwidefsky@de.ibm.com>
> > @@ -7714,7 +7715,7 @@ SAMSUNG FRAMEBUFFER DRIVER
> >   M:	Jingoo Han <jg1.han@samsung.com>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/s3c-fb.c
> > +F:	drivers/video/fbdev/s3c-fb.c
> >
> >   SAMSUNG MULTIFUNCTION DEVICE DRIVERS
> >   M:	Sangbeom Kim <sbkim73@samsung.com>
> > @@ -8186,7 +8187,7 @@ M:	Thomas Winischhofer <thomas@winischhofer.net>
> >   W:	http://www.winischhofer.net/linuxsisvga.shtml
> >   S:	Maintained
> >   F:	Documentation/fb/sisfb.txt
> > -F:	drivers/video/sis/
> > +F:	drivers/video/fbdev/sis/
> >   F:	include/video/sisfb.h
> >
> >   SIS USB2VGA DRIVER
> > @@ -8290,7 +8291,7 @@ SMSC UFX6000 and UFX7000 USB to VGA DRIVER
> >   M:	Steve Glendinning <steve.glendinning@shawell.net>
> >   L:	linux-fbdev@vger.kernel.org
> >   S:	Maintained
> > -F:	drivers/video/smscufx.c
> > +F:	drivers/video/fbdev/smscufx.c
> >
> >   SOC-CAMERA V4L2 SUBSYSTEM
> >   M:	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > @@ -9622,7 +9623,8 @@ L:	linux-fbdev@vger.kernel.org
> >   W:	http://dev.gentoo.org/~spock/projects/uvesafb/
> >   S:	Maintained
> >   F:	Documentation/fb/uvesafb.txt
> > -F:	drivers/video/uvesafb.*
> > +F:	drivers/video/fbdev/uvesafb.c
> > +F:	include/video/uvesafb.h
> >
> >   VFAT/FAT/MSDOS FILESYSTEM
> >   M:	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> > @@ -9695,7 +9697,7 @@ S:	Maintained
> >   F:	include/linux/via-core.h
> >   F:	include/linux/via-gpio.h
> >   F:	include/linux/via_i2c.h
> > -F:	drivers/video/via/
> > +F:	drivers/video/fbdev/via/
> >
> >   VIA VELOCITY NETWORK DRIVER
> >   M:	Francois Romieu <romieu@fr.zoreil.com>
> >

