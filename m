From: Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH 2.6.7-rc2] get rid of fbmem warning
Date: Mon, 7 Jun 2004 10:10:25 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040607101025.2e30b001@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BXNdp-0002X8-UZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 10:10:33 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BXNdp-00052E-H4
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Jun 2004 10:10:33 -0700
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
To: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Get rid of warning because fb_image data is declared 'const char *' but is
being modified by the copy_from_user.

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-06-07 10:06:59 -07:00
+++ b/drivers/video/fbmem.c	2004-06-07 10:06:59 -07:00
@@ -930,7 +930,7 @@
 			return -ENOMEM;
 		}
 		
-		if (copy_from_user(cursor.image.data, sprite->image.data, size) ||
+		if (copy_from_user((char *)cursor.image.data, sprite->image.data, size) ||
 		    copy_from_user(cursor.mask, sprite->mask, size)) { 
 			kfree(cursor.image.data);
 			kfree(cursor.mask);


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
