From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Fix Au1100 fb dependencies, add helptext
Date: Mon, 23 Jul 2007 18:42:12 +0100
Message-ID: <20070723174212.GA31907@linux-mips.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ID1vU-0002Kc-Oy for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jul 2007 10:42:32 -0700
Received: from ftp.linux-mips.org ([194.74.144.162])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ID1vS-0007es-TX
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Jul 2007 10:42:32 -0700
Received: from localhost.localdomain ([127.0.0.1]:41640 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022736AbXGWRmQ (ORCPT
	<rfc822;linux-fbdev-devel@lists.sourceforge.net>);
	Mon, 23 Jul 2007 18:42:16 +0100
Content-Disposition: inline
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
To: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 drivers/video/Kconfig |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: upstream-linus/drivers/video/Kconfig
===================================================================
--- upstream-linus.orig/drivers/video/Kconfig
+++ upstream-linus/drivers/video/Kconfig
@@ -1571,7 +1571,14 @@ config FB_PM3
 
 config FB_AU1100
 	bool "Au1100 LCD Driver"
-	depends on (FB = y) && EXPERIMENTAL && PCI && MIPS && MIPS_PB1100=y
+	depends on (FB = y) && MIPS && SOC_AU1100
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the framebuffer driver for the AMD Au1100 SOC.  It can drive
+	  various panels and CRTs by passing in kernel cmd line option
+	  au1100fb:panel=<name>.
 
 config FB_AU1200
 	bool "Au1200 LCD Driver"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
