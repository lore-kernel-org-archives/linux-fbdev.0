From: James Simmons <jsimmons@infradead.org>
Subject: [BK RIVA FBDEV] updates
Date: Mon, 12 May 2003 23:11:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0305122308510.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Kill off some warnings.


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
 
