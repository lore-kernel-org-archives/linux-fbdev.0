From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/8] fbdev: Fix access to ROM in aty128fb
Date: Tue, 2 Nov 2004 19:46:09 +0800
Message-ID: <200411021946.09621.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COx7S-0002gA-Vl
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:46:34 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1COx7S-00069t-Dp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:46:34 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D677971411
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 11:46:15 +0000 (UTC)
Content-Disposition: inline
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix access to ROM in aty128fb. Found by sparse.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 aty128fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	2004-10-24 05:46:29 +08:00
+++ b/drivers/video/aty/aty128fb.c	2004-10-31 12:36:43 +08:00
@@ -939,7 +939,7 @@
                 rom_base = ioremap(segstart, 0x10000);
 		if (rom_base == NULL)
 			return NULL;
-                if ((*rom_base == 0x55) && (((*(rom_base + 1)) & 0xff) == 0xaa))
+		if (readb(rom_base) == 0x55 && readb(rom_base + 1) == 0xaa)
 	                break;
                 iounmap(rom_base);
 		rom_base = NULL;




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
