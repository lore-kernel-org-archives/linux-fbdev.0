From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/7] fbdev: Kbuild cleanups
Date: Thu, 17 Feb 2005 20:45:25 +0800
Message-ID: <200502172045.25601.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1l53-0000iO-Ad
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:48:29 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D1l4y-0008UN-LK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Feb 2005 04:48:29 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 08898DE3AD7
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Feb 2005 12:48:18 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David Vrabel <dvrabel@arcom.com>

=46rom David Vrabel <dvrabel@arcom.com>:

This set of two patches add new options (FB_CFB_IMAGEBLIT, FB_CFB_FILLRECT,
=46B_CFB_COPYAREA, FB_SOFT_CURSOR) to the framebuffer Kconfig to enable
building the generic software cfbfillrect, cfbcopyarea, cfbimageblt and
softcursor objects.  This cuts out a lot of stuff from the Makefile and
allows drivers in their own directory to be more self-contained.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 Kconfig  |  290 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 Makefile |  147 ++++++++++++++-----------------
 2 files changed, 358 insertions(+), 79 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
=2D-- a/drivers/video/Kconfig	2005-02-15 21:03:40 +08:00
+++ b/drivers/video/Kconfig	2005-02-16 08:18:11 +08:00
@@ -38,6 +38,42 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
=20
+config FB_CFB_FILLRECT
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the cfb_fillrect function for generic software rectangle
+	  filling. This is used by drivers that don't provide their own
+	  (accelerated) version.
+
+config FB_CFB_COPYAREA
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the cfb_copyarea function for generic software area copying.
+	  This is used by drivers that don't provide their own (accelerated)
+	  version.
+
+config FB_CFB_IMAGEBLIT
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the cfb_imageblit function for generic software image
+	  blitting. This is used by drivers that don't provide their own
+	  (accelerated) version.
+
+config FB_SOFT_CURSOR
+	tristate
+	depends on FB
+	default n
+	---help---
+	  Include the soft_cursor function for generic software cursor support.
+	  This is used by drivers that don't provide their own (accelerated)
+	  version.
+
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
@@ -70,6 +106,10 @@
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (ZORRO || PCI)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
@@ -85,6 +125,10 @@
 config FB_PM2
 	tristate "Permedia2 support"
 	depends on FB && ((AMIGA && BROKEN) || PCI)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
@@ -100,6 +144,10 @@
 config FB_ARMCLCD
 	tristate "ARM PrimeCell PL110 support"
 	depends on FB && ARM && ARM_AMBA
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
@@ -113,6 +161,10 @@
 config FB_ACORN
 	bool "Acorn VIDC support"
 	depends on FB && ARM && ARCH_ACORN
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Acorn VIDC graphics
 	  hardware found in Acorn RISC PCs and other ARM-based machines.  If
@@ -121,10 +173,18 @@
 config FB_CLPS711X
 	bool "CLPS711X LCD support"
 	depends on FB && ARM && ARCH_CLPS711X
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
=20
 config FB_SA1100
 	bool "SA-1100 LCD support"
 	depends on FB && ARM && ARCH_SA1100
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is a framebuffer device for the SA-1100 LCD Controller.
 	  See <http://www.linux-fbdev.org/> for information on framebuffer
@@ -136,6 +196,10 @@
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
 	depends on FB && PCI && (BROKEN || !SPARC64)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Integraphics CyberPro 20x0 and 5000
 	  VGA chips used in the Rebel.com Netwinder and other machines.
@@ -146,15 +210,23 @@
 	bool
 	depends on FB && APOLLO
 	default y
+	select FB_CFB_FILLRECT
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
=20
 config FB_Q40
 	bool
 	depends on FB && Q40
 	default y
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
=20
 config FB_AMIGA
 	tristate "Amiga native chipset support"
 	depends on FB && AMIGA
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the builtin graphics
 	  chipset found in Amigas.
@@ -191,6 +263,10 @@
 config FB_CYBER
 	tristate "Amiga CyberVision 64 support"
 	depends on FB && ZORRO && BROKEN
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Cybervision 64 graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -202,6 +278,10 @@
 config FB_VIRGE
 	bool "Amiga CyberVision 64/3D support "
 	depends on FB && ZORRO && BROKEN
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This enables support for the Cybervision 64/3D graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -221,6 +301,10 @@
 config FB_FM2
 	bool "Amiga FrameMaster II/Rainbow II support"
 	depends on FB && ZORRO
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Amiga FrameMaster
 	  card from BSC (exhibited 1992 but not shipped as a CBM product).
