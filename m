From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 8/10] fbdev: Allow core fb to be built as a module
Date: Mon, 7 Mar 2005 19:05:07 -0500
Message-ID: <9e4733910503071605486c9c93@mail.gmail.com>
References: <200503060816.55890.adaplas@hotpop.com>
	 <20050307022828.54d52983.akpm@osdl.org>
	 <9e47339105030711117f6ffdc9@mail.gmail.com>
	 <20050307154355.2fd5094c.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_983_25508499.1110240307647"
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8SEO-0003Ro-PK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:05:48 -0800
Received: from rproxy.gmail.com ([64.233.170.204])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8SEK-0002hD-UV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 16:05:48 -0800
Received: by rproxy.gmail.com with SMTP id z35so2153157rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 16:05:44 -0800 (PST)
In-Reply-To: <20050307154355.2fd5094c.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, adaplas@hotpop.com, linux-fbdev-devel@lists.sourceforge.net

------=_Part_983_25508499.1110240307647
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's the same patch as an attachment. It is against a clean linus bk tree.

-- 
Jon Smirl
jonsmirl@gmail.com

------=_Part_983_25508499.1110240307647
Content-Type: text/x-diff; name="module.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="module.patch"

diff -Nru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig=092005-03-07 14:08:41 -05:00
+++ b/drivers/video/Kconfig=092005-03-07 14:08:41 -05:00
@@ -5,7 +5,7 @@
 menu "Graphics support"
=20
 config FB
-=09bool "Support for frame buffer devices"
+=09tristate "Support for frame buffer devices"
 =09---help---
 =09  The frame buffer device provides an abstraction for the graphics
 =09  hardware. It represents the frame buffer of some video hardware and
@@ -112,7 +112,7 @@
=20
 config FB_ACORN
 =09bool "Acorn VIDC support"
-=09depends on FB && ARM && ARCH_ACORN
+=09depends on (FB =3D y) && ARM && ARCH_ACORN
 =09help
 =09  This is the frame buffer device driver for the Acorn VIDC graphics
 =09  hardware found in Acorn RISC PCs and other ARM-based machines.  If
@@ -120,11 +120,11 @@
=20
 config FB_CLPS711X
 =09bool "CLPS711X LCD support"
-=09depends on FB && ARM && ARCH_CLPS711X
+=09depends on (FB =3D y) && ARM && ARCH_CLPS711X
=20
 config FB_SA1100
 =09bool "SA-1100 LCD support"
-=09depends on FB && ARM && ARCH_SA1100
+=09depends on (FB =3D y) && ARM && ARCH_SA1100
 =09help
 =09  This is a framebuffer device for the SA-1100 LCD Controller.
 =09  See <http://www.linux-fbdev.org/> for information on framebuffer
@@ -144,12 +144,12 @@
=20
 config FB_APOLLO
 =09bool
-=09depends on FB && APOLLO
+=09depends on (FB =3D y) && APOLLO
 =09default y
=20
 config FB_Q40
 =09bool
-=09depends on FB && Q40
+=09depends on (FB =3D y) && Q40
 =09default y
=20
 config FB_AMIGA
@@ -201,7 +201,7 @@
=20
 config FB_VIRGE
 =09bool "Amiga CyberVision 64/3D support "
