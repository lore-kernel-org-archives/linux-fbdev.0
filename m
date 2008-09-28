From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH v3] fbdev: ignore VESA modes if framebuffer does not
	support them
Date: Sun, 28 Sep 2008 14:54:15 +0200
Message-ID: <20080928125414.GA27703@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753018AbYI1Mzp@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, krzysztof.h1@poczta.fm, akpm@linux-foundation.org, bonbons@linux-vserver.org, hpa@zytor.com

Currently, it is possible to set a graphics VESA mode at boot time via
the vga= parameter even when no framebuffer driver supporting this is
configured.  This could lead to the system booting with a black screen,
without a usable console.

Fix this problem by only allowing to set graphics modes at boot time
if a supporting framebuffer driver is configured.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This version of the patch replaces the FB_SUPPORTS_BOOT_VESA macro from
screen-info.h with a config option in drivers/video/Kconfig.

diff --git a/arch/x86/boot/video-vesa.c b/arch/x86/boot/video-vesa.c
index 401ad99..47e5080 100644
--- a/arch/x86/boot/video-vesa.c
+++ b/arch/x86/boot/video-vesa.c
@@ -88,14 +88,11 @@ static int vesa_probe(void)
 			   (vminfo.memory_layout == 4 ||
 			    vminfo.memory_layout == 6) &&
 			   vminfo.memory_planes == 1) {
-#ifdef CONFIG_FB
+#ifdef CONFIG_FB_BOOT_VESA_SUPPORT
 			/* Graphics mode, color, linear frame buffer
 			   supported.  Only register the mode if
 			   if framebuffer is configured, however,
-			   otherwise the user will be left without a screen.
-			   We don't require CONFIG_FB_VESA, however, since
-			   some of the other framebuffer drivers can use
-			   this mode-setting, too. */
+			   otherwise the user will be left without a screen. */
 			mi = GET_HEAP(struct mode_info, 1);
 			mi->mode = mode + VIDEO_FIRST_VESA;
 			mi->depth = vminfo.bpp;
@@ -133,10 +130,12 @@ static int vesa_set_mode(struct mode_info *mode)
 	if ((vminfo.mode_attr & 0x15) == 0x05) {
 		/* It's a supported text mode */
 		is_graphic = 0;
+#ifdef CONFIG_FB_BOOT_VESA_SUPPORT
 	} else if ((vminfo.mode_attr & 0x99) == 0x99) {
 		/* It's a graphics mode with linear frame buffer */
 		is_graphic = 1;
 		vesa_mode |= 0x4000; /* Request linear frame buffer */
+#endif
 	} else {
 		return -1;	/* Invalid mode */
 	}
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 70d135e..651249d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -76,6 +76,14 @@ config FB_DDC
        select I2C
        default n
 
+config FB_BOOT_VESA_SUPPORT
+	bool
+	depends on FB
+	default n
+	---help---
+	  If true, at least one selected framebuffer driver can take advantage
+	  of VESA video modes set at an early boot stage via the vga= parameter.
+
 config FB_CFB_FILLRECT
 	tristate
 	depends on FB
@@ -679,6 +687,7 @@ config FB_VESA
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select VIDEO_SELECT
+	select FB_BOOT_VESA_SUPPORT
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -702,6 +711,7 @@ config FB_IMAC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_BOOT_VESA_SUPPORT
 	help
 	  This is the frame buffer device driver for the Intel-based Macintosh
 
@@ -1124,6 +1134,7 @@ config FB_INTEL
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_BOOT_VESA_SUPPORT
 	help
 	  This driver supports the on-board graphics built in to the Intel
           830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM chipsets.
@@ -1476,6 +1487,7 @@ config FB_SIS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select FB_BOOT_VESA_SUPPORT
 	help
 	  This is the frame buffer device driver for the SiS 300, 315, 330
 	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.
