From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Allow core fb to be built as a module
Date: Wed, 2 Mar 2005 18:23:28 -0500
Message-ID: <9e4733910503021523316b7e32@mail.gmail.com>
References: <9e4733910502241239268ca595@mail.gmail.com>
	 <Pine.LNX.4.56.0502282010070.16877@pentafluge.infradead.org>
	 <200503012031.50512.adaplas@hotpop.com>
	 <9e473391050302092834dc6e36@mail.gmail.com>
	 <Pine.LNX.4.56.0503021730340.20488@pentafluge.infradead.org>
	 <9e47339105030209542a06a882@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6dC6-0007XR-Nm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 15:23:54 -0800
Received: from rproxy.gmail.com ([64.233.170.198])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6dC2-0007vn-OR
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 15:23:54 -0800
Received: by rproxy.gmail.com with SMTP id z35so447267rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 15:23:50 -0800 (PST)
In-Reply-To: <9e47339105030209542a06a882@mail.gmail.com>
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
To: James Simmons <jsimmons@www.infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>

Patch to allow building of the fbdev core as a module.
Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Forgot to fix up non-x86. The algorithm is that any FB driver that is
not tristate needs (FB = y) instead of FB. It is really minor to
convert these non-module drivers to module based ones It seems to have
taken Paul about 5 minutes to convert his.
 
--
Jon Smirl
jonsmirl@gmail.com

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-02 18:21:47 -05:00
+++ b/drivers/video/Kconfig	2005-03-02 18:21:47 -05:00
@@ -5,7 +5,7 @@
 menu "Graphics support"
 
 config FB
-	bool "Support for frame buffer devices"
+	tristate "Support for frame buffer devices"
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
@@ -112,7 +112,7 @@
 
 config FB_ACORN
 	bool "Acorn VIDC support"
-	depends on FB && ARM && ARCH_ACORN
+	depends on (FB = y) && ARM && ARCH_ACORN
 	help
 	  This is the frame buffer device driver for the Acorn VIDC graphics
 	  hardware found in Acorn RISC PCs and other ARM-based machines.  If
@@ -120,11 +120,11 @@
 
 config FB_CLPS711X
 	bool "CLPS711X LCD support"
-	depends on FB && ARM && ARCH_CLPS711X
+	depends on (FB = y) && ARM && ARCH_CLPS711X
 
 config FB_SA1100
 	bool "SA-1100 LCD support"
-	depends on FB && ARM && ARCH_SA1100
+	depends on (FB = y) && ARM && ARCH_SA1100
 	help
 	  This is a framebuffer device for the SA-1100 LCD Controller.
 	  See <http://www.linux-fbdev.org/> for information on framebuffer
@@ -144,12 +144,12 @@
 
 config FB_APOLLO
 	bool
-	depends on FB && APOLLO
+	depends on (FB = y) && APOLLO
 	default y
 
 config FB_Q40
 	bool
-	depends on FB && Q40
+	depends on (FB = y) && Q40
 	default y
 
 config FB_AMIGA
@@ -201,7 +201,7 @@
 
 config FB_VIRGE
 	bool "Amiga CyberVision 64/3D support "
-	depends on FB && ZORRO && BROKEN
+	depends on (FB = y) && ZORRO && BROKEN
 	help
 	  This enables support for the Cybervision 64/3D graphics card from
 	  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -212,7 +212,7 @@
 
 config FB_RETINAZ3
 	tristate "Amiga Retina Z3 support"
-	depends on FB && ZORRO && BROKEN
+	depends on (FB = y) && ZORRO && BROKEN
 	help
 	  This enables support for the Retina Z3 graphics card. Say N unless
 	  you have a Retina Z3 or plan to get one before you next recompile
@@ -220,67 +220,67 @@
 
 config FB_FM2
 	bool "Amiga FrameMaster II/Rainbow II support"
-	depends on FB && ZORRO
+	depends on (FB = y) && ZORRO
 	help
 	  This is the frame buffer device driver for the Amiga FrameMaster
 	  card from BSC (exhibited 1992 but not shipped as a CBM product).
 
 config FB_ATARI
 	bool "Atari native chipset support"
-	depends on FB && ATARI && BROKEN
+	depends on (FB = y) && ATARI && BROKEN
 	help
 	  This is the frame buffer device driver for the builtin graphics
 	  chipset found in Ataris.
 
 config FB_OF
 	bool "Open Firmware frame buffer device support"
-	depends on FB && (PPC64 || PPC_OF)
+	depends on (FB = y) && (PPC64 || PPC_OF)
 	help
 	  Say Y if you want support with Open Firmware for your graphics
 	  board.
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on FB && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC
 	help
 	  This driver supports a frame buffer for the graphics adapter in the
 	  Power Macintosh 7300 and others.
 
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
-	depends on FB && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC
 	help
 	  This driver supports a frame buffer for the "platinum" graphics
 	  adapter in some Power Macintoshes.
 
 config FB_VALKYRIE
 	bool "Apple \"valkyrie\" display support"
-	depends on FB && (MAC || PPC_PMAC)
+	depends on (FB = y) && (MAC || PPC_PMAC)
 	help
 	  This driver supports a frame buffer for the "valkyrie" graphics
 	  adapter in some Power Macintoshes.
 
 config FB_CT65550
 	bool "Chips 65550 display support"
-	depends on FB && PPC
+	depends on (FB = y) && PPC
 	help
 	  This is the frame buffer device driver for the Chips & Technologies
 	  65550 graphics chip in PowerBooks.
 
 config FB_ASILIANT
 	bool "Chips 69000 display support"
-	depends on FB && PCI
+	depends on (FB = y) && PCI
 
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"
-	depends on FB && PCI
+	depends on (FB = y) && PCI
 	help
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
 
 config FB_S3TRIO
 	bool "S3 Trio display support"
