From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] tdfxfb: fix section mismatch warnings
Date: Fri, 11 Jan 2008 17:03:53 -0800
Message-ID: <20080111170353.c28970f8.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDUn5-0001nj-Bh for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 17:04:03 -0800
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JDUn3-00011U-QW
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 17:04:03 -0800
Received: from midway.site ([71.245.106.199]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 11 Jan 2008 17:03:53 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, hmallat@cc.hut.fi
Cc: akpm <akpm@linux-foundation.org>, samr <sam@ravnborg.org>, adaplas@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

tdfxfb_setup() can be __devinit.  This fixes the modpost section mismatch
warnings:

WARNING: vmlinux.o(.text+0x4cff9b): Section mismatch: reference to .init.data:mode_option (between 'tdfxfb_setup' and 'getclkMHz')
WARNING: vmlinux.o(.text+0x4cffa8): Section mismatch: reference to .init.data: (between 'tdfxfb_setup' and 'getclkMHz')

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/tdfxfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.24-rc7-git1.orig/drivers/video/tdfxfb.c
+++ linux-2.6.24-rc7-git1/drivers/video/tdfxfb.c
@@ -1342,7 +1342,7 @@ out_err:
 }
 
 #ifndef MODULE
-static void tdfxfb_setup(char *options)
+static void __devinit tdfxfb_setup(char *options)
 {
 	char *this_opt;
 
---
~Randy

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
