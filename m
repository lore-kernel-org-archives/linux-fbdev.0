From: James Simmons <jsimmons@infradead.org>
Subject: micro patch 2
Date: Tue, 20 Apr 2004 17:37:54 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404201736520.27498-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFyFy-0007d1-Vx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:37:58 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BFyFy-00085W-Bk
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 09:37:58 -0700
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


This make the logo handling code easier to read. Merged the two code 
blocks since they test for the exact same condition.


--- linus-2.6/drivers/video/console/fbcon.c	2004-04-19 16:32:29.000000000 -0700
+++ fbdev-2.6/drivers/video/console/fbcon.c	2004-04-20 08:49:37.000000000 -0700
@@ -767,7 +767,7 @@
 			vc->vc_complement_mask <<= 1;
 	}
 
-	if (!init) {
+	if (logo) {
 		if (vc->vc_cols != nr_cols || vc->vc_rows != nr_rows)
 			vc_resize(vc->vc_num, nr_cols, nr_rows);
 		else if (CON_IS_VISIBLE(vc) &&
@@ -784,9 +784,6 @@
 			vc->vc_pos += logo_lines * vc->vc_size_row;
 			kfree(save);
 		}
-	}
-
-	if (logo) {
 		if (logo_lines > vc->vc_bottom) {
 			logo_shown = -1;
 			printk(KERN_INFO



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
