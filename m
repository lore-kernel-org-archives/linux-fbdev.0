From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/10] fbdev: Clean up of sparc FB
	options
Date: Thu, 17 May 2007 05:17:34 +0800
Message-ID: <464B74EE.5040407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HoR9L-0005vP-Pv for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:12 -0700
Received: from wx-out-0506.google.com ([66.249.82.231])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HoR9I-0004vZ-4r
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 May 2007 14:35:11 -0700
Received: by wx-out-0506.google.com with SMTP id i30so629531wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 May 2007 14:35:07 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "David S. Miller" <davem@davemloft.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch puts all SBUS/UPA selection under one option "SBUS/UPA
framebuffers" and moves all sparc specific drivers next to them
in one group.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig |  176 ++++++++++++++++++++++++-------------------------
 1 files changed, 86 insertions(+), 90 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ef8e97a..ce09836 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -711,6 +711,91 @@ config FB_CG6
 	  This is the frame buffer device driver for the CGsix (GX, TurboGX)
 	  frame buffer.
 
+config FB_FFB
+	bool "Creator/Creator3D/Elite3D support"
+	depends on FB_SBUS && SPARC64
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the Creator, Creator3D,
+	  and Elite3D graphics boards.
+
+config FB_TCX
+	bool "TCX (SS4/SS5 only) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the TCX 24/8bit frame
+	  buffer.
+
+config FB_CG14
+	bool "CGfourteen (SX) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the CGfourteen frame
+	  buffer on Desktop SPARCsystems with the SX graphics option.
+
+config FB_P9100
+	bool "P9100 (Sparcbook 3 only) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the P9100 card
+	  supported on Sparcbook 3 machines.
+
+config FB_LEO
+	bool "Leo (ZX) support"
+	depends on FB_SBUS
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the SBUS-based Sun ZX
+	  (leo) frame buffer cards.
+
+config FB_IGA
+	bool "IGA 168x display support"
+	depends on FB && SPARC32
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the INTERGRAPHICS 1680 and
+	  successor frame buffer cards.
+
+config FB_XVR500
+	bool "Sun XVR-500 3DLABS Wildcat support"
+	depends on FB && PCI && SPARC64
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the Sun XVR-500 and similar
+	  graphics cards based upon the 3DLABS Wildcat chipset.  The driver
+	  only works on sparc64 systems where the system firwmare has
+	  mostly initialized the card already.  It is treated as a
+	  completely dumb framebuffer device.
+
+config FB_XVR2500
+	bool "Sun XVR-2500 3DLABS Wildcat support"
+	depends on FB && PCI && SPARC64
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer device for the Sun XVR-2500 and similar
+	  graphics cards based upon the 3DLABS Wildcat chipset.  The driver
+	  only works on sparc64 systems where the system firwmare has
+	  mostly initialized the card already.  It is treated as a
+	  completely dumb framebuffer device.
+
 config FB_PVR2
 	tristate "NEC PowerVR 2 display support"
 	depends on FB && SH_DREAMCAST
@@ -1202,7 +1287,7 @@ config FB_ATY
 config FB_ATY_CT
 	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
 	depends on PCI && FB_ATY
-	default y if SPARC64 && FB_PCI
+	default y if SPARC64 && PCI
 	help
 	  Say Y here to support use of ATI's 64-bit Rage boards (or other
 	  boards based on the Mach64 CT, VT, GT, and LT chipsets) as a
@@ -1491,95 +1576,6 @@ config FB_AU1200
 
 source "drivers/video/geode/Kconfig"
 
-config FB_FFB
-	bool "Creator/Creator3D/Elite3D support"
-	depends on FB_SBUS && SPARC64
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the Creator, Creator3D,
-	  and Elite3D graphics boards.
-
-config FB_TCX
-	bool "TCX (SS4/SS5 only) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the TCX 24/8bit frame
-	  buffer.
-
-config FB_CG14
-	bool "CGfourteen (SX) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the CGfourteen frame
-	  buffer on Desktop SPARCsystems with the SX graphics option.
-
-config FB_P9100
-	bool "P9100 (Sparcbook 3 only) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the P9100 card
-	  supported on Sparcbook 3 machines.
-
-config FB_LEO
-	bool "Leo (ZX) support"
-	depends on FB_SBUS
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the frame buffer device driver for the SBUS-based Sun ZX
-	  (leo) frame buffer cards.
-
-config FB_XVR500
-	bool "Sun XVR-500 3DLABS Wildcat support"
-	depends on (FB = y) && PCI && SPARC64
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for the Sun XVR-500 and similar
-	  graphics cards based upon the 3DLABS Wildcat chipset.  The driver
-	  only works on sparc64 systems where the system firwmare has
-	  mostly initialized the card already.  It is treated as a
-	  completely dumb framebuffer device.
-
-config FB_XVR2500
-	bool "Sun XVR-2500 3DLABS Wildcat support"
-	depends on (FB = y) && PCI && SPARC64
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for the Sun XVR-2500 and similar
-	  graphics cards based upon the 3DLABS Wildcat chipset.  The driver
-	  only works on sparc64 systems where the system firwmare has
-	  mostly initialized the card already.  It is treated as a
-	  completely dumb framebuffer device.
-
-config FB_PCI
-	bool "PCI framebuffers"
-	depends on (FB = y) && PCI && SPARC
-
-config FB_IGA
-	bool "IGA 168x display support"
-	depends on SPARC32 && FB_PCI
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
-	help
-	  This is the framebuffer device for the INTERGRAPHICS 1680 and
-	  successor frame buffer cards.
-
 config FB_HIT
 	tristate "HD64461 Frame Buffer support"
 	depends on FB && HD64461


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
