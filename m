From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Sun, 6 Mar 2005 08:16:55 +0800
Message-ID: <200503060816.55890.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7jUN-00073t-W1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:19:19 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7jUL-0002XN-OC
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Mar 2005 16:19:19 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id AF3B7145D32F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  6 Mar 2005 00:19:05 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>

  From Jon Smirl <jonsmirl@gmail.com>:

  Allow the framebuffer core to be built as a module to
  ease debugging.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Kconfig  |   74 +++++++++++++++++++++++++++++++--------------------------------
 Makefile |    8 ++++--
 fbmem.c  |   15 ++++++++++++
 3 files changed, 57 insertions(+), 40 deletions(-)

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/Kconfig	2005-03-05 08:03:29 +08:00
@@ -5,7 +5,7 @@
 menu "Graphics support"
 
 config FB
-	bool "Support for frame buffer devices"
+	tristate "Support for frame buffer devices"
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
@@ -160,7 +160,7 @@
 
 config FB_ACORN
 	bool "Acorn VIDC support"
-	depends on FB && ARM && ARCH_ACORN
+	depends on (FB = y) && ARM && ARCH_ACORN
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -172,7 +172,7 @@
 
 config FB_CLPS711X
 	bool "CLPS711X LCD support"
-	depends on FB && ARM && ARCH_CLPS711X
+	depends on (FB = y) && ARM && ARCH_CLPS711X
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -180,7 +180,7 @@
 
 config FB_SA1100
 	bool "SA-1100 LCD support"
-	depends on FB && ARM && ARCH_SA1100
+	depends on (FB = y) && ARM && ARCH_SA1100
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -208,7 +208,7 @@
 
 config FB_APOLLO
 	bool
-	depends on FB && APOLLO
+	depends on (FB = y) && APOLLO
 	default y
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
@@ -216,7 +216,7 @@
 
 config FB_Q40
 	bool
-	depends on FB && Q40
+	depends on (FB = y) && Q40
 	default y
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -277,7 +277,7 @@
 
 config FB_VIRGE
 	bool "Amiga CyberVision 64/3D support "
-	depends on FB && ZORRO && BROKEN
+	depends on (FB = y) && ZORRO && BROKEN
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -292,7 +292,7 @@
 
 config FB_RETINAZ3
 	tristate "Amiga Retina Z3 support"
-	depends on FB && ZORRO && BROKEN
+	depends on (FB = y) && ZORRO && BROKEN
 	help
 	  This enables support for the Retina Z3 graphics card. Say N unless
 	  you have a Retina Z3 or plan to get one before you next recompile
@@ -300,7 +300,7 @@
 
 config FB_FM2
 	bool "Amiga FrameMaster II/Rainbow II support"
-	depends on FB && ZORRO
+	depends on (FB = y) && ZORRO
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -311,14 +311,14 @@
 
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
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -329,7 +329,7 @@
 
 config FB_CONTROL
 	bool "Apple \"control\" display support"
-	depends on FB && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -340,7 +340,7 @@
 
 config FB_PLATINUM
 	bool "Apple \"platinum\" display support"
-	depends on FB && PPC_PMAC
+	depends on (FB = y) && PPC_PMAC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -351,7 +351,7 @@
 
 config FB_VALKYRIE
 	bool "Apple \"valkyrie\" display support"
-	depends on FB && (MAC || PPC_PMAC)
+	depends on (FB = y) && (MAC || PPC_PMAC)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -362,7 +362,7 @@
 
 config FB_CT65550
 	bool "Chips 65550 display support"
-	depends on FB && PPC
+	depends on (FB = y) && PPC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -373,7 +373,7 @@
 
 config FB_ASILIANT
 	bool "Chips 69000 display support"
-	depends on FB && PCI
+	depends on (FB = y) && PCI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -381,7 +381,7 @@
 
 config FB_IMSTT
 	bool "IMS Twin Turbo display support"
-	depends on FB && PCI
+	depends on (FB = y) && PCI
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
 	help
@@ -390,7 +390,7 @@
 
 config FB_S3TRIO
 	bool "S3 Trio display support"
-	depends on FB && PPC && BROKEN
+	depends on (FB = y) && PPC && BROKEN
 	help
 	  If you have a S3 Trio say Y. Say N for S3 Virge.
 
