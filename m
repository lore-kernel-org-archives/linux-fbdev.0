From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbcon crashes
Date: Wed, 9 Apr 2003 16:08:31 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304091603470.21742-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193GFz-0007T5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 07:08:56 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id QAA12979
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Apr 2003 16:08:15 +0200 (MET DST)
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


While playing with 2.4.20 on a dual-headed unified memory system, I fixed the
following:

  - Make PROC_CONSOLE() return -1 when the virtual console does not belong to
    the specified fbdev. This way we prevent messing with the wrong fb_info[i]
    later when running fbset from the `wrong' virtual console on multi-headed
    systems.
  - Validate the current cursor position before undrawing the cursor in
    fbcon_cursor(). If we just shrank the frame buffer size, the old cursor
    position may now lay outside the frame buffer region.

The second one made my kernel crash, by scribbling on kernel code that was
located right after the frame buffer. I guess no one saw this before, because
usually display->screen_base doesn't move when changing the resolution, and
most modern video cards have plenty of graphics memory.

Any comments?

--- linux-2.4.20/drivers/video/fbcon.c.orig	Wed Apr  2 13:26:09 2003
+++ linux-2.4.20/drivers/video/fbcon.c	Wed Apr  9 15:33:07 2003
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
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
