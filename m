From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: dead code in fbcon
Date: Mon, 10 Feb 2003 10:24:27 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0302101022190.25020-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18iAC1-0008Ih-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Feb 2003 01:25:38 -0800
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


fbcon_changevar() contains some code (copy-and-pasted from
fbcon_set_display()?) which is never used because save is never set to
non-NULL.

--- linux-2.5.59/drivers/video/console/fbcon.c	Fri Jan 17 12:09:27 2003
+++ linux-geert-2.5.59/fbcon.c	Mon Feb 10 10:19:58 2003
@@ -766,7 +766,6 @@
 		struct vc_data *vc = p->conp;
 		int nr_rows, nr_cols;
 		int old_rows, old_cols;
-		unsigned short *save = NULL, *q;
 		int i, charcnt = 256;
 		struct font_desc *font;
 
@@ -846,15 +845,6 @@
 		 	vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
 			accel_clear_margins(vc, p, 0);
 			update_screen(con);
-		}
-		if (save) {
-			q = (unsigned short *) (vc->vc_origin +
-						vc->vc_size_row *
-						old_rows);
-			scr_memcpyw(q, save, logo_lines * nr_cols * 2);
-			vc->vc_y += logo_lines;
-			vc->vc_pos += logo_lines * vc->vc_size_row;
-			kfree(save);
 		}
 
 		if (con == fg_console && softback_buf) {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
