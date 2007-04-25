From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 05/41] fbdev: Link vgastate.o using
	Kconfig
Date: Wed, 25 Apr 2007 14:20:12 +0800
Message-ID: <462EF31C.7070605@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc4z-0000oq-AS for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:21 -0700
Received: from wx-out-0506.google.com ([66.249.82.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc4y-0005O7-By
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:21 -0700
Received: by wx-out-0506.google.com with SMTP id i30so293585wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:38:20 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Instead of directly linking vgastate.o by individual drivers, create a Kconfig
option VGASTATE which can be 'SELECT'ed by individual drivers instead.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig  |   11 +++++++++++
 drivers/video/Makefile |   14 +++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 55f4ffd..4f6ee88 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -7,6 +7,10 @@ menu "Graphics support"
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
 
+config VGASTATE
+       tristate
+       default n
+
 config FB
 	tristate "Support for frame buffer devices"
 	---help---
@@ -478,6 +482,7 @@ config FB_VGA16
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VGASTATE
 	help
 	  This is the frame buffer device driver for VGA 16 color graphic
 	  cards. Say Y if you have such a card.
@@ -713,6 +718,7 @@ config FB_NVIDIA
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select BITREVERSE
+	select VGASTATE
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
@@ -751,6 +757,7 @@ config FB_RIVA
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select BITREVERSE
+	select VGASTATE
 	help
 	  This driver supports graphics boards with the nVidia Riva/Geforce
 	  chips.
@@ -797,6 +804,7 @@ config FB_I810
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VGASTATE
 	help
 	  This driver supports the on-board graphics built in to the Intel 810 
           and 815 chipsets.  Say Y if you have and plan to use such a board.
@@ -1147,6 +1155,7 @@ config FB_S3
 	select FB_CFB_IMAGEBLIT
 	select FB_TILEBLITTING
 	select FB_SVGALIB
+	select VGASTATE
 	---help---
 	  Driver for graphics boards with S3 Trio / S3 Virge chip.
 
@@ -1157,6 +1166,7 @@ config FB_SAVAGE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VGASTATE
 	help
 	  This driver supports notebooks and computers with S3 Savage PCI/AGP
 	  chips.
@@ -1223,6 +1233,7 @@ config FB_NEOMAGIC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select VGASTATE
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
 	  Say Y if you have such a graphics card. 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 4fa1529..3ff0a70 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -4,6 +4,7 @@ # Rewritten to use lists instead of if-s
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-y                             += fb_notify.o
 obj-$(CONFIG_FB)                  += fb.o
 fb-y                              := fbmem.o fbmon.o fbcmap.o fbsysfs.o \
@@ -31,18 +32,17 @@ obj-$(CONFIG_FB_PM2)              += pm2
 obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 
 obj-$(CONFIG_FB_MATROX)		  += matrox/
-obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
-obj-$(CONFIG_FB_NVIDIA)		  += nvidia/ vgastate.o
+obj-$(CONFIG_FB_RIVA)		  += riva/
+obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
 obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/
 obj-$(CONFIG_FB_KYRO)             += kyro/
-obj-$(CONFIG_FB_SAVAGE)		  += savage/ vgastate.o
+obj-$(CONFIG_FB_SAVAGE)		  += savage/
 obj-$(CONFIG_FB_GEODE)		  += geode/
 obj-$(CONFIG_FB_MBX)		  += mbx/
-obj-$(CONFIG_FB_I810)             += vgastate.o
-obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o vgastate.o
+obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o
 obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
 obj-$(CONFIG_FB_CONTROL)          += controlfb.o
 obj-$(CONFIG_FB_PLATINUM)         += platinumfb.o
@@ -52,7 +52,7 @@ obj-$(CONFIG_FB_IMSTT)            += ims
 obj-$(CONFIG_FB_FM2)              += fm2fb.o
 obj-$(CONFIG_FB_CYBLA)            += cyblafb.o
 obj-$(CONFIG_FB_TRIDENT)          += tridentfb.o
-obj-$(CONFIG_FB_S3)               += s3fb.o vgastate.o
+obj-$(CONFIG_FB_S3)               += s3fb.o
 obj-$(CONFIG_FB_STI)              += stifb.o
 obj-$(CONFIG_FB_FFB)              += ffb.o sbuslib.o
 obj-$(CONFIG_FB_CG6)              += cg6.o sbuslib.o
@@ -105,7 +105,7 @@ obj-$(CONFIG_FB_SM501)            += sm5
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o
 obj-$(CONFIG_FB_IMAC)             += imacfb.o
-obj-$(CONFIG_FB_VGA16)            += vga16fb.o vgastate.o
+obj-$(CONFIG_FB_VGA16)            += vga16fb.o
 obj-$(CONFIG_FB_OF)               += offb.o
 
 # the test framebuffer is last


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
