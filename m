From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] C99 initializers for drivers/video/console
Date: Thu, 2 Jan 2003 16:32:39 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030102223239.GF23213@pcdebian.artsapartment.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from covert.brown-ring.iadfw.net ([209.196.123.142])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18UDvk-00075J-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 02 Jan 2003 14:35:12 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org, geert@linux-m68k.org
Cc: Linus Torvalds <torvalds@transmeta.com>

Hi.

Here are patches for two files in drivers/video/console that switch the
files to use C99 initializers. The patches are against 2.5.54.

Art Haas

--- linux-2.5.54/drivers/video/console/sticon.c.old	2003-01-02 07:35:51.000000000 -0600
+++ linux-2.5.54/drivers/video/console/sticon.c	2003-01-02 15:58:58.000000000 -0600
@@ -365,26 +365,26 @@
 }
 
 struct consw sti_con = {
-    con_startup:	sticon_startup,
-    con_init:		sticon_init,
-    con_deinit:		sticon_deinit,
-    con_clear:		sticon_clear,
-    con_putc:		sticon_putc,
-    con_putcs:		sticon_putcs,
-    con_cursor:		sticon_cursor,
-    con_scroll:		sticon_scroll,
-    con_bmove:		sticon_bmove,
-    con_switch:		sticon_switch,
-    con_blank:		sticon_blank,
-    con_font_op:	sticon_font_op,
-    con_set_palette:	sticon_set_palette,
-    con_scrolldelta:	sticon_scrolldelta,
-    con_set_origin:	sticon_set_origin,
-    con_save_screen:	sticon_save_screen, 
-    con_build_attr:	sticon_build_attr,
-    con_invert_region:	sticon_invert_region, 
-    con_screen_pos:	sticon_screen_pos,
-    con_getxy:		sticon_getxy,
+	.con_startup		= sticon_startup,
+	.con_init		= sticon_init,
+	.con_deinit		= sticon_deinit,
+	.con_clear		= sticon_clear,
+	.con_putc		= sticon_putc,
+	.con_putcs		= sticon_putcs,
+	.con_cursor		= sticon_cursor,
+	.con_scroll		= sticon_scroll,
+	.con_bmove		= sticon_bmove,
+	.con_switch		= sticon_switch,
+	.con_blank		= sticon_blank,
+	.con_font_op		= sticon_font_op,
+	.con_set_palette	= sticon_set_palette,
+	.con_scrolldelta	= sticon_scrolldelta,
+	.con_set_origin		= sticon_set_origin,
+	.con_save_screen	= sticon_save_screen, 
+	.con_build_attr		= sticon_build_attr,
+	.con_invert_region	= sticon_invert_region, 
+	.con_screen_pos		= sticon_screen_pos,
+	.con_getxy		= sticon_getxy,
 };
 
 
--- linux-2.5.54/drivers/video/console/sticore.c.old	2003-01-02 07:35:51.000000000 -0600
+++ linux-2.5.54/drivers/video/console/sticore.c	2003-01-02 16:00:15.000000000 -0600
@@ -97,8 +97,8 @@
 }
 
 static const struct sti_conf_flags default_conf_flags = {
-		wait:	STI_WAIT,
-	};
+	.wait	= STI_WAIT,
+};
 
 void
 sti_inq_conf(struct sti_struct *sti)
@@ -118,8 +118,8 @@
 }
 
 static const struct sti_font_flags default_font_flags = {
-		wait:	STI_WAIT,
-		non_text: 0,
+	.wait		= STI_WAIT,
+	.non_text	= 0,
 };
 
 void
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