@@ -235,6 +319,10 @@
 config FB_OF
 	bool "Open Firmware frame buffer device support"
 	depends on FB && (PPC64 || PPC_OF)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Say Y if you want support with Open Firmware for your graphics
 	  board.
@@ -242,6 +330,10 @@
 config FB_CONTROL
 	bool "Apple \"control\" display support"
 	depends on FB && PPC_PMAC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports a frame buffer for the graphics adapter in the
 	  Power Macintosh 7300 and others.
@@ -249,6 +341,10 @@
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
 	depends on FB && PPC_PMAC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports a frame buffer for the "platinum" graphics
 	  adapter in some Power Macintoshes.
@@ -256,6 +352,10 @@
 config FB_VALKYRIE
 	bool "Apple \"valkyrie\" display support"
 	depends on FB && (MAC || PPC_PMAC)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports a frame buffer for the "valkyrie" graphics
 	  adapter in some Power Macintoshes.
@@ -263,6 +363,10 @@
 config FB_CT65550
 	bool "Chips 65550 display support"
 	depends on FB && PPC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Chips & Technologies
 	  65550 graphics chip in PowerBooks.
@@ -270,10 +374,16 @@
 config FB_ASILIANT
 	bool "Chips 69000 display support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
=20
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"
 	depends on FB && PCI
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
@@ -287,6 +397,10 @@
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
 	depends on FB && (X86 || PPC)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for VGA 16 color graphic
 	  cards. Say Y if you have such a card.
@@ -297,6 +411,10 @@
 config FB_STI
 	tristate "HP STI frame buffer device support"
 	depends on FB && PARISC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	default y
 	---help---
 	  STI refers to the HP "Standard Text Interface" which is a set of
@@ -314,16 +432,27 @@
 config FB_MAC
 	bool "Generic Macintosh display support"
 	depends on FB && MAC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
=20
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
 config FB_HP300
 	bool
 	depends on FB && HP300
+	select FB_CFB_FILLRECT
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	default y
=20
 config FB_TGA
 	tristate "TGA framebuffer support"
 	depends on FB && ALPHA
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for generic TGA graphic
 	  cards. Say Y if you have one of those.
@@ -331,6 +460,10 @@
 config FB_VESA
 	bool "VESA VGA graphics support"
 	depends on FB && (X86 || X86_64)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -345,6 +478,10 @@
 config FB_HGA
 	tristate "Hercules mono graphics support"
 	depends on FB && X86
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you have a Hercules mono graphics card.
=20
@@ -370,12 +507,20 @@
 config FB_SGIVW
 	tristate "SGI Visual Workstation framebuffer support"
 	depends on FB && X86_VISWS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  SGI Visual Workstation support for framebuffer graphics.
=20
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
 	depends on FB && (SGI_IP32 || X86_VISWS)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
  	help
 	  This is the frame buffer device driver for SGI Graphics Backend.
 	  This chip is used in SGI O2 and Visual Workstation 320/540.
@@ -400,18 +545,28 @@
 config FB_BW2
 	bool "BWtwo support"
 	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && F=
B_SUN3)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the BWtwo frame buffer.
=20
 config FB_CG3
 	bool "CGthree support"
 	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && F=
B_SUN3)
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGthree frame buffer.
=20
 config FB_CG6
 	bool "CGsix (GX,TurboGX) support"
 	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && F=
B_SUN3)
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 	  frame buffer.
@@ -419,6 +574,10 @@
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
 	depends on FB && SH_DREAMCAST
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a PowerVR 2 card in your box.  If you plan to
 	  run linux on your Dreamcast, you will have to say Y here.
@@ -437,6 +596,10 @@
 config FB_EPSON1355
 	bool "Epson 1355 framebuffer support"
 	depends on FB && (SUPERH || ARCH_CEIVA)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Build in support for the SED1355 Epson Research Embedded RAMDAC
 	  LCD/CRT Controller (since redesignated as the S1D13505) as a
