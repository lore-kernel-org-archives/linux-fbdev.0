From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] typo in linux-2.5.63/drivers/video/console/fbcon.c (fwd)
Date: Sun, 2 Mar 2003 13:10:24 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303021310090.9181-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18pSKB-00047N-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 02 Mar 2003 04:12:12 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Sun, 2 Mar 2003 04:02:41 -0800
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: geert@linux-m68k.org
Subject: [PATCH] typo in linux-2.5.63/drivers/video/console/fbcon.c

Hi,
found a small typo in this driver.

so long
	Norbert

--- linux-2.5.63/drivers/video/console/fbcon.c~	2003-02-24 11:05:37.000000000 -0800
+++ linux-2.5.63/drivers/video/console/fbcon.c	2003-03-02 03:03:34.000000000 -0800
@@ -456,7 +456,7 @@
 	region.color = attr_bgcol_ec(p, vc);
 	region.rop = ROP_COPY;
 
-	if (rw & !bottom_only) {
+	if (rw && !bottom_only) {
 		region.dx = info->var.xoffset + rs;
 		region.dy = 0;
 		region.width = rw;



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
