From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH][2.5] fbcon.c complement_mask bug (fwd)
Date: Mon, 16 Jun 2003 10:48:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306161048230.14770-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Rpg1-0000NW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 01:49:22 -0700
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5G8mYpI002318
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 16 Jun 2003 10:48:34 +0200 (MEST)
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Sun, 15 Jun 2003 23:34:45 -0400
From: Chris Heath <chris@heathens.co.nz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5] fbcon.c complement_mask bug

When using a frame buffer console with a 512-character font, the mouse
pointer starts using the wrong complement_mask after a console reset.

This patch is against 2.5.71.  It fixes s_complement_mask so that it is
always a valid default value for complement_mask.

Chris


--- a/drivers/video/console/fbcon.c	2003-06-01 09:56:46.000000000 -0400
+++ b/drivers/video/console/fbcon.c	2003-06-15 22:54:47.000000000 -0400
@@ -1826,8 +1826,10 @@
 	vc->vc_font.height = h;
 	if (vc->vc_hi_font_mask && cnt == 256) {
 		vc->vc_hi_font_mask = 0;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask >>= 1;
+			vc->vc_s_complement_mask >>= 1;
+		}
 
 		/* ++Edmund: reorder the attribute bits */
 		if (vc->vc_can_do_color) {
@@ -1847,8 +1849,10 @@
 		}
 	} else if (!vc->vc_hi_font_mask && cnt == 512) {
 		vc->vc_hi_font_mask = 0x100;
-		if (vc->vc_can_do_color)
+		if (vc->vc_can_do_color) {
 			vc->vc_complement_mask <<= 1;
+			vc->vc_s_complement_mask <<= 1;
+		}
 
 		/* ++Edmund: reorder the attribute bits */
 		{

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