@@ -449,6 +612,10 @@
 	select I2C_ALGOBIT if FB_RIVA_I2C
 	select I2C if FB_RIVA_I2C
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -484,6 +651,10 @@
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel 810=20
           and 815 chipsets.  Say Y if you have and plan to use such a boar=
d.
@@ -523,6 +694,10 @@
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G chipsets.
@@ -542,6 +717,10 @@
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 	  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -677,6 +856,10 @@
 config FB_RADEON_OLD
 	tristate "ATI Radeon display support (Old driver)"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
@@ -690,6 +873,10 @@
 	select I2C_ALGOBIT if FB_RADEON_I2C
 	select I2C if FB_RADEON_I2C
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
@@ -724,6 +911,10 @@
 config FB_ATY128
 	tristate "ATI Rage128 display support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
 	  Say Y if you have such a graphics board and read
@@ -735,6 +926,10 @@
 config FB_ATY
 	tristate "ATI Mach64 display support" if PCI || ATARI
 	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
 	  Say Y if you have such a graphics board.
@@ -782,6 +977,10 @@
 	select I2C_ALGOBIT if FB_SAVAGE_I2C
 	select I2C if FB_SAVAGE_I2C
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports notebooks and computers with S3 Savage PCI/AGP
 	  chips.
@@ -815,6 +1014,10 @@
 config FB_SIS
 	tristate "SiS acceleration"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the SiS 300, 315 and
 	  330 series VGA chipsets. Specs available at <http://www.sis.com>
@@ -839,6 +1042,10 @@
 	tristate "NeoMagic display support"
 	depends on FB && PCI
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
 	  Say Y if you have such a graphics card.=20
@@ -849,6 +1056,10 @@
 config FB_KYRO
 	tristate "IMG Kyro support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you have a STG4000 / Kyro / PowerVR 3 based
 	  graphics board.
@@ -859,6 +1070,10 @@
 config FB_3DFX
 	tristate "3Dfx Banshee/Voodoo3 display support"
 	depends on FB && PCI
+	select FB_CFB_IMAGEBLIT
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_SOFT_CURSOR
 	help
 	  This driver supports graphics boards with the 3Dfx Banshee/Voodoo3
 	  chips. Say Y if you have such a graphics board.
@@ -877,6 +1092,10 @@
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or=20
 	  Voodoo2 (cvg) based graphics card.
@@ -892,6 +1111,10 @@
 config FB_TRIDENT
 	tristate "Trident support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  This driver is supposed to support graphics boards with the
 	  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
@@ -965,6 +1188,9 @@
 config FB_FFB
 	bool "Creator/Creator3D/Elite3D support"
 	depends on FB_SBUS && SPARC64
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Creator, Creator3D,
 	  and Elite3D graphics boards.
@@ -972,6 +1198,10 @@
 config FB_TCX
 	bool "TCX (SS4/SS5 only) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the TCX 24/8bit frame
 	  buffer.
@@ -979,6 +1209,10 @@
 config FB_CG14
 	bool "CGfourteen (SX) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the CGfourteen frame
 	  buffer on Desktop SPARCsystems with the SX graphics option.
@@ -986,6 +1220,10 @@
 config FB_P9100
 	bool "P9100 (Sparcbook 3 only) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the P9100 card
 	  supported on Sparcbook 3 machines.
@@ -993,6 +1231,10 @@
 config FB_LEO
 	bool "Leo (ZX) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the SBUS-based Sun ZX
 	  (leo) frame buffer cards.
@@ -1004,6 +1246,10 @@
 config FB_IGA
 	bool "IGA 168x display support"
 	depends on SPARC32 && FB_PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the framebuffer device for the INTERGRAPHICS 1680 and
 	  successor frame buffer cards.
@@ -1011,6 +1257,10 @@
 config FB_HIT
 	tristate "HD64461 Frame Buffer support"
 	depends on FB && HD64461
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  This is the frame buffer device driver for the Hitachi HD64461 LCD
 	  frame buffer card.
@@ -1018,6 +1268,10 @@
 config FB_PMAG_AA
 	bool "PMAG-AA TURBOchannel framebuffer support"
 	depends on FB && MACH_DECSTATION && TC
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
 	  used mainly in the MIPS-based DECstation series.
