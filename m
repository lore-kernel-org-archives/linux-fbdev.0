From: James Simmons <jsimmons@infradead.org>
Subject: Micro patch 3
Date: Tue, 20 Apr 2004 17:38:56 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404201737590.27498-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFyH0-0007rM-6S
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:39:02 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BFyGz-0000va-SC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:39:02 -0700
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


Remove extra variable. We use i instead of rc. 

--- linus-2.6/drivers/video/fbmem.c	2004-04-19 16:32:25.000000000 -0700
+++ fbdev-2.6/drivers/video/fbmem.c	2004-04-20 09:02:55.000000000 -0700
@@ -1013,7 +1013,7 @@
 	struct fb_con2fbmap con2fb;
 #endif
 	struct fb_cmap cmap;
-	int i, rc;
+	int i;
 	
 	if (!fb)
 		return -ENODEV;
@@ -1055,9 +1055,9 @@
 		return 0;
 	case FBIO_CURSOR:
 		acquire_console_sem();
-		rc = fb_cursor(info, (struct fb_cursor *) arg);
+		i = fb_cursor(info, (struct fb_cursor *) arg);
 		release_console_sem();
-		return rc;
+		return i;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 	case FBIOGET_CON2FBMAP:
 		if (copy_from_user(&con2fb, (void *)arg, sizeof(con2fb)))



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
