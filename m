From: James Simmons <jsimmons@infradead.org>
Subject: Micro patch 1
Date: Tue, 20 Apr 2004 17:36:48 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404201734050.27498-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFyEy-0007Or-P7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:36:56 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BFyEy-0007kY-9U
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:36:56 -0700
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


This patch removes the redundent calculation of p->vrows. This is done in 
fbcon_resize.

--- linus-2.6/drivers/video/console/fbcon.c	2004-04-19 16:32:29.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-04-19 17:39:09.000000000 -0700
@@ -749,14 +749,6 @@
 		vc->vc_cols = nr_cols;
 		vc->vc_rows = nr_rows;
 	}
-	p->vrows = info->var.yres_virtual / vc->vc_font.height;
-	if(info->var.yres > (vc->vc_font.height * (vc->vc_rows + 1))) {
-		p->vrows -= (info->var.yres - (vc->vc_font.height * vc->vc_rows)) / vc->vc_font.height;
-	}
-	if ((info->var.yres % vc->vc_font.height) &&
-	    (info->var.yres_virtual % vc->vc_font.height <
-	     info->var.yres % vc->vc_font.height))
-		p->vrows--;
 	vc->vc_can_do_color = info->var.bits_per_pixel != 1;
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
@@ -1570,6 +1562,8 @@
 	p->vrows = var.yres_virtual/fh;
 	if (var.yres > (fh * (height + 1)))
 		p->vrows -= (var.yres - (fh * height)) / fh;
+	if ((var.yres % fh) && (var.yres_virtual % fh < var.yres % fh))
+		p->vrows--;
 	return 0;
 }
 
@@ -1839,15 +1833,6 @@
 	if (resize) {
 		/* reset wrap/pan */
 		info->var.xoffset = info->var.yoffset = p->yscroll = 0;
-		p->vrows = info->var.yres_virtual / h;
-
-#if 0          /* INCOMPLETE - let the console gurus handle this */
-		if(info->var.yres > (h * (vc->vc_rows + 1))
-			p->vrows -= (info->var.yres - (h * vc->vc_rows)) / h;
-#endif
-		if ((info->var.yres % h)
-		    && (info->var.yres_virtual % h < info->var.yres % h))
-			p->vrows--;
 		updatescrollmode(p, vc);
 		vc_resize(vc->vc_num, info->var.xres / w, info->var.yres / h);
 		if (CON_IS_VISIBLE(vc) && softback_buf) {



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