@@ -431,7 +431,7 @@
 
 config FB_MAC
 	bool "Generic Macintosh display support"
-	depends on FB && MAC
+	depends on (FB = y) && MAC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -440,7 +440,7 @@
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
 config FB_HP300
 	bool
-	depends on FB && HP300
+	depends on (FB = y) && HP300
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
@@ -459,7 +459,7 @@
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on FB && (X86 || X86_64)
+	depends on (FB = y) && (X86 || X86_64)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -501,7 +501,7 @@
 
 config VIDEO_SELECT
 	bool
-	depends on FB && X86
+	depends on (FB = y) && X86
 	default y
 
 config FB_SGIVW
@@ -516,7 +516,7 @@
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
-	depends on FB && (SGI_IP32 || X86_VISWS)
+	depends on (FB = y) && (SGI_IP32 || X86_VISWS)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -535,16 +535,16 @@
 
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
-	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -554,7 +554,7 @@
 
 config FB_CG3
 	bool "CGthree support"
-	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
@@ -563,7 +563,7 @@
 
 config FB_CG6
 	bool "CGsix (GX,TurboGX) support"
-	depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
+	depends on (FB = y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) && FB_SUN3)
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
@@ -595,7 +595,7 @@
 
 config FB_EPSON1355
 	bool "Epson 1355 framebuffer support"
-	depends on FB && (SUPERH || ARCH_CEIVA)
+	depends on (FB = y) && (SUPERH || ARCH_CEIVA)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1209,13 +1209,13 @@
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on FB && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
+	depends on (FB = y) && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
 
 source "drivers/video/geode/Kconfig"
 
 config FB_SBUS
 	bool "SBUS and UPA framebuffers"
-	depends on FB && (SPARC32 || SPARC64)
+	depends on (FB = y) && (SPARC32 || SPARC64)
 	help
 	  Say Y if you want support for SBUS or UPA based frame buffer device.
 
@@ -1275,7 +1275,7 @@
 
 config FB_PCI
 	bool "PCI framebuffers"
-	depends on FB && PCI && (SPARC64 || SPARC32)
+	depends on (FB = y) && PCI && (SPARC64 || SPARC32)
 
 config FB_IGA
 	bool "IGA 168x display support"
@@ -1301,7 +1301,7 @@
 
 config FB_PMAG_AA
 	bool "PMAG-AA TURBOchannel framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1312,7 +1312,7 @@
 
 config FB_PMAG_BA
 	bool "PMAG-BA TURBOchannel framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1323,7 +1323,7 @@
 
 config FB_PMAGB_B
 	bool "PMAGB-B TURBOchannel framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1335,7 +1335,7 @@
 
 config FB_MAXINE
 	bool "Maxine (Personal DECstation) onboard framebuffer support"
-	depends on FB && MACH_DECSTATION && TC
+	depends on (FB = y) && MACH_DECSTATION && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1347,7 +1347,7 @@
 
 config FB_TX3912
 	bool "TMPTX3912/PR31700 frame buffer support"
-	depends on FB && NINO
+	depends on (FB = y) && NINO
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	2005-03-05 00:18:24 +08:00
+++ b/drivers/video/Makefile	2005-03-05 08:04:32 +08:00
@@ -8,11 +8,13 @@
 obj-$(CONFIG_LOGO)		  += logo/
 obj-$(CONFIG_SYSFS)		  += backlight/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o
+obj-$(CONFIG_FB)                  += fb.o
+fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o modedb.o
+ifneq ($(CONFIG_FB),n)
+fb-$(CONFIG_PPC)                  += macmodes.o
 # Only include macmodes.o if we have FB support and are PPC
-ifeq ($(CONFIG_FB),y)
-obj-$(CONFIG_PPC)                 += macmodes.o
 endif
+fb-objs                           := $(fb-y)
 
 obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
 obj-$(CONFIG_FB_CFB_COPYAREA)  += cfbcopyarea.o
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2005-02-21 20:43:10 +08:00
+++ b/drivers/video/fbmem.c	2005-03-03 07:21:47 +08:00
@@ -1205,7 +1205,22 @@
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
 
 int fb_new_modelist(struct fb_info *info)
 {




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
