From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/17] fbcon/fbdev: Move softcursor out of fbdev to fbcon
Date: Tue, 18 Oct 2005 17:13:12 +0800
Message-ID: <4354BCA8.3030509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyHq-0000Zh-BD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:18 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyHp-0000dG-Cr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:18 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395707nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:11 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

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

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/68328fb.c                |    1 
 drivers/video/Kconfig                  |   79 ---------------------------------
 drivers/video/Makefile                 |    1 
 drivers/video/acornfb.c                |    1 
 drivers/video/amba-clcd.c              |    1 
 drivers/video/amifb.c                  |    1 
 drivers/video/arcfb.c                  |    1 
 drivers/video/asiliantfb.c             |    1 
 drivers/video/aty/aty128fb.c           |    1 
 drivers/video/aty/atyfb_base.c         |    1 
 drivers/video/aty/radeon_base.c        |    1 
 drivers/video/bw2.c                    |    1 
 drivers/video/cg14.c                   |    1 
 drivers/video/cg3.c                    |    1 
 drivers/video/cg6.c                    |    1 
 drivers/video/chipsfb.c                |    1 
 drivers/video/cirrusfb.c               |    1 
 drivers/video/clps711xfb.c             |    1 
 drivers/video/console/Makefile         |    2 
 drivers/video/console/bitblit.c        |    7 ++
 drivers/video/console/fbcon.h          |    2 
 drivers/video/console/softcursor.c     |   72 ++++++++++++++++++++++++++++++
 drivers/video/controlfb.c              |    1 
 drivers/video/cyber2000fb.c            |    1 
 drivers/video/cyblafb.c                |    1 
 drivers/video/dnfb.c                   |    1 
 drivers/video/epson1355fb.c            |    1 
 drivers/video/ffb.c                    |    3 -
 drivers/video/fm2fb.c                  |    1 
 drivers/video/gbefb.c                  |    1 
 drivers/video/geode/Kconfig            |    1 
 drivers/video/geode/gx1fb_core.c       |    1 
 drivers/video/hitfb.c                  |    1 
 drivers/video/hpfb.c                   |    1 
 drivers/video/imsttfb.c                |    1 
 drivers/video/imxfb.c                  |    1 
 drivers/video/intelfb/intelfbdrv.c     |    2 
 drivers/video/kyro/fbdev.c             |    1 
 drivers/video/leo.c                    |    1 
 drivers/video/macfb.c                  |    1 
 drivers/video/matrox/matroxfb_accel.c  |    2 
 drivers/video/matrox/matroxfb_crtc2.c  |    1 
 drivers/video/maxinefb.c               |    1 
 drivers/video/neofb.c                  |    1 
 drivers/video/nvidia/nvidia.c          |    2 
 drivers/video/offb.c                   |    1 
 drivers/video/p9100.c                  |    1 
 drivers/video/platinumfb.c             |    1 
 drivers/video/pm2fb.c                  |    1 
 drivers/video/pmag-ba-fb.c             |    1 
 drivers/video/pmagb-b-fb.c             |    1 
 drivers/video/pvr2fb.c                 |    1 
 drivers/video/pxafb.c                  |    1 
 drivers/video/q40fb.c                  |    1 
 drivers/video/radeonfb.c               |    1 
 drivers/video/s1d13xxxfb.c             |    1 
 drivers/video/s3c2410fb.c              |    1 
 drivers/video/sa1100fb.c               |    1 
 drivers/video/savage/savagefb_driver.c |    1 
 drivers/video/sgivwfb.c                |    1 
 drivers/video/sis/sis_main.c           |    2 
 drivers/video/skeletonfb.c             |    9 +--
 drivers/video/softcursor.c             |   72 ------------------------------
 drivers/video/sstfb.c                  |    1 
 drivers/video/stifb.c                  |    1 
 drivers/video/tcx.c                    |    1 
 drivers/video/tdfxfb.c                 |    1 
 drivers/video/tgafb.c                  |    1 
 drivers/video/tridentfb.c              |    1 
 drivers/video/tx3912fb.c               |    1 
 drivers/video/valkyriefb.c             |    1 
 drivers/video/vesafb.c                 |    1 
 drivers/video/vfb.c                    |    1 
 drivers/video/vga16fb.c                |    1 
 drivers/video/w100fb.c                 |    1 
 include/linux/fb.h                     |    1 
 76 files changed, 88 insertions(+), 230 deletions(-)


