From: James Simmons <jsimmons@infradead.org>
Subject: Console bug fix.
Date: Tue, 13 May 2003 22:41:52 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305132237570.12672-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19FhXa-0007EZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 14:42:31 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


The font size needs to be set for all terminals. This patch fixes that. 
Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1077  -> 1.1078 
#	drivers/char/vt_ioctl.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1078
# [CONSOLE] This was the bug that was causing dual head (vga and mda) to lock up.
# --------------------------------------------
#
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Mon May 12 14:12:47 2003
+++ b/drivers/char/vt_ioctl.c	Mon May 12 14:12:47 2003
@@ -869,13 +869,13 @@
 		if (clin > 32)
 			return -EINVAL;
 		    
-		if (vlin)
-			vc->vc_scan_lines = vlin;
-		if (clin)
-			vc->vc_font.height = clin;
-	
-		for (i = 0; i < MAX_NR_CONSOLES; i++)
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			if (vlin)
+				vc_cons[i].d->vc_scan_lines = vlin;
+			if (clin)
+				vc_cons[i].d->vc_font.height = clin;
 			vc_resize(i, cc, ll);
+		}
   		return 0;
 	}
 



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
