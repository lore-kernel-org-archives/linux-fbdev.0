From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Duplicate PROC_CONSOLE()
Date: Wed, 9 Apr 2003 16:03:45 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304091600580.21742-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193GBP-00070A-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 07:04:12 -0700
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0p/8.8.6) with ESMTP id QAA12614
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Apr 2003 16:03:29 +0200 (MET DST)
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


A clean up for 2.4.x:

  - Remove local copy of PROC_CONSOLE() in drivers/video/modedb.c. A global one
    is already provided by drivers/video/fbcon.c
  - Add missing multiple include protectors to <linux/console_struct.h>

OK to send this to Alan and Marcelo?

--- linux-2.4.x/drivers/video/modedb.c.orig	Sun Dec 23 11:25:09 2001
+++ linux-2.4.x/drivers/video/modedb.c	Wed Apr  9 13:47:05 2003
@@ -16,6 +16,7 @@
 #include <linux/fb.h>
 #include <linux/console_struct.h>
 #include <linux/sched.h>
+#include <video/fbcon.h>
 
 
 #undef DEBUG
@@ -255,28 +256,6 @@
 		return val;
 	}
     }
-}
-
-static int PROC_CONSOLE(const struct fb_info *info)
-{
-	int fgc;
-	
-	if (info->display_fg != NULL)
-		fgc = info->display_fg->vc_num;
-	else
-		return -1;
-		
-	if (!current->tty)
-		return fgc;
-
-	if (current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE)
-		/* XXX Should report error here? */
-		return fgc;
-
-	if (MINOR(current->tty->device) < 1)
-		return fgc;
-
-	return MINOR(current->tty->device) - 1;
 }
 
 
--- linux-2.4.x/include/linux/console_struct.h.orig	Thu Sep 20 10:51:46 2001
+++ linux-2.4.x/include/linux/console_struct.h	Wed Apr  9 13:54:58 2003
@@ -9,6 +9,9 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */
 
+#ifndef _LINUX_CONSOLE_STRUCT_H_
+#define _LINUX_CONSOLE_STRUCT_H_
+
 #define NPAR 16
 
 struct vc_data {
@@ -107,3 +110,5 @@
 #define CUR_DEFAULT CUR_UNDERLINE
 
 #define CON_IS_VISIBLE(conp) (*conp->vc_display_fg == conp)
+
+#endif /* _LINUX_CONSOLE_STRUCT_H_ */

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
