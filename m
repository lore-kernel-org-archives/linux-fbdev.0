From: David Vrabel <dvrabel@arcom.com>
Subject: [patch] Framebuffer kbuild -- make all drivers select FB_CFB_xxx
 (2/4)
Date: Tue, 15 Feb 2005 10:53:09 +0000
Message-ID: <4211D495.3080506@arcom.com>
References: <421096C6.3030105@arcom.com> <Pine.GSO.4.61.0502141322060.16209@waterleaf.sonytel.be> <Pine.LNX.4.56.0502141724240.6781@pentafluge.infradead.org> <4211D2DF.2070302@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030307030904040109040306"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D10KW-0004Lj-Fw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 02:53:20 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D10KR-00049k-Sw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 02:53:20 -0800
In-Reply-To: <4211D2DF.2070302@arcom.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030307030904040109040306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Make all framebuffer drivers (where appropriate) select FB_CFB_FILLRECT,
FB_CFB_COPYAREA, and/or FB_CFB_IMAGEBLIT instead of specifying the
objects in the Makefile directly.

Signed-off-by: David Vrabel <dvrabel@arcom.com>


--------------030307030904040109040306
Content-Type: text/plain;
 name="fb-kbuild-use-FB_CFB_xxx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fb-kbuild-use-FB_CFB_xxx"

%status
pending
%patch
Index: linux-2.6-i386/drivers/video/Kconfig
===================================================================
--- linux-2.6-i386.orig/drivers/video/Kconfig	2005-02-15 10:12:37.657581067 +0000
+++ linux-2.6-i386/drivers/video/Kconfig	2005-02-15 10:12:46.078098585 +0000
@@ -97,6 +97,9 @@
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (ZORRO || PCI)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
@@ -112,6 +115,9 @@
 config FB_PM2
 	tristate "Permedia2 support"
 	depends on FB && ((AMIGA && BROKEN) || PCI)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
@@ -127,6 +133,9 @@
 config FB_ARMCLCD
 	tristate "ARM PrimeCell PL110 support"
 	depends on FB && ARM && ARM_AMBA
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This framebuffer device driver is for the ARM PrimeCell PL110
 	  Colour LCD controller.  ARM PrimeCells provide the building
@@ -140,6 +149,9 @@
 config FB_ACORN
 	bool "Acorn VIDC support"
 	depends on FB && ARM && ARCH_ACORN
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the Acorn VIDC graphics
 	  hardware found in Acorn RISC PCs and other ARM-based machines.  If
@@ -148,10 +160,16 @@
 config FB_CLPS711X
 	bool "CLPS711X LCD support"
 	depends on FB && ARM && ARCH_CLPS711X
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 
 config FB_SA1100
 	bool "SA-1100 LCD support"
 	depends on FB && ARM && ARCH_SA1100
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is a framebuffer device for the SA-1100 LCD Controller.
 	  See <http://www.linux-fbdev.org/> for information on framebuffer
@@ -163,6 +181,9 @@
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
 	depends on FB && PCI && (BROKEN || !SPARC64)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This enables support for the Integraphics CyberPro 20x0 and 5000
 	  VGA chips used in the Rebel.com Netwinder and other machines.
@@ -173,11 +194,16 @@
 	bool
 	depends on FB && APOLLO
 	default y
+	select FB_CFB_FILLRECT
+	select FB_CFB_IMAGEBLIT
 
 config FB_Q40
 	bool
 	depends on FB && Q40
 	default y
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 
 config FB_AMIGA
 	tristate "Amiga native chipset support"
@@ -218,6 +244,9 @@
 config FB_CYBER
 	tristate "Amiga CyberVision 64 support"
 	depends on FB && ZORRO && BROKEN
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This enables support for the Cybervision 64 graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -229,6 +258,9 @@
 config FB_VIRGE
 	bool "Amiga CyberVision 64/3D support "
 	depends on FB && ZORRO && BROKEN
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This enables support for the Cybervision 64/3D graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -248,6 +280,9 @@
 config FB_FM2
 	bool "Amiga FrameMaster II/Rainbow II support"
 	depends on FB && ZORRO
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the Amiga FrameMaster
 	  card from BSC (exhibited 1992 but not shipped as a CBM product).
