From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/8] fbdev: Fix source copy bug in neofb
Date: Tue, 2 Nov 2004 19:46:21 +0800
Message-ID: <200411021946.21191.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COx7x-0002mU-Mb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:47:05 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1COx7x-0006Ft-2W
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 03:47:05 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 54761745F6
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  2 Nov 2004 11:46:49 +0000 (UTC)
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

Fix copy system-io copy bug.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 neofb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	2004-10-29 05:38:32 +08:00
+++ b/drivers/video/neofb.c	2004-11-01 07:21:53 +08:00
@@ -1529,7 +1529,7 @@
 	       &par->neo2200->xyExt);
 
 	for (i = 0; i < data_len; i++)
-		writeb(image->data[i], par->mmio_vbase + 0x100000);
+		writeb(image->data[i], par->mmio_vbase + 0x100000 + i);
 }
 
 static void




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
