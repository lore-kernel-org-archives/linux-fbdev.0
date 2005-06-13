From: James Simmons <jsimmons@www.infradead.org>
Subject: access_align fixes.
Date: Mon, 13 Jun 2005 17:46:46 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506131745350.899@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dhs5K-0002lZ-4U
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Jun 2005 09:46:50 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Dhs5J-0002pR-9r
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Jun 2005 09:46:50 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch makes sure all drivers use or set access_align properly.
It will be needed will future soft accel functions.

--- linus-2.6/drivers/video/fbmem.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/fbmem.c	2005-06-13 09:25:56.000000000 -0700
@@ -1081,7 +1034,7 @@
 			fb_info->pixmap.size = FBPIXMAPSIZE;
 			fb_info->pixmap.buf_align = 1;
 			fb_info->pixmap.scan_align = 1;
-			fb_info->pixmap.access_align = 4;
+			fb_info->pixmap.access_align = 32;
 			fb_info->pixmap.flags = FB_PIXMAP_DEFAULT;
 		}
 	}	
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_main.c fbdev-2.6/drivers/video/i810/i810_main.c
--- linus-2.6/drivers/video/i810/i810_main.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/i810/i810_main.c	2005-06-13 08:46:11.000000000 -0700
@@ -1885,6 +1885,7 @@
 	memset(info->pixmap.addr, 0, 8*1024);
 	info->pixmap.size = 8*1024;
 	info->pixmap.buf_align = 8;
+	info->pixmap.access_align = 32;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
 	if ((err = i810_allocate_pci_resource(par, entry))) {
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/intelfbdrv.c fbdev-2.6/drivers/video/intelfb/intelfbdrv.c
--- linus-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-04 10:33:41.000000000 -0700
+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-13 08:45:21.000000000 -0700
@@ -1083,6 +1083,7 @@
 
 	info->pixmap.size = 64*1024;
 	info->pixmap.buf_align = 8;
+	info->pixmap.access_align = 32;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
 	if (intelfb_init_var(dinfo))
--- linus-2.6/drivers/video/nvidia/nvidia.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/nvidia/nvidia.c	2005-06-13 08:44:12.000000000 -0700
@@ -1348,6 +1345,7 @@
 
 	info->pixmap.scan_align = 4;
 	info->pixmap.buf_align = 4;
+	info->pixmap.access_align = 32;
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/riva/fbdev.c fbdev-2.6/drivers/video/riva/fbdev.c
--- linus-2.6/drivers/video/riva/fbdev.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-06-13 08:42:27.000000000 -0700
@@ -1727,6 +1723,7 @@
 
 	info->pixmap.size = 8 * 1024;
 	info->pixmap.buf_align = 4;
+	info->pixmap.access_align = 32;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 	info->var.yres_virtual = -1;
 	NVTRACE_LEAVE();
diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/savage/savagefb_driver.c fbdev-2.6/drivers/video/savage/savagefb_driver.c
--- linus-2.6/drivers/video/savage/savagefb_driver.c	2005-05-10 08:39:33.000000000 -0700
+++ fbdev-2.6/drivers/video/savage/savagefb_driver.c	2005-06-13 08:43:02.000000000 -0700
@@ -1897,7 +1897,7 @@
 		info->pixmap.size = 8*1024;
 		info->pixmap.scan_align = 4;
 		info->pixmap.buf_align = 4;
-		info->pixmap.access_align = 4;
+		info->pixmap.access_align = 32;
 
 		fb_alloc_cmap (&info->cmap, NR_PALETTE, 0);
 		info->flags |= FBINFO_HWACCEL_COPYAREA |


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