@@ -262,6 +297,9 @@
 config FB_OF
 	bool "Open Firmware frame buffer device support"
 	depends on FB && (PPC64 || PPC_OF)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y if you want support with Open Firmware for your graphics
 	  board.
@@ -269,6 +307,9 @@
 config FB_CONTROL
 	bool "Apple \"control\" display support"
 	depends on FB && PPC_PMAC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports a frame buffer for the graphics adapter in the
 	  Power Macintosh 7300 and others.
@@ -276,6 +317,9 @@
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
 	depends on FB && PPC_PMAC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports a frame buffer for the "platinum" graphics
 	  adapter in some Power Macintoshes.
@@ -283,6 +327,9 @@
 config FB_VALKYRIE
 	bool "Apple \"valkyrie\" display support"
 	depends on FB && (MAC || PPC_PMAC)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports a frame buffer for the "valkyrie" graphics
 	  adapter in some Power Macintoshes.
@@ -290,6 +337,9 @@
 config FB_CT65550
 	bool "Chips 65550 display support"
 	depends on FB && PPC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the Chips & Technologies
 	  65550 graphics chip in PowerBooks.
@@ -297,10 +347,14 @@
 config FB_ASILIANT
 	bool "Chips 69000 display support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"
 	depends on FB && PCI
+	select FB_CFB_IMAGEBLIT
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
@@ -314,6 +368,9 @@
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
 	depends on FB && (X86 || PPC)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for VGA 16 color graphic
 	  cards. Say Y if you have such a card.
@@ -324,6 +381,9 @@
 config FB_STI
 	tristate "HP STI frame buffer device support"
 	depends on FB && PARISC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	default y
 	---help---
 	  STI refers to the HP "Standard Text Interface" which is a set of
@@ -341,16 +401,24 @@
 config FB_MAC
 	bool "Generic Macintosh display support"
 	depends on FB && MAC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
 config FB_HP300
 	bool
 	depends on FB && HP300
+	select FB_CFB_FILLRECT
+	select FB_CFB_IMAGEBLIT
 	default y
 
 config FB_TGA
 	tristate "TGA framebuffer support"
 	depends on FB && ALPHA
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for generic TGA graphic
 	  cards. Say Y if you have one of those.
@@ -358,6 +426,9 @@
 config FB_VESA
 	bool "VESA VGA graphics support"
 	depends on FB && (X86 || X86_64)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -372,6 +443,9 @@
 config FB_HGA
 	tristate "Hercules mono graphics support"
 	depends on FB && X86
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here if you have a Hercules mono graphics card.
 
@@ -397,12 +471,18 @@
 config FB_SGIVW
 	tristate "SGI Visual Workstation framebuffer support"
 	depends on FB && X86_VISWS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  SGI Visual Workstation support for framebuffer graphics.
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
 	depends on FB && (SGI_IP32 || X86_VISWS)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
  	help
 	  This is the frame buffer device driver for SGI Graphics Backend.
 	  This chip is used in SGI O2 and Visual Workstation 320/540.
@@ -427,6 +507,9 @@
 config FB_BW2
 	bool "BWtwo support"
 	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the BWtwo frame buffer.
 
@@ -439,6 +522,8 @@
 config FB_CG6
 	bool "CGsix (GX,TurboGX) support"
 	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 	  frame buffer.
@@ -446,6 +531,9 @@
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
 	depends on FB && SH_DREAMCAST
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  Say Y here if you have a PowerVR 2 card in your box.  If you plan to
 	  run linux on your Dreamcast, you will have to say Y here.
@@ -464,6 +552,9 @@
 config FB_EPSON1355
 	bool "Epson 1355 framebuffer support"
 	depends on FB && (SUPERH || ARCH_CEIVA)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Build in support for the SED1355 Epson Research Embedded RAMDAC
 	  LCD/CRT Controller (since redesignated as the S1D13505) as a
@@ -476,6 +567,9 @@
 	select I2C_ALGOBIT if FB_RIVA_I2C
 	select I2C if FB_RIVA_I2C
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -511,6 +605,9 @@
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
@@ -568,6 +665,9 @@
 config FB_MATROX
 	tristate "Matrox acceleration"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 	  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -723,6 +823,9 @@
 config FB_RADEON_OLD
 	tristate "ATI Radeon display support (Old driver)"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Choose this option if you want to use an ATI Radeon graphics card as
 	  a framebuffer device.  There are both PCI and AGP versions.  You
