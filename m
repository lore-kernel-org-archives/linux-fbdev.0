From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH] sm501fb: fix printk format warnings
Date: Mon, 30 Apr 2007 17:58:53 -0700
Message-ID: <20070430175853.4f315a1e.randy.dunlap@oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HigeQ-0006F7-Oq for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 17:55:30 -0700
Received: from agminet01.oracle.com ([141.146.126.228])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HigeQ-0003UW-GU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Apr 2007 17:55:30 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm <akpm@linux-foundation.org>, adaplas@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix printk format warnings:
drivers/video/sm501fb.c:992: warning: format '%08x' expects type 'unsigned int', but argument 3 has type 'long unsigned int'
drivers/video/sm501fb.c:992: warning: format '%08x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/sm501fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.21-git3.orig/drivers/video/sm501fb.c
+++ linux-2.6.21-git3/drivers/video/sm501fb.c
@@ -989,7 +989,7 @@ static int sm501fb_cursor(struct fb_info
 			((info->cmap.green[fg_col] & 0xFC) << 3) |
 			((info->cmap.blue[fg_col] & 0xF8) >> 3);
 
-		dev_dbg(fbi->dev, "fgcol %08x, bgcol %08x\n", fg, bg);
+		dev_dbg(fbi->dev, "fgcol %08lx, bgcol %08lx\n", fg, bg);
 
 		writel(bg, base + SM501_OFF_HWC_COLOR_1_2);
 		writel(fg, base + SM501_OFF_HWC_COLOR_3);

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
