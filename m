From: John Zielinski <grim@undead.cc>
Subject: FBTEST Patch
Date: Thu, 27 Nov 2003 21:47:45 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC6B751.8080801@undead.cc>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APYfq-0007NS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Nov 2003 18:48:02 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1APYfp-0000O9-ES
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 27 Nov 2003 18:48:01 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Here's the fbtest patch I was talking about:

diff -urNX dontdiff fbtest.old/fb.c fbtest/fb.c
--- fbtest.old/fb.c	2003-04-04 07:07:55.000000000 -0500
+++ fbtest/fb.c	2003-11-27 21:41:16.000000000 -0500
@@ -18,6 +18,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <linux/kd.h>
 
 #include <asm/page.h>
 
@@ -47,6 +48,7 @@
 static struct fb_cmap saved_cmap;
 static u16 *saved_red, *saved_green, *saved_blue, *saved_transp;
 static u8 *saved_fb;
+static long old_mode;
 
 
 static void fix_validate(void);
@@ -396,6 +398,9 @@
 void fb_init(void)
 {
     Debug("fb_init()\n");
+    ioctl(STDOUT_FILENO, KDGETMODE, &old_mode);
+    if (old_mode == KD_TEXT );
+        ioctl(STDOUT_FILENO, KDSETMODE, KD_GRAPHICS);
     fb_open();
     fb_get_var();
     saved_var = fb_var;
@@ -435,7 +440,8 @@
 	    ALLOC_AND_SAVE_COMPONENT(transp);
     }
     fb_map();
-    fb_save();
+    if (old_mode == KD_GRAPHICS)
+        fb_save();
     fb_clear();
 }
 
@@ -477,6 +483,7 @@
 	/* FIXME: compare fb_fix with saved_fix */
 	fb_close();
     }
+    ioctl(STDOUT_FILENO, KDSETMODE, old_mode);
 }
 
 #undef RESTORE_AND_FREE_COMPONENT


John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
