From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Move softcursor out of fbdev to fbcon
Date: Wed, 27 Jul 2005 15:49:02 +0800
Message-ID: <42E73C6E.1090205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dxgjt-000375-T2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 00:54:05 -0700
Received: from wproxy.gmail.com ([64.233.184.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Dxgjt-0004rc-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 00:54:06 -0700
Received: by wproxy.gmail.com with SMTP id i20so116071wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Jul 2005 00:53:58 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The changelog says it all. This is a modification of Jon's patch, but
I have moved softcursor.c to the console directory.  Also I removed
the "select FB_SOFTCURSOR" from video/Kconfig and made the compilation
of softcursor unconditional, if framebuffer console is enabled.

I don't think the fb_cursor hook is usable by other programs, so we
should just restrict this hook for fbcon use only.  For userspace cursor
support, we need a new one.  But instead of one function, I believe
it's better to provide several.  Ie, something like below:

fbcursor_show()         
fbcursor_move()
fbcursor_loadimage()
fbcursor_loadpalette()
fbcursor_start()
fbcursor_stop() 

No need to pass all variables to just, say, move the cursor to x,y.

And the next step is to eliminate all fbcon-specific fields from
fb_info to another structure, such as fb_imageblit, fb_fillrect,
fb_cursor, fb_copyarea.  We'll have a smaller kernel size for
if fbcon is not enabled.

Comments?

Tony

Patch follows:

   fbcon/fbdev: Move softcursor out of fbdev to fbcon

 According to Jon Smirl, filling in the field fb_cursor with soft_cursor for
 drivers that do not support hardware cursors is redundant.  The soft_cursor
 function is usable by all drivers because it is just a wrapper around
 fb_imageblit. And because soft_cursor is an fbcon-specific hook, the file
 is moved to the console directory.


 Thus, drivers that do not support hardware cursors can leave the fb_cursor
 field blank.  For drivers that do, they can fill up this field with their
 own version.

 The end result is a smaller code size. And if the framebuffer console is
 not loaded, module/kernel size is also reduced because the soft_cursor
 module will also not be loaded.

 From: Antonino Daplas <adaplas@pol.net>
 Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/console/softcursor.c |   72 +++++++++
86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/softcursor.c         |   72 ---------
drivers/video/68328fb.c                                                     |    1
drivers/video/Kconfig                                                       |   79 ----------
drivers/video/Makefile                                                      |    1
drivers/video/acornfb.c                                                     |    1
drivers/video/amba-clcd.c                                                   |    1
drivers/video/amifb.c                                                       |    1
drivers/video/arcfb.c                                                       |    1
drivers/video/asiliantfb.c                                                  |    1
drivers/video/aty/aty128fb.c                                                |    1
drivers/video/aty/atyfb_base.c                                              |    1
drivers/video/aty/radeon_base.c                                             |    1
drivers/video/bw2.c                                                         |    1
drivers/video/cg14.c                                                        |    1
drivers/video/cg3.c                                                         |    1
drivers/video/cg6.c                                                         |    1
drivers/video/chipsfb.c                                                     |    1
drivers/video/cirrusfb.c                                                    |    1
drivers/video/clps711xfb.c                                                  |    1
drivers/video/console/Makefile                                              |    2
drivers/video/console/bitblit.c                                             |    7
drivers/video/console/fbcon.h                                               |    2
drivers/video/controlfb.c                                                   |    1
drivers/video/cyber2000fb.c                                                 |    1
drivers/video/dnfb.c                                                        |    1
drivers/video/epson1355fb.c                                                 |    1
drivers/video/ffb.c                                                         |    3
drivers/video/fm2fb.c                                                       |    1
drivers/video/gbefb.c                                                       |    1
drivers/video/geode/Kconfig                                                 |    1
drivers/video/geode/gx1fb_core.c                                            |    1
drivers/video/hitfb.c                                                       |    1
drivers/video/hpfb.c                                                        |    1
drivers/video/i810/i810_main.c                                              |    2
drivers/video/imsttfb.c                                                     |    1
drivers/video/imxfb.c                                                       |    1
drivers/video/intelfb/intelfbdrv.c                                          |    2
drivers/video/kyro/fbdev.c                                                  |    1
drivers/video/leo.c                                                         |    1
drivers/video/macfb.c                                                       |    1
drivers/video/matrox/matroxfb_accel.c                                       |    2
drivers/video/matrox/matroxfb_crtc2.c                                       |    1
drivers/video/maxinefb.c                                                    |    1
drivers/video/neofb.c                                                       |    1
drivers/video/nvidia/nvidia.c                                               |    2
drivers/video/offb.c                                                        |    1
drivers/video/p9100.c                                                       |    1
drivers/video/platinumfb.c                                                  |    1
drivers/video/pm2fb.c                                                       |    1
drivers/video/pmag-ba-fb.c                                                  |    1
drivers/video/pmagb-b-fb.c                                                  |    1
drivers/video/pvr2fb.c                                                      |    1
drivers/video/pxafb.c                                                       |    1
drivers/video/q40fb.c                                                       |    1
drivers/video/radeonfb.c                                                    |    1
drivers/video/s1d13xxxfb.c                                                  |    1
drivers/video/sa1100fb.c                                                    |    1
drivers/video/savage/savagefb_driver.c                                      |    1
drivers/video/sgivwfb.c                                                     |    1
drivers/video/sis/sis_main.c                                                |    2
drivers/video/skeletonfb.c                                                  |    9 -
drivers/video/sstfb.c                                                       |    1
drivers/video/stifb.c                                                       |    1
drivers/video/tcx.c                                                         |    1
drivers/video/tdfxfb.c                                                      |    1
drivers/video/tgafb.c                                                       |    1
drivers/video/tridentfb.c                                                   |    1
drivers/video/tx3912fb.c                                                    |    1
drivers/video/valkyriefb.c                                                  |    1
drivers/video/vesafb.c                                                      |    1
drivers/video/vfb.c                                                         |    1
drivers/video/vga16fb.c                                                     |    1
drivers/video/w100fb.c                                                      |    1
include/linux/fb.h                                                          |    1
75 files changed, 89 insertions(+), 229 deletions(-)

Index: drivers/video/68328fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/68328fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/68328fb.c  (mode:100644)
@@ -113,7 +113,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= mc68x328fb_mmap,
 };
 
Index: drivers/video/Kconfig
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/Kconfig  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/Kconfig  (mode:100644)
@@ -65,15 +65,6 @@
 	  blitting. This is used by drivers that don't provide their own
 	  (accelerated) version.
 
-config FB_SOFT_CURSOR
-	tristate
-	depends on FB
-	default n
-	---help---
-	  Include the soft_cursor function for generic software cursor support.
-	  This is used by drivers that don't provide their own (accelerated)
-	  version.
-
 config FB_MACMODES
        tristate
        depends on FB
@@ -114,7 +105,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
@@ -133,7 +123,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
@@ -152,7 +141,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
@@ -169,7 +157,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Acorn VIDC graphics
 	  hardware found in Acorn RISC PCs and other ARM-based machines.  If
@@ -181,7 +168,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_SA1100
 	bool "SA-1100 LCD support"
@@ -189,7 +175,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is a framebuffer device for the SA-1100 LCD Controller.
 	  See <http://www.linux-fbdev.org/> for information on framebuffer
@@ -204,7 +189,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
@@ -212,7 +196,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Integraphics CyberPro 20x0 and 5000
 	  VGA chips used in the Rebel.com Netwinder and other machines.
@@ -225,7 +208,6 @@
 	default y
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_Q40
 	bool
@@ -234,12 +216,10 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_AMIGA
 	tristate "Amiga native chipset support"
 	depends on FB && AMIGA
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the builtin graphics
 	  chipset found in Amigas.
@@ -279,7 +259,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Cybervision 64 graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -294,7 +273,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Cybervision 64/3D graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -317,7 +295,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Amiga FrameMaster
 	  card from BSC (exhibited 1992 but not shipped as a CBM product).
@@ -328,7 +305,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Arc Monochrome LCD board. The board
 	  is based on the KS-108 lcd controller and is typically a matrix
@@ -351,7 +327,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  Say Y if you want support with Open Firmware for your graphics
@@ -363,7 +338,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  This driver supports a frame buffer for the graphics adapter in the
@@ -375,7 +349,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  This driver supports a frame buffer for the "platinum" graphics
@@ -387,7 +360,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  This driver supports a frame buffer for the "valkyrie" graphics
@@ -399,7 +371,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Chips & Technologies
 	  65550 graphics chip in PowerBooks.
@@ -410,13 +381,11 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"
 	depends on (FB = y) && PCI
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
@@ -434,7 +403,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for VGA 16 color graphic
 	  cards. Say Y if you have such a card.
@@ -448,7 +416,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	default y
 	---help---
 	  STI refers to the HP "Standard Text Interface" which is a set of
@@ -469,7 +436,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
@@ -478,7 +444,6 @@
 	depends on (FB = y) && HP300
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	default y
 
 config FB_TGA
@@ -487,7 +452,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for generic TGA graphic
 	  cards. Say Y if you have one of those.
@@ -498,7 +462,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -516,7 +479,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you have a Hercules mono graphics card.
 
@@ -545,7 +507,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  SGI Visual Workstation support for framebuffer graphics.
 
@@ -555,7 +516,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
  	help
 	  This is the frame buffer device driver for SGI Graphics Backend.
 	  This chip is used in SGI O2 and Visual Workstation 320/540.
@@ -583,7 +543,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the BWtwo frame buffer.
 
@@ -592,7 +551,6 @@
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGthree frame buffer.
 
@@ -601,7 +559,6 @@
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 	  frame buffer.
@@ -612,7 +569,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a PowerVR 2 card in your box.  If you plan to
 	  run linux on your Dreamcast, you will have to say Y here.
@@ -634,7 +590,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Build in support for the SED1355 Epson Research Embedded RAMDAC
 	  LCD/CRT Controller (since redesignated as the S1D13505) as a
@@ -650,7 +605,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
@@ -681,7 +635,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -720,7 +673,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
@@ -763,7 +715,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.
@@ -786,7 +737,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_TILEBLITTING
 	select FB_MACMODES if PPC_PMAC
 	---help---
@@ -927,7 +877,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
@@ -945,7 +894,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC_OF
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
@@ -984,7 +932,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC_PMAC
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
@@ -1000,7 +947,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
@@ -1052,7 +998,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports notebooks and computers with S3 Savage PCI/AGP
 	  chips.
@@ -1089,7 +1034,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the SiS 300, 315 and
 	  330 series VGA chipsets. Specs available at <http://www.sis.com>
@@ -1117,7 +1061,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
 	  Say Y if you have such a graphics card. 
@@ -1131,7 +1074,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you have a STG4000 / Kyro / PowerVR 3 based
 	  graphics board.
@@ -1145,7 +1087,6 @@
 	select FB_CFB_IMAGEBLIT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the 3Dfx Banshee/Voodoo3
 	  chips. Say Y if you have such a graphics board.
@@ -1167,7 +1108,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or 
 	  Voodoo2 (cvg) based graphics card.
@@ -1186,7 +1126,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  This driver is supposed to support graphics boards with the
 	  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
@@ -1264,7 +1203,6 @@
 	depends on FB_SBUS && SPARC64
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Creator, Creator3D,
 	  and Elite3D graphics boards.
@@ -1275,7 +1213,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the TCX 24/8bit frame
 	  buffer.
@@ -1286,7 +1223,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGfourteen frame
 	  buffer on Desktop SPARCsystems with the SX graphics option.
@@ -1297,7 +1233,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the P9100 card
 	  supported on Sparcbook 3 machines.
@@ -1308,7 +1243,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the SBUS-based Sun ZX
 	  (leo) frame buffer cards.
@@ -1323,7 +1257,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the framebuffer device for the INTERGRAPHICS 1680 and
 	  successor frame buffer cards.
@@ -1334,7 +1267,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Hitachi HD64461 LCD
 	  frame buffer card.
@@ -1345,7 +1277,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
 	  used mainly in the MIPS-based DECstation series.
@@ -1356,7 +1287,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
 	  used mainly in the MIPS-based DECstation series.
@@ -1367,7 +1297,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
 	  in the MIPS-based DECstation series. The card is currently only
@@ -1379,7 +1308,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the onboard framebuffer (1024x768x8) in the Personal
 	  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
@@ -1391,7 +1319,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -1404,7 +1331,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  The G364 driver is the framebuffer used in MIPS Magnum 4000 and
 	  Olivetti M700-10 systems.
@@ -1415,7 +1341,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.
@@ -1426,7 +1351,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the built-in LCD controller in the Intel
 	  PXA2x0 processor.
@@ -1444,7 +1368,6 @@
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
 
@@ -1478,7 +1401,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for S1D13XXX framebuffer device family (currently only
 	  working with S1D13806). Product specs at
@@ -1490,7 +1412,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  This is a `virtual' frame buffer device. It operates on a chunk of
 	  unswappable kernel memory instead of on the memory of a graphics
Index: drivers/video/Makefile
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/Makefile  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/Makefile  (mode:100644)
@@ -15,7 +15,6 @@
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
 obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
-obj-$(CONFIG_FB_SOFT_CURSOR)   += softcursor.o
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o
 
 # Hardware specific drivers go first
Index: drivers/video/acornfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/acornfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/acornfb.c  (mode:100644)
@@ -926,7 +926,6 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_mmap	= acornfb_mmap,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
Index: drivers/video/amba-clcd.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/amba-clcd.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/amba-clcd.c  (mode:100644)
@@ -332,7 +332,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= clcdfb_mmap,
 };
 
Index: drivers/video/amifb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/amifb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/amifb.c  (mode:100644)
@@ -1185,7 +1185,6 @@
 	.fb_fillrect	= amifb_fillrect,
 	.fb_copyarea	= amifb_copyarea,
 	.fb_imageblit	= amifb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl	= amifb_ioctl,
 };
 
Index: drivers/video/arcfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/arcfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/arcfb.c  (mode:100644)
@@ -514,7 +514,6 @@
 	.fb_fillrect	= arcfb_fillrect,
 	.fb_copyarea	= arcfb_copyarea,
 	.fb_imageblit	= arcfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl 	= arcfb_ioctl,
 };
 
Index: drivers/video/asiliantfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/asiliantfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/asiliantfb.c  (mode:100644)
@@ -106,7 +106,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /* Calculate the ratios for the dot clocks without using a single long long
Index: drivers/video/aty/aty128fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/aty/aty128fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/aty/aty128fb.c  (mode:100644)
@@ -478,7 +478,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 #ifdef CONFIG_PMAC_BACKLIGHT
Index: drivers/video/aty/atyfb_base.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/aty/atyfb_base.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/aty/atyfb_base.c  (mode:100644)
@@ -292,7 +292,6 @@
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
-	.fb_cursor	= soft_cursor,
 #ifdef __sparc__
 	.fb_mmap	= atyfb_mmap,
 #endif
Index: drivers/video/aty/radeon_base.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/aty/radeon_base.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/aty/radeon_base.c  (mode:100644)
@@ -1873,7 +1873,6 @@
 	.fb_fillrect		= radeonfb_fillrect,
 	.fb_copyarea		= radeonfb_copyarea,
 	.fb_imageblit		= radeonfb_imageblit,
-	.fb_cursor		= soft_cursor,
 };
 
 
Index: drivers/video/bw2.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/bw2.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/bw2.c  (mode:100644)
@@ -51,7 +51,6 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= bw2_mmap,
 	.fb_ioctl		= bw2_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* OBio addresses for the bwtwo registers */
Index: drivers/video/cg14.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/cg14.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/cg14.c  (mode:100644)
@@ -49,7 +49,6 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= cg14_mmap,
 	.fb_ioctl		= cg14_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 #define CG14_MCR_INTENABLE_SHIFT	7
Index: drivers/video/cg3.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/cg3.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/cg3.c  (mode:100644)
@@ -50,7 +50,6 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= cg3_mmap,
 	.fb_ioctl		= cg3_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 
Index: drivers/video/cg6.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/cg6.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/cg6.c  (mode:100644)
@@ -54,7 +54,6 @@
 	.fb_sync		= cg6_sync,
 	.fb_mmap		= cg6_mmap,
 	.fb_ioctl		= cg6_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* Offset of interesting structures in the OBIO space */
Index: drivers/video/chipsfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/chipsfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/chipsfb.c  (mode:100644)
@@ -91,7 +91,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int chipsfb_check_var(struct fb_var_screeninfo *var,
Index: drivers/video/cirrusfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/cirrusfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/cirrusfb.c  (mode:100644)
@@ -548,7 +548,6 @@
 	.fb_fillrect	= cirrusfb_fillrect,
 	.fb_copyarea	= cirrusfb_copyarea,
 	.fb_imageblit	= cirrusfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*--- Hardware Specific Routines -------------------------------------------*/
Index: drivers/video/clps711xfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/clps711xfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/clps711xfb.c  (mode:100644)
@@ -219,7 +219,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int 
Index: drivers/video/console/Makefile
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/console/Makefile  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/console/Makefile  (mode:100644)
@@ -26,7 +26,7 @@
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o font.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o font.o
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o font.o softcursor.o
 ifeq ($(CONFIG_FB_TILEBLITTING),y)
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += tileblit.o
 endif
Index: drivers/video/console/bitblit.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/console/bitblit.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/console/bitblit.c  (mode:100644)
@@ -232,6 +232,7 @@
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	int err = 1;
 	char *src;
 
 	cursor.set = 0;
@@ -368,7 +369,11 @@
 	cursor.image.depth = 1;
 	cursor.rop = ROP_XOR;
 
-	info->fbops->fb_cursor(info, &cursor);
+	if (info->fbops->fb_cursor)
+		err = info->fbops->fb_cursor(info, &cursor);
+
+	if (err)
+		soft_cursor(info, &cursor);
 
 	ops->cursor_reset = 0;
 }
Index: drivers/video/console/fbcon.h
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/console/fbcon.h  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/console/fbcon.h  (mode:100644)
@@ -166,5 +166,5 @@
 			      struct display *p, struct fbcon_ops *ops);
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
-
+extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 #endif /* _VIDEO_FBCON_H */
Index: drivers/video/console/softcursor.c
===================================================================
--- /dev/null  (tree:86b5df80031a3c68459cc684c4ee9e00e9e38873)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/console/softcursor.c  (mode:100644)
@@ -0,0 +1,72 @@
+/*
+ * linux/drivers/video/softcursor.c -- Generic software cursor for frame buffer devices
+ *
+ *  Created 14 Nov 2002 by James Simmons 
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+#include <linux/fb.h>
+#include <linux/slab.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
+{
+	unsigned int scan_align = info->pixmap.scan_align - 1;
+	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int i, size, dsize, s_pitch, d_pitch;
+	struct fb_image *image;
+	u8 *dst, *src;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return 0;
+
+	s_pitch = (cursor->image.width + 7) >> 3;
+	dsize = s_pitch * cursor->image.height;
+
+	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
+	if (!src)
+		return -ENOMEM;
+
+	image = (struct fb_image *) (src + dsize);
+	*image = cursor->image;
+	d_pitch = (s_pitch + scan_align) & ~scan_align;
+
+	size = d_pitch * image->height + buf_align;
+	size &= ~buf_align;
+	dst = fb_get_buffer_offset(info, &info->pixmap, size);
+
+	if (cursor->enable) {
+		switch (cursor->rop) {
+		case ROP_XOR:
+			for (i = 0; i < dsize; i++)
+				src[i] = image->data[i] ^ cursor->mask[i];
+			break;
+		case ROP_COPY:
+		default:
+			for (i = 0; i < dsize; i++)
+				src[i] = image->data[i] & cursor->mask[i];
+			break;
+		}
+	} else 
+		memcpy(src, image->data, dsize);
+	
+	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
+	image->data = dst;
+	info->fbops->fb_imageblit(info, image);
+	kfree(src);
+	return 0;
+}
+
+EXPORT_SYMBOL(soft_cursor);
+ 
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
+MODULE_DESCRIPTION("Generic software cursor");
+MODULE_LICENSE("GPL");
Index: drivers/video/controlfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/controlfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/controlfb.c  (mode:100644)
@@ -176,7 +176,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 
Index: drivers/video/cyber2000fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/cyber2000fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/cyber2000fb.c  (mode:100644)
@@ -1064,7 +1064,6 @@
 	.fb_fillrect	= cyber2000fb_fillrect,
 	.fb_copyarea	= cyber2000fb_copyarea,
 	.fb_imageblit	= cyber2000fb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_sync	= cyber2000fb_sync,
 };
 
Index: drivers/video/dnfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/dnfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/dnfb.c  (mode:100644)
@@ -114,7 +114,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= dnfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 struct fb_var_screeninfo dnfb_var __devinitdata = {
Index: drivers/video/epson1355fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/epson1355fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/epson1355fb.c  (mode:100644)
@@ -482,7 +482,6 @@
 	.fb_imageblit 	= cfb_imageblit,
 	.fb_read 	= epson1355fb_read,
 	.fb_write 	= epson1355fb_write,
-	.fb_cursor 	= soft_cursor,
 };
 
 /* ------------------------------------------------------------------------- */
Index: drivers/video/ffb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/ffb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/ffb.c  (mode:100644)
@@ -57,9 +57,6 @@
 	.fb_sync		= ffb_sync,
 	.fb_mmap		= ffb_mmap,
 	.fb_ioctl		= ffb_ioctl,
-
-	/* XXX Use FFB hw cursor once fb cursor API is better understood... */
-	.fb_cursor		= soft_cursor,
 };
 
 /* Register layout and definitions */
Index: drivers/video/fm2fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/fm2fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/fm2fb.c  (mode:100644)
@@ -172,7 +172,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
     /*
Index: drivers/video/gbefb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/gbefb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/gbefb.c  (mode:100644)
@@ -1038,7 +1038,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
Index: drivers/video/geode/Kconfig
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/geode/Kconfig  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/geode/Kconfig  (mode:100644)
@@ -16,7 +16,6 @@
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Framebuffer driver for the display controller integrated into the
 	  AMD Geode GX1 processor.
Index: drivers/video/geode/gx1fb_core.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/geode/gx1fb_core.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/geode/gx1fb_core.c  (mode:100644)
@@ -213,7 +213,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static struct fb_info * __init gx1fb_init_fbinfo(void)
Index: drivers/video/hitfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/hitfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/hitfb.c  (mode:100644)
@@ -262,7 +262,6 @@
 	.fb_fillrect	= hitfb_fillrect,
 	.fb_copyarea	= hitfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 int __init hitfb_init(void)
Index: drivers/video/hpfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/hpfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/hpfb.c  (mode:100644)
@@ -193,7 +193,6 @@
 	.fb_fillrect	= hpfb_fillrect,
 	.fb_copyarea	= hpfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_sync	= hpfb_sync,
 };
 
Index: drivers/video/i810/i810_main.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/i810/i810_main.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/i810/i810_main.c  (mode:100644)
@@ -1420,7 +1420,7 @@
 
 	if (!(par->dev_flags & USE_HWCUR) || !info->var.accel_flags ||
 	    par->dev_flags & LOCKUP)
-		return soft_cursor(info, cursor);
+		return -ENODEV;
 
 	if (cursor->image.width > 64 || cursor->image.height > 64)
 		return -ENXIO;
Index: drivers/video/imsttfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/imsttfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/imsttfb.c  (mode:100644)
@@ -1344,7 +1344,6 @@
 	.fb_fillrect	= imsttfb_fillrect,
 	.fb_copyarea	= imsttfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
Index: drivers/video/imxfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/imxfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/imxfb.c  (mode:100644)
@@ -302,7 +302,6 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= imxfb_blank,
-	.fb_cursor	= soft_cursor, /* FIXME: i.MX can do hardware cursor */
 };
 
 /*
Index: drivers/video/intelfb/intelfbdrv.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/intelfb/intelfbdrv.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/intelfb/intelfbdrv.c  (mode:100644)
@@ -1494,7 +1494,7 @@
 #endif
 
 	if (!dinfo->hwcursor)
-		return soft_cursor(info, cursor);
+		return -ENODEV;
 
 	intelfbhw_cursor_hide(dinfo);
 
Index: drivers/video/kyro/fbdev.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/kyro/fbdev.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/kyro/fbdev.c  (mode:100644)
@@ -669,7 +669,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int __devinit kyrofb_probe(struct pci_dev *pdev,
Index: drivers/video/leo.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/leo.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/leo.c  (mode:100644)
@@ -51,7 +51,6 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= leo_mmap,
 	.fb_ioctl		= leo_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 #define LEO_OFF_LC_SS0_KRN	0x00200000UL
Index: drivers/video/macfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/macfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/macfb.c  (mode:100644)
@@ -589,7 +589,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 void __init macfb_setup(char *options)
Index: drivers/video/matrox/matroxfb_accel.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/matrox/matroxfb_accel.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/matrox/matroxfb_accel.c  (mode:100644)
@@ -122,7 +122,7 @@
 	ACCESS_FBINFO(fbops).fb_copyarea = cfb_copyarea;
 	ACCESS_FBINFO(fbops).fb_fillrect = cfb_fillrect;
 	ACCESS_FBINFO(fbops).fb_imageblit = cfb_imageblit;
-	ACCESS_FBINFO(fbops).fb_cursor = soft_cursor;
+	ACCESS_FBINFO(fbops).fb_cursor = NULL;
 
 	accel = (ACCESS_FBINFO(fbcon).var.accel_flags & FB_ACCELF_TEXT) == FB_ACCELF_TEXT;
 
Index: drivers/video/matrox/matroxfb_crtc2.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/matrox/matroxfb_crtc2.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/matrox/matroxfb_crtc2.c  (mode:100644)
@@ -576,7 +576,6 @@
 	.fb_fillrect =	cfb_fillrect,
 	.fb_copyarea =	cfb_copyarea,
 	.fb_imageblit =	cfb_imageblit,
-	.fb_cursor =	soft_cursor,
 };
 
 static struct fb_var_screeninfo matroxfb_dh_defined = {
Index: drivers/video/maxinefb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/maxinefb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/maxinefb.c  (mode:100644)
@@ -113,7 +113,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 int __init maxinefb_init(void)
Index: drivers/video/neofb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/neofb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/neofb.c  (mode:100644)
@@ -1665,7 +1665,6 @@
 	.fb_fillrect	= neofb_fillrect,
 	.fb_copyarea	= neofb_copyarea,
 	.fb_imageblit	= neofb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /* --------------------------------------------------------------------- */
Index: drivers/video/nvidia/nvidia.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/nvidia/nvidia.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/nvidia/nvidia.c  (mode:100644)
@@ -1350,7 +1350,7 @@
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
 	if (!hwcur)
-		info->fbops->fb_cursor = soft_cursor;
+		info->fbops->fb_cursor = NULL;
 	info->var.accel_flags = (!noaccel);
 
 	switch (par->Architecture) {
Index: drivers/video/offb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/offb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/offb.c  (mode:100644)
@@ -85,7 +85,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
     /*
Index: drivers/video/p9100.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/p9100.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/p9100.c  (mode:100644)
@@ -48,7 +48,6 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= p9100_mmap,
 	.fb_ioctl		= p9100_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* P9100 control registers */
Index: drivers/video/platinumfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/platinumfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/platinumfb.c  (mode:100644)
@@ -109,7 +109,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
Index: drivers/video/pm2fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/pm2fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/pm2fb.c  (mode:100644)
@@ -1034,7 +1034,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
Index: drivers/video/pmag-ba-fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/pmag-ba-fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/pmag-ba-fb.c  (mode:100644)
@@ -117,7 +117,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 int __init pmagbafb_init_one(int slot)
Index: drivers/video/pmagb-b-fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/pmagb-b-fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/pmagb-b-fb.c  (mode:100644)
@@ -118,7 +118,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 int __init pmagbbfb_init_one(int slot)
Index: drivers/video/pvr2fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/pvr2fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/pvr2fb.c  (mode:100644)
@@ -230,7 +230,6 @@
 	.fb_fillrect 	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static struct fb_videomode pvr2_modedb[] __initdata = {
Index: drivers/video/pxafb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/pxafb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/pxafb.c  (mode:100644)
@@ -418,7 +418,6 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= pxafb_blank,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= pxafb_mmap,
 };
 
Index: drivers/video/q40fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/q40fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/q40fb.c  (mode:100644)
@@ -84,7 +84,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int __init q40fb_probe(struct device *device)
Index: drivers/video/radeonfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/radeonfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/radeonfb.c  (mode:100644)
@@ -2218,7 +2218,6 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 #endif
-	.fb_cursor	= soft_cursor,
 };
 
 
Index: drivers/video/s1d13xxxfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/s1d13xxxfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/s1d13xxxfb.c  (mode:100644)
@@ -388,7 +388,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor
 };
 
 static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
Index: drivers/video/sa1100fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/sa1100fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/sa1100fb.c  (mode:100644)
@@ -851,7 +851,6 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= sa1100fb_blank,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= sa1100fb_mmap,
 };
 
Index: drivers/video/savage/savagefb_driver.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/savage/savagefb_driver.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/savage/savagefb_driver.c  (mode:100644)
@@ -1417,7 +1417,6 @@
 	.fb_copyarea    = cfb_copyarea,
 	.fb_imageblit   = cfb_imageblit,
 #endif
-	.fb_cursor      = soft_cursor,
 };
 
 /* --------------------------------------------------------------------- */
Index: drivers/video/sgivwfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/sgivwfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/sgivwfb.c  (mode:100644)
@@ -124,7 +124,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= sgivwfb_mmap,
 };
 
Index: drivers/video/sis/sis_main.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/sis/sis_main.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/sis/sis_main.c  (mode:100644)
@@ -2270,7 +2270,9 @@
 	.fb_fillrect    = fbcon_sis_fillrect,
 	.fb_copyarea    = fbcon_sis_copyarea,
 	.fb_imageblit   = cfb_imageblit,
+#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,12)
 	.fb_cursor      = soft_cursor,
+#endif
 	.fb_sync        = fbcon_sis_sync,
 	.fb_ioctl       = sisfb_ioctl,
 #ifdef CONFIG_COMPAT
Index: drivers/video/skeletonfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/skeletonfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/skeletonfb.c  (mode:100644)
@@ -457,11 +457,8 @@
 }
 
 /**
- *	xxxfb_cursor - 	REQUIRED function. If your hardware lacks support
- *			for a cursor you can use the default cursor whose
- *			function is called soft_cursor. It will always 
- *			work since it uses xxxfb_imageblit function which 
- *			is required. 	  	 
+ *	xxxfb_cursor - 	OPTIONAL. If your hardware lacks support
+ *			for a cursor, leave this field NULL. 
  *
  *      @info: frame buffer structure that represents a single frame buffer
  *	@cursor: structure defining the cursor to draw.
@@ -663,7 +660,7 @@
 	.fb_fillrect	= xxxfb_fillrect, 	/* Needed !!! */ 
 	.fb_copyarea	= xxxfb_copyarea,	/* Needed !!! */ 
 	.fb_imageblit	= xxxfb_imageblit,	/* Needed !!! */
-	.fb_cursor	= xxxfb_cursor,		/* Needed !!! */
+	.fb_cursor	= xxxfb_cursor,		/* Optional !!! */
 	.fb_rotate	= xxxfb_rotate,
 	.fb_poll	= xxxfb_poll,
 	.fb_sync	= xxxfb_sync,
Index: drivers/video/softcursor.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/softcursor.c  (mode:100644)
+++ /dev/null  (tree:67f1f768d5c715e7bd5fcd8fa71f946e883869ea)
@@ -1,72 +0,0 @@
-/*
- * linux/drivers/video/softcursor.c -- Generic software cursor for frame buffer devices
- *
- *  Created 14 Nov 2002 by James Simmons 
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/tty.h>
-#include <linux/fb.h>
-#include <linux/slab.h>
-
-#include <asm/uaccess.h>
-#include <asm/io.h>
-
-int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
-{
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int i, size, dsize, s_pitch, d_pitch;
-	struct fb_image *image;
-	u8 *dst, *src;
-
-	if (info->state != FBINFO_STATE_RUNNING)
-		return 0;
-
-	s_pitch = (cursor->image.width + 7) >> 3;
-	dsize = s_pitch * cursor->image.height;
-
-	src = kmalloc(dsize + sizeof(struct fb_image), GFP_ATOMIC);
-	if (!src)
-		return -ENOMEM;
-
-	image = (struct fb_image *) (src + dsize);
-	*image = cursor->image;
-	d_pitch = (s_pitch + scan_align) & ~scan_align;
-
-	size = d_pitch * image->height + buf_align;
-	size &= ~buf_align;
-	dst = fb_get_buffer_offset(info, &info->pixmap, size);
-
-	if (cursor->enable) {
-		switch (cursor->rop) {
-		case ROP_XOR:
-			for (i = 0; i < dsize; i++)
-				src[i] = image->data[i] ^ cursor->mask[i];
-			break;
-		case ROP_COPY:
-		default:
-			for (i = 0; i < dsize; i++)
-				src[i] = image->data[i] & cursor->mask[i];
-			break;
-		}
-	} else 
-		memcpy(src, image->data, dsize);
-	
-	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
-	image->data = dst;
-	info->fbops->fb_imageblit(info, image);
-	kfree(src);
-	return 0;
-}
-
-EXPORT_SYMBOL(soft_cursor);
- 
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
-MODULE_DESCRIPTION("Generic software cursor");
-MODULE_LICENSE("GPL");
Index: drivers/video/sstfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/sstfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/sstfb.c  (mode:100644)
@@ -1382,7 +1382,6 @@
 	.fb_fillrect	= cfb_fillrect, /* sstfb_fillrect */
 	.fb_copyarea	= cfb_copyarea, /* sstfb_copyarea */
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl	= sstfb_ioctl,
 };
 
Index: drivers/video/stifb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/stifb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/stifb.c  (mode:100644)
@@ -1147,7 +1147,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor      = soft_cursor,
 };
 
 
Index: drivers/video/tcx.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/tcx.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/tcx.c  (mode:100644)
@@ -52,7 +52,6 @@
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= tcx_mmap,
 	.fb_ioctl		= tcx_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* THC definitions */
Index: drivers/video/tdfxfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/tdfxfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/tdfxfb.c  (mode:100644)
@@ -184,7 +184,6 @@
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 #endif
-	.fb_cursor	= soft_cursor,
 };
 
 /*
Index: drivers/video/tgafb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/tgafb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/tgafb.c  (mode:100644)
@@ -63,7 +63,6 @@
 	.fb_fillrect		= tgafb_fillrect,
 	.fb_copyarea		= tgafb_copyarea,
 	.fb_imageblit		= tgafb_imageblit,
-	.fb_cursor		= soft_cursor,
 };
 
 
Index: drivers/video/tridentfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/tridentfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/tridentfb.c  (mode:100644)
@@ -1282,7 +1282,6 @@
 	.fb_fillrect = tridentfb_fillrect,
 	.fb_copyarea= tridentfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_cursor = soft_cursor,
 };
 
 module_init(tridentfb_init);
Index: drivers/video/tx3912fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/tx3912fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/tx3912fb.c  (mode:100644)
@@ -89,7 +89,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int tx3912fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
Index: drivers/video/valkyriefb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/valkyriefb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/valkyriefb.c  (mode:100644)
@@ -135,7 +135,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /* Sets the video mode according to info->var */
Index: drivers/video/vesafb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/vesafb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/vesafb.c  (mode:100644)
@@ -213,7 +213,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int __init vesafb_setup(char *options)
Index: drivers/video/vfb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/vfb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/vfb.c  (mode:100644)
@@ -90,7 +90,6 @@
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= vfb_mmap,
 };
 
Index: drivers/video/vga16fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/vga16fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/vga16fb.c  (mode:100644)
@@ -1326,7 +1326,6 @@
 	.fb_fillrect	= vga16fb_fillrect,
 	.fb_copyarea	= vga16fb_copyarea,
 	.fb_imageblit	= vga16fb_imageblit,
-	.fb_cursor      = soft_cursor,
 };
 
 #ifndef MODULE
Index: drivers/video/w100fb.c
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/drivers/video/w100fb.c  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/drivers/video/w100fb.c  (mode:100644)
@@ -473,7 +473,6 @@
 	.fb_fillrect = cfb_fillrect,
 	.fb_copyarea = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_cursor = soft_cursor,
 };
 
 
Index: include/linux/fb.h
===================================================================
--- 86b5df80031a3c68459cc684c4ee9e00e9e38873/include/linux/fb.h  (mode:100644)
+++ 67f1f768d5c715e7bd5fcd8fa71f946e883869ea/include/linux/fb.h  (mode:100644)
@@ -808,7 +808,6 @@
 extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var); 
 extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var); 
 extern int fb_blank(struct fb_info *info, int blank);
-extern int soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect); 
 extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area); 
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
