From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] atyfb: Fix power management
Date: Wed, 03 Nov 2004 14:15:04 +1100
Message-ID: <1099451704.31629.28.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPC0f-0000bK-Ta
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:40:33 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CPC0e-000653-R7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:40:33 -0800
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

Hi !

The PM code in atyfb got broken in the recent update. This is just a typo though,
here's a fix:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/atyfb_base.c	2004-11-03 14:13:10.319998376 +1100
+++ linux-work/drivers/video/aty/atyfb_base.c	2004-11-03 14:13:45.491651472 +1100
@@ -2015,7 +2015,7 @@
 	}
 	mdelay(500);
 
-	return timeout ? -1 : 0;
+	return timeout ? 0 : -EIO;
 }
 
 static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