-=09depends on FB && ZORRO && BROKEN
+=09depends on (FB =3D y) && ZORRO && BROKEN
 =09help
 =09  This enables support for the Cybervision 64/3D graphics card from
 =09  Phase5. Please note that its use is not all that intuitive (i.e. if
@@ -212,7 +212,7 @@
=20
 config FB_RETINAZ3
 =09tristate "Amiga Retina Z3 support"
-=09depends on FB && ZORRO && BROKEN
+=09depends on (FB =3D y) && ZORRO && BROKEN
 =09help
 =09  This enables support for the Retina Z3 graphics card. Say N unless
 =09  you have a Retina Z3 or plan to get one before you next recompile
@@ -220,67 +220,67 @@
=20
 config FB_FM2
 =09bool "Amiga FrameMaster II/Rainbow II support"
-=09depends on FB && ZORRO
+=09depends on (FB =3D y) && ZORRO
 =09help
 =09  This is the frame buffer device driver for the Amiga FrameMaster
 =09  card from BSC (exhibited 1992 but not shipped as a CBM product).
=20
 config FB_ATARI
 =09bool "Atari native chipset support"
-=09depends on FB && ATARI && BROKEN
+=09depends on (FB =3D y) && ATARI && BROKEN
 =09help
 =09  This is the frame buffer device driver for the builtin graphics
 =09  chipset found in Ataris.
=20
 config FB_OF
 =09bool "Open Firmware frame buffer device support"
-=09depends on FB && (PPC64 || PPC_OF)
+=09depends on (FB =3D y) && (PPC64 || PPC_OF)
 =09help
 =09  Say Y if you want support with Open Firmware for your graphics
 =09  board.
=20
 config FB_CONTROL
 =09bool "Apple \"control\" display support"
-=09depends on FB && PPC_PMAC
+=09depends on (FB =3D y) && PPC_PMAC
 =09help
 =09  This driver supports a frame buffer for the graphics adapter in the
 =09  Power Macintosh 7300 and others.
=20
 config FB_PLATINUM
 =09bool "Apple \"platinum\" display support"
-=09depends on FB && PPC_PMAC
+=09depends on (FB =3D y) && PPC_PMAC
 =09help
 =09  This driver supports a frame buffer for the "platinum" graphics
 =09  adapter in some Power Macintoshes.
=20
 config FB_VALKYRIE
 =09bool "Apple \"valkyrie\" display support"
-=09depends on FB && (MAC || PPC_PMAC)
+=09depends on (FB =3D y) && (MAC || PPC_PMAC)
 =09help
 =09  This driver supports a frame buffer for the "valkyrie" graphics
 =09  adapter in some Power Macintoshes.
=20
 config FB_CT65550
 =09bool "Chips 65550 display support"
-=09depends on FB && PPC
+=09depends on (FB =3D y) && PPC
 =09help
 =09  This is the frame buffer device driver for the Chips & Technologies
 =09  65550 graphics chip in PowerBooks.
=20
 config FB_ASILIANT
 =09bool "Chips 69000 display support"
-=09depends on FB && PCI
+=09depends on (FB =3D y) && PCI
=20
 config FB_IMSTT
 =09bool "IMS Twin Turbo display support"
-=09depends on FB && PCI
+=09depends on (FB =3D y) && PCI
 =09help
 =09  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 =09  many Macintosh and compatible computers.
=20
 config FB_S3TRIO
 =09bool "S3 Trio display support"
-=09depends on FB && PPC && BROKEN
+=09depends on (FB =3D y) && PPC && BROKEN
 =09help
 =09  If you have a S3 Trio say Y. Say N for S3 Virge.
=20
@@ -313,12 +313,12 @@
=20
 config FB_MAC
 =09bool "Generic Macintosh display support"
-=09depends on FB && MAC
+=09depends on (FB =3D y) && MAC
=20
 #      bool '  Apple DAFB display support' CONFIG_FB_DAFB
 config FB_HP300
 =09bool
-=09depends on FB && HP300
+=09depends on (FB =3D y) && HP300
 =09default y
=20
 config FB_TGA
@@ -330,7 +330,7 @@
=20
 config FB_VESA
 =09bool "VESA VGA graphics support"
-=09depends on FB && (X86 || X86_64)
+=09depends on (FB =3D y) && (X86 || X86_64)
 =09help
 =09  This is the frame buffer device driver for generic VESA 2.0
 =09  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -364,7 +364,7 @@
=20
 config VIDEO_SELECT
 =09bool
-=09depends on FB && X86
+=09depends on (FB =3D y) && X86
 =09default y
=20
 config FB_SGIVW
@@ -375,7 +375,7 @@
=20
 config FB_GBE
 =09bool "SGI Graphics Backend frame buffer support"
-=09depends on FB && (SGI_IP32 || X86_VISWS)
+=09depends on (FB =3D y) && (SGI_IP32 || X86_VISWS)
  =09help
 =09  This is the frame buffer device driver for SGI Graphics Backend.
 =09  This chip is used in SGI O2 and Visual Workstation 320/540.
@@ -390,28 +390,28 @@
=20
 config BUS_I2C
 =09bool
-=09depends on FB && VISWS
+=09depends on (FB =3D y) && VISWS
 =09default y
=20
 config FB_SUN3
 =09bool "Sun3 framebuffer support"
-=09depends on FB && (SUN3 || SUN3X) && BROKEN
+=09depends on (FB =3D y) && (SUN3 || SUN3X) && BROKEN
=20
 config FB_BW2
 =09bool "BWtwo support"
-=09depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) &&=
 FB_SUN3)
