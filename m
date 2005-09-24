From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] framebuffer: add some help text in Kconfig
Date: Fri, 23 Sep 2005 22:56:09 -0700
Message-ID: <20050923225609.0efada07.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJ31B-0000Bm-3n
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Sep 2005 22:56:13 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EJ31A-0004t9-4T
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Sep 2005 22:56:13 -0700
Received: from midway ([71.111.157.99]) by xenotime.net for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 23 Sep 2005 22:56:11 -0700
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
To: adaplas@pol.net, akpm <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net


Frame buffer driver help text changes:
- Move S3 Trio next to S3 Savage;
- add or clarify help text for several FB drivers;
- add help text for FB console;
- add help text for bootup logos;


 drivers/video/Kconfig         |   17 ++++++++++-------
 drivers/video/console/Kconfig |    2 ++
 drivers/video/logo/Kconfig    |    2 ++
 3 files changed, 14 insertions(+), 7 deletions(-)

--- linux-2614-rc2-git3.orig/drivers/video/Kconfig.orig
+++ linux-2614-rc2-git3/drivers/video/Kconfig
@@ -182,6 +182,9 @@ config FB_CLPS711X
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB_SOFT_CURSOR
+	help
+	  Say Y to enable the Framebuffer driver for the CLPS7111 and
+	  EP7212 processors.
 
 config FB_SA1100
 	bool "SA-1100 LCD support"
@@ -405,7 +408,7 @@ config FB_CT65550
 	  65550 graphics chip in PowerBooks.
 
 config FB_ASILIANT
-	bool "Chips 69000 display support"
+	bool "Asiliant (Chips) 69000 display support"
 	depends on (FB = y) && PCI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -422,12 +425,6 @@ config FB_IMSTT
 	  The IMS Twin Turbo is a PCI-based frame buffer card bundled with
 	  many Macintosh and compatible computers.
 
-config FB_S3TRIO
-	bool "S3 Trio display support"
-	depends on (FB = y) && PPC && BROKEN
-	help
-	  If you have a S3 Trio say Y. Say N for S3 Virge.
-
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
 	depends on FB && (X86 || PPC)
@@ -1046,6 +1043,12 @@ config FB_ATY_GX
 	  is at
 	  <http://support.ati.com/products/pc/mach64/graphics_xpression.html>.
 
+config FB_S3TRIO
+	bool "S3 Trio display support"
+	depends on (FB = y) && PPC && BROKEN
+	help
+	  If you have a S3 Trio say Y. Say N for S3 Virge.
+
 config FB_SAVAGE
 	tristate "S3 Savage support"
 	depends on FB && PCI && EXPERIMENTAL
--- linux-2614-rc2-git3.orig/drivers/video/console/Kconfig.orig
+++ linux-2614-rc2-git3/drivers/video/console/Kconfig
@@ -98,6 +98,8 @@ config FRAMEBUFFER_CONSOLE
 	tristate "Framebuffer Console support"
 	depends on FB
 	select CRC32
+	help
+	  Low-level framebuffer-based console driver.
 
 config STI_CONSOLE
         tristate "STI text console" 
--- linux-2614-rc2-git3.orig/drivers/video/logo/Kconfig.orig
+++ linux-2614-rc2-git3/drivers/video/logo/Kconfig
@@ -7,6 +7,8 @@ menu "Logo configuration"
 config LOGO
 	bool "Bootup logo"
 	depends on FB || SGI_NEWPORT_CONSOLE
+	help
+	  Enable and select frame buffer bootup logos.
 
 config LOGO_LINUX_MONO
 	bool "Standard black and white Linux logo"

---


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
