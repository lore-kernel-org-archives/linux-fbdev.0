From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/20] Use menuconfig objects II:
	video/logo
Date: Sat, 05 May 2007 22:57:40 +0800
Message-ID: <463C9B64.9060907@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDz-0000BK-QF for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:07 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDz-0008EN-Co
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:07 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:07 -0700 (PDT)
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
Cc: Jan Engelhardt <jengelh@gmx.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Jan Engelhardt <jengelh@gmx.de>

Change Kconfig objects from "menu, config" into "menuconfig" so
that the user can disable the whole feature without having to
enter the menu first.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/logo/Kconfig |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index f0e6512..9397bce 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -2,73 +2,69 @@ #
 # Logo configuration
 #
 
-menu "Logo configuration"
-
-config LOGO
+menuconfig LOGO
 	bool "Bootup logo"
 	depends on FB || SGI_NEWPORT_CONSOLE
 	help
 	  Enable and select frame buffer bootup logos.
 
+if LOGO
+
 config LOGO_LINUX_MONO
 	bool "Standard black and white Linux logo"
-	depends on LOGO
 	default y
 
 config LOGO_LINUX_VGA16
 	bool "Standard 16-color Linux logo"
-	depends on LOGO
 	default y
 
 config LOGO_LINUX_CLUT224
 	bool "Standard 224-color Linux logo"
-	depends on LOGO
 	default y
 
 config LOGO_DEC_CLUT224
 	bool "224-color Digital Equipment Corporation Linux logo"
-	depends on LOGO && (MACH_DECSTATION || ALPHA)
+	depends on MACH_DECSTATION || ALPHA
 	default y
 
 config LOGO_MAC_CLUT224
 	bool "224-color Macintosh Linux logo"
-	depends on LOGO && MAC
+	depends on MAC
 	default y
 
 config LOGO_PARISC_CLUT224
 	bool "224-color PA-RISC Linux logo"
-	depends on LOGO && PARISC
+	depends on PARISC
 	default y
 
 config LOGO_SGI_CLUT224
 	bool "224-color SGI Linux logo"
-	depends on LOGO && (SGI_IP22 || SGI_IP27 || SGI_IP32 || X86_VISWS)
+	depends on SGI_IP22 || SGI_IP27 || SGI_IP32 || X86_VISWS
 	default y
 
 config LOGO_SUN_CLUT224
 	bool "224-color Sun Linux logo"
-	depends on LOGO && SPARC
+	depends on SPARC
 	default y
 
 config LOGO_SUPERH_MONO
 	bool "Black and white SuperH Linux logo"
-	depends on LOGO && SUPERH
+	depends on SUPERH
 	default y
 
 config LOGO_SUPERH_VGA16
 	bool "16-color SuperH Linux logo"
-	depends on LOGO && SUPERH
+	depends on SUPERH
 	default y
 
 config LOGO_SUPERH_CLUT224
 	bool "224-color SuperH Linux logo"
-	depends on LOGO && SUPERH
+	depends on SUPERH
 	default y
 
 config LOGO_M32R_CLUT224
 	bool "224-color M32R Linux logo"
-	depends on LOGO && M32R
+	depends on M32R
 	default y
 
-endmenu
-
+endif # LOGO


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