diff --git a/drivers/video/68328fb.c b/drivers/video/68328fb.c
--- a/drivers/video/68328fb.c
+++ b/drivers/video/68328fb.c
@@ -113,7 +113,6 @@ static struct fb_ops mc68x328fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= mc68x328fb_mmap,
 };
 
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -65,15 +65,6 @@ config FB_CFB_IMAGEBLIT
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
@@ -114,7 +105,6 @@ config FB_CIRRUS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
@@ -133,7 +123,6 @@ config FB_PM2
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
@@ -152,7 +141,6 @@ config FB_ARMCLCD
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
@@ -169,7 +157,6 @@ config FB_ACORN
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Acorn VIDC graphics
 	  hardware found in Acorn RISC PCs and other ARM-based machines.  If
@@ -181,7 +168,6 @@ config FB_CLPS711X
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y to enable the Framebuffer driver for the CLPS7111 and
 	  EP7212 processors.
@@ -192,7 +178,6 @@ config FB_SA1100
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is a framebuffer device for the SA-1100 LCD Controller.
 	  See <http://www.linux-fbdev.org/> for information on framebuffer
@@ -207,7 +192,6 @@ config FB_IMX
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
@@ -215,7 +199,6 @@ config FB_CYBER2000
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Integraphics CyberPro 20x0 and 5000
 	  VGA chips used in the Rebel.com Netwinder and other machines.
@@ -228,7 +211,6 @@ config FB_APOLLO
 	default y
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 
 config FB_Q40
 	bool
@@ -237,12 +219,10 @@ config FB_Q40
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
@@ -282,7 +262,6 @@ config FB_CYBER
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Cybervision 64 graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -297,7 +276,6 @@ config FB_VIRGE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Cybervision 64/3D graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -320,7 +298,6 @@ config FB_FM2
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Amiga FrameMaster
 	  card from BSC (exhibited 1992 but not shipped as a CBM product).
@@ -331,7 +308,6 @@ config FB_ARC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Arc Monochrome LCD board. The board
 	  is based on the KS-108 lcd controller and is typically a matrix
@@ -354,7 +330,6 @@ config FB_OF
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  Say Y if you want support with Open Firmware for your graphics
@@ -366,7 +341,6 @@ config FB_CONTROL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  This driver supports a frame buffer for the graphics adapter in the
@@ -378,7 +352,6 @@ config FB_PLATINUM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  This driver supports a frame buffer for the "platinum" graphics
@@ -390,7 +363,6 @@ config FB_VALKYRIE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 	help
 	  This driver supports a frame buffer for the "valkyrie" graphics
@@ -402,7 +374,6 @@ config FB_CT65550
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Chips & Technologies
 	  65550 graphics chip in PowerBooks.
@@ -413,13 +384,11 @@ config FB_ASILIANT
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
@@ -431,7 +400,6 @@ config FB_VGA16
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for VGA 16 color graphic
 	  cards. Say Y if you have such a card.
@@ -445,7 +413,6 @@ config FB_STI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	default y
 	---help---
 	  STI refers to the HP "Standard Text Interface" which is a set of
@@ -466,7 +433,6 @@ config FB_MAC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES
 
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
@@ -475,7 +441,6 @@ config FB_HP300
 	depends on (FB = y) && HP300
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	default y
 
 config FB_TGA
@@ -484,7 +449,6 @@ config FB_TGA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for generic TGA graphic
 	  cards. Say Y if you have one of those.
@@ -495,7 +459,6 @@ config FB_VESA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -513,7 +476,6 @@ config FB_HGA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you have a Hercules mono graphics card.
 
@@ -542,7 +504,6 @@ config FB_SGIVW
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  SGI Visual Workstation support for framebuffer graphics.
 
@@ -552,7 +513,6 @@ config FB_GBE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
  	help
 	  This is the frame buffer device driver for SGI Graphics Backend.
 	  This chip is used in SGI O2 and Visual Workstation 320/540.
@@ -580,7 +540,6 @@ config FB_BW2
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the BWtwo frame buffer.
 
@@ -589,7 +548,6 @@ config FB_CG3
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGthree frame buffer.
 
@@ -598,7 +556,6 @@ config FB_CG6
 	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 	  frame buffer.
