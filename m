From: Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] eliminate warnings from unused variable in matrox frame
 buffer
Date: Mon, 7 Jun 2004 10:13:13 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040607101313.46e02b07@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXNgT-0003B5-Le
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 10:13:17 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXNgT-00037v-0l
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 10:13:17 -0700
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

The parameter 'inverse' is defined and never used, therefore it can be removed.
This gets rid of a compiler warning when matrox fb is built as a module.

diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	2004-06-07 10:08:03 -07:00
+++ b/drivers/video/matrox/matroxfb_base.c	2004-06-07 10:08:03 -07:00
@@ -1247,7 +1247,6 @@
 static int novga;			/* "matrox:novga" */
 static int nobios;			/* "matrox:nobios" */
 static int noinit = 1;			/* "matrox:init" */
-static int inverse;			/* "matrox:inverse" */
 static int sgram;			/* "matrox:sgram" */
 #ifdef CONFIG_MTRR
 static int mtrr = 1;			/* "matrox:nomtrr" */
@@ -2376,9 +2375,7 @@
 				value = 0;
 				this_opt += 2;
 			}
-			if (! strcmp(this_opt, "inverse"))
-				inverse = value;
-			else if (!strcmp(this_opt, "accel"))
+			if (!strcmp(this_opt, "accel"))
 				noaccel = !value;
 			else if (!strcmp(this_opt, "pan"))
 				nopan = !value;
@@ -2459,8 +2456,6 @@
 MODULE_PARM_DESC(sgram, "Indicates that G100/G200/G400 has SGRAM memory (0=SDRAM, 1=SGRAM) (default=0)");
 MODULE_PARM(inv24, "i");
 MODULE_PARM_DESC(inv24, "Inverts clock polarity for 24bpp and loop frequency > 100MHz (default=do not invert polarity)");
-MODULE_PARM(inverse, "i");
-MODULE_PARM_DESC(inverse, "Inverse (0 or 1) (default=0)");
 #ifdef CONFIG_FB_MATROX_MULTIHEAD
 MODULE_PARM(dev, "i");
 MODULE_PARM_DESC(dev, "Multihead support, attach to device ID (0..N) (default=all working)");


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
