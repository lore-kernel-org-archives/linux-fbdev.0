From: James Simmons <jsimmons@infradead.org>
Subject: micro patch 4.
Date: Tue, 20 Apr 2004 17:45:47 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404201739010.27498-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFyNb-00014E-MF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:45:51 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BFyNb-0001Up-2n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:45:51 -0700
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Set the default access_align variable. This variable tells us how much 
data the hardware can handle in a single read/write cycle. For example 
the epson chipset can handle only 16 bit reads and writes to the 
framebuffer. 

--- linus-2.6/drivers/video/fbmem.c	2004-04-19 16:32:25.000000000 -0700
+++ fbdev-2.6/drivers/video/fbmem.c	2004-04-20 09:06:07.000000000 -0700
@@ -1286,6 +1286,7 @@
 			fb_info->pixmap.size = FBPIXMAPSIZE;
 			fb_info->pixmap.buf_align = 1;
 			fb_info->pixmap.scan_align = 1;
+			fb_info->pixmap.access_align = 4;
 			fb_info->pixmap.flags = FB_PIXMAP_DEFAULT;
 		}
 	}	
@@ -1301,6 +1302,7 @@
 			fb_info->sprite.size = FBPIXMAPSIZE;
 			fb_info->sprite.buf_align = 1;
 			fb_info->sprite.scan_align = 1;
+			fb_info->sprite.access_align = 4;
 			fb_info->sprite.flags = FB_PIXMAP_DEFAULT;
 		}
 	}



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