@@ -609,7 +566,6 @@ config FB_PVR2
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a PowerVR 2 card in your box.  If you plan to
 	  run linux on your Dreamcast, you will have to say Y here.
@@ -631,7 +587,6 @@ config FB_EPSON1355
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Build in support for the SED1355 Epson Research Embedded RAMDAC
 	  LCD/CRT Controller (since redesignated as the S1D13505) as a
@@ -676,7 +631,6 @@ config FB_S1D13XXX
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for S1D13XXX framebuffer device family (currently only
 	  working with S1D13806). Product specs at
@@ -691,7 +645,6 @@ config FB_NVIDIA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
@@ -809,7 +762,6 @@ config FB_INTEL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.
@@ -832,7 +784,6 @@ config FB_MATROX
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_TILEBLITTING
 	select FB_MACMODES if PPC_PMAC
 	---help---
@@ -973,7 +924,6 @@ config FB_RADEON_OLD
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
@@ -991,7 +941,6 @@ config FB_RADEON
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC_OF
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
@@ -1029,7 +978,6 @@ config FB_ATY128
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC_PMAC
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
@@ -1045,7 +993,6 @@ config FB_ATY
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select FB_MACMODES if PPC
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
@@ -1103,7 +1050,6 @@ config FB_SAVAGE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports notebooks and computers with S3 Savage PCI/AGP
 	  chips.
@@ -1140,7 +1086,6 @@ config FB_SIS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the SiS 300, 315, 330
 	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.
@@ -1170,7 +1115,6 @@ config FB_NEOMAGIC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
 	  Say Y if you have such a graphics card. 
@@ -1184,7 +1128,6 @@ config FB_KYRO
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you have a STG4000 / Kyro / PowerVR 3 based
 	  graphics board.
@@ -1198,7 +1141,6 @@ config FB_3DFX
 	select FB_CFB_IMAGEBLIT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
-	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the 3Dfx Banshee/Voodoo3
 	  chips. Say Y if you have such a graphics board.
@@ -1220,7 +1162,6 @@ config FB_VOODOO1
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or 
 	  Voodoo2 (cvg) based graphics card.
@@ -1237,7 +1178,6 @@ config FB_CYBLA
 	tristate "Cyberblade/i1 support"
 	depends on FB && PCI
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	select VIDEO_SELECT
 	---help---
 	  This driver is supposed to support the Trident Cyberblade/i1
@@ -1265,7 +1205,6 @@ config FB_TRIDENT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  This driver is supposed to support graphics boards with the
 	  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
@@ -1314,7 +1253,6 @@ config FB_FFB
 	depends on FB_SBUS && SPARC64
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Creator, Creator3D,
 	  and Elite3D graphics boards.
@@ -1325,7 +1263,6 @@ config FB_TCX
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the TCX 24/8bit frame
 	  buffer.
@@ -1336,7 +1273,6 @@ config FB_CG14
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGfourteen frame
 	  buffer on Desktop SPARCsystems with the SX graphics option.
@@ -1347,7 +1283,6 @@ config FB_P9100
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the P9100 card
 	  supported on Sparcbook 3 machines.
@@ -1358,7 +1293,6 @@ config FB_LEO
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the SBUS-based Sun ZX
 	  (leo) frame buffer cards.
@@ -1373,7 +1307,6 @@ config FB_IGA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the framebuffer device for the INTERGRAPHICS 1680 and
 	  successor frame buffer cards.
@@ -1384,7 +1317,6 @@ config FB_HIT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Hitachi HD64461 LCD
 	  frame buffer card.
@@ -1395,7 +1327,6 @@ config FB_PMAG_AA
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
 	  used mainly in the MIPS-based DECstation series.
@@ -1406,7 +1337,6 @@ config FB_PMAG_BA
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
 	  used mainly in the MIPS-based DECstation series.
@@ -1417,7 +1347,6 @@ config FB_PMAGB_B
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
 	  in the MIPS-based DECstation series. The card is currently only
@@ -1429,7 +1358,6 @@ config FB_MAXINE
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Support for the onboard framebuffer (1024x768x8) in the Personal
 	  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
@@ -1441,7 +1369,6 @@ config FB_TX3912
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -1454,7 +1381,6 @@ config FB_G364
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  The G364 driver is the framebuffer used in MIPS Magnum 4000 and
 	  Olivetti M700-10 systems.
