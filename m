From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] i810fb: Fix i810_check_params section
	mismatch
Date: Sun, 17 Dec 2006 18:03:11 +0100
Message-ID: <20061217180311.087f531f.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GvzQ8-0000Nv-Ul for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Dec 2006 09:03:29 -0800
Received: from smtp-100-sunday.nerim.net ([62.4.16.100] helo=kraid.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GvzQ7-0005nR-Cd
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Dec 2006 09:03:28 -0800
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
To: Antonino Daplas <adaplas@pol.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

WARNING: drivers/video/i810/i810fb.o - Section mismatch: reference
to .init.data: from .text between 'i810_check_params' (at offset
0x1123) and 'encode_fix'

yres cannot be declared __devinitdata as it is used in
i810_check_params(), which isn't __devinit.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/video/i810/i810_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.20-rc1.orig/drivers/video/i810/i810_main.c	2006-12-17 16:02:06.000000000 +0100
+++ linux-2.6.20-rc1/drivers/video/i810/i810_main.c	2006-12-17 16:04:01.000000000 +0100
@@ -142,7 +142,7 @@
 static int vsync1     __devinitdata;
 static int vsync2     __devinitdata;
 static int xres       __devinitdata;
-static int yres       __devinitdata;
+static int yres;
 static int vyres      __devinitdata;
 static int sync       __devinitdata;
 static int extvga     __devinitdata;


-- 
Jean Delvare

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
