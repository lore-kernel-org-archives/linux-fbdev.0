From: John Zielinski <grim@undead.cc>
Subject: Console takeover screen corruption issue
Date: Thu, 06 May 2004 22:56:47 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <409AFAEF.9060907@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020404080708060005050306"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLvXk-00041u-Gv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:56:56 -0700
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BLvXk-0002wJ-7h
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 19:56:56 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020404080708060005050306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've been playing around with trying to find a better solution to the 
screen corruption that I was getting when the fbcon driver takes over 
the console.  I came up with the following modifications which are a 
better solution for the following reasons: 

1)  Only the vt take_over_console code needs to be changed and not all 
the console drivers and fb drivers.
2)  It also keeps the console drivers from accessing freed resources 
when printk output happens between the calls to con_deinit and visual_init.

It's the printk's between the call to save_screen and visual_init which 
cause vgacon to mess up it's saved screen buffer.  Putting the vt in 
KD_GRAPHICS mode causes all physical output to be deferred until the new 
console has taken over.

Comments?

John


--------------020404080708060005050306
Content-Type: text/plain;
 name="take_over_console_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="take_over_console_fix"

diff +requires kdsetmode_kdgetmode
diff -urNX dontdiff linux-2.6.5/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-2.6.5/drivers/char/vt.c	2004-04-03 22:38:04.000000000 -0500
+++ linux/drivers/char/vt.c	2004-05-02 20:48:06.000000000 -0400
@@ -2657,11 +2657,23 @@
 {
 	int i, j = -1;
 	const char *desc;
+	unsigned char saved_kdmode[MAX_NR_CONSOLES]; 
 
 	acquire_console_sem();
 
+	for (i = first; i <= last; i++) {
+    		if (vc_cons[i].d && vc_cons[i].d->vc_sw && CON_IS_VISIBLE(vc_cons[i].d)) {
+			saved_kdmode[i] = vt_kdgetmode(i);
+			vt_kdsetmode(i, KD_GRAPHICS);
+		}
+	}
+
 	desc = csw->con_startup();
 	if (!desc) {
+		for (i = first; i <= last; i++) {
+    			if (vc_cons[i].d && vc_cons[i].d->vc_sw && CON_IS_VISIBLE(vc_cons[i].d))
+				vt_kdsetmode(i, saved_kdmode[i]);
+		}
 		release_console_sem();
 		return;
 	}
@@ -2670,7 +2682,6 @@
 
 	for (i = first; i <= last; i++) {
 		int old_was_color;
-		int currcons = i;
 
 		con_driver_map[i] = csw;
 
@@ -2678,8 +2689,6 @@
 			continue;
 
 		j = i;
-		if (IS_VISIBLE)
-			save_screen(i);
 		old_was_color = vc_cons[i].d->vc_can_do_color;
 		vc_cons[i].d->vc_sw->con_deinit(vc_cons[i].d);
 		visual_init(i, 0);
@@ -2692,8 +2701,8 @@
 		if (old_was_color != vc_cons[i].d->vc_can_do_color)
 			clear_buffer_attributes(i);
 
-		if (IS_VISIBLE)
-			update_screen(i);
+		if (CON_IS_VISIBLE(vc_cons[i].d)) 
+			vt_kdsetmode(i, saved_kdmode[i]);
 	}
 	printk("Console: switching ");
 	if (!deflt)

--------------020404080708060005050306
Content-Type: text/plain;
 name="kdsetmode_kdgetmode"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdsetmode_kdgetmode"

diff -urNX dontdiff linux-2.6.5/drivers/char/vt_ioctl.c linux/drivers/char/vt_ioctl.c
--- linux-2.6.5/drivers/char/vt_ioctl.c	2004-04-03 22:37:37.000000000 -0500
+++ linux/drivers/char/vt_ioctl.c	2004-05-02 20:45:16.000000000 -0400
@@ -357,6 +357,27 @@
 	return 0;
 }
 
+void vt_kdsetmode(unsigned int console, unsigned char mode)
+{
+	if (vt_cons[console]->vc_mode == (unsigned char) mode)
+		return;
+	vt_cons[console]->vc_mode = (unsigned char) mode;
+	if (console != fg_console)
+		return;
+	/*
+	 * explicitly blank/unblank the screen if switching modes
+	 */
+	if (mode == KD_TEXT)
+		do_unblank_screen(1);
+	else
+		do_blank_screen(1);
+}
+
+unsigned char vt_kdgetmode(unsigned int console)
+{
+    return vt_cons[console]->vc_mode;    
+}
+
 /*
  * We handle the console-specific ioctl's here.  We allow the
  * capability to modify any console, not just the fg_console. 
@@ -487,24 +508,13 @@
 		default:
 			return -EINVAL;
 		}
-		if (vt_cons[console]->vc_mode == (unsigned char) arg)
-			return 0;
-		vt_cons[console]->vc_mode = (unsigned char) arg;
-		if (console != fg_console)
-			return 0;
-		/*
-		 * explicitly blank/unblank the screen if switching modes
-		 */
 		acquire_console_sem();
-		if (arg == KD_TEXT)
-			do_unblank_screen(1);
-		else
-			do_blank_screen(1);
+		vt_kdsetmode(console, (unsigned char)arg);
 		release_console_sem();
 		return 0;
 
 	case KDGETMODE:
-		ucval = vt_cons[console]->vc_mode;
+		ucval = vt_kdgetmode(console);
 		goto setint;
 
 	case KDMAPDISP:
diff -urNX dontdiff linux-2.6.5/include/linux/vt_kern.h linux/include/linux/vt_kern.h
--- linux-2.6.5/include/linux/vt_kern.h	2004-04-03 22:38:12.000000000 -0500
+++ linux/include/linux/vt_kern.h	2004-05-02 20:42:42.000000000 -0400
@@ -83,5 +83,7 @@
 int vt_waitactive(int vt);
 void change_console(unsigned int);
 void reset_vc(unsigned int new_console);
+void vt_kdsetmode(unsigned int console, unsigned char mode);
+unsigned char vt_kdgetmode(unsigned int console);
 
 #endif /* _VT_KERN_H */

--------------020404080708060005050306--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
