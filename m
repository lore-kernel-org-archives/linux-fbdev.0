From: Ben Dooks <ben-linux@fluff.org>
Subject: [RFC] SM501: Call fb suspend function during
	suspend and resume.
Date: Tue, 10 Jul 2007 10:01:24 +0100
Message-ID: <20070710090124.GA3628@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8BbB-0000qt-U5 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 02:01:33 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=aeryn.fluff.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I8BbA-0004sd-D8
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 02:01:33 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

I belive the following patch to be correct:

Call the fb_set_suspend() over suspend and resume.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.21-quilt/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.21-quilt.orig/drivers/video/sm501fb.c	2007-05-24 14:58:43.000000000 +0100
+++ linux-2.6.21-quilt/drivers/video/sm501fb.c	2007-05-24 15:06:24.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/wait.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/console.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1697,6 +1698,10 @@ static int sm501fb_suspend_fb(struct sm5
 	/* blank the relevant interface to ensure unit power minimised */
 	(par->ops.fb_blank)(FB_BLANK_POWERDOWN, fbi);
 
+	acquire_console_sem();
+	fb_set_suspend(fbi, 1);
+	release_console_sem();
+
 	return 0;
 
  err_nocursor:
@@ -1732,6 +1737,10 @@ static void sm501fb_resume_fb(struct sm5
 		memcpy_toio(par->cursor.k_addr, par->store_cursor,
 			    par->cursor.size);
 
+	acquire_console_sem();
+	fb_set_suspend(fbi, 0);
+	release_console_sem();
+
 	vfree(par->store_fb);
 	vfree(par->store_cursor);
 }



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