@@ -770,6 +873,9 @@
 config FB_ATY128
 	tristate "ATI Rage128 display support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports graphics boards with the ATI Rage128 chips.
 	  Say Y if you have such a graphics board and read
@@ -781,6 +887,9 @@
 config FB_ATY
 	tristate "ATI Mach64 display support" if PCI || ATARI
 	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports graphics boards with the ATI Mach64 chips.
 	  Say Y if you have such a graphics board.
@@ -828,6 +937,9 @@
 	select I2C_ALGOBIT if FB_SAVAGE_I2C
 	select I2C if FB_SAVAGE_I2C
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports notebooks and computers with S3 Savage PCI/AGP
 	  chips.
@@ -861,6 +973,9 @@
 config FB_SIS
 	tristate "SiS acceleration"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the SiS 300, 315 and
 	  330 series VGA chipsets. Specs available at http://www.sis.com
@@ -885,6 +1000,9 @@
 	tristate "NeoMagic display support"
 	depends on FB && PCI
 	select FB_MODE_HELPERS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
 	  Say Y if you have such a graphics card. 
@@ -895,6 +1013,9 @@
 config FB_KYRO
 	tristate "IMG Kyro support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here if you have a STG4000 / Kyro / PowerVR 3 based
 	  graphics board.
@@ -905,6 +1026,7 @@
 config FB_3DFX
 	tristate "3Dfx Banshee/Voodoo3 display support"
 	depends on FB && PCI
+	select FB_CFB_IMAGEBLIT
 	help
 	  This driver supports graphics boards with the 3Dfx Banshee/Voodoo3
 	  chips. Say Y if you have such a graphics board.
@@ -938,6 +1060,9 @@
 config FB_TRIDENT
 	tristate "Trident support"
 	depends on FB && PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  This driver is supposed to support graphics boards with the
 	  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
@@ -975,6 +1100,8 @@
 config FB_FFB
 	bool "Creator/Creator3D/Elite3D support"
 	depends on FB_SBUS && SPARC64
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the Creator, Creator3D,
 	  and Elite3D graphics boards.
@@ -982,6 +1109,9 @@
 config FB_TCX
 	bool "TCX (SS4/SS5 only) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the TCX 24/8bit frame
 	  buffer.
@@ -989,6 +1119,9 @@
 config FB_CG14
 	bool "CGfourteen (SX) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the CGfourteen frame
 	  buffer on Desktop SPARCsystems with the SX graphics option.
@@ -996,6 +1129,9 @@
 config FB_P9100
 	bool "P9100 (Sparcbook 3 only) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the P9100 card
 	  supported on Sparcbook 3 machines.
@@ -1003,6 +1139,9 @@
 config FB_LEO
 	bool "Leo (ZX) support"
 	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the SBUS-based Sun ZX
 	  (leo) frame buffer cards.
@@ -1014,6 +1153,9 @@
 config FB_IGA
 	bool "IGA 168x display support"
 	depends on SPARC32 && FB_PCI
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the framebuffer device for the INTERGRAPHICS 1680 and
 	  successor frame buffer cards.
@@ -1021,6 +1163,9 @@
 config FB_HIT
 	tristate "HD64461 Frame Buffer support"
 	depends on FB && HD64461
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  This is the frame buffer device driver for the Hitachi HD64461 LCD
 	  frame buffer card.
@@ -1028,6 +1173,9 @@
 config FB_PMAG_BA
 	bool "PMAG-BA TURBOchannel framebuffer support"
 	depends on FB && DECSTATION && TC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here to directly support the on-board PMAG-BA framebuffer in
 	  the 5000/1xx versions of the DECstation.  There is a page dedicated
@@ -1036,6 +1184,9 @@
 config FB_PMAGB_B
 	bool "PMAGB-B TURBOchannel framebuffer spport"
 	depends on FB && DECSTATION && TC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here to directly support the on-board PMAGB-B framebuffer in
 	  the 5000/1xx versions of the DECstation.  There is a page dedicated
@@ -1044,6 +1195,9 @@
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer spport"
 	depends on FB && DECSTATION && TC
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here to directly support the on-board framebuffer in the
 	  Maxine (5000/20, /25, /33) version of the DECstation.  There is a
