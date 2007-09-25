From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] video gfx: fix menu ordering
Date: Mon, 24 Sep 2007 23:05:45 -0700
Message-ID: <20070924230545.78797d75.randy.dunlap@oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ia3Zk-0000RZ-U8 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 23:07:17 -0700
Received: from rgminet01.oracle.com ([148.87.113.118])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ia3Zk-0003bE-Gs
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 23:07:16 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm <akpm@linux-foundation.org>, adaplas@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Move video graphics driver configs to fix menus:

Fix FB_PMAGB_B to depend on FB so that the FB menus remain
  listed in order and indented correctly.
Fix FB_IBM_GXT4500 to depend on FB so that the FB menus remain
  listed in order and indented correctly.
The OMAP FB drivers still muck up the FB menu a bit, so I put
  OMAP drivers at the end of the FB menu.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.23-rc8.orig/drivers/video/Kconfig
+++ linux-2.6.23-rc8/drivers/video/Kconfig
@@ -1625,7 +1625,7 @@ config FB_PMAG_BA
 
 config FB_PMAGB_B
 	tristate "PMAGB-B TURBOchannel framebuffer support"
-	depends on TC
+	depends on FB && TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
@@ -1793,7 +1793,7 @@ config FB_PNX4008_DUM_RGB
 
 config FB_IBM_GXT4500
 	tristate "Framebuffer support for IBM GXT4500P adaptor"
-	depends on PPC
+	depends on FB && PPC
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -1833,10 +1833,6 @@ config FB_XILINX
 	  framebuffer. ML300 carries a 640*480 LCD display on the board,
 	  ML403 uses a standard DB15 VGA connector.
 
-if ARCH_OMAP
-	source "drivers/video/omap/Kconfig"
-endif
-
 config FB_VIRTUAL
 	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
 	depends on FB
@@ -1860,6 +1856,10 @@ config FB_VIRTUAL
 
 	  If unsure, say N.
 
+if ARCH_OMAP
+	source "drivers/video/omap/Kconfig"
+endif
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
