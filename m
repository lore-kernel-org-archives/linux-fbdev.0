From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbcon: Fix endian bug in fbcon_putc (console mouse problem)
Date: Thu, 28 Oct 2004 06:11:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410280611.49045.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMvvM-0007Af-J1
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 15:05:44 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMvvL-0006rX-Ih
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Oct 2004 15:05:44 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 182868F31E5
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 27 Oct 2004 22:05:29 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The typecast (const unsigned short *) &c in fbcon_putc is not correct for
big-endian machines.  This problem manifests as a black cursor that can be
used to erase the console screen contents.  The correct fix is to use scr_writew
instead.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbcon.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-10-26 23:49:13 +08:00
+++ b/drivers/video/console/fbcon.c	2004-10-27 09:07:57 +08:00
@@ -1012,7 +1012,10 @@
 
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
-	fbcon_putcs(vc, (const unsigned short *) &c, 1, ypos, xpos);
+	unsigned short chr;
+
+	scr_writew(c, &chr);
+	fbcon_putcs(vc, &chr, 1, ypos, xpos);
 }
 
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
