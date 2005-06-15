From: James Simmons <jsimmons@www.infradead.org>
Subject: [PATCH] fill in the access_align field.
Date: Thu, 16 Jun 2005 00:57:07 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506160055050.2231@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dihkx-0001du-UO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 16:57:15 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Dihkw-0008PB-5E
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Jun 2005 16:57:15 -0700
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Several drivers miss filling in the access_align field. So this patch has 
them fill it in.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>

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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
