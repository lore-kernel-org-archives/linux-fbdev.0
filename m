From: John Zielinski <grim@undead.cc>
Subject: Re: FBTEST Patch
Date: Fri, 28 Nov 2003 17:44:29 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FC7CFCD.5010503@undead.cc>
References: <Pine.GSO.4.21.0311281020140.21469-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1APrLw-0001vS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Nov 2003 14:44:44 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1APrLv-0002Lu-JX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Nov 2003 14:44:43 -0800
In-Reply-To: <Pine.GSO.4.21.0311281020140.21469-100000@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

> You don't check for failure?
>
This was a quick "proof of concept" patch.  I should have mentioned that 
in my message.  I wanted to get some feedback before putting more effort 
into it.

>>+    if (old_mode == KD_TEXT );
>>+        ioctl(STDOUT_FILENO, KDSETMODE, KD_GRAPHICS);
>>    
>>
>
>Note that this doesn't work if you run fbtest from a remote shell or from a
>serial line, i.e. if you're not on the console.
>  
>
Good point.  Here's an updated version.  Opening /dev/console only works 
as root but then I couldn't get a regular user to run the program even 
though they were in the video group.  I tried opening /dev/fb0 write 
only but then the mmap call failed.  Can regular users run frame buffer 
programs?

Regardless, if the /dev/console open or the first ioctl fail then it 
assumes KD_GRAPHICS and does the usual fb_save/fb_restore stuff.  Not 
requiring the save/restore is an added bonus.  The reason I'm doing this 
patch is that the console keeps messing up the graphics trying to write 
text and flash the cursor.  

Also, if it doesn't do a restore I made it do a clear instead.   This is 
just in case the kernel fbcon restore bug patch I posted eariler isn't 
applied.   Here's a summary of what can happen:

1) Niether patch applied:
    * Console messes up the fbtest graphics.
    * Switching virtual consoles messes up the graphics.  (Looks really 
cool when it does the color pallette thing)  :)
    * If left on another virtual console, the wrong screen is restored.
    * After exit fbtest's debug/verbose output is mixed in with the 
saved console text.

2)  Fbtest patch only and using a fbdev driver that does vesa blanking:
    * Console output is disabled, graphics not corrupted.
    * Virtual console switching is prevented.
    * After exit previous console text and fbtest's debug/verbose output 
is hidden until the console is scrolled or swtiched back to.

3)  Both patches or using a fbdev driver that doesn't do vesa blanking:
    * Console output is disabled, graphics not corrupted.
    * Virtual console switching is prevented.
    * Console is restored properly upon exit.

diff -urNX dontdiff fbtest.old/fb.c fbtest/fb.c
--- fbtest.old/fb.c	2003-04-04 07:07:55.000000000 -0500
+++ fbtest/fb.c	2003-11-28 17:16:54.000000000 -0500
@@ -18,6 +18,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <linux/kd.h>
 
 #include <asm/page.h>
 
@@ -47,6 +48,8 @@
 static struct fb_cmap saved_cmap;
 static u16 *saved_red, *saved_green, *saved_blue, *saved_transp;
 static u8 *saved_fb;
+static long old_mode;
+static int console;
 
 
 static void fix_validate(void);
@@ -396,6 +399,15 @@
 void fb_init(void)
 {
     Debug("fb_init()\n");
+    console = open("/dev/console", O_RDWR | O_NOCTTY);
+    if (console != -1) {
+        if (ioctl(console, KDGETMODE, &old_mode) != -1) {
+    	    if (old_mode != KD_GRAPHICS)
+    		ioctl(console, KDSETMODE, KD_GRAPHICS);
+	}
+	else
+	    old_mode = KD_GRAPHICS;
+    }
     fb_open();
     fb_get_var();
     saved_var = fb_var;
@@ -435,7 +447,8 @@
 	    ALLOC_AND_SAVE_COMPONENT(transp);
     }
     fb_map();
-    fb_save();
+    if (old_mode == KD_GRAPHICS)
+        fb_save();
     fb_clear();
 }
 
@@ -457,6 +470,8 @@
     Debug("fb_cleanup()\n");
     if (saved_fb)
 	fb_restore();
+    else
+	fb_clear();
     if (fb)
 	fb_unmap();
     if (fb_fd != -1) {
@@ -477,6 +492,11 @@
 	/* FIXME: compare fb_fix with saved_fix */
 	fb_close();
     }
+    if (console != -1) {
+	if (old_mode != KD_GRAPHICS) 
+            ioctl(console, KDSETMODE, old_mode);
+	close(console);
+    }
 }
 
 #undef RESTORE_AND_FREE_COMPONENT


John





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
