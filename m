From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch] Correct colour handling (fwd)
Date: Wed, 23 Oct 2002 16:14:52 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210231614330.2882-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 184MHm-0004cb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Oct 2002 07:15:02 -0700
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
Cc: Martin Schulze <joey@infodrom.org>


Any comments?

---------- Forwarded message ----------
Date: Sat, 19 Oct 2002 18:50:54 +0200
From: Martin Schulze <joey@infodrom.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Correct colour handling

Moin Ralf,

please apply the patch below which will correct colour handling.  The
outcome of this patch will only be visible with a monochrome graphics
card since they can see what is written on the screen again.

As you can see, not all occasions where the currently used colour is
changed, isn't protected by the 'if (can_do_color)' check.  Some
occurrences though use it.

This patch is done basically by Thiemo Seufer during this years'
Oldenburg meeting.

Regards,

	Joey


Index: console.c
===================================================================
RCS file: /home/cvs/linux/drivers/char/console.c,v
retrieving revision 1.37.2.2
diff -u -r1.37.2.2 console.c
--- console.c	26 Jun 2002 22:35:32 -0000	1.37.2.2
+++ console.c	19 Oct 2002 16:47:01 -0000
@@ -1046,7 +1046,8 @@
 	underline = 0;
 	reverse = 0;
 	blink = 0;
-	color = def_color;
+	if (can_do_color)
+		color = def_color;
 }
 
 /* console_sem is held */
@@ -1119,7 +1120,8 @@
 				  * with white underscore (Linux - use
 				  * default foreground).
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 1;
 				break;
 			case 39: /* ANSI X3.64-1979 (SCO-ish?)
@@ -1127,11 +1129,13 @@
 				  * Reset colour to default? It did this
 				  * before...
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 0;
 				break;
 			case 49:
-				color = (def_color & 0xf0) | foreground;
+			  	if (can_do_color)
+					color = (def_color & 0xf0) | foreground;
 				break;
 			default:
 				if (par[i] >= 30 && par[i] <= 37)
@@ -1274,9 +1278,11 @@
 			}
 			break;
 		case 8:	/* store colors as defaults */
-			def_color = attr;
-			if (hi_font_mask == 0x100)
-				def_color >>= 1;
+			if (can_do_color) {
+				def_color = attr;
+				if (hi_font_mask == 0x100)
+					def_color >>= 1;
+			}
 			default_attr(currcons);
 			update_attr(currcons);
 			break;
-- 
Every use of Linux is a proper use of Linux.  -- Jon "Maddog" Hall



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