-	depends on FB && PPC && BROKEN
+	depends on (FB = y) && PPC && BROKEN
 	help
 	  If you have a S3 Trio say Y. Say N for S3 Virge.
 
@@ -313,12 +313,12 @@
 
 config FB_MAC
 	bool "Generic Macintosh display support"
-	depends on FB && MAC
+	depends on (FB = y) && MAC
 
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
 config FB_HP300
 	bool
-	depends on FB && HP300
+	depends on (FB = y) && HP300
 	default y
 
 config FB_TGA
@@ -330,7 +330,7 @@
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on FB && (X86 || X86_64)
+	depends on (FB = y) && (X86 || X86_64)
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -364,7 +364,7 @@
 
 config VIDEO_SELECT
 	bool
-	depends on FB && X86
+	depends on (FB = y) && X86
 	default y
 
 config FB_SGIVW
@@ -375,7 +375,7 @@
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
-	depends on FB && (SGI_IP32 || X86_VISWS)
+	depends on (FB = y) && (SGI_IP32 || X86_VISWS)
  	help
 	  This is the frame buffer device driver for SGI Graphics Backend.
 	  This chip is used in SGI O2 and Visual Workstation 320/540.
@@ -390,28 +390,28 @@
 
 config BUS_I2C
 	bool
-	depends on FB && VISWS
+	depends on (FB = y) && VISWS
 	default y
 
 config FB_SUN3
 	bool "Sun3 framebuffer support"
-	depends on FB && (SUN3 || SUN3X) && BROKEN
+	depends on (FB = y) && (SUN3 || SUN3X) && BROKEN
 
 config FB_BW2
 	bool "BWtwo support"
-	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X)
&& FB_SUN3)
+	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 ||
SUN3X) && FB_SUN3)
 	help
 	  This is the frame buffer device driver for the BWtwo frame buffer.
 
 config FB_CG3
 	bool "CGthree support"
-	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X)
&& FB_SUN3)
+	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 ||
SUN3X) && FB_SUN3)
 	help
 	  This is the frame buffer device driver for the CGthree frame buffer.
 
 config FB_CG6
 	bool "CGsix (GX,TurboGX) support"
-	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X)
&& FB_SUN3)
+	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 ||
SUN3X) && FB_SUN3)
 	help
 	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 	  frame buffer.
@@ -436,7 +436,7 @@
 
 config FB_EPSON1355
 	bool "Epson 1355 framebuffer support"
-	depends on FB && (SUPERH || ARCH_CEIVA)
+	depends on (FB = y) && (SUPERH || ARCH_CEIVA)
 	help
 	  Build in support for the SED1355 Epson Research Embedded RAMDAC
 	  LCD/CRT Controller (since redesignated as the S1D13505) as a
@@ -953,11 +953,11 @@
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on FB && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
+	depends on (FB = y) && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
 
 config FB_SBUS
 	bool "SBUS and UPA framebuffers"
-	depends on FB && (SPARC32 || SPARC64)
+	depends on (FB = y) && (SPARC32 || SPARC64)
 	help
 	  Say Y if you want support for SBUS or UPA based frame buffer device.
 
@@ -998,7 +998,7 @@
 
 config FB_PCI
 	bool "PCI framebuffers"
-	depends on FB && PCI && (SPARC64 || SPARC32)
+	depends on (FB = y) && PCI && (SPARC64 || SPARC32)
 
 config FB_IGA
 	bool "IGA 168x display support"
@@ -1016,21 +1016,21 @@
 
 config FB_PMAG_AA
 	bool "PMAG-AA TURBOchannel framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
 	help
 	  Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
 	  used mainly in the MIPS-based DECstation series.
 
 config FB_PMAG_BA
 	bool "PMAG-BA TURBOchannel framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
 	help
 	  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
 	  used mainly in the MIPS-based DECstation series.
 
 config FB_PMAGB_B
 	bool "PMAGB-B TURBOchannel framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
 	help
 	  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
 	  in the MIPS-based DECstation series. The card is currently only
@@ -1038,7 +1038,7 @@
 
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
 	help
 	  Support for the onboard framebuffer (1024x768x8) in the Personal
 	  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
@@ -1046,7 +1046,7 @@
 
 config FB_TX3912
 	bool "TMPTX3912/PR31700 frame buffer support"
-	depends on FB && NINO
+	depends on (FB = y) && NINO
 	help
 	  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-03-02 18:21:47 -05:00
+++ b/drivers/video/Makefile	2005-03-02 18:21:47 -05:00
@@ -8,11 +8,13 @@
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fb.o
+fb-y                              := fbmem.o fbmon.o fbcmap.o
fbsysfs.o modedb.o softcursor.o
 # Only include macmodes.o if we have FB support and are PPC
-ifeq ($(CONFIG_FB),y)
-obj-$(CONFIG_PPC)                 += macmodes.o
+ifneq ($(CONFIG_FB),n)
+fb-$(CONFIG_PPC)                  += macmodes.o
 endif
+fb-objs                           := $(fb-y)
 
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-03-02 18:21:47 -05:00
+++ b/drivers/video/fbmem.c	2005-03-02 18:21:47 -05:00
@@ -1204,7 +1204,22 @@
 	}
 	return 0;
 }
+
+void __exit
+fbmem_exit(void)
+{
+	class_simple_destroy(fb_class);
+}
+
+#ifdef MODULE
+module_init(fbmem_init);
+module_exit(fbmem_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Framebuffer base");
+#else
 subsys_initcall(fbmem_init);
+subsys_exitcall(fbmem_exit);
+#endif
 
 static char *video_options[FB_MAX];
 static int ofonly;


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