+=09depends on (FB =3D y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || S=
UN3X) && FB_SUN3)
 =09help
 =09  This is the frame buffer device driver for the BWtwo frame buffer.
=20
 config FB_CG3
 =09bool "CGthree support"
-=09depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) &&=
 FB_SUN3)
+=09depends on (FB =3D y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || S=
UN3X) && FB_SUN3)
 =09help
 =09  This is the frame buffer device driver for the CGthree frame buffer.
=20
 config FB_CG6
 =09bool "CGsix (GX,TurboGX) support"
-=09depends on FB && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || SUN3X) &&=
 FB_SUN3)
+=09depends on (FB =3D y) && ((SPARC32 || SPARC64) && FB_SBUS || (SUN3 || S=
UN3X) && FB_SUN3)
 =09help
 =09  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 =09  frame buffer.
@@ -436,7 +436,7 @@
=20
 config FB_EPSON1355
 =09bool "Epson 1355 framebuffer support"
-=09depends on FB && (SUPERH || ARCH_CEIVA)
+=09depends on (FB =3D y) && (SUPERH || ARCH_CEIVA)
 =09help
 =09  Build in support for the SED1355 Epson Research Embedded RAMDAC
 =09  LCD/CRT Controller (since redesignated as the S1D13505) as a
@@ -541,6 +541,7 @@
 config FB_MATROX
 =09tristate "Matrox acceleration"
 =09depends on FB && PCI
+=09select FB_TILEBLITTING
 =09---help---
 =09  Say Y here if you have a Matrox Millennium, Matrox Millennium II,
 =09  Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
@@ -953,11 +954,11 @@
=20
 config FB_AU1100
 =09bool "Au1100 LCD Driver"
-=09depends on FB && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=3Dy
+=09depends on (FB =3D y) && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=3Dy
=20
 config FB_SBUS
 =09bool "SBUS and UPA framebuffers"
-=09depends on FB && (SPARC32 || SPARC64)
+=09depends on (FB =3D y) && (SPARC32 || SPARC64)
 =09help
 =09  Say Y if you want support for SBUS or UPA based frame buffer device.
=20
@@ -998,7 +999,7 @@
=20
 config FB_PCI
 =09bool "PCI framebuffers"
-=09depends on FB && PCI && (SPARC64 || SPARC32)
+=09depends on (FB =3D y) && PCI && (SPARC64 || SPARC32)
=20
 config FB_IGA
 =09bool "IGA 168x display support"
@@ -1016,21 +1017,21 @@
=20
 config FB_PMAG_AA
 =09bool "PMAG-AA TURBOchannel framebuffer support"
-=09depends on FB && MACH_DECSTATION && TC
+=09depends on (FB =3D y) && MACH_DECSTATION && TC
 =09help
 =09  Support for the PMAG-AA TURBOchannel framebuffer card (1280x1024x1)
 =09  used mainly in the MIPS-based DECstation series.
