From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: new logo drawing code
Date: Sun, 29 Dec 2002 21:07:39 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0212292057180.17739-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Sjju-0003uK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 29 Dec 2002 12:08:50 -0800
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


Did anyone actually test fbcon_set_logo() on monochrome hardware?

I admit I haven't tried it myself yet (still fighting with amifb), but this
looks more reasonable:
  - Use index i*8+j instead of i*2
  - Replace conditionals by straight code without branches (bit 7 of needs_logo
    is either 0 (normal) or 1 (reverse), and perhaps we should kill the default
    case?).

The second part is an indentation fix.

BTW, most of the new fbdev code looks really ugly in vim with `let
c_space_errors=1', due to the exorbitant use of superfluous whitespace
characters.

--- linux-2.5.53/drivers/video/console/fbcon.c	Tue Dec 10 13:41:40 2002
+++ linux-geert-2.5.53/drivers/video/console/fbcon.c	Sun Dec 29 20:54:30 2002
@@ -2631,12 +2632,12 @@
 	case 1:
 	case ~1:
 	default:
-		for (i = 0; i < (LOGO_W * LOGO_H)/8; i++) 
-			for (j = 0; j < 8; j++) 
-				logo[i*2] = (linux_logo_bw[i] &  (7 - j)) ? 
-					((needs_logo == 1) ? 1 : 0) :
-					((needs_logo == 1) ? 0 : 1);
-				
+		for (i = 0; i < (LOGO_W * LOGO_H)/8; i++) {
+			u8 d = linux_logo_bw[i];
+			for (j = 0; j < 8; j++, d <<= 1)
+				logo[i*8+j] = ((d ^ needs_logo) >> 7) & 1;
+		}
+
 		break;
 	} 
 }	
@@ -2668,8 +2669,8 @@
  * be set to 1.
  */
 static int __init fbcon_show_logo(void)
-	{
-		struct display *p = &fb_display[fg_console];	/* draw to vt in foreground */
+{
+	struct display *p = &fb_display[fg_console];	/* draw to vt in foreground */
 	struct fb_info *info = p->fb_info;
 	struct vc_data *vc = info->display_fg;
 	struct fb_image image;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