@@ -1025,6 +1279,10 @@
 config FB_PMAG_BA
 	bool "PMAG-BA TURBOchannel framebuffer support"
 	depends on FB && MACH_DECSTATION && TC
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
 	  used mainly in the MIPS-based DECstation series.
@@ -1032,6 +1290,10 @@
 config FB_PMAGB_B
 	bool "PMAGB-B TURBOchannel framebuffer support"
 	depends on FB && MACH_DECSTATION && TC
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
 	  in the MIPS-based DECstation series. The card is currently only
@@ -1040,6 +1302,10 @@
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"
 	depends on FB && MACH_DECSTATION && TC
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Support for the onboard framebuffer (1024x768x8) in the Personal
 	  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
@@ -1048,6 +1314,10 @@
 config FB_TX3912
 	bool "TMPTX3912/PR31700 frame buffer support"
 	depends on FB && NINO
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -1057,6 +1327,10 @@
 config FB_G364
 	bool
 	depends on MIPS_MAGNUM_4000 || OLIVETTI_M700
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  The G364 driver is the framebuffer used in MIPS Magnum 4000 and
 	  Olivetti M700-10 systems.
@@ -1064,6 +1338,10 @@
 config FB_68328
 	bool "Motorola 68328 native frame buffer support"
 	depends on FB && (M68328 || M68EZ328 || M68VZ328)
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	help
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.
@@ -1071,6 +1349,10 @@
 config FB_PXA
 	tristate "PXA LCD framebuffer support"
 	depends on FB && ARCH_PXA
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the built-in LCD controller in the Intel
 	  PXA2x0 processor.
