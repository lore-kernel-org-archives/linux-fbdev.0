From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: [PATCH] savagefb: fix section mismatch warnings
Date: Fri, 14 Apr 2006 22:02:58 -0700
Message-ID: <20060414220258.c6160661.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUcte-0005Vo-3s
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 22:00:34 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1FUctd-0004Qy-5a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Apr 2006 22:00:34 -0700
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 14 Apr 2006 22:00:31 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, akpm <akpm@osdl.org>

From: Randy Dunlap <rdunlap@xenotime.net>

Fix modpost section mismatch warnings in savagefb driver:

WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.text: from .exit.text after 'savagefb_remove' (at offset 0x66)
WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.text: from .exit.text after 'savagefb_remove' (at offset 0x6e)
WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.text: from .text.savagefb_resume after 'savagefb_resume' (at offset 0x70)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/video/savage/savagefb_driver.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2617-rc1g8.orig/drivers/video/savage/savagefb_driver.c
+++ linux-2617-rc1g8/drivers/video/savage/savagefb_driver.c
@@ -1545,7 +1545,7 @@ static int __devinit savage_map_mmio (st
 	return 0;
 }
 
-static void __devinit savage_unmap_mmio (struct fb_info *info)
+static void savage_unmap_mmio (struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
 	DBG ("savage_unmap_mmio");
@@ -1597,7 +1597,7 @@ static int __devinit savage_map_video (s
 	return 0;
 }
 
-static void __devinit savage_unmap_video (struct fb_info *info)
+static void savage_unmap_video (struct fb_info *info)
 {
 	struct savagefb_par *par = info->par;
 
@@ -1614,7 +1614,7 @@ static void __devinit savage_unmap_video
 	}
 }
 
-static int __devinit savage_init_hw (struct savagefb_par *par)
+static int savage_init_hw (struct savagefb_par *par)
 {
 	unsigned char config1, m, n, n1, n2, sr8, cr3f, cr66 = 0, tmp;
 


---


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
