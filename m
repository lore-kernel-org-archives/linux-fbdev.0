From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: [PATCH 1/1: 2.6.15-rc6] Fix clearing of vertical margins
Date: Tue, 20 Dec 2005 11:06:43 +0100
Message-ID: <43A7D7B3.6000907@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoeVQ-0007YI-H8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 02:14:04 -0800
Received: from mailout11.sul.t-online.com ([194.25.134.85])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoeVN-00026u-OQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 02:14:04 -0800
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Whenever the font width does not divide the x resolution, the remainder
of this division is a vertical margin at right of the screen. Whatever the
video memory contains in that margin is displayed.

This patch corrects this behaviour. There is no performance impact
as long as there is no vertical margin as fbcon_clear_margins() and
bit_clear_margins() only execute additional code if really necessary.

I think this patch should be applied before 2.6.15-final.

Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' linuxorig/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linuxorig/drivers/video/console/fbcon.c	2005-12-15 10:34:42.000000000 +0100
+++ linux/drivers/video/console/fbcon.c	2005-12-20 09:41:32.000000000 +0100
@@ -1399,7 +1399,7 @@ static __inline__ void ypan_up(struct vc
 	ops->var.yoffset = p->yscroll * vc->vc_font.height;
 	ops->var.vmode &= ~FB_VMODE_YWRAP;
 	ops->update_start(info);
-	fbcon_clear_margins(vc, 1);
+	fbcon_clear_margins(vc, 0);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max = scrollback_phys_max;
@@ -1426,7 +1426,7 @@ static __inline__ void ypan_up_redraw(st
 	ops->var.yoffset = p->yscroll * vc->vc_font.height;
 	ops->var.vmode &= ~FB_VMODE_YWRAP;
 	ops->update_start(info);
-	fbcon_clear_margins(vc, 1);
+	fbcon_clear_margins(vc, 0);
 	scrollback_max += count;
 	if (scrollback_max > scrollback_phys_max)
 		scrollback_max = scrollback_phys_max;
@@ -1450,7 +1450,7 @@ static __inline__ void ypan_down(struct 
 	ops->var.yoffset = p->yscroll * vc->vc_font.height;
 	ops->var.vmode &= ~FB_VMODE_YWRAP;
 	ops->update_start(info);
-	fbcon_clear_margins(vc, 1);
+	fbcon_clear_margins(vc, 0);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
 		scrollback_max = 0;
@@ -1477,7 +1477,7 @@ static __inline__ void ypan_down_redraw(
 	ops->var.yoffset = p->yscroll * vc->vc_font.height;
 	ops->var.vmode &= ~FB_VMODE_YWRAP;
 	ops->update_start(info);
-	fbcon_clear_margins(vc, 1);
+	fbcon_clear_margins(vc, 0);
 	scrollback_max -= count;
 	if (scrollback_max < 0)
 		scrollback_max = 0;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