@@ -1101,6 +1383,10 @@
 config FB_W100
 	tristate "W100 frame buffer support"
 	depends on FB && PXA_SHARPSL
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
=20
@@ -1114,6 +1400,10 @@
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
 	---help---
 	  This is a `virtual' frame buffer device. It operates on a chunk of
 	  unswappable kernel memory instead of on the memory of a graphics
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
=2D-- a/drivers/video/Makefile	2005-02-01 23:45:01 +08:00
+++ b/drivers/video/Makefile	2005-02-15 18:12:59 +08:00
@@ -8,102 +8,91 @@
 obj-$(CONFIG_LOGO)		  +=3D logo/
 obj-$(CONFIG_SYSFS)		  +=3D backlight/
=20
=2Dobj-$(CONFIG_FB)                  +=3D fbmem.o fbmon.o fbcmap.o fbsysfs.=
o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  +=3D fbmem.o fbmon.o fbcmap.o fbsysfs.o =
modedb.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 +=3D macmodes.o
 endif
=20
+obj-$(CONFIG_FB_CFB_FILLRECT)  +=3D cfbfillrect.o
+obj-$(CONFIG_FB_CFB_COPYAREA)  +=3D cfbcopyarea.o
+obj-$(CONFIG_FB_CFB_IMAGEBLIT) +=3D cfbimgblt.o
+obj-$(CONFIG_FB_SOFT_CURSOR)   +=3D softcursor.o
+
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         +=3D retz3fb.o
 obj-$(CONFIG_FB_AMIGA)            +=3D amifb.o c2p.o
=2Dobj-$(CONFIG_FB_CLPS711X)         +=3D clps711xfb.o cfbfillrect.o cfbcop=
yarea.o cfbimgblt.o
+obj-$(CONFIG_FB_CLPS711X)         +=3D clps711xfb.o
 obj-$(CONFIG_FB_CYBER)            +=3D cyberfb.o
=2Dobj-$(CONFIG_FB_CYBER2000)        +=3D cyber2000fb.o cfbfillrect.o cfbco=
pyarea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_PM2)              +=3D pm2fb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
+obj-$(CONFIG_FB_CYBER2000)        +=3D cyber2000fb.o
+obj-$(CONFIG_FB_PM2)              +=3D pm2fb.o
 obj-$(CONFIG_FB_PM3)		  +=3D pm3fb.o
=20
=2Dobj-$(CONFIG_FB_MATROX)		  +=3D matrox/ cfbfillrect.o cfbcopyarea.o cfbi=
mgblt.o
=2Dobj-$(CONFIG_FB_RIVA)		  +=3D riva/ cfbimgblt.o cfbfillrect.o \
=2D				     cfbcopyarea.o vgastate.o
=2Dobj-$(CONFIG_FB_ATY)		  +=3D aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_ATY128)		  +=3D aty/ cfbcopyarea.o cfbfillrect.o cfbimgb=
lt.o
=2Dobj-$(CONFIG_FB_RADEON)		  +=3D aty/ cfbcopyarea.o cfbfillrect.o cfbimgb=
lt.o
=2Dobj-$(CONFIG_FB_SIS)		  +=3D sis/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_KYRO)             +=3D kyro/ cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
=2Dobj-$(CONFIG_FB_SAVAGE)		  +=3D savage/ cfbfillrect.o cfbcopyarea.o \
=2D				     cfbimgblt.o
=2Dobj-$(CONFIG_FB_I810)             +=3D cfbcopyarea.o cfbfillrect.o cfbim=
gblt.o \
=2D				     vgastate.o
=2Dobj-$(CONFIG_FB_INTEL)            +=3D cfbfillrect.o cfbcopyarea.o \
=2D	                             cfbimgblt.o
=2D
=2Dobj-$(CONFIG_FB_RADEON_OLD)	  +=3D radeonfb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
=2Dobj-$(CONFIG_FB_NEOMAGIC)         +=3D neofb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o vgastate.o
+obj-$(CONFIG_FB_MATROX)		  +=3D matrox/
+obj-$(CONFIG_FB_RIVA)		  +=3D riva/ vgastate.o
+obj-$(CONFIG_FB_ATY)		  +=3D aty/
+obj-$(CONFIG_FB_ATY128)		  +=3D aty/
+obj-$(CONFIG_FB_RADEON)		  +=3D aty/
+obj-$(CONFIG_FB_SIS)		  +=3D sis/
+obj-$(CONFIG_FB_KYRO)             +=3D kyro/
+obj-$(CONFIG_FB_SAVAGE)		  +=3D savage/
+obj-$(CONFIG_FB_I810)             +=3D vgastate.o
+obj-$(CONFIG_FB_RADEON_OLD)	  +=3D radeonfb.o
+obj-$(CONFIG_FB_NEOMAGIC)         +=3D neofb.o vgastate.o
 obj-$(CONFIG_FB_VIRGE)            +=3D virgefb.o
=2Dobj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o cfbimgblt.o
=2Difneq ($(CONFIG_FB_3DFX_ACCEL),y)
=2Dobj-$(CONFIG_FB_3DFX)             +=3D cfbfillrect.o cfbcopyarea.o
=2Dendif
=2Dobj-$(CONFIG_FB_CONTROL)          +=3D controlfb.o macmodes.o cfbfillrec=
t.o cfbcopyarea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_PLATINUM)         +=3D platinumfb.o macmodes.o cfbfillre=
ct.o cfbcopyarea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_VALKYRIE)         +=3D valkyriefb.o macmodes.o cfbfillre=
ct.o cfbcopyarea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_CT65550)          +=3D chipsfb.o cfbfillrect.o cfbcopyar=
ea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_IMSTT)            +=3D imsttfb.o cfbimgblt.o
+obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o
+obj-$(CONFIG_FB_CONTROL)          +=3D controlfb.o macmodes.o
+obj-$(CONFIG_FB_PLATINUM)         +=3D platinumfb.o macmodes.o
+obj-$(CONFIG_FB_VALKYRIE)         +=3D valkyriefb.o macmodes.o
+obj-$(CONFIG_FB_CT65550)          +=3D chipsfb.o
+obj-$(CONFIG_FB_IMSTT)            +=3D imsttfb.o
 obj-$(CONFIG_FB_S3TRIO)           +=3D S3triofb.o
=2Dobj-$(CONFIG_FB_FM2)              +=3D fm2fb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_TRIDENT)	  +=3D tridentfb.o cfbfillrect.o cfbimgblt.o cf=
bcopyarea.o
=2Dobj-$(CONFIG_FB_STI)              +=3D stifb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_FFB)              +=3D ffb.o sbuslib.o cfbimgblt.o cfbco=
pyarea.o
=2Dobj-$(CONFIG_FB_CG6)              +=3D cg6.o sbuslib.o cfbimgblt.o cfbco=
pyarea.o
=2Dobj-$(CONFIG_FB_CG3)              +=3D cg3.o sbuslib.o cfbimgblt.o cfbco=
pyarea.o \
=2D				     cfbfillrect.o
=2Dobj-$(CONFIG_FB_BW2)              +=3D bw2.o sbuslib.o cfbimgblt.o cfbco=
pyarea.o \
=2D				     cfbfillrect.o
=2Dobj-$(CONFIG_FB_CG14)             +=3D cg14.o sbuslib.o cfbimgblt.o cfbc=
opyarea.o \
=2D				     cfbfillrect.o
=2Dobj-$(CONFIG_FB_P9100)            +=3D p9100.o sbuslib.o cfbimgblt.o cfb=
copyarea.o \
=2D				     cfbfillrect.o
=2Dobj-$(CONFIG_FB_TCX)              +=3D tcx.o sbuslib.o cfbimgblt.o cfbco=
pyarea.o \
=2D				     cfbfillrect.o
=2Dobj-$(CONFIG_FB_LEO)              +=3D leo.o sbuslib.o cfbimgblt.o cfbco=
pyarea.o \
=2D				     cfbfillrect.o
=2Dobj-$(CONFIG_FB_SGIVW)            +=3D sgivwfb.o cfbfillrect.o cfbcopyar=
ea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_ACORN)            +=3D acornfb.o cfbfillrect.o cfbcopyar=
ea.o cfbimgblt.o
+obj-$(CONFIG_FB_FM2)              +=3D fm2fb.o
+obj-$(CONFIG_FB_TRIDENT)	  +=3D tridentfb.o
+obj-$(CONFIG_FB_STI)              +=3D stifb.o
+obj-$(CONFIG_FB_FFB)              +=3D ffb.o sbuslib.o
+obj-$(CONFIG_FB_CG6)              +=3D cg6.o sbuslib.o
+obj-$(CONFIG_FB_CG3)              +=3D cg3.o sbuslib.o
+obj-$(CONFIG_FB_BW2)              +=3D bw2.o sbuslib.o
+obj-$(CONFIG_FB_CG14)             +=3D cg14.o sbuslib.o
+obj-$(CONFIG_FB_P9100)            +=3D p9100.o sbuslib.o
+obj-$(CONFIG_FB_TCX)              +=3D tcx.o sbuslib.o
+obj-$(CONFIG_FB_LEO)              +=3D leo.o sbuslib.o
+obj-$(CONFIG_FB_SGIVW)            +=3D sgivwfb.o
+obj-$(CONFIG_FB_ACORN)            +=3D acornfb.o
 obj-$(CONFIG_FB_ATARI)            +=3D atafb.o
=2Dobj-$(CONFIG_FB_MAC)              +=3D macfb.o macmodes.o cfbfillrect.o =
cfbcopyarea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_HGA)              +=3D hgafb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o=20
=2Dobj-$(CONFIG_FB_IGA)              +=3D igafb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_APOLLO)           +=3D dnfb.o cfbfillrect.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_Q40)              +=3D q40fb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_TGA)              +=3D tgafb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_HP300)            +=3D hpfb.o cfbfillrect.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_G364)             +=3D g364fb.o cfbfillrect.o cfbcopyare=
a.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_SA1100)           +=3D sa1100fb.o cfbfillrect.o cfbcopya=
rea.o cfbimgblt.o
+obj-$(CONFIG_FB_MAC)              +=3D macfb.o macmodes.o
+obj-$(CONFIG_FB_HGA)              +=3D hgafb.o
+obj-$(CONFIG_FB_IGA)              +=3D igafb.o
+obj-$(CONFIG_FB_APOLLO)           +=3D dnfb.o
+obj-$(CONFIG_FB_Q40)              +=3D q40fb.o
+obj-$(CONFIG_FB_TGA)              +=3D tgafb.o
+obj-$(CONFIG_FB_HP300)            +=3D hpfb.o
+obj-$(CONFIG_FB_G364)             +=3D g364fb.o
+obj-$(CONFIG_FB_SA1100)           +=3D sa1100fb.o
 obj-$(CONFIG_FB_SUN3)             +=3D sun3fb.o
=2Dobj-$(CONFIG_FB_HIT)              +=3D hitfb.o cfbfillrect.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_EPSON1355)	  +=3D epson1355fb.o cfbfillrect.o cfbcopyare=
a.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_PVR2)             +=3D pvr2fb.o cfbfillrect.o cfbcopyare=
a.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_VOODOO1)          +=3D sstfb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_ARMCLCD)	  +=3D amba-clcd.o cfbfillrect.o cfbcopyarea.o =
cfbimgblt.o
=2Dobj-$(CONFIG_FB_68328)            +=3D 68328fb.o cfbfillrect.o cfbcopyar=
ea.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_GBE)              +=3D gbefb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
=2Dobj-$(CONFIG_FB_CIRRUS)		  +=3D cirrusfb.o cfbfillrect.o cfbimgblt.o cfb=
copyarea.o
=2Dobj-$(CONFIG_FB_ASILIANT)	  +=3D asiliantfb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
=2Dobj-$(CONFIG_FB_PXA)		  +=3D pxafb.o cfbimgblt.o cfbcopyarea.o cfbfillre=
ct.o
=2Dobj-$(CONFIG_FB_W100)		   +=3D w100fb.o cfbimgblt.o cfbcopyarea.o cfbfil=
lrect.o
+obj-$(CONFIG_FB_HIT)              +=3D hitfb.o
+obj-$(CONFIG_FB_EPSON1355)	  +=3D epson1355fb.o
+obj-$(CONFIG_FB_PVR2)             +=3D pvr2fb.o
+obj-$(CONFIG_FB_VOODOO1)          +=3D sstfb.o
+obj-$(CONFIG_FB_ARMCLCD)	  +=3D amba-clcd.o
+obj-$(CONFIG_FB_68328)            +=3D 68328fb.o
+obj-$(CONFIG_FB_GBE)              +=3D gbefb.o
+obj-$(CONFIG_FB_CIRRUS)		  +=3D cirrusfb.o
+obj-$(CONFIG_FB_ASILIANT)	  +=3D asiliantfb.o
+obj-$(CONFIG_FB_PXA)		  +=3D pxafb.o
+obj-$(CONFIG_FB_W100)		  +=3D w100fb.o
 obj-$(CONFIG_FB_AU1100)		  +=3D au1100fb.o fbgen.o
=2Dobj-$(CONFIG_FB_PMAG_AA)	  +=3D pmag-aa-fb.o  cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
=2Dobj-$(CONFIG_FB_PMAG_BA)	  +=3D pmag-ba-fb.o  cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
=2Dobj-$(CONFIG_FB_PMAGB_B)	  +=3D pmagb-b-fb.o  cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
=2Dobj-$(CONFIG_FB_MAXINE)		  +=3D maxinefb.o  cfbfillrect.o cfbcopyarea.o =
cfbimgblt.o
=2Dobj-$(CONFIG_FB_TX3912)		  +=3D tx3912fb.o  cfbfillrect.o cfbcopyarea.o =
cfbimgblt.o
+obj-$(CONFIG_FB_PMAG_AA)	  +=3D pmag-aa-fb.o
+obj-$(CONFIG_FB_PMAG_BA)	  +=3D pmag-ba-fb.o
+obj-$(CONFIG_FB_PMAGB_B)	  +=3D pmagb-b-fb.o
+obj-$(CONFIG_FB_MAXINE)		  +=3D maxinefb.o
+obj-$(CONFIG_FB_TX3912)		  +=3D tx3912fb.o
=20
 # Platform or fallback drivers go here
=2Dobj-$(CONFIG_FB_VESA)             +=3D vesafb.o cfbfillrect.o cfbcopyare=
a.o cfbimgblt.o
=2Dobj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o cfbfillrect.o cfbcopyar=
ea.o \
=2D	                             cfbimgblt.o vgastate.o
=2Dobj-$(CONFIG_FB_OF)               +=3D offb.o cfbfillrect.o cfbimgblt.o =
cfbcopyarea.o
+obj-$(CONFIG_FB_VESA)             +=3D vesafb.o
+obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o vgastate.o
+obj-$(CONFIG_FB_OF)               +=3D offb.o
=20
 # the test framebuffer is last
=2Dobj-$(CONFIG_FB_VIRTUAL)          +=3D vfb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
+obj-$(CONFIG_FB_VIRTUAL)          +=3D vfb.o




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
