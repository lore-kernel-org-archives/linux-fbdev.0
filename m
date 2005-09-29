From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] fb: straighten up fb drivers menu
Date: Wed, 28 Sep 2005 21:00:00 -0700
Message-ID: <20050928210000.57fb7ce6.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKpaX-00065a-GS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 21:00:05 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EKpaV-00071F-88
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Sep 2005 21:00:05 -0700
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
To: akpm <akpm@osdl.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sf.net

From: Randy Dunlap <rdunlap@xenotime.net>

Arrange frame buffer menu:
- puts all Epson drivers together
- removes split of FB_PXA and FB_PXA_PARAMETERS by FB_W100
- results in PXA, W100, Epson, S3C2410, & Virtual FB drivers being
  presented at the same menu level as all other FB drivers

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 drivers/video/Kconfig |  118 ++++++++++++++++++++--------------------
 1 files changed, 59 insertions(+), 59 deletions(-)

diff -Naurp linux-2614-rc2-git6/drivers/video/Kconfig~fb_menu_levels linux-2614-rc2-git6/drivers/video/Kconfig
--- linux-2614-rc2-git6/drivers/video/Kconfig~fb_menu_levels	2005-09-27 21:36:24.000000000 -0700
+++ linux-2614-rc2-git6/drivers/video/Kconfig	2005-09-27 22:03:10.000000000 -0700
@@ -641,6 +641,50 @@ config FB_EPSON1355
 	  framebuffer.  Product specs at
 	  <http://www.erd.epson.com/vdc/html/products.htm>.
 
+config FB_E1356
+	tristate "Epson SED1356 framebuffer support"
+	depends on FB && EXPERIMENTAL && PCI && MIPS
+
+config PB1000_CRT
+	bool "Use CRT on Pb1000 (J65)"
+	depends on MIPS_PB1000=y && FB_E1356
+
+config PB1000_NTSC
+	bool "Use Compsite NTSC on Pb1000 (J63)"
+	depends on MIPS_PB1000=y && FB_E1356
+
+config PB1000_TFT
+	bool "Use TFT Panel on Pb1000 (J64)"
+	depends on MIPS_PB1000=y && FB_E1356
+
+config PB1500_CRT
+	bool "Use CRT on Pb1500 " if MIPS_PB1500=y
+	depends on FB_E1356
+
+config PB1500_CRT
+	prompt "Use CRT on Pb1100 "
+	depends on FB_E1356 && MIPS_PB1100=y
+
+config PB1500_TFT
+	bool "Use TFT Panel on Pb1500 " if MIPS_PB1500=y
+	depends on FB_E1356
+
+config PB1500_TFT
+	prompt "Use TFT Panel on Pb1100 "
+	depends on FB_E1356 && MIPS_PB1100=y
+
+config FB_S1D13XXX
+	tristate "Epson S1D13XXX framebuffer support"
+	depends on FB
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  Support for S1D13XXX framebuffer device family (currently only
+	  working with S1D13806). Product specs at
+	  <http://www.erd.epson.com/vdc/html/legacy_13xxx.htm>
+
 config FB_NVIDIA
 	tristate "nVidia Framebuffer Support"
 	depends on FB && PCI
@@ -1249,38 +1293,6 @@ config FB_PM3
 	  similar boards, 3DLabs Permedia3 Create!, Appian Jeronimo 2000
 	  and maybe other boards.
 
-config FB_E1356
-	tristate "Epson SED1356 framebuffer support"
-	depends on FB && EXPERIMENTAL && PCI && MIPS
-
-config PB1000_CRT
-	bool "Use CRT on Pb1000 (J65)"
-	depends on MIPS_PB1000=y && FB_E1356
-
-config PB1000_NTSC
-	bool "Use Compsite NTSC on Pb1000 (J63)"
-	depends on MIPS_PB1000=y && FB_E1356
-
-config PB1000_TFT
-	bool "Use TFT Panel on Pb1000 (J64)"
-	depends on MIPS_PB1000=y && FB_E1356
-
-config PB1500_CRT
-	bool "Use CRT on Pb1500 " if MIPS_PB1500=y
-	depends on FB_E1356
-
-config PB1500_CRT
-	prompt "Use CRT on Pb1100 "
-	depends on FB_E1356 && MIPS_PB1100=y
-
-config PB1500_TFT
-	bool "Use TFT Panel on Pb1500 " if MIPS_PB1500=y
-	depends on FB_E1356
-
-config PB1500_TFT
-	prompt "Use TFT Panel on Pb1100 "
-	depends on FB_E1356 && MIPS_PB1100=y
-
 config FB_AU1100
 	bool "Au1100 LCD Driver"
 	depends on (FB = y) && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
@@ -1472,23 +1484,6 @@ config FB_PXA
 
 	  If unsure, say N.
 
-config FB_W100
-	tristate "W100 frame buffer support"
-	depends on FB && PXA_SHARPSL
- 	select FB_CFB_FILLRECT
- 	select FB_CFB_COPYAREA
- 	select FB_CFB_IMAGEBLIT
-	select FB_SOFT_CURSOR
-	---help---
-	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted and removed from the running kernel whenever you want). The
-	  module will be called vfb. If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-
-	  If unsure, say N.
-
 config FB_PXA_PARAMETERS
 	bool "PXA LCD command line parameters"
 	default n
@@ -1506,17 +1501,22 @@ config FB_PXA_PARAMETERS
 
 	  <file:Documentation/fb/pxafb.txt> describes the available parameters.
 
-config FB_S1D13XXX
-	tristate "Epson S1D13XXX framebuffer support"
-	depends on FB
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
+config FB_W100
+	tristate "W100 frame buffer support"
+	depends on FB && PXA_SHARPSL
+ 	select FB_CFB_FILLRECT
+ 	select FB_CFB_COPYAREA
+ 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
-	help
-	  Support for S1D13XXX framebuffer device family (currently only
-	  working with S1D13806). Product specs at
-	  <http://www.erd.epson.com/vdc/html/legacy_13xxx.htm>
+	---help---
+	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted and removed from the running kernel whenever you want). The
+	  module will be called vfb. If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
 
 config FB_S3C2410
 	tristate "S3C2410 LCD framebuffer support"

---


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
