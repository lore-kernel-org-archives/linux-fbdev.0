From: Fredrik Noring <noring@nocrew.org>
Subject: [PATCH] Fix for wasted memory in rivafb?
Date: 27 Jan 2003 00:20:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1043623243.1307.16.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from maile.telia.com ([194.22.190.16])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cw4F-00081n-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 26 Jan 2003 15:19:59 -0800
Received: from h9n1fls20o980.telia.com (h9n1fls20o980.telia.com [213.65.208.9])
	by maile.telia.com (8.12.5/8.12.5) with ESMTP id h0QNJPVj025582
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 27 Jan 2003 00:19:26 +0100 (CET)
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
To: linux-fbdev-devel@lists.sourceforge.net

This patch fixes a problem with wasted memory in the rivafb driver.
For some reason, only half the memory is currently allowed when 
maximizing the virtual screen. The 2.5.x tree has the same problem.

Is this a reserve for something? I have not found any use for it 
inside the driver.

My app needs all the precious video memory it can get. :)

	Fredrik

--- linux-2.4.21-pre2/drivers/video/riva/fbdev.c.orig	2003-01-27 00:06:19.000000000 +0100
+++ linux-2.4.21-pre2/drivers/video/riva/fbdev.c	2003-01-26 21:28:04.000000000 +0100
@@ -1063,7 +1063,7 @@
 		       "using maximum available virtual resolution\n");
 		for (i = 0; modes[i].xres != -1; i++) {
 			if (modes[i].xres * nom / den * modes[i].yres <
-			    rinfo->ram_amount / 2)
+			    rinfo->ram_amount)
 				break;
 		}
 		if (modes[i].xres == -1) {
@@ -1080,13 +1080,13 @@
 		       v->xres_virtual, v->yres_virtual);
 	} else if (v->xres_virtual == -1) {
 		v->xres_virtual = (rinfo->ram_amount * den /
-			(nom * v->yres_virtual * 2)) & ~15;
+			(nom * v->yres_virtual)) & ~15;
 		printk(KERN_WARNING PFX
 		       "setting virtual X resolution to %d\n", v->xres_virtual);
 	} else if (v->yres_virtual == -1) {
 		v->xres_virtual = (v->xres_virtual + 15) & ~15;
 		v->yres_virtual = rinfo->ram_amount * den /
-			(nom * v->xres_virtual * 2);
+			(nom * v->xres_virtual);
 		printk(KERN_WARNING PFX
 		       "setting virtual Y resolution to %d\n", v->yres_virtual);
 	} else {



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
