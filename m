From: James Simmons <jsimmons@infradead.org>
Subject: framebuffer GPM corruption fix.
Date: Tue, 10 Feb 2004 17:26:51 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402101726130.6600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aqbf1-0003r9-Lr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:26:59 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aqbex-0000jm-Jb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 09:26:55 -0800
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
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


This patch fixes the GPM cursor corruption people where seeing.

--- fbcon.c	2004-02-09 16:41:26.000000000 -0800
+++ fbcon.c.fix	2004-02-09 16:41:17.000000000 -0800
@@ -1826,9 +1826,11 @@
 	vc->vc_font.height = h;
 	if (vc->vc_hi_font_mask && cnt == 256) {
 		vc->vc_hi_font_mask = 0;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask >>= 1;
-
+			vc->vc_s_complement_mask >>= 1;
+		}
+			
 		/* ++Edmund: reorder the attribute bits */
 		if (vc->vc_can_do_color) {
 			unsigned short *cp =
@@ -1847,9 +1849,11 @@
 		}
 	} else if (!vc->vc_hi_font_mask && cnt == 512) {
 		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask <<= 1;
-
+			vc->vc_s_complement_mask <<= 1;
+		}
+			
 		/* ++Edmund: reorder the attribute bits */
 		{
 			unsigned short *cp =



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
