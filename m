From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] fb menu: fix FB_OMAP dependencies so
 that menu is displayed correctly
Date: Sun, 21 Oct 2007 21:47:20 -0700
Message-ID: <20071021214720.f551a387.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IjpCF-0007rq-5X for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 21:47:23 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1IjpCE-0001ub-VN
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 21 Oct 2007 21:47:23 -0700
Received: from midway.site ([71.117.233.180]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 21 Oct 2007 21:47:21 -0700
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

Fix FB_OMAP dependencies so that the OMAP FB driver options are
presented correctly.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/Kconfig      |    4 +---
 drivers/video/omap/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.23-git13.orig/drivers/video/Kconfig
+++ linux-2.6.23-git13/drivers/video/Kconfig
@@ -1892,9 +1892,7 @@ config FB_VIRTUAL
 
 	  If unsure, say N.
 
-if ARCH_OMAP
-	source "drivers/video/omap/Kconfig"
-endif
+source "drivers/video/omap/Kconfig"
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
--- linux-2.6.23-git13.orig/drivers/video/omap/Kconfig
+++ linux-2.6.23-git13/drivers/video/omap/Kconfig
@@ -1,6 +1,6 @@
 config FB_OMAP
 	tristate "OMAP frame buffer support (EXPERIMENTAL)"
-	depends on FB
+	depends on FB && ARCH_OMAP
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