@@ -1052,6 +1206,9 @@
 config FB_TX3912
 	bool "TMPTX3912/PR31700 frame buffer support"
 	depends on FB && NINO
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -1061,6 +1218,9 @@
 config FB_68328
 	bool "Motorola 68328 native frame buffer support"
 	depends on (M68328 || M68EZ328 || M68VZ328)
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	help
 	  Say Y here if you want to support the built-in frame buffer of
 	  the Motorola 68328 CPU family.
@@ -1068,6 +1228,9 @@
 config FB_PXA
 	tristate "PXA LCD framebuffer support"
 	depends on FB && ARCH_PXA
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  Frame buffer driver for the built-in LCD controller in the Intel
 	  PXA2x0 processor.
@@ -1099,6 +1262,9 @@
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
 	---help---
 	  This is a `virtual' frame buffer device. It operates on a chunk of
 	  unswappable kernel memory instead of on the memory of a graphics
Index: linux-2.6-i386/drivers/video/Makefile
===================================================================
--- linux-2.6-i386.orig/drivers/video/Makefile	2005-02-15 10:11:43.064192554 +0000
+++ linux-2.6-i386/drivers/video/Makefile	2005-02-15 10:12:46.082097881 +0000
@@ -20,90 +20,74 @@
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
-obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o
 obj-$(CONFIG_FB_CYBER)            += cyberfb.o
-obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_PM2)              += pm2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o
+obj-$(CONFIG_FB_PM2)              += pm2fb.o
 obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 
-obj-$(CONFIG_FB_MATROX)		  += matrox/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_RIVA)		  += riva/ cfbimgblt.o cfbfillrect.o \
-				     cfbcopyarea.o vgastate.o
-obj-$(CONFIG_FB_ATY)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_ATY128)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_RADEON)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_SIS)		  += sis/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_KYRO)             += kyro/ cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_SAVAGE)		  += savage/ cfbfillrect.o cfbcopyarea.o \
-				     cfbimgblt.o
-obj-$(CONFIG_FB_I810)             += cfbcopyarea.o cfbfillrect.o cfbimgblt.o \
-				     vgastate.o
-obj-$(CONFIG_FB_INTEL)            += cfbfillrect.o cfbcopyarea.o \
-	                             cfbimgblt.o
-
-obj-$(CONFIG_FB_RADEON_OLD)	  += radeonfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o vgastate.o
+obj-$(CONFIG_FB_MATROX)		  += matrox/
+obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
+obj-$(CONFIG_FB_ATY)		  += aty/
+obj-$(CONFIG_FB_ATY128)		  += aty/
+obj-$(CONFIG_FB_RADEON)		  += aty/
+obj-$(CONFIG_FB_SIS)		  += sis/
+obj-$(CONFIG_FB_KYRO)             += kyro/
+obj-$(CONFIG_FB_SAVAGE)		  += savage/			    
+obj-$(CONFIG_FB_I810)             += vgastate.o
+obj-$(CONFIG_FB_RADEON_OLD)	  += radeonfb.o
+obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o vgastate.o
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
-obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
-ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
-obj-$(CONFIG_FB_3DFX)             += cfbfillrect.o cfbcopyarea.o
-endif
-obj-$(CONFIG_FB_CONTROL)          += controlfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_CT65550)          += chipsfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_IMSTT)            += imsttfb.o cfbimgblt.o
+obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
+obj-$(CONFIG_FB_CONTROL)          += controlfb.o macmodes.o
+obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o macmodes.o
+obj-$(CONFIG_FB_VALKYRIE)         += valkyriefb.o macmodes.o
+obj-$(CONFIG_FB_CT65550)          += chipsfb.o
+obj-$(CONFIG_FB_IMSTT)            += imsttfb.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
-obj-$(CONFIG_FB_FM2)              += fm2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
-obj-$(CONFIG_FB_STI)              += stifb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_FFB)              += ffb.o sbuslib.o cfbimgblt.o cfbcopyarea.o
-obj-$(CONFIG_FB_CG6)              += cg6.o sbuslib.o cfbimgblt.o cfbcopyarea.o
-obj-$(CONFIG_FB_CG3)              += cg3.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
-				     cfbfillrect.o
-obj-$(CONFIG_FB_BW2)              += bw2.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
-				     cfbfillrect.o
-obj-$(CONFIG_FB_CG14)             += cg14.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
-				     cfbfillrect.o
-obj-$(CONFIG_FB_P9100)            += p9100.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
-				     cfbfillrect.o
-obj-$(CONFIG_FB_TCX)              += tcx.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
-				     cfbfillrect.o
-obj-$(CONFIG_FB_LEO)              += leo.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
-				     cfbfillrect.o
-obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_ACORN)            += acornfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_FM2)              += fm2fb.o
+obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o
+obj-$(CONFIG_FB_STI)              += stifb.o
+obj-$(CONFIG_FB_FFB)              += ffb.o sbuslib.o
+obj-$(CONFIG_FB_CG6)              += cg6.o sbuslib.o
+obj-$(CONFIG_FB_CG3)              += cg3.o sbuslib.o
+obj-$(CONFIG_FB_BW2)              += bw2.o sbuslib.o
+obj-$(CONFIG_FB_CG14)             += cg14.o sbuslib.o
+obj-$(CONFIG_FB_P9100)            += p9100.o sbuslib.o
+obj-$(CONFIG_FB_TCX)              += tcx.o sbuslib.o
+obj-$(CONFIG_FB_LEO)              += leo.o sbuslib.o
+obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o
+obj-$(CONFIG_FB_ACORN)            += acornfb.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o
-obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_HGA)              += hgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
-obj-$(CONFIG_FB_IGA)              += igafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_APOLLO)           += dnfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_Q40)              += q40fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_TGA)              += tgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_G364)             += g364fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_SA1100)           += sa1100fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o
+obj-$(CONFIG_FB_HGA)              += hgafb.o 
+obj-$(CONFIG_FB_IGA)              += igafb.o
+obj-$(CONFIG_FB_APOLLO)           += dnfb.o
+obj-$(CONFIG_FB_Q40)              += q40fb.o
+obj-$(CONFIG_FB_TGA)              += tgafb.o
+obj-$(CONFIG_FB_HP300)            += hpfb.o
+obj-$(CONFIG_FB_G364)             += g364fb.o
+obj-$(CONFIG_FB_SA1100)           += sa1100fb.o
 obj-$(CONFIG_FB_SUN3)             += sun3fb.o
-obj-$(CONFIG_FB_HIT)              += hitfb.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_TX3912)           += tx3912fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_EPSON1355)	  += epson1355fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_PVR2)             += pvr2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_PMAG_BA)          += pmag-ba-fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_PMAGB_B)          += pmagb-b-fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_MAXINE)           += maxinefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_VOODOO1)          += sstfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_68328)            += 68328fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
-obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_PXA)		  += pxafb.o cfbimgblt.o cfbcopyarea.o cfbfillrect.o
+obj-$(CONFIG_FB_HIT)              += hitfb.o
+obj-$(CONFIG_FB_TX3912)           += tx3912fb.o
+obj-$(CONFIG_FB_EPSON1355)	  += epson1355fb.o
+obj-$(CONFIG_FB_PVR2)             += pvr2fb.o
+obj-$(CONFIG_FB_PMAG_BA)          += pmag-ba-fb.o
+obj-$(CONFIG_FB_PMAGB_B)          += pmagb-b-fb.o
+obj-$(CONFIG_FB_MAXINE)           += maxinefb.o
+obj-$(CONFIG_FB_VOODOO1)          += sstfb.o
+obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o
+obj-$(CONFIG_FB_68328)            += 68328fb.o
+obj-$(CONFIG_FB_GBE)              += gbefb.o
+obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
+obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o
+obj-$(CONFIG_FB_PXA)		  += pxafb.o
 
 # Platform or fallback drivers go here
-obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_VGA16)            += vga16fb.o cfbfillrect.o cfbcopyarea.o \
-	                             cfbimgblt.o vgastate.o
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
+obj-$(CONFIG_FB_VESA)             += vesafb.o
+obj-$(CONFIG_FB_VGA16)            += vga16fb.o vgastate.o
+obj-$(CONFIG_FB_OF)               += offb.o
 
 # the test framebuffer is last
-obj-$(CONFIG_FB_VIRTUAL)          += vfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_VIRTUAL)          += vfb.o

--------------030307030904040109040306--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