=20
 config FB_PMAG_BA
 =09bool "PMAG-BA TURBOchannel framebuffer support"
-=09depends on FB && MACH_DECSTATION && TC
+=09depends on (FB =3D y) && MACH_DECSTATION && TC
 =09help
 =09  Support for the PMAG-BA TURBOchannel framebuffer card (1024x864x8)
 =09  used mainly in the MIPS-based DECstation series.
=20
 config FB_PMAGB_B
 =09bool "PMAGB-B TURBOchannel framebuffer support"
-=09depends on FB && MACH_DECSTATION && TC
+=09depends on (FB =3D y) && MACH_DECSTATION && TC
 =09help
 =09  Support for the PMAGB-B TURBOchannel framebuffer card used mainly
 =09  in the MIPS-based DECstation series. The card is currently only
@@ -1038,7 +1039,7 @@
=20
 config FB_MAXINE
 =09bool "Maxine (Personal DECstation) onboard framebuffer support"
-=09depends on FB && MACH_DECSTATION && TC
+=09depends on (FB =3D y) && MACH_DECSTATION && TC
 =09help
 =09  Support for the onboard framebuffer (1024x768x8) in the Personal
 =09  DECstation series (Personal DECstation 5000/20, /25, /33, /50,
@@ -1046,7 +1047,7 @@
=20
 config FB_TX3912
 =09bool "TMPTX3912/PR31700 frame buffer support"
-=09depends on FB && NINO
+=09depends on (FB =3D y) && NINO
 =09help
 =09  The TX3912 is a Toshiba RISC processor based on the MIPS 3900 core
 =09  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile=092005-03-07 14:08:41 -05:00
+++ b/drivers/video/Makefile=092005-03-07 14:08:41 -05:00
@@ -8,11 +8,9 @@
 obj-$(CONFIG_LOGO)=09=09  +=3D logo/
 obj-$(CONFIG_SYSFS)=09=09  +=3D backlight/
=20
-obj-$(CONFIG_FB)                  +=3D fbmem.o fbmon.o fbcmap.o fbsysfs.o =
modedb.o softcursor.o
-# Only include macmodes.o if we have FB support and are PPC
-ifeq ($(CONFIG_FB),y)
-obj-$(CONFIG_PPC)                 +=3D macmodes.o
-endif
+obj-$(CONFIG_FB)                  +=3D fb.o
+fb-y                              :=3D fbmem.o fbmon.o fbcmap.o fbsysfs.o =
modedb.o softcursor.o
+fb-objs                           :=3D $(fb-y)
=20
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         +=3D retz3fb.o
diff -Nru a/drivers/video/console/Makefile b/drivers/video/console/Makefile
--- a/drivers/video/console/Makefile=092005-03-07 14:08:41 -05:00
+++ b/drivers/video/console/Makefile=092005-03-07 14:08:41 -05:00
@@ -25,7 +25,9 @@
 obj-$(CONFIG_VGA_CONSOLE)         +=3D vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         +=3D mdacon.o
 obj-$(CONFIG_FRAMEBUFFER_CONSOLE) +=3D fbcon.o bitblit.o font.o
-obj-$(CONFIG_FB_TILEBLITTING)     +=3D tileblit.o
+ifeq ($(CONFIG_FB_TILEBLITTING),y)
+obj-$(CONFIG_FRAMEBUFFER_CONSOLE)     +=3D tileblit.o
+endif
=20
 obj-$(CONFIG_FB_STI)              +=3D sticore.o
=20
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c=092005-03-07 14:08:41 -05:00
+++ b/drivers/video/fbmem.c=092005-03-07 14:08:41 -05:00
@@ -1204,7 +1204,22 @@
 =09}
 =09return 0;
 }
+
+void __exit
+fbmem_exit(void)
+{
+=09class_simple_destroy(fb_class);
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
=20
 static char *video_options[FB_MAX];
 static int ofonly;

------=_Part_983_25508499.1110240307647--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
