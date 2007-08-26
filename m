From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/20] newportcon: Fix font dependency
 for SGI Newport console driver
Date: Sun, 26 Aug 2007 21:55:23 +0800
Message-ID: <46D1864B.2040601@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJ10-000553-Am for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:22:58 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ10-00011m-16
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:22:58 -0700
Received: by py-out-1112.google.com with SMTP id a25so368092pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:22:57 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ralf Baechle <ralf@linux-mips.org>

From: Ralf Baechle <ralf@linux-mips.org>

We better select a font when the newport driver is a module or the user
experience might suffer.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 4964396..087c091 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -182,7 +182,7 @@ config FONT_8x8
 
 config FONT_8x16
 	bool "VGA 8x16 font" if FONTS
-	depends on FRAMEBUFFER_CONSOLE || SGI_NEWPORT_CONSOLE=y || STI_CONSOLE || USB_SISUSBVGA_CON 
+	depends on FRAMEBUFFER_CONSOLE || SGI_NEWPORT_CONSOLE || STI_CONSOLE || USB_SISUSBVGA_CON
 	default y if !SPARC && !FONTS
 	help
 	  This is the "high resolution" font for the VGA frame buffer (the one


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
