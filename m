From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch] Correct monochrome selection (fwd)
Date: Wed, 23 Oct 2002 16:15:08 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210231614570.2882-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 184MI0-0004fp-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Oct 2002 07:15:16 -0700
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

---------- Forwarded message ----------
Date: Sat, 19 Oct 2002 19:05:34 +0200
From: Martin Schulze <joey@infodrom.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [patch] Correct monochrome selection

Hi Ralf,

please apply the patch below which will add proper handling for
monochrome graphic cards.

Both changes are required since there are graphic cards out in the
voi^Wwild that are monochrome but have bits_per_pixel set to something
else than 1, e.g. PMAG-AA which uses 8 bits per pixel but ignores 7 of
it.

Since currently no such card is supported, this change wasn't
required.  However, we developed support for the PMAG-AA card and we
would like to add support for it to the Linux kernel, of course.

Regards,

	Joey


Index: fbcon.c
===================================================================
RCS file: /home/cvs/linux/drivers/video/fbcon.c,v
retrieving revision 1.28.2.4
diff -u -r1.28.2.4 fbcon.c
--- fbcon.c	2 Oct 2002 13:28:31 -0000	1.28.2.4
+++ fbcon.c	19 Oct 2002 16:57:40 -0000
@@ -711,7 +711,8 @@
     if ((p->var.yres % fontheight(p)) &&
 	(p->var.yres_virtual % fontheight(p) < p->var.yres % fontheight(p)))
 	p->vrows--;
-    conp->vc_can_do_color = p->var.bits_per_pixel != 1;
+    conp->vc_can_do_color = (p->fb_info->fix.visual != FB_VISUAL_MONO10 &&
+			     p->fb_info->fix.visual != FB_VISUAL_MONO01);
     conp->vc_complement_mask = conp->vc_can_do_color ? 0x7700 : 0x0800;
     if (charcnt == 256) {
     	conp->vc_hi_font_mask = 0;
@@ -2177,7 +2178,12 @@
 					   p->fb_info);
 	}
 	
-    if (depth >= 8) {
+    if (p->visual == FB_VISUAL_MONO10 ||
+	p->visual == FB_VISUAL_MONO01) {
+	logo = linux_logo_bw;
+	logo_depth = 1;
+    }
+    else if (depth >= 8) {
 	logo = linux_logo;
 	logo_depth = 8;
     }

-- 
Every use of Linux is a proper use of Linux.  -- Jon "Maddog" Hall



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0002en
