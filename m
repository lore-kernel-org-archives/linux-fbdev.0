From: James Simmons <jsimmons@infradead.org>
Subject: Riva Framebuffer update.
Date: Tue, 13 May 2003 22:46:32 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305132245140.12672-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Fhc5-0002dY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 13 May 2003 14:47:10 -0700
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This kills off warnings about unused variables. Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1079  -> 1.1080 
#	drivers/video/riva/fbdev.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1080
# [RIVA FBDEV] Removal of exccess variable. Kills off a few warnings.
# --------------------------------------------
#
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Mon May 12 14:53:32 2003
+++ b/drivers/video/riva/fbdev.c	Mon May 12 14:53:32 2003
@@ -1469,10 +1469,10 @@
 static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
-	int i, j, d_idx = 0, s_idx = 0;
 	u8 data[MAX_CURS * MAX_CURS/8];
 	u8 mask[MAX_CURS * MAX_CURS/8];
 	u16 fg, bg;
+	int i;
 
 	par->riva.ShowHideCursor(&par->riva, 0);
 



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
