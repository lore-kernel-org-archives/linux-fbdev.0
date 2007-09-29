From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/17] video gfx: merge kconfig menus
Date: Sat, 29 Sep 2007 09:32:51 +0800
Message-ID: <46FDAB43.5010703@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbSNW-00084H-HA for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:26 -0700
Received: from wr-out-0506.google.com ([64.233.184.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbSNW-00039C-7W
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 19:48:26 -0700
Received: by wr-out-0506.google.com with SMTP id 36so1486750wra
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 28 Sep 2007 19:48:26 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Dave Airlie <airlied@linux.ie>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Randy Dunlap <randy.dunlap@oracle.com>

Move AGP and DRM menus into the video graphics support menu.
  They use 'menuconfig' so that they can all be disabled with
  one selection.
Make the console menu use 'menuconfig' so that it can all be
  disabled with one selection.
Make the frame buffer menu use 'menuconfig' so that it can all be
  disabled with one selection.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Dave Airlie <airlied@linux.ie>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/char/Kconfig     |    4 ----
 drivers/char/agp/Kconfig |    2 +-
 drivers/char/drm/Kconfig |    2 +-
 drivers/video/Kconfig    |   11 +++++++----
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 045f74c..d9bc0b3 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -925,10 +925,6 @@ config GPIO_TB0219
 	depends on TANBAC_TB022X
 	select GPIO_VR41XX
 
-source "drivers/char/agp/Kconfig"
-
-source "drivers/char/drm/Kconfig"
-
 source "drivers/char/pcmcia/Kconfig"
 
 config MWAVE
diff --git a/drivers/char/agp/Kconfig b/drivers/char/agp/Kconfig
index 713533d..f22c253 100644
--- a/drivers/char/agp/Kconfig
+++ b/drivers/char/agp/Kconfig
@@ -1,4 +1,4 @@
-config AGP
+menuconfig AGP
 	tristate "/dev/agpgart (AGP Support)"
 	depends on ALPHA || IA64 || PARISC || PPC || X86
 	depends on PCI
diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
index 0b7ffa5..ba3058d 100644
--- a/drivers/char/drm/Kconfig
+++ b/drivers/char/drm/Kconfig
@@ -4,7 +4,7 @@ #
 # This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 #
-config DRM
+menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && PCI && !EMULATED_CMPXCHG
 	help
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index fbee300..282c351 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -5,8 +5,9 @@ #
 menu "Graphics support"
 	depends on HAS_IOMEM
 
-source "drivers/video/backlight/Kconfig"
-source "drivers/video/display/Kconfig"
+source "drivers/char/agp/Kconfig"
+
+source "drivers/char/drm/Kconfig"
 
 config VGASTATE
        tristate
@@ -18,7 +19,7 @@ config VIDEO_OUTPUT_CONTROL
 	  This framework adds support for low-level control of the video 
 	  output switch.
 
-config FB
+menuconfig FB
 	tristate "Support for frame buffer devices"
 	---help---
 	  The frame buffer device provides an abstraction for the graphics
@@ -1906,6 +1907,9 @@ if ARCH_OMAP
 	source "drivers/video/omap/Kconfig"
 endif
 
+source "drivers/video/backlight/Kconfig"
+source "drivers/video/display/Kconfig"
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
@@ -1915,4 +1919,3 @@ if FB || SGI_NEWPORT_CONSOLE
 endif
 
 endmenu
-


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
