From: James Simmons <jsimmons@infradead.org>
Subject: Re: Vesa fix
Date: Mon, 12 May 2003 22:53:01 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305122252120.14641-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19FLFU-0004PZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 12 May 2003 14:54:25 -0700
In-Reply-To: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> 
> Hi!
>   
>    The results of the EDID info from the BIOS has been varied. For some it 
> worked. Others it gave the wrong data. Then for other even the headers 
> where corrupted :-( So this patch pulls out the EDID code from Vesa. The 
> EDID code works for PPC tho :-)
> 
> 
> -

Oop.s Forgot patch.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1078  -> 1.1079 
#	drivers/video/vesafb.c	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1079
# [VESA FBDEV] Removed the EDID code. The results where mixed. It worked for some but not for others.
# --------------------------------------------
#
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	Mon May 12 14:26:05 2003
+++ b/drivers/video/vesafb.c	Mon May 12 14:26:05 2003
@@ -215,7 +215,6 @@
 int __init vesafb_init(void)
 {
 	int video_cmap_len;
-	char *edid = 0;
 	int i;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
@@ -300,18 +299,10 @@
 		ypan = 0;
 	}
 
-#ifdef __i386__
-	edid = get_EDID_from_BIOS(0);
-	if (edid)
-		parse_edid(edid, &vesafb_defined);	
-	else		
-#endif
-	{	
-		/* some dummy values for timing to make fbset happy */
-		vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
-		vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
-		vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
-	}
+	/* some dummy values for timing to make fbset happy */
+	vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
+	vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
+	vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
 	
 	if (vesafb_defined.bits_per_pixel > 8) {
 		vesafb_defined.red.offset    = screen_info.red_pos;



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
