From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbcon fixes
Date: Sun, 15 Jun 2003 21:10:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306151910.h5FJAU0S008580@callisto.of.borg>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amsfep14-int.chello.nl ([213.46.243.22])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Rcwt-00075l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 15 Jun 2003 12:13:55 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Fbcon:
  - Make PROC_CONSOLE() return -1 when the virtual console does not belong to
    the specified fbdev. This way we prevent messing with the wrong fb_info[i]
    later when running fbset from the `wrong' virtual console on multi-headed
    systems.
  - Validate the current cursor position before undrawing the cursor in
    fbcon_cursor(). If we just shrank the frame buffer size, the old cursor
    position may now lay outside the frame buffer region.

--- linux-2.4.x/drivers/video/fbcon.c.orig	Wed Apr  2 13:26:09 2003
+++ linux-2.4.x/drivers/video/fbcon.c	Wed Apr  9 15:33:07 2003
@@ -272,23 +272,22 @@
 int PROC_CONSOLE(const struct fb_info *info)
 {
         int fgc;
-        
-        if (info->display_fg != NULL)
-                fgc = info->display_fg->vc_num;
-        else
-                return -1;
-                
-        if (!current->tty)
-                return fgc;
-
-        if (current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE)
-                /* XXX Should report error here? */
-                return fgc;
 
-        if (MINOR(current->tty->device) < 1)
-                return fgc;
+	if (info->display_fg == NULL)
+		return -1;
 
-        return MINOR(current->tty->device) - 1;
+        if (!current->tty ||
+	    current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE ||
+	    MINOR(current->tty->device) < 1)
+		fgc = info->display_fg->vc_num;
+	else
+		fgc = MINOR(current->tty->device)-1;
+
+	/* Does this virtual console belong to the specified fbdev? */
+	if (fb_display[fgc].fb_info != info)
+		return -1;
+
+	return fgc;
 }
 
 
@@ -925,8 +924,9 @@
 	return;
 
     cursor_on = 0;
-    if (cursor_drawn)
-        p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
+    if (cursor_drawn && p->cursor_x < conp->vc_cols &&
+	p->cursor_y < conp->vc_rows)
+	p->dispsw->revc(p, p->cursor_x, real_y(p, p->cursor_y));
 
     p->cursor_x = conp->vc_x;
     p->cursor_y = y;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