@@ -1465,7 +1391,6 @@ config FB_68328
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.
@@ -1476,7 +1401,6 @@ config FB_PXA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the built-in LCD controller in the Intel
 	  PXA2x0 processor.
@@ -1511,7 +1435,6 @@ config FB_W100
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
 
@@ -1528,7 +1451,6 @@ config FB_S3C2410
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the built-in LCD controller in the Samsung
 	  S3C2410 processor.
@@ -1552,7 +1474,6 @@ config FB_VIRTUAL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  This is a `virtual' frame buffer device. It operates on a chunk of
 	  unswappable kernel memory instead of on the memory of a graphics
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -16,7 +16,6 @@ fb-objs                           := $(f
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
 obj-$(CONFIG_FB_CFB_IMAGEBLIT) += cfbimgblt.o
-obj-$(CONFIG_FB_SOFT_CURSOR)   += softcursor.o
 obj-$(CONFIG_FB_MACMODES)      += macmodes.o
 
 # Hardware specific drivers go first
diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -926,7 +926,6 @@ static struct fb_ops acornfb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_mmap	= acornfb_mmap,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -332,7 +332,6 @@ static struct fb_ops clcdfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= clcdfb_mmap,
 };
 
diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -1185,7 +1185,6 @@ static struct fb_ops amifb_ops = {
 	.fb_fillrect	= amifb_fillrect,
 	.fb_copyarea	= amifb_copyarea,
 	.fb_imageblit	= amifb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl	= amifb_ioctl,
 };
 
diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -514,7 +514,6 @@ static struct fb_ops arcfb_ops = {
 	.fb_fillrect	= arcfb_fillrect,
 	.fb_copyarea	= arcfb_copyarea,
 	.fb_imageblit	= arcfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl 	= arcfb_ioctl,
 };
 
diff --git a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
--- a/drivers/video/asiliantfb.c
+++ b/drivers/video/asiliantfb.c
@@ -106,7 +106,6 @@ static struct fb_ops asiliantfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /* Calculate the ratios for the dot clocks without using a single long long
diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -478,7 +478,6 @@ static struct fb_ops aty128fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 #ifdef CONFIG_PMAC_BACKLIGHT
diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -292,7 +292,6 @@ static struct fb_ops atyfb_ops = {
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
-	.fb_cursor	= soft_cursor,
 #ifdef __sparc__
 	.fb_mmap	= atyfb_mmap,
 #endif
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -1873,7 +1873,6 @@ static struct fb_ops radeonfb_ops = {
 	.fb_fillrect		= radeonfb_fillrect,
 	.fb_copyarea		= radeonfb_copyarea,
 	.fb_imageblit		= radeonfb_imageblit,
-	.fb_cursor		= soft_cursor,
 };
 
 
diff --git a/drivers/video/bw2.c b/drivers/video/bw2.c
--- a/drivers/video/bw2.c
+++ b/drivers/video/bw2.c
@@ -51,7 +51,6 @@ static struct fb_ops bw2_ops = {
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= bw2_mmap,
 	.fb_ioctl		= bw2_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* OBio addresses for the bwtwo registers */
diff --git a/drivers/video/cg14.c b/drivers/video/cg14.c
--- a/drivers/video/cg14.c
+++ b/drivers/video/cg14.c
@@ -49,7 +49,6 @@ static struct fb_ops cg14_ops = {
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= cg14_mmap,
 	.fb_ioctl		= cg14_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 #define CG14_MCR_INTENABLE_SHIFT	7
diff --git a/drivers/video/cg3.c b/drivers/video/cg3.c
--- a/drivers/video/cg3.c
+++ b/drivers/video/cg3.c
@@ -50,7 +50,6 @@ static struct fb_ops cg3_ops = {
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= cg3_mmap,
 	.fb_ioctl		= cg3_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 
diff --git a/drivers/video/cg6.c b/drivers/video/cg6.c
--- a/drivers/video/cg6.c
+++ b/drivers/video/cg6.c
@@ -54,7 +54,6 @@ static struct fb_ops cg6_ops = {
 	.fb_sync		= cg6_sync,
 	.fb_mmap		= cg6_mmap,
 	.fb_ioctl		= cg6_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* Offset of interesting structures in the OBIO space */
diff --git a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
--- a/drivers/video/chipsfb.c
+++ b/drivers/video/chipsfb.c
@@ -91,7 +91,6 @@ static struct fb_ops chipsfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int chipsfb_check_var(struct fb_var_screeninfo *var,
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -548,7 +548,6 @@ static struct fb_ops cirrusfb_ops = {
 	.fb_fillrect	= cirrusfb_fillrect,
 	.fb_copyarea	= cirrusfb_copyarea,
 	.fb_imageblit	= cirrusfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*--- Hardware Specific Routines -------------------------------------------*/
diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
--- a/drivers/video/clps711xfb.c
+++ b/drivers/video/clps711xfb.c
@@ -219,7 +219,6 @@ static struct fb_ops clps7111fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int 
diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_PROM_CONSOLE)        += pro
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o font.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
-obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o font.o
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE) += fbcon.o bitblit.o font.o softcursor.o
 ifeq ($(CONFIG_FB_TILEBLITTING),y)
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     += tileblit.o
 endif
diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -272,6 +272,7 @@ static void bit_cursor(struct vc_data *v
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(p, vc->vc_y);
 	int attribute, use_sw = (vc->vc_cursor_type & 0x10);
+	int err = 1;
 	char *src;
 
 	cursor.set = 0;
@@ -408,7 +409,11 @@ static void bit_cursor(struct vc_data *v
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
diff --git a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h
+++ b/drivers/video/console/fbcon.h
@@ -167,5 +167,5 @@ extern void fbcon_set_tileops(struct vc_
 			      struct display *p, struct fbcon_ops *ops);
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
-
+extern int  soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 #endif /* _VIDEO_FBCON_H */
diff --git a/drivers/video/console/softcursor.c b/drivers/video/console/softcursor.c
new file mode 100644
--- /dev/null
+++ b/drivers/video/console/softcursor.c
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
diff --git a/drivers/video/controlfb.c b/drivers/video/controlfb.c
--- a/drivers/video/controlfb.c
+++ b/drivers/video/controlfb.c
@@ -176,7 +176,6 @@ static struct fb_ops controlfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 
diff --git a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c
+++ b/drivers/video/cyber2000fb.c
@@ -1064,7 +1064,6 @@ static struct fb_ops cyber2000fb_ops = {
 	.fb_fillrect	= cyber2000fb_fillrect,
 	.fb_copyarea	= cyber2000fb_copyarea,
 	.fb_imageblit	= cyber2000fb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_sync	= cyber2000fb_sync,
 };
 
diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
--- a/drivers/video/cyblafb.c
+++ b/drivers/video/cyblafb.c
@@ -968,7 +968,6 @@ static struct fb_ops cyblafb_ops __devin
 	.fb_fillrect = cyblafb_fillrect,
 	.fb_copyarea= cyblafb_copyarea,
 	.fb_imageblit = cyblafb_imageblit,
-	.fb_cursor = soft_cursor,
 };
 
 //==========================================================================
diff --git a/drivers/video/dnfb.c b/drivers/video/dnfb.c
--- a/drivers/video/dnfb.c
+++ b/drivers/video/dnfb.c
@@ -114,7 +114,6 @@ static struct fb_ops dn_fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= dnfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 struct fb_var_screeninfo dnfb_var __devinitdata = {
diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -482,7 +482,6 @@ static struct fb_ops epson1355fb_fbops =
 	.fb_imageblit 	= cfb_imageblit,
 	.fb_read 	= epson1355fb_read,
 	.fb_write 	= epson1355fb_write,
-	.fb_cursor 	= soft_cursor,
 };
 
 /* ------------------------------------------------------------------------- */
diff --git a/drivers/video/ffb.c b/drivers/video/ffb.c
--- a/drivers/video/ffb.c
+++ b/drivers/video/ffb.c
@@ -57,9 +57,6 @@ static struct fb_ops ffb_ops = {
 	.fb_sync		= ffb_sync,
 	.fb_mmap		= ffb_mmap,
 	.fb_ioctl		= ffb_ioctl,
-
-	/* XXX Use FFB hw cursor once fb cursor API is better understood... */
-	.fb_cursor		= soft_cursor,
 };
 
 /* Register layout and definitions */
diff --git a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
--- a/drivers/video/fm2fb.c
+++ b/drivers/video/fm2fb.c
@@ -172,7 +172,6 @@ static struct fb_ops fm2fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
     /*
diff --git a/drivers/video/gbefb.c b/drivers/video/gbefb.c
--- a/drivers/video/gbefb.c
+++ b/drivers/video/gbefb.c
@@ -1038,7 +1038,6 @@ static struct fb_ops gbefb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
diff --git a/drivers/video/geode/Kconfig b/drivers/video/geode/Kconfig
--- a/drivers/video/geode/Kconfig
+++ b/drivers/video/geode/Kconfig
@@ -14,7 +14,6 @@ config FB_GEODE_GX1
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
 	---help---
 	  Framebuffer driver for the display controller integrated into the
 	  AMD Geode GX1 processor.
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -275,7 +275,6 @@ static struct fb_ops gx1fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static struct fb_info * __init gx1fb_init_fbinfo(struct device *dev)
diff --git a/drivers/video/hitfb.c b/drivers/video/hitfb.c
--- a/drivers/video/hitfb.c
+++ b/drivers/video/hitfb.c
@@ -262,7 +262,6 @@ static struct fb_ops hitfb_ops = {
 	.fb_fillrect	= hitfb_fillrect,
 	.fb_copyarea	= hitfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 int __init hitfb_init(void)
diff --git a/drivers/video/hpfb.c b/drivers/video/hpfb.c
--- a/drivers/video/hpfb.c
+++ b/drivers/video/hpfb.c
@@ -193,7 +193,6 @@ static struct fb_ops hpfb_ops = {
 	.fb_fillrect	= hpfb_fillrect,
 	.fb_copyarea	= hpfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_sync	= hpfb_sync,
 };
 
diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1344,7 +1344,6 @@ static struct fb_ops imsttfb_ops = {
 	.fb_fillrect	= imsttfb_fillrect,
 	.fb_copyarea	= imsttfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl 	= imsttfb_ioctl,
 };
 
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -298,7 +298,6 @@ static struct fb_ops imxfb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= imxfb_blank,
-	.fb_cursor	= soft_cursor, /* FIXME: i.MX can do hardware cursor */
 };
 
 /*
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1485,7 +1485,7 @@ intelfb_cursor(struct fb_info *info, str
 #endif
 
 	if (!dinfo->hwcursor)
-		return soft_cursor(info, cursor);
+		return -ENODEV;
 
 	intelfbhw_cursor_hide(dinfo);
 
diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
--- a/drivers/video/kyro/fbdev.c
+++ b/drivers/video/kyro/fbdev.c
@@ -669,7 +669,6 @@ static struct fb_ops kyrofb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int __devinit kyrofb_probe(struct pci_dev *pdev,
diff --git a/drivers/video/leo.c b/drivers/video/leo.c
--- a/drivers/video/leo.c
+++ b/drivers/video/leo.c
@@ -51,7 +51,6 @@ static struct fb_ops leo_ops = {
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= leo_mmap,
 	.fb_ioctl		= leo_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 #define LEO_OFF_LC_SS0_KRN	0x00200000UL
diff --git a/drivers/video/macfb.c b/drivers/video/macfb.c
--- a/drivers/video/macfb.c
+++ b/drivers/video/macfb.c
@@ -589,7 +589,6 @@ static struct fb_ops macfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 void __init macfb_setup(char *options)
diff --git a/drivers/video/matrox/matroxfb_accel.c b/drivers/video/matrox/matroxfb_accel.c
--- a/drivers/video/matrox/matroxfb_accel.c
+++ b/drivers/video/matrox/matroxfb_accel.c
@@ -122,7 +122,7 @@ void matrox_cfbX_init(WPMINFO2) {
 	ACCESS_FBINFO(fbops).fb_copyarea = cfb_copyarea;
 	ACCESS_FBINFO(fbops).fb_fillrect = cfb_fillrect;
 	ACCESS_FBINFO(fbops).fb_imageblit = cfb_imageblit;
-	ACCESS_FBINFO(fbops).fb_cursor = soft_cursor;
+	ACCESS_FBINFO(fbops).fb_cursor = NULL;
 
 	accel = (ACCESS_FBINFO(fbcon).var.accel_flags & FB_ACCELF_TEXT) == FB_ACCELF_TEXT;
 
diff --git a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c
+++ b/drivers/video/matrox/matroxfb_crtc2.c
@@ -576,7 +576,6 @@ static struct fb_ops matroxfb_dh_ops = {
 	.fb_fillrect =	cfb_fillrect,
 	.fb_copyarea =	cfb_copyarea,
 	.fb_imageblit =	cfb_imageblit,
-	.fb_cursor =	soft_cursor,
 };
 
 static struct fb_var_screeninfo matroxfb_dh_defined = {
diff --git a/drivers/video/maxinefb.c b/drivers/video/maxinefb.c
--- a/drivers/video/maxinefb.c
+++ b/drivers/video/maxinefb.c
@@ -113,7 +113,6 @@ static struct fb_ops maxinefb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 int __init maxinefb_init(void)
diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -1665,7 +1665,6 @@ static struct fb_ops neofb_ops = {
 	.fb_fillrect	= neofb_fillrect,
 	.fb_copyarea	= neofb_copyarea,
 	.fb_imageblit	= neofb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /* --------------------------------------------------------------------- */
diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -1425,7 +1425,7 @@ static int __devinit nvidia_set_fbinfo(s
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
 	if (!hwcur)
-	    info->fbops->fb_cursor = soft_cursor;
+	    info->fbops->fb_cursor = NULL;
 
 	info->var.accel_flags = (!noaccel);
 
diff --git a/drivers/video/offb.c b/drivers/video/offb.c
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -85,7 +85,6 @@ static struct fb_ops offb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
     /*
diff --git a/drivers/video/p9100.c b/drivers/video/p9100.c
--- a/drivers/video/p9100.c
+++ b/drivers/video/p9100.c
@@ -48,7 +48,6 @@ static struct fb_ops p9100_ops = {
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= p9100_mmap,
 	.fb_ioctl		= p9100_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* P9100 control registers */
diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -109,7 +109,6 @@ static struct fb_ops platinumfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1034,7 +1034,6 @@ static struct fb_ops pm2fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /*
diff --git a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
--- a/drivers/video/pmag-ba-fb.c
+++ b/drivers/video/pmag-ba-fb.c
@@ -128,7 +128,6 @@ static struct fb_ops pmagbafb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 
diff --git a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
--- a/drivers/video/pmagb-b-fb.c
+++ b/drivers/video/pmagb-b-fb.c
@@ -132,7 +132,6 @@ static struct fb_ops pmagbbfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -230,7 +230,6 @@ static struct fb_ops pvr2fb_ops = {
 	.fb_fillrect 	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static struct fb_videomode pvr2_modedb[] __initdata = {
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -418,7 +418,6 @@ static struct fb_ops pxafb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= pxafb_blank,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= pxafb_mmap,
 };
 
diff --git a/drivers/video/q40fb.c b/drivers/video/q40fb.c
--- a/drivers/video/q40fb.c
+++ b/drivers/video/q40fb.c
@@ -83,7 +83,6 @@ static struct fb_ops q40fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int __init q40fb_probe(struct device *device)
diff --git a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c
+++ b/drivers/video/radeonfb.c
@@ -2218,7 +2218,6 @@ static struct fb_ops radeonfb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 #endif
-	.fb_cursor	= soft_cursor,
 };
 
 
diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -388,7 +388,6 @@ static struct fb_ops s1d13xxxfb_fbops = 
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor
 };
 
 static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -494,7 +494,6 @@ static struct fb_ops s3c2410fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -853,7 +853,6 @@ static struct fb_ops sa1100fb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_blank	= sa1100fb_blank,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= sa1100fb_mmap,
 };
 
diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1470,7 +1470,6 @@ static struct fb_ops savagefb_ops = {
 	.fb_copyarea    = cfb_copyarea,
 	.fb_imageblit   = cfb_imageblit,
 #endif
-	.fb_cursor      = soft_cursor,
 };
 
 /* --------------------------------------------------------------------- */
diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -124,7 +124,6 @@ static struct fb_ops sgivwfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= sgivwfb_mmap,
 };
 
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -2002,7 +2002,9 @@ static struct fb_ops sisfb_ops = {
 	.fb_fillrect	= fbcon_sis_fillrect,
 	.fb_copyarea	= fbcon_sis_copyarea,
 	.fb_imageblit	= cfb_imageblit,
+#ifdef CONFIG_FB_SOFT_CURSOR
 	.fb_cursor	= soft_cursor,
+#endif
 	.fb_sync	= fbcon_sis_sync,
 #ifdef SIS_NEW_CONFIG_COMPAT
 	.fb_compat_ioctl= sisfb_compat_ioctl,
diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -457,11 +457,8 @@ void xxxfb_imageblit(struct fb_info *p, 
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
@@ -663,7 +660,7 @@ static struct fb_ops xxxfb_ops = {
 	.fb_fillrect	= xxxfb_fillrect, 	/* Needed !!! */ 
 	.fb_copyarea	= xxxfb_copyarea,	/* Needed !!! */ 
 	.fb_imageblit	= xxxfb_imageblit,	/* Needed !!! */
-	.fb_cursor	= xxxfb_cursor,		/* Needed !!! */
+	.fb_cursor	= xxxfb_cursor,		/* Optional !!! */
 	.fb_rotate	= xxxfb_rotate,
 	.fb_poll	= xxxfb_poll,
 	.fb_sync	= xxxfb_sync,
diff --git a/drivers/video/softcursor.c b/drivers/video/softcursor.c
--- a/drivers/video/softcursor.c
+++ b/drivers/video/softcursor.c
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
diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -1382,7 +1382,6 @@ static struct fb_ops sstfb_ops = {
 	.fb_fillrect	= cfb_fillrect, /* sstfb_fillrect */
 	.fb_copyarea	= cfb_copyarea, /* sstfb_copyarea */
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_ioctl	= sstfb_ioctl,
 };
 
diff --git a/drivers/video/stifb.c b/drivers/video/stifb.c
--- a/drivers/video/stifb.c
+++ b/drivers/video/stifb.c
@@ -1147,7 +1147,6 @@ static struct fb_ops stifb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor      = soft_cursor,
 };
 
 
diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -52,7 +52,6 @@ static struct fb_ops tcx_ops = {
 	.fb_imageblit		= cfb_imageblit,
 	.fb_mmap		= tcx_mmap,
 	.fb_ioctl		= tcx_ioctl,
-	.fb_cursor		= soft_cursor,
 };
 
 /* THC definitions */
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -184,7 +184,6 @@ static struct fb_ops tdfxfb_ops = {
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 #endif
-	.fb_cursor	= soft_cursor,
 };
 
 /*
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -63,7 +63,6 @@ static struct fb_ops tgafb_ops = {
 	.fb_fillrect		= tgafb_fillrect,
 	.fb_copyarea		= tgafb_copyarea,
 	.fb_imageblit		= tgafb_imageblit,
-	.fb_cursor		= soft_cursor,
 };
 
 
diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -1293,7 +1293,6 @@ static struct fb_ops tridentfb_ops = {
 	.fb_fillrect = tridentfb_fillrect,
 	.fb_copyarea= tridentfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_cursor = soft_cursor,
 };
 
 module_init(tridentfb_init);
diff --git a/drivers/video/tx3912fb.c b/drivers/video/tx3912fb.c
--- a/drivers/video/tx3912fb.c
+++ b/drivers/video/tx3912fb.c
@@ -89,7 +89,6 @@ static struct fb_ops tx3912fb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int tx3912fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
diff --git a/drivers/video/valkyriefb.c b/drivers/video/valkyriefb.c
--- a/drivers/video/valkyriefb.c
+++ b/drivers/video/valkyriefb.c
@@ -135,7 +135,6 @@ static struct fb_ops valkyriefb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 /* Sets the video mode according to info->var */
diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c
+++ b/drivers/video/vesafb.c
@@ -213,7 +213,6 @@ static struct fb_ops vesafb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 };
 
 static int __init vesafb_setup(char *options)
diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -90,7 +90,6 @@ static struct fb_ops vfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,
 	.fb_mmap	= vfb_mmap,
 };
 
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1326,7 +1326,6 @@ static struct fb_ops vga16fb_ops = {
 	.fb_fillrect	= vga16fb_fillrect,
 	.fb_copyarea	= vga16fb_copyarea,
 	.fb_imageblit	= vga16fb_imageblit,
-	.fb_cursor      = soft_cursor,
 };
 
 #ifndef MODULE
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -397,7 +397,6 @@ static struct fb_ops w100fb_ops = {
 	.fb_fillrect  = cfb_fillrect,
 	.fb_copyarea  = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_cursor    = soft_cursor,
 };
 
 #ifdef CONFIG_PM
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -810,7 +810,6 @@ struct fb_info {
 extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var); 
 extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var); 
 extern int fb_blank(struct fb_info *info, int blank);
-extern int soft_cursor(struct fb_info *info, struct fb_cursor *cursor);
 extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect); 
 extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area); 
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
